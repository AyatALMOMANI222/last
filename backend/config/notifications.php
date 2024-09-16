<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Default Notification Channels
    |--------------------------------------------------------------------------
    |
    | Here you may specify a default channel to be used by the notifications
    | sent by your application. This will be used if no specific channel
    | is provided when creating the notification.
    |
    */

    'default' => 'database',

    /*
    |--------------------------------------------------------------------------
    | Notification Channels
    |--------------------------------------------------------------------------
    |
    | Here you may specify the channels that are available to be used
    | when sending notifications. You can define your own channels
    | or use the ones provided by Laravel.
    |
    */

    'channels' => [
        'mail' => \Illuminate\Notifications\Channels\MailChannel::class,
        'database' => \Illuminate\Notifications\Channels\DatabaseChannel::class,
    ],

];
