# **TRABALHO FINAL - BANCO DE DADOS**

## STATUS DO PROJETO

Submeter grupo e incluir professor:

![Badge em Desenvolvimento](https://img.shields.io/badge/STATUS-FINALIZADO-green)

Modelagem e scripts:

![Badge em Desenvolvimento](https://img.shields.io/badge/STATUS-FINALIZADO-green)

Parte 1 do projeto:

![Badge em Desenvolvimento](https://img.shields.io/badge/STATUS-ENVIADO-brightgreen)

Implementações Finais:

![Badge em Desenvolvimento](https://img.shields.io/badge/STATUS-EM%20DESENVOLVIMENTO%20-yellow)

# 📚BIBLIOTECA UNIVERSITÁRIA📖

## 🌎Descrição Geral:

<p align="justify">Modelar e criar uma aplicação para controle de uma biblioteca acadêmica, constando as informações de seus livros. Inicialmente, se quer armazenar para os livros as seguintes características: ISBN, título, ano de lançamento, editora, quantidade de cópias e autores deste livro. Para os autores, deseja-se manter: nome, e-mail e nacionalidade. Cabe salientar que um autor pode ter vários livros publicados, assim como um livro pode ser escrito por vários autores. Cada livro da biblioteca pertence a uma categoria. A biblioteca deseja manter um cadastro de todas as categorias existentes, com informações como: código da categoria e descrição. Uma categoria pode ter vários livros associados a ela, porém cada livro só deverá pertencer a uma categoria (principal). Além disso, deseja-se manter os dados dos usuários, como alunos (matrícula, nome, cod*curso[Curso], endereço, telefones*, data_de_ingresso e data_de_conclusão_prevista), professores (mat_siape, nome, endereço, telefone celular, regime_trabalho\*\*, cod_curso[curso], data_de_contratação) e funcionários (matrícula, nome, endereço e telefones*) e curso (cod_curso, nome_curso). Além disso, o sistema deve controlar que usuários fizeram reservas de quais livros (um usuário pode reservar vários livros e um livro pode ser reservado por vários usuários, com diferentes datas de reserva), além da quantidade máxima de livros emprestados por usuário e o prazo de devolução, onde um aluno pode pegar até 3 livros emprestados por até 15 dias, um funcionário pode pegar até 4 livros emprestados por até 21 dias e um professor pode pegar até 5 livros emprestados por até 30 dias. O sistema deve parametrizar os dados de acesso ao Banco de Dados, solicitando “Usuário” e “Senha” de acesso ao BD logo na tela inicial. A aplicação deve possuir três níveis de acesso: Um de administrador (login: Admin e senha: Root), que deve manter o cadastro (inserção, remoção, alteração) de todas as entidades (descritas acima). Um nível de bibliotecário, que tem permissão para consultar livros, usuários e reservas e ainda realizar/alterar e dar baixa nos empréstimos de livros. E um nível de usuário, que deve ser capaz somente de consultar os livros (por nome, autor, editora, categoria e/ou ano de publicação) e seus empréstimos / disponibilidade de exemplares, além de poder fazer reservas de livros de forma on-line. (\**) O regime de trabalho dos professores pode ser de: 20h, 40h ou DE (exclusivamente). Esta restrição deverá ser garantida através do domínio deste atributo. Cada usuário pode fazer o cadastramento no sistema e pode solicitar cancelamento do mesmo, sendo assim impedido de fazer reservas e/ou empréstimos de livros, e para cada solicitação de cadastramento de um aluno no sistema, um gatilho (trigger) deve verificar se a data*de_conclusão_prevista já foi atingida. Neste caso, o cadastramento não poderá ser realizado; (*) O cadastro de alunos e funcionários deve contemplar a inclusão de vários telefones por usuário, não havendo uma quantidade pré-fixada de telefones nem nenhuma restrição a inclusão de vários números, sejam quantos forem; A aplicação deverá ser capaz de listar (utilizando visões no BD) os livros cadastrados por categoria, por editora, por ano de publicação ou por autor (todos em ordem alfabética e utilizando-se agrupamento para tal), podendo-se optar por selecionar uma determinada categoria ou editora para ver os seus livros; os professores por curso (em ordem alfabética), também podendo-se escolher um determinado curso para ver somente os seus professores; e todas as reservas feitas para um determinado livro (consultado por nome ou ISBN) com suas respectivas datas e usuários. O BD a ser utilizado deverá ser o MySQL (ver. 5.7 ou superior) e a ferramenta de modelagem deve ser o MySQL WorkBench (versão compatível com o BD). O nome do BD a ser criado deverá ser equipe<Num>, onde <Num> é o menor número de matrícula dos membros da equipe.</p>
