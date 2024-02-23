package xray;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.SessionInfo;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Login
		if (request.getParameter("username") != null && request.getParameter("pass") != null)
		{
			String username = request.getParameter("username"); //pairnw to username tis formas
			String password = request.getParameter("pass"); //pairnw to password tis formas
			SessionInfo sInfo = new SessionInfo();
			boolean loggedIn = sInfo.checkLogin(username, password); 
			if (loggedIn == false) //o xristis den uparxei
				request.setAttribute("login", "Δώσατε λανθασμένα στοιχεία.");
			else //Ola ok me to xristi
			{
				HttpSession session = request.getSession(true);
				session.setAttribute("sInfo", sInfo);	
			}
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");		
			dispatcher.forward(request,  response);
		}
		
		//Logout user
		if (request.getParameter("logout") != null)
		{
			HttpSession session = request.getSession(true);
			SessionInfo sInfo = new SessionInfo();
			if (session.isNew() == false)
				session.setAttribute("sInfo", sInfo); //set sInfo as an empty
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");		
			dispatcher.forward(request,  response);
		}
	}

}
