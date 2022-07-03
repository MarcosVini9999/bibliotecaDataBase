<?php

namespace App\Controller;

use App\Entity\Reserva;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class ReservaController extends AbstractController
{
    /**
     * @Route("/reserva", methods={"POST"})
     */
    public function index(Request $request): JsonResponse
    {
        $data = $request->getContent();
        $repository = $this->getDoctrine()->getRepository(Reserva::class);

        $repository->reservarLivro($data);
        return $this->json([
            'message' => 'Welcome to your new controller!',
            'path' => 'src/Controller/ReservaController.php',
        ]);
    }
}
