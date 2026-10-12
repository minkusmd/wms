<?php

/*
|--------------------------------------------------------------------------
| Firebird WMS - sursa operationala
|--------------------------------------------------------------------------
|
| Datele operationale (sarcini, trasee, documente) raman in baza Firebird a
| WMS. Aplicatia le acceseaza prin App\Firebird\FirebirdConnection, cu SQL
| parametrizat si proceduri - nu prin Eloquent.
|
| pdo_firebird porneste tranzactiile cu "wait" fara limita: un UPDATE pe un
| rand blocat de alta tranzactie (de ex. un dialog WMS ramas deschis) ar
| astepta la nesfirsit. De aceea fiecare conexiune seteaza
| SET STATEMENT TIMEOUT = statement_timeout secunde.
|
*/

return [

    'default' => 'wms',

    'connections' => [

        'wms' => [
            'host' => env('FB_HOST', 'firebird-test'),
            'port' => (int) env('FB_PORT', 3050),
            // alias din databases.conf (de preferat) sau cale completa pe server
            'database' => env('FB_DATABASE', 'SW'),
            'username' => env('FB_USERNAME', 'CURIERI'),
            'password' => env('FB_PASSWORD', ''),
            'role' => env('FB_ROLE'),
            'charset' => 'UTF8',
            // read_committed | repeatable_read | serializable
            'isolation' => env('FB_ISOLATION', 'read_committed'),
            'statement_timeout' => (int) env('FB_STATEMENT_TIMEOUT', 10),
        ],

    ],

    /*
    | Verificarile care scriu (curieri:verifica-firebird --scriere) fac mereu
    | ROLLBACK, dar ruleaza numai cand flagul e true SI baza nu e in lista de
    | baze protejate (comparat cu FB_DATABASE si cu numele fisierului pe server).
    */
    'allow_write_probes' => (bool) env('FB_ALLOW_WRITE_PROBES', false),

    'protected_databases' => ['SW', 'sw5.fdb'],

];
