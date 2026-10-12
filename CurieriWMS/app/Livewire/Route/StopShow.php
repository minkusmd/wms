<?php

namespace App\Livewire\Route;

use App\Dispatch\DispatchException;
use App\Dispatch\PickupService;
use App\Dispatch\RouteRepository;
use App\Firebird\FirebirdException;
use Illuminate\Support\Str;
use Livewire\Attributes\Layout;
use Livewire\Attributes\Locked;
use Livewire\Component;
use Livewire\Features\SupportFileUploads\TemporaryUploadedFile;
use Livewire\WithFileUploads;

/**
 * Detaliul opririi (plan §9A ecranele 3-5, §9B, §9E, §9F): contact, apel, harta,
 * apoi dupa tip - incarcarea la depozit, preluarea la furnizor (lista blocata,
 * cantitati, fotografii, inchidere) sau livrarea la client.
 *
 * Identificatorii trimisi din browser (ITEMID, PHOTOID, PDOCID) sunt verificati
 * in procedurile SP_CW_* fata de curierul autentificat.
 */
#[Layout('layouts::app')]
class StopShow extends Component
{
    use WithFileUploads;

    #[Locked]
    public int $stopId;

    /** identificatorii actiunilor: aceiasi la reincercare, noi dupa succes */
    #[Locked]
    public string $startUid = '';

    #[Locked]
    public string $closeUid = '';

    /** @var array<int|string, string> cantitatea introdusa, pe ITEMID */
    public array $qty = [];

    /** @var array<int|string, string> motivul lipsei, pe ITEMID */
    public array $notes = [];

    /** ITEMID-ul cu formularul "Alta cantitate" deschis */
    public ?int $editing = null;

    /** @var TemporaryUploadedFile|null */
    public $photo = null;

    public ?string $message = null;

    public bool $messageIsError = false;

    public function mount(int $stop): void
    {
        $this->stopId = $stop;
        $this->startUid = (string) Str::uuid();
        $this->closeUid = (string) Str::uuid();
    }

    private function courierId(): int
    {
        return (int) auth()->id();
    }

    private function notify(string $message, bool $error = false): void
    {
        $this->message = $message;
        $this->messageIsError = $error;
    }

    /** Ruleaza o actiune si arata mesajul soferului; erorile tehnice se jurnalizeaza. */
    private function attempt(callable $action, string $success): bool
    {
        try {
            $action();
            $this->notify($success);

            return true;
        } catch (DispatchException $e) {
            $this->notify($e->getMessage(), true);
        } catch (FirebirdException $e) {
            report($e);
            $this->notify('Serverul nu a putut salva. Verifică internetul și încearcă din nou.', true);
        }

        return false;
    }

    public function startPickup(PickupService $pickups): void
    {
        if ($this->attempt(fn () => $pickups->start($this->stopId, $this->courierId(), $this->startUid),
            'Preluarea a început. Lista de produse este blocată.')) {
            $this->startUid = (string) Str::uuid();
        }
    }

    public function receiveAll(int $itemId, string $planned, PickupService $pickups): void
    {
        $this->attempt(fn () => $pickups->setQuantity($itemId, $this->courierId(), (float) $planned, null), 'Cantitate salvată.');
        $this->editing = null;
    }

    public function editQty(int $itemId, string $current): void
    {
        $this->editing = $itemId;
        $this->qty[$itemId] ??= $current;
    }

    public function saveQty(int $itemId, PickupService $pickups): void
    {
        $raw = str_replace([' ', ','], ['', '.'], (string) ($this->qty[$itemId] ?? ''));
        if (! is_numeric($raw)) {
            $this->notify('Scrie cantitatea în cifre.', true);

            return;
        }
        if ($this->attempt(fn () => $pickups->setQuantity($itemId, $this->courierId(), (float) $raw, $this->notes[$itemId] ?? null),
            'Cantitate salvată.')) {
            $this->editing = null;
        }
    }

    /** Apelat din browser dupa $wire.upload('photo', ...): fotografia e deja comprimata in telefon. */
    public function savePhoto(int $itemId, int $unitNo, string $uploadUid, PickupService $pickups): bool
    {
        $this->validate(['photo' => 'required|image|max:8192'], attributes: ['photo' => 'fotografia']);
        if (! preg_match('/^[0-9a-f-]{36}$/', $uploadUid)) {
            return false;
        }

        $path = $this->photo->getRealPath();
        [$width, $height] = @getimagesize($path) ?: [null, null];
        $saved = $this->attempt(
            fn () => $pickups->addPhoto($itemId, $unitNo, (string) file_get_contents($path), $this->courierId(), $uploadUid, $width, $height),
            'Fotografia a fost salvată.',
        );
        $this->photo->delete();
        $this->photo = null;

        return $saved;
    }

    public function replacePhoto(int $photoId, PickupService $pickups): void
    {
        $this->attempt(fn () => $pickups->replacePhoto($photoId, $this->courierId()), 'Fotografia veche a fost scoasă. Fă una nouă.');
    }

    public function closePickup(int $pdocId, PickupService $pickups): void
    {
        $result = null;
        if ($this->attempt(function () use ($pickups, $pdocId, &$result) {
            $result = $pickups->close($pdocId, $this->courierId(), $this->closeUid);
        }, 'Preluarea s-a încheiat.')) {
            $this->closeUid = (string) Str::uuid();
            if ($result['invoiceDocId']) {
                $this->notify($result['invoices'] > 1
                    ? "Preluarea s-a încheiat. S-au creat {$result['invoices']} intrări de marfă."
                    : "Preluarea s-a încheiat. Intrare marfă nr. {$result['invoiceDocId']}.");
            }
        }
    }

    /**
     * Cate fotografii trebuie: serie (4403) - una pe unitate primita; partida (4402) - una; altfel niciuna.
     * Pana la confirmarea cantitatii se numara dupa cea planificata, ca soferul sa vada de la inceput ce are de facut.
     */
    public static function requiredPhotos(array $item): int
    {
        $qty = (float) ($item['QTY_DONE'] ?? $item['QTY_PLANNED'] ?? 0);
        if ((int) $item['ITEM_KIND'] !== 1 || $qty <= 0) {
            return 0;
        }

        return match ((int) $item['SERIAL_TYPE_ID']) {
            4403 => (int) ceil($qty),
            4402 => 1,
            default => 0,
        };
    }

    public function render(RouteRepository $repository)
    {
        $courierId = $this->courierId();
        $stop = $repository->stop($this->stopId, $courierId);
        abort_if($stop === null, 404);

        $data = ['stop' => $stop, 'kind' => (int) $stop['STOP_KIND']];

        if ($data['kind'] === RouteRepository::KIND_SUPPLIER) {
            $doc = $repository->pickupDoc($this->stopId, $courierId);
            $data['doc'] = $doc;
            if ($doc) {
                $items = $repository->pickupItems((int) $doc['PDOCID']);
                $photos = [];
                foreach ($repository->pickupPhotos((int) $doc['PDOCID']) as $p) {
                    $photos[(int) $p['ITEMID']][(int) $p['UNIT_NO']] = (int) $p['PHOTOID'];
                }
                $data['items'] = $items;
                $data['photos'] = $photos;
                $need = $have = $qtyDone = 0;
                foreach ($items as $item) {
                    $required = self::requiredPhotos($item);
                    $need += $required;
                    $have += min($required, count(array_filter(array_keys($photos[(int) $item['ITEMID']] ?? []), fn ($u) => $u <= $required)));
                    $qtyDone += $item['QTY_DONE'] !== null ? 1 : 0;
                }
                $data['progress'] = ['qty' => $qtyDone, 'qtyTotal' => count($items), 'photos' => $have, 'photosTotal' => $need];
            } else {
                $data['planned'] = $repository->plannedPickups($this->stopId);
                $data['returns'] = $repository->documentLines($this->stopId, 2);
            }
        } elseif ($data['kind'] === RouteRepository::KIND_CLIENT) {
            $data['deliveries'] = array_map(function (array $delivery) use ($repository) {
                $lines = $repository->deliveryLines((int) $delivery['DOCID']);
                $isService = fn ($l) => in_array((int) $l['GOODS_TYPE_ID'], RouteRepository::SERVICE_TYPES, true);
                $delivery['goods'] = array_values(array_filter($lines, fn ($l) => ! $isService($l)));
                $delivery['services'] = array_values(array_filter($lines, $isService));

                return $delivery;
            }, $repository->deliveries($this->stopId));
        } else {
            $data['loads'] = $repository->documentLines($this->stopId, 4);
        }

        return view('livewire.route.stop-show', $data)->title($stop['TITLE'] ?? 'Oprire');
    }
}
