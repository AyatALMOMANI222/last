<?php

namespace App\Http\Controllers;

use App\Models\ConferenceImage;
use Illuminate\Http\Request;

class ConferenceImageController extends Controller
{
    public function store(Request $request, $conference_id)
    {
        $validatedData = $request->validate([
            'conference_img' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        if ($request->hasFile('conference_img')) {
            $imagePath = $request->file('conference_img')->store('conference_images', 'public');

            $conferenceImage = ConferenceImage::create([
                'conference_id' => $conference_id,
                'conference_img' => $imagePath,
            ]);

            return response()->json(['message' => 'Image uploaded successfully', 'data' => $conferenceImage], 201);
        }

        return response()->json(['message' => 'No image uploaded'], 400);
    }

  
    public function getByConference($conference_id)
    {
        $images = ConferenceImage::where('conference_id', $conference_id)->get();

        // التحقق إذا كانت الصور موجودة
        if ($images->isEmpty()) {
            return response()->json(['message' => 'No images found for this conference'], 404);
        }

        // إرجاع الصور
        return response()->json(['data' => $images], 200);
    }


    // public function destroy($id)
    // {
    //     $image = ConferenceImage::findOrFail($id);

    //     Storage::disk('public')->delete($image->conference_img);

    //     $image->delete();

    //     return response()->json(['message' => 'Image deleted successfully'], 200);
    // }
}
