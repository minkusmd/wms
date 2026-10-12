<?php

use App\Http\Controllers\PhotoController;
use App\Livewire\Auth\Activate;
use App\Livewire\Auth\Login;
use App\Livewire\Route\MyRoute;
use App\Livewire\Route\StopShow;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::middleware('guest')->group(function () {
    Route::livewire('/autentificare', Login::class)->name('login');
    Route::livewire('/activare', Activate::class)->name('activare');
});

Route::middleware('auth')->group(function () {
    Route::livewire('/', MyRoute::class)->name('traseu');
    Route::livewire('/oprire/{stop}', StopShow::class)->whereNumber('stop')->name('oprire');
    Route::get('/foto/{photo}', [PhotoController::class, 'show'])->whereNumber('photo')->name('foto');

    Route::post('/iesire', function (Request $request) {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect()->route('login');
    })->name('logout');
});
