<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <meta name="theme-color" content="#1d4ed8">
    <meta name="format-detection" content="telephone=no">
    <title>{{ $title ?? 'Curieri' }} · {{ config('app.name') }}</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body>
    @auth
        <header class="sticky top-0 z-30 bg-brand-600 text-white shadow">
            <div class="mx-auto flex max-w-xl items-center gap-3 px-4 py-3">
                <a href="{{ route('traseu') }}" wire:navigate class="min-w-0 flex-1">
                    <span class="block truncate text-lg font-semibold">{{ auth()->user()->name }}</span>
                    <span class="block text-sm text-brand-100">{{ now()->locale('ro')->isoFormat('dddd, D MMMM') }}</span>
                </a>
                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <button type="submit" class="min-h-12 rounded-lg px-3 text-base font-medium text-brand-50 active:bg-brand-700">Ieșire</button>
                </form>
            </div>
        </header>
    @endauth

    <main class="mx-auto max-w-xl px-3 pt-3 pb-[calc(env(safe-area-inset-bottom)+6rem)]">
        {{ $slot }}
    </main>

    {{-- confirmarile cer internet (plan §9A): avertisment vizibil cand telefonul e offline --}}
    <div x-data="{ online: navigator.onLine }"
         x-on:online.window="online = true" x-on:offline.window="online = false"
         x-show="!online" x-cloak
         class="fixed inset-x-0 bottom-0 z-40 bg-red-600 px-4 pt-3 pb-[calc(env(safe-area-inset-bottom)+0.75rem)] text-center text-base font-semibold text-white">
        Fără internet. Confirmările sunt posibile doar după reconectare.
    </div>
</body>
</html>
