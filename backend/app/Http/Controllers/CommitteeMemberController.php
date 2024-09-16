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
            'name' => 'required|string|max:255',
            'committee_image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'conference_id' => 'required|exists:conferences,id',
        ]);

        if ($request->hasFile('committee_image')) {
            $imagePath = $request->file('committee_image')->store('committee_images', 'public');
        } else {
            $imagePath = null; 
        }

        $committeeMember = CommitteeMember::create([
            'name' => $validatedData['name'],
            'committee_image' => $imagePath,
            'conference_id' => $validatedData['conference_id'],
        ]);

        return response()->json(['message' => 'Committee member added successfully', 'data' => $committeeMember], 201);
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
