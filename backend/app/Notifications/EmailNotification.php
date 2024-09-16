<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;

class EmailNotification extends Notification
{
    use Queueable;

    protected $message;

  
    public function __construct($message)
    {
        $this->message = $message;
    }

  
    public function via($notifiable)
    {
        return ['mail'];
    }

   
    public function toMail($notifiable)
    {
        return (new MailMessage)
                    ->subject('إشعار جديد')
                    ->line($this->message)
                    ->action('عرض التفاصيل', url('/'))
                    ->line('شكراً لاستخدامك تطبيقنا!');
    }
}
