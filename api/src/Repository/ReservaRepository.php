<?php

namespace App\Repository;

use App\Entity\Reserva;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Exception;

/**
 * @extends ServiceEntityRepository<Reserva>
 *
 * @method Reserva|null find($id, $lockMode = null, $lockVersion = null)
 * @method Reserva|null findOneBy(array $criteria, array $orderBy = null)
 * @method Reserva[]    findAll()
 * @method Reserva[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ReservaRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Reserva::class);
    }

    function reservarLivro($data)
    {
        if(!$this->verificarDisponiveis($data->livros_isbn)) {
            throw new Exception("Sem livros disponíveis para reservar");
        }

        $conn = $this->getEntityManager()->getConnection();

        try {
            $conn->beginTransaction();

            $sql = "
    INSERT 
        INTO 
            usuarios_reserva_livros(usuarios_id, livros_isbn, data_reserva) 
        VALUES (:usuarios_id, :livros_isbn, current_date())";

            $stmt = $conn->prepare($sql);
            $stmt->executeQuery([
                'usuarios_id'         => $data->usuarios_id,
                'livros_isbn'         => $data->livros_isbn,
            ]);
            $conn->commit();
        } catch (\Exception $e) {
            $conn->rollBack();
            throw $e;
        }
        return true;
    }

    function verificarDisponiveis($isbn)
    {
        $conn = $this->getEntityManager()->getConnection();

        $sql = "SELECT qtd_copias - (SELECT count(*)
            FROM usuarios_reserva_livros url
            WHERE data_devolucao IS NULL
            AND l.isbn = url.livros_isbn) AS disponiveis
            FROM livros l WHERE isbn = :isbn";

        $stmt = $conn->prepare($sql);
        $resultSet = $stmt->executeQuery([
            'isbn' => $isbn
        ]);

        $qtdDisponiveis =  intval($resultSet->fetchAssociative()['disponiveis']);
        if ($qtdDisponiveis > 0) {
            return true;
        } else {
            return false;
        }
    }
}
