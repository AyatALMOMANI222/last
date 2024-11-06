<?php

namespace App\Http\Controllers;

use App\Models\Applicant;
use App\Models\ApplicantJob;
use App\Models\AvailableJob;
use Illuminate\Http\Request;

class ApplicantJobController extends Controller
{
    public function getApplicantsByJobId($jobId)
    {
        // استرجاع applicant_id من جدول applicant_jobs للوظيفة المحددة
        $applicantIds = ApplicantJob::where('job_id', $jobId)->pluck('applicant_id');
    
        if ($applicantIds->isEmpty()) {
            return response()->json(['message' => 'No applicants found for this job.'], 200);
        }
    
        // استرجاع معلومات المتقدمين من جدول applicants باستخدام المعرفات المسترجعة
        $applicants = Applicant::whereIn('id', $applicantIds)->get();
    
        return response()->json($applicants);
    }
    
}
