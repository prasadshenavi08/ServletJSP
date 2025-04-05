package com.demo;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/InsertProductServlet")
@MultipartConfig
public class InsertProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("GET method is not supported for this servlet.");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String brand = request.getParameter("brand");
        String ram = request.getParameter("ram");
        String manufactureDate = request.getParameter("manufacture_date");
        String description = request.getParameter("description");
        Part filePart = request.getPart("image");

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("images") + File.separator + fileName;

            try (InputStream fileContent = filePart.getInputStream()) {
                File file = new File(uploadPath);
                Files.copy(fileContent, file.toPath());

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");
                PreparedStatement ps = con.prepareStatement("INSERT INTO mobiles (name, price, brand, ram, manufacture_date, description, image) VALUES (?, ?, ?, ?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setDouble(2, Double.parseDouble(price));
                ps.setString(3, brand);
                ps.setString(4, ram);
                ps.setString(5, manufactureDate);
                ps.setString(6, description);
                ps.setString(7, "images/" + fileName);

                int i = ps.executeUpdate();
                con.close();

                if (i > 0) {
                    response.sendRedirect("admindashboard.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            }
        } else {
            response.getWriter().println("Error: No file uploaded.");
        }
    }
}
