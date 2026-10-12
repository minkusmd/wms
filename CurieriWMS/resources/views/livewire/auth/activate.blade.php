<div class="pt-6">
    <h1 class="mb-1 text-2xl font-bold">Activarea contului</h1>
    <p class="mb-6 text-slate-600">Introdu loginul și codul primit de la dispecer, apoi alege o parolă.</p>

    <form wire:submit="activate" class="card space-y-5">
        <div>
            <label for="login" class="label">Login</label>
            <input id="login" type="text" wire:model="login" class="field"
                   autocomplete="username" autocapitalize="none" autocorrect="off" spellcheck="false" required>
            @error('login') <p class="mt-2 text-base font-medium text-red-700">{{ $message }}</p> @enderror
        </div>

        <div>
            <label for="code" class="label">Codul de activare</label>
            <input id="code" type="text" wire:model="code" class="field tracking-widest"
                   inputmode="numeric" autocomplete="one-time-code" required>
            @error('code') <p class="mt-2 text-base font-medium text-red-700">{{ $message }}</p> @enderror
        </div>

        <div>
            <label for="password" class="label">Parola nouă (minimum 6 caractere)</label>
            <input id="password" type="password" wire:model="password" class="field" autocomplete="new-password" required>
            @error('password') <p class="mt-2 text-base font-medium text-red-700">{{ $message }}</p> @enderror
        </div>

        <div>
            <label for="password_confirmation" class="label">Repetă parola</label>
            <input id="password_confirmation" type="password" wire:model="password_confirmation" class="field" autocomplete="new-password" required>
        </div>

        <button type="submit" class="btn-primary" wire:loading.attr="disabled">
            <span wire:loading.remove wire:target="activate">Activează și intră</span>
            <span wire:loading wire:target="activate">Se salvează…</span>
        </button>
    </form>

    <a href="{{ route('login') }}" wire:navigate class="btn-light mt-4">Înapoi la autentificare</a>
</div>
