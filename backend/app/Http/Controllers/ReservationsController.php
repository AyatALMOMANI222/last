<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Notification;
use App\Models\Reservation;
use App\Models\ReservationInvoice;
use App\Models\Room;
use App\Models\RoomPrice;
use App\Models\Speaker;
use App\Models\User;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ReservationsController extends Controller
{



    protected function getBasePriceForRoomType($roomType)
    {
        // Retrieve the base price for the given room type from the room price table
        return RoomPrice::where('room_type', $roomType)->value('base_price');
    }

    protected function getEarlyCheckInPriceForRoomType($roomType)
    {
        // Retrieve the early check-in price for the given room type
        return RoomPrice::where('room_type', $roomType)->value('early_check_in_price');
    }

    protected function getLateCheckOutPriceForRoomType($roomType)
    {
        // Retrieve the late check-out price for the given room type
        return RoomPrice::where('room_type', $roomType)->value('late_check_out_price');
    }
    public function calculateInvoice($rooms, $companionsCount, $nightsCovered, $roomTypeCovered, $conference_id = null)
    {
        $totalInvoice = 0;
        $roomInvoices = [];

        foreach ($rooms as $index => $room) {
            // Get the base price for the room type
            $basePrice = $this->getBasePriceForRoomType($room['room_type']);
            $baseCoveredPrice = $this->getBasePriceForRoomType($roomTypeCovered);
            $nights = $room['total_nights'];

            // Calculate covered nights deduction only for the first room
            $coveredCost = 0;
            if ($index === 0) {
                $coveredCost = min($nightsCovered, $nights) * $baseCoveredPrice;
            }

            // Calculate the total room cost
            $roomCost = max(0, ($basePrice * $nights) - $coveredCost);

            // Add the room invoice to the list
            $roomInvoices[] = [
                'room_type' => $room['room_type'],
                'base_price' => $basePrice,
                'total_cost' => $roomCost,
                'covered_cost' => $coveredCost,
            ];

            // Add the room cost to the total invoice
            $totalInvoice += $roomCost;
        }

        // If there's a conference, add conference-related costs (optional)
        if ($conference_id) {
            $conferenceCost = 0; // Assume conference cost logic is handled elsewhere
            $totalInvoice += $conferenceCost;
        }

        return [
            'total_invoice' => $totalInvoice,
            'room_invoices' => $roomInvoices,
        ];
    }
    public function createReservation(Request $request)
    {
        $user_id = Auth::id(); // Get user_id from the token

        try {
            // Validate the request data
            $validatedData = $request->validate([
                'conference_id' => 'nullable|exists:conferences,id',
                'companions_count' => 'nullable|integer|min:0',
                'companions_names' => 'nullable|string',
                'update_deadline' => 'nullable|date',
                'rooms' => 'required|array',
                'rooms.*.room_type' => 'required|string',
                'rooms.*.occupant_name' => 'nullable|string',
                'rooms.*.check_in_date' => 'required|date',
                'rooms.*.check_out_date' => 'required|date|after:rooms.*.check_in_date',
                'rooms.*.total_nights' => 'required|integer|min:1',
                'rooms.*.cost' => 'required|numeric|min:0',
                'rooms.*.additional_cost' => 'nullable|numeric|min:0',
                'rooms.*.early_check_in' => 'nullable|boolean',
                'rooms.*.late_check_out' => 'nullable|boolean',
            ]);

            $conference_id = $validatedData['conference_id'] ?? null;

            // Retrieve speaker details
            $speaker = Speaker::where('user_id', $user_id)->first();

            if ($speaker) {
                $nightsCovered = $speaker->nights_covered;
                $roomTypeCovered = $speaker->room_type;
            } else {
                $nightsCovered = 0;
                $roomTypeCovered = 'Single';
            }


            // Call calculateInvoice method to get the total invoice and room-wise breakdown
            $invoiceDetails = $this->calculateInvoice(
                $validatedData['rooms'],
                $validatedData['companions_count'] ?? 0,
                $nightsCovered,
                $roomTypeCovered,
                $conference_id
            );
            $totalInvoice = $invoiceDetails['total_invoice'];
            $roomInvoices = $invoiceDetails['room_invoices'];

            // Create the reservation record
            $reservation = Reservation::create([
                'user_id' => $user_id,
                'conference_id' => $conference_id,
                'room_count' => count($validatedData['rooms']),
                'companions_count' => $validatedData['companions_count'] ?? 0,
                'companions_names' => $validatedData['companions_names'] ?? null,
                'update_deadline' => $validatedData['update_deadline'] ?? Carbon::now()->addDays(30),
                'total_invoice' => $totalInvoice,
            ]);

            // Prepare and save room data
            $roomsData = [];
            foreach ($validatedData['rooms'] as $index => $room) {
                $roomsData[] = [
                    'reservation_id' => $reservation->id,
                    'room_type' => $room['room_type'],
                    'occupant_name' => $room['occupant_name'],
                    'special_requests' => $request->input("rooms.$index.special_requests", null),
                    'check_in_date' => $room['check_in_date'],
                    'check_out_date' => $room['check_out_date'],
                    'total_nights' => $room['total_nights'],
                    'cost' => $room['cost'],
                    'additional_cost' => $room['additional_cost'] ?? 0.00,
                    'early_check_in' => $room['early_check_in'] ?? false,
                    'late_check_out' => $room['late_check_out'] ?? false,
                    'update_deadline' => $request->input("rooms.$index.update_deadline", Carbon::now()->addDays(30)),
                    'user_type' => $index === 0 ? 'main' : 'companion',
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }

            // Insert room data into the database
            Room::insert($roomsData);

            // Retrieve room IDs
            $rooms = Room::where('reservation_id', $reservation->id)->get();

            // Map the room IDs to the invoice details
            foreach ($roomInvoices as $index => $roomInvoice) {
                $roomInvoice['room_id'] = $rooms[$index]->id;
                $roomInvoices[$index] = $roomInvoice;

                // Insert the room invoice details into the reservation_invoices table
                ReservationInvoice::create([
                    'room_id' => $roomInvoice['room_id'],
                    'price' => $roomInvoice['base_price'],
                    'additional_price' => $roomInvoice['additional_cost'] ?? 0,
                    'total' => $roomInvoice['total_cost'],
                    'status' => 'pending',
                ]);
            }

            // Return the response
            return response()->json([
                'message' => 'Reservation and rooms created successfully.',
                'reservation_id' => $reservation->id,
                'total_invoice' => $totalInvoice,
                'room_invoices' => $roomInvoices,
                'rooms' => $roomsData,
                'nightsCovered' => $nightsCovered,
                'roomTypeCovered' => $roomTypeCovered,
            ], 201);

        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to create reservation. ' . $e->getMessage()], 400);
        }
    }
    public function editReservation(Request $request)
{
    $user_id = Auth::id(); // Get user_id from the token

    try {
        // Validate the request data
        $validatedData = $request->validate([
            'reservation_id' => 'required|exists:reservations,id', // Ensure the reservation exists
            'conference_id' => 'nullable|exists:conferences,id',
            'companions_count' => 'nullable|integer|min:0',
            'companions_names' => 'nullable|string',
            'update_deadline' => 'nullable|date',
            'rooms' => 'required|array',
            'rooms.*.id' => 'required|exists:rooms,id', // Ensure the room exists
            'rooms.*.room_type' => 'required|string',
            'rooms.*.occupant_name' => 'nullable|string',
            'rooms.*.check_in_date' => 'required|date',
            'rooms.*.check_out_date' => 'required|date|after:rooms.*.check_in_date',
            'rooms.*.total_nights' => 'required|integer|min:1',
            'rooms.*.cost' => 'required|numeric|min:0',
            'rooms.*.additional_cost' => 'nullable|numeric|min:0',
            'rooms.*.early_check_in' => 'nullable|boolean',
            'rooms.*.late_check_out' => 'nullable|boolean',
        ]);

        // Find the existing reservation
        $reservation = Reservation::findOrFail($validatedData['reservation_id']);
        $conference_id = $validatedData['conference_id'] ?? $reservation->conference_id;

        // Retrieve speaker details
        $speaker = Speaker::where('user_id', $user_id)->first();
        if (!$speaker) {
            return response()->json(['message' => 'Speaker not found.'], 404);
        }

        $nightsCovered = $speaker->nights_covered;
        $roomTypeCovered = $speaker->room_type;

        // Call calculateInvoice method to get the updated total invoice and room-wise breakdown
        $invoiceDetails = $this->calculateInvoice(
            $validatedData['rooms'],
            $validatedData['companions_count'] ?? 0,
            $nightsCovered,
            $roomTypeCovered,
            $conference_id
        );
        $totalInvoice = $invoiceDetails['total_invoice'];
        $roomInvoices = $invoiceDetails['room_invoices'];

        // Update the reservation record
        $reservation->update([
            'conference_id' => $conference_id,
            'room_count' => count($validatedData['rooms']),
            'companions_count' => $validatedData['companions_count'] ?? 0,
            'companions_names' => $validatedData['companions_names'] ?? null,
            'update_deadline' => $validatedData['update_deadline'] ?? Carbon::now()->addDays(30),
            'total_invoice' => $totalInvoice,
        ]);

        // Prepare and update room data
        $roomsData = [];
        foreach ($validatedData['rooms'] as $index => $room) {
            $existingRoom = Room::findOrFail($room['id']); // Find the existing room by ID

            // Update the room details
            $existingRoom->update([
                'room_type' => $room['room_type'],
                'occupant_name' => $room['occupant_name'],
                'special_requests' => $request->input("rooms.$index.special_requests", null),
                'check_in_date' => $room['check_in_date'],
                'check_out_date' => $room['check_out_date'],
                'total_nights' => $room['total_nights'],
                'cost' => $room['cost'],
                'additional_cost' => $room['additional_cost'] ?? 0.00,
                'early_check_in' => $room['early_check_in'] ?? false,
                'late_check_out' => $room['late_check_out'] ?? false,
                'update_deadline' => $request->input("rooms.$index.update_deadline", Carbon::now()->addDays(30)),
                'user_type' => $index === 0 ? 'main' : 'companion',
                'updated_at' => now(),
            ]);

            // Prepare updated room data for the response
            $roomsData[] = $existingRoom;
        }

        // Retrieve the room IDs again after the update
        $rooms = Room::where('reservation_id', $reservation->id)->get();

        // Update the room invoices
        foreach ($roomInvoices as $index => $roomInvoice) {
            $roomInvoice['room_id'] = $rooms[$index]->id;
            $roomInvoices[$index] = $roomInvoice;

            // Update the room invoice details in the reservation_invoices table
            $invoice = ReservationInvoice::where('room_id', $roomInvoice['room_id'])->first();
            if ($invoice) {
                $invoice->update([
                    'price' => $roomInvoice['base_price'],
                    'additional_price' => $roomInvoice['additional_cost'] ?? 0,
                    'total' => $roomInvoice['total_cost'],
                    'status' => 'pending',
                ]);
            }
        }

        // Return the response
        return response()->json([
            'message' => 'Reservation and rooms updated successfully.',
            'reservation_id' => $reservation->id,
            'total_invoice' => $totalInvoice,
            'room_invoices' => $roomInvoices,
            'rooms' => $roomsData,
            'nightsCovered' => $nightsCovered,
            'roomTypeCovered' => $roomTypeCovered,
        ], 200);

    } catch (\Exception $e) {
        return response()->json(['message' => 'Failed to update reservation. ' . $e->getMessage()], 400);
    }
}

    // public function editReservation(Request $request)
    // {
    //     $user_id = Auth::id();
    
    //     try {
    //         // Validate the request data
    //         $validatedData = $request->validate([
    //             'reservation_id' => 'required|exists:reservations,id',
    //             'conference_id' => 'nullable|exists:conferences,id',
    //             'rooms' => 'required|array',
    //             'rooms.*.id' => 'required|exists:rooms,id',
    //             'rooms.*.room_type' => 'required|string',
    //             'rooms.*.occupant_name' => 'nullable|string',
    //             'rooms.*.check_in_date' => 'required|date',
    //             'rooms.*.check_out_date' => 'required|date|after:rooms.*.check_in_date',
    //             'rooms.*.total_nights' => 'required|integer|min:1',
    //             'rooms.*.early_check_in' => 'nullable|boolean',
    //             'rooms.*.late_check_out' => 'nullable|boolean',
    //         ]);
    
    //         // Find the reservation
    //         $reservation = Reservation::findOrFail($validatedData['reservation_id']);
    //         $conference_id = $validatedData['conference_id'] ?? $reservation->conference_id;
    
    //         // Update room details and collect room data for invoice calculation
    //         $roomsData = [];
    //         $nightsCovered = 0; // Assuming you want to set a value for covered nights if needed
    //         $roomTypeCovered = ''; // Set room type that is covered, if applicable
    
    //         foreach ($validatedData['rooms'] as $room) {
    //             $existingRoom = Room::findOrFail($room['id']);
    
    //             // Update the room details
    //             $existingRoom->update([
    //                 'room_type' => $room['room_type'],
    //                 'occupant_name' => $room['occupant_name'],
    //                 'check_in_date' => $room['check_in_date'],
    //                 'check_out_date' => $room['check_out_date'],
    //                 'total_nights' => $room['total_nights'],
    //                 'early_check_in' => $room['early_check_in'] ?? false,
    //                 'late_check_out' => $room['late_check_out'] ?? false,
    //             ]);
    
    //             // Prepare data for the invoice calculation
    //             $roomsData[] = [
    //                 'id' => $existingRoom->id,
    //                 'room_type' => $room['room_type'],
    //                 'occupant_name' => $room['occupant_name'],
    //                 'check_in_date' => $room['check_in_date'],
    //                 'check_out_date' => $room['check_out_date'],
    //                 'total_nights' => $room['total_nights'],
    //                 'early_check_in' => $room['early_check_in'] ?? false,
    //                 'late_check_out' => $room['late_check_out'] ?? false,
    //             ];
    //         }
    
    //         // Calculate the updated invoices (ensure you pass the necessary parameters)
    //         $companionsCount = 0; // Adjust this as needed for your logic
    //         $invoiceData = $this->calculateInvoice($roomsData, $companionsCount, $nightsCovered, $roomTypeCovered, $conference_id);
    
    //         // Update room invoices in the database
    //         foreach ($invoiceData['room_invoices'] as $key => $roomInvoice) {
    //             $roomId = $validatedData['rooms'][$key]['id'];
    //             $invoice = ReservationInvoice::where('room_id', $roomId)->first();
    //             if ($invoice) {
    //                 $invoice->update([
    //                     'price' => $roomInvoice['base_price'],
    //                     'total' => $roomInvoice['total_cost'],
    //                 ]);
    //             }
    //         }
    
    //         // Return the response with the required format
    //         return response()->json([
    //             'message' => 'Reservation and rooms updated successfully.',
    //             'reservation_id' => $reservation->id,
    //             'total_invoice' => $invoiceData['total_invoice'],
    //             'room_invoices' => $invoiceData['room_invoices'],
    //             'rooms' => $roomsData,
    //         ], 200);
    
    //     } catch (\Exception $e) {
    //         // Return a failure response if any exception occurs
    //         return response()->json([
    //             'message' => 'Failed to update reservation. ' . $e->getMessage(),
    //         ], 400);
    //     }
    // }
    
    // public function editReservation(Request $request)
    // {
    //     $user_id = Auth::id();

    //     try {
    //         // Validate the request data
    //         $validatedData = $request->validate([
    //             'reservation_id' => 'required|exists:reservations,id',
    //             'conference_id' => 'nullable|exists:conferences,id',
    //             'rooms' => 'required|array',
    //             'rooms.*.id' => 'required|exists:rooms,id',
    //             'rooms.*.room_type' => 'required|string',
    //             'rooms.*.occupant_name' => 'nullable|string',
    //             'rooms.*.check_in_date' => 'required|date',
    //             'rooms.*.check_out_date' => 'required|date|after:rooms.*.check_in_date',
    //             'rooms.*.total_nights' => 'required|integer|min:1',
    //             'rooms.*.early_check_in' => 'nullable|boolean',
    //             'rooms.*.late_check_out' => 'nullable|boolean',
    //         ]);

    //         // Find the reservation
    //         $reservation = Reservation::findOrFail($validatedData['reservation_id']);
    //         $conference_id = $validatedData['conference_id'] ?? $reservation->conference_id;

    //         // Update room details and collect room data for invoice calculation
    //         $roomsData = [];
    //         foreach ($validatedData['rooms'] as $room) {
    //             $existingRoom = Room::findOrFail($room['id']);

    //             // Update the room details
    //             $existingRoom->update([
    //                 'room_type' => $room['room_type'],
    //                 'occupant_name' => $room['occupant_name'],
    //                 'check_in_date' => $room['check_in_date'],
    //                 'check_out_date' => $room['check_out_date'],
    //                 'total_nights' => $room['total_nights'],
    //                 'early_check_in' => $room['early_check_in'] ?? false,
    //                 'late_check_out' => $room['late_check_out'] ?? false,
    //             ]);

    //             // Prepare data for the invoice calculation
    //             $roomsData[] = [
    //                 'id' => $existingRoom->id,
    //                 'room_type' => $room['room_type'],
    //                 'occupant_name' => $room['occupant_name'],
    //                 'check_in_date' => $room['check_in_date'],
    //                 'check_out_date' => $room['check_out_date'],
    //                 'total_nights' => $room['total_nights'],
    //                 'early_check_in' => $room['early_check_in'] ?? false,
    //                 'late_check_out' => $room['late_check_out'] ?? false,
    //             ];
    //         }

    //         // Calculate the updated invoices
    //         $companionsCount = 0; // Adjust based on your logic
    //         $invoiceData = $this->calculateInvoice($roomsData, $companionsCount, $conference_id);

    //         // Update room invoices in the database
    //         foreach ($invoiceData['room_invoices'] as $key => $roomInvoice) {
    //             $roomId = $validatedData['rooms'][$key]['id'];
    //             $invoice = ReservationInvoice::where('room_id', $roomId)->first();
    //             if ($invoice) {
    //                 $invoice->update([
    //                     'price' => $roomInvoice['base_price'],
    //                     'early_check_in_price' => $roomInvoice['early_check_in_price'],
    //                     'late_check_out_price' => $roomInvoice['late_check_out_price'],
    //                     'total' => $roomInvoice['total_cost'],
    //                 ]);
    //             }
    //         }

    //         // Return the response with the required format
    //         return response()->json([
    //             'message' => 'Reservation and rooms updated successfully.',
    //             'reservation_id' => $reservation->id,
    //             'total_invoice' => $invoiceData['total_invoice'],
    //             'room_invoices' => $invoiceData['room_invoices'],
    //             'rooms' => $roomsData,
    //         ], 200);

    //     } catch (\Exception $e) {
    //         // Return a failure response if any exception occurs
    //         return response()->json([
    //             'message' => 'Failed to update reservation. ' . $e->getMessage(),
    //         ], 400);
    //     }
    // }


  public function updateReservation(Request $request, $id)
    {
        try {
            // الحصول على الحجز الحالي
            $reservation = Reservation::findOrFail($id);

            // التحقق إذا كان قد تم تجاوز الموعد النهائي للتحديث
            if ($reservation->update_deadline && now()->greaterThan($reservation->update_deadline)) {
                return response()->json([
                    'error' => 'The reservation cannot be updated because the deadline has passed.',
                ], 403); // إرسال خطأ إذا تم تجاوز الموعد النهائي
            }

            // تحقق من القيم المدخلة لتحديث الحجز
            $dataToUpdate = [
                'room_count' => $request->input('room_count', $reservation->room_count),
                'companions_count' => $request->input('companions_count', $reservation->companions_count),
                'companions_names' => $request->input('companions_names', $reservation->companions_names),
                'update_deadline' => $request->input('update_deadline', $reservation->update_deadline),
            ];

            // تحديث الحجز باستخدام القيم المحدثة
            $reservation->update($dataToUpdate);

            // تحديث بيانات الغرف المرتبطة بالحجز
            if ($request->has('rooms')) {
                foreach ($request->input('rooms') as $roomData) {
                    // العثور على الغرفة بناءً على ID الغرفة
                    $roomId = $roomData['id'] ?? null; // تأكد من وجود ID الغرفة
                    if ($roomId) {
                        $room = Room::find($roomId);
                        if ($room) {
                            // تحديث بيانات الغرفة
                            $room->update([
                                'room_type' => $roomData['room_type'] ?? $room->room_type,
                                'occupant_name' => $roomData['occupant_name'] ?? $room->occupant_name,
                                'check_in_date' => $roomData['check_in_date'] ?? $room->check_in_date,
                                'check_out_date' => $roomData['check_out_date'] ?? $room->check_out_date,
                                'total_nights' => $roomData['total_nights'] ?? $room->total_nights,
                                'cost' => $roomData['cost'] ?? $room->cost,
                                'additional_cost' => $roomData['additional_cost'] ?? $room->additional_cost,
                                'update_deadline' => $roomData['update_deadline'] ?? $room->update_deadline,
                            ]);
                        }
                    } else {
                        // إذا لم يكن هناك ID للغرفة، يمكنك إضافة منطق لإضافة غرفة جديدة
                        Room::create([
                            'reservation_id' => $reservation->id, // تمرير ID الحجز
                            'room_type' => $roomData['room_type'],
                            'occupant_name' => $roomData['occupant_name'],
                            'check_in_date' => $roomData['check_in_date'],
                            'check_out_date' => $roomData['check_out_date'],
                            'total_nights' => $roomData['total_nights'],
                            'cost' => $roomData['cost'],
                            'additional_cost' => $roomData['additional_cost'] ?? 0.00,
                            'update_deadline' => $roomData['update_deadline'] ?? Carbon::now()->addDays(30),
                        ]);
                    }
                }
            }

            return response()->json([
                'message' => 'Reservation and rooms updated successfully!',
                'reservation' => $reservation
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while updating the reservation.',
                'message' => $e->getMessage()
            ], 400);
        }
    }



    public function deleteReservation($id)
    {
        try {
            // إيجاد الحجز بالمعرف (id)
            $reservation = Reservation::find($id);

            // التحقق إذا كان الحجز موجوداً
            if (!$reservation) {
                return response()->json([
                    'error' => 'Reservation not found.'
                ], 404);
            }

            // حذف الحجز، مما سيؤدي تلقائياً إلى حذف الغرف المرتبطة بفضل onDelete('cascade')
            $reservation->delete();

            // إرسال إشعار إلى جميع الإداريين
            $admins = User::where('isAdmin', true)->get(); // افترض أن لديك نموذج User
            foreach ($admins as $admin) {
                // إنشاء إشعار وحفظه في جدول notifications
                $notification = Notification::create([
                    'user_id' => $admin->id, // استخدام معرف الإداري
                    'message' => 'Reservation ID ' . $reservation->id . ' has been deleted.',
                    'is_read' => false,
                ]);
                broadcast(new NotificationSent($notification))->toOthers();
            }

            return response()->json([
                'message' => 'Reservation deleted successfully!',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'error' => 'An error occurred while deleting the reservation.',
                'message' => $e->getMessage()
            ], 400);
        }
    }

    public function updateDeadlineByAdmin(Request $request, $id)
    {
        try {
            $reservation = Reservation::findOrFail($id);

            $request->validate([
                'update_deadline' => 'required|date'
            ]);

            $reservation->update([
                'update_deadline' => $request->input('update_deadline')
            ]);

            return response()->json([
                'message' => 'Reservation deadline updated successfully!',
                'reservation' => $reservation
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'error' => 'An error occurred while updating the reservation deadline.',
                'message' => $e->getMessage()
            ], 400);
        }
    }




    public function getReservationsByUserId(Request $request)
    {
        try {
            $user_id = Auth::id();

            $reservations = Reservation::where('user_id', $user_id)->get();

            if ($reservations->isEmpty()) {
                return response()->json([
                    'message' => 'No reservations found for this user.'
                ], 404);
            }

            return response()->json([
                'reservations' => $reservations
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while retrieving reservations.',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function getAllReservations()
    {
        try {

            $reservations = Reservation::all();

            if ($reservations->isEmpty()) {
                return response()->json([
                    'message' => 'No reservations found.'
                ], 404);
            }

            return response()->json([
                'reservations' => $reservations
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while retrieving reservations.',
                'message' => $e->getMessage()
            ], 500);
        }
    }
    public function getReservationsByUserAndConference($conferenceId)
    {
        // جلب user_id من المستخدم المصادق عليه
        $userId = Auth::id();

        // جلب الحجوزات بناءً على user_id و conference_id مع إضافة العلاقة مع الغرف والفواتير
        $reservations = Reservation::where('user_id', $userId)
            ->where('conference_id', $conferenceId)
            ->with(['rooms.reservationInvoices'])  // تحميل الفواتير المرتبطة بالغرف
            ->get();

        return response()->json([
            'status' => 'success',
            'data' => $reservations,
        ]);
    }





    public function getAllReservationsWithRooms(Request $request)
    {
        try {
            $perPage = $request->query('perPage', 10);
    
            // Include the user details (name and email) along with rooms and reservation invoices
            $reservations = Reservation::with(['rooms.reservationInvoices', 'user:id,name,email,registration_type'])->paginate($perPage);
    
            if ($reservations->isEmpty()) {
                return response()->json([
                    'message' => 'No reservations found.',
                ], 404);
            }
    
            return response()->json([
                'message' => 'Reservations, room, and invoice details retrieved successfully.',
                'reservations' => $reservations->items(),
                'currentPage' => $reservations->currentPage(),
                'totalPages' => $reservations->lastPage(),
                'totalReservations' => $reservations->total(),
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve reservations, room, and invoice details. ' . $e->getMessage(),
            ], 500);
        }
    }
    
}
