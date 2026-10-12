@php
    $kindLabel = [1 => 'Depozit', 2 => 'Furnizor', 3 => 'Client'];
    $kindStyle = [1 => 'bg-slate-700 text-white', 2 => 'bg-amber-500 text-white', 3 => 'bg-brand-600 text-white'];
@endphp
<div wire:poll.visible.60s>
    {{-- filele fixe sus, cu contoare (ce a ramas de facut) --}}
    <nav class="sticky top-[4.25rem] z-20 -mx-3 mb-3 grid grid-cols-3 gap-1 bg-slate-100 px-3 py-2">
        @foreach (['toate' => 'Toate', 'achizitii' => 'Achiziții', 'livrari' => 'Livrări'] as $key => $label)
            <button type="button" wire:click="setTab('{{ $key }}')"
                    class="min-h-12 rounded-xl text-base font-semibold {{ $tab === $key ? 'bg-brand-600 text-white shadow' : 'bg-white text-slate-700 ring-1 ring-slate-200' }}">
                {{ $label }}
                <span class="ml-1 rounded-full px-2 py-0.5 text-sm {{ $tab === $key ? 'bg-white/25' : 'bg-slate-100' }}">{{ $counts[$key] }}</span>
            </button>
        @endforeach
    </nav>

    @if ($error)
        <div class="card mb-3 bg-red-50 text-red-800 ring-red-200">{{ $error }}</div>
    @endif

    @forelse ($routes as $route)
        @php $late = \Illuminate\Support\Carbon::parse($route['PLAN_DATE'])->lt(today()); @endphp
        @if ($late || count($routes) > 1)
            <h2 class="mt-4 mb-2 px-1 text-base font-semibold {{ $late ? 'text-red-700' : 'text-slate-600' }}">
                {{ $late ? 'Restanță din '.\Illuminate\Support\Carbon::parse($route['PLAN_DATE'])->format('d.m') : 'Cursa '.$route['TRIPNO'] }}
            </h2>
        @endif

        <ol class="space-y-3">
            @forelse ($route['stops'] as $stop)
                @php
                    $kind = (int) $stop['STOP_KIND'];
                    $done = in_array((int) $stop['STATEID'], [2, 4], true);
                @endphp
                <li>
                    <a href="{{ route('oprire', $stop['STOPID']) }}" wire:navigate
                       class="card block active:bg-slate-50 {{ (int) $stop['N_RETURN'] > 0 && ! $done ? 'bg-amber-50 ring-amber-300' : '' }} {{ $done ? 'opacity-70' : '' }}">
                        <div class="flex items-start gap-3">
                            <span class="flex size-10 shrink-0 items-center justify-center rounded-full bg-slate-900 text-lg font-bold text-white">{{ $stop['ORDERNO'] }}</span>
                            <div class="min-w-0 flex-1">
                                <div class="flex flex-wrap items-center gap-2">
                                    <span class="rounded-md px-2 py-0.5 text-sm font-semibold {{ $kindStyle[$kind] ?? '' }}">{{ $kindLabel[$kind] ?? '' }}</span>
                                    @if ($stop['PLAN_TIME'])
                                        <span class="text-base font-semibold text-slate-900">{{ $stop['PLAN_TIME'] }}</span>
                                    @endif
                                    @if ($stop['ZONE_NAME'])
                                        <span class="text-base text-slate-500">· {{ $stop['ZONE_NAME'] }}</span>
                                    @endif
                                </div>
                                <p class="mt-1 text-lg leading-tight font-semibold {{ (int) $stop['STATEID'] === 4 ? 'line-through' : '' }}">{{ $stop['TITLE'] }}</p>
                                @if ($stop['ADDRESS'])
                                    <p class="mt-0.5 text-base text-slate-600">{{ $stop['ADDRESS'] }}</p>
                                @endif
                                <div class="mt-2 flex flex-wrap items-center gap-x-3 gap-y-1">
                                    <x-stop-state :state="$stop['STATEID']" />
                                    @if ($stop['N_PICKUP'] > 0)
                                        <span class="text-base text-slate-700">Ridicări: <b>{{ $stop['N_PICKUP'] }}</b></span>
                                    @endif
                                    @if ($stop['N_RETURN'] > 0)
                                        <span class="text-base font-semibold text-amber-800">Retur: {{ $stop['N_RETURN'] }}</span>
                                    @endif
                                    @if ($stop['N_DELIVERY'] > 0)
                                        <span class="text-base text-slate-700">Livrări: <b>{{ $stop['N_DELIVERY'] }}</b></span>
                                    @endif
                                    @if ($stop['N_LOAD'] > 0)
                                        <span class="text-base text-slate-700">De încărcat: <b>{{ $stop['N_LOAD'] }}</b></span>
                                    @endif
                                </div>
                            </div>
                            <span class="self-center text-2xl text-slate-400" aria-hidden="true">›</span>
                        </div>
                    </a>
                </li>
            @empty
                <li class="card text-center text-slate-500">Nimic în această filă.</li>
            @endforelse
        </ol>
    @empty
        @unless ($error)
            <div class="card mt-6 text-center">
                <p class="text-lg font-semibold">Nu ai un traseu publicat pentru azi.</p>
                <p class="mt-1 text-slate-600">Când dispecerul publică traseul, el apare aici.</p>
            </div>
        @endunless
    @endforelse

    <p class="mt-6 text-center text-sm text-slate-500">
        Actualizat la {{ $updatedAt->format('H:i') }}
        <button type="button" wire:click="$refresh" class="ml-2 min-h-10 rounded-lg px-3 font-semibold text-brand-600 active:bg-brand-50">Reîncarcă</button>
    </p>
</div>
