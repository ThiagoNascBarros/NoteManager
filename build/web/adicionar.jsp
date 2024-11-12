<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // Inicializa��o das vari�veis
    String alunoNome = request.getParameter("nomeAluno");
    String matricula = request.getParameter("matricula");
    double notaPortugues = Double.parseDouble(request.getParameter("notaPortugues"));
    double notaMatematica = Double.parseDouble(request.getParameter("notaMatematica"));
    double notaGeografia = Double.parseDouble(request.getParameter("notaGeografia"));
    double notaHistoria = Double.parseDouble(request.getParameter("notaHistoria"));
    double notaCiencias = Double.parseDouble(request.getParameter("notaCiencias"));

    // Definindo vari�veis de banco de dados
    String url = "jdbc:mysql://localhost:3306/notemanager";  // URL do banco de dados
    String user = "root";  // Usu�rio do banco de dados
    String password = "";  // Senha do banco de dados
    Connection conn = null;
    PreparedStatement psAluno = null;
    PreparedStatement psNotas = null;
    ResultSet rs = null;

    try {
        // Carregar o driver JDBC e conectar ao banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Inserir aluno no banco de dados
        String sqlAluno = "INSERT INTO alunos (nome, matricula) VALUES (?, ?)";
        psAluno = conn.prepareStatement(sqlAluno, Statement.RETURN_GENERATED_KEYS);
        psAluno.setString(1, alunoNome);
        psAluno.setString(2, matricula);
        psAluno.executeUpdate();

        // Recuperar o ID do aluno inserido
        rs = psAluno.getGeneratedKeys();
        int idAluno = -1;
        if (rs.next()) {
            idAluno = rs.getInt(1);  // Pega o ID gerado automaticamente
        }

        // Inserir notas para cada disciplina
        String sqlNotas = "INSERT INTO notas (id_aluno, id_disciplina, nota) VALUES (?, (SELECT id_disciplina FROM disciplinas WHERE nome = ?), ?)";

        psNotas = conn.prepareStatement(sqlNotas);

        // Inserir notas para cada disciplina
        psNotas.setInt(1, idAluno);
        psNotas.setString(2, "Portugu�s");
        psNotas.setDouble(3, notaPortugues);
        psNotas.executeUpdate();

        psNotas.setInt(1, idAluno);
        psNotas.setString(2, "Matem�tica");
        psNotas.setDouble(3, notaMatematica);
        psNotas.executeUpdate();

        psNotas.setInt(1, idAluno);
        psNotas.setString(2, "Geografia");
        psNotas.setDouble(3, notaGeografia);
        psNotas.executeUpdate();

        psNotas.setInt(1, idAluno);
        psNotas.setString(2, "Hist�ria");
        psNotas.setDouble(3, notaHistoria);
        psNotas.executeUpdate();

        psNotas.setInt(1, idAluno);
        psNotas.setString(2, "Ci�ncias");
        psNotas.setDouble(3, notaCiencias);
        psNotas.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Fechar todos os recursos
        try {
            if (rs != null) rs.close();
            if (psAluno != null) psAluno.close();
            if (psNotas != null) psNotas.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }

    // Ap�s o cadastro, redireciona de volta � p�gina (sem par�metros de sucesso ou erro)
    response.sendRedirect("adicionar-aluno.html");
%>
