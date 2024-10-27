<?php

namespace App\Http\Controllers;

use App\Models\AdditionalOption;
use App\Models\TripOptionsParticipant;
use App\Models\TripParticipant;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TripParticipantController extends Controller
{

    // public function addParticipant(Request $request)
    // {
    //     $userId = Auth::id();
    
    //     if (!$userId) {
    //         return response()->json(['error' => 'Unauthorized'], 401);
    //     }
    
    //     try {
    //         // Validate input
    //         $validatedData = $request->validate([
    //             'trip_id' => 'required|exists:trips,id',
    //             'participants' => 'required|array',
    //             'participants.*.is_companion' => 'required|boolean',
    //             'participants.*.include_accommodation' => 'boolean',
    //             'participants.*.accommodation_stars' => 'nullable|integer|min:1|max:5',
    //             'participants.*.nights_count' => 'nullable|integer|min:1',
    //             'participants.*.check_in_date' => 'nullable|date',
    //             'participants.*.check_out_date' => 'nullable|date|after_or_equal:participants.*.check_in_date',
    //             'participants.*.name' => 'nullable|string',
    //             'participants.*.nationality' => 'nullable|string',
    //             'participants.*.phone_number' => 'nullable|string',
    //             'participants.*.whatsapp_number' => 'nullable|string',
    //         ]);
    
    //         // Get user data from the database
    //         $user = User::findOrFail($userId); // Use findOrFail to ensure the user exists
    
    //         // Initialize participants array
    //         $participants = [];
    
    //         // Add normal user
    //         $normalUser = [
    //             'user_id' => $userId,
    //             'main_user_id' => null,
    //             'trip_id' => $validatedData['trip_id'],
    //             'name' => $user->name,  // from User table
    //             'nationality' => $user->nationality,  // from User table
    //             'phone_number' => $user->phone_number,  // from User table
    //             'whatsapp_number' => $user->whatsapp_number,  // from User table
    //             'is_companion' => false,
    //             // Take these values directly from the first participant's data
    //             'include_accommodation' => $validatedData['participants'][0]['include_accommodation'],
    //             'accommodation_stars' => $validatedData['participants'][0]['accommodation_stars'] ?? null,
    //             'nights_count' => $validatedData['participants'][0]['nights_count'],
    //             'check_in_date' => $validatedData['participants'][0]['check_in_date'],
    //             'check_out_date' => $validatedData['participants'][0]['check_out_date'],
    //         ];
    
    //         // Add normal user to participants
    //         $participants[] = $normalUser;
    
    //         // Initialize array for companions
    //         $companions = [];
    
    //         // Process companions
    //         foreach ($validatedData['participants'] as $participantData) {
    //             if ($participantData['is_companion'] === true) {
    //                 // Store companion details from the request
    //                 $companions[] = [
    //                     'user_id' => null,
    //                     'main_user_id' => $userId,
    //                     'trip_id' => $validatedData['trip_id'],
    //                     'name' => $participantData['name'] ?? $user->name,
    //                     'nationality' => $participantData['nationality'] ?? $user->nationality,
    //                     'phone_number' => $participantData['phone_number'] ?? $user->phone_number,
    //                     'whatsapp_number' => $participantData['whatsapp_number'] ?? $user->whatsapp_number,
    //                     'is_companion' => true,
    //                     'include_accommodation' => $participantData['include_accommodation'],
    //                     'accommodation_stars' => $participantData['accommodation_stars'],
    //                     'nights_count' => $participantData['nights_count'],
    //                     'check_in_date' => $participantData['check_in_date'],
    //                     'check_out_date' => $participantData['check_out_date'],
    //                 ];
    //             }
    //         }
    
    //         // Add companions to participants
    //         $participants = array_merge($participants, $companions);
    
    //         // Insert participants
    //         TripParticipant::insert($participants); // Use insert to add participants in bulk
    
    //         return response()->json([
    //             'message' => 'Participants added successfully',
    //             'participants' => $participants
    //         ], 201);
    
    //     } catch (\Illuminate\Validation\ValidationException $e) {
    //         return response()->json(['error' => $e->validator->errors()], 422); // Return all validation errors
    //     } catch (\Exception $e) {
    //         return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
    //     }
    // } 
    public function addParticipant(Request $request)
    {
        $userId = Auth::id();
    
        if (!$userId) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
    
        try {
            // Validate input
            $validatedData = $request->validate([
                'trip_id' => 'required|exists:trips,id',
                'options' => 'required|array',
                'participants' => 'required|array',
                'participants.*.is_companion' => 'required|boolean',
                'participants.*.include_accommodation' => 'boolean',
                'participants.*.accommodation_stars' => 'nullable|integer|min:1|max:5',
                'participants.*.nights_count' => 'nullable|integer|min:1',
                'participants.*.check_in_date' => 'nullable|date',
                'participants.*.check_out_date' => 'nullable|date|after_or_equal:participants.*.check_in_date',
                'participants.*.name' => 'nullable|string',
                'participants.*.nationality' => 'nullable|string',
                'participants.*.phone_number' => 'nullable|string',
                'participants.*.whatsapp_number' => 'nullable|string',
                'participants.*.id' => 'nullable|integer'
            ]);
    
            // Get user data from the database
            $user = User::findOrFail($userId);
    
            // Initialize participants array
            $participants = [];
    
            // Add normal user
            $normalUser = [
                'user_id' => $userId,
                'main_user_id' => null,
                'trip_id' => $validatedData['trip_id'],
                'name' => $user->name,
                'nationality' => $user->nationality,
                'phone_number' => $user->phone_number,
                'whatsapp_number' => $user->whatsapp_number,
                'is_companion' => false,
                'include_accommodation' => $validatedData['participants'][0]['include_accommodation'],
                'accommodation_stars' => $validatedData['participants'][0]['accommodation_stars'] ?? null,
                'nights_count' => $validatedData['participants'][0]['nights_count'],
                'check_in_date' => $validatedData['participants'][0]['check_in_date'],
                'check_out_date' => $validatedData['participants'][0]['check_out_date'],
            ];
    
            // Insert normal user and get the inserted participant ID
            $normalParticipant = TripParticipant::create($normalUser);
            $participants[] = $normalParticipant;
    
            // Initialize array for companions
            $companions = [];
    
            // Process companions
            foreach ($validatedData['participants'] as $participantData) {
                if ($participantData['is_companion'] === true) {
                    // Store companion details from the request
                    $companions[] = [
                        'user_id' => null,
                        'main_user_id' => $userId,
                        'trip_id' => $validatedData['trip_id'],
                        'name' => $participantData['name'] ?? $user->name,
                        'nationality' => $participantData['nationality'] ?? $user->nationality,
                        'phone_number' => $participantData['phone_number'] ?? $user->phone_number,
                        'whatsapp_number' => $participantData['whatsapp_number'] ?? $user->whatsapp_number,
                        'is_companion' => true,
                        'include_accommodation' => $participantData['include_accommodation'],
                        'accommodation_stars' => $participantData['accommodation_stars'],
                        'nights_count' => $participantData['nights_count'],
                        'check_in_date' => $participantData['check_in_date'],
                        'check_out_date' => $participantData['check_out_date'],
                    ];
                }
            }
    
            // Insert companions and collect their IDs
            foreach ($companions as $companion) {
                $insertedCompanion = TripParticipant::create($companion);
                $participants[] = $insertedCompanion;
            }
    
            // Get valid option IDs from the additional_options table
            $validOptionIds = AdditionalOption::whereIn('id', $validatedData['options'])->pluck('id')->toArray();
    
            // Store options for each participant
            foreach ($validOptionIds as $optionId) {
                foreach ($participants as $participant) {
                    TripOptionsParticipant::create([
                        'trip_id' => $validatedData['trip_id'],
                        'option_id' => $optionId,
                        'participant_id' => $participant->id // Use the actual participant ID
                    ]);
                }
            }
    
            return response()->json([
                'message' => 'Participants added successfully',
                'participants' => $participants
            ], 201);
    
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->validator->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
    
    
    
    // public function addParticipant(Request $request)
    // {
    //     $userId = Auth::id();
    
    //     if (!$userId) {
    //         return response()->json(['error' => 'Unauthorized'], 401);
    //     }
    
    //     try {
    //         // Validate input
    //         $validatedData = $request->validate([
    //             'trip_id' => 'required|exists:trips,id',
    //             'options' => 'required|array',
    //             'participants' => 'required|array',
    //             'participants.*.is_companion' => 'required|boolean',
    //             'participants.*.include_accommodation' => 'boolean',
    //             'participants.*.accommodation_stars' => 'nullable|integer|min:1|max:5',
    //             'participants.*.nights_count' => 'nullable|integer|min:1',
    //             'participants.*.check_in_date' => 'nullable|date',
    //             'participants.*.check_out_date' => 'nullable|date|after_or_equal:participants.*.check_in_date',
    //             'participants.*.name' => 'nullable|string',
    //             'participants.*.nationality' => 'nullable|string',
    //             'participants.*.phone_number' => 'nullable|string',
    //             'participants.*.whatsapp_number' => 'nullable|string',
    //             'participants.*.id' => 'nullable|integer'
    //         ]);
    
    //         // Get user data from the database
    //         $user = User::findOrFail($userId);
    
    //         // Initialize participants array
    //         $participants = [];
    
    //         // Add normal user
    //         $normalUser = [
    //             'user_id' => $userId,
    //             'main_user_id' => null,
    //             'trip_id' => $validatedData['trip_id'],
    //             'name' => $user->name,
    //             'nationality' => $user->nationality,
    //             'phone_number' => $user->phone_number,
    //             'whatsapp_number' => $user->whatsapp_number,
    //             'is_companion' => false,
    //             'include_accommodation' => $validatedData['participants'][0]['include_accommodation'],
    //             'accommodation_stars' => $validatedData['participants'][0]['accommodation_stars'] ?? null,
    //             'nights_count' => $validatedData['participants'][0]['nights_count'],
    //             'check_in_date' => $validatedData['participants'][0]['check_in_date'],
    //             'check_out_date' => $validatedData['participants'][0]['check_out_date'],
    //         ];
    
    //         // Insert normal user and get the inserted participant ID
    //         $normalParticipant = TripParticipant::create($normalUser);
    //         $participants[] = $normalParticipant;
    
    //         // Initialize array for companions
    //         $companions = [];
    
    //         // Process companions
    //         foreach ($validatedData['participants'] as $participantData) {
    //             if ($participantData['is_companion'] === true) {
    //                 // Store companion details from the request
    //                 $companions[] = [
    //                     'user_id' => null,
    //                     'main_user_id' => $userId,
    //                     'trip_id' => $validatedData['trip_id'],
    //                     'name' => $participantData['name'] ?? $user->name,
    //                     'nationality' => $participantData['nationality'] ?? $user->nationality,
    //                     'phone_number' => $participantData['phone_number'] ?? $user->phone_number,
    //                     'whatsapp_number' => $participantData['whatsapp_number'] ?? $user->whatsapp_number,
    //                     'is_companion' => true,
    //                     'include_accommodation' => $participantData['include_accommodation'],
    //                     'accommodation_stars' => $participantData['accommodation_stars'],
    //                     'nights_count' => $participantData['nights_count'],
    //                     'check_in_date' => $participantData['check_in_date'],
    //                     'check_out_date' => $participantData['check_out_date'],
    //                 ];
    //             }
    //         }
    
    //         // Insert companions and collect their IDs
    //         foreach ($companions as $companion) {
    //             $insertedCompanion = TripParticipant::create($companion);
    //             $participants[] = $insertedCompanion;
    //         }
    
    //         // Get valid option IDs from the additional_options table
    //         $validOptionIds = AdditionalOption::whereIn('id', $validatedData['options'])->pluck('id')->toArray();
    
    //         // Store options for each participant if the option_id is valid
    //         foreach ($validOptionIds as $optionId) {
    //             foreach ($participants as $participant) {
    //                 TripOptionsParticipant::create([
    //                     'trip_id' => $validatedData['trip_id'],
    //                     'option_id' => $optionId, // Use the validated option ID
    //                     'participant_id' => $participant->id // Use the actual participant ID
    //                 ]);
    //             }
    //         }
    
    //         return response()->json([
    //             'message' => 'Participants added successfully',
    //             'participants' => $participants
    //         ], 201);
    
    //     } catch (\Illuminate\Validation\ValidationException $e) {
    //         return response()->json(['error' => $e->validator->errors()], 422);
    //     } catch (\Exception $e) {
    //         return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
    //     }
    // }
    

    
    



    public function storeUserAndParticipant(Request $request)
    {
        if (!Auth::id()) {
            return response()->json(['success' => false, 'message' => 'يجب تسجيل الدخول.'], 401);
        }
    
        $userId = Auth::id();
    
        $validatedData = $request->validate([
            'trip_id' => 'required|exists:trips,id',
            'name' => 'nullable|string',
            'nationality' => 'nullable|string',
            'phone_number' => 'nullable|string',
            'whatsapp_number' => 'nullable|string',
            'is_companion' => 'boolean',
            'include_accommodation' => 'boolean',
            'accommodation_stars' => 'nullable|integer',
            'nights_count' => 'nullable|integer',
            'check_in_date' => 'nullable|date',
            'check_out_date' => 'nullable|date',
            'companions' => 'array',
            'companions.*.name' => 'required|string',
            'companions.*.nationality' => 'required|string',
            'companions.*.phone_number' => 'required|string',
            'companions.*.whatsapp_number' => 'required|string',
            'companions.*.is_companion' => 'boolean',
            'companions.*.include_accommodation' => 'boolean',
            'companions.*.accommodation_stars' => 'nullable|integer',
            'companions.*.nights_count' => 'nullable|integer',
            'selectedOptions' => 'array',
            'selectedOptions.*.option_id' => 'required|exists:additional_options,id',
            'selectedOptions.*.option_name' => 'required|string',
            'selectedOptions.*.value' => 'boolean',
        ]);
    
        try {
            // إعداد بيانات المشارك الرئيسي
            $mainParticipantData = [
                'user_id' => $userId,
                'trip_id' => $validatedData['trip_id'],
                'main_user_id' => $validatedData['is_companion'] ? $userId : null,
                'is_companion' => $validatedData['is_companion'] ?? false,
                'include_accommodation' => $validatedData['include_accommodation'],
                'accommodation_stars' => $validatedData['accommodation_stars'],
                'nights_count' => $validatedData['nights_count'],
                'check_in_date' => $validatedData['check_in_date'],
                'check_out_date' => $validatedData['check_out_date'],
            ];
    
            // إذا كان المستخدم مرافقًا (is_companion == true)، نضيف الحقول التالية
            if ($validatedData['is_companion']) {
                $mainParticipantData['name'] = $validatedData['name'];
                $mainParticipantData['nationality'] = $validatedData['nationality'];
                $mainParticipantData['phone_number'] = $validatedData['phone_number'];
                $mainParticipantData['whatsapp_number'] = $validatedData['whatsapp_number'];
            }
    
            // إضافة المشارك الرئيسي في جدول trip_participants
            $mainParticipant = TripParticipant::create($mainParticipantData);
    
            // Array to hold the IDs of companions
            $companionIds = [];
    
            // إضافة المرافقين (companions) في جدول trip_participants
            foreach ($validatedData['companions'] as $companion) {
                $companionData = [
                    'user_id' => null,
                    'trip_id' => $validatedData['trip_id'],
                    'main_user_id' => $validatedData['is_companion'] ? $userId : $mainParticipant->id,
                    'name' => $companion['name'],
                    'nationality' => $companion['nationality'],
                    'phone_number' => $companion['phone_number'],
                    'whatsapp_number' => $companion['whatsapp_number'],
                    'is_companion' => true,
                    'include_accommodation' => $companion['include_accommodation'],
                    'accommodation_stars' => $companion['accommodation_stars'],
                    'nights_count' => $companion['nights_count'],
                    'check_in_date' => null,
                    'check_out_date' => null,
                ];
    
                // Create the companion participant and store the ID
                $createdCompanion = TripParticipant::create($companionData);
                $companionIds[] = $createdCompanion->id; // Store the ID of the newly created companion
            }
    
            // Adding selected options to the trip_options_participants table
            // For main participant
            foreach ($validatedData['selectedOptions'] as $option) {
                TripOptionsParticipant::create([
                    'trip_id' => $validatedData['trip_id'],
                    'option_id' => $option['option_id'],
                    'participant_id' => $mainParticipant->id, // Using the main participant ID
                ]);
            }
    
            // For companions
            foreach ($companionIds as $companionId) {
                foreach ($validatedData['selectedOptions'] as $option) {
                    TripOptionsParticipant::create([
                        'trip_id' => $validatedData['trip_id'],
                        'option_id' => $option['option_id'],
                        'participant_id' => $companionId, // Using the companion's ID
                    ]);
                }
            }
    
            // استجابة عند النجاح
            return response()->json(['success' => true, 'message' => 'تم إضافة المشارك والمرافقين بنجاح.', 'companion_ids' => $companionIds], 201);
        } catch (\Exception $e) {
            // استجابة عند حدوث خطأ
            return response()->json(['success' => false, 'message' => 'حدث خطأ أثناء إضافة البيانات: ' . $e->getMessage()], 500);
        }
    }
    
}




