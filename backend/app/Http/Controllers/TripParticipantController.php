<?php

namespace App\Http\Controllers;

use App\Models\TripParticipant;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TripParticipantController extends Controller
{
    public function addParticipant(Request $request)
    {
        $userId = Auth::id();

        if (!$userId) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        try {
            // التحقق من صحة المدخلات
            $validatedData = $request->validate([
                'trip_id' => 'required|exists:trips,id',
                'name' => 'required|string|max:255',
                'nationality' => 'required|string|max:255',
                'phone_number' => 'required|string|max:20',
                'whatsapp_number' => 'required|string|max:20',
                'is_companion' => 'required|boolean',
                'include_accommodation' => 'boolean',
                'accommodation_type' => 'nullable|string',
                'tent_type' => 'nullable|string',
                'accommodation_stars' => 'nullable|integer|min:1|max:5',
                'nights_count' => 'nullable|integer|min:1',
                'check_in_date' => 'nullable|date',
                'check_out_date' => 'nullable|date|after_or_equal:check_in_date',
            ]);

            // تحديد main_user_id و user_id بناءً على is_companion
            if ($validatedData['is_companion']) {
                $participantData = [
                    'user_id' => null, // user_id فارغ
                    'main_user_id' => $userId, // main_user_id يساوي user_id
                ];
            } else {
                $participantData = [
                    'user_id' => $userId, // user_id يساوي قيمة التوكن
                    'main_user_id' => null, // main_user_id فارغ
                ];
            }

            // دمج باقي بيانات المشارك
            $participantData = array_merge($participantData, [
                'trip_id' => $validatedData['trip_id'],
                'name' => $validatedData['name'],
                'nationality' => $validatedData['nationality'],
                'phone_number' => $validatedData['phone_number'],
                'whatsapp_number' => $validatedData['whatsapp_number'],
                'is_companion' => $validatedData['is_companion'],
                'include_accommodation' => $validatedData['include_accommodation'] ?? false,
                'accommodation_type' => $validatedData['accommodation_type'],
                'tent_type' => $validatedData['tent_type'],
                'accommodation_stars' => $validatedData['accommodation_stars'],
                'nights_count' => $validatedData['nights_count'],
                'check_in_date' => $validatedData['check_in_date'],
                'check_out_date' => $validatedData['check_out_date'],
            ]);

            // إنشاء المشارك
            $participant = TripParticipant::create($participantData);

            return response()->json(['message' => 'Participant added successfully', 'participant' => $participant], 201);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->validator->errors()->first()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
}


