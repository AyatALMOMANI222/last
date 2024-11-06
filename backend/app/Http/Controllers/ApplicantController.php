<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreApplicantRequest;
use App\Models\Applicant;
use App\Models\ApplicantJob;
use App\Models\AvailableJob; // تأكد من إضافة هذا النموذج إذا لم يكن موجودًا
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ApplicantController extends Controller
{
    public function store(Request $request)
{
    // تحقق من صحة البيانات
    $validatedData = $request->validate([
        'first_name' => 'required|string|max:255',
        'last_name' => 'required|string|max:255',
        'phone' => 'nullable|string|max:20',
        'whatsapp_number' => 'nullable|string|max:20',
        'email' => 'required|email',
        'nationality' => 'nullable|string|max:255',
        'home_address' => 'nullable|string|max:255',
        'position_applied_for' => 'required|string|max:255',
        'educational_qualification' => 'nullable|string|max:255',
        'resume' => 'nullable|file|mimes:pdf,doc,docx|max:2048', // تحديد أنواع الملفات
        'job_id' => 'required|exists:available_jobs,id', // تحقق من وجود الوظيفة
    ]);

    // تخزين ملف السيرة الذاتية إذا تم تحميله
    $resumePath = null;
    if ($request->hasFile('resume')) {
        $resumePath = $request->file('resume')->store('resumes', 'public'); // تخزين الملف في المجلد 'resumes'
    }

    // إنشاء سجل جديد في جدول المتقدمين
    $applicant = Applicant::create([
        'first_name' => $validatedData['first_name'],
        'last_name' => $validatedData['last_name'],
        'phone' => $validatedData['phone'],
        'whatsapp_number' => $validatedData['whatsapp_number'],
        'email' => $validatedData['email'],
        'nationality' => $validatedData['nationality'],
        'home_address' => $validatedData['home_address'],
        'position_applied_for' => $validatedData['position_applied_for'],
        'educational_qualification' => $validatedData['educational_qualification'],
        'resume' => $resumePath, // مسار السيرة الذاتية
    ]);

    // إضافة سجل في جدول applicant_job
    $jobId = $validatedData['job_id']; // يجب أن يتم تمرير job_id في الطلب
    ApplicantJob::create([
        'applicant_id' => $applicant->id,
        'job_id' => $jobId,
        'status' => 'Pending', // تعيين الحالة إلى Pending
    ]);

    return response()->json(['message' => 'Your application has been submitted successfully!'], 201);
}



}
