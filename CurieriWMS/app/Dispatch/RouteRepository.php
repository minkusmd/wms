<?php

namespace App\Dispatch;

use App\Firebird\FirebirdConnection;

/**
 * Citirile pentru telefonul soferului. Fiecare interogare e filtrata pe curierul
 * autentificat si pe planuri publicate (plan §9A, scenariul 12): un identificator
 * de oprire schimbat in URL nu da acces la traseul altui sofer.
 */
class RouteRepository
{
    public const KIND_DEPOT = 1;

    public const KIND_SUPPLIER = 2;

    public const KIND_CLIENT = 3;

    /** GOODS_TYPE_ID ale serviciilor (TS_GOODS): terti, proprii, complet de servicii, livrare */
    public const SERVICE_TYPES = [4202, 4204, 4212, 4217];

    public function __construct(private readonly FirebirdConnection $db) {}

    /**
     * Traseele de executat: cele de azi si cele mai vechi ramase cu opriri nefinalizate (restante).
     *
     * @return list<array<string, mixed>>
     */
    public function routes(int $courierId): array
    {
        return $this->db->select(<<<'SQL'
            SELECT R.ROUTEID, R.STATEID, R.TRIPNO, P.PLANID, P.PLAN_DATE, P.VERSIONNO
            FROM TDB_DISPATCH_ROUTE R
            JOIN TDB_DISPATCH_PLAN P ON P.PLANID = R.PLANID
            WHERE R.COURIERID = :courier
              AND P.STATEID IN (1, 2)
              AND (P.PLAN_DATE = CURRENT_DATE
                   OR (P.PLAN_DATE < CURRENT_DATE AND R.STATEID < 3
                       AND EXISTS(SELECT 1 FROM TDB_DISPATCH_STOP S
                                  WHERE S.ROUTEID = R.ROUTEID AND S.STATEID IN (0, 1))))
            ORDER BY P.PLAN_DATE, R.TRIPNO
            SQL, ['courier' => $courierId]);
    }

    /** @return list<array<string, mixed>> */
    public function stops(int $routeId): array
    {
        return $this->db->select(<<<'SQL'
            SELECT S.STOPID, S.ORDERNO, S.STOP_KIND, S.TITLE, S.ADDRESS, S.PHONE, S.PLAN_TIME,
                   S.STATEID, S.NOTE, Z.NAME AS ZONE_NAME,
                   (SELECT COUNT(*) FROM TDB_DISPATCH_STOP_TASK T WHERE T.STOPID = S.STOPID AND T.TASK_KIND = 1 AND T.STATEID <> 9) AS N_PICKUP,
                   (SELECT COUNT(*) FROM TDB_DISPATCH_STOP_TASK T WHERE T.STOPID = S.STOPID AND T.TASK_KIND = 2 AND T.STATEID <> 9) AS N_RETURN,
                   (SELECT COUNT(*) FROM TDB_DISPATCH_STOP_TASK T WHERE T.STOPID = S.STOPID AND T.TASK_KIND = 3 AND T.STATEID <> 9) AS N_DELIVERY,
                   (SELECT COUNT(*) FROM TDB_DISPATCH_STOP_TASK T WHERE T.STOPID = S.STOPID AND T.TASK_KIND = 4 AND T.STATEID <> 9) AS N_LOAD
            FROM TDB_DISPATCH_STOP S
            LEFT JOIN TS_LOGISTIC_ZONE Z ON Z.ZONEID = S.ZONEID
            WHERE S.ROUTEID = :route
            ORDER BY S.ORDERNO, S.STOPID
            SQL, ['route' => $routeId]);
    }

    /** Oprirea, numai daca e pe un traseu publicat al curierului. */
    public function stop(int $stopId, int $courierId): ?array
    {
        return $this->db->selectOne(<<<'SQL'
            SELECT S.STOPID, S.ROUTEID, S.ORDERNO, S.STOP_KIND, S.PARTNERID, S.TITLE, S.ADDRESS,
                   S.CONTACT_NAME, S.PHONE, S.LATITUDE, S.LONGITUDE, S.PLAN_TIME, S.NOTE, S.STATEID,
                   S.ARRIVED_AT, S.DONE_AT, Z.NAME AS ZONE_NAME, PP.SCHEDULE, P.PLAN_DATE, P.VERSIONNO
            FROM TDB_DISPATCH_STOP S
            JOIN TDB_DISPATCH_ROUTE R ON R.ROUTEID = S.ROUTEID
            JOIN TDB_DISPATCH_PLAN P ON P.PLANID = R.PLANID
            LEFT JOIN TS_LOGISTIC_ZONE Z ON Z.ZONEID = S.ZONEID
            LEFT JOIN TS_PICKUP_POINT PP ON PP.POINTID = S.POINTID
            WHERE S.STOPID = :stop AND R.COURIERID = :courier AND P.STATEID IN (1, 2)
            SQL, ['stop' => $stopId, 'courier' => $courierId]);
    }

    /**
     * Ridicarile planificate ale opririi (inainte de inceperea preluarii), cu pretul
     * de achizitie de la furnizorul prin care se comanda (plan §9F).
     *
     * @return list<array<string, mixed>>
     */
    public function plannedPickups(int $stopId): array
    {
        return $this->db->select(<<<'SQL'
            SELECT T.TASKID, T.STATEID AS TASK_STATE, K.PICKUPID, K.DOCID, K.GOODSID, K.GOODS_CODE,
                   K.QTY, K.NOTE, G.TITLE, G.SERIAL_TYPE_ID, C.NAME AS ORDER_SUPPLIER_NAME,
                   (SELECT FIRST 1 F.PRICE0 FROM TS_GOODS_FOREIGN F
                    WHERE F.GOODSID = K.GOODSID AND F.CUSTOMERID = K.ORDER_SUPPLIERID) AS PRICE,
                   (SELECT FIRST 1 F.CURRENCY0ID FROM TS_GOODS_FOREIGN F
                    WHERE F.GOODSID = K.GOODSID AND F.CUSTOMERID = K.ORDER_SUPPLIERID) AS CURRENCYID
            FROM TDB_DISPATCH_STOP_TASK T
            JOIN TDB_SUPPLIER_PICKUP K ON K.PICKUPID = T.PICKUPID
            JOIN TS_GOODS G ON G.GOODSID = K.GOODSID
            LEFT JOIN TS_CUSTOMER C ON C.CUSTOMERID = K.ORDER_SUPPLIERID
            WHERE T.STOPID = :stop AND T.TASK_KIND = 1 AND T.STATEID <> 9
            ORDER BY T.ORDERNO, T.TASKID
            SQL, ['stop' => $stopId]);
    }

    /**
     * Liniile documentelor legate de sarcinile opririi: retur la furnizor (2) sau incarcare la depozit (4).
     *
     * @return list<array<string, mixed>>
     */
    public function documentLines(int $stopId, int $taskKind): array
    {
        return $this->db->select(<<<'SQL'
            SELECT T.TASKID, T.DOCID, T.STATEID AS TASK_STATE, T.NOTE AS TASK_NOTE, D.CURRENCYID,
                   J.GOODSID, G.TITLE, G.CODE, J.QTY, J.PRICE, J.SUMA
            FROM TDB_DISPATCH_STOP_TASK T
            JOIN TDB_DOCS D ON D.DOCID = T.DOCID
            JOIN TDB_JURNAL J ON J.DOCID = T.DOCID AND J.GOODSCOMPLECT_ID = -1
            JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
            WHERE T.STOPID = :stop AND T.TASK_KIND = :kind AND T.STATEID <> 9
            ORDER BY T.ORDERNO, T.TASKID, G.TITLE
            SQL, ['stop' => $stopId, 'kind' => $taskKind]);
    }

    /** @return list<array<string, mixed>> livrarile opririi (sarcina + copia adresei + documentul) */
    public function deliveries(int $stopId): array
    {
        return $this->db->select(<<<'SQL'
            SELECT T.TASKID, T.STATEID AS TASK_STATE, L.DELIVERYID, L.DOCID, L.STATEID, L.ADDRESS,
                   L.CONTACT_NAME, L.PHONE, L.TIME_TEXT, L.AUTH_AT, L.NOTE, D.SUMA AS DOC_SUMA, D.CURRENCYID
            FROM TDB_DISPATCH_STOP_TASK T
            JOIN TDB_DISPATCH_DELIVERY L ON L.DELIVERYID = T.DELIVERYID
            JOIN TDB_DOCS D ON D.DOCID = L.DOCID
            WHERE T.STOPID = :stop AND T.TASK_KIND = 3 AND T.STATEID <> 9
            ORDER BY T.ORDERNO, T.TASKID
            SQL, ['stop' => $stopId]);
    }

    /** @return list<array<string, mixed>> liniile documentului comercial al livrarii (marfa si servicii) */
    public function deliveryLines(int $docId): array
    {
        return $this->db->select(<<<'SQL'
            SELECT J.GOODSID, G.TITLE, G.CODE, G.GOODS_TYPE_ID, J.QTY, J.PRICE, J.SUMA
            FROM TDB_JURNAL J
            JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
            WHERE J.DOCID = :doc AND J.GOODSCOMPLECT_ID = -1
            ORDER BY G.TITLE
            SQL, ['doc' => $docId]);
    }

    /** Documentul de preluare al opririi: cel deschis, altfel ultimul inchis. */
    public function pickupDoc(int $stopId, int $courierId): ?array
    {
        return $this->db->selectOne(<<<'SQL'
            SELECT FIRST 1 PDOCID, STATEID, STARTED_AT, CLOSED_AT
            FROM TDB_PICKUP_DOC
            WHERE STOPID = :stop AND COURIERID = :courier AND STATEID IN (1, 2)
            ORDER BY IIF(STATEID = 1, 0, 1), PDOCID DESC
            SQL, ['stop' => $stopId, 'courier' => $courierId]);
    }

    /** @return list<array<string, mixed>> */
    public function pickupItems(int $pdocId): array
    {
        return $this->db->select(<<<'SQL'
            SELECT I.ITEMID, I.ITEM_KIND, I.PICKUPID, I.SRC_DOCID, I.GOODSID, I.GOODS_CODE,
                   I.SERIAL_TYPE_ID, I.QTY_PLANNED, I.QTY_DONE, I.PRICE, I.CURRENCYID, I.ISSUE_NOTE,
                   I.INVOICE_DOCID, G.TITLE
            FROM TDB_PICKUP_DOC_ITEM I
            JOIN TS_GOODS G ON G.GOODSID = I.GOODSID
            WHERE I.PDOCID = :pdoc
            ORDER BY I.ITEM_KIND, I.ITEMID
            SQL, ['pdoc' => $pdocId]);
    }

    /** @return list<array<string, mixed>> fotografiile valabile (neinlocuite) ale documentului */
    public function pickupPhotos(int $pdocId): array
    {
        return $this->db->select(<<<'SQL'
            SELECT F.PHOTOID, F.ITEMID, F.UNIT_NO
            FROM TDB_PICKUP_PHOTO F
            JOIN TDB_PICKUP_DOC_ITEM I ON I.ITEMID = F.ITEMID
            WHERE I.PDOCID = :pdoc AND F.FLG_REPLACED = 0
            ORDER BY F.ITEMID, F.UNIT_NO, F.PHOTOID
            SQL, ['pdoc' => $pdocId]);
    }

    /** Fotografia, numai pentru curierul documentului ei. */
    public function photo(int $photoId, int $courierId): ?array
    {
        return $this->db->selectOne(<<<'SQL'
            SELECT F.PHOTO, F.MIME_TYPE
            FROM TDB_PICKUP_PHOTO F
            JOIN TDB_PICKUP_DOC_ITEM I ON I.ITEMID = F.ITEMID
            JOIN TDB_PICKUP_DOC D ON D.PDOCID = I.PDOCID
            WHERE F.PHOTOID = :photo AND D.COURIERID = :courier
            SQL, ['photo' => $photoId, 'courier' => $courierId]);
    }
}
