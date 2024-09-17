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
    public function store(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'conference_id' => 'required|exists:conferences,id',
                'abstract' => 'nullable|file|mimes:pdf',
                'topics' => 'nullable|string',
                'presentation_file' => 'nullable|file|mimes:ppt,pptx',
            ]);
    
            $conference = Conference::find($validatedData['conference_id']);
            
            $speaker = Speaker::create([
                'user_id' => Auth::id(),
                'conference_id' => $validatedData['conference_id'],
                'abstract' => $request->file('abstract') ? $request->file('abstract')->store('abstracts') : null,
                'topics' => $validatedData['topics'],
                'presentation_file' => $request->file('presentation_file') ? $request->file('presentation_file')->store('presentations') : null,
            ]);
    
            return response()->json(['message' => 'Speaker profile created successfully', 'speaker' => $speaker], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An unexpected error occurred. Please try again.'], 500);
        }
    }



    // هنا يعدل على user_id ,عملتله check admin خارجي

    public function updateByAdmin(Request $request, $user_id)
    {
        try {
            $validatedData = $request->validate([
                'is_online_approved' => 'nullable|boolean',
                'ticket_status' => 'nullable',
                'dinner_invitation' => 'nullable|boolean',
                'airport_pickup' => 'nullable|boolean',
                'free_trip' => 'nullable|boolean',
                'is_certificate_active' => 'nullable|boolean',
            ]);
    
            // البحث عن المتحدث بناءً على user_id
            $speaker = Speaker::where('user_id', $user_id)->firstOrFail();
    
            $speaker->update($validatedData);
    
            return response()->json(['message' => 'Speaker details updated successfully by admin', 'speaker' => $speaker], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => 'Validation error', 'details' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An unexpected error occurred. Please try again.', 'details' => $e->getMessage()], 500);
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


    



    
    
    
    
    
    

