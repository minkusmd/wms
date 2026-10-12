<?php

namespace App\Firebird;

use Closure;
use PDO;
use Pdo\Firebird as PdoFirebird;
use PDOException;
use PDOStatement;
use Throwable;

/**
 * Accesul la baza Firebird a WMS: SQL parametrizat, proceduri, tranzactii explicite.
 *
 * - O instanta = o conexiune (attachment). Pentru doua tranzactii concurente
 *   (de ex. testul de conflict) se creeaza doua instante.
 * - In afara unei tranzactii explicite fiecare instructiune ruleaza in
 *   autocommit (read committed).
 * - Erorile PDO sunt transformate in FirebirdException.
 */
class FirebirdConnection
{
    private ?PDO $pdo = null;

    /** @param array{host:string,port:int,database:string,username:string,password:string,role:?string,charset:string,isolation:string,statement_timeout:int} $config */
    public function __construct(private readonly array $config) {}

    public static function fromConfig(?string $name = null, array $overrides = []): self
    {
        $name ??= config('firebird.default');

        return new self(array_merge(config("firebird.connections.$name"), $overrides));
    }

    public function config(string $key): mixed
    {
        return $this->config[$key] ?? null;
    }

    public function pdo(): PDO
    {
        return $this->pdo ??= $this->connect();
    }

    public function disconnect(): void
    {
        if ($this->pdo?->inTransaction()) {
            $this->pdo->rollBack();
        }
        $this->pdo = null;
    }

    /** @return list<array<string, mixed>> */
    public function select(string $sql, array $bindings = []): array
    {
        $statement = $this->run($sql, $bindings);

        return $this->wrap(fn () => $statement->fetchAll(PDO::FETCH_ASSOC), $sql);
    }

    /** @return array<string, mixed>|null */
    public function selectOne(string $sql, array $bindings = []): ?array
    {
        $statement = $this->run($sql, $bindings);
        $row = $this->wrap(fn () => $statement->fetch(PDO::FETCH_ASSOC), $sql);

        return $row === false ? null : $row;
    }

    public function scalar(string $sql, array $bindings = []): mixed
    {
        $statement = $this->run($sql, $bindings);
        $value = $this->wrap(fn () => $statement->fetchColumn(), $sql);

        return $value === false ? null : $value;
    }

    /** INSERT/UPDATE/DELETE/EXECUTE PROCEDURE; intoarce numarul de randuri afectate. */
    public function execute(string $sql, array $bindings = []): int
    {
        return $this->run($sql, $bindings)->rowCount();
    }

    /**
     * Ruleaza $callback intr-o tranzactie: COMMIT la succes, ROLLBACK la orice exceptie.
     *
     * @template T
     *
     * @param  Closure(self): T  $callback
     * @return T
     */
    public function transaction(Closure $callback): mixed
    {
        $this->begin();
        try {
            $result = $callback($this);
            $this->commit();

            return $result;
        } catch (Throwable $e) {
            $this->rollBack();
            throw $e;
        }
    }

    public function begin(): void
    {
        $this->wrap(fn () => $this->pdo()->beginTransaction());
    }

    public function commit(): void
    {
        $this->wrap(fn () => $this->pdo()->commit());
    }

    public function rollBack(): void
    {
        if ($this->pdo?->inTransaction()) {
            $this->wrap(fn () => $this->pdo->rollBack());
        }
    }

    public function inTransaction(): bool
    {
        return (bool) $this->pdo?->inTransaction();
    }

    private function connect(): PDO
    {
        $c = $this->config;
        $dsn = sprintf('firebird:dbname=%s/%d:%s;charset=%s', $c['host'], $c['port'], $c['database'], $c['charset'] ?? 'UTF8');
        if (! empty($c['role'])) {
            $dsn .= ';role='.$c['role'];
        }

        try {
            $pdo = new PdoFirebird($dsn, $c['username'], $c['password'], [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_CASE => PDO::CASE_UPPER,
                PdoFirebird::TRANSACTION_ISOLATION_LEVEL => match ($c['isolation'] ?? 'read_committed') {
                    'serializable' => PdoFirebird::SERIALIZABLE,
                    'repeatable_read' => PdoFirebird::REPEATABLE_READ,
                    default => PdoFirebird::READ_COMMITTED,
                },
            ]);

            $timeout = (int) ($c['statement_timeout'] ?? 0);
            if ($timeout > 0) {
                $pdo->exec("SET STATEMENT TIMEOUT $timeout SECOND");
            }
        } catch (PDOException $e) {
            // DSN-ul nu contine parola, dar mesajul nu trebuie sa ajunga la telefon
            throw FirebirdException::fromPdo($e, 'CONNECT '.$c['host'].'/'.$c['port'].':'.$c['database']);
        }

        return $pdo;
    }

    private function run(string $sql, array $bindings): PDOStatement
    {
        try {
            $statement = $this->pdo()->prepare($sql);
            foreach ($bindings as $key => $value) {
                $param = is_int($key) ? $key + 1 : ':'.ltrim($key, ':');
                [$value, $type] = match (true) {
                    $value instanceof Blob => [$value->data, PDO::PARAM_LOB],
                    $value === null => [null, PDO::PARAM_NULL],
                    is_bool($value) => [(int) $value, PDO::PARAM_INT],
                    is_int($value) => [$value, PDO::PARAM_INT],
                    $value instanceof \DateTimeInterface => [$value->format('Y-m-d H:i:s'), PDO::PARAM_STR],
                    default => [(string) $value, PDO::PARAM_STR],
                };
                $statement->bindValue($param, $value, $type);
            }
            $statement->execute();

            return $statement;
        } catch (PDOException $e) {
            throw FirebirdException::fromPdo($e, $sql);
        }
    }

    /**
     * La procedurile selectabile (SELECT ... FROM SP_...) Firebird ridica exceptiile
     * abia la fetch, nu la execute - de aceea si citirea randurilor trece pe aici.
     */
    private function wrap(Closure $operation, ?string $sql = null): mixed
    {
        try {
            return $operation();
        } catch (PDOException $e) {
            throw FirebirdException::fromPdo($e, $sql);
        }
    }
}
