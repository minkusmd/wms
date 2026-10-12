<?php

namespace App\Dispatch;

use App\Firebird\FirebirdException;
use RuntimeException;

/**
 * Eroare de afisat soferului ca atare (regula de business, conflict, oprire
 * care nu mai e a lui). Erorile tehnice raman FirebirdException si se jurnalizeaza.
 */
class DispatchException extends RuntimeException
{
    /**
     * Mesajele procedurilor sunt ASCII (regula pentru DB Model); soferul le vede
     * in romana cu diacritice. Cheia = inceputul textului din baza.
     */
    private const MESSAGES = [
        'Oprirea nu este pe traseul tau' => 'Oprirea nu este pe traseul tău.',
        'Traseul nu este publicat' => 'Traseul nu este publicat.',
        'Oprirea nu este la un furnizor' => 'Oprirea nu este la un furnizor.',
        'Oprirea a fost anulata de dispecer' => 'Oprirea a fost anulată de dispecer.',
        'Curierul nu are depozit asociat' => 'Nu ai un depozit (mașină) asociat. Anunță dispecerul.',
        'La aceasta oprire nu exista produse' => 'La această oprire nu există produse de preluat sau de returnat.',
        'Preluarea apartine altui curier' => 'Preluarea aparține altui curier.',
        'Preluarea este deja inchisa' => 'Preluarea este deja închisă.',
        'Preluarea a fost anulata' => 'Preluarea a fost anulată.',
        'Preluarea nu exista sau apartine altui curier' => 'Preluarea nu există sau aparține altui curier.',
        'Preluarea nu este deschisa' => 'Preluarea nu este deschisă: fotografia nu mai poate fi adăugată.',
        'Scrie motivul pentru cantitatea lipsa' => 'Scrie motivul pentru cantitatea lipsă.',
        'Confirma cantitatea pentru fiecare produs' => 'Confirmă cantitatea pentru fiecare produs.',
        'Lipsesc fotografii' => 'Lipsesc fotografii ale seriilor sau partidelor.',
        'Fotografia apartine altui curier' => 'Fotografia aparține altui curier.',
        'Numarul unitatii depaseste cantitatea' => 'Numărul unității depășește cantitatea.',
        'Dispeceratul nu este configurat' => 'Dispeceratul nu este configurat pentru firmă. Anunță dispecerul.',
        'Lista de preluare este blocata' => 'Lista de preluare este blocată.',
    ];

    /** Transforma erorile Firebird previzibile in mesaje pentru sofer; restul le lasa sa urce. */
    public static function wrap(FirebirdException $e): self|FirebirdException
    {
        if ($e->isTimeout() || $e->isLockConflict()) {
            return new self('Dispecerul modifică acum aceste date. Reîncarcă pagina peste câteva secunde.', 0, $e);
        }
        $message = $e->userMessage();

        return $message !== null ? new self(self::translate($message), 0, $e) : $e;
    }

    public static function translate(string $message): string
    {
        if (preg_match('/^Cantitatea trebuie sa fie intre 0 si ([\d.]+)/', $message, $m)) {
            return 'Cantitatea trebuie să fie între 0 și '.rtrim(rtrim($m[1], '0'), '.').'.';
        }
        foreach (self::MESSAGES as $prefix => $text) {
            if (str_starts_with($message, $prefix)) {
                return $text;
            }
        }

        return $message;
    }

    /**
     * Ruleaza $operation si traduce erorile Firebird previzibile.
     *
     * @template T
     *
     * @param  callable(): T  $operation
     * @return T
     */
    public static function guard(callable $operation): mixed
    {
        try {
            return $operation();
        } catch (FirebirdException $e) {
            throw self::wrap($e);
        }
    }
}
