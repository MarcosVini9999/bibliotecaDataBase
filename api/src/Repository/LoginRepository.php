<?php

namespace App\Repository;

use App\Entity\Login;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Login>
 *
 * @method Login|null find($id, $lockMode = null, $lockVersion = null)
 * @method Login|null findOneBy(array $criteria, array $orderBy = null)
 * @method Login[]    findAll()
 * @method Login[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class LoginRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Login::class);
    }

    public function getUser($data)
    {
        $conn = $this->getEntityManager()->getConnection();

        $sql = "SELECT u.login, u.nome, u.tipo_usuario
        FROM usuarios u
        WHERE login =:email AND senha=:senha";

        $stmt = $conn->prepare($sql);
        $resultSet = $stmt->executeQuery([
            'email' => $data->email,
            'senha' => md5($data->senha)
        ]);

        return $resultSet->fetchAssociative();
    }
}
