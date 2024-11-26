<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Invoice;
use App\Models\Conference;
use App\Models\BoothCost;
use App\Models\SponsorshipOption;
use App\Models\SponsorInvoice;
use App\Models\Sponsorship;
use Exception;
use Illuminate\Support\Facades\Auth;

class InvoiceController extends Controller
{
    public function createInvoice(Request $request)
    {
        // التحقق من صحة البيانات المدخلة
        try {
            $validated = $request->validate([
                'user_id' => 'required|exists:users,id',
                'user_name' => 'required|string|max:255',
                'conference_sponsorship_option_ids' => 'nullable|array',
                'booth_cost_ids' => 'nullable|array',
                'sponsorship_option_ids' => 'nullable|array',
                'conference_id' => 'required|exists:conferences,id',
                'additional_cost_for_shell_scheme_booth' => 'nullable|boolean',
                'exhibit_number' => 'nullable|integer', // إضافة رقم المعرض

            ]);
            if ($validated['exhibit_number'] && SponsorInvoice::where('exhibit_number', $validated['exhibit_number'])->exists()) {
                return response()->json(['message' => 'The exhibit number already exists. Please enter a unique number.'], 422);
            }
            
            
            // استرجاع المؤتمر بناءً على ID المؤتمر
            $conference = Conference::find($validated['conference_id']);
            
            if (!$conference) {
                return response()->json(['message' => 'Conference not found!'], 404);
            }
    
            // حساب إجمالي السعر
            $totalPrice = 0;
    
            // حساب سعر الخيارات الخاصة بالرعاية للمؤتمر
            if ($validated['conference_sponsorship_option_ids']) {
                $conferenceSponsorshipOptions = Sponsorship::whereIn('id', $validated['conference_sponsorship_option_ids'])
                    ->where('conference_id', $validated['conference_id'])
                    ->get();
                $conferenceSponsorshipTotal = $conferenceSponsorshipOptions->sum(function ($option) {
                    return floatval($option->price); // تحويل إلى عدد عشري
                        
                });
                // إضافة القيمة الإجمالية لخيار الرعاية
                $totalPrice += $conferenceSponsorshipTotal;

            }
            
            // حساب تكلفة البوث
            if ($validated['booth_cost_ids']) {
                $boothCosts = BoothCost::whereIn('id', $validated['booth_cost_ids'])
                    ->where('conference_id', $validated['conference_id'])
                    ->get();
                $boothCostTotal = $boothCosts->sum(function ($cost) {
                    return floatval($cost->cost); // تحويل إلى عدد عشري
                });
                // إضافة قيمة تكلفة البوث
                $totalPrice += $boothCostTotal;
            }
    
            // حساب الخيارات الخاصة برعاية المؤتمر
            if ($validated['sponsorship_option_ids']) {
                $sponsorshipOptions = SponsorshipOption::whereIn('id', $validated['sponsorship_option_ids'])
                    ->where('conference_id', $validated['conference_id'])
                    ->get();
            
                // تحقق من محتويات الـ $sponsorshipOptions
                // dd($sponsorshipOptions);  // هنا يمكنك التحقق من الخيارات المسترجعة
                
                $sponsorshipOptionTotal = $sponsorshipOptions->sum(function ($option) {
                    // التحقق من أن القيمة ليست null، وإذا كانت null نعتبرها 0
                    // dd($option->price); // هنا تحقق من القيمة التي يتم جمعها
                    return $option->price !== null ? floatval($option->price) : 0;
                });
            
                // تحقق من المجموع الكلي
                // dd($sponsorshipOptionTotal);  // هنا تحقق من المجموع الذي يتم حسابه
                $totalPrice += $sponsorshipOptionTotal;
            }
            
            
    
            // إذا كان هناك تكلفة إضافية لبوث النظام الصدفي
            if ($validated['additional_cost_for_shell_scheme_booth'] === true) {
                $totalPrice += 50; // إضافة 50 دولار إذا كانت القيمة true
            }
    
            // تخزين البيانات في قاعدة البيانات
            $invoice = new SponsorInvoice();
            $invoice->user_name = $validated['user_name'];
            $invoice->total_amount = number_format($totalPrice, 2, '.', ''); // تأكيد أن المجموع هو قيمة عددية مع تنسيق
            $invoice->conference_sponsorship_option_ids = json_encode($validated['conference_sponsorship_option_ids'] ?? []);
            $invoice->booth_cost_ids = json_encode($validated['booth_cost_ids'] ?? []);
            $invoice->sponsorship_option_ids = json_encode($validated['sponsorship_option_ids'] ?? []);
            $invoice->conference_id = $validated['conference_id'];
            $invoice->user_id = $validated['user_id'];
            $invoice->exhibit_number = $validated['exhibit_number'] ?? null; // إضافة رقم المعرض

            $invoice->save();
    
            // إرجاع استجابة بنجاح
            return response()->json([
                'message' => 'Invoice created successfully!',
                'invoice' => $invoice
            ], 201);
    
        } catch (Exception $e) {
            // التعامل مع الأخطاء وإرجاع رسالة مفصلة للمستخدم
            return response()->json([
                'message' => 'An error occurred while creating the invoice.',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    // public function getInvoiceByUserIdAndConferenceId($conferenceId)
    // {
    //     try {
    //         // الحصول على user_id من التوكن
    //         $userId = Auth::id();  // أو Auth::user()->id في حال كان التوثيق بواسطة Sanatum أو JWT
    
    //         // استرجاع الفواتير بناءً على user_id و conference_id
    //         $invoices = SponsorInvoice::where('user_id', $userId)
    //                                   ->where('conference_id', $conferenceId)
    //                                   ->get();
            
    //         // التحقق إذا كانت هناك فواتير للمستخدم في المؤتمر المحدد
    //         if ($invoices->isEmpty()) {
    //             return response()->json(['message' => 'No invoices found for this user in the specified conference.'], 404);
    //         }
    
    //         // إرجاع الفواتير للمستخدم في المؤتمر المحدد
    //         return response()->json([
    //             'message' => 'Invoices retrieved successfully!',
    //             'invoices' => $invoices
    //         ], 200);
            
    //     } catch (Exception $e) {
    //         // التعامل مع الأخطاء وإرجاع رسالة مفصلة للمستخدم
    //         return response()->json([
    //             'message' => 'An error occurred while retrieving the invoices.',
    //             'error' => $e->getMessage()
    //         ], 500);
    //     }

    // }
    public function getInvoiceByUserIdAndConferenceId($conferenceId)
{
    try {
        // الحصول على user_id من التوكن
        $userId = Auth::id(); // أو Auth::user()->id إذا كنت تستخدم JWT
        
        // استرجاع الفواتير بناءً على user_id و conference_id
        $invoices = SponsorInvoice::where('user_id', $userId)
            ->where('conference_id', $conferenceId)
            ->get();

        // التحقق إذا كانت هناك فواتير للمستخدم في المؤتمر المحدد
        if ($invoices->isEmpty()) {
            return response()->json(['message' => 'No invoices found for this user in the specified conference.'], 404);
        }

        // تجهيز البيانات مع التفاصيل
        $invoicesWithDetails = $invoices->map(function ($invoice) {
            // الحصول على تفاصيل الخيارات المختارة
            $conferenceSponsorshipDetails = Sponsorship::whereIn('id', json_decode($invoice->conference_sponsorship_option_ids, true))->get(['item', 'price']);
            $boothCostDetails = BoothCost::whereIn('id', json_decode($invoice->booth_cost_ids, true))->get(['size', 'cost']);
            $sponsorshipOptionDetails = SponsorshipOption::whereIn('id', json_decode($invoice->sponsorship_option_ids, true))->get(['title', 'price']);

            return [
                'invoice_id' => $invoice->id,
                'user_name' => $invoice->user_name,
                'total_amount' => $invoice->total_amount,
                'exhibit_number' => $invoice->exhibit_number,
                'created_at' => $invoice->created_at,
                'conference_sponsorship_details' => $conferenceSponsorshipDetails,
                'booth_cost_details' => $boothCostDetails,
                'sponsorship_option_details' => $sponsorshipOptionDetails,
            ];
        });

        // إرجاع البيانات المجهزة
        return response()->json([
            'message' => 'Invoices retrieved successfully!',
            'invoices' => $invoicesWithDetails
        ], 200);

    } catch (Exception $e) {
        // التعامل مع الأخطاء وإرجاع رسالة مفصلة للمستخدم
        return response()->json([
            'message' => 'An error occurred while retrieving the invoices.',
            'error' => $e->getMessage()
        ], 500);
    }
}

    // public function getAllInvoices()
    // {
    //     try {
    //         // استرجاع جميع الفواتير مع العلاقات المرتبطة
    //         $invoices = SponsorInvoice::with([
    //             'user', // العلاقة مع جدول المستخدمين
    //             'conference', // العلاقة مع جدول المؤتمرات
    //         ])->get();
    
    //         // تنسيق البيانات وإرجاعها
    //         return response()->json([
    //             'message' => 'Invoices retrieved successfully!',
    //             'invoices' => $invoices,
    //         ], 200);
    //     } catch (Exception $e) {
    //         // التعامل مع الأخطاء
    //         return response()->json([
    //             'message' => 'An error occurred while retrieving invoices.',
    //             'error' => $e->getMessage(),
    //         ], 500);
    //     }
    // }
    
public function getAllInvoices(Request $request)
{
    try {
        $search = $request->input('search', '');
        $perPage = $request->input('per_page', 10); // تحديد عدد النتائج لكل صفحة

        // استرجاع الفواتير مع pagination
        $invoices = SponsorInvoice::with(['user', 'conference'])
            ->when($search, function ($query) use ($search) {
                $query->where('user_name', 'LIKE', "%{$search}%")
                    ->orWhereHas('conference', function ($q) use ($search) {
                        $q->where('title', 'LIKE', "%{$search}%");
                    });
            })
            ->paginate($perPage); // استخدام paginate بدلاً من get

        // تعديل هيكل البيانات إذا لزم
        $invoicesWithDetails = $invoices->items(); // بدلاً من getCollection()، استخدم items()

        // نقوم بتعديل البيانات لتحتوي على التفاصيل المطلوبة
        $invoicesWithDetails = array_map(function ($invoice) {
            $conferenceSponsorshipIds = json_decode($invoice->conference_sponsorship_option_ids, true) ?? [];
            $boothCostIds = json_decode($invoice->booth_cost_ids, true) ?? [];
            $sponsorshipOptionIds = json_decode($invoice->sponsorship_option_ids, true) ?? [];

            $conferenceSponsorshipDetails = Sponsorship::whereIn('id', $conferenceSponsorshipIds)->get(['item', 'price']);
            $boothCostDetails = BoothCost::whereIn('id', $boothCostIds)->get(['size', 'cost']);
            $sponsorshipOptionDetails = SponsorshipOption::whereIn('id', $sponsorshipOptionIds)->get(['title', 'price']);

            return [
                'invoice_id' => $invoice->id,
                'user_name' => $invoice->user_name,
                'conference_title' => $invoice->conference->title ?? 'N/A',
                'total_amount' => $invoice->total_amount,
                'exhibit_number' => $invoice->exhibit_number,
                'created_at' => $invoice->created_at,
                'conference_sponsorship_details' => $conferenceSponsorshipDetails,
                'booth_cost_details' => $boothCostDetails,
                'sponsorship_option_details' => $sponsorshipOptionDetails,
            ];
        }, $invoicesWithDetails); // تعديل البيانات بالـ map

        // إعادة البيانات مع pagination metadata
        return response()->json([
            'message' => 'Invoices retrieved successfully!',
            'invoices' => [
                'data' => $invoicesWithDetails,
                'current_page' => $invoices->currentPage(),
                'last_page' => $invoices->lastPage(),
                'per_page' => $invoices->perPage(),
                'total' => $invoices->total(),
            ],
        ], 200);
    } catch (\Exception $e) {
        return response()->json([
            'message' => 'An error occurred while retrieving invoices.',
            'error' => $e->getMessage(),
        ], 500);
    }
}

    
    
    
    
}
