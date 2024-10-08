<?php

namespace App\Http\Controllers;

use App\Models\Trip;
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

            return response()->json(['message' => 'Trip added successfully', 'trip' => $trip], 201);
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
            ]);

            return response()->json(['message' => 'Trip added successfully', 'trip' => $trip], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->validator->errors()->first()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }

    public function getAllTrips(Request $request)
    {
        try {
            // استرجاع جميع الرحلات مع إمكانية التصفية
            $query = Trip::query();

            // تصفية حسب نوع الرحلة إذا تم توفيره
            if ($request->has('trip_type')) {
                $query->where('trip_type', $request->input('trip_type'));
            }

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
}