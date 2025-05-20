<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rutthshop - E-Commerce</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById("sidebar");
            sidebar.classList.toggle("translate-x-full");
        }

        function closeSidebar() {
            document.getElementById("sidebar").classList.add("translate-x-full");
        }
    </script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
    </style>
</head>
<body class="bg-gray-50 relative">

    <!-- Navbar -->
    <nav class="bg-white shadow-md py-4 px-8 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-blue-600">Rutthshop</h1>
        <div class="space-x-4">
            <a href="cart.jsp" class="text-gray-700 hover:text-blue-600 font-semibold">Cart</a>
            <button onclick="toggleSidebar()" class="text-gray-700 hover:text-blue-600 font-semibold">Profil</button>
        </div>
    </nav>

    <!-- Sidebar -->
    <div id="sidebar" class="fixed top-0 right-0 h-full w-64 bg-white shadow-lg transform translate-x-full transition-transform duration-300 z-50">
        <div class="p-4 border-b flex justify-between items-center">
            <h2 class="text-xl font-bold text-gray-800">Menu</h2>
            <button onclick="closeSidebar()" class="text-gray-500 hover:text-red-500 text-xl font-bold">&times;</button>
        </div>
        <ul class="p-4 space-y-4">
            <li><a href="history.jsp" class="block text-gray-700 hover:text-blue-600 font-medium">History</a></li>
            <li><a href="setting.jsp" class="block text-gray-700 hover:text-blue-600 font-medium">Setting</a></li>
            <li><a href="logout.jsp" class="block text-red-600 hover:text-red-800 font-medium">Log Out</a></li>
        </ul>
    </div>

    <!-- Hero Section -->
    <section class="bg-blue-100 py-16 text-center">
        <h2 class="text-4xl font-bold text-gray-800 mb-4">Selamat Datang di Rutthshop!</h2>
        <p class="text-gray-600 text-lg">Temukan berbagai produk terbaik untuk kebutuhanmu</p>
    </section>

    <!-- Product Display -->
    <section class="px-8 py-12">
        <h3 class="text-2xl font-semibold text-gray-800 mb-6">Produk Terbaru</h3>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna", "root", "");
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM barang ORDER BY created_at DESC");

                    while (rs.next()) {
                        String nama = rs.getString("nama_barang");
                        String harga = rs.getString("harga");
                        String gambar = rs.getString("gambar");
            %>
                <div class="bg-white shadow-md rounded-lg overflow-hidden hover:shadow-lg transition-shadow">
                    <img src="assets/img/<%= gambar %>" alt="<%= nama %>" class="w-full h-48 object-cover">
                    <div class="p-4">
                        <h4 class="text-lg font-bold text-gray-800"><%= nama %></h4>
                        <p class="text-blue-600 font-semibold mt-2">Rp <%= String.format("%,.0f", Double.parseDouble(harga)) %></p>
                        <button class="mt-4 w-full bg-blue-600 text-white py-2 px-4 rounded hover:bg-blue-700">Add to Cart</button>
                    </div>
                </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<p class='text-red-500'>Gagal memuat produk: " + e.getMessage() + "</p>");
                }
            %>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-white text-center py-4 border-t mt-12 text-sm text-gray-500">
        &copy; 2025 Rutthshop. All rights reserved.
    </footer>
</body>
</html>
