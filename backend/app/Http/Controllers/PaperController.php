<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\ConferenceUser;
use App\Models\Notification;
use App\Models\Paper;
use App\Models\Speaker;
use App\Models\User;
use Illuminate\Http\Request;
use App\Notifications\EmailNotification;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class PaperController extends Controller
{
    public function store(Request $request)
    {
        try {
            // 1. التحقق من صحة البيانات
            $validatedData = $request->validate([
                'conference_id' => 'required|exists:conferences,id',
                'title' => 'required|string|max:255',
                'file_path' => 'required|file|mimes:pdf,doc,docx|max:10240', // 10MB كحد أقصى للملف
                'abstract' => 'required|string|max:255',
                'status' => 'nullable|in:under review,accepted,rejected',
                'submitted_at' => 'nullable|date', // يمكن جعله اختياري
                'name' => 'required|string|max:255',
                'email' => 'required|email|unique:users,email',
                'password' => 'required|string|min:8',
                'phone_number' => 'required|string|max:20',
                'whatsapp_number' => 'nullable|string|max:20',
                'nationality' => 'nullable|string|max:100',
                'country_of_residence' => 'nullable|string|max:100',
                'is_visa_payment_required' => 'nullable|boolean', // مطلوب لإضافة إلى الجدول الجديد
            ]);
    
            // التحقق من حالة `status`
            $status = $validatedData['status'] ?? null;
    
            // 2. تخزين البيانات في جدول `users`
            $user = User::create([
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'password' => Hash::make($validatedData['password']),
                'registration_type' => 'speaker',
                'phone_number' => $validatedData['phone_number'],
                'whatsapp_number' => $validatedData['whatsapp_number'],
                'nationality' => $validatedData['nationality'],
                'country_of_residence' => $validatedData['country_of_residence'],
                'conference_id' => $validatedData['conference_id'],

                'isAdmin' => false,
            ]);
    
            // 3. تخزين البيانات في جدول `papers`
            $paper = Paper::create([
                'conference_id' => $validatedData['conference_id'],
                'user_id' => $user->id,
                'title' => $validatedData['title'],
                'abstract' => $validatedData['abstract'],
                'file_path' => $validatedData['file_path'],
                'status' => $status ?? "under review",
                'submitted_at' => now(), // استخدام الوقت الحالي
            ]);
    
            // 4. تخزين البيانات في جدول `conference_user`
            ConferenceUser::create([
                'user_id' => $user->id,
                'conference_id' => $validatedData['conference_id'],
                'is_visa_payment_required' => $validatedData['is_visa_payment_required'] ?? false,
            ]);
    
            // 5. إرسال إشعار للمسؤولين
            $admins = User::where('isAdmin', true)->get();
            foreach ($admins as $admin) {
                $notification = Notification::create([
                    'user_id' => $admin->id,
                    'conference_id' => $validatedData['conference_id'],
                    'message' => 'A new Abstract has been added by ' . $user->name . ' for conference ID: ' . $validatedData['conference_id'] . '. Would you like to update the status?',
                    'is_read' => false,
                    'register_id' => $user->id,
                ]);
                broadcast(new NotificationSent($notification))->toOthers();
            }
    
            // 6. إرسال إشعار للمستخدم
            $userNotification = Notification::create([
                'user_id' => $user->id,
                'message' => "Your abstract is currently under review by the congress scientific committee. You can log in to your profile at any time to check its status.",
                'is_read' => false,
                'register_id' => null,
            ]);
            broadcast(new NotificationSent($userNotification));
    
            // 7. إرسال إشعار عبر البريد الإلكتروني
            $user->notify(new EmailNotification("Your abstract is currently under review by the congress scientific committee. You can log in to your profile at any time to check its status."));
    
            // 8. إرجاع استجابة ناجحة
            return response()->json([
                'message' => 'Paper, user, and conference_user created successfully, and notifications sent.',
                'paper' => $paper,
                'user' => $user,
            ], 201);
        } catch (\Exception $e) {
            // 9. معالجة الأخطاء
            return response()->json([
                'message' => 'There was an error processing your request.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
    
    


    public function updateByAdmin(Request $request, $user_id, $conference_id)
{
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
            'is_visa_payment_required' => 'nullable|boolean', // الحقل الجديد
            'paper_status' => 'required|string|in:accepted,rejected', // حقل حالة الورقة
        ]);

        // Check if the speaker already exists for this user and conference
        $existingSpeaker = Speaker::where('user_id', $user_id)
            ->where('conference_id', $conference_id)
            ->first();

        if ($existingSpeaker) {
            return response()->json([
                'error' => 'Speaker already exists for this user and conference.'
            ], 409); // Use 409 for conflict
        }
        // dd('user_id: ' . $user_id . ', conference_id: ' . $conference_id);

        // }
// Check if conference_user record exists and update it
$conferenceUser = ConferenceUser::where('user_id', $user_id)
    ->where('conference_id', $conference_id) // Use $conference_id from parameters
    ->first();

if ($conferenceUser) {
    // Update conference_user with the new visa payment requirement and other fields
    $conferenceUser->is_visa_payment_required = $request->input('is_visa_payment_required', false);
    $conferenceUser->save();
} else {
    return response()->json([
        'error' => 'ConferenceUser record not found for this user and conference.'
    ], 404);
}

        // Step 1: Update the papers table with the new status for this user and conference
        $paper = Paper::where('user_id', $user_id)
            ->where('conference_id', $conference_id)
            ->first();

        if ($paper) {
            // Update paper status based on the provided paper_status (approved or rejected)
            $paper->status = $request->input('paper_status');
            $paper->save();
        } else {
            return response()->json([
                'error' => 'Paper record not found for this user and conference.'
            ], 404);
        }

        // Step 2: Create a new speaker entry
        $speaker = Speaker::create(array_merge($validatedData, [
            'user_id' => $user_id,
            'conference_id' => $conference_id,
        ]));

        // Step 3: Update user status to "approved"
        $user = User::findOrFail($user_id);
        $user->status = 'approved';
        $user->save();

        // Step 4: إرسال إشعار إلى السبيكر باستخدام نموذج Notification
        $paperStatusMessage = $request->input('paper_status') == 'accepted' 
            ? 'Your paper has been accepted for the conference.' 
            : 'Unfortunately, your paper has been rejected for the conference.';
        
        $userNotification = Notification::create([
            'user_id' => $user_id,
            'message' => 'We are pleased to inform you that your profile is now active. ' . $paperStatusMessage . ' You can log in to the website and complete your profile.',
            'conference_id' => $conference_id,
            'is_read' => false, // يمكنك تعيين القيمة حسب الحاجة
        ]);

        // Step 5: Broadcast the notification
        broadcast(new NotificationSent($userNotification));

        // Return a success response
        return response()->json([
            'message' => 'Speaker created successfully, paper status updated, and user status updated to approved.',
            'speaker' => $speaker,
            // 'conference_user' => $conferenceUser,
            'paper' => $paper,
        ], 201); // Use 201 for created resource

     } catch (\Exception $e) {
        // Handle general errors
        return response()->json([
            'error' => 'An unexpected error occurred. Please try again.',
            'details' => $e->getMessage()
        ], 500);
    }
}





    // public function getPapersByConferenceId($conference_id)
    // {
    //     try {
    //         // الحصول على الأوراق حسب معرف المؤتمر
    //         $papers = Paper::where('conference_id', $conference_id)->get();

    //         if ($papers->isEmpty()) {
    //             return response()->json([
    //                 'message' => 'No papers found for this conference.'
    //             ], 404);
    //         }

    //         return response()->json([
    //             'message' => 'Papers retrieved successfully!',
    //             'data' => $papers
    //         ], 200);
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'message' => 'Error retrieving papers',
    //             'error' => $e->getMessage()
    //         ], 500);
    //     }
    // }


    // public function getPaperById($paper_id)
    // {
    //     try {
    //         // البحث عن الورقة العلمية حسب معرفها
    //         $paper = Paper::find($paper_id);

    //         if (!$paper) {
    //             return response()->json([
    //                 'message' => 'Paper not found.'
    //             ], 404);
    //         }

    //         return response()->json([
    //             'message' => 'Paper retrieved successfully!',
    //             'data' => $paper
    //         ], 200);
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'message' => 'Error retrieving paper',
    //             'error' => $e->getMessage()
    //         ], 500);
    //     }
    // }
}
