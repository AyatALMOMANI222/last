<?php

namespace App\Http\Controllers;

use App\Models\ConferenceUser;
use App\Models\User;
use Illuminate\Http\Request;


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


    public function getConferencesByUser($userId)
    {
        $user = User::with('conferences')->find($userId);

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        return response()->json($user->conferences, 200);
    }
}
