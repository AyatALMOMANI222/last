<?php

namespace App\Http\Controllers;

use App\Models\ConferenceTrip;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException; 

class ConferenceTripController extends Controller
{
    /**
     * Store a trip in a conference.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // Validate the input
        $request->validate([
            'conference_id' => 'required|exists:conferences,id',
            'trip_id' => 'required|exists:trips,id',
        ]);

        try {
            // Create a new record in the conference_trip table
            $conferenceTrip = ConferenceTrip::create([
                'conference_id' => $request->conference_id,
                'trip_id' => $request->trip_id,
            ]);

            return response()->json([
                'message' => 'The trip has been successfully added to the conference.',
                'data' => $conferenceTrip
            ], 201);
        } catch (QueryException $e) {
            return response()->json([
                'message' => 'An error occurred while adding the trip to the conference.',
                'error' => $e->getMessage()
            ], 500);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'An unexpected error occurred.',
                'error' => $e->getMessage()
            ], 500);
        }
    }





    public function getTripsByConferenceId($conferenceId, $tripType)
    {
        try {
            // الحصول على الرحلات المرتبطة بالمؤتمر بناءً على نوع الرحلة
            $trips = ConferenceTrip::with('trip') // Assuming you have a 'trip' relationship
                ->where('conference_id', $conferenceId)
                ->whereHas('trip', function($query) use ($tripType) {
                    $query->where('trip_type', $tripType);
                })
                ->get();

            if ($trips->isEmpty()) {
                return response()->json([
                    'message' => 'No trips found for this conference with the specified trip type.'
                ], 404);
            }

            return response()->json([
                'message' => 'Trips retrieved successfully.',
                'data' => $trips
            ], 200);
        } catch (QueryException $e) {
            return response()->json([
                'message' => 'An error occurred while retrieving trips.',
                'error' => $e->getMessage()
            ], 500);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'An unexpected error occurred.',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    
    public function destroy($conferenceId, $tripId)
    {
        try {
            // تحقق مما إذا كانت الرحلة مرتبطة بالمؤتمر
            $conferenceTrip = ConferenceTrip::where('conference_id', $conferenceId)
                ->where('trip_id', $tripId)
                ->first();
    
            // إذا لم يتم العثور على السجل، أعد رد 404
            if (!$conferenceTrip) {
                return response()->json([
                    'message' => 'The specified trip does not exist for this conference.'
                ], 404);
            }
    
            // حذف السجل
            $conferenceTrip->delete();
    
            return response()->json([
                'message' => 'The trip has been successfully removed from the conference.'
            ], 200);
        } catch (QueryException $e) {
            return response()->json([
                'message' => 'An error occurred while removing the trip from the conference.',
                'error' => $e->getMessage()
            ], 500);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'An unexpected error occurred.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
    
}
