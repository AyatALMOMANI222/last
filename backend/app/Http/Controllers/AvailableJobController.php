<?php

namespace App\Http\Controllers;

use App\Models\AvailableJob;
use Illuminate\Http\Request;

class AvailableJobController extends Controller
{
    
    public function store(Request $request)
    {
        // التحقق من صحة البيانات
        $validatedData = $request->validate([
            'events_coordinator' => 'required|string|max:255',
            'responsibilities' => 'nullable|string',
            'description' => 'nullable|string',
        ]);
    
        // إنشاء وظيفة جديدة
        $job = AvailableJob::create($validatedData);
    
        // إرجاع استجابة JSON مع الوظيفة التي تم إنشاؤها
        return response()->json([
            'message' => 'Available job created successfully.',
            'job' => $job,
        ], 201); // الحالة 201 تعني تم إنشاء المورد بنجاح
    }
    public function getAllJob()
{
    // استرجاع جميع الوظائف المتاحة
    $jobs = AvailableJob::all();

    // إرجاع استجابة JSON مع قائمة الوظائف
    return response()->json([
        'jobs' => $jobs,
    ], 200); // الحالة 200 تعني الطلب ناجح
}
public function destroy($id)
{
    // البحث عن الوظيفة باستخدام المعرف
    $job = AvailableJob::find($id);

    // التحقق مما إذا كانت الوظيفة موجودة
    if (!$job) {
        return response()->json([
            'message' => 'Job not found.',
        ], 404); // الحالة 404 تعني أن المورد غير موجود
    }
    // حذف الوظيفة
    $job->delete();

    // إرجاع استجابة JSON تؤكد الحذف
    return response()->json([
        'message' => 'Job deleted successfully.',
    ], 200); // الحالة 200 تعني الطلب ناجح
}

public function update(Request $request, $id)
{
    // البحث عن الوظيفة باستخدام المعرف
    $job = AvailableJob::find($id);

    // التحقق مما إذا كانت الوظيفة موجودة
    if (!$job) {
        return response()->json([
            'message' => 'Job not found.',
        ], 404); // الحالة 404 تعني أن المورد غير موجود
    }

    // التحقق من صحة البيانات، لكن فقط إذا تم تمرير الحقول
    $validatedData = $request->validate([
        'events_coordinator' => 'sometimes|required|string|max:255',
        'responsibilities' => 'sometimes|nullable|string',
        'description' => 'sometimes|nullable|string',
    ]);

    // تحديث الوظيفة مع البيانات الجديدة فقط
    $job->update($validatedData);

    // إرجاع استجابة JSON مع الوظيفة المحدثة
    return response()->json([
        'message' => 'Job updated successfully.',
        'job' => $job,
    ], 200); // الحالة 200 تعني الطلب ناجح
}
 
}
