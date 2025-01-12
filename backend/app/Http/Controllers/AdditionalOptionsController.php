<?php

namespace App\Http\Controllers;

use App\Models\AdditionalOption;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Auth;

class AdditionalOptionsController extends Controller
{
    /**
     * Store a new additional option.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // Validate the input
        $request->validate([
            'trip_id' => 'required|exists:trips,id',
            'option_name' => 'required|string|max:255',
            'option_description' => 'nullable|string',
            'price' => 'required|numeric|min:0',
            'multiply_by_nights' => 'required|boolean', // Add validation for multiply_by_nights
        ]);
    
        try {
            // Create a new additional option
            $additionalOption = AdditionalOption::create([
                'trip_id' => $request->trip_id,
                'option_name' => $request->option_name,
                'option_description' => $request->option_description,
                'price' => $request->price,
                'multiply_by_nights' => $request->multiply_by_nights, // Include the field
            ]);
    
            return response()->json([
                'message' => 'The additional option has been successfully added.',
                'data' => $additionalOption
            ], 201);
        } catch (QueryException $e) {
            return response()->json([
                'message' => 'An error occurred while adding the additional option.',
                'error' => $e->getMessage()
            ], 500);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'An unexpected error occurred.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
    
    


    public function getAdditionalOptionsByTripId($trip_id)
    {
        try {
            $additionalOptions = AdditionalOption::where('trip_id', $trip_id)->get();

            if ($additionalOptions->isEmpty()) {
                return response()->json([
                    'message' => 'No additional options found for this trip.',
                ], 404);
            }

            return response()->json([
                'message' => 'Additional options retrieved successfully.',
                'data' => $additionalOptions
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'An unexpected error occurred.',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function updateSelectedOptionsPrices(Request $request, $trip_id)
{
    // Validate the request data
    $request->validate([
        'options' => 'required|array',  // Ensure 'options' is an array
        'options.*.id' => 'required|exists:additional_options,id', // Validate each option ID
        'options.*.price' => 'required|numeric|min:0',  // Validate the price for each option
    ]);

    try {
        $updatedOptions = [];

        // Loop through the options provided in the request
        foreach ($request->options as $optionData) {
            $option = AdditionalOption::where('trip_id', $trip_id)
                ->where('id', $optionData['id'])
                ->first();

            // Check if option exists for the given trip
            if ($option) {
                $option->price = $optionData['price'];  // Update the price
                $option->save();  // Save the updated option
                $updatedOptions[] = $option;  // Collect updated options for the response
            }
        }

        // Check if any options were updated
        if (count($updatedOptions) > 0) {
            return response()->json([
                'message' => 'Prices updated successfully for selected options.',
                'data' => $updatedOptions,
            ], 200);
        } else {
            return response()->json([
                'message' => 'No matching options found for the given trip ID and option IDs.',
            ], 404);
        }
    } catch (\Exception $e) {
        return response()->json([
            'message' => 'An unexpected error occurred.',
            'error' => $e->getMessage(),
        ], 500);
    }
}

}
