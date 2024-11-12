<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // Receber os dados do formul�rio
    String alunoNome = request.getParameter("alunoNome");
    double notaPortugues = Double.parseDouble(request.getParameter("notaPortugues"));
    double notaMatematica = Double.parseDouble(request.getParameter("notaMatematica"));
    double notaGeografia = Double.parseDouble(request.getParameter("notaGeografia"));
    double notaHistoria = Double.parseDouble(request.getParameter("notaHistoria"));
    double notaCiencias = Double.parseDouble(request.getParameter("notaCiencias"));

    // Dados de conex�o com o banco de dados
    String url = "jdbc:mysql://localhost:3306/notemanager";
    String user = "root";
    String password = "";
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Conectar ao banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Atualizar as notas nas disciplinas correspondentes
        String updateQuery = "UPDATE notas SET nota = ? WHERE id_aluno = (SELECT id_aluno FROM alunos WHERE nome = ?) AND id_disciplina = ?";
        
        // 1. Atualizar a nota de Portugu�s
        ps = conn.prepareStatement(updateQuery);
        ps.setDouble(1, notaPortugues);
        ps.setString(2, alunoNome);
        ps.setInt(3, 1); // Supondo que 1 seja o id da disciplina Portugu�s
        ps.executeUpdate();

        // 2. Atualizar a nota de Matem�tica
        ps.setDouble(1, notaMatematica);
        ps.setString(2, alunoNome);
        ps.setInt(3, 2); // Supondo que 2 seja o id da disciplina Matem�tica
        ps.executeUpdate();

        // 3. Atualizar a nota de Geografia
        ps.setDouble(1, notaGeografia);
        ps.setString(2, alunoNome);
        ps.setInt(3, 3); // Supondo que 3 seja o id da disciplina Geografia
        ps.executeUpdate();

        // 4. Atualizar a nota de Hist�ria
        ps.setDouble(1, notaHistoria);
        ps.setString(2, alunoNome);
        ps.setInt(3, 4); // Supondo que 4 seja o id da disciplina Hist�ria
        ps.executeUpdate();

        // 5. Atualizar a nota de Ci�ncias
        ps.setDouble(1, notaCiencias);
        ps.setString(2, alunoNome);
        ps.setInt(3, 5); // Supondo que 5 seja o id da disciplina Ci�ncias
        ps.executeUpdate();

        // Se tudo correr bem, redirecionar para a p�gina de consulta
        response.sendRedirect("consultar-alunos.jsp?sucesso=true");
        
    } catch (Exception e) {
        e.printStackTrace();
        // Caso ocorra algum erro, redireciona para a p�gina de erro
        response.sendRedirect("consultar-alunos.jsp?erro=true");
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
