<?php

namespace App\Http\Controllers;

use App\Models\OurClient;
use Illuminate\Http\Request;

class OurClientController extends Controller
{
    public function store(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
                'description' => 'nullable|string',
            ]);
    
            // تحقق من رفع الصورة واحفظها في مجلد التخزين
            if ($request->hasFile('image')) {
                $imagePath = $request->file('image')->store('images', 'public');
                $validatedData['image'] = $imagePath; // قم بتحديث مسار الصورة
            }
    
            $client = OurClient::create($validatedData);
    
            return response()->json($client, 201);
    
        } catch (\Illuminate\Validation\ValidationException $e) {
            // في حال حدوث خطأ في التحقق من صحة البيانات
            return response()->json([
                'message' => 'Validation Error',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            // في حال حدوث أي خطأ آخر
            return response()->json([
                'message' => 'An error occurred while creating the client',
                'error' => $e->getMessage()
            ], 500);
        }
    }
    
    public function index()
    {
        try {
            // جلب جميع العملاء من قاعدة البيانات
            $clients = OurClient::all();
    
            return response()->json($clients, 200);
    
        } catch (\Exception $e) {
            // معالجة أي خطأ
            return response()->json([
                'message' => 'An error occurred while fetching clients',
                'error' => $e->getMessage(),
                'code' => $e->getCode(), // إضافة كود الخطأ
            ], 500);
        }
    }
    
public function destroy($id)
{
    try {
        // البحث عن العميل باستخدام ID
        $client = OurClient::findOrFail($id); // سيقوم برمي استثناء إذا لم يتم العثور على السجل

        $client->delete(); // حذف العميل

        return response()->json([
            'message' => 'Client deleted successfully',
        ], 200);

    } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
        return response()->json([
            'message' => 'Client not found',
        ], 404);
    } catch (\Exception $e) {
        return response()->json([
            'message' => 'An error occurred while deleting the client',
            'error' => $e->getMessage()
        ], 500);
    }
}

}
