package com.training;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FrontServlet
 */
@WebServlet("/home")
public class FrontServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FrontServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private String str;
    
    
    
    public void init(ServletConfig config) throws ServletException {
    	str = "Hello World";
    	
    	 try {
    		 System.out.println("Pass_40");
             Class.forName("oracle.jdbc.driver.OracleDriver");
             String url= "jdbc:oracle:thin:@//localhost:1521/orcl";
             String userName = "sys as sysdba";
             String password = "system";
             Connection con=DriverManager.getConnection(url,userName,password);
             Statement stmt=con.createStatement();
             ResultSet rs=stmt.executeQuery("select * from USERONE");
             System.out.println("Pass_48 " +rs);    
          while(rs.next())  {
              System.out.println(rs.getString(1)+"  "+rs.getString(2));
     
          }   
         
      con.close();
         
         
      } catch (ClassNotFoundException | SQLException e) {
         
          e.printStackTrace();
      }
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		out.println("<h1>" +str + "</h1>");*/
		
		request.setAttribute("value", str);
        request.getRequestDispatcher("home.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	


}
