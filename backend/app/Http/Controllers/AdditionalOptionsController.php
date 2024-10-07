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
        ]);
    
        try {
            // Create a new additional option without timestamps
            $additionalOption = AdditionalOption::create([
                'trip_id' => $request->trip_id,
                'option_name' => $request->option_name,
                'option_description' => $request->option_description,
                'price' => $request->price,
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
}
