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
import java.sql.ResultSet;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public LoginServlet() {
        super();
        System.out.println("Constructor Invoked");
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String username = request.getParameter("txtusername");
        String password = request.getParameter("txtpassword");

        // Database connection
        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servletdemo", "root", "root");

            // Prepare SQL query
            PreparedStatement pstmt = con.prepareStatement("SELECT * FROM registration WHERE username = ? AND password = ?");
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            // Execute query
            ResultSet rs = pstmt.executeQuery();

            // Check login 
            if (rs.next()) {
                //out.println("<h1>Login Successful</h1>");
            	RequestDispatcher rd = request.getRequestDispatcher("ProductServlet");
            	rd.forward(request , response);
            } else {
                out.println("<h1>Invalid Username and Password</h1>");
            }

            // Close resources
            rs.close();
           
        } catch (Exception e) {
            out.println("<h1>Error Occur</h1>");
            e.printStackTrace();
        }

        out.println("<h1>Hello World!</h1>");
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
