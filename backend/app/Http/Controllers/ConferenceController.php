<?php

namespace App\Http\Controllers;

// use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Conference;
use App\Models\ConferencePrice;
use App\Models\ConferenceUser;
use App\Models\ScientificTopic;
use Illuminate\Support\Facades\Auth;
use Illuminate\Routing\Controller;


use Carbon\Carbon;

class ConferenceController extends Controller
{
    // public function store(Request $request)
    // {
    //     // Validate request
    //     $request->validate([
    //         'title' => 'required|string|max:255',
    //         'description' => 'nullable|string',
    //         'start_date' => 'required|date',
    //         'end_date' => 'nullable|date',
    //         'location' => 'required|string|max:255',
    //         // 'status' => 'required|in:upcoming,past',
    //         'image' => 'nullable|image',
    //         'first_announcement_pdf' => 'nullable|file|mimes:pdf',
    //         'second_announcement_pdf' => 'nullable|file|mimes:pdf',
    //         'conference_brochure_pdf' => 'nullable|file|mimes:pdf',
    //         'conference_scientific_program_pdf' => 'nullable|file|mimes:pdf',
    //         'scientific_topics' => 'nullable|string',
    //         'prices' => 'nullable|array',
    //         'prices.*.price_type' => 'required|string|max:255',
    //         'prices.*.price' => 'required|numeric',
    //         'prices.*.price_description' => 'nullable|string|max:255',
    //         'visa_price' => 'nullable|numeric', // التحقق من visa_price
    //     ]);

    //     try {
    //         $conference = new Conference();
    //         $conference->title = $request->input('title');
    //         $conference->description = $request->input('description');
    //         $conference->start_date = $request->input('start_date');
    //         $conference->end_date = $request->input('end_date');
    //         $conference->location = $request->input('location');
    //         // $conference->status = $request->input('status');
    //         $conference->visa_price = $request->input('visa_price'); // تخزين قيمة visa_price

    //         // معالجة رفع الملفات
    //         if ($request->hasFile('image')) {
    //             $conference->image = $request->file('image')->store('conference_images', 'public');
    //         }
    //         if ($request->hasFile('first_announcement_pdf')) {
    //             $conference->first_announcement_pdf = $request->file('first_announcement_pdf')->store('conference_announcements', 'public');
    //         }
    //         if ($request->hasFile('second_announcement_pdf')) {
    //             $conference->second_announcement_pdf = $request->file('second_announcement_pdf')->store('conference_announcements', 'public');
    //         }
    //         if ($request->hasFile('conference_brochure_pdf')) {
    //             $conference->conference_brochure_pdf = $request->file('conference_brochure_pdf')->store('conference_brochures', 'public');
    //         }
    //         if ($request->hasFile('conference_scientific_program_pdf')) {
    //             $conference->conference_scientific_program_pdf = $request->file('conference_scientific_program_pdf')->store('conference_programs', 'public');
    //         }

    //         $conference->save(); // حفظ المؤتمر

    //         // معالجة المواضيع العلمية
    //         if ($request->filled('scientific_topics')) {
    //             $topics = explode(',', $request->input('scientific_topics'));
    //             foreach ($topics as $topic) {
    //                 $topic = trim($topic);
    //                 if (!empty($topic)) {
    //                     ScientificTopic::create([
    //                         'conference_id' => $conference->id,
    //                         'title' => $topic
    //                     ]);
    //                 }
    //             }
    //         }

    //         // معالجة الأسعار
    //         if ($request->filled('prices')) {
    //             $prices = $request->input('prices');

    //             foreach ($prices as $priceData) {
    //                 ConferencePrice::create([
    //                     'conference_id' => $conference->id,
    //                     'price_type' => $priceData['price_type'],
    //                     'price' => $priceData['price'],
    //                     'description' => $priceData['price_description'] ?? null,
    //                 ]);
    //             }
    //         }

    //         return response()->json(['message' => 'Conference created successfully!', "id" => $conference->id], 201);
    //     } catch (\Exception $e) {
    //         return response()->json(['message' => 'Failed to create conference.', 'error' => $e->getMessage()], 500);
    //     }
    // }
    public function store(Request $request)
    {
        // Validate request
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'start_date' => 'required|date',
            'end_date' => 'nullable|date|after_or_equal:start_date', // Ensure end_date is after start_date
            'location' => 'required|string|max:255',
            'image' => 'nullable|image',
            'first_announcement_pdf' => 'nullable|file|mimes:pdf',
            'second_announcement_pdf' => 'nullable|file|mimes:pdf',
            'conference_brochure_pdf' => 'nullable|file|mimes:pdf',
            'conference_scientific_program_pdf' => 'nullable|file|mimes:pdf',
            'scientific_topics' => 'nullable|string',
            'prices' => 'nullable|array',
            'prices.*.price_type' => 'required|string|max:255',
            'prices.*.price' => 'required|numeric',
            'prices.*.price_description' => 'nullable|string|max:255',
            'visa_price' => 'nullable|numeric', // Check for visa_price
        ]);

        try {
            $conference = new Conference();
            $conference->title = $request->input('title');
            $conference->description = $request->input('description');
            $conference->start_date = $request->input('start_date');
            $conference->end_date = $request->input('end_date');
            $conference->location = $request->input('location');

            // Determine the status of the conference
            $currentDate = now(); // Get the current date and time
            if ($conference->start_date < $currentDate) {
                $conference->status = 'past'; // If the start date is in the past
            } elseif ($conference->end_date && $conference->end_date >= $currentDate) {
                $conference->status = 'upcoming'; // If the end date is in the future
            } else {
                $conference->status = 'upcoming'; // Default to upcoming if only the start date is in the future
            }

            $conference->visa_price = $request->input('visa_price'); // Store visa_price

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

            $conference->save(); // Save the conference

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
                $prices = $request->input('prices');
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


    public function update(Request $request, $id)
    {
        // Find the conference by ID
        $conference = Conference::findOrFail($id);

        // Validate request
        $request->validate([
            'title' => 'nullable|string|max:255',
            'description' => 'nullable|string',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date',
            'location' => 'nullable|string|max:255',
            // 'status' => 'nullable|in:upcoming,past',
            'image' => 'nullable|image',
            'first_announcement_pdf' => 'nullable|file|mimes:pdf',
            'second_announcement_pdf' => 'nullable|file|mimes:pdf',
            'conference_brochure_pdf' => 'nullable|file|mimes:pdf',
            'conference_scientific_program_pdf' => 'nullable|file|mimes:pdf',
            'scientific_topics' => 'nullable|string',
            'prices' => 'nullable|array',
            'prices.*.price_type' => 'required_with:prices|string|max:255',
            'prices.*.price' => 'required_with:prices|numeric',
            'prices.*.price_description' => 'nullable|string|max:255',
            'visa_price' => 'nullable|numeric', // إضافة تحقق للـ visa_price
        ]);

        try {
            // Update conference fields only if present in the request
            $conference->title = $request->input('title', $conference->title);
            $conference->description = $request->input('description', $conference->description);
            $conference->start_date = $request->input('start_date', $conference->start_date);
            $conference->end_date = $request->input('end_date', $conference->end_date);
            $conference->location = $request->input('location', $conference->location);
            // $conference->status = $request->input('status', $conference->status);

            // Handle file uploads (only update if a new file is provided)
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

            // تحديث visa_price إذا كان موجودًا
            if ($request->filled('visa_price')) {
                $conference->visa_price = $request->input('visa_price'); // تحديث visa_price
            }

            $conference->save();

            // Handle scientific topics (update or create)
            if ($request->filled('scientific_topics')) {
                $conference->scientificTopics()->delete(); // Clear existing topics
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

            // Handle prices (update or create)
            if ($request->filled('prices')) {
                // Clear existing prices
                ConferencePrice::where('conference_id', $conference->id)->delete();

                $prices = $request->input('prices'); // Directly retrieve the prices array

                foreach ($prices as $priceData) {
                    ConferencePrice::create([
                        'conference_id' => $conference->id,
                        'price_type' => $priceData['price_type'],
                        'price' => $priceData['price'],
                        'description' => $priceData['price_description'] ?? null,
                    ]);
                }
            }

            return response()->json(['message' => 'Conference updated successfully!', "id" => $conference->id], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to update conference.', 'error' => $e->getMessage()], 500);
        }
    }


    public function getAllConferences(Request $request)
    {
        try {
            // Check if a search parameter or status parameter is provided
            $search = $request->input('search');
            $status = $request->input('status');

            // Set how many items per page you want to display
            $perPage = 10; // You can adjust this number as needed

            // Retrieve all conferences, applying the search filter if provided
            $query = Conference::with(['images', 'committeeMembers', 'scientificTopics', 'prices']);

            // Filter by search if provided
            if ($search) {
                $query->where('title', 'like', '%' . $search . '%');
            }

            // Filter by status if provided
            if ($status) {
                // Create a DateTime object for the current date
                $currentDate = new \DateTime();

                if ($status === 'past') {
                    // Get past conferences where the end_date is less than the current date
                    $query->where('end_date', '<', $currentDate->format('Y-m-d H:i:s'));
                } elseif ($status === 'upcoming') {
                    // Get upcoming conferences where the end_date is greater than or equal to the current date
                    $query->where('end_date', '>=', $currentDate->format('Y-m-d H:i:s'));
                }
            }

            // Apply pagination with paginate() method
            $conferences = $query->paginate($perPage);

            return response()->json([
                'status' => 'success',
                'data' => $conferences->items(),  // The paginated data (conferences)
                'total' => $conferences->total(), // Total number of items
                'per_page' => $conferences->perPage(), // Number of items per page
                'current_page' => $conferences->currentPage(), // Current page number
                'total_pages' => $conferences->lastPage(), // Total number of pages
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to retrieve conferences: ' . $e->getMessage(),
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
