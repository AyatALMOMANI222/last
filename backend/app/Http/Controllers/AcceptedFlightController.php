<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\AcceptedFlight;
use App\Models\Flight;
use App\Models\Notification;

class AcceptedFlightController extends Controller
{

    // public function store(Request $request)
    // {
    //     try {
    //         $validatedData = $request->validate([
    //             'flight_id' => 'required|exists:flights,flight_id',  
    //             'price' => 'required|numeric|min:0',
    //             'departure_date' => 'required|date',
    //             'departure_time' => 'required|date_format:H:i',
    //             'admin_set_deadline' => 'nullable|date',
    //             'ticket_number' => 'nullable|string',
    //             'ticket_image' => 'nullable|string',
    //             'issued_at' => 'nullable|date',
    //             'expiration_date' => 'nullable|date',
    //         ]);
    
    //         $acceptedFlight = AcceptedFlight::create([
    //             'flight_id' => $validatedData['flight_id'],
    //             'price' => $validatedData['price'],
    //             'departure_date' => $validatedData['departure_date'],
    //             'departure_time' => $validatedData['departure_time'],
    //             'admin_set_deadline' => $validatedData['admin_set_deadline'],
    //             'ticket_number' => $validatedData['ticket_number'],
    //             'ticket_image' => $validatedData['ticket_image'],
    //             'issued_at' => $validatedData['issued_at'],
    //             'expiration_date' => $validatedData['expiration_date'],
    //         ]);
    
    //         return response()->json([
    //             'message' => 'Accepted flight created successfully',
    //             'accepted_flight' => $acceptedFlight,
    //         ], 201);
    
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'error' => 'An error occurred',
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }
    
    public function storeAll(Request $request)
    {
        try {
            // Validate the incoming request data
            $validatedData = $request->validate([
                'flights' => 'required|array',
                'flights.*.available_id' => 'required|integer',  // New field validation
                'flights.*.flight_id' => 'required|exists:flights,flight_id',
                'flights.*.price' => 'required|numeric|min:0',
                'flights.*.departure_date' => 'required|date',
                'flights.*.departure_time' => 'required|date_format:H:i:s', // Ensure the time is in HH:MM:SS format
                // Removed 'admin_set_deadline' and 'ticket_number' as they are not present in the new structure
                'flights.*.ticket_image' => 'nullable|string',
                'flights.*.issued_at' => 'nullable|date',
                'flights.*.expiration_date' => 'nullable|date',
                'flights.*.is_free' => 'nullable|boolean', // New field validation
            ]);
    
            $acceptedFlights = [];
    
            // Iterate through the validated data and insert each flight into the database
            foreach ($validatedData['flights'] as $flightData) {
                $acceptedFlight = AcceptedFlight::create([
                    'flight_id' => $flightData['flight_id'],
                    'price' => $flightData['price'],
                    'departure_date' => $flightData['departure_date'],
                    'departure_time' => $flightData['departure_time'], // Store time as is, format validated
                    // 'ticket_image' => $flightData['ticket_image'],
                    // 'issued_at' => $flightData['issued_at'],
                    // 'expiration_date' => $flightData['expiration_date'],
                    // Include the new fields in the database creation if applicable
                    // 'available_id' => $flightData['available_id'],  // New field
                    'is_free' => $flightData['is_free'],  // New field
                ]);
    
                $acceptedFlights[] = $acceptedFlight;
            }
    
            return response()->json([
                'message' => 'Accepted flights created successfully',
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
        if (isset($validatedData['admin_set_deadline']) && 
            empty($validatedData['ticket_number']) && 
            empty($validatedData['ticket_image']) && 
            empty($validatedData['issued_at']) && 
            empty($validatedData['expiration_date'])) {
            // إرسال إشعار بأن التذكرة ستكون متاحة قريبًا
            Notification::create([
                'user_id' => $user_id,
                'message' => 'Your ticket will be available soon within the deadline set by the admin.',
            ]);
        }

        // التحقق إذا تم تحديث بيانات التذكرة
        if (!empty($validatedData['ticket_number']) || 
            !empty($validatedData['ticket_image']) || 
            !empty($validatedData['issued_at']) || 
            !empty($validatedData['expiration_date'])) {
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

