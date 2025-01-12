<?php

namespace App\Http\Controllers;

use App\Models\AdditionalOption;
use App\Models\DiscountOption;
use App\Models\PrivateInvoiceTrip;
use App\Models\TripOptionsParticipant;
use App\Models\TripParticipant;
use App\Models\User;
use App\Models\Trip;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TripParticipantController extends Controller
{
    // public function calculateOptionsPrice($participantId, $tripId, $index, $nightsCount)
    // {
    //     $userId = Auth::id();

    //     // Fetch the options for the participant from the AdditionalOption table
    //     $options = AdditionalOption::whereIn('id', function ($query) use ($participantId) {
    //         $query->select('option_id')
    //             ->from('trip_options_participants')
    //             ->where('participant_id', $participantId);
    //     })->get();

    //     $totalOptionsPrice = 0;

    //     foreach ($options as $option) {
    //         if ($index === 0) {
    //             // Apply discounted logic for index 0
    //             $discount = DiscountOption::where('trip_id', $tripId)
    //                 ->where('user_id', $userId)
    //                 ->where('option_id', $option->id)
    //                 ->first();

    //             $optionPrice = $discount ? $discount->price : $option->price;
    //         } else {
    //             // Use original price for all other participants
    //             $optionPrice = $option->price;
    //         }

    //         // Add to total options price
    //         $totalOptionsPrice += $optionPrice;
    //     }

    //     return $totalOptionsPrice;
    // }

    public function calculateOptionsPrice($participantId, $tripId, $index, $nightsCount)
    {
        $userId = Auth::id();

        // Fetch the options for the participant from the AdditionalOption table
        $options = AdditionalOption::whereIn('id', function ($query) use ($participantId) {
            $query->select('option_id')
                ->from('trip_options_participants')
                ->where('participant_id', $participantId);
        })->get();

        $totalOptionsPrice = 0;

        foreach ($options as $option) {
            if ($index === 0) {
                // Apply discounted logic for index 0 (first participant)
                $discount = DiscountOption::where('trip_id', $tripId)
                    ->where('user_id', $userId)
                    ->where('option_id', $option->id)
                    ->first();

                // Get the option price after applying discount, if applicable
                $optionPrice = $discount ? $discount->price : $option->price;
            } else {
                // Use original price for all other participants
                $optionPrice = $option->price;
            }

            if ($option->multiply_by_nights == 1) {
                if ($index === 0 && $discount) {
                    // السعر الكامل لجميع الليالي باستثناء الليلة الأولى
                    $optionPrice = $option->price * ($nightsCount - 1) + $discount->price * 1;
                } else {
                    // السعر الكامل لجميع الليالي إذا لم يكن هناك خصم أو إذا كان المشاركون الآخرون
                    $optionPrice = $option->price * $nightsCount;
                }
            }

            // Add to total options price
            $totalOptionsPrice += $optionPrice;
        }

        return $totalOptionsPrice;
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
        foreach ($participants as $index => $participant) { // Add $index to track participant position
            // Calculate price for accommodation

            // Pass index to calculateOptionsPrice
            $optionsPrice = $this->calculateOptionsPrice(
                participantId: $participant->id,
                tripId: $tripId,
                index: $index,
                nightsCount: $participant->nights_count
            );

            // Calculate total price (base price * night count + options price + accommodation price)
            $totalPrice = ($basePrice) + $optionsPrice;

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
        // Check if the user is already registered in this trip
        $existingParticipant = TripParticipant::where('user_id', $userId)
            ->where('trip_id', $request->trip_id)
            ->first();

        if ($existingParticipant) {
            return response()->json(['error' => 'User is already registered in this trip'], 400);
        }

        try {
            // Validate input
            $validatedData = $request->validate([
                'trip_id' => 'required|exists:trips,id',
                'options' => 'nullable|array',
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


    public function getAllParticipantsWithInvoice()
    {
        $participants = TripParticipant::leftJoin('trip_participants as companions', 'trip_participants.id', '=', 'companions.main_user_id')
            ->leftJoin('private_invoice_trips as participant_invoices', 'trip_participants.id', '=', 'participant_invoices.participant_id')
            ->leftJoin('private_invoice_trips as companion_invoices', 'companions.id', '=', 'companion_invoices.participant_id')
            ->whereNull('trip_participants.main_user_id') // Filter main participants (not companions)
            ->select(
                'trip_participants.id',
                'trip_participants.user_id',
                'trip_participants.main_user_id',
                'trip_participants.trip_id',
                'trip_participants.name',
                'trip_participants.nationality',
                'trip_participants.phone_number',
                'trip_participants.whatsapp_number',
                'trip_participants.is_companion',
                'trip_participants.include_accommodation',
                'trip_participants.accommodation_stars',
                'trip_participants.nights_count',
                'trip_participants.check_in_date',
                'trip_participants.check_out_date',
                'participant_invoices.base_price as participant_base_price',
                'participant_invoices.options_price as participant_options_price',
                'participant_invoices.total_price as participant_total_price',
                'participant_invoices.status as participant_status',
                'companions.id as companion_id',
                'companions.name as companion_name',
                'companions.nationality as companion_nationality',
                'companions.phone_number as companion_phone_number',
                'companions.whatsapp_number as companion_whatsapp_number',
                'companions.is_companion as companion_is_companion',
                'companions.include_accommodation as companion_include_accommodation',
                'companions.accommodation_stars as companion_accommodation_stars',
                'companions.nights_count as companion_nights_count',
                'companions.check_in_date as companion_check_in_date',
                'companions.check_out_date as companion_check_out_date',
                'companion_invoices.base_price as companion_base_price',
                'companion_invoices.options_price as companion_options_price',
                'companion_invoices.total_price as companion_total_price',
                'companion_invoices.status as companion_status'
            )
            ->groupBy(
                'trip_participants.id',
                'trip_participants.user_id',
                'trip_participants.main_user_id',
                'trip_participants.trip_id',
                'trip_participants.name',
                'trip_participants.nationality',
                'trip_participants.phone_number',
                'trip_participants.whatsapp_number',
                'trip_participants.is_companion',
                'trip_participants.include_accommodation',
                'trip_participants.accommodation_stars',
                'trip_participants.nights_count',
                'trip_participants.check_in_date',
                'trip_participants.check_out_date',
                'participant_invoices.base_price',
                'participant_invoices.options_price',
                'participant_invoices.total_price',
                'participant_invoices.status',
                'companions.id',
                'companions.name',
                'companions.nationality',
                'companions.phone_number',
                'companions.whatsapp_number',
                'companions.is_companion',
                'companions.include_accommodation',
                'companions.accommodation_stars',
                'companions.nights_count',
                'companions.check_in_date',
                'companions.check_out_date',
                'companion_invoices.base_price',
                'companion_invoices.options_price',
                'companion_invoices.total_price',
                'companion_invoices.status'
            )
            ->paginate(10);

        // Format results to separate main participants and their companions
        $formattedParticipants = $participants->map(function ($participant) {
            $companions = [
                'id' => $participant->companion_id,
                'name' => $participant->companion_name,
                'nationality' => $participant->companion_nationality,
                'phone_number' => $participant->companion_phone_number,
                'whatsapp_number' => $participant->companion_whatsapp_number,
                'is_companion' => $participant->companion_is_companion,
                'include_accommodation' => $participant->companion_include_accommodation,
                'accommodation_stars' => $participant->companion_accommodation_stars,
                'nights_count' => $participant->companion_nights_count,
                'check_in_date' => $participant->companion_check_in_date,
                'check_out_date' => $participant->companion_check_out_date,
                'invoice' => [
                    'base_price' => $participant->companion_base_price,
                    'options_price' => $participant->companion_options_price,
                    'total_price' => $participant->companion_total_price,
                    'status' => $participant->companion_status
                ]
            ];

            return [
                'id' => $participant->id,
                'mainParticipant' => [
                    'id' => $participant->id,
                    'user_id' => $participant->user_id,
                    'name' => $participant->name,
                    'nationality' => $participant->nationality,
                    'phone_number' => $participant->phone_number,
                    'whatsapp_number' => $participant->whatsapp_number,
                    'is_companion' => $participant->is_companion,
                    'include_accommodation' => $participant->include_accommodation,
                    'accommodation_stars' => $participant->accommodation_stars,
                    'nights_count' => $participant->nights_count,
                    'check_in_date' => $participant->check_in_date,
                    'check_out_date' => $participant->check_out_date,
                    'invoice' => [
                        'base_price' => $participant->participant_base_price,
                        'options_price' => $participant->participant_options_price,
                        'total_price' => $participant->participant_total_price,
                        'status' => $participant->participant_status
                    ]
                ],
                'companions' => $companions['id'] ? [$companions] : [] // Only include if companion exists
            ];
        });

        return response()->json([
            'message' => 'Participants and invoice details retrieved successfully.',
            'participants' => $formattedParticipants,
            'currentPage' => $participants->currentPage(),
            'totalPages' => $participants->lastPage(),
            'totalReservations' => $participants->total()
        ]);
    }

    public function getUserTrips(Request $request)
    {
        $userId = Auth::id();

        if (!$userId) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        try {
            // Fetch the trips the user is participating in
            $userTrips = TripParticipant::with('trip', 'companions') // Include companions relationship
                ->where('user_id', $userId)
                ->get();

            // Transform trips data to include companions
            $tripsData = $userTrips->map(function ($tripParticipant) {
                $companions = TripParticipant::where('main_user_id', $tripParticipant->id)
                    ->where('is_companion', true)
                    ->get();

                $mainUser = TripParticipant::where('id', $tripParticipant->id)
                    ->get();

                return [
                    'trip' => $tripParticipant->trip,
                    'companions' => $companions,
                    'mainUser' => $mainUser
                ];
            });

            return response()->json([
                'message' => 'Trips found successfully',
                'trips' => $tripsData
            ], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }






}
