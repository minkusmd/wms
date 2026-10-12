<?php

namespace App\Support;

/** Formatari pentru ecranele soferului (stil romanesc: 1 234,50). */
class Format
{
    private const CURRENCIES = [498 => 'lei', 840 => 'USD', 978 => 'EUR'];

    public static function money(float|int|string|null $amount, int|string|null $currencyId = 498): string
    {
        if ($amount === null || $amount === '') {
            return '—';
        }

        return number_format((float) $amount, 2, ',', ' ').' '.self::currency($currencyId);
    }

    public static function currency(int|string|null $currencyId): string
    {
        return self::CURRENCIES[(int) $currencyId] ?? 'lei';
    }

    /** Cantitate fara zecimale inutile: 2 / 1,5 */
    public static function qty(float|int|string|null $qty): string
    {
        $value = (float) $qty;

        return floor($value) == $value
            ? number_format($value, 0, ',', ' ')
            : rtrim(rtrim(number_format($value, 3, ',', ' '), '0'), ',');
    }

    /** Link de harta: coordonatele daca exista, altfel adresa (plan §9A). */
    public static function mapUrl(?string $address, mixed $lat = null, mixed $lng = null): ?string
    {
        if ($lat !== null && $lng !== null && (float) $lat != 0.0) {
            return 'https://www.google.com/maps/search/?api=1&query='.rawurlencode($lat.','.$lng);
        }
        $address = trim((string) $address);

        return $address === '' ? null : 'https://www.google.com/maps/search/?api=1&query='.rawurlencode($address);
    }

    public static function phoneUrl(?string $phone): ?string
    {
        $digits = preg_replace('/[^0-9+]/', '', (string) $phone);

        return $digits === '' ? null : 'tel:'.$digits;
    }
}
