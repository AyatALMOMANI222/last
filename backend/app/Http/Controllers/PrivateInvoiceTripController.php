<?php

namespace App\Http\Controllers;

use App\Models\PrivateInvoiceTrip;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PrivateInvoiceTripController extends Controller
{
    // Store method to create a new PrivateInvoiceTrip
    public function store(Request $request)
    {
        // Validate the incoming request data
        $validator = Validator::make($request->all(), [
            'participant_id' => 'required|exists:trip_participants,id', // Ensure participant_id exists in the trip_participants table
            'base_price' => 'required|numeric',
            'options_price' => 'required|numeric',
            'total_price' => 'required|numeric'
        ]);

        // If validation fails, return errors
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 400);
        }

        // Create a new PrivateInvoiceTrip record
        $privateInvoiceTrip = PrivateInvoiceTrip::create([
            'participant_id' => $request->participant_id,
            'base_price' => $request->base_price,
            'options_price' => $request->options_price,
            'total_price' => $request->total_price
        ]);

        // Return a success response with the created resource
        return response()->json([
            'success' => true,
            'data' => $privateInvoiceTrip
        ], 201);
    }


public function getInvoiceByParticipantId($participant_id)
    {
        // تحقق من وجود الفواتير للمشارك باستخدام الـ participant_id
        $privateInvoiceTrips = PrivateInvoiceTrip::where('participant_id', $participant_id)->get();
    
        // إذا لم يتم العثور على أي فاتورة، أرجع استجابة بأن العنصر غير موجود
        if ($privateInvoiceTrips->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'No invoices found for this participant.'
            ], 404);
        }
    
        // إرجاع الفواتير بنجاح
        return response()->json([
            'success' => true,
            'data' => $privateInvoiceTrips
        ], 200);
    }


}
