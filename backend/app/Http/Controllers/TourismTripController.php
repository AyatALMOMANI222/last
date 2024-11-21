<?php

namespace App\Http\Controllers;

use App\Models\TourismTrip;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Notification;
use App\Notifications\EmailNotification;
class TourismTripController extends Controller
{


    
    public function create(Request $request)
    {
        try {
            // التحقق من البيانات المدخلة
            $validatedData = $request->validate([
                'title' => 'required|string',
                'firstname' => 'required|string',
                'lastname' => 'required|string',
                'emailaddress' => 'required|email',
                'phonenumber' => 'required|string',
                'nationality' => 'required|string',
                'country' => 'required|string',
                'arrivalPoint' => 'required|string',
                'departurePoint' => 'required|string',
                'arrivalDate' => 'required|date',
                'departureDate' => 'required|date',
                'arrivalTime' => 'required|date_format:H:i',
                'departureTime' => 'required|date_format:H:i',
                'preferredHotel' => 'nullable|string',
                'duration' => 'required|integer',
                'adults' => 'required|integer',
                'children' => 'required|integer',
                'preferredDestination' => 'required|array',
                'activities' => 'required|array',
            ]);
    
            // إنشاء الرحلة السياحية
            $tourismTrip = TourismTrip::create($validatedData);
    
            // إرسال البريد الإلكتروني باستخدام Notification
            $message = "A new tourism trip has been created:\n" . print_r($validatedData, true);
    
            // إرسال الإشعار عبر البريد الإلكتروني
            Notification::route('mail', 'ayatalmomani655@gmail.com')
                ->notify(new EmailNotification($message));
    
            // إرجاع استجابة بالنجاح
            return response()->json([
                'message' => 'Tourism trip created successfully, and email notification sent!',
                'trip' => $tourismTrip
            ], 201);
        } catch (ValidationException $e) {
            // في حال كانت البيانات المدخلة غير صالحة، أرسل رسالة خطأ
            return response()->json([
                'error' => 'Validation failed!',
                'message' => $e->errors() // عرض تفاصيل الأخطاء
            ], 422);
        } catch (\Exception $e) {
            // في حال حدوث أي خطأ آخر غير متوقع
            return response()->json([
                'error' => 'An unexpected error occurred.',
                'message' => $e->getMessage() // عرض تفاصيل الخطأ
            ], 500);
        }
    }
    public function getAllTourismTrips(Request $request)
    {
        try {
            // تحقق من وجود معايير البحث
            $search = $request->input('search');
    
            // تحديد عدد العناصر في كل صفحة
            $perPage = 10; // يمكنك تعديل الرقم حسب الحاجة
    
            // استعلام جلب الرحلات السياحية
            $query = TourismTrip::query();
    
            // تطبيق التصفية بالبحث إذا تم تقديمها
            if ($search) {
                $query->where('title', 'like', '%' . $search . '%')
                      ->orWhere('firstname', 'like', '%' . $search . '%')
                      ->orWhere('lastname', 'like', '%' . $search . '%');
            }
    
            // تطبيق خاصية التصفح
            $tourismTrips = $query->paginate($perPage);
    
            // قائمة الأنشطة الثابتة
            $staticActivities = [
                'Hiking',
                'Camping',
                'Photography',
                'Scuba Diving',
                'Rock Climbing'
            ];
    
            // تحويل العناصر إلى مجموعة وتطبيق الأنشطة الثابتة
            $dataWithActivities = collect($tourismTrips->items())->map(function ($trip) use ($staticActivities) {
                $trip->staticActivities = $staticActivities; // إرفاق الأنشطة الثابتة
                return $trip;
            });
    
            // إرجاع النتيجة بتنسيق JSON
            return response()->json([
                'status' => 'success',
                'data' => $dataWithActivities,       // العناصر في الصفحة الحالية مع الأنشطة الثابتة
                'total' => $tourismTrips->total(),   // العدد الإجمالي للعناصر
                'per_page' => $tourismTrips->perPage(), // عدد العناصر في كل صفحة
                'current_page' => $tourismTrips->currentPage(), // رقم الصفحة الحالية
                'total_pages' => $tourismTrips->lastPage(), // العدد الإجمالي للصفحات
            ], 200);
        } catch (\Exception $e) {
            // معالجة الأخطاء
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to retrieve tourism trips: ' . $e->getMessage(),
            ], 500);
        }
    }
    
    
    
    
}
