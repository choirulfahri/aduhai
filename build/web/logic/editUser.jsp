<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    int id = Integer.parseInt(request.getParameter("id"));
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String role = request.getParameter("role");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna", "root", "");
        String sql = "UPDATE users SET username=?, email=?, role=? WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, email);
        stmt.setString(3, role);
        stmt.setInt(4, id);

        int result = stmt.executeUpdate();
        stmt.close(); conn.close();

        response.sendRedirect("../view/dashboardAdmin.jsp");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
