<?php

namespace App\Http\Controllers;

use App\Models\AdditionalOption;
use App\Models\ConferenceTrip;
use App\Models\Trip;
use App\Models\TripParticipant;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TripController extends Controller
{

    
    public function addTrip(Request $request)
    {
        $userId = Auth::id();
        if (!$userId) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
    
        try {
            // تحقق من صحة المدخلات
            $validatedData = $request->validate([
                'conference_id' => 'required|exists:conferences,id', // التأكد من وجود conference_id
                'trip_type' => 'required|in:private,group',
                'name' => 'nullable|string|max:255',  // اجعل name nullable
                'images' => 'nullable|array|max:5', // مجموعة من الصور
                'images.*' => 'image|mimes:jpeg,png,jpg,gif,svg|max:2048', // صور فردية
                'price_per_person' => 'nullable|numeric',
                'price_for_two' => 'nullable|numeric',
                'price_for_three_or_more' => 'nullable|numeric',
            ]);
    
            // تخزين الصور
            $imagePaths = [];
            if ($request->has('images')) {
                foreach ($request->images as $image) {
                    $imagePaths[] = $image->store('trip_images', 'public');
                }
            }
    
            // إنشاء الرحلة الجديدة
            $tripData = [
                'trip_type' => $validatedData['trip_type'],
                'name' => $validatedData['name'],
                'image_1' => $imagePaths[0] ?? null,
                'image_2' => $imagePaths[1] ?? null,
                'image_3' => $imagePaths[2] ?? null,
                'image_4' => $imagePaths[3] ?? null,
                'image_5' => $imagePaths[4] ?? null,
                'price_per_person' => $validatedData['price_per_person'],
                'price_for_two' => $validatedData['price_for_two'],
                'price_for_three_or_more' => $validatedData['price_for_three_or_more'],
            ];
    
            // إضافة الوصف والمعلومات الإضافية إذا كانت موجودة
            if ($request->filled('description')) {
                $tripData['description'] = $request->description;
            }
    
            if ($request->filled('additional_info')) {
                $tripData['additional_info'] = $request->additional_info;
            }
    
            // إنشاء الرحلة
            $trip = Trip::create($tripData);
    
            // إنشاء العلاقة باستخدام نموذج ConferenceTrip
            $conferenceTrip = new ConferenceTrip();
            $conferenceTrip->conference_id = $validatedData['conference_id'];
            $conferenceTrip->trip_id = $trip->id;
            $conferenceTrip->save();
    
            return response()->json([
                'message' => 'Trip added successfully and linked to conference',
                'trip' => $trip,
            ], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            // إرجاع رسالة الخطأ من عملية التحقق
            return response()->json(['error' => $e->validator->errors()], 422);
        } catch (\Exception $e) {
            // إرجاع رسالة الخطأ العامة
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
    
    public function addGroupTrip(Request $request)
    {
        $userId = Auth::id();
        if (!$userId) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        try {
            // تحقق من صحة المدخلات
            $validatedData = $request->validate([
                'trip_type' => 'required|in:private,group',
                'available_dates' => 'nullable|json',
                'location' => 'nullable|string|max:255',
                'duration' => 'nullable|integer',
                'inclusions' => 'nullable|string',
                'group_price_per_person' => 'required|numeric',
                'group_price_per_speaker' => 'nullable|numeric',
                'trip_details' => 'required|string',
                'group_accompanying_price' => 'nullable|numeric'
            ]);

            // إنشاء الرحلة الجديدة
            $trip = Trip::create([
                'trip_type' => $validatedData['trip_type'],
                'available_dates' => $validatedData['available_dates'],
                'location' => $validatedData['location'],
                'duration' => $validatedData['duration'],
                'inclusions' => $validatedData['inclusions'],
                'group_price_per_person' => $validatedData['group_price_per_person'],
                'group_price_per_speaker' => $validatedData['group_price_per_speaker'],
                'trip_details' => $validatedData['trip_details'],
                'group_accompanying_price'=> $validatedData['group_accompanying_price'],
            ]);

            return response()->json(['message' => 'Trip added successfully', 'trip' => $trip], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->validator->errors()->first()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
    public function getGroupTrips($conferenceId)
    {
        try {
            // استرجاع جميع الرحلات التي نوعها group و conference_id مطابق للمعطى
            $trips = Trip::where('trip_type', 'group')
                         ->where('conference_id', $conferenceId) // شرط conference_id
                         ->get();
    
            return response()->json(['trips' => $trips], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
    

    public function getAllTrips(Request $request)
    {
        try {
            // استرجاع جميع الرحلات الخاصة فقط
            $query = Trip::where('trip_type', 'private');
    
            // تصفية حسب اسم الرحلة إذا تم توفيره
            if ($request->has('name')) {
                $query->where('name', 'like', '%' . $request->input('name') . '%');
            }
    
            // استرجاع الرحلات
            $trips = $query->get();
    
            return response()->json(['trips' => $trips], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
    
    public function getTripById($id)
    {
        try {
            // Eager load additional options for the trip
            $trip = Trip::with('additionalOptions')->find($id);

            if (!$trip) {
                return response()->json(['error' => 'Trip not found'], 404);
            }

            // Get additional options associated with the trip
            $additionalOptions = $trip->additionalOptions;

            return response()->json([
                'trip' => $trip,
            ], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }

    public function updateTripById(Request $request, $id)
{
    $userId = Auth::id();
    if (!$userId) {
        return response()->json(['error' => 'Unauthorized'], 401);
    }

    try {
        // تحقق من وجود الرحلة
        $trip = Trip::find($id);
        if (!$trip) {
            return response()->json(['error' => 'Trip not found'], 404);
        }

        // تحقق من صحة المدخلات
        $validatedData = $request->validate([
            'trip_type' => 'sometimes|required|in:private,group',
            'name' => 'sometimes|nullable|string|max:255',
            'images' => 'sometimes|nullable|array|max:5', // مجموعة من الصور
            'images.*' => 'sometimes|image|mimes:jpeg,png,jpg,gif,svg|max:2048', // صور فردية
            'price_per_person' => 'sometimes|nullable|numeric',
            'price_for_two' => 'sometimes|nullable|numeric',
            'price_for_three_or_more' => 'sometimes|nullable|numeric',
            'description' => 'sometimes|nullable|string',
            'additional_info' => 'sometimes|nullable|string',
        ]);

        // تحديث الصور
        $imagePaths = [];
        if ($request->has('images')) {
            foreach ($request->images as $image) {
                $imagePaths[] = $image->store('trip_images', 'public');
            }
        }

        // تحديث بيانات الرحلة
        $trip->trip_type = $validatedData['trip_type'] ?? $trip->trip_type;
        $trip->name = $validatedData['name'] ?? $trip->name;
        $trip->image_1 = $imagePaths[0] ?? $trip->image_1;
        $trip->image_2 = $imagePaths[1] ?? $trip->image_2;
        $trip->image_3 = $imagePaths[2] ?? $trip->image_3;
        $trip->image_4 = $imagePaths[3] ?? $trip->image_4;
        $trip->image_5 = $imagePaths[4] ?? $trip->image_5;
        $trip->price_per_person = $validatedData['price_per_person'] ?? $trip->price_per_person;
        $trip->price_for_two = $validatedData['price_for_two'] ?? $trip->price_for_two;
        $trip->price_for_three_or_more = $validatedData['price_for_three_or_more'] ?? $trip->price_for_three_or_more;
        $trip->description = $validatedData['description'] ?? $trip->description;
        $trip->additional_info = $validatedData['additional_info'] ?? $trip->additional_info;

        // حفظ التعديلات
        $trip->save();

        return response()->json(['message' => 'Trip updated successfully', 'trip' => $trip], 200);
    } catch (\Illuminate\Validation\ValidationException $e) {
        return response()->json(['error' => $e->validator->errors()], 422);
    } catch (\Exception $e) {
        return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
    }
}


public function updateTripAndOptions(Request $request, $id)
{
    $userId = Auth::id();
    if (!$userId) {
        return response()->json(['error' => 'Unauthorized'], 401);
    }

    try {
        // تحقق من وجود الرحلة
        $trip = Trip::find($id);
        if (!$trip) {
            return response()->json(['error' => 'Trip not found'], 404);
        }

        // التحقق من صحة مدخلات تحديث الرحلة
        $validatedTripData = $request->validate([
            'trip_type' => 'sometimes|required|in:private,group',
            'name' => 'sometimes|nullable|string|max:255',
            'images' => 'sometimes|nullable|array|max:5', // مجموعة من الصور
            'images.*' => 'sometimes|image|mimes:jpeg,png,jpg,gif,svg|max:2048', // صور فردية
            'price_per_person' => 'sometimes|nullable|numeric',
            'price_for_two' => 'sometimes|nullable|numeric',
            'price_for_three_or_more' => 'sometimes|nullable|numeric',
            'description' => 'sometimes|nullable|string',
            'additional_info' => 'sometimes|nullable|string',
        ]);

        // تحديث الصور
        $imagePaths = [];
        if ($request->has('images')) {
            foreach ($request->images as $image) {
                $imagePaths[] = $image->store('trip_images', 'public');
            }
        }

        // تحديث بيانات الرحلة
        $trip->trip_type = $validatedTripData['trip_type'] ?? $trip->trip_type;
        $trip->name = $validatedTripData['name'] ?? $trip->name;
        $trip->image_1 = $imagePaths[0] ?? $trip->image_1;
        $trip->image_2 = $imagePaths[1] ?? $trip->image_2;
        $trip->image_3 = $imagePaths[2] ?? $trip->image_3;
        $trip->image_4 = $imagePaths[3] ?? $trip->image_4;
        $trip->image_5 = $imagePaths[4] ?? $trip->image_5;
        $trip->price_per_person = $validatedTripData['price_per_person'] ?? $trip->price_per_person;
        $trip->price_for_two = $validatedTripData['price_for_two'] ?? $trip->price_for_two;
        $trip->price_for_three_or_more = $validatedTripData['price_for_three_or_more'] ?? $trip->price_for_three_or_more;
        $trip->description = $validatedTripData['description'] ?? $trip->description;
        $trip->additional_info = $validatedTripData['additional_info'] ?? $trip->additional_info;

        // حفظ التعديلات على بيانات الرحلة
        $trip->save();

        $validatedOptionData = $request->validate([
            'options' => 'sometimes|array',
            'options.*.id' => 'sometimes|required|exists:additional_options,id',
            'options.*.price' => 'sometimes|required|numeric|min:0',
        ]);

        $updatedOptions = [];
        if (!empty($validatedOptionData['options'])) {
            foreach ($validatedOptionData['options'] as $optionData) {
                $option = AdditionalOption::where('trip_id', $id)
                    ->where('id', $optionData['id'])
                    ->first();

                if ($option) {
                    $option->price = $optionData['price'];
                    $option->save();
                    $updatedOptions[] = $option;
                }
            }
        }

        return response()->json([
            'message' => 'Trip and options updated successfully',
            'trip' => $trip,
            'updated_options' => $updatedOptions,
        ], 200);

    } catch (\Illuminate\Validation\ValidationException $e) {
        return response()->json(['error' => $e->validator->errors()], 422);
    } catch (\Exception $e) {
        return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
    }}

    public function getTripByIdWithOptions($id)
    {
        try {
            // جلب بيانات الرحلة بالإضافة إلى الخيارات المرتبطة بها باستخدام eager loading
            $trip = Trip::with('additionalOptions') // Assuming you have a relationship set up
                        ->where('id', $id)
                        ->first();
    
            if (!$trip) {
                return response()->json(['error' => 'Trip not found'], 404);
            }
    
            return response()->json([
                'message' => 'Trip and additional options retrieved successfully.',
                'trip' => $trip,
                // 'additional_options' => $trip->additionalOptions, // Grouping additional options under trip
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred: ' . $e->getMessage(),
            ], 500);
        }
    }
    

    public function getUserTripOptions($userId)
    {
        try {
            // البحث عن trip_id من جدول trip_participants بناءً على user_id
            $tripId = TripParticipant::where('user_id', $userId)->value('trip_id');
    
            // التحقق من أن trip_id موجود
            if (!$tripId) {
                return response()->json([
                    'error' => true,
                    'message' => 'No trip found for this user.',
                ], 404);
            }
    
            // جلب الخيارات المرتبطة بـ trip_id من جدول additional_options
            $options = AdditionalOption::where('trip_id', $tripId)->get();
    
            // التحقق من وجود الخيارات
            if ($options->isEmpty()) {
                return response()->json([
                    'error' => true,
                    'message' => 'No options found for the given trip.',
                ], 404);
            }
    
            // إرجاع الخيارات كاستجابة JSON
            return response()->json([
                'TripId' => $tripId,
                'message' => 'Options retrieved successfully.',
                'data' => $options,
            ], 200);
        } catch (\Exception $e) {
            // إرجاع رسالة الخطأ إذا حدث استثناء
            return response()->json([
                'error' => true,
                'message' => 'An error occurred: ' . $e->getMessage(),
            ], 500);
        }
    }
    
}
