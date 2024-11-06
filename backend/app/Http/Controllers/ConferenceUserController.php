<?php

namespace App\Http\Controllers;

use App\Models\Conference;
use App\Models\ConferenceUser;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ConferenceUserController extends Controller
{

  
   


    public function store(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'conference_id' => 'required|exists:conferences,id',
        ]);

        $conferenceUser = ConferenceUser::create([
            'user_id' => $request->user_id,
            'conference_id' => $request->conference_id,
        ]);

        return response()->json(['message' => 'User added to conference successfully!', 'data' => $conferenceUser], 201);
    }


    public function updateVisaPaymentRequirement(Request $request, $userId, $conferenceId)
    {
        // تحقق من صلاحية الحقل
        $request->validate([
            'is_visa_payment_required' => 'required|boolean',
        ]);

        // ابحث عن السجل باستخدام user_id و conference_id
        $conferenceUser = ConferenceUser::where('user_id', $userId)
            ->where('conference_id', $conferenceId)
            ->first();

        if (!$conferenceUser) {
            return response()->json(['message' => 'Conference user record not found'], 404);
        }

        // تحديث الحقل is_visa_payment_required
        $conferenceUser->is_visa_payment_required = $request->is_visa_payment_required;
        $conferenceUser->save();

        return response()->json(['message' => 'Visa payment requirement updated successfully!', 'data' => $conferenceUser], 200);
    }

    public function getConferencesByUser($userId)
    {
        $user = User::with('conferences')->find($userId);

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        return response()->json($user->conferences, 200);
    }
    public function getUpcomingConferencesByUserId(Request $request)
    {
        try {
            // الحصول على معرف المستخدم من التوكن
            $userId = Auth::id(); // باستخدام Laravel Auth للحصول على user_id
    
            // التحقق من وجود معرف المستخدم
            if (!$userId) {
                return response()->json([
                    'message' => 'User not authenticated.',
                ], 401);
            }
    
            // الحصول على التاريخ الحالي
            $currentDate = Carbon::now();
    
            // جلب معرفات المؤتمرات المرتبطة بالمستخدم من جدول ConferenceUser
            $conferenceIds = ConferenceUser::where('user_id', $userId)->pluck('conference_id')->toArray();

    
            // التحقق من وجود أي معرفات للمؤتمرات
            if (empty($conferenceIds)) {
                return response()->json([
                    'message' => 'No upcoming conferences found.',
                    'data' => [],
                ], 404);
            }
    
            // جلب المؤتمرات التي تواريخ البدء الخاصة بها أكبر من التاريخ الحالي
            $conferences = Conference::whereIn('id', $conferenceIds)
                ->where('start_date', '>', $currentDate)
                ->get();
    
            // التحقق من وجود مؤتمرات قادمة
            if ($conferences->isEmpty()) {
                return response()->json([
                    'message' => 'No upcoming conferences found.',
                    'data' => [],
                ], 200);
            }
    
            // إرجاع رد يحتوي على المؤتمرات القادمة
            return response()->json([
                'message' => 'Upcoming conferences retrieved successfully.',
                'data' => $conferences,
            ]);
        } catch (\Exception $e) {
            // معالجة أي خطأ وإرجاع رسالة توضح السبب
            return response()->json([
                'message' => 'An error occurred while retrieving upcoming conferences.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
    
}
