<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .tab-content { display: none; }
        .tab-content.active { display: block; }
        .btn-hover { transition: all 0.3s ease; }
        .btn-hover:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.2); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
        img { max-width: 100px; height: auto; }
        .modal {
            display: none; position: fixed; z-index: 10;
            left: 0; top: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background: white; margin: 10% auto; padding: 20px;
            border-radius: 8px; width: 90%; max-width: 500px;
        }
    </style>
</head>
<body class="bg-white min-h-screen">
<div class="container mx-auto p-6">
    <!-- Header -->
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-xl font-semibold text-gray-700">Ruth Dashboard</h2>
        <nav class="flex space-x-4">
            <a href="#" id="usersTab" class="px-4 py-2 bg-gray-200 rounded-md btn-hover">Data User</a>
            <a href="#" id="barangTab" class="px-4 py-2 bg-gray-200 rounded-md btn-hover">Data Barang</a>
            <a href="#" id="transaksiTab" class="px-4 py-2 bg-gray-200 rounded-md btn-hover">Data Transaksi</a>
            <a href="login.jsp" class="px-4 py-2 bg-gray-200 rounded-md btn-hover">Log Out</a>
        </nav>
    </div>

    <!-- Welcome -->
    <div class="text-center mb-6">
        <h3 class="text-2xl font-bold">Wassupp Ma G !!! (<%= session.getAttribute("email") %>)</h3>
    </div>

    <!-- USERS -->
    <div id="usersContent" class="tab-content">
        <h3 class="text-lg font-semibold text-gray-700 mb-4">Data User</h3>
        <table>
            <thead>
                <tr><th>ID</th><th>Username</th><th>Email</th><th>Role</th><th>Created At</th><th>Aksi</th></tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna", "root", "");
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM users");
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("role") %></td>
                <td><%= rs.getTimestamp("created_at") %></td>
                <td>
                    <a href="../logic/deleteUser.jsp?id=<%= rs.getInt("id") %>" class="text-red-500 hover:underline" onclick="return confirm('Yakin hapus user?')">Hapus</a>
                </td>
            </tr>
            <%
                    }
                    rs.close(); stmt.close(); conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>" + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>

    <!-- BARANG -->
    <div id="barangContent" class="tab-content">
        <h3 class="text-lg font-semibold text-gray-700 mb-4">Data Barang</h3>
        <button onclick="document.getElementById('barangModal').style.display='block'" class="mb-4 px-4 py-2 bg-blue-600 text-white rounded-md btn-hover">Tambah Barang</button>

        <div id="barangModal" class="modal">
            <div class="modal-content">
                <span onclick="document.getElementById('barangModal').style.display='none'" class="float-right cursor-pointer text-red-500 text-lg font-bold">&times;</span>
                <h4 class="text-md font-semibold mb-2">Tambah Barang</h4>
                <form action="../logic/addBarang.jsp" method="post" enctype="multipart/form-data">
                    <input type="text" name="nama_barang" placeholder="Nama Barang" required class="mb-2 w-full p-2 border rounded">
                    <input type="number" name="stok" placeholder="Stok" required class="mb-2 w-full p-2 border rounded">
                    <input type="number" step="0.01" name="harga" placeholder="Harga" required class="mb-2 w-full p-2 border rounded">
                    <textarea name="deskripsi" placeholder="Deskripsi" rows="3" required class="mb-2 w-full p-2 border rounded"></textarea>
                    <input type="file" name="gambar" accept="image/*" required class="mb-2 w-full">
                    <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-md btn-hover">Tambah</button>
                </form>
            </div>
        </div>

        <% if (session.getAttribute("message") != null) { %>
            <p class="text-green-500 mt-2"><%= session.getAttribute("message") %></p>
            <% session.removeAttribute("message"); %>
        <% } %>
        <% if (session.getAttribute("errorMessage") != null) { %>
            <p class="text-red-500 mt-2"><%= session.getAttribute("errorMessage") %></p>
            <% session.removeAttribute("errorMessage"); %>
        <% } %>

        <table>
            <thead>
                <tr>
                    <th>ID</th><th>Nama</th><th>Stok</th><th>Harga</th><th>Deskripsi</th><th>Gambar</th><th>Created</th><th>Aksi</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    Connection conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna", "root", "");
                    Statement stmt2 = conn2.createStatement();
                    ResultSet rs2 = stmt2.executeQuery("SELECT * FROM barang");
                    while (rs2.next()) {
            %>
            <tr>
                <td><%= rs2.getString("nama_barang") %></td>
                <td><%= rs2.getInt("stok") %></td>
                <td>Rp. <%= rs2.getInt("harga") %></td>
                <td><%= rs2.getString("deskripsi") %></td>
                <td><img src="assets/img/<%= rs2.getString("gambar") %>" alt="gambar"></td>
                <td><%= rs2.getTimestamp("created_at") %></td>
                <td>
                    <a href="../logic/deleteBarang.jsp?id=<%= rs2.getInt("id") %>" class="text-red-500 hover:underline" onclick="return confirm('Yakin hapus barang ini?')">Delete</a>
                </td>
            </tr>
            <%
                    }
                    rs2.close(); stmt2.close(); conn2.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='8'>" + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>

    <!-- TRANSAKSI -->
    <div id="transaksiContent" class="tab-content">
        <h3 class="text-lg font-semibold text-gray-700 mb-4">Data Transaksi</h3>
        <table>
            <thead>
                <tr><th>ID</th><th>User</th><th>Barang</th><th>Jumlah</th><th>Total</th><th>Tanggal</th></tr>
            </thead>
            <tbody>
            <%
                try {
                    Connection conn3 = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna", "root", "");
                    Statement stmt3 = conn3.createStatement();
                    String sql = "SELECT t.id, u.username, b.nama_barang, t.jumlah, t.harga_total, t.created_at FROM transaksi t JOIN users u ON t.user_id = u.id JOIN barang b ON t.barang_id = b.id_barang";
                    ResultSet rs3 = stmt3.executeQuery(sql);
                    while (rs3.next()) {
            %>
            <tr>
                <td><%= rs3.getInt("id") %></td>
                <td><%= rs3.getString("username") %></td>
                <td><%= rs3.getString("nama_barang") %></td>
                <td><%= rs3.getInt("jumlah") %></td>
                <td>Rp. <%= rs3.getInt("harga_total") %></td>
                <td><%= rs3.getTimestamp("created_at") %></td>
            </tr>
            <%
                    }
                    rs3.close(); stmt3.close(); conn3.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>" + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script>
    const usersTab = document.getElementById('usersTab');
    const barangTab = document.getElementById('barangTab');
    const transaksiTab = document.getElementById('transaksiTab');

    const usersContent = document.getElementById('usersContent');
    const barangContent = document.getElementById('barangContent');
    const transaksiContent = document.getElementById('transaksiContent');

    function showTab(tab) {
        [usersContent, barangContent, transaksiContent].forEach(c => c.classList.remove('active'));
        [usersTab, barangTab, transaksiTab].forEach(t => t.classList.remove('bg-blue-500', 'text-white'));

        if (tab === 'users') {
            usersContent.classList.add('active');
            usersTab.classList.add('bg-blue-500', 'text-white');
        } else if (tab === 'barang') {
            barangContent.classList.add('active');
            barangTab.classList.add('bg-blue-500', 'text-white');
        } else {
            transaksiContent.classList.add('active');
            transaksiTab.classList.add('bg-blue-500', 'text-white');
        }
    }

    usersTab.addEventListener('click', e => { e.preventDefault(); showTab('users'); });
    barangTab.addEventListener('click', e => { e.preventDefault(); showTab('barang'); });
    transaksiTab.addEventListener('click', e => { e.preventDefault(); showTab('transaksi'); });

    // Default tab
    showTab('users');

    // Close modal on outside click
    window.onclick = function(e) {
        if (e.target === document.getElementById('barangModal')) {
            document.getElementById('barangModal').style.display = 'none';
        }
    }
</script>
</body>
</html>