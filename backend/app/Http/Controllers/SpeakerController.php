<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Conference;
use App\Models\ConferenceUser;
use App\Models\Notification;
use App\Models\Paper;
use Illuminate\Http\Request;
use App\Models\Speaker;
use App\Models\User;
use App\Notifications\NewSpeakerNotification;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class SpeakerController extends Controller
{
    public function store(Request $request, $user_id, $conference_id)
    {
        try {
            // Validate the incoming request data
            $validatedData = $request->validate([
                'is_online_approved' => 'nullable|boolean',
                // 'ticket_status' => 'nullable|string',
                'dinner_invitation' => 'nullable|boolean',
                'airport_pickup' => 'nullable|boolean',
                'free_trip' => 'nullable|boolean',
                'is_certificate_active' => 'nullable|boolean',
                'room_type' => 'nullable|string|in:Single,Double,Triple',
                'nights_covered' => 'nullable|integer|min:0',
                'is_visa_payment_required' => 'nullable|boolean', // الحقل الجديد
            ]);
    
            // Check if the speaker already exists for this user and conference
            $existingSpeaker = Speaker::where('user_id', $user_id)
                ->where('conference_id', $conference_id)
                ->first();
    
            if ($existingSpeaker) {
                return response()->json([
                    'error' => 'Speaker already exists for this user and conference.'
                ], 400); // Use 409 for conflict
            }
    
            // Check if conference_user record exists and update only is_visa_payment_required
            $conferenceUser = ConferenceUser::where('user_id', $user_id)
                ->where('conference_id', $conference_id)
                ->first();
    
            if ($conferenceUser) {
                // Update only the is_visa_payment_required field
                $conferenceUser->is_visa_payment_required = $request->input('is_visa_payment_required', false);
                $conferenceUser->save();
            } else {
                return response()->json([
                    'error' => 'ConferenceUser record not found for this user and conference.'
                ], 404);
            }
    
            // Check if the user has a paper associated with this conference
            $paper = Paper::where('user_id', $user_id)
                ->where('conference_id', $conference_id)
                ->first();
    
            // If the user has a paper, use its abstract in the speaker entry
            $abstract = $paper ? $paper->abstract : null;
    
            // Create a new speaker entry with the abstract from the paper (if available)
            $speaker = Speaker::create(array_merge($validatedData, [
                'user_id' => $user_id,
                'conference_id' => $conference_id,
                'abstract' => $abstract, // Set abstract from paper if it exists
            ]));
    
            // Update user status to "approved"
            $user = User::findOrFail($user_id);
            $user->status = 'approved';
            $user->save();
    
            // Send a notification to the speaker
            $userNotification = Notification::create([
                'user_id' => $user_id,
                'message' => 'We are pleased to inform you that your profile is now active. You can log in to the website and complete your profile.',
                'conference_id' => $conference_id,
                'is_read' => false, // Set according to your needs
            ]);
    
            // Broadcast the notification
            broadcast(new NotificationSent($userNotification));
    
            // Return a success response
            return response()->json([
                'message' => 'Speaker created successfully, user status updated to approved, and abstract from paper added.',
                'speaker' => $speaker,
                'conference_user' => $conferenceUser,
            ], 201); // Use 201 for created resource
    
        } catch (\Illuminate\Validation\ValidationException $e) {
            // Handle validation errors
            return response()->json([
                'error' => 'Validation error',
                'details' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            // Handle general errors
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage()
            ], 500);
        }
    }
    


    //  هنا يعدل على user_id ,عملتله check admin خارجي 
      public function updateByUser(Request $request)
    {
        try {
            // Validate input data
            $validatedData = $request->validate([
                'abstract' => 'nullable', // Allow any value (file or text)
                'topics' => 'nullable|string',
                'presentation_file' => 'nullable', // Allow any value (file or text)
                'online_participation' => 'nullable|boolean',
                'departure_date' => 'nullable|date',
                'arrival_date' => 'nullable|date',
                'video' => 'nullable', // Allow any value (file or text)
            ]);

            // Get the authenticated user's ID
            $user_id = Auth::id();

            // Find the speaker associated with the authenticated user
            $speaker = Speaker::where('user_id', $user_id)->firstOrFail();

            // Handle 'presentation_file'
            if ($request->hasFile('presentation_file')) {
                $presentationFilePath = $request->file('presentation_file')->store('presentations', 'public');
                $speaker->presentation_file = $presentationFilePath;
            } elseif (is_string($request->input('presentation_file'))) {
                $speaker->presentation_file = $request->input('presentation_file');
            } else {
                $speaker->presentation_file = null; // Set to null if not present
            }

            // Handle 'abstract'
            if ($request->hasFile('abstract')) {
                $abstractFilePath = $request->file('abstract')->store('abstracts', 'public');
                $speaker->abstract = $abstractFilePath;
            } elseif (is_string($request->input('abstract'))) {
                $speaker->abstract = $request->input('abstract');
            } else {
                $speaker->abstract = null; // Set to null if not present
            }

            // Handle 'video'
            if ($request->hasFile('video')) {
                $videoFilePath = $request->file('video')->store('videos', 'public');
                $speaker->video = $videoFilePath;
            } elseif (is_string($request->input('video'))) {
                $speaker->video = $request->input('video');
            } else {
                $speaker->video = null; // Set to null if not present
            }

            // Update other details, setting to null if not provided
            $speaker->topics = $validatedData['topics'] ?? null;
            $speaker->online_participation = $validatedData['online_participation'] ?? null;
            $speaker->departure_date = $validatedData['departure_date'] ?? null;
            $speaker->arrival_date = $validatedData['arrival_date'] ?? null;

            $speaker->save();

            return response()->json([
                'message' => 'Speaker details updated successfully',
                'speaker' => $speaker
            ], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'error' => 'Validation error',
                'details' => $e->errors()
            ], 422);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'error' => 'Speaker not found for the authenticated user',
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage()
            ], 500);
        }
    }
    

    public function getSpeakerByConferenceId($conference_id)
    {
        try {
            // الحصول على الـ user_id من التوكن
            $user_id = Auth::id(); // أو إذا كنت تستخدم JWT، يمكنك استخدام JWT facade أو middleware

            // التحقق إذا كان المستخدم مسجل الدخول
            if (!$user_id) {
                return response()->json([
                    'error' => 'User not authenticated.'
                ], 401); // Unauthorized
            }

            // Find the speaker based on user_id and conference_id
            $speaker = Speaker::where('user_id', $user_id)
                ->where('conference_id', $conference_id)
                ->first();

            // Check if the speaker exists
            if (!$speaker) {
                return response()->json([
                    'error' => 'Speaker not found for this user and conference.'
                ], 404); // Resource not found
            }

            // Return the speaker details
            return response()->json([
                'message' => 'Speaker found successfully.',
                'speaker' => $speaker,
            ], 200); // Success response

        } catch (\Exception $e) {
            // Handle unexpected errors
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage(),
            ], 500); // Internal server error
        }
    }


    // هنا ياخذ user_id من التوكن يعدل لنفسه 
    public function updateOnlineParticipation(Request $request)
    {
        try {
            // التحقق من صحة البيانات
            $validatedData = $request->validate([
                'online_participation' => 'required|boolean',
            ]);

            // استخراج user_id من التوكن
            $userId = Auth::id(); // الحصول على user_id من التوكن

            // العثور على المتحدث بناءً على user_id
            $speaker = Speaker::where('user_id', $userId)->firstOrFail();

            // الحصول على المؤتمر المرتبط بالمتحدث
            $conference = Conference::find($speaker->conference_id);

            // التحقق من صحة المؤتمر
            // if (!$conference) {
            //     return response()->json(['error' => 'Conference not found'], 404);
            // }

            // تحقق من أن المشاركة عبر الإنترنت مسموح بها بناءً على حالة الموافقة على المشاركة عبر الإنترنت
            if ($speaker->is_online_approved) {
                // تحديث حالة المشاركة عبر الإنترنت
                $speaker->update([
                    'online_participation' => $validatedData['online_participation'],
                ]);

                // إرسال الإشعار عند النجاح
                $notificationMessage = 'سيتم تزويدك برابط الزوم الخاص بالمؤتمر قبل موعد المؤتمر أو محاضرتك بيوم واحد للمشاركة';

                // إدخال الإشعار في قاعدة البيانات
                $userNotification = Notification::create([
                    'user_id' => $userId, // إرسال الإشعار إلى المستخدم نفسه
                    'message' => $notificationMessage,
                    'is_read' => false, // الإشعار جديد لم يُقرأ بعد
                ]);
                broadcast(new NotificationSent($userNotification));
                return response()->json(['message' => 'Online participation updated successfully', 'notification' => $notificationMessage, 'speaker' => $speaker], 200);
            } else {
                return response()->json(['error' => 'Online participation is not approved for this speaker'], 400);
            }
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->errors()], 422);
        } catch (\Exception $e) {
            // طباعة تفاصيل الخطأ
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage()
            ], 500);
        }
    }





    public function updateCertificateFile(Request $request, $user_id)
    {
        try {
            // البحث عن المتحدث بناءً على user_id
            $speaker = Speaker::where('user_id', $user_id)->firstOrFail();

            // التحقق من صحة البيانات
            $validatedData = $request->validate([
                'certificate_file' => 'required|file|mimes:pdf',
            ]);

            // تحديث ملف الشهادة
            $speaker->certificate_file = $request->file('certificate_file')->store('certificates', 'public');
            $speaker->save();

            return response()->json(['message' => 'Certificate file updated successfully', 'speaker' => $speaker], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An unexpected error occurred. Please try again.'], 500);
        }
    }
    public function getSpeakerInfoByToken()
    {
        try {
            // استخراج user_id من التوكن
            $user_id = Auth::id(); // يحصل على user_id من التوكن

            // العثور على المتحدث مع معلومات المستخدم بناءً على user_id
            $speaker = Speaker::where('user_id', $user_id)
                ->join('users', 'users.id', '=', 'speakers.user_id') // إجراء join مع جدول users
                ->select('speakers.*', 'users.*'
                
           
                ) // تحديد الأعمدة المراد جلبها
                ->firstOrFail();

            // إعادة بيانات المتحدث مع بيانات المستخدم
            return response()->json([
                'message' => 'Speaker found successfully',
                'speaker' => $speaker
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            // إذا لم يتم العثور على المتحدث
            return response()->json([
                'error' => 'Speaker not found'
            ], 404);

        } catch (\Exception $e) {
            // التعامل مع أي أخطاء غير متوقعة
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage()
            ], 500);
        }
    }


 
    



    public function getSpeakersByConference($conferenceId)
    {
        // استدعاء دالة الحصول على المتحدثين مع معلومات اليوزر من خلال join
        $speakers = Speaker::join('users', 'speakers.user_id', '=', 'users.id')  // عمل join مع جدول ال users
            ->where('speakers.conference_id', $conferenceId) // تحديد المؤتمر باستخدام conference_id
            ->select('speakers.*', 'users.name', 'users.email', 'users.image')  // اختيار الأعمدة المطلوبة
            ->get(); // جلب النتائج

        // إرجاع البيانات على هيئة JSON
        return response()->json($speakers);
    }

    public function getSpeakers(Request $request)
    {
        // Get the 'page' query parameter, default to 1 if not provided
        $page = $request->query('page', 1); 
        
        // Define the number of speakers per page
        $speakersPerPage = 3;
        
        // Calculate the offset for the current page
        $offset = ($page - 1) * $speakersPerPage;
        
        // Fetch speakers from the database and include user data (using Eloquent's 'with' method to eager load the 'user' relationship)
        $totalSpeakers = Speaker::count(); // Total number of speakers
        $speakers = Speaker::with('user') // Eager load user data for each speaker
            ->skip($offset)
            ->take($speakersPerPage)
            ->get(); // Fetch paginated speakers
        
        // Calculate the total number of pages
        $totalPages = ceil($totalSpeakers / $speakersPerPage);
        
        // Prepare the response data
        $response = [
            'message' => 'Users speakers successfully.',
            'speakers' => $speakers,
            'currentPage' => $page,
            'totalPages' => $totalPages
        ];
        
        // Return the JSON response
        return response()->json($response);
    }

    public function getOnlineParticipants($conference_id, Request $request)
    {
        try {
            // Define the number of items per page (you can make it configurable)
            $perPage = $request->input('per_page', 10); // Default to 10 items per page
    
            // Retrieve speakers who are online participants for the given conference
            $onlineSpeakers = Speaker::where('conference_id', $conference_id)
                ->where('online_participation', true)  // Checking if the speaker is online
                ->with('user')  // Assuming there is a relation with User
                ->paginate($perPage); // Use pagination to split the data across pages
    
            // Check if the collection is empty
            if ($onlineSpeakers->isEmpty()) {
                return response()->json([
                    'message' => 'No online participants found for this conference.'
                ], 404);
            }
    
            // Return the response with pagination data
            return response()->json([
                'message' => 'Online participants retrieved successfully.',
                'data' => $onlineSpeakers->items(),
                'pagination' => [
                    'current_page' => $onlineSpeakers->currentPage(),
                    'previous_page' => $onlineSpeakers->previousPageUrl(),
                    'next_page' => $onlineSpeakers->nextPageUrl(),
                    'total' => $onlineSpeakers->total(),
                    'per_page' => $onlineSpeakers->perPage(),
                ]
            ], 200);
        } catch (\Exception $e) {
            // Handle any unexpected errors
            return response()->json([
                'error' => 'An unexpected error occurred. Please try again.',
                'details' => $e->getMessage()
            ], 500);
        }
    }
    

    public function storeLink(Request $request)
    {
        // التحقق من صحة المدخلات
        $validator = Validator::make($request->all(), [
            'link' => 'nullable|url', // التحقق من أن الرابط هو URL صحيح أو يمكن أن يكون فارغًا
            'speaker_id' => 'required|exists:speakers,id'  // التحقق من أن الـ speaker_id موجود في قاعدة البيانات
        ]);
    
        if ($validator->fails()) {
            return response()->json([
                'error' => 'Invalid data format.',
                'details' => $validator->errors()
            ], 400);
        }
    
        // إذا كانت المدخلات صحيحة، نقوم بإدخال الرابط في قاعدة البيانات
        try {
            // البحث عن السبيكر باستخدام speaker_id
            $speaker = Speaker::find($request->speaker_id);
    
            if ($speaker) {
                // تحديث قيمة الرابط في جدول السبيكر
                $speaker->link = $request->link;
                $speaker->save();
    
                return response()->json([
                    'message' => 'Link updated successfully!',
                    'data' => $speaker
                ], 200);
            } else {
                return response()->json([
                    'error' => 'Speaker not found.'
                ], 404);
            }
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while updating the link.',
                'details' => $e->getMessage()
            ], 500);
        }
    }
    
   
 
    public function getLinkByToken(Request $request)
    {
        try {
            // الحصول على الـ user_id من التوكن (المصادقة)
            $userId = Auth::id();
    
            // التحقق من أن المستخدم موجود
            if (!$userId) {
                return response()->json([
                    'error' => 'User not authenticated or invalid token.'
                ], 401);
            }
    
            // البحث عن السبيكر باستخدام user_id
            $speaker = Speaker::where('user_id', $userId)->first();
    
            // التحقق من وجود السبيكر
            if (!$speaker) {
                return response()->json([
                    'error' => 'Speaker not found for this user.'
                ], 404);
            }
    
            // إرجاع الرابط
            return response()->json([
                'message' => 'Link retrieved successfully!',
                'link' => $speaker->link
            ], 200);
    
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while retrieving the link.',
                'details' => $e->getMessage()
            ], 500);
        }
    }
       
}
