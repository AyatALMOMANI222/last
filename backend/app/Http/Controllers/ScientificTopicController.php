<?php

namespace App\Http\Controllers;

use App\Models\ScientificTopic;
use Illuminate\Http\Request;

class ScientificTopicController extends Controller
{

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'conference_id' => 'required|exists:conferences,id',
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'speaker_names' => 'nullable|string',
            'goal' => 'nullable|string',
        ]);

        $topic = ScientificTopic::create($validatedData);

        return response()->json(['message' => 'Scientific topic created successfully', 'data' => $topic], 201);
    }



    public function index()
    {
        $topics = ScientificTopic::all();
        return response()->json(['data' => $topics], 200);
    }


    public function show($id)
    {
        $topic = ScientificTopic::find($id);

        if (!$topic) {
            return response()->json(['message' => 'Scientific topic not found'], 404);
        }

        return response()->json(['data' => $topic], 200);
    }

    // public function update(Request $request, $id)
    // {
    //     $validatedData = $request->validate([
    //         'conference_id' => 'required|exists:conferences,id',
    //         'title' => 'required|string|max:255',
    //         'description' => 'nullable|string',
    //         'speaker_names' => 'nullable|string',
    //         'goal' => 'nullable|string',
    //     ]);

    //     $topic = ScientificTopic::find($id);

    //     if (!$topic) {
    //         return response()->json(['message' => 'Scientific topic not found'], 404);
    //     }

    //     $topic->update($validatedData);

    //     return response()->json(['message' => 'Scientific topic updated successfully', 'data' => $topic], 200);
    // }

    public function destroy($id)
    {
        $topic = ScientificTopic::find($id);

        if (!$topic) {
            return response()->json(['message' => 'Scientific topic not found'], 404);
        }

        $topic->delete();

        return response()->json(['message' => 'Scientific topic deleted successfully'], 200);
    }
}
