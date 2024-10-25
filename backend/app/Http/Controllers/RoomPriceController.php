<?php



        namespace App\Http\Controllers;
        
        use App\Models\RoomPrice;
        use Illuminate\Http\Request;
        use Illuminate\Support\Facades\Auth;
        
        class RoomPriceController extends Controller
        {
          
            public function store(Request $request)
            {
                $userId = Auth::id();
                
                // التحقق من المدخلات
                $request->validate([
                    'conference_id' => 'required|integer', // إضافة التحقق من conference_id
                    'single_base_price' => 'required|numeric',
                    'single_companion_price' => 'required|numeric',
                    'single_early_check_in_price' => 'required|numeric',
                    'single_late_check_out_price' => 'required|numeric',
                    'double_base_price' => 'required|numeric',
                    'double_companion_price' => 'required|numeric',
                    'double_early_check_in_price' => 'required|numeric',
                    'double_late_check_out_price' => 'required|numeric',
                    'triple_base_price' => 'required|numeric',
                    'triple_companion_price' => 'required|numeric',
                    'triple_early_check_in_price' => 'required|numeric',
                    'triple_late_check_out_price' => 'required|numeric',
                ]);
            
                try {
                    // تخزين أسعار الغرف
                    RoomPrice::create([
                        'conference_id' => $request->conference_id,
                        'room_type' => 'Single',
                        'base_price' => $request->single_base_price,
                        'companion_price' => $request->single_companion_price,
                        'early_check_in_price' => $request->single_early_check_in_price,
                        'late_check_out_price' => $request->single_late_check_out_price,
                    ]);
            
                    RoomPrice::create([
                        'conference_id' => $request->conference_id,
                        'room_type' => 'Double',
                        'base_price' => $request->double_base_price,
                        'companion_price' => $request->double_companion_price,
                        'early_check_in_price' => $request->double_early_check_in_price,
                        'late_check_out_price' => $request->double_late_check_out_price,
                    ]);
            
                    RoomPrice::create([
                        'conference_id' => $request->conference_id,
                        'room_type' => 'Triple',
                        'base_price' => $request->triple_base_price,
                        'companion_price' => $request->triple_companion_price,
                        'early_check_in_price' => $request->triple_early_check_in_price,
                        'late_check_out_price' => $request->triple_late_check_out_price,
                    ]);
            
                    // استجابة ناجحة
                    return response()->json([
                        'success' => 'Room prices have been successfully added!'
                    ], 201);
                } catch (\Exception $e) {
                    // استجابة خطأ
                    return response()->json([
                        'error' => 'An error occurred while adding room prices.'
                    ], 500);
                }
            }
            
        }
        

