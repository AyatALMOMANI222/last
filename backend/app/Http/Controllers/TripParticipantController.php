<?php

namespace App\Http\Controllers;

use App\Models\TripOptionsParticipant;
use App\Models\TripParticipant;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TripParticipantController extends Controller
{
    public function addParticipant(Request $request)
    {
        $userId = Auth::id();

        if (!$userId) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        try {
            // التحقق من صحة المدخلات
            $validatedData = $request->validate([
                'trip_id' => 'required|exists:trips,id',
                'name' => 'required|string|max:255',
                'nationality' => 'required|string|max:255',
                'phone_number' => 'required|string|max:20',
                'whatsapp_number' => 'required|string|max:20',
                'is_companion' => 'required|boolean',
                'include_accommodation' => 'boolean',
                // 'accommodation_type' => 'nullable|string',
                // 'tent_type' => 'nullable|string',
                'accommodation_stars' => 'nullable|integer|min:1|max:5',
                'nights_count' => 'nullable|integer|min:1',
                'check_in_date' => 'nullable|date',
                'check_out_date' => 'nullable|date|after_or_equal:check_in_date',
            ]);

            // تحديد main_user_id و user_id بناءً على is_companion
            if ($validatedData['is_companion']) {
                $participantData = [
                    'user_id' => null, // user_id فارغ
                    'main_user_id' => $userId, // main_user_id يساوي user_id
                ];
            } else {
                $participantData = [
                    'user_id' => $userId, // user_id يساوي قيمة التوكن
                    'main_user_id' => null, // main_user_id فارغ
                ];
            }

            // دمج باقي بيانات المشارك
            $participantData = array_merge($participantData, [
                'trip_id' => $validatedData['trip_id'],
                'name' => $validatedData['name'],
                'nationality' => $validatedData['nationality'],
                'phone_number' => $validatedData['phone_number'],
                'whatsapp_number' => $validatedData['whatsapp_number'],
                'is_companion' => $validatedData['is_companion'],
                'include_accommodation' => $validatedData['include_accommodation'] ?? false,
                // 'accommodation_type' => $validatedData['accommodation_type'],
                // 'tent_type' => $validatedData['tent_type'],
                'accommodation_stars' => $validatedData['accommodation_stars'],
                'nights_count' => $validatedData['nights_count'],
                'check_in_date' => $validatedData['check_in_date'],
                'check_out_date' => $validatedData['check_out_date'],
            ]);

            // إنشاء المشارك
            $participant = TripParticipant::create($participantData);

            return response()->json(['message' => 'Participant added successfully', 'participant' => $participant], 201);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => $e->validator->errors()->first()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }



    // public function storeUserAndParticipant(Request $request)
    // {
    //     if (!Auth::id()) {
    //         return response()->json(['success' => false, 'message' => 'يجب تسجيل الدخول.'], 401);
    //     }
    //     $userId = Auth::id();
    
    //     $validatedData = $request->validate([
    //         'trip_id' => 'required|exists:trips,id', // تأكد من وجود الرحلة
    //         'name' => 'nullable|string', // اسم المشارك الرئيسي، يمكن أن يكون فارغًا إذا لم يكن مرافقًا
    //         'nationality' => 'nullable|string', // جنسية المشارك الرئيسي
    //         'phone_number' => 'nullable|string', // رقم الهاتف
    //         'whatsapp_number' => 'nullable|string', // رقم الواتساب
    //         'is_companion' => 'boolean', // هل هو مرافق أم لا
    //         'include_accommodation' => 'boolean', // هل تشمل الإقامة؟
    //         'accommodation_stars' => 'nullable|integer', // عدد النجوم للإقامة
    //         'nights_count' => 'nullable|integer', // عدد الليالي
    //         'check_in_date' => 'nullable|date', // تاريخ تسجيل الدخول للإقامة
    //         'check_out_date' => 'nullable|date', // تاريخ تسجيل الخروج للإقامة
    //         'companions' => 'array', // مصفوفة المرافقين
    //         'companions.*.name' => 'required|string', // اسم المرافق
    //         'companions.*.nationality' => 'required|string', // جنسية المرافق
    //         'companions.*.phone_number' => 'required|string', // رقم هاتف المرافق
    //         'companions.*.whatsapp_number' => 'required|string', // رقم الواتساب للمرافق
    //         'companions.*.is_companion' => 'boolean', // هل هو مرافق
    //         'companions.*.include_accommodation' => 'boolean', // هل تشمل الإقامة؟
    //         'companions.*.accommodation_stars' => 'nullable|integer', // عدد النجوم للإقامة
    //         'companions.*.nights_count' => 'nullable|integer', // عدد الليالي للإقامة
    //     ]);
    
    //     try {
    //         // إعداد بيانات المشارك الرئيسي
    //         $mainParticipantData = [
    //             'user_id' => $userId, // استخدام user_id من التوكن
    //             'trip_id' => $validatedData['trip_id'],
    //             'main_user_id' => $validatedData['is_companion'] ? $userId : null, // المشارك الرئيسي إذا كان مرافقًا نعين user_id
    //             'is_companion' => $validatedData['is_companion'] ?? false, // افتراضيًا هو ليس مرافقًا
    //             'include_accommodation' => $validatedData['include_accommodation'],
    //             'accommodation_stars' => $validatedData['accommodation_stars'],
    //             'nights_count' => $validatedData['nights_count'],
    //             'check_in_date' => $validatedData['check_in_date'],
    //             'check_out_date' => $validatedData['check_out_date'],
    //         ];
    
    //         // إذا كان المستخدم مرافقًا (is_companion == true)، نضيف الحقول التالية
    //         if ($validatedData['is_companion']) {
    //             $mainParticipantData['name'] = $validatedData['name'];
    //             $mainParticipantData['nationality'] = $validatedData['nationality'];
    //             $mainParticipantData['phone_number'] = $validatedData['phone_number'];
    //             $mainParticipantData['whatsapp_number'] = $validatedData['whatsapp_number'];
    //         }
    
    //         // إضافة المشارك الرئيسي في جدول trip_participants
    //         $mainParticipant = TripParticipant::create($mainParticipantData);
    
    //         // إضافة المرافقين (companions) في جدول trip_participants
    //         foreach ($validatedData['companions'] as $companion) {
    //             TripParticipant::create([
    //                 'user_id' => null, // المرافق لا يحتاج إلى user_id
    //                 'trip_id' => $validatedData['trip_id'],
    //                 'main_user_id' => $validatedData['is_companion'] ? $userId : $mainParticipant->id, // ربط المرافق بالمشارك الرئيسي
    //                 'name' => $companion['name'],
    //                 'nationality' => $companion['nationality'],
    //                 'phone_number' => $companion['phone_number'],
    //                 'whatsapp_number' => $companion['whatsapp_number'],
    //                 'is_companion' => true, // هو مرافق
    //                 'include_accommodation' => $companion['include_accommodation'],
    //                 'accommodation_stars' => $companion['accommodation_stars'],
    //                 'nights_count' => $companion['nights_count'],
    //                 'check_in_date' => null, // يمكن تعديلها حسب الحاجة
    //                 'check_out_date' => null, // يمكن تعديلها حسب الحاجة
    //             ]);
    //         }
    
    //         // استجابة عند النجاح
    //         return response()->json(['success' => true, 'message' => 'تم إضافة المشارك والمرافقين بنجاح.'], 201);
    //     } catch (\Exception $e) {
    //         // استجابة عند حدوث خطأ
    //         return response()->json(['success' => false, 'message' => 'حدث خطأ أثناء إضافة البيانات: ' . $e->getMessage()], 500);
    //     }
    // }
 
    public function storeUserAndParticipant(Request $request)
    {
        if (!Auth::id()) {
            return response()->json(['success' => false, 'message' => 'يجب تسجيل الدخول.'], 401);
        }
    
        $userId = Auth::id();
    
        $validatedData = $request->validate([
            'trip_id' => 'required|exists:trips,id',
            'name' => 'nullable|string',
            'nationality' => 'nullable|string',
            'phone_number' => 'nullable|string',
            'whatsapp_number' => 'nullable|string',
            'is_companion' => 'boolean',
            'include_accommodation' => 'boolean',
            'accommodation_stars' => 'nullable|integer',
            'nights_count' => 'nullable|integer',
            'check_in_date' => 'nullable|date',
            'check_out_date' => 'nullable|date',
            'companions' => 'array',
            'companions.*.name' => 'required|string',
            'companions.*.nationality' => 'required|string',
            'companions.*.phone_number' => 'required|string',
            'companions.*.whatsapp_number' => 'required|string',
            'companions.*.is_companion' => 'boolean',
            'companions.*.include_accommodation' => 'boolean',
            'companions.*.accommodation_stars' => 'nullable|integer',
            'companions.*.nights_count' => 'nullable|integer',
            'selectedOptions' => 'array',
            'selectedOptions.*.option_id' => 'required|exists:additional_options,id',
            'selectedOptions.*.option_name' => 'required|string',
            'selectedOptions.*.value' => 'boolean',
        ]);
    
        try {
            // إعداد بيانات المشارك الرئيسي
            $mainParticipantData = [
                'user_id' => $userId,
                'trip_id' => $validatedData['trip_id'],
                'main_user_id' => $validatedData['is_companion'] ? $userId : null,
                'is_companion' => $validatedData['is_companion'] ?? false,
                'include_accommodation' => $validatedData['include_accommodation'],
                'accommodation_stars' => $validatedData['accommodation_stars'],
                'nights_count' => $validatedData['nights_count'],
                'check_in_date' => $validatedData['check_in_date'],
                'check_out_date' => $validatedData['check_out_date'],
            ];
    
            // إذا كان المستخدم مرافقًا (is_companion == true)، نضيف الحقول التالية
            if ($validatedData['is_companion']) {
                $mainParticipantData['name'] = $validatedData['name'];
                $mainParticipantData['nationality'] = $validatedData['nationality'];
                $mainParticipantData['phone_number'] = $validatedData['phone_number'];
                $mainParticipantData['whatsapp_number'] = $validatedData['whatsapp_number'];
            }
    
            // إضافة المشارك الرئيسي في جدول trip_participants
            $mainParticipant = TripParticipant::create($mainParticipantData);
    
            // Array to hold the IDs of companions
            $companionIds = [];
    
            // إضافة المرافقين (companions) في جدول trip_participants
            foreach ($validatedData['companions'] as $companion) {
                $companionData = [
                    'user_id' => null,
                    'trip_id' => $validatedData['trip_id'],
                    'main_user_id' => $validatedData['is_companion'] ? $userId : $mainParticipant->id,
                    'name' => $companion['name'],
                    'nationality' => $companion['nationality'],
                    'phone_number' => $companion['phone_number'],
                    'whatsapp_number' => $companion['whatsapp_number'],
                    'is_companion' => true,
                    'include_accommodation' => $companion['include_accommodation'],
                    'accommodation_stars' => $companion['accommodation_stars'],
                    'nights_count' => $companion['nights_count'],
                    'check_in_date' => null,
                    'check_out_date' => null,
                ];
    
                // Create the companion participant and store the ID
                $createdCompanion = TripParticipant::create($companionData);
                $companionIds[] = $createdCompanion->id; // Store the ID of the newly created companion
            }
    
            // Adding selected options to the trip_options_participants table
            // For main participant
            foreach ($validatedData['selectedOptions'] as $option) {
                TripOptionsParticipant::create([
                    'trip_id' => $validatedData['trip_id'],
                    'option_id' => $option['option_id'],
                    'participant_id' => $mainParticipant->id, // Using the main participant ID
                ]);
            }
    
            // For companions
            foreach ($companionIds as $companionId) {
                foreach ($validatedData['selectedOptions'] as $option) {
                    TripOptionsParticipant::create([
                        'trip_id' => $validatedData['trip_id'],
                        'option_id' => $option['option_id'],
                        'participant_id' => $companionId, // Using the companion's ID
                    ]);
                }
            }
    
            // استجابة عند النجاح
            return response()->json(['success' => true, 'message' => 'تم إضافة المشارك والمرافقين بنجاح.', 'companion_ids' => $companionIds], 201);
        } catch (\Exception $e) {
            // استجابة عند حدوث خطأ
            return response()->json(['success' => false, 'message' => 'حدث خطأ أثناء إضافة البيانات: ' . $e->getMessage()], 500);
        }
    }
    
}




