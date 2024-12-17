<?php

use Illuminate\Support\Facades\Broadcast;

return [

    'default' => env('BROADCAST_DRIVER', 'pusher'),

    'connections' => [

        'pusher' => [
            'driver' => 'pusher',
            'key' => env('PUSHER_APP_KEY', 'd621cac4efd6817060d6'),
            'secret' => env('PUSHER_APP_SECRET', 'e49c0bc9c9094f7eca2a'),
            'app_id' => env('PUSHER_APP_ID', '1886910'),
            'cluster' => env('PUSHER_APP_CLUSTER', 'ap2'),
            'use_tls' => false,
        ],

        'redis' => [
            'driver' => 'redis',
            'connection' => 'default',
        ],

        'null' => [
            'driver' => 'null',
        ],

        'log' => [
            'driver' => 'log',
        ],

        'socket.io' => [
            'driver' => 'socket.io',
            'host' => env('SOCKET_IO_HOST', '127.0.0.1'),
            'port' => env('SOCKET_IO_PORT', 6001),
            'options' => [
                'transports' => ['websocket'],
            ],
        ],

    ],

];
