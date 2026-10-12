@use('App\Support\Format')
@use('App\Livewire\Route\StopShow')
@php
    $kindLabel = [1 => 'Depozit — încărcare', 2 => 'Furnizor', 3 => 'Client — livrare'];
    $mapUrl = Format::mapUrl($stop['ADDRESS'], $stop['LATITUDE'], $stop['LONGITUDE']);
    $phoneUrl = Format::phoneUrl($stop['PHONE']);

    /** totaluri pe moneda: [currencyId => suma] */
    $totals = function (iterable $rows, string $qtyKey, string $priceKey = 'PRICE') {
        $sum = [];
        foreach ($rows as $r) {
            if ($r[$priceKey] === null) continue;
            $cur = (int) ($r['CURRENCYID'] ?: 498);
            $sum[$cur] = ($sum[$cur] ?? 0) + (float) $r[$qtyKey] * (float) $r[$priceKey];
        }
        return $sum;
    };
@endphp

<div class="space-y-3">
    <a href="{{ route('traseu') }}" wire:navigate class="inline-flex min-h-12 items-center gap-1 rounded-lg pr-3 text-lg font-semibold text-brand-600 active:bg-brand-50">‹ Traseul meu</a>

    {{-- antet: cine, unde, contact --}}
    <section class="card">
        <div class="flex flex-wrap items-center gap-2 text-base">
            <span class="rounded-md bg-slate-900 px-2 py-0.5 font-bold text-white">{{ $stop['ORDERNO'] }}</span>
            <span class="font-semibold text-slate-600">{{ $kindLabel[$kind] ?? '' }}</span>
            @if ($stop['PLAN_TIME'])<span class="font-semibold">· {{ $stop['PLAN_TIME'] }}</span>@endif
            <x-stop-state :state="$stop['STATEID']" class="ml-auto" />
        </div>
        <h1 class="mt-2 text-2xl leading-tight font-bold">{{ $stop['TITLE'] }}</h1>
        @if ($stop['ADDRESS'])<p class="mt-1 text-lg text-slate-700">{{ $stop['ADDRESS'] }}</p>@endif
        @if ($stop['ZONE_NAME'])<p class="text-base text-slate-500">Zona: {{ $stop['ZONE_NAME'] }}</p>@endif
        @if ($stop['CONTACT_NAME'] || $stop['PHONE'])
            <p class="mt-2 text-base">{{ $stop['CONTACT_NAME'] }} @if ($stop['PHONE'])<span class="text-slate-600">· {{ $stop['PHONE'] }}</span>@endif</p>
        @endif
        @if ($stop['SCHEDULE'])<p class="text-base text-slate-600">Program: {{ $stop['SCHEDULE'] }}</p>@endif
        @if ($stop['NOTE'])
            <p class="mt-3 rounded-xl bg-amber-50 p-3 text-base font-medium text-amber-900 ring-1 ring-amber-200">{{ $stop['NOTE'] }}</p>
        @endif

        <div class="mt-4 grid grid-cols-2 gap-2">
            @if ($phoneUrl)
                <a href="{{ $phoneUrl }}" class="btn-light">Sună</a>
            @else
                <span class="btn-light opacity-40">Fără telefon</span>
            @endif
            @if ($mapUrl)
                <a href="{{ $mapUrl }}" target="_blank" rel="noopener" class="btn-light">Hartă</a>
            @else
                <span class="btn-light opacity-40">Fără adresă</span>
            @endif
        </div>
    </section>

    @if ($message)
        <div wire:key="msg-{{ md5($message) }}" role="status"
             class="card text-lg font-semibold {{ $messageIsError ? 'bg-red-50 text-red-800 ring-red-200' : 'bg-green-50 text-green-800 ring-green-200' }}">
            {{ $message }}
        </div>
    @endif

    {{-- ================= FURNIZOR ================= --}}
    @if ($kind === 2)
        @if (! $doc)
            {{-- inainte de inceperea preluarii: ce trebuie ridicat / returnat, cu pretul de achizitie --}}
            <section class="card">
                <h2 class="text-xl font-bold">De ridicat</h2>
                <ul class="mt-2 divide-y divide-slate-100">
                    @forelse ($planned as $p)
                        <li class="py-3">
                            <p class="text-lg leading-tight font-semibold">{{ $p['TITLE'] }}</p>
                            <p class="text-base text-slate-500">{{ $p['GOODS_CODE'] }} · comanda {{ $p['DOCID'] }}</p>
                            <p class="mt-1 text-base">
                                <b class="text-lg">{{ Format::qty($p['QTY']) }} buc</b>
                                × {{ Format::money($p['PRICE'], $p['CURRENCYID']) }}
                                = <b>{{ $p['PRICE'] !== null ? Format::money((float) $p['QTY'] * (float) $p['PRICE'], $p['CURRENCYID']) : '—' }}</b>
                            </p>
                            @if ($p['NOTE'])<p class="mt-1 text-base text-amber-800">{{ $p['NOTE'] }}</p>@endif
                        </li>
                    @empty
                        <li class="py-3 text-slate-500">Nimic de ridicat.</li>
                    @endforelse
                </ul>
                @foreach ($totals($planned, 'QTY') as $cur => $sum)
                    <p class="mt-2 flex justify-between border-t border-slate-200 pt-2 text-lg font-bold"><span>Total achiziție</span><span>{{ Format::money($sum, $cur) }}</span></p>
                @endforeach
            </section>

            @if (count($returns))
                <section class="card bg-amber-50 ring-amber-300">
                    <h2 class="text-xl font-bold text-amber-900">Retur la furnizor ↩</h2>
                    <ul class="mt-2 divide-y divide-amber-200">
                        @foreach ($returns as $r)
                            <li class="py-3">
                                <p class="text-lg leading-tight font-semibold">{{ $r['TITLE'] }}</p>
                                <p class="text-base text-amber-900/70">{{ $r['CODE'] }} · document {{ $r['DOCID'] }}</p>
                                <p class="mt-1 text-base"><b class="text-lg">{{ Format::qty($r['QTY']) }} buc</b> × {{ Format::money($r['PRICE'], $r['CURRENCYID']) }}</p>
                                @if ($r['TASK_NOTE'])<p class="text-base font-medium text-amber-900">{{ $r['TASK_NOTE'] }}</p>@endif
                            </li>
                        @endforeach
                    </ul>
                    @foreach ($totals($returns, 'QTY') as $cur => $sum)
                        <p class="mt-2 flex justify-between border-t border-amber-300 pt-2 text-lg font-bold text-amber-900"><span>Total retur</span><span>{{ Format::money($sum, $cur) }}</span></p>
                    @endforeach
                </section>
            @endif

            @if (count($planned) || count($returns))
                <div class="sticky bottom-3 z-10 pt-2">
                    <button type="button" class="btn-primary shadow-lg"
                            wire:click="startPickup" wire:loading.attr="disabled" wire:target="startPickup"
                            wire:confirm="Începi preluarea? Lista de produse se blochează până o închizi.">
                        <span wire:loading.remove wire:target="startPickup">Am ajuns — încep preluarea</span>
                        <span wire:loading wire:target="startPickup">Se blochează lista…</span>
                    </button>
                </div>
            @endif
        @else
            @php $open = (int) $doc['STATEID'] === 1; @endphp
            <section class="card {{ $open ? 'bg-amber-50 ring-amber-200' : 'bg-green-50 ring-green-200' }}">
                @if ($open)
                    <p class="text-lg font-semibold text-amber-900">Preluare în curs · lista blocată din {{ \Illuminate\Support\Carbon::parse($doc['STARTED_AT'])->format('H:i') }}</p>
                    <p class="text-base text-amber-900/80">Confirmă cantitatea primită și fotografiază seria sau partida fiecărui produs.</p>
                @else
                    <p class="text-lg font-semibold text-green-800">Încărcat · preluare închisă la {{ \Illuminate\Support\Carbon::parse($doc['CLOSED_AT'])->format('H:i') }}</p>
                    @php $invoices = array_unique(array_filter(array_column($items, 'INVOICE_DOCID'))); @endphp
                    @if ($invoices)
                        <p class="text-base text-green-900">Intrare marfă nr. {{ implode(', ', $invoices) }}</p>
                    @endif
                @endif
            </section>

            @foreach ([1 => 'Ridicări', 2 => 'Retur la furnizor ↩'] as $itemKind => $heading)
                @php $group = array_values(array_filter($items, fn ($i) => (int) $i['ITEM_KIND'] === $itemKind)); @endphp
                @continue(! count($group))
                <h2 class="px-1 pt-2 text-xl font-bold {{ $itemKind === 2 ? 'text-amber-900' : '' }}">{{ $heading }}</h2>

                @foreach ($group as $item)
                    @php
                        $id = (int) $item['ITEMID'];
                        $done = $item['QTY_DONE'] !== null;
                        $required = StopShow::requiredPhotos($item);
                        $itemPhotos = $photos[$id] ?? [];
                    @endphp
                    <article wire:key="item-{{ $id }}" class="card {{ $itemKind === 2 ? 'bg-amber-50 ring-amber-300' : '' }}">
                        <p class="text-lg leading-tight font-semibold">{{ $item['TITLE'] }}</p>
                        <p class="text-base text-slate-500">{{ $item['GOODS_CODE'] }} · {{ $itemKind === 1 ? 'comanda' : 'document' }} {{ $item['SRC_DOCID'] }}</p>
                        <p class="mt-1 text-base">
                            Planificat <b class="text-lg">{{ Format::qty($item['QTY_PLANNED']) }}</b>
                            × {{ Format::money($item['PRICE'], $item['CURRENCYID']) }}
                            = <b>{{ $item['PRICE'] !== null ? Format::money((float) $item['QTY_PLANNED'] * (float) $item['PRICE'], $item['CURRENCYID']) : '—' }}</b>
                        </p>

                        {{-- cantitatea --}}
                        @if ($done)
                            <p class="mt-2 flex items-center gap-2 text-lg">
                                <span class="dot {{ (float) $item['QTY_DONE'] < (float) $item['QTY_PLANNED'] ? 'bg-state-fail' : 'bg-state-done' }}"></span>
                                {{ $itemKind === 1 ? 'Primit' : 'Predat' }}: <b>{{ Format::qty($item['QTY_DONE']) }}</b>
                                @if ($open && $editing !== $id)
                                    <button type="button" wire:click="editQty({{ $id }}, '{{ Format::qty($item['QTY_DONE']) }}')" class="ml-auto min-h-10 rounded-lg px-3 text-base font-semibold text-brand-600 active:bg-brand-50">Modifică</button>
                                @endif
                            </p>
                            @if ($item['ISSUE_NOTE'])<p class="text-base text-red-800">{{ $item['ISSUE_NOTE'] }}</p>@endif
                        @elseif ($open && $editing !== $id)
                            <div class="mt-3 grid grid-cols-2 gap-2">
                                <button type="button" class="btn-success text-base"
                                        wire:click="receiveAll({{ $id }}, '{{ $item['QTY_PLANNED'] }}')" wire:loading.attr="disabled">
                                    {{ $itemKind === 1 ? 'Am primit tot' : 'Predat tot' }} ({{ Format::qty($item['QTY_PLANNED']) }})
                                </button>
                                <button type="button" class="btn-light text-base" wire:click="editQty({{ $id }}, '')">Altă cantitate</button>
                            </div>
                        @endif

                        @if ($open && $editing === $id)
                            <div class="mt-3 space-y-3 rounded-xl bg-slate-50 p-3 ring-1 ring-slate-200">
                                <label class="label" for="qty-{{ $id }}">Cantitatea {{ $itemKind === 1 ? 'primită' : 'predată' }} (din {{ Format::qty($item['QTY_PLANNED']) }})</label>
                                <input id="qty-{{ $id }}" type="text" inputmode="decimal" wire:model="qty.{{ $id }}" class="field">
                                <label class="label" for="note-{{ $id }}">Motivul (lipsă, refuz, defect)</label>
                                <input id="note-{{ $id }}" type="text" wire:model="notes.{{ $id }}" class="field" maxlength="500">
                                <div class="grid grid-cols-2 gap-2">
                                    <button type="button" class="btn-light" wire:click="$set('editing', null)">Renunță</button>
                                    <button type="button" class="btn-primary" wire:click="saveQty({{ $id }})" wire:loading.attr="disabled">Salvează</button>
                                </div>
                            </div>
                        @endif

                        {{-- fotografiile seriei / partidei --}}
                        @if ($required > 0 || count($itemPhotos))
                            <div class="mt-3">
                                <p class="text-base font-medium text-slate-700">
                                    {{ (int) $item['SERIAL_TYPE_ID'] === 4403 ? 'Seria fiecărei unități' : 'Partida' }}
                                    · {{ min($required, count(array_filter(array_keys($itemPhotos), fn ($u) => $u <= $required))) }} din {{ $required }} fotografii
                                </p>
                                <div class="mt-2 grid grid-cols-2 gap-2">
                                    @for ($unit = 1; $unit <= max($required, $itemPhotos ? max(array_keys($itemPhotos)) : 0); $unit++)
                                        @php $photoId = $itemPhotos[$unit] ?? null; @endphp
                                        <div wire:key="slot-{{ $id }}-{{ $unit }}" class="relative">
                                            @if ($photoId)
                                                <a href="{{ route('foto', $photoId) }}" target="_blank">
                                                    <img src="{{ route('foto', $photoId) }}" alt="Unitatea {{ $unit }}" loading="lazy"
                                                         class="aspect-square w-full rounded-xl object-cover ring-1 ring-slate-200">
                                                </a>
                                                <span class="absolute top-1 left-1 rounded-md bg-black/60 px-2 text-sm font-semibold text-white">{{ $unit }} ✓</span>
                                                @if ($open)
                                                    <button type="button" wire:click="replacePhoto({{ $photoId }})" wire:confirm="Refaci fotografia unității {{ $unit }}?"
                                                            class="absolute right-1 bottom-1 min-h-10 rounded-lg bg-white/90 px-3 text-base font-semibold text-slate-900 shadow">Refă</button>
                                                @endif
                                            @elseif ($open)
                                                <label x-data="photoSlot({{ $id }}, {{ $unit }})"
                                                       class="flex aspect-square w-full cursor-pointer flex-col items-center justify-center gap-1 rounded-xl border-2 border-dashed border-slate-300 bg-white text-center active:bg-slate-50"
                                                       :class="error ? 'border-red-400 bg-red-50' : ''">
                                                    <input type="file" accept="image/*" capture="environment" class="sr-only" x-on:change="take($event)" :disabled="busy">
                                                    <span class="text-3xl" aria-hidden="true">📷</span>
                                                    <span class="px-2 text-base font-semibold" x-show="!busy && !error">{{ (int) $item['SERIAL_TYPE_ID'] === 4403 ? 'Unitatea '.$unit : 'Fotografiază' }}</span>
                                                    <span class="text-base font-semibold text-brand-700" x-show="busy" x-cloak>Se trimite… <span x-text="progress + '%'"></span></span>
                                                    <span class="px-2 text-sm font-semibold text-red-700" x-show="error" x-text="error" x-cloak></span>
                                                </label>
                                            @endif
                                        </div>
                                    @endfor
                                </div>
                            </div>
                        @elseif ($done && $itemKind === 1 && (float) $item['QTY_DONE'] > 0)
                            <p class="mt-2 text-base text-slate-500">Produs fără serie sau partidă: fotografia nu e necesară.</p>
                        @endif
                    </article>
                @endforeach

                @php $groupTotals = $totals($group, 'QTY_PLANNED'); @endphp
                @foreach ($groupTotals as $cur => $sum)
                    <p class="flex justify-between px-1 text-lg font-bold {{ $itemKind === 2 ? 'text-amber-900' : '' }}">
                        <span>{{ $itemKind === 1 ? 'Total achiziție' : 'Total retur' }}</span><span>{{ Format::money($sum, $cur) }}</span>
                    </p>
                @endforeach
            @endforeach

            @if ($open)
                @php $ready = $progress['qty'] === $progress['qtyTotal'] && $progress['photos'] === $progress['photosTotal']; @endphp
                <div class="sticky bottom-3 z-10 pt-2">
                    <div class="card space-y-2 shadow-lg">
                        <p class="flex justify-between text-base">
                            <span>Cantități: <b>{{ $progress['qty'] }} din {{ $progress['qtyTotal'] }}</b></span>
                            <span>Fotografii: <b>{{ $progress['photos'] }} din {{ $progress['photosTotal'] }}</b></span>
                        </p>
                        <button type="button" class="btn-success" @disabled(! $ready)
                                wire:click="closePickup({{ (int) $doc['PDOCID'] }})" wire:loading.attr="disabled" wire:target="closePickup"
                                wire:confirm="Închizi preluarea? Se creează Intrarea de marfă și lista nu se mai poate schimba.">
                            <span wire:loading.remove wire:target="closePickup">{{ $ready ? 'Închide preluarea' : 'Completează cantitățile și fotografiile' }}</span>
                            <span wire:loading wire:target="closePickup">Se creează intrarea…</span>
                        </button>
                    </div>
                </div>
            @endif
        @endif
    @endif

    {{-- ================= CLIENT ================= --}}
    @if ($kind === 3)
        @foreach ($deliveries as $d)
            <section wire:key="delivery-{{ $d['DELIVERYID'] }}" class="card space-y-3">
                <div class="flex flex-wrap items-center justify-between gap-2">
                    <h2 class="text-xl font-bold">Comanda {{ $d['DOCID'] }}</h2>
                    @if ($d['AUTH_AT'])
                        <span class="inline-flex items-center gap-1.5 text-base font-semibold text-green-800"><span class="dot bg-state-done"></span>Pregătită pentru predare</span>
                    @else
                        <span class="inline-flex items-center gap-1.5 text-base font-semibold text-violet-800"><span class="dot bg-state-wait"></span>Așteaptă confirmarea dispecerului</span>
                    @endif
                </div>
                @if ($d['TIME_TEXT'])<p class="text-base">Interval: <b>{{ $d['TIME_TEXT'] }}</b></p>@endif
                @if ($d['NOTE'])<p class="rounded-xl bg-amber-50 p-3 text-base text-amber-900 ring-1 ring-amber-200">{{ $d['NOTE'] }}</p>@endif

                <div>
                    <h3 class="text-lg font-semibold">Produse</h3>
                    <ul class="divide-y divide-slate-100">
                        @foreach ($d['goods'] as $l)
                            <li class="py-2">
                                <p class="text-lg leading-tight font-medium">{{ $l['TITLE'] }}</p>
                                <p class="flex justify-between text-base text-slate-700">
                                    <span>{{ Format::qty($l['QTY']) }} × {{ Format::money($l['PRICE'], $d['CURRENCYID']) }}</span>
                                    <b>{{ Format::money($l['SUMA'], $d['CURRENCYID']) }}</b>
                                </p>
                            </li>
                        @endforeach
                    </ul>
                    <p class="flex justify-between border-t border-slate-200 pt-2 text-lg font-bold"><span>Total produse</span><span>{{ Format::money(array_sum(array_column($d['goods'], 'SUMA')), $d['CURRENCYID']) }}</span></p>
                </div>

                @if (count($d['services']))
                    <div>
                        <h3 class="text-lg font-semibold">Servicii</h3>
                        <ul class="divide-y divide-slate-100">
                            @foreach ($d['services'] as $l)
                                <li class="flex justify-between py-2 text-base">
                                    <span>{{ $l['TITLE'] }} · {{ Format::qty($l['QTY']) }}</span>
                                    <b>{{ Format::money($l['SUMA'], $d['CURRENCYID']) }}</b>
                                </li>
                            @endforeach
                        </ul>
                        <p class="flex justify-between border-t border-slate-200 pt-2 text-lg font-bold"><span>Total servicii</span><span>{{ Format::money(array_sum(array_column($d['services'], 'SUMA')), $d['CURRENCYID']) }}</span></p>
                    </div>
                @endif

                <p class="flex justify-between rounded-xl bg-slate-900 px-4 py-3 text-xl font-bold text-white">
                    <span>Total comandă</span><span>{{ Format::money($d['DOC_SUMA'], $d['CURRENCYID']) }}</span>
                </p>
            </section>
        @endforeach
    @endif

    {{-- ================= DEPOZIT ================= --}}
    @if ($kind === 1)
        <section class="card">
            <h2 class="text-xl font-bold">De încărcat</h2>
            <ul class="mt-2 divide-y divide-slate-100">
                @forelse ($loads as $l)
                    <li class="py-3">
                        <p class="text-lg leading-tight font-semibold">{{ $l['TITLE'] }}</p>
                        <p class="text-base text-slate-500">{{ $l['CODE'] }} · document {{ $l['DOCID'] }}</p>
                        <p class="mt-1 text-lg"><b>{{ Format::qty($l['QTY']) }} buc</b></p>
                        @if ($l['TASK_NOTE'])<p class="text-base text-amber-800">{{ $l['TASK_NOTE'] }}</p>@endif
                    </li>
                @empty
                    <li class="py-3 text-slate-500">Nimic de încărcat.</li>
                @endforelse
            </ul>
        </section>
    @endif
</div>
