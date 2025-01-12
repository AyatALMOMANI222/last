<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\InvoiceFlight;
use Illuminate\Http\Request;
use App\Models\AcceptedFlight;
use App\Models\Conference;
use App\Models\Flight;
use App\Models\Notification;
use App\Models\User;

class InvoiceFlightController extends Controller
{
    public function store(Request $request)
    {
        // Step 1: Initialize an array to store the generated or updated invoices
        $invoices = [];

        // Step 2: Loop through each flight_id in the provided array
        foreach ($request->flight_id as $flightId) {
            // Get data from the AcceptedFlight table by flight_id
            $acceptedFlight = AcceptedFlight::where('flight_id', $flightId)->first();

            // Check if AcceptedFlight exists for the given flight_id
            if (!$acceptedFlight) {
                return response()->json(['error' => "Accepted flight not found for flight_id: $flightId"], 404);
            }

            // Get the price from the AcceptedFlight
            $price = $acceptedFlight->price;

            // Get the Flight data
            $flight = Flight::where('flight_id', $flightId)->first();

            // Check if Flight exists for the given flight_id
            if (!$flight) {
                return response()->json(['error' => "Flight not found for flight_id: $flightId"], 404);
            }

            // Step 3: Calculate the total price based on flight information
            $calculatedPrice = $price; // Start with the price from AcceptedFlight

            // Conditionally add costs based on the flight's upgrade_class
            if ($flight->upgrade_class != 0 && $flight->business_class_upgrade_cost) {
                $calculatedPrice += $flight->business_class_upgrade_cost;
            }

            // Always include the reserved seat, additional baggage, and other additional costs if available
            if ($flight->reserved_seat_cost) {
                $calculatedPrice += $flight->reserved_seat_cost;
            }

            if ($flight->additional_baggage_cost) {
                $calculatedPrice += $flight->additional_baggage_cost;
            }

            if ($flight->other_additional_costs) {
                $calculatedPrice += $flight->other_additional_costs;
            }

            // Step 4: Check if an InvoiceFlight already exists for this flight_id
            $invoiceFlight = InvoiceFlight::where('flight_id', $flight->flight_id)->first();

            if ($invoiceFlight) {
                // Check if the invoice's status is 'approved'
                if ($invoiceFlight->status === 'approved') {
                    return response()->json(['error' => "Invoice for flight_id: $flightId is already approved and cannot be edited."], 200);
                }

                // Update existing InvoiceFlight
                $invoiceFlight->total_price = $calculatedPrice;
                $invoiceFlight->status = 'pending'; // Update status if needed
                $invoiceFlight->save();
            } else {
                // Create a new InvoiceFlight
                $invoiceFlight = new InvoiceFlight();
                $invoiceFlight->flight_id = $flight->flight_id;
                $invoiceFlight->total_price = $calculatedPrice;
                $invoiceFlight->status = 'pending'; // Default status
                $invoiceFlight->save();
            }

            // Add the generated or updated invoice to the invoices array
            $invoices[] = $invoiceFlight;

            // Step 5: Notify admins
            $admins = User::where('isAdmin', true)->get();

            foreach ($admins as $admin) {
                // Create a notification
                $notificationMessage = 'Invoice for flight ' . $flight->flight_number . ' has been processed.';

                $notification = Notification::create([
                    'user_id' => $admin->id,  // Admin user
                    'register_id' => $flight->user_id ?? null, // Flight's user_id or null
                    'message' => $notificationMessage,  // Notification message
                    'is_read' => false,  // Unread by default
                ]);

                // Broadcast the notification
                broadcast(new NotificationSent($notification))->toOthers();
            }
        }

        // Step 6: Return a response with the created or updated invoices data
        return response()->json([
            'success' => true,
            'invoices' => $invoices,
        ]);
    }

    public function pay($invoiceId)
    {
        try {
            // Step 1: Retrieve the invoice by invoice_id
            $invoice = InvoiceFlight::find($invoiceId);

            if (!$invoice) {
                return response()->json(['error' => 'Invoice not found.'], 404);
            }

            // Step 2: Retrieve the flight_id from the invoice
            $flightId = $invoice->flight_id; // Assuming the column is named `flight_id`

            // Step 3: Retrieve the flight record using the flight ID
            $flight = Flight::find($flightId);

            if (!$flight) {
                return response()->json(['error' => 'Flight not found.'], 404);
            }

            // Step 4: Update the invoice status to "approved"
            $invoice->status = 'approved';
            $invoice->save();

            // Step 5: Retrieve the user associated with the flight
            $user = $flight->user; // Get the user associated with the flight

            // Check if the user has the correct invoice
            if ($user && $user->id == $invoice->user_id) {
                // Step 6: Retrieve the main_user_id for this flight
                $mainUserId = $flight->main_user_id; // Get main_user_id from the flight record

                // If main_user_id equals flight_id, update the invoice status in InvoiceFlight table
                if ($mainUserId == $flightId) {
                    // Update the status to 'approved' for the records with the same flight_id
                    InvoiceFlight::where('flight_id', $flightId)
                        ->update(['status' => 'approved']);
                }
            }

            // Step 7: Retrieve the conference title
            $conferenceId = $user->conference_id; // Assuming the user has a conference_id
            $conference = Conference::find($conferenceId);

            if (!$conference) {
                return response()->json(['error' => 'Conference not found.'], 404);
            }

            $conferenceTitle = $conference->title;

            // Step 8: Send a notification to all admins
            $admins = User::where('isAdmin', true)->get();

            foreach ($admins as $admin) {
                $notificationMessage = 'The user ' . $user->name .
                    ' has completed the flight payment for flight: ' . $flight->flight_number .
                    ' in the conference: ' . $conferenceTitle;

                // Create a notification for the admin
                $notification = Notification::create([
                    'user_id' => $admin->id,
                    'register_id' => $user->id,
                    'conference_id' => $conferenceId,
                    'message' => $notificationMessage,
                    'is_read' => false,
                ]);

                // Broadcasting the notification to the admins
                broadcast(new NotificationSent($notification))->toOthers();
            }

            return response()->json(['success' => 'Payment completed and invoice status updated to approved.']);

        } catch (\Exception $e) {
            // Handle any exceptions
            return response()->json([
                'error' => 'An error occurred while processing the payment.',
                'message' => $e->getMessage() // Include the error message
            ], 500);
        }
    }




    public function getApprovedInvoices()
    {
        try {
            // استرجاع جميع الفواتير التي حالتها approved
            $approvedInvoices = InvoiceFlight::where('status', 'approved')
                ->get();

            if ($approvedInvoices->isEmpty()) {
                return response()->json(['message' => 'No approved invoices found.'], 404);
            }

            // تنسيق النتيجة لربط الجداول حسب المطلوب
            $result = $approvedInvoices->map(function ($invoice) {
                // 1. الحصول على بيانات الرحلة باستخدام flight_id من جدول InvoiceFlight
                $flight = Flight::find($invoice->flight_id);

                // 2. التأكد من وجود الرحلة
                if (!$flight) {
                    return null; // إذا لم يتم العثور على الرحلة
                }

                // 3. الحصول على بيانات المستخدم من جدول users باستخدام user_id من جدول الرحلة
                $user = User::find($flight->user_id);

                // 4. إعداد النتيجة
                return [
                    'invoice_id' => $invoice->id,
                    'status' => $invoice->status,
                    'total_price' => $invoice->total_price,
                    'flight' => $flight ? [
                        'id' => $flight->id,
                        'flight_number' => $flight->flight_number,
                        'departure_airport' => $flight->departure_airport,
                        'arrival_airport' => $flight->arrival_airport,
                        'departure_date' => $flight->departure_date,
                        'arrival_date' => $flight->arrival_date,
                        'seat_preference' => $flight->seat_preference,
                        // إضافة أي معلومات إضافية تحتاجها من جدول الرحلات
                    ] : null,
                    'user' => $user ? [
                        'id' => $user->id,
                        'name' => $user->name,
                        'email' => $user->email,
                        'phone_number' => $user->phone_number,
                        'whatsapp_number' => $user->whatsapp_number,
                        'isAdmin' => $user->isAdmin,
                        // إضافة أي معلومات إضافية تحتاجها من جدول المستخدمين
                    ] : null,
                ];
            });

            // تنظيف النتائج (إزالة أي قيم null)
            $result = $result->filter(function ($invoice) {
                return $invoice !== null;
            });

            // إرجاع النتيجة
            return response()->json(['approved_invoices' => $result], 200);

        } catch (\Exception $e) {
            // التعامل مع الاستثناءات
            return response()->json([
                'error' => 'An error occurred while retrieving approved invoices.',
                'message' => $e->getMessage()
            ], 500);
        }
    }


    public function addTicketPdf(Request $request, $invoiceId)
    {
        // التحقق من وجود السجل في جدول الفواتير
        $invoice = InvoiceFlight::find($invoiceId);
        if (!$invoice) {
            return response()->json(['error' => 'Invoice not found.'], 404);
        }

        // التحقق من أن حالة الفاتورة هي "approved"
        if ($invoice->status != 'approved') {
            return response()->json(['error' => 'Invoice status must be approved before adding a ticket PDF.'], 400);
        }

        // التحقق من أن الملف هو PDF
        if ($request->hasFile('ticketPDF')) {
            $file = $request->file('ticketPDF');

            // التحقق من نوع الملف (يجب أن يكون PDF)
            if ($file->getClientOriginalExtension() != 'pdf') {
                return response()->json(['error' => 'The file must be a PDF.'], 400);
            }

            // تخزين الملف في مجلد 'ticketpdf' داخل المجلد العام
            $filePath = $file->store('ticketpdf', 'public'); // تخزين في مجلد public/ticketpdf

            // تحديث السجل وتخزين مسار الملف
            $invoice->ticketPDF = $filePath;
            $invoice->save();

            // الحصول على البيانات من جدول flights
            $flight = Flight::find($invoice->flight_id); // استرجاع السجل المتعلق بالـ flight
            if (!$flight) {
                return response()->json(['error' => 'Flight not found.'], 404);
            }

            // الحصول على user_id من جدول flights وإذا لم يكن موجودًا، تعيين null
            $user_id = $flight->user_id ?? null;

            // إذا كان user_id غير موجود، عدم إرسال الإشعار
            if ($user_id !== null) {
                // الحصول على conference_id من جدول users وإذا لم يكن موجودًا، تعيين null
                $conference_id = $flight->user ? $flight->user->conference_id : null;

                // إرسال إشعار إلى المستخدم بخصوص جاهزية التكت
                $userNotification = Notification::create([
                    'user_id' => $user_id,
                    'message' => 'Your flight ticket is now ready and available for download.',
                    'conference_id' => $conference_id,
                    'is_read' => false, // تعيين القيمة إلى false حتى يقرأ المستخدم
                ]);

                // بث الإشعار
                broadcast(new NotificationSent($userNotification));
            }

            return response()->json(['success' => 'Ticket PDF added successfully.', 'invoice' => $invoice]);
        }

        return response()->json(['error' => 'No file uploaded.'], 400);
    }




    public function getByFlightId($flightId)
    {
        // Retrieve the flights based on the flight_id or main_user_id
        $flights = Flight::where('flight_id', $flightId)
            ->orWhere('main_user_id', $flightId)
            ->get();

        // If no flights are found, return an error
        if ($flights->isEmpty()) {
            return response()->json(['error' => "No flights found for flight_id: $flightId"], 404);
        }

        // Get all flight_ids from the retrieved flights
        $flightIds = $flights->pluck('flight_id')->toArray();

        // Retrieve all invoice_flights that match the flight_ids
        $invoiceFlights = InvoiceFlight::whereIn('flight_id', $flightIds)->get();

        // If no invoices are found, return an error
        if ($invoiceFlights->isEmpty()) {
            return response()->json(['error' => "No invoices found for the selected flights"], 404);
        }

        // Return the found invoice flights
        return response()->json([
            'success' => true,
            'invoice_flights' => $invoiceFlights,
        ]);
    }


}
