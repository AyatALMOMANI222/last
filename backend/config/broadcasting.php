<?php

use Illuminate\Support\Facades\Broadcast;

return [

    'default' => env('BROADCAST_DRIVER', 'null'),

    'connections' => [

        'pusher' => [
            'driver' => 'pusher',
            'key' => '743171d2766ff157a71a',
            'secret' => 'b8c7d169bfb95a4713e1',
            'app_id' => '1886913',
            'options' => [
                'cluster' => 'ap2',
                'useTLS' => true,
            ],
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
