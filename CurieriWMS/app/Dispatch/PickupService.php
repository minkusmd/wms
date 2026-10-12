<?php

namespace App\Dispatch;

use App\Firebird\Blob;
use App\Firebird\FirebirdConnection;
use App\Firebird\FirebirdException;

/**
 * Actiunile soferului la furnizor (plan §9B). Toate regulile (atribuire, plan
 * publicat, blocare, fotografii, crearea Intrarii 106) sunt in procedurile
 * SP_CW_* din DB Model/dispatch_logistics.sql; aici doar se apeleaza, fiecare
 * intr-o tranzactie proprie, cu identificatorul unic al actiunii.
 */
class PickupService
{
    public function __construct(private readonly FirebirdConnection $db) {}

    /** @return int PDOCID (acelasi la reluare) */
    public function start(int $stopId, int $courierId, string $actionUid): int
    {
        return DispatchException::guard(fn () => (int) $this->db->transaction(fn (FirebirdConnection $db) => $db->scalar(
            'SELECT O_PDOCID FROM SP_CW_PICKUP_START(:stop, :courier, :uid)',
            ['stop' => $stopId, 'courier' => $courierId, 'uid' => $actionUid],
        )));
    }

    public function setQuantity(int $itemId, int $courierId, float $qty, ?string $issueNote): void
    {
        DispatchException::guard(fn () => $this->db->transaction(fn (FirebirdConnection $db) => $db->execute(
            'EXECUTE PROCEDURE SP_CW_PICKUP_ITEM_SET(:item, :courier, :qty, :note)',
            ['item' => $itemId, 'courier' => $courierId, 'qty' => $qty, 'note' => $issueNote],
        )));
    }

    /** Salveaza fotografia; aceeasi incarcare retrimisa (acelasi UID) nu se dubleaza. */
    public function addPhoto(int $itemId, int $unitNo, string $jpeg, int $courierId, string $uploadUid, ?int $width, ?int $height): void
    {
        try {
            $this->db->transaction(fn (FirebirdConnection $db) => $db->execute(<<<'SQL'
                INSERT INTO TDB_PICKUP_PHOTO (ITEMID, UNIT_NO, PHOTO, MIME_TYPE, WIDTH, HEIGHT, COURIERID, UPLOAD_UID)
                VALUES (:item, :unit, :photo, 'image/jpeg', :w, :h, :courier, :uid)
                SQL, [
                'item' => $itemId, 'unit' => $unitNo, 'photo' => new Blob($jpeg),
                'w' => $width, 'h' => $height, 'courier' => $courierId, 'uid' => $uploadUid,
            ]));
        } catch (FirebirdException $e) {
            if (str_contains($e->getMessage(), 'UNQ_TDB_PICKUP_PHOTO_UID')) {
                return; // deja salvata la o incercare anterioara
            }
            throw DispatchException::wrap($e);
        }
    }

    /** Fotografia veche ramane in istoric; locul ei se elibereaza pentru una noua. */
    public function replacePhoto(int $photoId, int $courierId): void
    {
        DispatchException::guard(fn () => $this->db->transaction(fn (FirebirdConnection $db) => $db->execute(
            'EXECUTE PROCEDURE SP_CW_PHOTO_REPLACE(:photo, :courier)',
            ['photo' => $photoId, 'courier' => $courierId],
        )));
    }

    /** @return array{invoiceDocId: ?int, invoices: int} */
    public function close(int $pdocId, int $courierId, string $actionUid): array
    {
        $row = DispatchException::guard(fn () => $this->db->transaction(fn (FirebirdConnection $db) => $db->selectOne(
            'SELECT O_INVOICE_DOCID, O_INVOICES FROM SP_CW_PICKUP_CLOSE(:pdoc, :courier, :uid)',
            ['pdoc' => $pdocId, 'courier' => $courierId, 'uid' => $actionUid],
        )));

        return [
            'invoiceDocId' => isset($row['O_INVOICE_DOCID']) ? (int) $row['O_INVOICE_DOCID'] : null,
            'invoices' => (int) ($row['O_INVOICES'] ?? 0),
        ];
    }
}
