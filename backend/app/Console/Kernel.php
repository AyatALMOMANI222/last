<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * Define the application's command schedule.
     */
    protected function schedule(Schedule $schedule): void
    {
        // ضع هنا المهمة المجدولة
        $schedule->call(function () {
            \App\Models\Conference::where('status', 'upcoming')
                ->where('start_date', '<', now())
                ->update(['status' => 'past']);
        })->everyMinute();;
    }

    /**
     * Register the commands for the application.
     */
    protected function commands(): void
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
