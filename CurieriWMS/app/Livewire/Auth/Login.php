<?php

namespace App\Livewire\Auth;

use App\Firebird\FirebirdException;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Str;
use Livewire\Attributes\Layout;
use Livewire\Attributes\Title;
use Livewire\Component;

#[Layout('layouts::app')]
#[Title('Autentificare')]
class Login extends Component
{
    public string $login = '';

    public string $password = '';

    public function authenticate()
    {
        $this->validate([
            'login' => 'required|string|max:64',
            'password' => 'required|string|max:200',
        ], attributes: ['login' => 'loginul', 'password' => 'parola']);

        $key = 'login:'.Str::lower(trim($this->login)).'|'.request()->ip();
        if (RateLimiter::tooManyAttempts($key, 5)) {
            $this->addError('login', 'Prea multe încercări. Reîncearcă peste '.max(1, (int) ceil(RateLimiter::availableIn($key) / 60)).' min.');

            return null;
        }

        try {
            // "tine-ma minte" mereu: soferul nu trebuie sa se autentifice in fiecare zi
            $ok = Auth::attempt(['login' => $this->login, 'password' => $this->password], true);
        } catch (FirebirdException $e) {
            report($e);
            $this->addError('login', 'Baza de date nu răspunde. Încearcă din nou peste un minut.');

            return null;
        }

        if (! $ok) {
            RateLimiter::hit($key, 900);
            $this->reset('password');
            $this->addError('login', 'Login sau parolă greșită.');

            return null;
        }

        RateLimiter::clear($key);
        session()->regenerate();

        return $this->redirectRoute('traseu');
    }

    public function render()
    {
        return view('livewire.auth.login');
    }
}
