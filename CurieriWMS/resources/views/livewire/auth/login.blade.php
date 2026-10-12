<div class="pt-10">
    <h1 class="mb-1 text-center text-2xl font-bold">Curieri</h1>
    <p class="mb-8 text-center text-slate-600">Traseul zilei, preluări și livrări</p>

    <form wire:submit="authenticate" class="card space-y-5">
        <div>
            <label for="login" class="label">Login</label>
            <input id="login" type="text" wire:model="login" class="field"
                   autocomplete="username" autocapitalize="none" autocorrect="off" spellcheck="false" required>
            @error('login') <p class="mt-2 text-base font-medium text-red-700">{{ $message }}</p> @enderror
        </div>

        <div x-data="{ show: false }">
            <label for="password" class="label">Parola</label>
            <div class="relative">
                <input id="password" x-bind:type="show ? 'text' : 'password'" wire:model="password" class="field pr-24"
                       autocomplete="current-password" required>
                <button type="button" x-on:click="show = !show"
                        class="absolute inset-y-0 right-0 min-w-20 rounded-r-xl px-3 text-base font-medium text-brand-600"
                        x-text="show ? 'Ascunde' : 'Arată'">Arată</button>
            </div>
        </div>

        <button type="submit" class="btn-primary" wire:loading.attr="disabled">
            <span wire:loading.remove wire:target="authenticate">Intră</span>
            <span wire:loading wire:target="authenticate">Se verifică…</span>
        </button>
    </form>

    <a href="{{ route('activare') }}" wire:navigate class="btn-light mt-4">Am primit un cod de activare</a>
</div>
