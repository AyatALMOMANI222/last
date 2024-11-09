<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Paper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;
use App\Notifications\EmailNotification;

class PaperController extends Controller
{
    public function store(Request $request, $conferenceId)
    {
        try {
            // Validate the incoming request
            $validatedData = $request->validate([
                'author_name' => 'required|string|max:255',
                'author_title' => 'required|string|max:255',
                'email' => 'required|email|max:255',
                'phone' => 'required|string|max:20',
                'whatsapp' => 'nullable|string|max:20',
                'country' => 'required|string|max:255',
                'nationality' => 'required|string|max:255',
                'password' => 'required|string|max:255',
                'file_path' => 'nullable|file|mimes:pdf', // validate the file
                // 'second_announcement_pdf' => 'nullable|file|mimes:pdf', // validate the second file
            ]);
    
            // Create new paper record
            $scientificPaper = new Paper();
            $scientificPaper->conference_id = $conferenceId;
            $scientificPaper->author_name = $validatedData['author_name'];
            $scientificPaper->author_title = $validatedData['author_title'];
            $scientificPaper->email = $validatedData['email'];
            $scientificPaper->phone = $validatedData['phone'];
            $scientificPaper->whatsapp = $validatedData['whatsapp'] ?? null;
            $scientificPaper->country = $validatedData['country'];
            $scientificPaper->nationality = $validatedData['nationality'];
            $scientificPaper->password = Hash::make($validatedData['password']);
            $scientificPaper->status = 'under_review';
    
            // Handle file upload for file_path
            if ($request->hasFile('file_path')) {
                $filePath = $request->file('file_path')->store('papers', 'public'); // Store file in the 'papers' folder
                $scientificPaper->file_path = $filePath;
            }
    
            $scientificPaper->save();
    
            return response()->json([
                'message' => 'Scientific paper added successfully!',
                'data' => $scientificPaper
            ], 201);
    
        } catch (Exception $e) {
            Log::error('Error storing scientific paper: ' . $e->getMessage());
    
            return response()->json([
                'message' => 'Failed to add scientific paper',
                'error' => $e->getMessage()
            ], 500);
        }
    }
    

    private function storeFile($file, $folder)
    {
        return $file->store($folder, 'public');
    }


    public function getPapersByConferenceId($conference_id)
    {
        try {
            // الحصول على الأوراق حسب معرف المؤتمر
            $papers = Paper::where('conference_id', $conference_id)->get();

            if ($papers->isEmpty()) {
                return response()->json([
                    'message' => 'No papers found for this conference.'
                ], 404);
            }

            return response()->json([
                'message' => 'Papers retrieved successfully!',
                'data' => $papers
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error retrieving papers',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function getPaperById($paper_id)
    {
        try {
            // البحث عن الورقة العلمية حسب معرفها
            $paper = Paper::find($paper_id);

            if (!$paper) {
                return response()->json([
                    'message' => 'Paper not found.'
                ], 404);
            }

            return response()->json([
                'message' => 'Paper retrieved successfully!',
                'data' => $paper
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error retrieving paper',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}


