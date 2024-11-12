<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // Recebe o nome do aluno ou ID pela URL
    String alunoNome = request.getParameter("id");
    
    // Dados de conexão com o banco de dados
    String url = "jdbc:mysql://localhost:3306/notemanager";
    String user = "root";
    String password = "";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Variáveis para armazenar as notas do aluno
    double notaPortugues = 0;
    double notaMatematica = 0;
    double notaGeografia = 0;
    double notaHistoria = 0;
    double notaCiencias = 0;

    try {
        // Conectar ao banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Consulta para pegar as notas do aluno
        String query = "SELECT n.nota, d.nome AS disciplina_nome FROM notas n " +
                       "JOIN disciplinas d ON n.id_disciplina = d.id_disciplina " +
                       "JOIN alunos a ON n.id_aluno = a.id_aluno " +
                       "WHERE a.nome = ?";
        ps = conn.prepareStatement(query);
        ps.setString(1, alunoNome); // Passa o nome do aluno para buscar as notas
        rs = ps.executeQuery();

        // Preencher as notas nas variáveis correspondentes
        while (rs.next()) {
            String disciplinaNome = rs.getString("disciplina_nome");
            double nota = rs.getDouble("nota");

            if ("Português".equals(disciplinaNome)) {
                notaPortugues = nota;
            } else if ("Matemática".equals(disciplinaNome)) {
                notaMatematica = nota;
            } else if ("Geografia".equals(disciplinaNome)) {
                notaGeografia = nota;
            } else if ("História".equals(disciplinaNome)) {
                notaHistoria = nota;
            } else if ("Ciências".equals(disciplinaNome)) {
                notaCiencias = nota;
            }
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
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NoteManager</title>
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
        <h1 class="titulo text-center">Editar Aluno</h1>

        <!-- Formulário de edição -->
        <form action="atualizar-aluno.jsp" method="POST">

            <div class="table-responsive mt-5">
                <table class="w-100 table-bordered tabela-config text-center">
                    <thead>
                        <tr>
                            <th scope="col">Aluno</th>
                            <th scope="col">Português</th>
                            <th scope="col">Matemática</th>
                            <th scope="col">Geografia</th>
                            <th scope="col">História</th>
                            <th scope="col">Ciências</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <!-- Campo de nome do aluno -->
                            <td><input type="text" class="adn-input-aluno" name="alunoNome" value="<%= alunoNome %>" readonly required></td>

                            <td><input type="number" class="w-50 adn-input" name="notaPortugues" value="10" min="0" max="10" step="0.1" required></td>
                                <td><input type="number" class="w-50 adn-input" name="notaMatematica" value="10" min="0" max="10" step="0.1" required></td>
                                <td><input type="number" class="w-50 adn-input" name="notaGeografia" value="10" min="0" max="10" step="0.1" required></td>
                                <td><input type="number" class="w-50 adn-input" name="notaHistoria" value="10" min="0" max="10" step="0.1" required></td>
                                <td><input type="number" class="w-50 adn-input" name="notaCiencias" value="10" min="0" max="10" step="0.1" required></td>

                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Botões para finalizar ou voltar -->
            <div class="ctn">
                <button type="submit" class="btn-add-finalizar" id="finalizar-edit-aluno">Finalizar</button>
                <a href="index.html" style="text-decoration: none; color: #fff;">
                    <button type="button" id="voltar-index" class="voltar-index">Voltar</button>
                </a>
            </div>

        </form>
        <!-- Fim do formulário -->

    </main>

    <footer id="footer-editar-aluno">
        <div class="container mb-3 text-center text-lg-start p-4">
            <h1 id="emprego">NoteManager</h1>
        </div>
        <div>
            <p class="text-center mt-4 p-copy">@2024-2025 NoteManager | Todos os direitos reservados</p>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="../conteudo/js/script.js"></script>

    <!-- JS do Bootstrap e dependências (jQuery e Popper.js) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
