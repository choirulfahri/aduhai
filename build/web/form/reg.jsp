<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false", "root", "");
        String sql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, 'user')";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, email);
        pstmt.setString(3, password);
        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            session.setAttribute("successMessage", "Registration successful! Please sign in.");
            response.sendRedirect("login.jsp");
        }
    } catch (SQLException e) {
        session.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
        response.sendRedirect("login.jsp");
    } catch (Exception e) {
        session.setAttribute("errorMessage", "Database error: " + e.getMessage());
        response.sendRedirect("login.jsp");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>