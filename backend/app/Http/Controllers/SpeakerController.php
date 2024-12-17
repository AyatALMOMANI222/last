<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Conference;
use App\Models\ConferenceUser;
use App\Models\Notification;
use Illuminate\Http\Request;
use App\Models\Speaker;
use App\Models\User;
use App\Notifications\NewSpeakerNotification;
use Illuminate\Support\Facades\Auth;

class SpeakerController extends Controller
{

    public function store(Request $request, $user_id, $conference_id)
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

            // Create a new speaker entry
            $speaker = Speaker::create(array_merge($validatedData, [
                'user_id' => $user_id,
                'conference_id' => $conference_id,
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
                'message' => 'Speaker created successfully, and user status updated to approved.',
                'speaker' => $speaker,
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



    // هنا يعدل على user_id ,عملتله check admin خارجي
    public function updateByUser(Request $request)
    {
        try {
            // Validate the incoming request data
            $validatedData = $request->validate([
                'abstract' => 'nullable|file|mimes:txt,pdf,doc,docx', // قبول abstract كملف
                'topics' => 'nullable|string', // التحقق من topics كقيمة نصية
                'presentation_file' => 'nullable|file|mimes:ppt,pptx', // التحقق من presentation_file كملف
                'online_participation' => 'nullable|boolean', // إضافة خيار الحضور عبر الإنترنت
                'departure_date' => 'nullable|date', // التحقق من departure_date كـ تاريخ
                'arrival_date' => 'nullable|date', // التحقق من arrival_date كـ تاريخ
                'video' => 'nullable|file|mimes:mp4|max:200000', // التحقق من أن الفيديو هو MP4
            ]);
    
            // Get the authenticated user's ID
            $user_id = Auth::id();
    
            // Find the speaker associated with the authenticated user
            $speaker = Speaker::where('user_id', $user_id)->firstOrFail();
    
            // Check if a presentation file is provided
            if ($request->hasFile('presentation_file')) {
                // Store the presentation file and get the path
                $presentationFilePath = $request->file('presentation_file')->store('presentations', 'public');
                // Update the speaker's presentation file path
                $speaker->presentation_file = $presentationFilePath;
            }
    
            // Check if an abstract file is provided
            if ($request->hasFile('abstract')) {
                // Store the abstract file and get the path
                $abstractFilePath = $request->file('abstract')->store('abstracts', 'public');
                // Update the speaker's abstract file path
                $speaker->abstract = $abstractFilePath;
            }
    
            // Check if a video file is provided
            if ($request->hasFile('video')) {
                // Store the video file and get the path
                $videoFilePath = $request->file('video')->store('videos', 'public');
                
                // Update the speaker's video file path
                $speaker->video = $videoFilePath;
            }
    
            // Update the speaker's other details using validated data
            $speaker->topics = $validatedData['topics'] ?? $speaker->topics; // تحديث المواضيع إذا كانت موجودة
            $speaker->online_participation = $validatedData['online_participation'] ?? $speaker->online_participation; // تحديث خيار الحضور عبر الإنترنت إذا كان موجودًا
            $speaker->departure_date = $validatedData['departure_date'] ?? $speaker->departure_date; // تحديث departure_date إذا كانت موجودة
            $speaker->arrival_date = $validatedData['arrival_date'] ?? $speaker->arrival_date; // تحديث arrival_date إذا كانت موجودة
    
            $speaker->save(); // احفظ التغييرات في قاعدة البيانات
    
            // Return a success response
            return response()->json([
                'message' => 'Speaker details updated successfully',
                'speaker' => $speaker
            ], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            // Handle validation errors
            return response()->json([
                'error' => 'Validation error',
                'details' => $e->errors()
            ], 422);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            // Handle case where the speaker is not found
            return response()->json([
                'error' => 'Speaker not found for the authenticated user',
            ], 404);
        } catch (\Exception $e) {
            // Handle general errors
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage()
            ], 500);
        }
    }
    
    

    public function getSpeakerByConferenceId($conference_id)
    {
        try {
            // الحصول على الـ user_id من التوكن
            $user_id = Auth::id(); // أو إذا كنت تستخدم JWT، يمكنك استخدام JWT facade أو middleware

            // التحقق إذا كان المستخدم مسجل الدخول
            if (!$user_id) {
                return response()->json([
                    'error' => 'User not authenticated.'
                ], 401); // Unauthorized
            }

            // Find the speaker based on user_id and conference_id
            $speaker = Speaker::where('user_id', $user_id)
                ->where('conference_id', $conference_id)
                ->first();

            // Check if the speaker exists
            if (!$speaker) {
                return response()->json([
                    'error' => 'Speaker not found for this user and conference.'
                ], 404); // Resource not found
            }

            // Return the speaker details
            return response()->json([
                'message' => 'Speaker found successfully.',
                'speaker' => $speaker,
            ], 200); // Success response

        } catch (\Exception $e) {
            // Handle unexpected errors
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage(),
            ], 500); // Internal server error
        }
    }


    // هنا ياخذ user_id من التوكن يعدل لنفسه 
    public function updateOnlineParticipation(Request $request)
    {
        try {
            // التحقق من صحة البيانات
            $validatedData = $request->validate([
                'online_participation' => 'required|boolean',
            ]);

            // استخراج user_id من التوكن
            $userId = Auth::id(); // الحصول على user_id من التوكن

            // العثور على المتحدث بناءً على user_id
            $speaker = Speaker::where('user_id', $userId)->firstOrFail();

            // الحصول على المؤتمر المرتبط بالمتحدث
            $conference = Conference::find($speaker->conference_id);

            // التحقق من صحة المؤتمر
            // if (!$conference) {
            //     return response()->json(['error' => 'Conference not found'], 404);
            // }

            // تحقق من أن المشاركة عبر الإنترنت مسموح بها بناءً على حالة الموافقة على المشاركة عبر الإنترنت
            if ($speaker->is_online_approved) {
                // تحديث حالة المشاركة عبر الإنترنت
                $speaker->update([
                    'online_participation' => $validatedData['online_participation'],
                ]);

                // إرسال الإشعار عند النجاح
                $notificationMessage = 'سيتم تزويدك برابط الزوم الخاص بالمؤتمر قبل موعد المؤتمر أو محاضرتك بيوم واحد للمشاركة';

                // إدخال الإشعار في قاعدة البيانات
                $userNotification = Notification::create([
                    'user_id' => $userId, // إرسال الإشعار إلى المستخدم نفسه
                    'message' => $notificationMessage,
                    'is_read' => false, // الإشعار جديد لم يُقرأ بعد
                ]);
                broadcast(new NotificationSent($userNotification));
                return response()->json(['message' => 'Online participation updated successfully', 'notification' => $notificationMessage, 'speaker' => $speaker], 200);
            } else {
                return response()->json(['error' => 'Online participation is not approved for this speaker'], 400);
            }
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->errors()], 422);
        } catch (\Exception $e) {
            // طباعة تفاصيل الخطأ
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage()
            ], 500);
        }
    }





    public function updateCertificateFile(Request $request, $user_id)
    {
        try {
            // البحث عن المتحدث بناءً على user_id
            $speaker = Speaker::where('user_id', $user_id)->firstOrFail();

            // التحقق من صحة البيانات
            $validatedData = $request->validate([
                'certificate_file' => 'required|file|mimes:pdf',
            ]);

            // تحديث ملف الشهادة
            $speaker->certificate_file = $request->file('certificate_file')->store('certificates', 'public');
            $speaker->save();

            return response()->json(['message' => 'Certificate file updated successfully', 'speaker' => $speaker], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An unexpected error occurred. Please try again.'], 500);
        }
    }
    public function getSpeakerInfoByToken()
    {
        try {
            // استخراج user_id من التوكن
            $user_id = Auth::id(); // يحصل على user_id من التوكن

            // العثور على المتحدث مع معلومات المستخدم بناءً على user_id
            $speaker = Speaker::where('user_id', $user_id)
                ->join('users', 'users.id', '=', 'speakers.user_id') // إجراء join مع جدول users
                ->select('speakers.*', 'users.*'
                
           
                ) // تحديد الأعمدة المراد جلبها
                ->firstOrFail();

            // إعادة بيانات المتحدث مع بيانات المستخدم
            return response()->json([
                'message' => 'Speaker found successfully',
                'speaker' => $speaker
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            // إذا لم يتم العثور على المتحدث
            return response()->json([
                'error' => 'Speaker not found'
            ], 404);

        } catch (\Exception $e) {
            // التعامل مع أي أخطاء غير متوقعة
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage()
            ], 500);
        }
    }


 
    



    public function getSpeakersByConference($conferenceId)
    {
        // استدعاء دالة الحصول على المتحدثين مع معلومات اليوزر من خلال join
        $speakers = Speaker::join('users', 'speakers.user_id', '=', 'users.id')  // عمل join مع جدول ال users
            ->where('speakers.conference_id', $conferenceId) // تحديد المؤتمر باستخدام conference_id
            ->select('speakers.*', 'users.name', 'users.email', 'users.image')  // اختيار الأعمدة المطلوبة
            ->get(); // جلب النتائج

        // إرجاع البيانات على هيئة JSON
        return response()->json($speakers);
    }




}
