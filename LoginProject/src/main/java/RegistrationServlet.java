import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegistrationServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String fname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String birthday = request.getParameter("birthdate");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");

        // Database connection
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servletdemo", "root", "root");

            // Prepare SQL query
            PreparedStatement pstmt = con.prepareStatement(
                "INSERT INTO registration (fullname, email, contact, address, birthdate, username, password, gender) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
            );

            pstmt.setString(1, fname);
            pstmt.setString(2, email);
            pstmt.setString(3, contact);
            pstmt.setString(4, address);
            pstmt.setString(5, birthday);
            pstmt.setString(6, username);
            pstmt.setString(7, password);
            pstmt.setString(8, gender);

            // Execute query
            int result = pstmt.executeUpdate();

            if (result > 0) {
                out.print("<h3>Registration Successful!</h3>");
                RequestDispatcher rd = request.getRequestDispatcher("login.html");
                rd.include(request, response);
            } else {
                out.print("<h3>Registration Failed. Please try again.</h3>");
                RequestDispatcher rd = request.getRequestDispatcher("registration.html");
                rd.include(request, response);
            }

            // Close connection
            pstmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print("<h3>Error occurred: " + e.getMessage() + "</h3>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
