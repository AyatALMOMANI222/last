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
            $userId = Auth::id();  // أو Auth::user()->id في حال كان التوثيق بواسطة Sanatum أو JWT
    
            // استرجاع الفواتير بناءً على user_id و conference_id مع تحميل العلاقات الخاصة بالأسعار
            $invoices = SponsorInvoice::where('user_id', $userId)
                                      ->where('conference_id', $conferenceId)
                                      ->with([
                                          'conference', 
                                          'boothCosts',  // علاقة تكلفة الأجنحة
                                          'sponsorshipOptions',  // علاقة الخيارات الترويجية
                                          'sponsorships'  // علاقة الرعاية
                                      ])
                                      ->get();
    
            // التحقق إذا كانت هناك فواتير للمستخدم في المؤتمر المحدد
            if ($invoices->isEmpty()) {
                return response()->json(['message' => 'No invoices found for this user in the specified conference.'], 404);
            }
    
            // جلب البيانات المرتبطة بكل فاتورة مثل الأسعار
            $invoiceDetails = $invoices->map(function($invoice) {
                $totalAmount = 0;
                $invoiceData = [
                    'exhibit_number' => $invoice->exhibit_number,
                    'user_name' => $invoice->user_name,
                    'conference_id' => $invoice->conference_id,
                    'conference_name' => $invoice->conference->name,  // افتراض أنك تريد اسم المؤتمر
                    'booth_costs' => $invoice->boothCosts->map(function($boothCost) {
                        return [
                            // 'size' => $boothCost->size,
                            'cost' => $boothCost->cost,  // تكلفة الجناح
                        ];
                    }),
                    'sponsorship_options' => $invoice->sponsorshipOptions->map(function($sponsorshipOption) {
                        return [
                            'title' => $sponsorshipOption->title,  // اسم الخيار الترويجي
                            'price' => $sponsorshipOption->price,  // السعر المرتبط بالخيار الترويجي
                        ];
                    }),
                    'sponsorships' => $invoice->sponsorships->map(function($sponsorship) {
                        return [
                            'item' => $sponsorship->item,  // اسم عنصر الرعاية
                            'price' => $sponsorship->price,  // السعر المرتبط بالرعاية
                        ];
                    }),
                ];
    
                // حساب المجموع الإجمالي بناءً على البيانات المرتبطة
                $totalAmount += $invoice->boothCosts->sum('cost');  // إضافة التكلفة الإجمالية من الجداول المرتبطة
                $totalAmount += $invoice->sponsorshipOptions->sum('price');  // إضافة أسعار الخيارات الترويجية
                $totalAmount += $invoice->sponsorships->sum('price');  // إضافة أسعار الرعاية
                $invoiceData['total_amount'] = $totalAmount;
    
                return $invoiceData;
            });
    
            // إرجاع الفواتير مع التفاصيل المرتبطة
            return response()->json([
                'message' => 'Invoices retrieved successfully!',
                'invoices' => $invoiceDetails
            ], 200);
    
        } catch (Exception $e) {
            // التعامل مع الأخطاء وإرجاع رسالة مفصلة للمستخدم
            return response()->json([
                'message' => 'An error occurred while retrieving the invoices.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
     

}
