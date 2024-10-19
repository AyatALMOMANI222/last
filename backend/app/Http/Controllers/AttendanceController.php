<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use App\Models\User;
use App\Models\Conference;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class AttendanceController extends Controller
{
    // دالة لإدخال بيانات الحضور
    public function store(Request $request)
    {
        try {
            // التحقق من صحة البيانات المرسلة
            $validatedData = $request->validate([
                'user_id' => 'required|exists:users,id', // التأكد من وجود user_id
                'conference_id' => 'required|exists:conferences,id', // التأكد من وجود conference_id
            ]);

            // إنشاء سجل جديد في جدول attendance
            $attendance = Attendance::create([
                'user_id' => $validatedData['user_id'],
                'conference_id' => $validatedData['conference_id'],
            ]);

            return response()->json(['message' => 'Attendance recorded successfully!', 'attendance' => $attendance], 201);
        } catch (ValidationException $e) {
            // رسالة الخطأ الخاصة بالتحقق
            return response()->json(['message' => 'Validation Error', 'errors' => $e->validator->errors()], 422);
        } catch (\Exception $e) {
            // رسالة الخطأ العامة
            return response()->json(['message' => 'Something went wrong: ' . $e->getMessage()], 500);
        }
    }
}
