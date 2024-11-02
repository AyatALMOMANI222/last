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

public function getUpcomingConferencesByUserId(Request $request)
{
    // Get the authenticated user ID from the token
    $userId = Auth::id(); // Assuming you are using Laravel's built-in Auth

    // Check if user ID exists
    if (!$userId) {
        return response()->json([
            'message' => 'User not authenticated.',
        ], 401);
    }

    // Get current date
    $currentDate = Carbon::now();

    // Fetch conferences for the authenticated user with start date greater than now
    $conferencesIds = ConferenceUser::where('user_id', $userId)->pluck('conference_id'); // Assuming ConferenceUser model has a user_id and conference_id

    // Check if there are any conferences
    if ($conferencesIds->isEmpty()) {
        return response()->json([
            'message' => 'No upcoming conferences found.',
            'data' => [],
        ], 404);
    }

    // Fetch upcoming conferences
    $conferences = Conference::whereIn('id', $conferencesIds) 
        ->where('start_date', '>', $currentDate)
        ->get();

    // Return response
    return response()->json([
        'message' => 'Upcoming conferences retrieved successfully.',
        'data' => $conferences,
    ]);
}

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
}
