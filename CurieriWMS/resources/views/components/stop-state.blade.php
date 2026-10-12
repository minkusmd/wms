@props(['state'])
@php
    [$color, $label] = match ((int) $state) {
        1 => ['bg-state-work', 'În lucru'],
        2 => ['bg-state-done', 'Terminată'],
        3 => ['bg-state-fail', 'Cu probleme'],
        4 => ['bg-slate-400', 'Anulată'],
        default => ['bg-state-new', 'Planificată'],
    };
@endphp
<span {{ $attributes->merge(['class' => 'inline-flex items-center gap-1.5 text-base font-medium text-slate-700']) }}>
    <span class="dot {{ $color }}"></span>{{ $label }}
</span>
