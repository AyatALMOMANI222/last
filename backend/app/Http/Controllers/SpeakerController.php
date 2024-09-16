<?php
namespace App\Http\Controllers;

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
            // التحقق من تسجيل الدخول
            $userId = Auth::id();
    
            if (!$userId) {
                return response()->json([
                    'message' => 'لم يتم تسجيل الدخول.',
                ], 401);
            }
    
            // التحقق من صحة البيانات المدخلة
            $validated = $request->validate([
                'conference_id' => 'required|exists:conferences,id',
                'abstract' => 'nullable|string|max:255',
                'topics' => 'nullable|string',
                'presentation_file' => 'nullable|file|mimes:pdf,ppt,pptx|max:2048',
                'online_participation' => 'nullable|boolean',
                'is_online_approved' => 'nullable|boolean',
                'accommodation_status' => 'nullable|boolean',
                'ticket_status' => 'nullable|boolean',
                'dinner_invitation' => 'nullable|boolean',
                'airport_pickup' => 'nullable|boolean',
                'free_trip' => 'nullable|boolean',
                'certificate_file' => 'nullable|file|mimes:pdf|max:2048',
                'is_certificate_active' => 'nullable|boolean',
            ]);
    
            // التحقق من وجود تسجيل سابق لنفس المستخدم في نفس المؤتمر
            $existingSpeaker = Speaker::where('user_id', $userId)
                                      ->where('conference_id', $validated['conference_id'])
                                      ->first();
    
            if ($existingSpeaker) {
                return response()->json([
                    'message' => 'لقد قمت بالتسجيل في هذا المؤتمر مسبقًا.',
                ], 409); // Conflict
            }
    
            // تعيين user_id للمتحدث
            $validated['user_id'] = $userId;
    
            // تخزين الملفات إذا كانت موجودة
            if ($request->hasFile('presentation_file')) {
                $validated['presentation_file'] = $request->file('presentation_file')->store('presentations', 'public');
            }
    
            if ($request->hasFile('certificate_file')) {
                $validated['certificate_file'] = $request->file('certificate_file')->store('certificates', 'public');
            }
    
            // إنشاء المتحدث في قاعدة البيانات
            $speaker = Speaker::create($validated);
    
            // إرسال إشعار إلى الإداريين
            $admins = User::where('isAdmin', true)->get();
    
            foreach ($admins as $admin) {
                $admin->notifications()->create([
                    'user_id' => $admin->id,
                    'message' => "متحدث جديد قد أضيف. ID المستخدم: {$userId}",
                ]);
            }
    
            return response()->json([
                'message' => 'تم إنشاء المتحدث بنجاح!',
                'data' => $speaker
            ], 201);
    
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'message' => 'خطأ في التحقق من البيانات',
                'errors' => $e->errors()
            ], 422);
    
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'حدث خطأ أثناء إنشاء المتحدث',
                'error' => $e->getMessage()
            ], 500);
        }
    }
    
    
    



    public function updateSpeaker(Request $request, $id)
{
    try {
        // الحصول على المستخدم الحالي من التوكن
        $user = Auth::user();

        if (!$user) {
            return response()->json(['message' => 'User not authenticated.'], 401);
        }

        // العثور على المتحدث بناءً على الـ id
        $speaker = Speaker::find($id);

        if (!$speaker) {
            return response()->json(['message' => 'Speaker not found.'], 404);
        }

        // التحقق من الأذونات: إما أن يكون المستخدم أدمن أو صاحب السجل
        if (!$user->isAdmin && $user->id !== $speaker->user_id) {
            return response()->json(['message' => 'Unauthorized access.'], 403);
        }

        // تحقق من وجود حقول لتحديثها
        $updateData = $request->only([
            'abstract',
            'topics',
            'presentation_file',
            'online_participation',
            'is_online_approved',
            'accommodation_status',
            'ticket_status',
            'dinner_invitation',
            'airport_pickup',
            'free_trip',
            'certificate_file',
            'is_certificate_active',
        ]);

        // تحقق من أنه لا يتم إرسال أكثر من حقل واحد لتحديثه
        if (count($updateData) == 0) {
            return response()->json(['message' => 'No fields to update.'], 400);
        }

        // إذا كان هناك ملف تم رفعه، قم بتخزينه
        if (isset($updateData['presentation_file'])) {
            $updateData['presentation_file'] = $request->file('presentation_file')->store('presentations', 'public');
        }

        if (isset($updateData['certificate_file'])) {
            $updateData['certificate_file'] = $request->file('certificate_file')->store('certificates', 'public');
        }

        // تحديث السجل بالبيانات المدخلة
        $speaker->update($updateData);

        return response()->json([
            'message' => 'Speaker updated successfully!',
            'data' => $speaker
        ], 200);

    } catch (\Illuminate\Validation\ValidationException $e) {
        return response()->json([
            'message' => 'Validation error.',
            'errors' => $e->errors()
        ], 422);

    } catch (\Exception $e) {
        return response()->json([
            'message' => 'Error updating speaker.',
            'error' => $e->getMessage()
        ], 500);
    }
}

}
    
    
    
    
    
    

