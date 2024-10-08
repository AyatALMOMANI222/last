<?php

namespace App\Http\Controllers;

// use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Conference;
use App\Models\ConferencePrice;
use App\Models\ScientificTopic;
use Illuminate\Support\Facades\Auth;
use Illuminate\Routing\Controller;


use Carbon\Carbon;

class ConferenceController extends Controller
{
    public function store(Request $request)
    {
        // Validate request
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'start_date' => 'required|date',
            'end_date' => 'nullable|date',
            'location' => 'required|string|max:255',
            'status' => 'required|in:upcoming,past',
            'image' => 'nullable|image',
            'first_announcement_pdf' => 'nullable|file|mimes:pdf',
            'second_announcement_pdf' => 'nullable|file|mimes:pdf',
            'conference_brochure_pdf' => 'nullable|file|mimes:pdf',
            'conference_scientific_program_pdf' => 'nullable|file|mimes:pdf',
            'scientific_topics' => 'nullable|string',
            'prices' => 'nullable|array', // Change to 'array' type
            'prices.*.price_type' => 'required|string|max:255',
            'prices.*.price' => 'required|numeric',
            'prices.*.price_description' => 'nullable|string|max:255',
        ]);

        try {
            $conference = new Conference();
            $conference->title = $request->input('title');
            $conference->description = $request->input('description');
            $conference->start_date = $request->input('start_date');
            $conference->end_date = $request->input('end_date');
            $conference->location = $request->input('location');
            $conference->status = $request->input('status');

            // Handle file uploads
            if ($request->hasFile('image')) {
                $conference->image = $request->file('image')->store('conference_images', 'public');
            }
            if ($request->hasFile('first_announcement_pdf')) {
                $conference->first_announcement_pdf = $request->file('first_announcement_pdf')->store('conference_announcements', 'public');
            }
            if ($request->hasFile('second_announcement_pdf')) {
                $conference->second_announcement_pdf = $request->file('second_announcement_pdf')->store('conference_announcements', 'public');
            }
            if ($request->hasFile('conference_brochure_pdf')) {
                $conference->conference_brochure_pdf = $request->file('conference_brochure_pdf')->store('conference_brochures', 'public');
            }
            if ($request->hasFile('conference_scientific_program_pdf')) {
                $conference->conference_scientific_program_pdf = $request->file('conference_scientific_program_pdf')->store('conference_programs', 'public');
            }

            $conference->save();

            // Handle scientific topics
            if ($request->filled('scientific_topics')) {
                $topics = explode(',', $request->input('scientific_topics'));
                foreach ($topics as $topic) {
                    $topic = trim($topic);
                    if (!empty($topic)) {
                        ScientificTopic::create([
                            'conference_id' => $conference->id,
                            'title' => $topic
                        ]);
                    }
                }
            }

            // Handle prices
            if ($request->filled('prices')) {
                $prices = $request->input('prices'); // Directly retrieve the prices array

                // Validate each price entry if necessary
                foreach ($prices as $priceData) {
                    ConferencePrice::create([
                        'conference_id' => $conference->id,
                        'price_type' => $priceData['price_type'],
                        'price' => $priceData['price'],
                        'description' => $priceData['price_description'] ?? null,
                    ]);
                }
            }

            return response()->json(['message' => 'Conference created successfully!', "id" => $conference->id], 201);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to create conference.', 'error' => $e->getMessage()], 500);
        }
    }
    public function getAllConferences(Request $request)
    {
        try {
            // Check if a search parameter is provided
            $search = $request->input('search');
    
            // Retrieve all conferences, applying the search filter if provided
            $query = Conference::with(['images', 'committeeMembers', 'scientificTopics', 'prices']);
    
            if ($search) {
                $query->where('title', 'like', '%' . $search . '%');
            }
    
            $conferences = $query->get();
    
            return response()->json([
                'status' => 'success',
                'data' => $conferences
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to retrieve conferences.',
            ], 500);
        }
    }
    

    // public function getAllConferences(Request $request)
    // {
    //     try {
    //         // Retrieve all conferences
    //         $conferences = Conference::with(['images', 'committeeMembers', 'scientificTopics', 'prices'])->get();

    //         return response()->json([
    //             'status' => 'success',
    //             'data' => $conferences
    //         ], 200);
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'status' => 'error',
    //             'message' => 'Failed to retrieve conferences.',
    //         ], 500);
    //     }
    // }



    public function getConferenceByStatus($status)
    {
        try {
            $currentDate = Carbon::now();

            if ($status === 'past') {
                $conferences = Conference::with(['images', 'committeeMembers', 'scientificTopics', 'prices'])
                    ->where('end_date', '<', $currentDate)
                    ->get();
            } elseif ($status === 'upcoming') {
                $conferences = Conference::with(['images', 'committeeMembers', 'scientificTopics', 'prices'])
                    ->where('start_date', '>', $currentDate)
                    ->get();
            } else {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Invalid status parameter. Use "past" or "upcoming".'
                ], 400);
            }

            return response()->json([
                'status' => 'success',
                'data' => $conferences
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to retrieve conferences by status.',
            ], 500);
        }
    }

    public function getConferenceById($id)
    {
        $conference = Conference::find($id);

        if (!$conference) {
            return response()->json(['message' => 'Conference not found'], 404);
        }

        return response()->json($conference, 200);
    }
}
