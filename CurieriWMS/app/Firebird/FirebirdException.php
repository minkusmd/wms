<?php

namespace App\Firebird;

use PDOException;
use RuntimeException;

/**
 * Eroare Firebird cu clasificarea de care are nevoie fluxul soferilor:
 * conflict de blocare (alt utilizator modifica acelasi rand), timeout,
 * exceptie de business ridicata dintr-un trigger/procedura.
 */
class FirebirdException extends RuntimeException
{
    public function __construct(
        string $message,
        public readonly ?string $sqlState = null,
        public readonly ?int $sqlCode = null,
        public readonly ?string $sql = null,
        ?\Throwable $previous = null,
    ) {
        parent::__construct($message, (int) ($sqlCode ?? 0), $previous);
    }

    public static function fromPdo(PDOException $e, ?string $sql = null): self
    {
        $info = $e->errorInfo ?? [];

        return new self(
            $info[2] ?? $e->getMessage(),
            $info[0] ?? (is_string($e->getCode()) ? $e->getCode() : null),
            isset($info[1]) ? (int) $info[1] : null,
            $sql,
            $e,
        );
    }

    /** Randul e blocat/modificat de o alta tranzactie (lock conflict, update conflict, deadlock). */
    public function isLockConflict(): bool
    {
        return $this->sqlState === '40001'
            || (bool) preg_match('/lock conflict|update conflicts|deadlock|concurrent update/i', $this->getMessage());
    }

    /** Instructiunea a fost oprita de SET STATEMENT TIMEOUT (de regula asteptind un rand blocat). */
    public function isTimeout(): bool
    {
        return $this->sqlState === 'HY008'
            || (bool) preg_match('/timeout|timed out|operation was cancelled/i', $this->getMessage());
    }

    /** Exceptie Firebird definita de utilizator (EXCEPTION ERR_... din trigger/procedura). */
    public function isBusinessRule(): bool
    {
        return (bool) preg_match('/exception \d+|ERR_[A-Z_]+/', $this->getMessage());
    }

    /**
     * Textul unei exceptii de business, fara cod si fara locul din procedura:
     * "... exception 2 ERR_DISPATCH Oprirea nu este pe traseul tau At procedure 'X' line: 48 ..."
     * -> "Oprirea nu este pe traseul tau". Null daca nu e o exceptie de business.
     */
    public function userMessage(): ?string
    {
        if (! preg_match('/\bERR_[A-Z_]+\s+(.+?)(?:\s+At (?:procedure|trigger|block)\b.*)?$/s', $this->getMessage(), $m)) {
            return null;
        }
        $text = trim(preg_replace('/\s+/', ' ', $m[1]));

        return $text === '' ? null : $text;
    }
}
