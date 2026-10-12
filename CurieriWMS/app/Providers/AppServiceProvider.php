<?php

namespace App\Providers;

use App\Auth\CourierUserProvider;
use App\Firebird\FirebirdConnection;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        // o conexiune Firebird (WMS) per request / proces
        $this->app->scoped(FirebirdConnection::class, fn () => FirebirdConnection::fromConfig());
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // conturile curierilor: TS_COURIER in Firebird (config/auth.php, provider "couriers")
        Auth::provider('firebird-courier', fn ($app) => new CourierUserProvider(
            fn () => $app->make(FirebirdConnection::class),
            $app['hash'],
        ));
    }
}
