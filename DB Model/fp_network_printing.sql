/*
  Tiparirea bonului fiscal pe MCC din reteaua locala.

  Serverul ZFPLab (ZFPLabServer) este un server HTTP: clientul WMS se conecteaza la el
  prin adresa din FP_DEVICES.SERVER_ADDRESS. Pentru MCC atasata la calculatorul curent
  adresa ramine goala si se foloseste http://localhost:4444/.

  COM_PORT / BAUD_RATE sint necesare pentru MCC din retea: pe un calculator strain nu se
  face cautare automata (finddevice() ar scana toate porturile seriale ale acelui
  calculator), de aceea portul se indica explicit.

  Scriptul este repetabil - se poate rula de mai multe ori.
*/

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'FP_DEVICES'
                   AND RDB$FIELD_NAME = 'SERVER_ADDRESS')) THEN
    EXECUTE STATEMENT 'ALTER TABLE FP_DEVICES ADD SERVER_ADDRESS VARCHAR(128)';

  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'FP_DEVICES'
                   AND RDB$FIELD_NAME = 'COM_PORT')) THEN
    EXECUTE STATEMENT 'ALTER TABLE FP_DEVICES ADD COM_PORT VARCHAR(16)';

  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'FP_DEVICES'
                   AND RDB$FIELD_NAME = 'BAUD_RATE')) THEN
    EXECUTE STATEMENT 'ALTER TABLE FP_DEVICES ADD BAUD_RATE INTEGER';
END^

SET TERM ; ^

COMMIT;

/* VW_FP_DEVICES - adaugam coloanele noi la sfirsit, ordinea celor vechi nu se schimba */
CREATE OR ALTER VIEW VW_FP_DEVICES (
  FP_ID,
  FIRMA_ID,
  FIRMA_NAME,
  WS_ID,
  COMPUTER_NAME,
  SERIAL_NUMBER,
  DESCRIPTION,
  FLG_ENABLED,
  SERVER_ADDRESS,
  COM_PORT,
  BAUD_RATE
) AS
SELECT
    fp.fp_id,
    fp.firma_id,
    (SELECT displayname FROM ts_customer c WHERE c.customerid = fp.firma_id),
    fp.ws_id,
    (SELECT computer_name FROM ws_work_stations ws WHERE ws.ws_id = fp.ws_id),
    fp.serial_number,
    fp.description,
    fp.flg_enabled,
    fp.server_address,
    fp.com_port,
    fp.baud_rate
FROM fp_devices fp;

COMMIT;

/* ---------------------------------------------------------------------------
   Inregistrarea automata a calculatoarelor in WS_WORK_STATIONS

   Tabela exista de mult, dar nimic nu scria in ea: nu are generator, nu are
   trigger si nici o forma nu insereaza rinduri. De aceea dialogul "Acces la MCC"
   ramine gol. Generatorul si procedura de mai jos permit WMS sa inregistreze
   singur calculatorul la pornire (vezi RegisterCurrentWorkStation).
   --------------------------------------------------------------------------- */

CREATE SEQUENCE IF NOT EXISTS SQ_WS_WORK_STATIONS_ID;

COMMIT;

/* generatorul trebuie sa porneasca de la valoarea maxima deja existenta */
SET TERM ^ ;

EXECUTE BLOCK AS
DECLARE VARIABLE MAX_ID INTEGER;
DECLARE VARIABLE CUR_ID BIGINT;
BEGIN
  SELECT COALESCE(MAX(WS_ID), 0) FROM WS_WORK_STATIONS INTO :MAX_ID;
  SELECT GEN_ID(SQ_WS_WORK_STATIONS_ID, 0) FROM RDB$DATABASE INTO :CUR_ID;

  IF (CUR_ID < MAX_ID) THEN
    EXECUTE STATEMENT 'ALTER SEQUENCE SQ_WS_WORK_STATIONS_ID RESTART WITH ' || MAX_ID;
END^

SET TERM ; ^

COMMIT;

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_REGISTER_WORKSTATION (
  FIRMA_ID INTEGER,
  COMPUTER_NAME VARCHAR(64)
)
RETURNS (
  WS_ID INTEGER
)
AS
BEGIN
  WS_ID = NULL;

  SELECT FIRST 1 W.WS_ID
  FROM WS_WORK_STATIONS W
  WHERE (W.FIRMA_ID = :FIRMA_ID)
    AND (UPPER(W.COMPUTER_NAME) = UPPER(:COMPUTER_NAME))
  INTO :WS_ID;

  IF (WS_ID IS NULL) THEN
  BEGIN
    WS_ID = GEN_ID(SQ_WS_WORK_STATIONS_ID, 1);

    INSERT INTO WS_WORK_STATIONS (WS_ID, FIRMA_ID, COMPUTER_NAME, FLG_ENABLED, CREATED_DATE)
    VALUES (:WS_ID, :FIRMA_ID, :COMPUTER_NAME, 1, CURRENT_DATE);
  END

  SUSPEND;
END^

SET TERM ; ^

COMMIT;

/* nomenclatorul statiilor de lucru (Nomenclatoare -> Statii de lucru) */
CREATE OR ALTER VIEW VW_WS_WORK_STATIONS (
  WS_ID,
  FIRMA_ID,
  FIRMA_NAME,
  COMPUTER_NAME,
  DESCRIPTION,
  FLG_ENABLED,
  CREATED_DATE
) AS
SELECT
    w.ws_id,
    w.firma_id,
    (SELECT c.displayname FROM ts_customer c WHERE c.customerid = w.firma_id),
    w.computer_name,
    w.description,
    w.flg_enabled,
    w.created_date
FROM ws_work_stations w;

COMMIT;

/*
  Configurarea concreta se face din WMS (Setari MCC / Acces la MCC). Exemplu manual:

  -- calculatorul cu MCC (DESKTOP-7E7S01E, 192.168.100.27)
  UPDATE FP_DEVICES SET
    SERVER_ADDRESS = 'http://192.168.100.27:4444/',
    COM_PORT       = 'COM3',
    BAUD_RATE      = 115200
  WHERE SERIAL_NUMBER = '<numarul de serie al MCC>';

  -- statiile care au voie sa tipareasca pe aceasta MCC
  INSERT INTO FP_DEVICE_ACCESS (FP_ID, WS_ID) VALUES (<FP_ID>, <WS_ID>);
*/
