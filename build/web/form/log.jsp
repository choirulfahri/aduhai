<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false", "root", "");
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String role = rs.getString("role");
            session.setAttribute("email", email);
            session.setAttribute("role", role);
            if ("admin".equals(role)) {
                response.sendRedirect("../view/dashboardAdmin.jsp");
            } else {
                response.sendRedirect("../view/pinno-shop.jsp");
            }
        } else {
            session.setAttribute("errorMessage", "Invalid email or password");
            response.sendRedirect("login.jsp");
        }
    } catch (Exception e) {
        session.setAttribute("errorMessage", "Database error: " + e.getMessage());
        response.sendRedirect("login.jsp");
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>