<?php
namespace App\Http\Controllers;

use App\Events\NotificationSent;
use Illuminate\Foundation\Auth\User;
use Illuminate\Http\Request;
use App\Models\AcceptedFlight;
use App\Models\Flight;
use App\Models\Notification;

class AcceptedFlightController extends Controller
{

    public function storeAll(Request $request)
    {
        try {
            // Validate the incoming request data
            $validatedData = $request->validate([
                'flights' => 'required|array',
                'flights.*.available_id' => 'required|integer',  // New field validation
                'flights.*.flight_id' => 'required|exists:flights,flight_id', // Ensure flight_id exists
                'flights.*.price' => 'required|numeric|min:0',
                'flights.*.departure_date' => 'nullable|date',
                'flights.*.departure_time' => 'nullable|date_format:H:i:s', // Ensure the time is in HH:MM:SS format
                'flights.*.ticket_image' => 'nullable|string',
                'flights.*.issued_at' => 'nullable|date',
                'flights.*.expiration_date' => 'nullable|date',
                'flights.*.is_free' => 'nullable|boolean', // New field validation
                'flights.*.isOther' => 'nullable|boolean', // New field validation
            ]);

            $acceptedFlights = [];

            // Iterate through the validated data and insert each flight into the database
            foreach ($validatedData['flights'] as $flightData) {
                // Check if the flight_id already exists in the AcceptedFlight table
                $existingFlight = AcceptedFlight::where('flight_id', $flightData['flight_id'])->first();

                if ($existingFlight) {
                    // If the flight_id exists, remove the old record
                    $existingFlight->delete();
                }

                // Create the accepted flight record (insert the new data)
                $acceptedFlight = AcceptedFlight::create([
                    'flight_id' => $flightData['flight_id'],
                    'price' => $flightData['price'],
                    'departure_date' => $flightData['departure_date'] ?? null,
                    'departure_time' => $flightData['departure_time'] ?? null,
                    'ticket_image' => $flightData['ticket_image'] ?? null,
                    'issued_at' => $flightData['issued_at'] ?? null,
                    'expiration_date' => $flightData['expiration_date'] ?? null,
                    'is_free' => $flightData['is_free'] ?? false,
                    'isOther' => $flightData['isOther'] ?? false, // Default to false if not provided
                ]);
                // Check if 'isOther' is true, and send notification to all admins
                // if ($flightData['isOther'] === true) {
                //     $admins = User::where('isAdmin', true)->get();
                //     foreach ($admins as $admin) {
                //         $notification = new Notification();
                //         $notification->user_id = $admin->id; // Save the admin user_id
                //         $notification->message = "Flight {$acceptedFlight->flight_id} has been marked as 'Other' by user {$request->user()->id}.";
                //         $notification->save();
                //         broadcast(new NotificationSent($notification))->toOthers();
                //     }
                // }
                $acceptedFlights[] = $acceptedFlight;
            }

            return response()->json([
                'message' => 'Accepted flights created/updated successfully',
                'accepted_flights' => $acceptedFlights,
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'message' => $e->getMessage(),
            ], 500);
        }
    }





    public function getAcceptedFlightByFlightId($flight_id)
    {
        try {
            // البحث عن الرحلة بناءً على flight_id
            $acceptedFlight = AcceptedFlight::where('flight_id', $flight_id)->first();

            if (!$acceptedFlight) {
                return response()->json([
                    'error' => 'Accepted flight not found',
                ], 404);
            }

            return response()->json([
                'message' => 'Accepted flight retrieved successfully',
                'accepted_flight' => $acceptedFlight,
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    public function getFlightsWhereIsOther()
    {
        try {
            // Retrieve accepted flights where isOther is true, with related flight data
            $acceptedFlights = AcceptedFlight::where('isOther', true)
                ->with('flight') // Eager load the flight relationship
                ->get();

            return response()->json([
                'message' => 'Accepted flights with isOther = true retrieved successfully',
                'accepted_flights' => $acceptedFlights->map(function ($acceptedFlight) {
                    return [
                        'accepted_flight_id' => $acceptedFlight->accepted_flight_id,
                        'price' => $acceptedFlight->price,
                        'admin_set_deadline' => $acceptedFlight->admin_set_deadline,
                        'ticket_number' => $acceptedFlight->ticket_number,
                        'ticket_image' => $acceptedFlight->ticket_image,
                        'issued_at' => $acceptedFlight->issued_at,
                        'expiration_date' => $acceptedFlight->expiration_date,
                        'is_free' => $acceptedFlight->is_free,
                        'isOther' => $acceptedFlight->isOther,
                        'flight' => $acceptedFlight->flight // Include the nested flight object
                    ];
                }),
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'message' => $e->getMessage(),
            ], 500);
        }
    }


    // public function updateByAdmin(Request $request, $id)
// {
//     try {
//         // تحقق من صحة البيانات المدخلة
//         $validatedData = $request->validate([
//             'price' => 'nullable|numeric|min:0',
//             'admin_set_deadline' => 'nullable|date',
//             'ticket_number' => 'nullable|string',
//             'ticket_image' => 'nullable|file|mimes:jpeg,png,pdf', // التأكد من نوع الملف
//             'issued_at' => 'nullable|date',
//             'expiration_date' => 'nullable|date',
//         ]);

    //         // العثور على الرحلة المقبولة باستخدام معرفها
//         $acceptedFlight = AcceptedFlight::findOrFail($id);

    //         // إذا كان هناك ملف ticket_image، يتم رفعه وتحديث القيمة في البيانات المحققة
//         if ($request->hasFile('ticket_image')) {
//             // تخزين التذكرة في مجلد 'tickets' داخل التخزين
//             $ticketPath = $request->file('ticket_image')->store('tickets');
//             $validatedData['ticket_image'] = $ticketPath;
//         }

    //         // تحديث بيانات الرحلة المقبولة مع استخدام array_filter لتفادي الحقول الفارغة
//         $acceptedFlight->update(array_filter([
//             'price' => $validatedData['price'] ?? $acceptedFlight->price,
//             'admin_set_deadline' => $validatedData['admin_set_deadline'] ?? $acceptedFlight->admin_set_deadline,
//             'ticket_number' => $validatedData['ticket_number'] ?? $acceptedFlight->ticket_number,
//             'ticket_image' => $validatedData['ticket_image'] ?? $acceptedFlight->ticket_image,
//             'issued_at' => $validatedData['issued_at'] ?? $acceptedFlight->issued_at,
//             'expiration_date' => $validatedData['expiration_date'] ?? $acceptedFlight->expiration_date,
//         ]));

    //         // الحصول على user_id من جدول الرحلات
//         $flight = Flight::findOrFail($acceptedFlight->flight_id);
//         $user_id = $flight->user_id;

    //         // التحقق إذا تم تحديث فقط الـ admin_set_deadline وكانت التذاكر غير موجودة
//         if ($validatedData['admin_set_deadline'] && 
//             empty($validatedData['ticket_number']) && 
//             empty($validatedData['ticket_image']) && 
//             empty($validatedData['issued_at']) && 
//             empty($validatedData['expiration_date'])) {
//             // إرسال إشعار بأن التذكرة ستكون متاحة قريبًا
//             Notification::create([
//                 'user_id' => $user_id,
//                 'message' => 'Your ticket will be available soon within the deadline set by the admin.',
//             ]);
//         }

    //         // التحقق إذا تم تحديث بيانات التذكرة
//         if (!empty($validatedData['ticket_number']) || 
//             !empty($validatedData['ticket_image']) || 
//             !empty($validatedData['issued_at']) || 
//             !empty($validatedData['expiration_date'])) {
//             // إرسال إشعار بأن التذكرة متاحة الآن
//             Notification::create([
//                 'user_id' => $user_id,
//                 'message' => 'Your ticket is now available on the website. You can download it.',
//             ]);
//         }

    //         return response()->json([
//             'message' => 'Accepted flight updated successfully',
//             'accepted_flight' => $acceptedFlight,
//         ], 200);

    //     } catch (\Exception $e) {
//         return response()->json([
//             'error' => 'An error occurred',
//             'message' => $e->getMessage(),
//         ], 500);
//     }
// }
    public function updateByAdmin(Request $request, $id)
    {
        try {
            // تحقق من صحة البيانات المدخلة
            $validatedData = $request->validate([
                'price' => 'nullable|numeric|min:0',
                'admin_set_deadline' => 'nullable|date',
                'ticket_number' => 'nullable|string',
                'ticket_image' => 'nullable|file|mimes:jpeg,png,pdf', // التأكد من نوع الملف
                'issued_at' => 'nullable|date',
                'expiration_date' => 'nullable|date',
            ]);

            // العثور على الرحلة المقبولة باستخدام معرفها
            $acceptedFlight = AcceptedFlight::findOrFail($id);

            // إذا كان هناك ملف ticket_image، يتم رفعه وتحديث القيمة في البيانات المحققة
            if ($request->hasFile('ticket_image')) {
                $image = $request->file('ticket_image');
                // تخزين التذكرة في مجلد 'public/tickets'
                $ticketPath = $image->store('tickets', 'public');
                $acceptedFlight->ticket_image = basename($ticketPath); // تأكد من حفظ الاسم فقط
            }

            // تحديث بيانات الرحلة المقبولة مع استخدام array_filter لتفادي الحقول الفارغة
            $acceptedFlight->update(array_filter([
                'price' => $validatedData['price'] ?? $acceptedFlight->price,
                'admin_set_deadline' => $validatedData['admin_set_deadline'] ?? null, // القيمة الافتراضية إذا لم تكن موجودة
                'ticket_number' => $validatedData['ticket_number'] ?? $acceptedFlight->ticket_number,
                'ticket_image' => isset($acceptedFlight->ticket_image) ? $acceptedFlight->ticket_image : null,
                'issued_at' => $validatedData['issued_at'] ?? $acceptedFlight->issued_at,
                'expiration_date' => $validatedData['expiration_date'] ?? $acceptedFlight->expiration_date,
            ]));

            // الحصول على user_id من جدول الرحلات
            $flight = Flight::findOrFail($acceptedFlight->flight_id);
            $user_id = $flight->user_id;

            // التحقق إذا تم تحديث فقط الـ admin_set_deadline وكانت التذاكر غير موجودة
            if (
                isset($validatedData['admin_set_deadline']) &&
                empty($validatedData['ticket_number']) &&
                empty($validatedData['ticket_image']) &&
                empty($validatedData['issued_at']) &&
                empty($validatedData['expiration_date'])
            ) {
                // إرسال إشعار بأن التذكرة ستكون متاحة قريبًا
                Notification::create([
                    'user_id' => $user_id,
                    'message' => 'Your ticket will be available soon within the deadline set by the admin.',
                ]);
            }

            // التحقق إذا تم تحديث بيانات التذكرة
            if (
                !empty($validatedData['ticket_number']) ||
                !empty($validatedData['ticket_image']) ||
                !empty($validatedData['issued_at']) ||
                !empty($validatedData['expiration_date'])
            ) {
                // إرسال إشعار بأن التذكرة متاحة الآن
                Notification::create([
                    'user_id' => $user_id,
                    'message' => 'Your ticket is now available on the website. You can download it.',
                ]);
            }

            return response()->json([
                'message' => 'Accepted flight updated successfully',
                'accepted_flight' => $acceptedFlight,
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'message' => $e->getMessage(),
            ], 500);
        }
    }


    public function downloadTicket($id)
    {
        try {
            // العثور على الرحلة المقبولة باستخدام المعرف
            $acceptedFlight = AcceptedFlight::findOrFail($id);

            // تحقق مما إذا كانت صورة التذكرة موجودة
            if (!$acceptedFlight->ticket_image) {
                return response()->json(['error' => 'Ticket image not found.'], 404);
            }

            // بناء مسار الملف بشكل صحيح
            $filePath = storage_path('app/public/tickets/' . $acceptedFlight->ticket_image);

            // تحقق من وجود الملف
            if (!file_exists($filePath)) {
                return response()->json(['error' => 'File not found at: ' . $filePath], 404);
            }

            // تنزيل الملف
            return response()->download($filePath);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred', 'message' => $e->getMessage()], 500);
        }
    }










}

