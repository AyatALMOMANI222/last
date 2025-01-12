<?php



namespace App\Http\Controllers;

use App\Models\RoomPrice;
use App\Models\Speaker;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RoomPriceController extends Controller
{
    public function store(Request $request)
    {
        $userId = Auth::id();

        // التحقق من المدخلات
        $request->validate([
            'conference_id' => 'required|integer',
            'single_base_price' => 'required|numeric',
            // 'single_companion_price' => 'required|numeric',
            'double_base_price' => 'required|numeric',
            // 'double_companion_price' => 'required|numeric',
            'triple_base_price' => 'required|numeric',
            // 'triple_companion_price' => 'required|numeric',
        ]);

        try {
            $existingPrices = RoomPrice::where('conference_id', $request->conference_id)->exists();

            // إذا كانت الأسعار موجودة مسبقاً، إرجاع رسالة خطأ
            if ($existingPrices) {
                return response()->json([
                    'error' => 'Prices for this conference have already been added.'
                ], 400);  // استجابة مع كود الخطأ 400 (Bad Request)
            }
            // تخزين أو تحديث أسعار الغرف
            RoomPrice::updateOrCreate(
                ['conference_id' => $request->conference_id, 'room_type' => 'Single'],
                [
                    'base_price' => $request->single_base_price,
                    'companion_price' => 0,
                    'early_check_in_price' => 0,
                    'late_check_out_price' => 0,
                ]
            );

            RoomPrice::updateOrCreate(
                ['conference_id' => $request->conference_id, 'room_type' => 'Double'],
                [
                    'base_price' => $request->double_base_price,
                    'companion_price' => 0,
                    'early_check_in_price' => 0,
                    'late_check_out_price' => 0,
                ]
            );

            RoomPrice::updateOrCreate(
                ['conference_id' => $request->conference_id, 'room_type' => 'Triple'],
                [
                    'base_price' => $request->triple_base_price,
                    'companion_price' =>0,
                    'early_check_in_price' => 0,
                    'late_check_out_price' => 0,
                ]
            );

            // استجابة ناجحة
            return response()->json([
                'success' => 'Room prices have been successfully updated or added!'
            ], 201);
        } catch (\Exception $e) {
            // استجابة خطأ
            return response()->json([
                'error' => 'An error occurred while adding or updating room prices.'
            ], 500);
        }
    }



    public function getPricesByConferenceId($conferenceId)
    {
        try {
            // Retrieve room prices filtered by conference_id
            $prices = RoomPrice::where('conference_id', $conferenceId)->get();

            // Check if any prices were found
            if ($prices->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No room prices found for this conference ID.'
                ], 404);
            }

            // Retrieve speakers associated with the conference
            $speakers = Speaker::where('conference_id', $conferenceId)->get();

            // Organize the data by room type
            $formattedData = [];
            foreach ($prices as $price) {
                switch ($price->room_type) {
                    case 'Single':
                        $formattedData['single_base_price'] = $price->base_price;
                        $formattedData['single_companion_price'] = $price->companion_price;
                        $formattedData['single_early_check_in_price'] = $price->early_check_in_price;
                        $formattedData['single_late_check_out_price'] = $price->late_check_out_price;
                        break;
                    case 'Double':
                        $formattedData['double_base_price'] = $price->base_price;
                        $formattedData['double_companion_price'] = $price->companion_price;
                        $formattedData['double_early_check_in_price'] = $price->early_check_in_price;
                        $formattedData['double_late_check_out_price'] = $price->late_check_out_price;
                        break;
                    case 'Triple':
                        $formattedData['triple_base_price'] = $price->base_price;
                        $formattedData['triple_companion_price'] = $price->companion_price;
                        $formattedData['triple_early_check_in_price'] = $price->early_check_in_price;
                        $formattedData['triple_late_check_out_price'] = $price->late_check_out_price;
                        break;
                }
            }

            // Get room_type and nights_covered from the first speaker (if available)
            if (!$speakers->isEmpty()) {
                $formattedData['room_type'] = $speakers->first()->room_type;
                $formattedData['nights_covered'] = $speakers->first()->nights_covered;
            } else {
                $formattedData['room_type'] = null; // or any default value
                $formattedData['nights_covered'] = null; // or any default value
            }

            // Return a successful response with the formatted room prices data
            return response()->json([
                'success' => true,
                'data' => $formattedData
            ], 200);
        } catch (\Exception $e) {
            // Return an error response with the actual error message
            return response()->json([
                'error' => 'An error occurred while fetching room prices.',
                'message' => $e->getMessage()
            ], 500);
        }
    }




}


