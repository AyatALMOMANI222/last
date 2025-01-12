<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PayPal\Rest\ApiContext;
use PayPal\Auth\OAuthTokenCredential;
use PayPal\Api\Payment;
use PayPal\Api\PaymentExecution;
use PayPal\Api\RedirectUrls;
use PayPal\Api\Payer;
use PayPal\Api\Transaction;
use PayPal\Api\Amount;
use PayPal\Api\ItemList;
use PayPal\Api\Item;

class PayPalController extends Controller
{
    private $_api_context;

    public function __construct()
    {
        $paypal_conf = config('services.paypal');
        $this->_api_context = new ApiContext(new OAuthTokenCredential($paypal_conf['client_id'], $paypal_conf['secret']));
        $this->_api_context->setConfig($paypal_conf['settings']);
    }

    public function createPayment(Request $request)
    {
        // إعداد تفاصيل الدفع
        $payer = new Payer();
        $payer->setPaymentMethod('paypal');

        $amount = new Amount();
        $amount->setCurrency('USD')
            ->setTotal($request->total); // المبلغ الذي سيتم دفعه

        $transaction = new Transaction();
        $transaction->setAmount($amount)
            ->setDescription('Payment description');

        $redirect_urls = new RedirectUrls();
        $redirect_urls->setReturnUrl(route('paypal.success'))
            ->setCancelUrl(route('paypal.cancel'));

        $payment = new Payment();
        $payment->setIntent('sale')
            ->setPayer($payer)
            ->setTransactions([$transaction])
            ->setRedirectUrls($redirect_urls);

        try {
            $payment->create($this->_api_context);
        } catch (\Exception $ex) {
            return redirect()->route('paypal.cancel');
        }

        return redirect($payment->getApprovalLink());
    }

    public function success(Request $request)
    {
        $paymentId = $request->paymentId;
        $payerId = $request->PayerID;
        $payment = Payment::get($paymentId, $this->_api_context);
        $execution = new PaymentExecution();
        $execution->setPayerId($payerId);
        $result = $payment->execute($execution, $this->_api_context);

        if ($result->getState() == 'approved') {
            return redirect()->route('payment.success');
        }

        return redirect()->route('paypal.cancel');
    }

    public function cancel()
    {
        return redirect()->route('payment.cancel');
    }
}
