<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class CheckAdmin
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Check if the user is authenticated and has admin privileges
        if (Auth::check() && Auth::user()->isAdmin) {
            // إذا كان المستخدم مسؤولًا، اسمح بمتابعة الطلب
            return $next($request);
        }

        // إذا لم يكن المستخدم مسؤولًا، إعادة توجيهه أو إرجاع استجابة خطأ
        return response()->json([
            'message' => 'Unauthorized. You do not have admin privileges.'
        ], Response::HTTP_UNAUTHORIZED);
    }
}
