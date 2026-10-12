<?php

namespace App\Console\Commands;

use App\Firebird\Blob;
use App\Firebird\FirebirdConnection;
use App\Firebird\FirebirdException;
use Illuminate\Console\Command;
use Throwable;

/**
 * Primul pas tehnic din planul dispeceratului (§9A): verificarea restrinsa a
 * integrarii Laravel - Firebird inainte de implementarea fluxurilor.
 *
 *   php artisan curieri:verifica-firebird             doar citiri (sigur si pe SW)
 *   php artisan curieri:verifica-firebird --scriere   + tranzactie cu ROLLBACK,
 *                                                     BLOB-uri si conflictul de alocare
 *                                                     (numai pe baza de test)
 */
class VerificaFirebird extends Command
{
    protected $signature = 'curieri:verifica-firebird
        {--scriere : ruleaza si verificarile care scriu (mereu cu ROLLBACK; doar cu FB_ALLOW_WRITE_PROBES=true)}
        {--sarcina= : PICKUPID folosit la verificari (implicit ultima sarcina neanulata)}
        {--timeout=3 : secunde de asteptare pentru writer-ul blocat in testul de conflict}';

    protected $description = 'Verifica integrarea cu Firebird WMS: conexiune, UTF-8, citire sarcina, BLOB, rollback, conflict de alocare';

    private int $failures = 0;

    public function handle(FirebirdConnection $db): int
    {
        $this->line('Firebird: <info>'.$db->config('host').'/'.$db->config('port').':'.$db->config('database').'</info> ca <info>'.$db->config('username').'</info>');

        $info = $this->check('Conexiune si parametrii sesiunii', fn () => $this->checkConnection($db));
        if ($info === null) {
            return self::FAILURE;
        }

        $task = $this->check('Citirea unei sarcini de ridicare (TDB_SUPPLIER_PICKUP)', fn () => $this->checkReadTask($db));
        $this->check('Citire BLOB text (metadate)', fn () => $this->checkReadBlob($db));

        if ($this->option('scriere')) {
            if (! $this->writeProbesAllowed($info)) {
                $this->failures++;
            } elseif (! is_array($task)) {
                $this->error('Nu exista nicio sarcina pentru verificarile cu scriere.');
                $this->failures++;
            } else {
                $this->check('Tranzactie cu ROLLBACK (UPDATE + INSERT ... RETURNING)', fn () => $this->checkRollback($db, $task));
                $this->check('BLOB text UTF-8 + binar (scriere si citire, ROLLBACK)', fn () => $this->checkBlobRoundTrip($db));
                $this->check('Conflict de alocare intre doua conexiuni', fn () => $this->checkAllocationConflict($db, $task));
            }
        } else {
            $this->line('<comment>Verificarile cu scriere au fost sarite (fara --scriere).</comment>');
        }

        $this->newLine();
        if ($this->failures > 0) {
            $this->error("Esuate: {$this->failures}");

            return self::FAILURE;
        }
        $this->info('Toate verificarile au trecut.');

        return self::SUCCESS;
    }

    // ------------------------------------------------------------------ verificari

    private function checkConnection(FirebirdConnection $db): array
    {
        $row = $db->selectOne(<<<'SQL'
            SELECT
                RDB$GET_CONTEXT('SYSTEM', 'ENGINE_VERSION') AS ENGINE_VERSION,
                RDB$GET_CONTEXT('SYSTEM', 'DB_NAME') AS DB_NAME,
                RDB$GET_CONTEXT('SYSTEM', 'WIRE_ENCRYPTED') AS WIRE_ENCRYPTED,
                CURRENT_USER AS DB_USER,
                CURRENT_ROLE AS DB_ROLE,
                TRIM(CS.RDB$CHARACTER_SET_NAME) AS ATT_CHARSET,
                A.MON$STATEMENT_TIMEOUT AS STATEMENT_TIMEOUT_MS
            FROM MON$ATTACHMENTS A
            JOIN RDB$CHARACTER_SETS CS ON CS.RDB$CHARACTER_SET_ID = A.MON$CHARACTER_SET_ID
            WHERE A.MON$ATTACHMENT_ID = CURRENT_CONNECTION
            SQL);

        $pdo = $db->pdo();
        $row['CLIENT_VERSION'] = $pdo->getAttribute(\PDO::ATTR_CLIENT_VERSION);

        $this->table(['Parametru', 'Valoare'], collect($row)->map(fn ($v, $k) => [$k, $this->show($v)])->values()->all());

        $this->assert($row['ATT_CHARSET'] === 'UTF8', "charset-ul conexiunii este {$row['ATT_CHARSET']}, nu UTF8");
        $expected = (int) $db->config('statement_timeout') * 1000;
        $this->assert((int) $row['STATEMENT_TIMEOUT_MS'] === $expected, "SET STATEMENT TIMEOUT nu s-a aplicat ({$row['STATEMENT_TIMEOUT_MS']} ms, asteptat $expected ms)");

        return $row;
    }

    private function checkReadTask(FirebirdConnection $db): ?array
    {
        $id = $this->option('sarcina');
        // implicit se evita ridicarile din preluari incepute de sofer (blocate, DB Model/dispatch_logistics.sql);
        // filtrul se adauga doar daca tabela exista deja in baza
        $hasPickupDocs = $db->scalar("SELECT COUNT(*) FROM RDB\$RELATIONS WHERE RDB\$RELATION_NAME = 'TDB_PICKUP_DOC_ITEM'") > 0;
        $notLocked = $hasPickupDocs ? <<<'SQL'
             AND (CAST(:id3 AS INTEGER) IS NOT NULL OR NOT EXISTS(
                 SELECT 1 FROM TDB_PICKUP_DOC_ITEM I JOIN TDB_PICKUP_DOC PD ON PD.PDOCID = I.PDOCID
                 WHERE I.PICKUPID = P.PICKUPID AND PD.STATEID IN (1, 2)))
            SQL : '';
        $bindings = ['id1' => $id === null ? null : (int) $id, 'id2' => $id === null ? null : (int) $id];
        if ($hasPickupDocs) {
            $bindings['id3'] = $bindings['id1'];
        }
        $task = $db->selectOne(<<<'SQL'
            SELECT FIRST 1
                P.PICKUPID, P.DOCID, P.GOODSID, P.GOODS_CODE, P.QTY, P.STATEID, P.PLAN_DATE,
                P.STOCK_SUPPLIERID, P.ORDER_SUPPLIERID, P.PICKUP_SUPPLIERID, P.DRIVERID, P.NOTE, P.UPDATED_AT,
                G.TITLE AS GOODS_TITLE,
                S.NAME AS PICKUP_SUPPLIER_NAME,
                D.NAME AS DRIVER_NAME
            FROM TDB_SUPPLIER_PICKUP P
            LEFT JOIN TS_GOODS G ON G.GOODSID = P.GOODSID
            LEFT JOIN TS_CUSTOMER S ON S.CUSTOMERID = P.PICKUP_SUPPLIERID
            LEFT JOIN TS_CUSTOMER D ON D.CUSTOMERID = P.DRIVERID
            WHERE P.STATEID < 3 AND (CAST(:id1 AS INTEGER) IS NULL OR P.PICKUPID = :id2)
            SQL.$notLocked.' ORDER BY P.PICKUPID DESC', $bindings);

        if ($task === null) {
            $this->warn('  nicio sarcina neanulata gasita');

            return null;
        }

        $this->table(['Coloana', 'Valoare'], collect($task)->map(fn ($v, $k) => [$k, $this->show($v)])->values()->all());

        foreach (['GOODS_TITLE', 'PICKUP_SUPPLIER_NAME', 'DRIVER_NAME', 'NOTE', 'GOODS_CODE'] as $col) {
            if (is_string($task[$col] ?? null)) {
                $this->assert(mb_check_encoding($task[$col], 'UTF-8'), "$col nu este UTF-8 valid");
            }
        }

        return $task;
    }

    private function checkReadBlob(FirebirdConnection $db): void
    {
        $row = $db->selectOne(<<<'SQL'
            SELECT FIRST 1 TRIM(RDB$RELATION_NAME) AS NAME, RDB$VIEW_SOURCE AS SRC
            FROM RDB$RELATIONS
            WHERE RDB$VIEW_BLR IS NOT NULL AND RDB$SYSTEM_FLAG = 0
            ORDER BY RDB$RELATION_NAME
            SQL);

        $this->assert($row !== null, 'nicio vedere in baza');
        $this->assert(is_string($row['SRC']) && strlen($row['SRC']) > 0, 'BLOB-ul RDB$VIEW_SOURCE a venit gol');
        $this->line(sprintf('  %s: %d octeti de sursa', $row['NAME'], strlen($row['SRC'])));
    }

    private function checkRollback(FirebirdConnection $db, array $task): void
    {
        $id = (int) $task['PICKUPID'];
        $note = 'Proba CurieriWMS ăâîșț ĂÂÎȘȚ — проверка '.bin2hex(random_bytes(3));

        $db->begin();
        try {
            $affected = $db->execute('UPDATE TDB_SUPPLIER_PICKUP SET NOTE = :note WHERE PICKUPID = :id', ['note' => $note, 'id' => $id]);
            $this->assert($affected === 1, "UPDATE a afectat $affected randuri");

            $inside = $db->scalar('SELECT NOTE FROM TDB_SUPPLIER_PICKUP WHERE PICKUPID = ?', [$id]);
            $this->assert($inside === $note, 'textul UTF-8 citit in tranzactie difera de cel scris');

            $newId = (int) $db->scalar(<<<'SQL'
                INSERT INTO TDB_SUPPLIER_PICKUP (DOCID, GOODSID, QTY, STOCK_SUPPLIERID, ORDER_SUPPLIERID, PICKUP_SUPPLIERID, NOTE)
                VALUES (:doc, :goods, 1, :stock, :ord, :pick, :note)
                RETURNING PICKUPID
                SQL, [
                'doc' => (int) $task['DOCID'], 'goods' => (int) $task['GOODSID'],
                'stock' => (int) $task['STOCK_SUPPLIERID'], 'ord' => (int) $task['ORDER_SUPPLIERID'],
                'pick' => (int) $task['PICKUP_SUPPLIERID'], 'note' => $note,
            ]);
            $this->assert($newId > 0, 'INSERT ... RETURNING nu a intors PICKUPID');
            $this->line("  in tranzactie: NOTE modificat, sarcina noua #$newId");
        } finally {
            $db->rollBack();
        }

        $after = $db->selectOne('SELECT NOTE FROM TDB_SUPPLIER_PICKUP WHERE PICKUPID = ?', [$id]);
        $this->assert(($after['NOTE'] ?? null) === $task['NOTE'], 'dupa ROLLBACK NOTE nu a revenit la valoarea initiala');
        $ghost = (int) $db->scalar('SELECT COUNT(*) FROM TDB_SUPPLIER_PICKUP WHERE PICKUPID = ?', [$newId]);
        $this->assert($ghost === 0, "dupa ROLLBACK sarcina #$newId inca exista");
        $this->line('  dupa ROLLBACK: NOTE initial, sarcina noua disparuta');
    }

    private function checkBlobRoundTrip(FirebirdConnection $db): void
    {
        $exists = (int) $db->scalar("SELECT COUNT(*) FROM RDB\$RELATIONS WHERE RDB\$RELATION_NAME = 'TCURIERI_PROBE'");
        if ($exists === 0) {
            $this->warn('  tabela TCURIERI_PROBE lipseste (exista doar in baza de test) - sarit');

            return;
        }

        $text = str_repeat("Fotografie serie/partidă — серийный номер ăîșț\n", 3000);   // ~150 KB
        $binary = random_bytes(400 * 1024);                                               // ~ o fotografie mica
        $binary[0] = "\0";                                                                // octet nul la inceput

        $db->begin();
        try {
            $db->execute('INSERT INTO TCURIERI_PROBE (ID, TXT, BIN) VALUES (?, ?, ?)', [1, $text, new Blob($binary)]);
            $row = $db->selectOne('SELECT TXT, BIN FROM TCURIERI_PROBE WHERE ID = 1');
        } finally {
            $db->rollBack();
        }

        $this->assert($row['TXT'] === $text, 'BLOB text citit difera ('.strlen((string) $row['TXT']).' / '.strlen($text).' octeti)');
        $this->assert($row['BIN'] === $binary, 'BLOB binar citit difera ('.strlen((string) $row['BIN']).' / '.strlen($binary).' octeti)');
        $this->line(sprintf('  text %d octeti, binar %d octeti - identice dupa citire', strlen($text), strlen($binary)));
    }

    /**
     * Doi dispeceri / un dispecer si un sofer modifica aceeasi sarcina in acelasi timp:
     *  1. A atribuie soferul (UPDATE conditionat pe valoarea veche), nu face inca COMMIT;
     *  2. B incearca aceeasi atribuire -> trebuie sa primeasca eroare in ~timeout, nu sa astepte la nesfirsit;
     *  3. dupa ROLLBACK-ul lui A, B poate scrie.
     */
    private function checkAllocationConflict(FirebirdConnection $a, array $task): void
    {
        $timeout = max(1, (int) $this->option('timeout'));
        $b = FirebirdConnection::fromConfig(null, ['statement_timeout' => $timeout]);

        $id = (int) $task['PICKUPID'];
        $old = $task['DRIVERID'] === null ? null : (int) $task['DRIVERID'];
        $driver = (int) ($old === (int) $task['PICKUP_SUPPLIERID'] ? $task['STOCK_SUPPLIERID'] : $task['PICKUP_SUPPLIERID']);
        $cas = 'UPDATE TDB_SUPPLIER_PICKUP SET DRIVERID = :new WHERE PICKUPID = :id AND DRIVERID IS NOT DISTINCT FROM :old';
        $params = ['new' => $driver, 'id' => $id, 'old' => $old];

        try {
            $a->begin();
            $this->assert($a->execute($cas, $params) === 1, 'A: atribuirea conditionata nu a gasit randul');
            $this->line('  A: sarcina atribuita, fara COMMIT');

            $b->begin();
            $started = microtime(true);
            $error = null;
            try {
                $b->execute($cas, $params);
            } catch (FirebirdException $e) {
                $error = $e;
            }
            $elapsed = microtime(true) - $started;
            $b->rollBack();

            $this->assert($error !== null, 'B a scris peste randul blocat de A');
            $this->line(sprintf('  B: refuzat dupa %.1f s - [%s/%s] %s', $elapsed, $error->sqlState, $error->sqlCode, $this->firstLine($error->getMessage())));
            $this->line(sprintf('     clasificare: conflict=%s, timeout=%s', $error->isLockConflict() ? 'da' : 'nu', $error->isTimeout() ? 'da' : 'nu'));
            $this->assert($error->isLockConflict() || $error->isTimeout(), 'eroarea lui B nu e recunoscuta ca blocare/timeout');
            $this->assert($elapsed < $timeout + 5, sprintf('B a asteptat %.1f s (timeout %d s)', $elapsed, $timeout));

            $a->rollBack();
            $this->line('  A: ROLLBACK');

            $b->begin();
            $this->assert($b->execute($cas, $params) === 1, 'B: dupa eliberarea randului atribuirea nu a reusit');
            $b->rollBack();
            $this->line('  B: dupa eliberare atribuirea reuseste (ROLLBACK)');
        } finally {
            $a->rollBack();
            $b->disconnect();
        }
    }

    // ------------------------------------------------------------------ utilitare

    private function writeProbesAllowed(array $info): bool
    {
        if (! config('firebird.allow_write_probes')) {
            $this->error('Verificarile cu scriere sint dezactivate (FB_ALLOW_WRITE_PROBES=false).');

            return false;
        }

        $protected = array_map('strtolower', config('firebird.protected_databases', []));
        $names = [
            strtolower((string) config('firebird.connections.'.config('firebird.default').'.database')),
            strtolower(basename(str_replace('\\', '/', (string) $info['DB_NAME']))),
        ];
        if (array_intersect($names, $protected)) {
            $this->error('Baza '.$info['DB_NAME'].' este protejata: verificarile cu scriere ruleaza doar pe baza de test.');

            return false;
        }

        return true;
    }

    private function check(string $title, callable $probe): mixed
    {
        $this->newLine();
        $this->line("<options=bold>▶ $title</>");
        try {
            $result = $probe();
            $this->line('  <info>✔ OK</info>');

            return $result ?? true;
        } catch (Throwable $e) {
            $this->failures++;
            $this->line('  <error>✖ '.$this->firstLine($e->getMessage()).'</error>');
            if ($e instanceof FirebirdException && $e->sql) {
                $this->line('    SQL: '.$this->firstLine($e->sql));
            }

            return null;
        }
    }

    private function assert(bool $condition, string $message): void
    {
        if (! $condition) {
            throw new \RuntimeException($message);
        }
    }

    private function show(mixed $value): string
    {
        return match (true) {
            $value === null => 'NULL',
            is_string($value) && mb_strlen($value) > 80 => mb_substr($value, 0, 77).'...',
            default => (string) $value,
        };
    }

    private function firstLine(string $text): string
    {
        return trim(strtok($text, "\n") ?: $text);
    }
}
