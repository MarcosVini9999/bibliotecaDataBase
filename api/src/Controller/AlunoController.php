<?php

namespace App\Controller;

use App\Entity\Aluno;
use Exception;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AlunoController extends AbstractController
{
    /**
     * @Route("/alunos", methods={"POST"})
     */
    public function index(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent());

        $data->senha = md5($data->senha);
        $data->tipo_usuario = 'Usuário';
        
        $repository = $this->getDoctrine()->getRepository(Aluno::class);
        try {
            $repository->salvarAluno($data);
          } catch (Exception $e) {
            return new JsonResponse(['success' => false, 'data' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
          }
          return new JsonResponse(['success' => true]);
    }
}
