<?php

namespace App\Livewire\Route;

use App\Dispatch\RouteRepository;
use App\Firebird\FirebirdException;
use Livewire\Attributes\Layout;
use Livewire\Attributes\Title;
use Livewire\Attributes\Url;
use Livewire\Component;

/**
 * "Traseul meu" (plan §9A, ecranul 2): traseele publicate ale soferului - azi si
 * restantele - cu opririle in ordinea stabilita de dispecer. Se reincarca singur
 * cat timp e vizibil si arata ora ultimei actualizari.
 */
#[Layout('layouts::app')]
#[Title('Traseul meu')]
class MyRoute extends Component
{
    /** toate | achizitii | livrari */
    #[Url(as: 'f')]
    public string $tab = 'toate';

    public function setTab(string $tab): void
    {
        $this->tab = in_array($tab, ['toate', 'achizitii', 'livrari'], true) ? $tab : 'toate';
    }

    public function render(RouteRepository $repository)
    {
        $routes = [];
        $error = null;

        try {
            foreach ($repository->routes((int) auth()->id()) as $route) {
                $route['stops'] = $repository->stops((int) $route['ROUTEID']);
                $routes[] = $route;
            }
        } catch (FirebirdException $e) {
            report($e);
            $error = 'Traseul nu a putut fi încărcat. Verifică internetul și reîncearcă.';
        }

        $isPurchase = fn (array $s) => in_array((int) $s['STOP_KIND'], [RouteRepository::KIND_DEPOT, RouteRepository::KIND_SUPPLIER], true);
        $isOpen = fn (array $s) => in_array((int) $s['STATEID'], [0, 1], true);

        $all = array_merge(...array_map(fn ($r) => $r['stops'], $routes ?: [['stops' => []]]));
        $counts = [
            'toate' => count(array_filter($all, $isOpen)),
            'achizitii' => count(array_filter($all, fn ($s) => $isPurchase($s) && $isOpen($s))),
            'livrari' => count(array_filter($all, fn ($s) => ! $isPurchase($s) && $isOpen($s))),
        ];

        foreach ($routes as &$route) {
            $route['stops'] = array_values(array_filter($route['stops'], fn ($s) => match ($this->tab) {
                'achizitii' => $isPurchase($s),
                'livrari' => ! $isPurchase($s),
                default => true,
            }));
        }
        unset($route);

        return view('livewire.route.my-route', [
            'routes' => $routes,
            'counts' => $counts,
            'error' => $error,
            'updatedAt' => now(),
        ]);
    }
}
