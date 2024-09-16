<?php

namespace App\Http\Controllers;

use App\Models\ConferencePrice;
use Illuminate\Http\Request;

class PricesController extends Controller
{
    public function store (Request $request, $conferenceId)
{
    $validatedData = $request->validate([
        'price_type' => 'required|string|max:255',
        'price' => 'required|numeric',
        'description' => 'nullable|string',
    ]);

    $conferencePrice = new ConferencePrice();
    $conferencePrice->conference_id = $conferenceId;
    $conferencePrice->price_type = $validatedData['price_type'];
    $conferencePrice->price = $validatedData['price'];
    $conferencePrice->description = $validatedData['description'] ?? null;

    $conferencePrice->save();

    return response()->json([
        'message' => 'Price added successfully!',
        'data' => $conferencePrice
    ], 201);
}
public function deletePriceByConferenceId($conferenceId, $priceId)
{
    $conferencePrice = ConferencePrice::where('conference_id', $conferenceId)
                                       ->where('id', $priceId)
                                       ->firstOrFail();

    $conferencePrice->delete();

    return response()->json([
        'message' => 'Price deleted successfully!'
    ], 200);
}
public function getPricesByConferenceId($conferenceId)
{
    $conferencePrices = ConferencePrice::where('conference_id', $conferenceId)->get();

    if ($conferencePrices->isEmpty()) {
        return response()->json([
            'message' => 'No prices found for this conference.'
        ], 404);
    }

    return response()->json([
        'message' => 'Prices retrieved successfully!',
        'data' => $conferencePrices
    ], 200);
}

}


