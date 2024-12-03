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
    // Recebe os dados enviados do formulário via POST
    String nomeAluno = request.getParameter("nomeAluno");
    String matricula = request.getParameter("matricula");
    String notaPortugues = request.getParameter("notaPortugues");
    String notaMatematica = request.getParameter("notaMatematica");
    String notaGeografia = request.getParameter("notaGeografia");
    String notaHistoria = request.getParameter("notaHistoria");
    String notaCiencias = request.getParameter("notaCiencias");

    // Valida o nome do aluno (somente letras e espaços, sem números ou caracteres especiais)
    if (nomeAluno != null && !nomeAluno.matches("^[A-Za-z\\s]+$")) {
        out.println("<div class='alert alert-danger mt-4'>");
        out.println("<h4>Erro: Nome do aluno contém números ou caracteres especiais!</h4>");
        out.println("<p>O nome do aluno deve conter apenas letras e espaços.</p>");
        out.println("</div>");
        return; // Interrompe o processo se a validação falhar
    }

    // Valida a matrícula (somente números e exatamente 11 dígitos)
    if (matricula != null && !matricula.matches("^[0-9]{11}$")) {
        out.println("<div class='alert alert-danger mt-4'>");
        out.println("<h4>Erro: Matrícula inválida!</h4>");
        out.println("<p>A matrícula deve conter exatamente 11 números.</p>");
        out.println("</div>");
        return; // Interrompe o processo se a validação falhar
    }

    // Defina as variáveis de conexão com o banco de dados
    String url = "jdbc:mysql://localhost:3306/notemanager"; // URL do banco
    String user = "root"; // Usuário do banco de dados
    String password = ""; // Senha do banco

    Connection conn = null;
    PreparedStatement stmtAluno = null;
    PreparedStatement stmtNota = null;
    PreparedStatement stmtVerificaAluno = null;

    // Query para verificar se o aluno já existe
    String sqlVerificaAluno = "SELECT COUNT(*) FROM alunos WHERE matricula = ? OR nome = ?";

    // Query para inserir dados na tabela alunos
    String sqlAluno = "INSERT INTO alunos (nome, matricula) VALUES (?, ?)";
    // Query para inserir dados na tabela notas
    String sqlNota = "INSERT INTO notas (id_aluno, id_disciplina, nota, periodo) VALUES (?, ?, ?, ?)";

    try {
        // Estabelece a conexão com o banco
        Class.forName("com.mysql.cj.jdbc.Driver"); // Certifique-se de que o driver MySQL está no classpath
        conn = DriverManager.getConnection(url, user, password);

        // Verifica se o aluno já existe
        stmtVerificaAluno = conn.prepareStatement(sqlVerificaAluno);
        stmtVerificaAluno.setString(1, matricula);
        stmtVerificaAluno.setString(2, nomeAluno);
        ResultSet rs = stmtVerificaAluno.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            // Se o aluno já existir, exibe uma mensagem de erro
            out.println("<div class='alert alert-danger mt-4'>");
            out.println("<h4>Erro: O aluno já está cadastrado!</h4>");
            out.println("<p>Já existe um aluno com o nome ou matrícula fornecida.</p>");
            out.println("</div>");
        } else {
            // Caso o aluno não exista, insere o aluno e as notas
            stmtAluno = conn.prepareStatement(sqlAluno, Statement.RETURN_GENERATED_KEYS);
            stmtAluno.setString(1, nomeAluno);
            stmtAluno.setString(2, matricula);
            int rowsInserted = stmtAluno.executeUpdate();

            if (rowsInserted > 0) {
                // Obtém o ID do aluno inserido
                ResultSet generatedKeys = stmtAluno.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int idAluno = generatedKeys.getInt(1); // Obtém o ID do aluno recém-inserido

                    // Prepara a inserção das notas para cada disciplina
                    Map<String, Double> notas = new HashMap<>();
                    notas.put("1", Double.parseDouble(notaPortugues));  // ID da disciplina 1 (Português)
                    notas.put("2", Double.parseDouble(notaMatematica)); // ID da disciplina 2 (Matemática)
                    notas.put("3", Double.parseDouble(notaGeografia)); // ID da disciplina 3 (Geografia)
                    notas.put("4", Double.parseDouble(notaHistoria));  // ID da disciplina 4 (História)
                    notas.put("5", Double.parseDouble(notaCiencias));  // ID da disciplina 5 (Ciências)

                    // Insere as notas na tabela notas
                    stmtNota = conn.prepareStatement(sqlNota);
                    for (Map.Entry<String, Double> entry : notas.entrySet()) {
                        stmtNota.setInt(1, idAluno); // ID do aluno
                        stmtNota.setInt(2, Integer.parseInt(entry.getKey())); // ID da disciplina
                        stmtNota.setDouble(3, entry.getValue()); // Nota
                        stmtNota.setString(4, "1º Semestre"); // Período
                        stmtNota.addBatch(); // Adiciona à batch para otimizar a inserção
                    }

                    // Executa o batch de inserção das notas
                    stmtNota.executeBatch();

                    // Mensagem de sucesso
                    out.println("<div class='alert alert-success mt-4'>");
                    out.println("<h4>Aluno Adicionado com Sucesso!</h4>");
                    out.println("<p><strong>Nome:</strong> " + nomeAluno + "</p>");
                    out.println("<p><strong>Matrícula:</strong> " + matricula + "</p>");
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
        // Caso o driver JDBC não seja encontrado
        out.println("<div class='alert alert-danger mt-4'>");
        out.println("<h4>Erro no carregamento do driver JDBC!</h4>");
        out.println("<p>" + e.getMessage() + "</p>");
        out.println("</div>");
    } finally {
        // Fechamento da conexão e recursos
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

        <!-- Voltar para o formulário -->
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
