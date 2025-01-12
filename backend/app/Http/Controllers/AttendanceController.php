<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use App\Models\User;
use App\Models\Conference;
use App\Models\ConferenceUser;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

use App\Events\NotificationSent;
use App\Models\Notification;
use App\Models\Speaker;

use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class AttendanceController extends Controller
{
    public function storeAttendance(Request $request)
    {
        // Assuming user_id and conference_id are dynamically set or passed, not hardcoded
        $user_id = $request->input('user_id');
        $conference_id = $request->input('conference_id');

        try {
            // Validate the incoming request data
            $validatedData = $request->validate([
                'is_online_approved' => 'nullable|boolean',
                'ticket_status' => 'nullable|string',
                'dinner_invitation' => 'nullable|boolean',
                'airport_pickup' => 'nullable|boolean',
                'free_trip' => 'nullable|boolean',
                'is_certificate_active' => 'nullable|boolean',
                'room_type' => 'nullable|string|in:single,double,triple',
                'nights_covered' => 'nullable|integer|min:0',
                'is_visa_payment_required' => 'nullable|boolean', // The new field
                // Include any other fields that need to be validated
            ]);

            // Check if the Attendance already exists for this user and conference
            $existingAttendance = Attendance::where('user_id', $user_id)
                ->where('conference_id', $conference_id)
                ->first();

            if ($existingAttendance) {
                return response()->json([
                    'error' => 'Attendance already exists for this user and conference.'
                ], 409); // Use 409 for conflict
            }

            // Check if conference_user record exists and update only is_visa_payment_required
            $conferenceUser = ConferenceUser::where('user_id', $user_id)
                ->where('conference_id', $conference_id)
                ->first();

            if ($conferenceUser) {
                // Update only the is_visa_payment_required field
                $conferenceUser->is_visa_payment_required = $request->input('is_visa_payment_required', false);
                $conferenceUser->save();
            } else {
                return response()->json([
                    'error' => 'ConferenceUser record not found for this user and conference.'
                ], 404);
            }

            // Create a new Attendance entry with the required default values
            $attendance = Attendance::create(array_merge($validatedData, [
                'user_id' => $user_id,
                'conference_id' => $conference_id,
                'registration_fee' => $request->registration_fee,
                'includes_conference_bag' => $request->includes_conference_bag ?? 0,
                'includes_conference_badge' => $request->includes_conference_badge ?? 0,
                'includes_conference_book' => $request->includes_conference_book ?? 0,
                'includes_certificate' => $request->includes_certificate ?? 0,
                'includes_lecture_attendance' => $request->includes_lecture_attendance ?? 0,
            ]));

            // Update user status to "approved"
            $user = User::findOrFail($user_id);
            $user->status = 'approved';
            $user->save();

            // إرسال إشعار إلى السبيكر باستخدام نموذج Notification
            $userNotification = Notification::create([
                'user_id' => $user_id,
                'message' => 'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',
                'conference_id' => $conference_id,
                'is_read' => false, // يمكنك تعيين القيمة حسب الحاجة
            ]);

            // Broadcast the notification
            broadcast(new NotificationSent($userNotification));

            // Return a success response
            return response()->json([
                'message' => 'Attendance created successfully, and user status updated to approved.',
                'attendance' => $attendance, // Fixed the typo: Attendance -> attendance
                'conference_user' => $conferenceUser,
            ], 201); // Use 201 for created resource

        } catch (\Illuminate\Validation\ValidationException $e) {
            // Handle validation errors
            return response()->json([
                'error' => 'Validation error',
                'details' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            // Handle general errors
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage()
            ], 500);
        }
    }




    public function getAttendanceInfoByToken()
    {
        try {
            // Extract user_id from the token
            $user_id = Auth::id(); // Get user_id from the token

            // Find the attendance record for the current user
            $attendance = Attendance::where('user_id', $user_id)
                ->join('users', 'users.id', '=', 'attendance.user_id') // Join with users table
                ->join('conferences', 'conferences.id', '=', 'attendance.conference_id') // Join with conferences table
                ->select('attendance.*', 'users.name as user_name', 'users.email as user_email', 'conferences.title as conference_title') // Select required columns
                ->firstOrFail();

            // Return attendance data along with user and conference details
            return response()->json([
                'message' => 'Attendance found successfully',
                'attendance' => $attendance
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            // If attendance not found
            return response()->json([
                'error' => 'Attendance not found'
            ], 404);

        } catch (\Exception $e) {
            // Handle any unexpected errors
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage()
            ], 500);
        }
    }
    public function getAttendance(Request $request)
    {
        // Get the 'page' query parameter, default to 1 if not provided
        $page = $request->query('page', 1);

        // Define the number of attendance records per page
        $attendancePerPage = 3;

        // Calculate the offset for the current page
        $offset = ($page - 1) * $attendancePerPage;

        // Fetch attendance from the database and include user and conference data (using Eloquent's 'with' method to eager load the 'user' and 'conference' relationships)
        $totalAttendance = Attendance::count(); // Total number of attendance records
        $attendance = Attendance::with(['user', 'conference']) // Eager load user and conference data for each attendance record
            ->skip($offset)
            ->take($attendancePerPage)
            ->get(); // Fetch paginated attendance records

        // Calculate the total number of pages
        $totalPages = ceil($totalAttendance / $attendancePerPage);

        // Prepare the response data
        $response = [
            'message' => 'Attendance records fetched successfully.',
            'attendance' => $attendance,
            'currentPage' => $page,
            'totalPages' => $totalPages
        ];

        // Return the JSON response
        return response()->json($response);
    }

}
