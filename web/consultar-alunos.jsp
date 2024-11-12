
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // Dados de conexão
    String url = "jdbc:mysql://localhost:3306/notemanager";
    String user = "root";
    String password = "";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Conectar ao banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // SQL para buscar todos os alunos, disciplinas e notas
        String query = "SELECT a.id_aluno, a.nome AS aluno_nome, d.nome AS disciplina_nome, n.nota " +
                       "FROM alunos a " +
                       "JOIN notas n ON a.id_aluno = n.id_aluno " +
                       "JOIN disciplinas d ON n.id_disciplina = d.id_disciplina " +
                       "ORDER BY a.nome, d.nome";
        ps = conn.prepareStatement(query);
        rs = ps.executeQuery();

        // Mapa para armazenar os alunos e suas disciplinas com notas
        Map<String, Map<String, Double>> alunoNotas = new LinkedHashMap<>();
        while (rs.next()) {
            String alunoNome = rs.getString("aluno_nome");
            String disciplinaNome = rs.getString("disciplina_nome");
            double nota = rs.getDouble("nota");

            // Adicionando o aluno ao mapa
            if (!alunoNotas.containsKey(alunoNome)) {
                alunoNotas.put(alunoNome, new LinkedHashMap<>());
            }

            // Adicionando a disciplina e nota para o aluno
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

    <main class="container mt-5">
        <h1 class="titulo text-center">Notas dos Alunos</h1>

        <% if (alunoNotas.isEmpty()) { %>
            <p class="text-center">Nenhuma nota encontrada.</p>
        <% } else { %>
            <!-- Tabela de Notas -->
            <div class="table-responsive mt-5">
                <table class="w-100 table-bordered tabela-config text-center">
                    <thead>
                        <tr>
                            <th scope="col">Aluno</th>
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
                            for (Map.Entry<String, Map<String, Double>> alunoEntry : alunoNotas.entrySet()) {
                                String alunoNome = alunoEntry.getKey();
                                Map<String, Double> notasAluno = alunoEntry.getValue();
                        %>
                        <tr>
                            <td><%= alunoNome %></td>
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
                                <a href="editar-aluno.jsp?id=<%= alunoNome %>" class="btn btn-warning btn-sm">Editar</a>
                                <!-- Link para apagar -->
                                <a href="excluir-aluno.jsp?nome=<%= alunoNome%>" class="btn btn-danger">Excluir</a>

                            </td>

                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
            </div>
        <% } %>

    </main>

    <!-- Botão de adicionar aluno após o conteúdo principal -->
   <div class="ctn">
    <a href="adicionar-aluno.html">
        <button class="btn-add" id="btnAdicionarAluno">
            Adicionar<br>Aluno
        </button>
    </a>
</div>


    <footer>
        <div class="container text-center p-4">
            <h1>NoteManager</h1>
            <p>@2024-2025 NoteManager | Todos os direitos reservados</p>
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