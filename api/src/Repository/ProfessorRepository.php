<?php

namespace App\Repository;

use App\Entity\Professor;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Professor>
 *
 * @method Professor|null find($id, $lockMode = null, $lockVersion = null)
 * @method Professor|null findOneBy(array $criteria, array $orderBy = null)
 * @method Professor[]    findAll()
 * @method Professor[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProfessorRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Professor::class);
    }

    function salvarProfessor($data)
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
                'nome'         => $data->nome,
                'endereco'     => $data->endereco,
                'email'        => $data->email,
                'senha'        => $data->senha,
                'tipo_usuario' => $data->tipo_usuario
            ]);

            $sql = "INSERT 
        INTO 
            professores(mat_siape, regime_trabalho, telefone_celular,data_contratacao, usuarios_id, cursos_cod_curso) 
        VALUES (:mat_siape, :regime_trabalho, :telefone_celular,:data_contratacao, LAST_INSERT_ID(), :cursos_cod_curso)";

            $stmt = $conn->prepare($sql);
            $stmt->executeQuery([
                'mat_siape'        => $data->mat_siape,
                'regime_trabalho'  => $data->regime_trabalho,
                'telefone_celular' => $data->telefone_celular,
                'data_contratacao' => $data->data_contratacao,
                'cursos_cod_curso' => $data->cursos_cod_curso,
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
