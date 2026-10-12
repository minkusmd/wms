<?php

namespace App\Firebird;

/**
 * Valoare binara pentru un parametru BLOB SUB_TYPE BINARY (de ex. o fotografie).
 * Textul pentru BLOB SUB_TYPE TEXT se trimite ca string obisnuit.
 */
final class Blob
{
    public function __construct(public readonly string $data) {}
}
