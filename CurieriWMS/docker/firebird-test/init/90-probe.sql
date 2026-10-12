/* Tabela folosita NUMAI de comanda `php artisan curieri:verifica-firebird --scriere`
   pentru verificarea BLOB-urilor (text UTF-8 + binar). Exista doar in baza de test. */

CREATE TABLE TCURIERI_PROBE (
    ID      INTEGER NOT NULL,
    TXT     BLOB SUB_TYPE TEXT CHARACTER SET UTF8,
    BIN     BLOB SUB_TYPE BINARY,
    CONSTRAINT PK_TCURIERI_PROBE PRIMARY KEY (ID)
);

COMMIT;
