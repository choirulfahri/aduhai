<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    if (id != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false", "root", "");
            PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id = ?");
            ps.setInt(1, Integer.parseInt(id));
            int result = ps.executeUpdate();

            ps.close();
            conn.close();

            if (result > 0) {
                session.setAttribute("message", "User berhasil dihapus.");
            } else {
                session.setAttribute("errorMessage", "Gagal menghapus user.");
            }
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
        }
    } else {
        session.setAttribute("errorMessage", "ID user tidak ditemukan.");
    }

    response.sendRedirect("../view/dashboardAdmin.jsp");
%>
