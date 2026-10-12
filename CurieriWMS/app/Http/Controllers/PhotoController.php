<?php

namespace App\Http\Controllers;

use App\Dispatch\RouteRepository;
use Illuminate\Http\Response;

/** Fotografiile preluarii: numai curierul documentului le poate vedea (plan §9B). */
class PhotoController extends Controller
{
    public function show(int $photo, RouteRepository $repository): Response
    {
        $row = $repository->photo($photo, (int) auth()->id());
        abort_if($row === null, 404);

        return response((string) $row['PHOTO'], 200, [
            'Content-Type' => $row['MIME_TYPE'] ?: 'image/jpeg',
            // fara cache: pe un telefon folosit de mai multi soferi fotografia nu ramane dupa iesirea din cont
            'Cache-Control' => 'private, no-store',
            'X-Content-Type-Options' => 'nosniff',
        ]);
    }
}
