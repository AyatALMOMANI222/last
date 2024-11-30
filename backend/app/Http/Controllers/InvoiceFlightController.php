<?php

namespace App\Http\Controllers;

use App\Models\InvoiceFlight;
use Illuminate\Http\Request;
use App\Models\AcceptedFlight;
use App\Models\Flight;
use App\Models\Notification;

class InvoiceFlightController extends Controller
{
    public function store(Request $request)
    {
        // Step 1: Initialize an array to store the generated invoices
        $invoices = [];

        // Step 2: Loop through each flight_id in the provided array
        foreach ($request->flight_id as $flightId) {
            // Get data from the AcceptedFlight table by flight_id
            $acceptedFlight = AcceptedFlight::where('flight_id', $flightId)->first();

            // Check if AcceptedFlight exists for the given flight_id
            if (!$acceptedFlight) {
                return response()->json(['error' => "Accepted flight not found for flight_id: $flightId"], 404);
            }

            // Get the price from the AcceptedFlight
            $price = $acceptedFlight->price;

            // Get the Flight data
            $flight = Flight::where('flight_id', $flightId)->first();

            // Check if Flight exists for the given flight_id
            if (!$flight) {
                return response()->json(['error' => "Flight not found for flight_id: $flightId"], 404);
            }

            // Step 3: Calculate the total price based on flight information
            $calculatedPrice = $price; // Start with the price from AcceptedFlight

            // Conditionally add costs based on the flight's upgrade_class
            if ($flight->upgrade_class != 0 && $flight->business_class_upgrade_cost) {
                $calculatedPrice += $flight->business_class_upgrade_cost;
            }

            // Always include the reserved seat, additional baggage, and other additional costs if available
            if ($flight->reserved_seat_cost) {
                $calculatedPrice += $flight->reserved_seat_cost;
            }

            if ($flight->additional_baggage_cost) {
                $calculatedPrice += $flight->additional_baggage_cost;
            }

            if ($flight->other_additional_costs) {
                $calculatedPrice += $flight->other_additional_costs;
            }

            // Step 4: Create and save the InvoiceFlight record
            $invoiceFlight = new InvoiceFlight();
            $invoiceFlight->flight_id = $flight->flight_id;
            $invoiceFlight->total_price = $calculatedPrice;
            $invoiceFlight->status = 'pending'; // Default status, can be updated as needed
            $invoiceFlight->save();

            // Add the generated invoice to the invoices array
            $invoices[] = $invoiceFlight;

            // Step 5: Create a notification (optional)
            Notification::create([
                'user_id' => $flight->user_id || "null", // Assuming the flight has a user_id
                'message' => 'Invoice for flight ' . $flight->flight_number . ' has been created.',
                'type' => 'invoice',
                'status' => 'unread',
            ]);
        }

        // Step 6: Return a response with the created invoices data
        return response()->json([
            'success' => true,
            'invoices' => $invoices,
        ]);
    }
}
