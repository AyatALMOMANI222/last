<?php

namespace App\Http\Controllers;

use App\Models\Paper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log; 
use Exception;

class ScientificPaperController extends Controller
{
    public function store(Request $request, $conferenceId)
    {
        try {
            $validatedData = $request->validate([
                'author_name' => 'required|string|max:255',
                'author_title' => 'required|string|max:255',
                'email' => 'required|email|max:255',
                'phone' => 'required|string|max:20',
                'whatsapp' => 'nullable|string|max:20',
                'country' => 'required|string|max:255',
                'nationality' => 'required|string|max:255',
                'password' => 'required|string|max:255',
                'file_path' => 'nullable|file|mimes:pdf',
                'second_announcement_pdf' => 'nullable|file|mimes:pdf', // تأكد من إضافة هذا إذا كان مطلوباً
            ]);

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

            if ($request->hasFile('file_path')) {
                $scientificPaper->file_path = $this->storeFile($request->file('file_path'), 'scientific_papers');
            }

            $scientificPaper->status = 'under_review';

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
}
