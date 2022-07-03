<?php

namespace App\Controller;

use App\Entity\Login;
use Firebase\JWT\JWT;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class LoginController extends AbstractController
{
    /**
     * @Route("/login", methods={"POST"})
     */
    public function index(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent());
        
        $repository = $this->getDoctrine()->getRepository(Login::class);
        
        $user = $repository->getUser($data);
        if (empty($user)) {
            return new JsonResponse(['message' => 'Usuário não Encontrado'], Response::HTTP_NOT_FOUND);
        }

        $token = JWT::encode($user, 'chave_privada', 'HS256');
        return new JsonResponse(['token' => $token, 'user' => $user]);
    }
}
