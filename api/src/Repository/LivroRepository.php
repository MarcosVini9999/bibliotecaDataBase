<?php

namespace App\Repository;

use App\Entity\Livro;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Exception;

/**
 * @extends ServiceEntityRepository<Livro>
 *
 * @method Livro|null find($id, $lockMode = null, $lockVersion = null)
 * @method Livro|null findOneBy(array $criteria, array $orderBy = null)
 * @method Livro[]    findAll()
 * @method Livro[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class LivroRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Livro::class);
    }

    public function getAll($value)
    {
        $conn = $this->getEntityManager()->getConnection();

        $sql = 'SELECT * FROM viewLivros WHERE 1=0';
        foreach (['titulo', 'ano_lancamento', 'editora', 'descricao', 'nome'] as $field) {
            $sql .= " OR $field LIKE '%$value%'";
        }
        $stmt = $conn->prepare($sql);
        $resultSet = $stmt->executeQuery();

        return $resultSet->fetchAllAssociative();
    }

    public function get($isbn)
    {
        $conn = $this->getEntityManager()->getConnection();

        $sql = 'SELECT * FROM livros WHERE isbn = :isbn limit 1';
        $stmt = $conn->prepare($sql);
        $resultSet = $stmt->executeQuery(['isbn' => $isbn]);

        return $resultSet->fetchAssociative();
    }

    function store($livro)
    {
        $conn = $this->getEntityManager()->getConnection();
        $erros = '';
        $sql = 'INSERT 
                    INTO 
                        livros (isbn, titulo, ano_lancamento, editora, qtd_copias, categorias_cod_categoria) 
                VALUES 
                    (:isbn, :titulo, :ano_lancamento, :editora, :qtd_copias, :categorias_cod_categoria)';
        $stmt = $conn->prepare($sql);
        if (!$stmt->executeQuery($livro)) {
            throw new Exception('Não foi possível cadastrar');
        }
        return true;
    }
}
