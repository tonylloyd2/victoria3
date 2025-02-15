<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Factory extends Model
{
    use HasFactory;

    protected $table = 'factory';

    protected $fillable = [
        'name',
        'location',
        'manager',
    ];

    public function manager()
    {
        return $this->belongsTo(User::class, 'manager', 'id');
    }
}
