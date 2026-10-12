<?php

namespace App\Dispatch;

use App\Firebird\FirebirdConnection;
use Illuminate\Contracts\Hashing\Hasher;

/**
 * Activarea contului web al curierului.
 *
 * Dispecerul genereaza in WMS un cod de activare (SP_COURIER_WEB_ACTIVATION:
 * hash SHA-256 + expirare in TS_COURIER). Curierul introduce loginul, codul si
 * parola aleasa; parola se salveaza numai ca hash bcrypt. O noua activare
 * (resetare din WMS) sterge parola si sesiunile "tine-ma minte".
 */
class CourierAccounts
{
    public function __construct(private readonly FirebirdConnection $db, private readonly Hasher $hasher) {}

    /** @return int|null CUSTOMERID-ul curierului activat, null daca loginul/codul nu sunt valide */
    public function activate(string $login, #[\SensitiveParameter] string $code, #[\SensitiveParameter] string $password): ?int
    {
        $row = $this->db->selectOne(<<<'SQL'
            SELECT CUSTOMERID, WEB_ACTIVATION_HASH
            FROM TS_COURIER
            WHERE FLG_ACTIVE = 1
              AND UPPER(WEB_LOGIN) = UPPER(:login)
              AND WEB_ACTIVATION_HASH IS NOT NULL
              AND WEB_ACTIVATION_EXPIRES > CURRENT_TIMESTAMP
            SQL, ['login' => trim($login)]);

        if ($row === null) {
            return null;
        }
        $stored = strtolower(trim((string) $row['WEB_ACTIVATION_HASH']));
        if (! hash_equals($stored, hash('sha256', trim($code)))) {
            return null;
        }

        // conditionat pe hash-ul vechi: doua activari simultane cu acelasi cod -> una singura reuseste
        $changed = $this->db->execute(<<<'SQL'
            UPDATE TS_COURIER
            SET WEB_PASSWORD_HASH = :hash, WEB_REMEMBER_TOKEN = NULL,
                WEB_ACTIVATION_HASH = NULL, WEB_ACTIVATION_EXPIRES = NULL
            WHERE CUSTOMERID = :id AND WEB_ACTIVATION_HASH = :old
            SQL, ['hash' => $this->hasher->make($password), 'id' => (int) $row['CUSTOMERID'], 'old' => $row['WEB_ACTIVATION_HASH']]);

        return $changed === 1 ? (int) $row['CUSTOMERID'] : null;
    }
}
