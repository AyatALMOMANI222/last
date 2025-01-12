<?php

namespace App\Http\Controllers;

use App\Models\DinnerDetail;
use App\Models\Speaker;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DinnerDetailController extends Controller
{
 

    public function store(Request $request)
    {
        $userId = Auth::id(); 
    
        // Validate the incoming request data
        $validatedData = $request->validate([
            'conference_id' => 'required|exists:conferences,id',
            'dinner_date' => 'required|date',
            'restaurant_name' => 'required|string|max:255',
            'location' => 'required|string|max:255',
            'gathering_place' => 'required|string|max:255',
            'transportation_method' => 'required|string|max:255',
            'gathering_time' => 'required|date_format:H:i',
            'dinner_time' => 'required|date_format:H:i',
            'duration' => 'required|integer|min:1',
            'dress_code' => 'required|string|max:255',
        ]);
        $existingDinner = DinnerDetail::where('conference_id', $request->conference_id)
        ->first();

    if ($existingDinner) {
        return response()->json(['message' => 'You have already added a dinner for this conference.'], 400);
    }

        try {
            $dinnerDetail = DinnerDetail::create(array_merge($validatedData, ['user_id' => $userId]));
            
            return response()->json(['message' => 'Dinner details created successfully!', 'data' => $dinnerDetail], 201);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error creating dinner details: ' . $e->getMessage()], 500);
        }
    }
    

//     public function getDinnerByConferenceId($conferenceId)
// {
//     $userId = Auth::id(); // الحصول على معرف المستخدم الحالي

//     // التحقق من تسجيل الدخول
//     if (!$userId) {
//         return response()->json(['message' => 'Unauthorized: Please log in to access this resource'], 401);
//     }

//     // استرجاع تفاصيل العشاء حسب conference_id
//     try {
//         $dinnerDetail = DinnerDetail::where('conference_id', $conferenceId)->first();

//         if (!$dinnerDetail) {
//             return response()->json(['message' => 'Dinner details not found for this conference'], 404);
//         }

//         return response()->json([
    
//             'dinner_detail' => $dinnerDetail // إضافة تفاصيل العشاء
//         ], 200);
//     } catch (\Exception $e) {
//         return response()->json(['message' => 'Error retrieving dinner details: ' . $e->getMessage()], 500);
//     }
// }
public function getDinnerByConferenceId($conferenceId)
{
    $userId = Auth::id(); // الحصول على معرف المستخدم الحالي

    // التحقق من تسجيل الدخول
    if (!$userId) {
        return response()->json(['message' => 'Unauthorized: Please log in to access this resource'], 401);
    }

    // التحقق من وجود المستخدم كمتحدث والتحقق من دعوة العشاء
    $speaker = Speaker::where('user_id', $userId)->first();

    if (!$speaker || !$speaker->dinner_invitation) {
        return response()->json(['message' => 'No speaker found for this user or no dinner invitation available'], 403);
    }

    // استرجاع تفاصيل العشاء حسب conference_id
    try {
        $dinnerDetail = DinnerDetail::where('conference_id', $conferenceId)->first();

        if (!$dinnerDetail) {
            return response()->json(['message' => 'Dinner details not found for this conference'], 404);
        }

        return response()->json([
            'dinner_detail' => $dinnerDetail // إضافة تفاصيل العشاء
        ], 200);
    } catch (\Exception $e) {
        return response()->json(['message' => 'Error retrieving dinner details: ' . $e->getMessage()], 500);
    }
}


public function update(Request $request, $id)
{
    $userId = Auth::id(); 

    $dinnerDetail = DinnerDetail::find($id);
    if (!$dinnerDetail) {
        return response()->json(['message' => 'Dinner detail not found.'], 404);
    }

    $validatedData = $request->validate([
        'conference_id' => 'sometimes|required|exists:conferences,id',
        'dinner_date' => 'sometimes|required|date',
        'restaurant_name' => 'sometimes|required|string|max:255',
        'location' => 'sometimes|required|string|max:255',
        'gathering_place' => 'sometimes|required|string|max:255',
        'transportation_method' => 'sometimes|required|string|max:255',
        'gathering_time' => 'sometimes|required|date_format:H:i',
        'dinner_time' => 'sometimes|required|date_format:H:i',
        'duration' => 'sometimes|required|integer|min:1',
        'dress_code' => 'sometimes|required|string|max:255',
    ]);

    try {
        $dataToUpdate = array_filter(array_merge($validatedData, ['user_id' => $userId]));

        $dinnerDetail->update($dataToUpdate);

        return response()->json(['message' => 'Dinner details updated successfully!', 'data' => $dinnerDetail], 200);
    } catch (\Exception $e) {
        return response()->json(['message' => 'Error updating dinner details: ' . $e->getMessage()], 500);
    }
}
public function destroy($id)
{
    $userId = Auth::id(); 

    $dinnerDetail = DinnerDetail::find($id);
    if (!$dinnerDetail) {
        return response()->json(['message' => 'Dinner detail not found.'], 404);
    }
    try {
        $dinnerDetail->delete();

        return response()->json(['message' => 'Dinner details deleted successfully!'], 200);
    } catch (\Exception $e) {
        return response()->json(['message' => 'Error deleting dinner details: ' . $e->getMessage()], 500);
    }
}

}
