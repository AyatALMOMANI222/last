<?php

namespace App\Http\Controllers;

use App\Models\ExhibitionImage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Exception;

class ExhibitionImagesController extends Controller
{
    public function store(Request $request)
    {
        try {
            // Validate the incoming request data
            $validatedData = $request->validate([
                'exhibition_id' => 'required|exists:exhibitions,id',
                'image' => 'required|file|mimes:jpeg,png,jpg|max:2048',
                'alt_text' => 'nullable|string|max:255',
                'uploaded_at' => 'nullable|date', // Optional date for uploaded_at
            ]);

            // Handle the uploaded image file
            $imagePath = $request->file('image')->store('exhibition_images', 'public');

            // Create a new record in the exhibition_images table
            $exhibitionImage = new ExhibitionImage();
            $exhibitionImage->exhibition_id = $validatedData['exhibition_id'];
            $exhibitionImage->image = $imagePath;
            $exhibitionImage->alt_text = $validatedData['alt_text'];
            $exhibitionImage->uploaded_at = $validatedData['uploaded_at'] ?? now(); // Default to current time if not provided
            $exhibitionImage->save();

            return response()->json([
                'message' => 'Image uploaded successfully!',
                'data' => $exhibitionImage
            ], 201);

        } catch (ValidationException $e) {
            // Handle validation exceptions
            return response()->json([
                'error' => 'Validation failed',
                'messages' => $e->errors()
            ], 422);

        } catch (Exception $e) {
            // Log the exception and return a generic error message
            Log::error('Error uploading image: ' . $e->getMessage());

            return response()->json([
                'error' => 'An error occurred while uploading the image',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function getImagesByExhibitionId($exhibitionId)
    {
        try {
            // Retrieve images for the given exhibition id
            $images = ExhibitionImage::where('exhibition_id', $exhibitionId)->get();

            // Check if there are images
            if ($images->isEmpty()) {
                return response()->json([
                    'message' => 'No images found for this exhibition.'
                ], 200);
            }

            return response()->json([
                'data' => $images
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'error' => 'Exhibition not found'
            ], 404);
        } catch (Exception $e) {
            return response()->json([
                'error' => 'An error occurred while retrieving images',
                'message' => $e->getMessage()
            ], 500);
        }
    }


   
    
    public function deleteImageByExhibitionIdAndImageId($exhibitionId, $imageId)
    {
        try {
            // Retrieve the image to delete
            $image = ExhibitionImage::where('exhibition_id', $exhibitionId)
                                    ->where('id', $imageId)
                                    ->firstOrFail();
            
            // Delete the image file from storage
            if (file_exists(storage_path('app/public/' . $image->image))) {
                unlink(storage_path('app/public/' . $image->image));
            }

            // Delete the record from the database
            $image->delete();

            return response()->json([
                'message' => 'Image deleted successfully!'
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'error' => 'Image not found for this exhibition.'
            ], 404);
        } catch (Exception $e) {
            return response()->json([
                'error' => 'An error occurred while deleting the image',
                'message' => $e->getMessage()
            ], 500);
        }
    }


//     public function getAllImages()
// {
//     try {
//         // Try to fetch all images
//         $images = ExhibitionImage::all(); 
        
//         // Check if the result is empty
//         if ($images->isEmpty()) {
//             return response()->json([
//                 'success' => false,
//                 'message' => 'No images found',
//             ], 404); // HTTP status 404 for "Not Found"
//         }

//         // Return success response
//         return response()->json([
//             'success' => true,
//             'data' => $images,
//         ], 200); // HTTP status 200 for success

//     } catch (\Exception $e) {
//         // Return error response
//         return response()->json([
//             'success' => false,
//             'message' => 'An error occurred while fetching the images.',
//             'error' => $e->getMessage(), // Optional: to debug the error
//         ], 500); // HTTP status 500 for "Internal Server Error"
//     }
// }
public function getAllImages()
{
    try {
        // إجراء Join مع جدول exhibitions للحصول على 'conference_id'، ثم جلب title من جدول conferences
        $images = ExhibitionImage::join('exhibitions', 'exhibition_images.exhibition_id', '=', 'exhibitions.id')  // تأكد من أن العمود 'exhibition_id' هو العمود الصحيح
            ->join('conferences', 'exhibitions.conference_id', '=', 'conferences.id')
            ->select('exhibition_images.*', 'conferences.title as conference_title') // إضافة الـ title من جدول conferences
            ->paginate(12); // يمكن تعديل العدد وفقاً لاحتياجك

        // تحقق إذا كانت البيانات فارغة
        if ($images->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'No images found',
            ], 200); // HTTP status 404 for "Not Found"
        }

        // إرجاع استجابة ناجحة مع البيانات
        return response()->json([
            'success' => true,
            'data' => $images,
        ], 200); // HTTP status 200 for success

    } catch (\Exception $e) {
        // في حالة وجود خطأ
        return response()->json([
            'success' => false,
            'message' => 'An error occurred while fetching the images.',
            'error' => $e->getMessage(), // اختياري: لمساعدتك في تتبع الأخطاء
        ], 500); // HTTP status 500 for "Internal Server Error"
    }
}



}
