<?php

namespace App\Console\Commands;

use Illuminate\Console\Attributes\Description;
use Illuminate\Console\Attributes\Signature;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Throwable;

/**
 * Verifica driverele Firebird pe conexiunea "firebird" (config/database.php):
 * extensia pdo_firebird, extensia interbase (ibase_*) si driverul Eloquent.
 */
#[Signature('firebird:check')]
#[Description('Verifica pdo_firebird, ibase_* si conexiunea Eloquent "firebird"')]
class FirebirdCheck extends Command
{
    public function handle(): int
    {
        $cfg = config('database.connections.firebird');
        $dsn = sprintf('%s/%s:%s', $cfg['host'], $cfg['port'], $cfg['database']);
        $this->line('Baza: '.$dsn.' (utilizator '.$cfg['username'].', charset '.$cfg['charset'].')');

        $ok = true;
        $sql = "select rdb\$get_context('SYSTEM', 'ENGINE_VERSION') as ENGINE, current_timestamp as NOW_TS from rdb\$database";

        // 1. PDO direct
        $ok = $this->step('pdo_firebird', function () use ($cfg, $dsn, $sql) {
            $pdo = new \PDO('firebird:dbname='.$dsn.';charset='.$cfg['charset'], $cfg['username'], $cfg['password'], [
                \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION,
            ]);
            $row = $pdo->query($sql)->fetch(\PDO::FETCH_ASSOC);

            return 'Firebird '.$row['ENGINE'].', '.$row['NOW_TS'];
        }) && $ok;

        // 2. extensia interbase (ibase_* / fbird_*)
        $ok = $this->step('interbase (ibase_*)', function () use ($cfg, $dsn, $sql) {
            $db = ibase_connect($dsn, $cfg['username'], $cfg['password'], $cfg['charset']);
            if ($db === false) {
                throw new \RuntimeException(ibase_errmsg() ?: 'ibase_connect a esuat');
            }
            $row = ibase_fetch_assoc(ibase_query($db, $sql));
            ibase_close($db);

            return 'Firebird '.$row['ENGINE'].', '.$row['NOW_TS'];
        }) && $ok;

        // 3. Laravel / Eloquent (harrygulliford/laravel-firebird)
        $ok = $this->step('Laravel DB::connection(\'firebird\')', function () {
            $engine = DB::connection('firebird')
                ->table('RDB$DATABASE')
                ->selectRaw("rdb\$get_context('SYSTEM', 'ENGINE_VERSION') as ENGINE")
                ->value('ENGINE');
            $tables = DB::connection('firebird')
                ->table('RDB$RELATIONS')
                ->where('RDB$SYSTEM_FLAG', 0)
                ->count();

            return 'Firebird '.$engine.', tabele utilizator: '.$tables;
        }) && $ok;

        return $ok ? self::SUCCESS : self::FAILURE;
    }

    private function step(string $name, callable $fn): bool
    {
        try {
            $this->components->twoColumnDetail($name, '<fg=green>OK</> '.$fn());

            return true;
        } catch (Throwable $e) {
            $this->components->twoColumnDetail($name, '<fg=red>EROARE</> '.$e->getMessage());

            return false;
        }
    }
}
