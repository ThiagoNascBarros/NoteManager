<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%
    // Recebe o ID do aluno pela URL
    int idAluno = Integer.parseInt(request.getParameter("id"));
    String alunoNome = "";
    String mensagem = "";

    // Dados de conexão com o banco de dados
    String url = "jdbc:mysql://localhost:3306/notemanager";
    String user = "root";
    String password = "";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Verifica se foi confirmada a exclusão
    String confirmar = request.getParameter("confirmar");

    if (confirmar != null && confirmar.equals("sim")) {
        if (idAluno > 0) {
            try {
                // Conectar ao banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                // Consulta para obter o nome do aluno pelo ID
                String queryNome = "SELECT nome FROM alunos WHERE id_aluno = ?";
                ps = conn.prepareStatement(queryNome);
                ps.setInt(1, idAluno);
                rs = ps.executeQuery();

                if (rs.next()) {
                    alunoNome = rs.getString("nome");
                    
                    // Excluir as notas associadas ao aluno primeiro
                    String queryNotas = "DELETE FROM notas WHERE id_aluno = ?";
                    ps = conn.prepareStatement(queryNotas);
                    ps.setInt(1, idAluno);
                    ps.executeUpdate();

                    // Agora excluir o aluno
                    String queryAluno = "DELETE FROM alunos WHERE id_aluno = ?";
                    ps = conn.prepareStatement(queryAluno);
                    ps.setInt(1, idAluno);
                    int rowsAffectedAluno = ps.executeUpdate();

                    if (rowsAffectedAluno > 0) {
                        mensagem = "Aluno " + alunoNome + " e suas notas foram excluídos com sucesso!";
                    } else {
                        mensagem = "Erro: Nenhum aluno encontrado com o ID fornecido!";
                    }
                } else {
                    mensagem = "Erro: Nenhum aluno encontrado com o ID fornecido!";
                }

            } catch (Exception e) {
                e.printStackTrace();
                mensagem = "Erro ao excluir aluno: " + e.getMessage();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        } else {
            mensagem = "ID do aluno não fornecido!";
        }
    } else {
        // Se não for uma confirmação, buscamos o nome do aluno
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            
            // Consulta para obter o nome do aluno
            String query = "SELECT nome FROM alunos WHERE id_aluno = ?";
            ps = conn.prepareStatement(query);
            ps.setInt(1, idAluno);
            rs = ps.executeQuery();

            if (rs.next()) {
                alunoNome = rs.getString("nome");
            } else {
                mensagem = "Erro: Nenhum aluno encontrado com o ID fornecido!";
            }
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
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NoteManager - Excluir Aluno</title>
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
        <h1 class="titulo text-center">Excluir Aluno</h1>

        <!-- Mensagem de confirmação -->
        <div class="alert alert-info mt-4" role="alert">
            <%= mensagem %>
        </div>

        <% if (mensagem.equals("Erro: Nenhum aluno encontrado com o ID fornecido!")) { %>
        <div class="alert alert-warning mt-4" role="alert">
            O aluno não foi encontrado. <a href="consultar-alunos.jsp">Voltar para a lista de alunos</a>
        </div>
        <% } %>

        <!-- Formulário de confirmação -->
        <form action="excluir-aluno.jsp" method="GET">
            <input type="hidden" name="id" value="<%= idAluno %>" />
            <div class="form-group">
                <% if (!mensagem.equals("Erro: Nenhum aluno encontrado com o ID fornecido!")) { %>
                <p>Tem certeza que deseja excluir o aluno <strong><%= alunoNome %></strong>?</p>
                <button type="submit" class="btn btn-danger" name="confirmar" value="sim">Sim, excluir</button>
                    <button href="consultar-alunos.jsp" class="btn-negative">Não, voltar</button>
                <% } %>
            </div>
        </form>
    </main>

    <footer id="footer-editar-aluno">
        <div class="container mb-3 text-center text-lg-start p-4">
            <h1 id="emprego">NoteManager</h1>
        </div>
        <div>
            <p class="text-center mt-4 p-copy">@2024-2025 NoteManager | Todos os direitos reservados</p>
        </div>
    </footer>

</body>
</html>
