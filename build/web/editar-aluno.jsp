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
    int idAluno = Integer.parseInt(request.getParameter("id")); // Recupera o ID do aluno da URL

    String nome = "";
    String matricula = "";
    Map<String, Double> notasAluno = new LinkedHashMap<>();
    
    try {
        // Conectar ao banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // SQL para buscar dados do aluno
        String queryAluno = "SELECT a.nome AS aluno_nome, a.matricula, d.nome AS disciplina_nome, n.nota " +
                            "FROM alunos a " +
                            "JOIN notas n ON a.id_aluno = n.id_aluno " +
                            "JOIN disciplinas d ON n.id_disciplina = d.id_disciplina " +
                            "WHERE a.id_aluno = ?";
        ps = conn.prepareStatement(queryAluno);
        ps.setInt(1, idAluno);
        rs = ps.executeQuery();

        // Preencher os dados do aluno
        while (rs.next()) {
            nome = rs.getString("aluno_nome");
            matricula = rs.getString("matricula");
            String disciplinaNome = rs.getString("disciplina_nome");
            double nota = rs.getDouble("nota");
            notasAluno.put(disciplinaNome, nota);
        }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Aluno - NoteManager</title>
    <link rel="stylesheet" href="pagina/css/style.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-control {
            font-size: 1.2rem;
            padding: 1rem;
        }
        .table td, .table th {
            vertical-align: middle;
            padding: 1.5rem;
        }
        .ctn {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .btn {
            padding: 10px 20px;
        }
    </style>
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
        <h1 class="titulo text-center">Editar Dados do Aluno</h1>

        <!-- Formulário de edição -->
        <form action="atualizar-aluno.jsp" method="POST">
            <input type="hidden" name="id_aluno" value="<%= idAluno %>">
            <div class="table-responsive mt-5">
                <table class="w-100 table-bordered tabela-config text-center table">
                    <thead>
                        <tr>
                            <th scope="col">Aluno</th>
                            <th scope="col">Matrícula</th>
                            <th scope="col">Português</th>
                            <th scope="col">Matemática</th>
                            <th scope="col">Geografia</th>
                            <th scope="col">História</th>
                            <th scope="col">Ciências</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="text" name="nome" class="form-control" value="<%= nome %>"  readonly    required></td>
                            <td><input type="text" name="matricula" class="form-control" value="<%= matricula %>" readonly    required></td>
                            <td><input type="number" name="notaPortugues" class="form-control" value="<%= notasAluno.get("Português") != null ? notasAluno.get("Português") : 0 %>" min="0" max="10" step="0.1" required></td>
                            <td><input type="number" name="notaMatematica" class="form-control" value="<%= notasAluno.get("Matemática") != null ? notasAluno.get("Matemática") : 0 %>" min="0" max="10" step="0.1" required></td>
                            <td><input type="number" name="notaGeografia" class="form-control" value="<%= notasAluno.get("Geografia") != null ? notasAluno.get("Geografia") : 0 %>" min="0" max="10" step="0.1" required></td>
                            <td><input type="number" name="notaHistoria" class="form-control" value="<%= notasAluno.get("História") != null ? notasAluno.get("História") : 0 %>" min="0" max="10" step="0.1" required></td>
                            <td><input type="number" name="notaCiencias" class="form-control" value="<%= notasAluno.get("Ciências") != null ? notasAluno.get("Ciências") : 0 %>" min="0" max="10" step="0.1" required></td>
                        </tr>
                    </tbody>
                </table>

                <div class="ctn">
                    <button type="submit" class="btn btn-primary">Atualizar</button>
                    <a href="consultar-alunos.jsp" style="text-decoration: none; color: #fff;">
                        <button type="button" class="btn btn-secondary">Voltar</button>
                    </a>
                </div>
            </div>
        </form>
    </main>

    <footer>
        <div class="container text-center p-4">
            <h1>NoteManager</h1>
            <p>@2024-2025 NoteManager | Todos os direitos reservados</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
