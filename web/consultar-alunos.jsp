<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%
    // Dados de conexão
    String url = "jdbc:mysql://localhost:3306/notemanager";
    String user = "root";
    String password = "";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String alunoPesquisado = request.getParameter("nome"); // Nome inserido no formulário

    boolean alunoEncontrado = false; // Variável para verificar se o aluno foi encontrado

    try {
        // Conectar ao banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // SQL para buscar o aluno pelo nome, incluindo o id_aluno, ordenado pelo nome e ID
        String queryAluno = "SELECT a.id_aluno, a.nome AS aluno_nome, a.matricula, d.nome AS disciplina_nome, n.nota " +
                            "FROM alunos a " +
                            "JOIN notas n ON a.id_aluno = n.id_aluno " +
                            "JOIN disciplinas d ON n.id_disciplina = d.id_disciplina " +
                            "WHERE a.nome LIKE ? " +  // Filtrando pelo nome do aluno
                            "ORDER BY a.nome ASC, d.nome";  // Ordenando pelo nome do aluno A-Z e depois pelas disciplinas
        ps = conn.prepareStatement(queryAluno);
        ps.setString(1, "%" + alunoPesquisado + "%"); // Usando LIKE para permitir busca por parte do nome
        rs = ps.executeQuery();

        // Mapa para armazenar os alunos e suas disciplinas com notas
        Map<String, Map<String, Object>> alunoNotas = new LinkedHashMap<>();
        while (rs.next()) {
            String alunoNome = rs.getString("aluno_nome");
            String matricula = rs.getString("matricula");  // Recupera a matrícula do aluno
            String disciplinaNome = rs.getString("disciplina_nome");
            double nota = rs.getDouble("nota");
            int idAluno = rs.getInt("id_aluno"); // Recupera o id_aluno

            // Marca o aluno como encontrado
            alunoEncontrado = true;

            // Adicionando o aluno ao mapa
            if (!alunoNotas.containsKey(alunoNome)) {
                alunoNotas.put(alunoNome, new LinkedHashMap<>());
            }

            // Adicionando a disciplina, nota, matrícula e id_aluno para o aluno
            alunoNotas.get(alunoNome).put("matricula", matricula);  // Armazenando a matrícula
            alunoNotas.get(alunoNome).put("id_aluno", idAluno);  // Armazenando o id_aluno
            alunoNotas.get(alunoNome).put(disciplinaNome, nota);
        }

        // Consulta para obter todas as disciplinas
        String queryDisciplinas = "SELECT nome FROM disciplinas ORDER BY id_disciplina";
        ps = conn.prepareStatement(queryDisciplinas);
        rs = ps.executeQuery();

        List<String> disciplinas = new ArrayList<>();
        while (rs.next()) {
            disciplinas.add(rs.getString("nome"));
        }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar Notas e Alunos - NoteManager</title>
    <link rel="stylesheet" href="conteudo/styles/style.css">
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

    <main class="container mt-main">
        <h1 class="titulo text-center">Notas dos Alunos</h1>

        <!-- Formulário de pesquisa de aluno -->
        <form action="consultar-alunos.jsp" method="GET" class="mt-4">
            <div class="form-group">
                <label for="nome">Nome do Aluno:</label>
                <input type="text" class="form-control" id="nome" name="nome" placeholder="Digite o nome do aluno" value="<%= alunoPesquisado != null ? alunoPesquisado : "" %>" required>
            </div>
            <button type="submit" class="btn-pesquisar-b">Pesquisar</button>
        </form>

        <% 
            if (alunoPesquisado != null && !alunoPesquisado.isEmpty()) { 
                if (!alunoEncontrado) { 
        %>
            <!-- Mensagem de erro se o aluno não for encontrado -->
            <p class="text-center text-danger">Aluno "<%= alunoPesquisado %>" não encontrado. Tente novamente.</p>
        <% 
                } else { 
        %>
            <!-- Tabela de Notas -->
            <div class="table-responsive mt-5">
                <table class="w-100 table-bordered tabela-config text-center">
                    <thead>
                        <tr>
                            <th scope="col">ID do Aluno</th> <!-- Agora a coluna de ID vem primeiro -->
                            <th scope="col">Aluno</th> <!-- A coluna "Aluno" vem depois do ID -->
                            <th scope="col">Matrícula</th> <!-- Adicionando a coluna para a matrícula -->
                            <% 
                                // Exibindo as disciplinas como cabeçalhos de coluna
                                for (String disciplina : disciplinas) {
                            %>
                            <th scope="col"><%= disciplina %></th>
                            <% 
                                }
                            %>
                            <th scope="col">Ações</th> <!-- Coluna para ações -->
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            // Exibindo os dados de cada aluno
                            for (Map.Entry<String, Map<String, Object>> alunoEntry : alunoNotas.entrySet()) {
                                String alunoNome = alunoEntry.getKey();
                                Map<String, Object> dadosAluno = alunoEntry.getValue();
                                String matricula = (String) dadosAluno.get("matricula");  // Recupera a matrícula
                                int idAluno = (int) dadosAluno.get("id_aluno");  // Recupera o id_aluno
                                Map<String, Double> notasAluno = new LinkedHashMap<>();
                                 
                                // Filtra as notas para cada disciplina
                                for (Map.Entry<String, Object> entry : dadosAluno.entrySet()) {
                                    if (!entry.getKey().equals("matricula") && !entry.getKey().equals("id_aluno")) {
                                        notasAluno.put(entry.getKey(), (Double) entry.getValue());
                                    }
                                }
                        %>
                        <tr>
                            <td><%= idAluno %></td> <!-- Exibindo o ID do aluno -->
                            <td><%= alunoNome %></td> <!-- Exibindo o nome do aluno -->
                            <td><%= matricula %></td> <!-- Exibindo a matrícula -->
                            <% 
                                // Para cada aluno, exibimos as notas de cada disciplina
                                for (String disciplina : disciplinas) {
                                    Double nota = notasAluno.get(disciplina);
                            %>
                            <td><%= (nota != null) ? nota : "N/A" %></td>
                            <% 
                                }
                            %>
                          <td>
                                <!-- Link para editar -->
                                <a href="editar-aluno.jsp?id=<%= idAluno %>" class="btn"><img src="<%= request.getContextPath() %>/pagina/images/Vector.svg"/></a>
                                <!-- Link para apagar -->
                                <a href="excluir-aluno.jsp?id=<%= idAluno %>" class="btn"><img src="<%= request.getContextPath() %>/pagina/images/Trash.svg"/></a>

                            </td>
                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
            </div>
        <% 
                } 
            } 
        %>
        <!-- Botão de adicionar aluno após o conteúdo principal -->
    <div class="ctn">
        <a href="adicionar-aluno.html">
            <button class="btn-add" id="btnAdicionarAluno">
                Adicionar<br>Aluno
            </button>
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

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Fechar conexões e recursos
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
