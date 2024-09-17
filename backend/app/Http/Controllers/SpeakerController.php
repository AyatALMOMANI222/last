<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Speaker;
use App\Models\User;
use App\Notifications\NewSpeakerNotification;
use Illuminate\Support\Facades\Auth;

class SpeakerController extends Controller

 
{
    public function update(Request $request, $id)
    {
        // التحقق من صحة البيانات
        $validatedData = $request->validate([
            'conference_id' => 'nullable|exists:conferences,id',
            'abstract' => 'nullable|string',
            'topics' => 'nullable|string',
            'presentation_file' => 'nullable|string',
            'online_participation' => 'nullable|boolean',
            'is_online_approved' => 'nullable|boolean',
            'accommodation_status' => 'nullable|boolean',
            'ticket_status' => 'nullable|boolean',
            'dinner_invitation' => 'nullable|boolean',
            'airport_pickup' => 'nullable|boolean',
            'free_trip' => 'nullable|boolean',
            'certificate_file' => 'nullable|string',
            'is_certificate_active' => 'nullable|boolean',
        ]);

        // العثور على السجل بناءً على الـ id
        $speaker = Speaker::find($id);

        if (!$speaker) {
            return response()->json(['message' => 'Speaker not found.'], 404);
        }

        // تحديث السجل
        $speaker->update($validatedData);

        return response()->json([
            'message' => 'Speaker updated successfully!',
            'speaker' => $speaker,
        ], 200);
    }
}


    



    
    
    
    
    
    

