<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Paper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;
use App\Notifications\EmailNotification;

class PaperController extends Controller
{
    public function create(Request $request)
    {
        try {
            // التحقق من صحة البيانات
            $validatedData = $request->validate([
                'conference_id' => 'required|exists:conferences,id',
                'author_name' => 'required|string|max:255',
                'author_title' => 'required|string|max:255',
                'email' => 'required|email|max:255',
                'phone' => 'required|string|max:20',
                'whatsapp' => 'nullable|string|max:20',
                'country' => 'required|string|max:255',
                'nationality' => 'required|string|max:255',
                'password' => 'required|string|max:255', // تأكد من تشفير كلمة السر
                'file_path' => 'required|file|mimes:pdf|max:2048', // تعديل بناءً على نوع الملفات المطلوبة
                'status' => 'nullable|in:under_review,accepted,rejected',
            ]);

            // معالجة الملف
            $filePath = $request->file('file_path')->store('scientific_papers', 'public');

            // تشفير كلمة المرور
            $hashedPassword = bcrypt($validatedData['password']);

            // إنشاء سجل جديد في جدول scientific_papers
            $paper = Paper::create([
                'conference_id' => $validatedData['conference_id'],
                'author_name' => $validatedData['author_name'],
                'author_title' => $validatedData['author_title'],
                'email' => $validatedData['email'],
                'phone' => $validatedData['phone'],
                'whatsapp' => $validatedData['whatsapp'],
                'country' => $validatedData['country'],
                'nationality' => $validatedData['nationality'],
                'password' => $hashedPassword, // حفظ كلمة السر المشفرة
                'file_path' => $filePath,
                'status' => $validatedData['status'] ?? 'under_review',
            ]);

            // محاولة إرسال إشعار بالبريد الإلكتروني
            try {
                $message = 'Your scientific paper has been successfully submitted. Thank you for your submission.';
                Notification::route('mail', $validatedData['email'])->notify(new EmailNotification($message));
                // broadcast(new NotificationSent([
                //     'message' => $message,
                //     'email' => $validatedData['email'],
                // ]));
                return response()->json([
                    'message' => 'Paper created and notification sent successfully!',
                    'data' => $paper,
                    'email_status' => 'Email sent successfully.'
                ], 201);
            } catch (\Exception $e) {
                // في حال فشل إرسال البريد الإلكتروني
                return response()->json([
                    'message' => 'Paper created but email notification failed to send.',
                    'data' => $paper,
                    'email_error' => $e->getMessage()
                ], 201);
            }
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error creating paper',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function getPapersByConferenceId($conference_id)
    {
        try {
            // الحصول على الأوراق حسب معرف المؤتمر
            $papers = Paper::where('conference_id', $conference_id)->get();

            if ($papers->isEmpty()) {
                return response()->json([
                    'message' => 'No papers found for this conference.'
                ], 404);
            }

            return response()->json([
                'message' => 'Papers retrieved successfully!',
                'data' => $papers
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error retrieving papers',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function getPaperById($paper_id)
    {
        try {
            // البحث عن الورقة العلمية حسب معرفها
            $paper = Paper::find($paper_id);

            if (!$paper) {
                return response()->json([
                    'message' => 'Paper not found.'
                ], 404);
            }

            return response()->json([
                'message' => 'Paper retrieved successfully!',
                'data' => $paper
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error retrieving paper',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
