<?php

namespace App\Auth;

use App\Firebird\FirebirdConnection;
use Closure;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Contracts\Auth\UserProvider;
use Illuminate\Contracts\Hashing\Hasher;

/**
 * Conturile web ale curierilor sunt in TS_COURIER (baza WMS), nu in SQLite:
 * dispecerul le activeaza/blocheaza din WMS, iar aplicatia doar le citeste
 * si salveaza parola aleasa de curier (hash bcrypt).
 *
 * Un cont e valid numai daca profilul e activ si colaboratorul exista.
 */
class CourierUserProvider implements UserProvider
{
    private const SELECT = <<<'SQL'
        SELECT K.CUSTOMERID, C.NAME, K.WEB_LOGIN, K.STOCKID, K.FLG_CAN_PICKUP, K.FLG_CAN_DELIVER,
               K.WEB_PASSWORD_HASH, K.WEB_REMEMBER_TOKEN
        FROM TS_COURIER K
        JOIN TS_CUSTOMER C ON C.CUSTOMERID = K.CUSTOMERID
        WHERE K.FLG_ACTIVE = 1 AND K.WEB_PASSWORD_HASH IS NOT NULL
        SQL;

    /** @param Closure(): FirebirdConnection $db conexiunea e scoped per request */
    public function __construct(private readonly Closure $db, private readonly Hasher $hasher) {}

    private function db(): FirebirdConnection
    {
        return ($this->db)();
    }

    public function retrieveById($identifier): ?Courier
    {
        $row = $this->db()->selectOne(self::SELECT.' AND K.CUSTOMERID = :id', ['id' => (int) $identifier]);

        return $row ? Courier::fromRow($row) : null;
    }

    public function retrieveByToken($identifier, #[\SensitiveParameter] $token): ?Courier
    {
        $courier = $this->retrieveById($identifier);
        $stored = $courier?->getRememberToken();

        return $stored !== null && $stored !== '' && hash_equals($stored, (string) $token) ? $courier : null;
    }

    public function updateRememberToken(Authenticatable $user, #[\SensitiveParameter] $token): void
    {
        $this->db()->execute(
            'UPDATE TS_COURIER SET WEB_REMEMBER_TOKEN = :token WHERE CUSTOMERID = :id',
            ['token' => $token, 'id' => $user->getAuthIdentifier()],
        );
    }

    /** @param array{login?: string} $credentials */
    public function retrieveByCredentials(#[\SensitiveParameter] array $credentials): ?Courier
    {
        $login = trim((string) ($credentials['login'] ?? ''));
        if ($login === '') {
            return null;
        }
        $row = $this->db()->selectOne(self::SELECT.' AND UPPER(K.WEB_LOGIN) = UPPER(:login)', ['login' => $login]);

        return $row ? Courier::fromRow($row) : null;
    }

    public function validateCredentials(Authenticatable $user, #[\SensitiveParameter] array $credentials): bool
    {
        $hash = $user->getAuthPassword();

        return $hash !== '' && $this->hasher->check((string) ($credentials['password'] ?? ''), $hash);
    }

    public function rehashPasswordIfRequired(Authenticatable $user, #[\SensitiveParameter] array $credentials, bool $force = false): void
    {
        if (! $this->hasher->needsRehash($user->getAuthPassword()) && ! $force) {
            return;
        }
        $this->db()->execute(
            'UPDATE TS_COURIER SET WEB_PASSWORD_HASH = :hash WHERE CUSTOMERID = :id',
            ['hash' => $this->hasher->make((string) $credentials['password']), 'id' => $user->getAuthIdentifier()],
        );
    }
}
