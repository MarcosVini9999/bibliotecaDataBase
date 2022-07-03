<?php

namespace App\Controller;

use App\Entity\Reserva;
use Exception;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ReservaController extends AbstractController
{
    /**
     * @Route("/reserva", methods={"POST"})
     */
    public function index(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent());
        $repository = $this->getDoctrine()->getRepository(Reserva::class);

        try {
            $repository->reservarLivro($data);
        } catch (Exception $e) {
            return new JsonResponse(['success' => false, 'message' => $e->getMessage()], Response::HTTP_NOT_FOUND);
        }

        return new JsonResponse([
            'success' => true,
            'message' => 'Livro reservado com sucesso',
        ]);
    }
}
