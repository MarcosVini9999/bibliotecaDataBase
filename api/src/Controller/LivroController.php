<?php

namespace App\Controller;

use App\Entity\Livro;
use Doctrine\ORM\Query\ResultSetMapping;
use Exception;
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

  /**
   * @Route("/livros", methods={"POST"})
   */
  function cadastrar(Request $request): Response
  {
    $repository = $this->getDoctrine()->getRepository(Livro::class);
    $data = json_decode($request->getContent());
    $livro = [
      'isbn'                    => $data->isbn,
      'titulo'                  => $data->titulo,
      'ano_lancamento'          => $data->ano_lancamento,
      'editora'                 => $data->editora,
      'qtd_copias'              => $data->qtd_copias,
      'categorias_cod_categoria' => $data->categorias_cod_categoria,
    ];

    try {
      $repository->store($livro);
    } catch (Exception $e) {
      return new JsonResponse(['success' => false, 'data' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
    return new JsonResponse(['success' => true, 'data' => $livro]);
  }
}
