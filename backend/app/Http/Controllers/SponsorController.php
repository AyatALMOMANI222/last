<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\BoothCost;
use App\Models\ConferenceUser;
use App\Models\Notification;
use App\Models\Sponsor;
use App\Models\SponsorshipOption;
use App\Models\User;
use App\Notifications\EmailNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;




class SponsorController extends Controller
{
    public function store(Request $request)
    {
        try {
            // التحقق من صحة البيانات المرسلة
            $validatedData = $request->validate([
                'phone_number' => 'nullable|string|max:255',
                'whatsapp_number' => 'nullable|string|max:255',
                'email' => 'required|email|unique:users,email', // تأكد من أن البريد الإلكتروني فريد
                'conference_id' => 'required|exists:conferences,id',
                'password' => 'required|string|min:8',
                'registration_type' => 'required|string',
                'company_name' => 'required|string|max:255',
                'contact_person' => 'required|string|max:255',
                'company_address' => 'required|string|max:255',
            ]);

            // إنشاء مستخدم جديد
            $user = User::create([
                'phone_number' => $validatedData['phone_number'],
                'whatsapp_number' => $validatedData['whatsapp_number'],
                'email' => $validatedData['email'],
                'password' => bcrypt($validatedData['password']),
                'registration_type' => "sponsor",
                'company_name' => $validatedData['company_name'],
                'contact_person' => $validatedData['contact_person'],
                'company_address' => $validatedData['company_address'],
                'conference_id'=> $validatedData['conference_id'],

            ]);

            // إنشاء Sponsor وربطه بالمستخدم
            // $sponsor = new Sponsor([
            //     'company_name' => $validatedData['company_name'],
            //     'contact_person' => $validatedData['contact_person'],
            //     'company_address' => $validatedData['company_address'],
            //     'conference_id' => $validatedData['conference_id'],
            //     'status' => "pending"
            // ]);

            // ربط Sponsor بالمستخدم وحفظ البيانات
            // $user->sponsors()->save($sponsor);

            // إرسال إشعار إلى المستخدم
            $userNotification = Notification::create([
                'user_id' => $user->id,
                'message' => 'You will be contacted directly by the organizing company via email.',
                'is_read' => false,
            ]);
            broadcast(new NotificationSent($userNotification));
            // **إضافة إشعار لجميع المدراء**
            $admins = User::where('isAdmin', true)->get();
            foreach ($admins as $admin) {
                $notification = Notification::create([
                    'user_id' => $admin->id,
                    'register_id' => $user->id,
                    'message' => 'New sponsor registration: ' . $user->email, // يمكنك تعديل هذه الرسالة حسب الحاجة
                    'is_read' => false,
                ]);
                broadcast(new NotificationSent($notification))->toOthers();
            }

            return response()->json(['message' => 'User and Sponsor created successfully!'], 201);
        } catch (ValidationException $e) {
            // رسالة الخطأ الخاصة بالتحقق
            return response()->json(['message' => 'Validation Error', 'errors' => $e->validator->errors()], 422);
        } catch (\Exception $e) {
            // رسالة الخطأ العامة
            return response()->json(['message' => 'Something went wrong: ' . $e->getMessage()], 500);
        }
    }
    public function approveSponsor(Request $request)
    {
        try {
            // Validate incoming data for approveSponsor
            $validatedData = $request->validate([
                'user_id' => 'required|exists:users,id',
                'conference_id' => 'required|exists:conferences,id',
                'company_name' => 'required|string|max:255',
                'contact_person' => 'required|string|max:255',
                'company_address' => 'required|string|max:255',
            ]);
    
            // Get the user_id and conference_id from the validated data
            $userId = $validatedData['user_id'];
            $conferenceId = $validatedData['conference_id'];
    
            // Find the user by userId
            $user = User::findOrFail($userId);
    
            // Check if the user is already approved
            if ($user->status == 'approved') {
                return response()->json(['message' => 'User already approved'], 400);
            }
    
            // Check if the user is already assigned to this conference
            $existingConferenceUser = ConferenceUser::where('user_id', $userId)
                ->where('conference_id', $conferenceId)
                ->first();
    
            if ($existingConferenceUser) {
                return response()->json(['message' => 'User already assigned to this conference.'], 400);
            }
    
            // Associate the user with the conference
            ConferenceUser::create([
                'user_id' => $userId,
                'conference_id' => $conferenceId,
            ]);
    
            // Update the user's status to approved
            $user->status = 'approved';
            $user->save();
    
            // Create a new Sponsor for the user
            $user->sponsors()->create([
                'company_name' => $validatedData['company_name'],
                'contact_person' => $validatedData['contact_person'],
                'company_address' => $validatedData['company_address'],
                'conference_id' => $conferenceId,
            ]);
    
            // Send notification to the user
            $notificationMessage = 'Your sponsorship has been approved. Thank you for becoming a sponsor for our conference. We look forward to your valuable contribution.';
            $userNotification = Notification::create([
                'user_id' => $user->id,
                'message' => $notificationMessage,
                'is_read' => false,
            ]);
            broadcast(new NotificationSent($userNotification));
    
            // Try to send an email notification
            try {
                $user->notify(new EmailNotification($notificationMessage));
            } catch (\Exception $e) {
                return response()->json([
                    'message' => 'Sponsor approved successfully, but email notification failed to send.',
                    'error' => $e->getMessage(),
                ], 200);
            }
    
            // Notify admins about the sponsor approval
            $admins = User::where('isAdmin', true)->get();
            foreach ($admins as $admin) {
                $notification = Notification::create([
                    'user_id' => $admin->id,
                    'register_id' => $user->id,
                    'message' => 'Sponsor approved: ' . $user->email,
                    'is_read' => false,
                ]);
                broadcast(new NotificationSent($notification))->toOthers();
            }
    
            return response()->json(['message' => 'Sponsor created and user approved successfully!'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Something went wrong: ' . $e->getMessage()], 500);
        }
    }
    
    public function getAllSponsors()
    {
        try {
            // جلب كل الsponsors مع ربط جدول المستخدمين باستخدام user_id
            $sponsors = DB::table('sponsors')
                ->join('users', 'sponsors.user_id', '=', 'users.id') // إجراء JOIN بين جدول sponsors وجدول users
                ->select('sponsors.*', 'users.conference_id') // تحديد الأعمدة المطلوبة من كلا الجدولين
                ->get();
    
            return response()->json([
                'message' => 'Sponsors fetched successfully.',
                'sponsors' => $sponsors,
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to fetch sponsors.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
    

    // public function getSponsors(Request $request)
    // {
    //     try {
    //         // Get the 'page' query parameter, default to 1 if not provided
    //         $page = $request->query('page', 1);
    
    //         // Define the number of sponsors per page
    //         $sponsorsPerPage = 3;
    
    //         // Calculate the offset for the current page
    //         $offset = ($page - 1) * $sponsorsPerPage;
    
    //         // Fetch total sponsor count for pagination
    //         $totalSponsors = Sponsor::count();
    
    //         // Fetch sponsors along with related user and invoice data
    //         $sponsors = Sponsor::with(['user', 'sponsorInvoices']) // Include user and invoices
    //             ->skip($offset)
    //             ->take($sponsorsPerPage)
    //             ->get();
    
    //         // Calculate the total number of pages
    //         $totalPages = ceil($totalSponsors / $sponsorsPerPage);
    
    //         // Prepare the response data
    //         $response = [
    //             'message' => 'Sponsors fetched successfully.',
    //             'sponsors' => $sponsors,
    //             'currentPage' => $page,
    //             'totalPages' => $totalPages,
    //         ];
    
    //         // Return the JSON response
    //         return response()->json($response, 200);
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'message' => 'Failed to fetch sponsors.',
    //             'error' => $e->getMessage(),
    //         ], 500);
    //     }
    // }
    
    public function getSponsors(Request $request)
    {
        try {
            // Get the 'page' query parameter, default to 1 if not provided
            $page = $request->query('page', 1);
        
            // Define the number of sponsors per page
            $sponsorsPerPage = 3;
        
            // Calculate the offset for the current page
            $offset = ($page - 1) * $sponsorsPerPage;
        
            // Fetch total sponsor count for pagination
            $totalSponsors = Sponsor::count();
        
            // Fetch sponsors along with related user and invoice data
            $sponsors = Sponsor::with([
                'user',
                'sponsorInvoices' => function($query) {
                    // Include specific relationships for sponsorInvoices
                    $query->with([
                        'sponsorshipOptions', // Only the sponsorship options related to invoice
                        'boothCosts' // Only the booth costs related to invoice
                    ]);
                }
            ])
            ->skip($offset)
            ->take($sponsorsPerPage)
            ->get();
    
            // Add custom logic to resolve sponsorship options and booth costs based on the JSON data
            foreach ($sponsors as $sponsor) {
                // Ensure sponsorInvoices exists and is not empty
                if ($sponsor->sponsorInvoices->isNotEmpty()) {
                    foreach ($sponsor->sponsorInvoices as $sponsorInvoice) {
                        // Decode the JSON arrays for sponsorship_option_ids and booth_cost_ids
                        $sponsorshipOptionIds = json_decode($sponsorInvoice->sponsorship_option_ids, true);
                        $boothCostIds = json_decode($sponsorInvoice->booth_cost_ids, true);
    
                        // Fetch the corresponding sponsorship options if they exist
                        if ($sponsorshipOptionIds) {
                            $sponsorshipOptions = SponsorshipOption::whereIn('id', $sponsorshipOptionIds)->get();
                            $sponsorInvoice->sponsorshipOptions = $sponsorshipOptions;
                        }
    
                        // Fetch the corresponding booth costs if they exist
                        if ($boothCostIds) {
                            $boothCosts = BoothCost::whereIn('id', $boothCostIds)->get();
                            $sponsorInvoice->boothCosts = $boothCosts;
                        }
                    }
                }
            }
        
            // Calculate the total number of pages
            $totalPages = ceil($totalSponsors / $sponsorsPerPage);
        
            // Prepare the response data
            $response = [
                'message' => 'Sponsors fetched successfully.',
                'sponsors' => $sponsors,
                'currentPage' => $page,
                'totalPages' => $totalPages,
            ];
        
            // Return the JSON response
            return response()->json($response, 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to fetch sponsors.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
    


}

