<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="pt-br">

<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adicionar Aluno - NoteManager</title>
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

    <main class="container" id="conteudo-principal">
        <h1 class="titulo text-center">Adicionar Aluno</h1>

      <%
    // Recebe os dados enviados do formul�rio via POST
    String nomeAluno = request.getParameter("nomeAluno");
    String matricula = request.getParameter("matricula");
    String notaPortugues = request.getParameter("notaPortugues");
    String notaMatematica = request.getParameter("notaMatematica");
    String notaGeografia = request.getParameter("notaGeografia");
    String notaHistoria = request.getParameter("notaHistoria");
    String notaCiencias = request.getParameter("notaCiencias");

    // Valida o nome do aluno (somente letras e espa�os, sem n�meros ou caracteres especiais)
    if (nomeAluno != null && !nomeAluno.matches("^[A-Za-z\\s]+$")) {
        out.println("<div class='alert alert-danger mt-4'>");
        out.println("<h4>Erro: Nome do aluno cont�m n�meros ou caracteres especiais!</h4>");
        out.println("<p>O nome do aluno deve conter apenas letras e espa�os.</p>");
        out.println("</div>");
        return; // Interrompe o processo se a valida��o falhar
    }

    // Valida a matr�cula (somente n�meros e exatamente 11 d�gitos)
    if (matricula != null && !matricula.matches("^[0-9]{11}$")) {
        out.println("<div class='alert alert-danger mt-4'>");
        out.println("<h4>Erro: Matr�cula inv�lida!</h4>");
        out.println("<p>A matr�cula deve conter exatamente 11 n�meros.</p>");
        out.println("</div>");
        return; // Interrompe o processo se a valida��o falhar
    }

    // Defina as vari�veis de conex�o com o banco de dados
    String url = "jdbc:mysql://localhost:3306/notemanager"; // URL do banco
    String user = "root"; // Usu�rio do banco de dados
    String password = ""; // Senha do banco

    Connection conn = null;
    PreparedStatement stmtAluno = null;
    PreparedStatement stmtNota = null;
    PreparedStatement stmtVerificaAluno = null;

    // Query para verificar se o aluno j� existe
    String sqlVerificaAluno = "SELECT COUNT(*) FROM alunos WHERE matricula = ? OR nome = ?";

    // Query para inserir dados na tabela alunos
    String sqlAluno = "INSERT INTO alunos (nome, matricula) VALUES (?, ?)";
    // Query para inserir dados na tabela notas
    String sqlNota = "INSERT INTO notas (id_aluno, id_disciplina, nota, periodo) VALUES (?, ?, ?, ?)";

    try {
        // Estabelece a conex�o com o banco
        Class.forName("com.mysql.cj.jdbc.Driver"); // Certifique-se de que o driver MySQL est� no classpath
        conn = DriverManager.getConnection(url, user, password);

        // Verifica se o aluno j� existe
        stmtVerificaAluno = conn.prepareStatement(sqlVerificaAluno);
        stmtVerificaAluno.setString(1, matricula);
        stmtVerificaAluno.setString(2, nomeAluno);
        ResultSet rs = stmtVerificaAluno.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            // Se o aluno j� existir, exibe uma mensagem de erro
            out.println("<div class='alert alert-danger mt-4'>");
            out.println("<h4>Erro: O aluno j� est� cadastrado!</h4>");
            out.println("<p>J� existe um aluno com o nome ou matr�cula fornecida.</p>");
            out.println("</div>");
        } else {
            // Caso o aluno n�o exista, insere o aluno e as notas
            stmtAluno = conn.prepareStatement(sqlAluno, Statement.RETURN_GENERATED_KEYS);
            stmtAluno.setString(1, nomeAluno);
            stmtAluno.setString(2, matricula);
            int rowsInserted = stmtAluno.executeUpdate();

            if (rowsInserted > 0) {
                // Obt�m o ID do aluno inserido
                ResultSet generatedKeys = stmtAluno.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int idAluno = generatedKeys.getInt(1); // Obt�m o ID do aluno rec�m-inserido

                    // Prepara a inser��o das notas para cada disciplina
                    Map<String, Double> notas = new HashMap<>();
                    notas.put("1", Double.parseDouble(notaPortugues));  // ID da disciplina 1 (Portugu�s)
                    notas.put("2", Double.parseDouble(notaMatematica)); // ID da disciplina 2 (Matem�tica)
                    notas.put("3", Double.parseDouble(notaGeografia)); // ID da disciplina 3 (Geografia)
                    notas.put("4", Double.parseDouble(notaHistoria));  // ID da disciplina 4 (Hist�ria)
                    notas.put("5", Double.parseDouble(notaCiencias));  // ID da disciplina 5 (Ci�ncias)

                    // Insere as notas na tabela notas
                    stmtNota = conn.prepareStatement(sqlNota);
                    for (Map.Entry<String, Double> entry : notas.entrySet()) {
                        stmtNota.setInt(1, idAluno); // ID do aluno
                        stmtNota.setInt(2, Integer.parseInt(entry.getKey())); // ID da disciplina
                        stmtNota.setDouble(3, entry.getValue()); // Nota
                        stmtNota.setString(4, "1� Semestre"); // Per�odo
                        stmtNota.addBatch(); // Adiciona � batch para otimizar a inser��o
                    }

                    // Executa o batch de inser��o das notas
                    stmtNota.executeBatch();

                    // Mensagem de sucesso
                    out.println("<div class='alert alert-success mt-4'>");
                    out.println("<h4>Aluno Adicionado com Sucesso!</h4>");
                    out.println("<p><strong>Nome:</strong> " + nomeAluno + "</p>");
                    out.println("<p><strong>Matr�cula:</strong> " + matricula + "</p>");
                    out.println("</div>");
                }
            }
        }
    } catch (SQLException e) {
        // Caso ocorra algum erro com o banco
        out.println("<div class='alert alert-danger mt-4'>");
        out.println("<h4>Erro ao inserir os dados no banco de dados!</h4>");
        out.println("<p>" + e.getMessage() + "</p>");
        out.println("</div>");
    } catch (ClassNotFoundException e) {
        // Caso o driver JDBC n�o seja encontrado
        out.println("<div class='alert alert-danger mt-4'>");
        out.println("<h4>Erro no carregamento do driver JDBC!</h4>");
        out.println("<p>" + e.getMessage() + "</p>");
        out.println("</div>");
    } finally {
        // Fechamento da conex�o e recursos
        try {
            if (stmtAluno != null) stmtAluno.close();
            if (stmtNota != null) stmtNota.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger mt-4'>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("</div>");
        }
    }
%>

        <!-- Voltar para o formul�rio -->
        <a href="index.html" class="btn btn-secondary mt-3 p-3 fw-bold">Voltar</a>
    </main>

    <footer id="footer-editar-aluno">
        <div class="container mb-3 text-center text-lg-start p-4">
            <h1 id="emprego">NoteManager</h1>
        </div>
        <div>
            <p class="text-center mt-4 p-copy">@2024-2025 NoteManager | Todos os direitos reservados</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
