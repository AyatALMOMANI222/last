<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use App\Models\User;
use App\Notifications\EmailNotification;
use Dotenv\Exception\ValidationException;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
// use Illuminate\Validation\ValidationException as ValidationValidationException;

class AuthController extends Controller
{
    //

    /**
     * Handle user login and issue a token.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

    /**
     * Handle user login and issue a token.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function login(Request $request)
    {
        // Validate the request inputs
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        // Find the user by email
        $user = User::where('email', $request->email)->first();

        // Validate user credentials
        if (!$user || !Hash::check($request->password, $user->password)) {
            throw new AuthenticationException('The provided credentials are incorrect.');
        }
        if ($user->status === 'pending' && $user->registration_type === 'group_registration') {
            return response()->json([
                 'status' => 'error',
                'message' => 'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',

            ], 400);
        }
        // Check the user's status
        else if ($user->status === 'pending') {
            return response()->json([
                'status' => 'error',
                'message' => 'Your account is pending approval. Please wait for admin confirmation.',
            ], 403);
        } elseif ($user->status === 'rejected') {
            return response()->json([
                'status' => 'error',
                'message' => 'Your account has been rejected. Please contact support for more information.',
            ], 403);
        } elseif ($user->status !== 'approved') {
            return response()->json([
                'status' => 'error',
                'message' => 'Your account status is not valid for login.',
            ], 403);
        }

        // Create a token for the user if approved
        $token = $user->createToken('laravel')->plainTextToken;

        // Return the token and user data including isAdmin
        return response()->json([
            'status' => 'success',
            'token' => $token,
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'email_verified_at' => $user->email_verified_at,
                'created_at' => $user->created_at,
                'updated_at' => $user->updated_at,
                'isAdmin' => $user->isAdmin, // Include isAdmin in the response
                'status' => $user->status,
                'registration_type' => $user->registration_type,

            ],
        ]);
    }


    /**
     * Get the authenticated user's profile.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function userProfile(Request $request)
    {
        // Get the authenticated user from the token
        $user = $request->user();

        // Return the user details
        return response()->json([
            'user' => $user,
            'isAdmin' => $user->isAdmin, // Include isAdmin in the response
        ]);
    }


    /**
     * Log the user out (revoke the token).
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout(Request $request)
    {
        // Check if the user is authenticated
        if (!$request->user()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized. No token provided or invalid token.',
            ], 401);
        }

        // Revoke the current user's token
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Logged out successfully.',
        ], 200);
    }




    public function sendNotification(Request $request, $userId)
    {
        // Validate the request data
        $validatedData = $request->validate([
            'message' => 'required|string',
        ]);

        try {
            // Find the user
            $user = User::find($userId);

            if ($user) {
                // Send the notification with the message from the request
                $user->notify(new EmailNotification($validatedData['message']));
                return response()->json(['message' => 'Notification sent successfully!']);
            }

            return response()->json(['message' => 'User not found!'], 404);
        } catch (\Exception $e) {

            return response()->json([
                'message' => 'Error sending notification',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
