<?php

namespace App\Http\Controllers;

use App\Models\CommitteeMember;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class CommitteeMemberController extends Controller
{
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'members' => 'required|array',
            'members.*.name' => 'required|string|max:255',
            'members.*.committee_image' => 'nullable',
            'members.*.conference_id' => 'required|exists:conferences,id',
        ]);
    
        // Step 1: Remove all committee members with the same conference_id from the first member
        $conferenceId = $validatedData['members'][0]['conference_id'];
        CommitteeMember::where('conference_id', $conferenceId)->delete();
    
        $committeeMembers = [];
    
        // Step 2: Create the new committee members
        foreach ($validatedData['members'] as $index => $memberData) {
            // Handle the image upload if it exists
            $imagePath = null; 
            if (isset($memberData['committee_image']) && $request->hasFile("members.{$index}.committee_image")) {
                $imagePath = $memberData['committee_image']->store('committee_images', 'public');
            }
    
            // Create the committee member record
            $committeeMember = CommitteeMember::create([
                'name' => $memberData['name'],
                'committee_image' => $imagePath,
                'conference_id' => $memberData['conference_id'],
            ]);
    
            $committeeMembers[] = $committeeMember;
        }
    
        return response()->json(['message' => 'Committee members added successfully', 'data' => $committeeMembers], 201);
    }
    
    

    public function getByConference($conference_id)
    {
        $members = CommitteeMember::where('conference_id', $conference_id)->get();

        if ($members->isEmpty()) {
            return response()->json(['message' => 'No committee members found for this conference'], 404);
        }

        return response()->json(['data' => $members], 200);
    }
}
