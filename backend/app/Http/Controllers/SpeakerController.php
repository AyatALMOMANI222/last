<?php

namespace App\Http\Controllers;

use App\Models\Conference;
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
    
            // Create a new speaker entry
            $speaker = Speaker::create(array_merge($validatedData, [
                'user_id' => $user_id,
                'conference_id' => $conference_id,
            ]));
    
            // إرسال إشعار إلى السبيكر باستخدام نموذج Notification
            Notification::create([
                'user_id' => $user_id,
                'message' => 'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',
                'conference_id' => $conference_id,
                'is_read' => false, // يمكنك تعيين القيمة حسب الحاجة
            ]);
    
            // Return a success response
            return response()->json([
                'message' => 'Speaker created successfully',
                'speaker' => $speaker
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
                'abstract' => 'nullable|string', // Validate the abstract
                'topics' => 'nullable|string', // Validate the topics
                'presentation_file' => 'nullable|file|mimes:ppt,pptx', // Validate the presentation file
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

            // Update the speaker's other details
            $speaker->update($validatedData);

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
            if (!$conference) {
                return response()->json(['error' => 'Conference not found'], 404);
            }

            // تحقق من أن المشاركة عبر الإنترنت مسموح بها بناءً على حالة الموافقة على المشاركة عبر الإنترنت
            if ($speaker->is_online_approved) {
                // تحديث حالة المشاركة عبر الإنترنت
                $speaker->update([
                    'online_participation' => $validatedData['online_participation'],
                ]);

                // إرسال الإشعار عند النجاح
                $notificationMessage = 'سيتم تزويدك برابط الزوم الخاص بالمؤتمر قبل موعد المؤتمر أو محاضرتك بيوم واحد للمشاركة';

                // إدخال الإشعار في قاعدة البيانات
                Notification::create([
                    'user_id' => $userId, // إرسال الإشعار إلى المستخدم نفسه
                    'message' => $notificationMessage,
                    'is_read' => false, // الإشعار جديد لم يُقرأ بعد
                ]);

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
}
