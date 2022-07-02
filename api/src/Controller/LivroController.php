<?php

namespace App\Controller;

use App\Entity\Livro;
use Doctrine\ORM\Query\ResultSetMapping;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class LivroController extends AbstractController

{
  /**
   * @Route("/livros", methods={"GET"})
   */
  function buscar(Request $request): Response
  {
    $value = $request->query->get('query');
    $repository = $this->getDoctrine()->getRepository(Livro::class);
    $livros = $repository->getAll($value);

    return new JsonResponse($livros);
  }

  /**
   * @Route("/livros/{isbn}", methods={"GET"})
   */
  function buscPorIsbn($isbn, Request $request): Response
  {
    $repository = $this->getDoctrine()->getRepository(Livro::class);
    $livros = $repository->get($isbn);

    return new JsonResponse($livros);
  }
}
