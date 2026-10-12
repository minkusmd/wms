<?php

namespace App\Auth;

use Illuminate\Contracts\Auth\Authenticatable;

/**
 * Curierul autentificat: colaboratorul din TS_CUSTOMER cu profilul TS_COURIER.
 * Nu e model Eloquent - randul vine din Firebird prin CourierUserProvider.
 */
class Courier implements Authenticatable
{
    public function __construct(
        public readonly int $id,
        public readonly string $name,
        public readonly string $login,
        public readonly ?int $stockId,
        public readonly bool $canPickup,
        public readonly bool $canDeliver,
        private readonly ?string $passwordHash,
        private ?string $rememberToken,
    ) {}

    /** @param array<string, mixed> $row rand din CourierUserProvider::SELECT */
    public static function fromRow(array $row): self
    {
        return new self(
            id: (int) $row['CUSTOMERID'],
            name: trim((string) $row['NAME']),
            login: trim((string) $row['WEB_LOGIN']),
            stockId: $row['STOCKID'] !== null ? (int) $row['STOCKID'] : null,
            canPickup: (int) $row['FLG_CAN_PICKUP'] === 1,
            canDeliver: (int) $row['FLG_CAN_DELIVER'] === 1,
            passwordHash: $row['WEB_PASSWORD_HASH'],
            rememberToken: $row['WEB_REMEMBER_TOKEN'],
        );
    }

    public function getAuthIdentifierName(): string
    {
        return 'CUSTOMERID';
    }

    public function getAuthIdentifier(): int
    {
        return $this->id;
    }

    public function getAuthPasswordName(): string
    {
        return 'WEB_PASSWORD_HASH';
    }

    public function getAuthPassword(): string
    {
        return (string) $this->passwordHash;
    }

    public function getRememberToken(): ?string
    {
        return $this->rememberToken;
    }

    public function setRememberToken($value): void
    {
        $this->rememberToken = $value;
    }

    public function getRememberTokenName(): string
    {
        return 'WEB_REMEMBER_TOKEN';
    }
}
