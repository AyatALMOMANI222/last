<?php

namespace App\Http\Controllers;

use App\Models\AdditionalOption;
use App\Models\PrivateInvoiceTrip;
use App\Models\TripOptionsParticipant;
use App\Models\TripParticipant;
use App\Models\User;
use App\Models\Trip;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TripParticipantController extends Controller
{
    public function calculateOptionsPrice($participantId)
    {
        // Fetch the options for the participant from the AdditionalOption table
        $options = AdditionalOption::whereIn('id', function ($query) use ($participantId) {
            // Assuming you have a pivot table or a relationship to store the selected options for a participant
            $query->select('option_id')->from('trip_options_participants')->where('participant_id', $participantId);
        })->get();

        // Calculate the total price of options
        $totalOptionsPrice = $options->sum('price'); // Assuming 'price' is the column with the price in the AdditionalOption model

        return $totalOptionsPrice ?: 0; // Return 0 if no options are selected or calculated price is 0
    }

    public function createInvoice($participantId, $basePrice, $optionsPrice, $totalPrice)
    {
        // Create a new PrivateInvoiceTrip for the participant
        return PrivateInvoiceTrip::create([
            'participant_id' => $participantId,
            'base_price' => $basePrice ?? 8,
            'options_price' => $optionsPrice,
            'total_price' => $totalPrice,
            'status' => 'pending'
        ]);
    }



    public function calculateInvoice($tripId, $participants)
    {
        $invoiceData = [];

        // Get trip details (e.g., base price)
        $trip = Trip::findOrFail($tripId);

        // Determine the base price depending on the number of participants
        $numberOfParticipants = count($participants);

        if ($numberOfParticipants === 1) {
            $basePrice = $trip->price_per_person;
        } elseif ($numberOfParticipants === 2) {
            $basePrice = $trip->price_for_two;
        } else {
            $basePrice = $trip->price_for_three_or_more;
        }

        // Iterate over each participant to calculate their invoice
        foreach ($participants as $participant) {
            // Calculate price for accommodation

            // Calculate price for additional options
            $optionsPrice = $this->calculateOptionsPrice(participantId: $participant->id);

            // Calculate total price (base price * night count + options price + accommodation price)
            $totalPrice = ($basePrice * $participant->nights_count) + $optionsPrice;

            $participantInvoice = [
                'participant_id' => $participant->id,
                'base_price' => $basePrice,
                'options_price' => $optionsPrice,
                'total_price' => $totalPrice,
            ];

            // Store the calculated invoice data
            $invoiceData[] = $participantInvoice;
        }

        return $invoiceData;
    }

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
                // 'participants.*.include_accommodation' => 'boolean',
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
                // 'include_accommodation' => $validatedData['participants'][0]['include_accommodation'],
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
                        'main_user_id' => $normalParticipant->id,
                        'trip_id' => $validatedData['trip_id'],
                        'name' => $participantData['name'] ?? $user->name,
                        'nationality' => $participantData['nationality'] ?? $user->nationality,
                        'phone_number' => $participantData['phone_number'] ?? $user->phone_number,
                        'whatsapp_number' => $participantData['whatsapp_number'] ?? $user->whatsapp_number,
                        'is_companion' => true,
                        // 'include_accommodation' => $participantData['include_accommodation'],
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

            // Calculate the invoice for the participants
            $invoiceData = $this->calculateInvoice($validatedData['trip_id'], $participants);

            foreach ($invoiceData as $invoice) {
                $this->createInvoice(
                    $invoice['participant_id'],
                    $invoice['base_price'],
                    $invoice['options_price'],
                    $invoice['total_price'],
                );
            }
            return response()->json([
                'message' => 'Participants added successfully',
                'participants' => $participants,
                'invoice' => $invoiceData
            ], 201);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->validator->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }


    public function updateParticipant(Request $request)
    {
        $userId = Auth::id();

        if (!$userId) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        try {
            // Validate input
            $validatedData = $request->validate([
                'trip_id' => 'required|exists:trips,id',
                'participants' => 'required|array',
                'participants.*.id' => 'required|integer|exists:trip_participants,id',
                'participants.*.name' => 'nullable|string',
                'participants.*.nationality' => 'nullable|string',
                'participants.*.phone_number' => 'nullable|string',
                'participants.*.whatsapp_number' => 'nullable|string',
                // 'participants.*.include_accommodation' => 'boolean',
                'participants.*.accommodation_stars' => 'nullable|integer|min:1|max:5',
                'participants.*.nights_count' => 'nullable|integer|min:1',
                'participants.*.check_in_date' => 'nullable|date',
                'participants.*.check_out_date' => 'nullable|date|after_or_equal:participants.*.check_in_date',
                'options' => 'nullable|array',
            ]);

            // Update participants
            $participants = [];
            foreach ($validatedData['participants'] as $participantData) {
                $participant = TripParticipant::find($participantData['id']);
                if ($participant) {
                    // Update participant's data
                    $participant->update(array_filter($participantData));
                    $participants[] = $participant;
                }
            }

            // Update options if provided
            if (isset($validatedData['options'])) {
                $validOptionIds = AdditionalOption::whereIn('id', $validatedData['options'])->pluck('id')->toArray();

                // Delete existing options for the participants
                TripOptionsParticipant::where('trip_id', $validatedData['trip_id'])
                    ->whereIn('participant_id', array_column($participants, 'id'))
                    ->delete();

                // Store new options for each participant
                foreach ($validOptionIds as $optionId) {
                    foreach ($participants as $participant) {
                        TripOptionsParticipant::create([
                            'trip_id' => $validatedData['trip_id'],
                            'option_id' => $optionId,
                            'participant_id' => $participant->id // Use the actual participant ID
                        ]);
                    }
                }
            }

            return response()->json([
                'message' => 'Participants updated successfully',
                'participants' => $participants
            ], 200);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->validator->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }










}




