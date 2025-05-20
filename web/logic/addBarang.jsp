<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="jakarta.servlet.http.*"%>
<%@page import="jakarta.servlet.ServletException"%>
<%@page import="jakarta.servlet.annotation.MultipartConfig"%>
<%@page import="java.nio.file.*" %>
<%@page import="jakarta.servlet.http.Part"%>
<%@page import="java.util.*"%>
<%
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        out.println("This page processes form submissions only.");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    String nama_barang = request.getParameter("nama_barang");
    String deskripsi = request.getParameter("deskripsi");
    String harga = request.getParameter("harga");
    String stokStr = request.getParameter("stok");
    int stok = 0;

    if (nama_barang == null || nama_barang.trim().isEmpty()) {
        response.sendRedirect("../view/dashboardAdmin.jsp?error=Nama barang tidak boleh kosong!");
        return;
    }

    try {
        Double.parseDouble(harga);
    } catch (NumberFormatException e) {
        response.sendRedirect("../view/dashboardAdmin.jsp?error=Harga harus berupa angka!");
        return;
    }

    if (stokStr == null || stokStr.trim().isEmpty()) {
        response.sendRedirect("../view/dashboardAdmin.jsp?error=Stok tidak boleh kosong!");
        return;
    }

    try {
        stok = Integer.parseInt(stokStr);
        if (stok < 0) {
            response.sendRedirect("../view/dashboardAdmin.jsp?error=Stok tidak boleh negatif!");
            return;
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("../view/dashboardAdmin.jsp?error=Stok harus berupa angka bulat!");
        return;
    }

    String gambar = "";
    Part filePart = null;

    try {
        if (request.getContentType() != null && request.getContentType().toLowerCase().contains("multipart/form-data")) {
            filePart = request.getPart("gambar");
        }
    } catch (Exception e) {
        System.out.println("Error getting file part: " + e.getMessage());
    }

    if (filePart != null && filePart.getSize() > 0) {
        String fileName = filePart.getSubmittedFileName();
        if (fileName != null && !fileName.isEmpty()) {
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String uniqueFileName = "barang_" + System.currentTimeMillis() + fileExtension;
            gambar = uniqueFileName;

            String buildUploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "img";
            File buildUploadDir = new File(buildUploadPath);
            if (!buildUploadDir.exists()) {
                buildUploadDir.mkdirs();
            }

            filePart.write(buildUploadPath + File.separator + uniqueFileName);

            File sourceFile = new File(buildUploadPath + File.separator + uniqueFileName);
            try {
                String buildDirPath = getServletContext().getRealPath("");
                File buildDir = new File(buildDirPath);
                String projectRoot = buildDir.getParentFile().getParent();
                String persistentAssetsPath = projectRoot + File.separator + "web" + File.separator + "assets" + File.separator + "img";
                File persistentAssetsDir = new File(persistentAssetsPath);
                if (!persistentAssetsDir.exists()) {
                    persistentAssetsDir.mkdirs();
                }
                File persistentDestFile = new File(persistentAssetsPath + File.separator + uniqueFileName);
                Files.copy(sourceFile.toPath(), persistentDestFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            } catch(Exception e) {
                System.out.println("Error copying file: " + e.getMessage());
            }
        }
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/yuna";
        String dbUser = "root";
        String dbPassword = "";
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        String sql = "INSERT INTO barang (nama_barang, stok, harga, deskripsi, gambar) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, nama_barang);
        pstmt.setInt(2, stok);
        pstmt.setString(3, harga);
        pstmt.setString(4, deskripsi);
        pstmt.setString(5, gambar);

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("../view/dashboardAdmin.jsp?success=Barang berhasil ditambahkan");
        } else {
            response.sendRedirect("../view/dashboardAdmin.jsp?error=Gagal menambahkan barang");
        }

    } catch (Exception e) {
        response.sendRedirect("../view/dashboardAdmin.jsp?error=Error: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {}
    }
%>
