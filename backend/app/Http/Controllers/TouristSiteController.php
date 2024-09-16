<?php

namespace App\Http\Controllers;

use App\Models\TouristSite;
use Illuminate\Http\Request;

class TouristSiteController extends Controller
{
    public function store(Request $request)
    {
        try {
            // التحقق من صحة البيانات
            $validatedData = $request->validate([
                'name' => 'required|string|max:255',
                'description' => 'nullable|string',
                'image' => 'required|file|mimes:jpeg,png,jpg|max:2048', // تعديل التحقق بناءً على نوع البيانات التي تتوقعها
                'additional_info' => 'nullable|string',
            ]);
    
            // معالجة ملف الصورة
            $imagePath = $request->file('image')->store('tourist_sites_images', 'public');
    
            // إنشاء سجل جديد في جدول tourist_sites
            $touristSite = TouristSite::create([
                'name' => $validatedData['name'],
                'description' => $validatedData['description'],
                'image' => $imagePath, // تخزين مسار الصورة
                'additional_info' => $validatedData['additional_info'],
            ]);
    
            return response()->json([
                'message' => 'Tourist site created successfully!',
                'data' => $touristSite
            ], 201);
    
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error creating tourist site',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $touristSite = TouristSite::findOrFail($id);
            $touristSite->delete();

            return response()->json([
                'message' => 'Tourist site deleted successfully!'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error deleting tourist site',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function index()
    {
        try {
            $touristSites = TouristSite::all();

            return response()->json([
                'data' => $touristSites
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error fetching tourist sites',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
