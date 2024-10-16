<?php

namespace App\Http\Controllers;

use App\Models\Exhibition;
use Illuminate\Http\Request;

class ExhibitionController extends Controller
{
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'location' => 'required|string|max:255',
            'start_date' => 'required|date',
            'end_date' => 'nullable|date',
            'image' => 'nullable|file|mimes:jpeg,png,jpg|max:2048',
            'status' => 'required|in:upcoming,past',
            'conference_id' => 'nullable|exists:conferences,id', // إضافة conference_id هنا

        ]);

        $exhibition = new Exhibition();
        $exhibition->title = $validatedData['title'];
        $exhibition->description = $validatedData['description'];
        $exhibition->location = $validatedData['location'];
        $exhibition->start_date = $validatedData['start_date'];
        $exhibition->end_date = $validatedData['end_date'];
        $exhibition->status = $validatedData['status'];
        $exhibition->conference_id = $validatedData['conference_id']; // إضافة conference_id هنا

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imagePath = $image->store('exhibition_images', 'public'); // تخزين الصورة في مجلد 'exhibition_images'
            $exhibition->image = $imagePath;
        }
       
        $exhibition->save();

        return response()->json([
            'message' => 'Exhibition added successfully!',
            'data' => $exhibition
        ], 201);
    }


    public function getExhibitionsByStatus($status)
{
    if (!$status || $status === 'all') {
        $exhibitions = Exhibition::all();
    } else {
        $exhibitions = Exhibition::where('status', $status)->get();
    }

    return response()->json($exhibitions);
}
public function getAllExhibitions(Request $request)
{
    try {
        // Get search and status input from the request
        $search = $request->input('search');
        $status = $request->input('status');

        // Set how many items per page you want to display
        $perPage = 10; // Adjust as needed

        // Retrieve all exhibitions
        $query = Exhibition::query(); // Retrieve exhibitions without related models

        // Filter by search if provided
        if ($search) {
            $query->where('title', 'like', '%' . $search . '%');
        }

        // Filter by status if provided
        if ($status) {
            $currentDate = new \DateTime();

            if ($status === 'past') {
                // Past exhibitions where the end date is before the current date
                $query->where('end_date', '<', $currentDate->format('Y-m-d H:i:s'));
            } elseif ($status === 'upcoming') {
                // Upcoming exhibitions where the end date is on or after the current date
                $query->where('end_date', '>=', $currentDate->format('Y-m-d H:i:s'));
            }
        }

        // Apply pagination
        $exhibitions = $query->paginate($perPage);

        // Return response with paginated data
        return response()->json([
            'status' => 'success',
            'data' => $exhibitions->items(),  // The paginated exhibitions data
            'total' => $exhibitions->total(), // Total number of exhibitions
            'per_page' => $exhibitions->perPage(), // Number of exhibitions per page
            'current_page' => $exhibitions->currentPage(), // Current page number
            'total_pages' => $exhibitions->lastPage(), // Total number of pages
        ], 200);

    } catch (\Exception $e) {
        return response()->json([
            'status' => 'error',
            'message' => 'Failed to retrieve exhibitions: ' . $e->getMessage(),
        ], 500);
    }
}

public function getExhibitionById($id)
{
  
    $exhibition = Exhibition::find($id);
    if ($exhibition) {
        return response()->json($exhibition);
    } else {
        return response()->json(['message' => 'Exhibition not found'], 404);
    }
}

    public function deleteExhibitionById($id)
    {
        $exhibition = Exhibition::find($id);

        if ($exhibition) {
            $exhibition->delete();
            return response()->json(['message' => 'Exhibition deleted successfully'], 200);
        } else {
            return response()->json(['message' => 'Exhibition not found'], 404);
        }
    }
}




    