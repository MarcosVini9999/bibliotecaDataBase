<?php

namespace App\Repository;

use App\Entity\Aluno;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Exception;

/**
 * @extends ServiceEntityRepository<Aluno>
 *
 * @method Aluno|null find($id, $lockMode = null, $lockVersion = null)
 * @method Aluno|null findOneBy(array $criteria, array $orderBy = null)
 * @method Aluno[]    findAll()
 * @method Aluno[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AlunoRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Aluno::class);
    }

    public function salvarAluno($data)
    {
        $conn = $this->getEntityManager()->getConnection();

        try {
            $conn->beginTransaction();

            $sql = "
        INSERT 
            INTO 
                usuarios(nome, endereco, login, senha, tipo_usuario) 
            VALUES (:nome, :endereco, :email, :senha, :tipo_usuario)";

            $stmt = $conn->prepare($sql);
            $stmt->executeQuery([
                'nome' => $data->nome,
                'endereco' => $data->endereco,
                'email' => $data->email,
                'senha' => $data->senha,
                'tipo_usuario' => $data->tipo_usuario
            ]);

            $sql = "INSERT 
            INTO 
                alunos(matricula, data_de_ingresso, data_de_conclusao_prevista, usuarios_id, cursos_cod_curso) 
            VALUES (:matricula, :data_de_ingresso, :data_de_conclusao_prevista, LAST_INSERT_ID(), :cursos_cod_curso)";

            $stmt = $conn->prepare($sql);
            $stmt->executeQuery([
                'matricula'                  => $data->matricula,
                'data_de_ingresso'           => $data->data_de_ingresso,
                'data_de_conclusao_prevista' => $data->data_de_conclusao_prevista,
                'cursos_cod_curso'           => $data->cursos_cod_curso,
            ]);
            // do stuff
            $conn->commit();
        } catch (\Exception $e) {
            $conn->rollBack();
            throw $e;
        }
        return true;
    }
}
