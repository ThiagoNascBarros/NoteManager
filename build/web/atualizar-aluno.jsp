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
    int idAluno = Integer.parseInt(request.getParameter("id_aluno"));
    String nome = request.getParameter("nome");
    String matricula = request.getParameter("matricula");

    // Pegando as notas das disciplinas
    Map<String, Double> notas = new HashMap<>();
    notas.put("Português", Double.parseDouble(request.getParameter("notaPortugues")));
    notas.put("Matemática", Double.parseDouble(request.getParameter("notaMatematica")));
    notas.put("Geografia", Double.parseDouble(request.getParameter("notaGeografia")));
    notas.put("História", Double.parseDouble(request.getParameter("notaHistoria")));
    notas.put("Ciências", Double.parseDouble(request.getParameter("notaCiencias")));

    try {
        // Conectar ao banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Atualizar os dados do aluno
        String updateAluno = "UPDATE alunos SET nome = ?, matricula = ? WHERE id_aluno = ?";
        ps = conn.prepareStatement(updateAluno);
        ps.setString(1, nome);
        ps.setString(2, matricula);
        ps.setInt(3, idAluno);
        ps.executeUpdate();

        // Atualizar as notas das disciplinas
        String updateNota = "UPDATE notas SET nota = ? WHERE id_aluno = ? AND id_disciplina = (SELECT id_disciplina FROM disciplinas WHERE nome = ?)";
        for (Map.Entry<String, Double> entry : notas.entrySet()) {
            String disciplina = entry.getKey();
            Double nota = entry.getValue();

            ps = conn.prepareStatement(updateNota);
            ps.setDouble(1, nota);
            ps.setInt(2, idAluno);
            ps.setString(3, disciplina);
            ps.executeUpdate();
        }

        // Redirecionar para a página de consulta
        response.sendRedirect("consultar-alunos.jsp?nome=" + nome);

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
