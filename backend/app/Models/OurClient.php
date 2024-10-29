<?php



namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OurClient extends Model
{
    use HasFactory;
    protected $table = 'ourclients'; // تحديد اسم الجدول

    // تحديد الأعمدة التي يمكن إدخال قيمها
    protected $fillable = ['image', 'description'];
}
