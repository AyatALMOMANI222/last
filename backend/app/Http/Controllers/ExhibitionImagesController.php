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
                ], 404);
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
}
