<?php
namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;

class NewSpeakerNotification extends Notification
{
    use Queueable;

    private $message;

    // تمرير الرسالة عبر الكونستركتور
    public function __construct($message)
    {
        $this->message = $message;
    }

    // تحديد القناة التي سيتم إرسال الإشعار عبرها
    public function via($notifiable)
    {
        return ['database']; 
    }

    public function toArray($notifiable)
    {
        // رسالة ثابتة يمكن تعديلها حسب الحاجة
        return [
            'message' => 'رسالة ثابتة: مرحبا بكم في منصتنا!',
        ];
    }
}
