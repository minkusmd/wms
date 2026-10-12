<?php

namespace App\Livewire\Auth;

use App\Dispatch\CourierAccounts;
use App\Firebird\FirebirdException;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Str;
use Illuminate\Validation\Rules\Password;
use Livewire\Attributes\Layout;
use Livewire\Attributes\Title;
use Livewire\Component;

#[Layout('layouts::app')]
#[Title('Activarea contului')]
class Activate extends Component
{
    public string $login = '';

    public string $code = '';

    public string $password = '';

    public string $password_confirmation = '';

    public function activate(CourierAccounts $accounts)
    {
        $this->validate([
            'login' => 'required|string|max:64',
            'code' => 'required|string|max:16',
            'password' => ['required', 'confirmed', Password::min(6)->max(200)],
        ], attributes: ['login' => 'loginul', 'code' => 'codul', 'password' => 'parola']);

        $key = 'activare:'.Str::lower(trim($this->login)).'|'.request()->ip();
        if (RateLimiter::tooManyAttempts($key, 5)) {
            $this->addError('code', 'Prea multe încercări. Reîncearcă peste '.max(1, (int) ceil(RateLimiter::availableIn($key) / 60)).' min.');

            return null;
        }

        try {
            $courierId = $accounts->activate($this->login, $this->code, $this->password);
        } catch (FirebirdException $e) {
            report($e);
            $this->addError('code', 'Baza de date nu răspunde. Încearcă din nou peste un minut.');

            return null;
        }

        if ($courierId === null) {
            RateLimiter::hit($key, 900);
            $this->addError('code', 'Loginul sau codul nu sunt valabile. Cere dispecerului un cod nou.');

            return null;
        }

        RateLimiter::clear($key);
        Auth::loginUsingId($courierId, true);
        session()->regenerate();

        return $this->redirectRoute('traseu');
    }

    public function render()
    {
        return view('livewire.auth.activate');
    }
}
