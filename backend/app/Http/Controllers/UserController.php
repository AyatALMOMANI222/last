<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

use function Laravel\Prompts\error;

class UserController extends Controller
{
    public function store(Request $request)
   
    {
        try {
            $validatedData = $request->validate([
                'name' => 'nullable|string|max:255',
                'email' => 'required|email|unique:users,email',
                'password' => 'required|string|min:8',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                'biography' => 'nullable|string',
                'registration_type' => 'nullable|in:speaker,attendance,sponsor,group_registration',
                'phone_number' => 'nullable|string|max:255',
                'whatsapp_number' => 'nullable|string|max:255',
                'specialization' => 'nullable|string|max:255',
                'nationality' => 'nullable|string|max:255',
                'country_of_residence' => 'nullable|string|max:255',
                'isAdmin' => 'sometimes|in:true,false', 
            ]);
    
            if ($request->hasFile('image')) {
                $path = $request->file('image')->store('images', 'public');
                $validatedData['image'] = $path;
            } else {
                $validatedData['image'] = null;
            }
    
            $validatedData['isAdmin'] = filter_var($request->input('isAdmin', false), FILTER_VALIDATE_BOOLEAN);
    
            $user = User::create([
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'password' => bcrypt($validatedData['password']),
                'image' => $validatedData['image'],
                'biography' => $validatedData['biography'],
                'registration_type' => $validatedData['registration_type'],
                'phone_number' => $validatedData['phone_number'],
                'whatsapp_number' => $validatedData['whatsapp_number'],
                'specialization' => $validatedData['specialization'],
                'nationality' => $validatedData['nationality'],
                'country_of_residence' => $validatedData['country_of_residence'],
                'isAdmin' => $validatedData['isAdmin'],
            ]);
    
            return response()->json(['message' => 'User created successfully!'], 201);
    
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create user.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
    
    
}

