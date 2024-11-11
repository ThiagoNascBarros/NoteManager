<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NoteManager - Consultar Alunos</title>
    <link rel="stylesheet" href="pagina/css/style.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <header>
        <nav class="navbar nav-note bg-body-tertiary">
            <div class="container-fluid">
                <span class="navbar-brand mb-0 h1">NoteManager</span>
            </div>
        </nav>
    </header>

    <main class="container mt-5">
        <h1 class="titulo text-center">Consultar Alunos</h1>

        <div class="table-responsive mt-5">
            <table class="w-100 table-bordered tabela-config text-center">
                <thead>
                    <tr>
                        <th scope="col">Aluno</th>
                        <th scope="col">Matrícula</th>
                        <th scope="col">Disciplina</th>
                        <th scope="col">Nota</th>
                        <th scope="col">Período</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Recupera o parâmetro 'nome' enviado na URL ou no formulário
                        String nome = request.getParameter("nome");

                        if (nome != null && !nome.isEmpty()) {
                            // Estabelecendo conexão com o banco de dados
                            try (Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/notemanager", "root", "");
                                 PreparedStatement pst = conecta.prepareStatement(
                                     "SELECT a.nome AS aluno_nome, a.matricula, d.nome AS disciplina_nome, n.nota, n.periodo " +
                                     "FROM alunos a " +
                                     "JOIN notas n ON a.id_aluno = n.id_aluno " +
                                     "JOIN disciplinas d ON n.id_disciplina = d.id_disciplina " +
                                     "WHERE a.nome LIKE ?"
                                 )) {
                                
                                // Adicionando o parâmetro para busca no banco
                                pst.setString(1, "%" + nome + "%");

                                // Executando a consulta
                                try (ResultSet rs = pst.executeQuery()) {
                                    // Iterando sobre o ResultSet e exibindo os resultados na tabela
                                    while (rs.next()) {
                                        String alunoNome = rs.getString("nome");
                                        String matricula = rs.getString("matricula");
                                        String disciplina = rs.getString("disciplina_nome");
                                        double nota = rs.getDouble("nota");
                                        String periodo = rs.getString("periodo");
                    %>
                    <tr>
                        <td><%= alunoNome %></td>
                        <td><%= matricula %></td>
                        <td><%= disciplina %></td>
                        <td><%= nota %></td>
                        <td><%= periodo %></td>
                    </tr>
                    <%
                                    }
                                }
                            } catch (SQLException e) {
                                e.printStackTrace(); // Log de erro
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="ctn">
            <a href="index.html" style="text-decoration: none; color: #fff;">
                <button id="voltar-index" class="voltar-index">Voltar</button>
            </a>
        </div>
    </main>

    <footer id="footer-editar-aluno">
        <div class="container mb-3 text-center text-lg-start p-4">
            <h1 id="emprego">NoteManager</h1>
        </div>
        <div>
            <p class="text-center mt-4 p-copy">@2024-2025 NoteManager | Todos os direitos reservados</p>
        </div>
    </footer>

    <script src="../js/script.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
