package xray;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;    

import database.SessionInfo;

/**
 * Servlet implementation class Doctor
 */
@WebServlet("/Doctor")
public class Doctor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Doctor() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String redir = "/command.jsp";
		
		//Insert new command
		if (request.getParameter("action") != null && request.getParameter("action").contentEquals("new_command") 
				&& request.getParameter("patient_id") != null && request.getParameter("exam") != null)
		{
			request.removeAttribute("patient_id");
			request.removeAttribute("exam");
			HttpSession session = request.getSession(true);
			SessionInfo sInfo = null;
			sInfo = (SessionInfo)session.getAttribute("sInfo");
			
			//Add command to array
			String sqlInsert = "INSERT INTO command VALUES (NULL, '" + request.getParameter("exam") + "')";
			String checker = "SELECT * FROM command ORDER BY idCommand DESC LIMIT 1";
			String checker_pk = "idCommand";
			int commandId = sInfo.runInsert(sqlInsert, checker, checker_pk);
			
			//Add command to doctor_issue_command array
			int doctorId = sInfo.getDoctorId();
			int patientId = Integer.valueOf((String)request.getParameter("patient_id"));
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
			LocalDateTime now = LocalDateTime.now();
			sqlInsert = "INSERT INTO doctor_issues_command VALUES (NULL, " + doctorId + ", " + commandId + ", " + patientId + ", '" + dtf.format(now) + "')";
			checker = "SELECT * FROM doctor_issues_command ORDER BY id DESC LIMIT 1";
			checker_pk = "id";
			sInfo.runInsert(sqlInsert, checker, checker_pk);
			
			//Link command with patient folder
			sInfo.updateFolderHasCommand(patientId, commandId);
			
			request.setAttribute("action", "inserted");	
		}
		//Edit command
		else if (request.getParameter("action") != null && request.getParameter("action").contentEquals("edit_command") 
			&& request.getParameter("id") != null && request.getParameter("exam") == null)
		{
			redir = "/command_view.jsp";
			HttpSession session = request.getSession(true);
			SessionInfo sInfo = null;
			sInfo = (SessionInfo)session.getAttribute("sInfo");
			int doctorId = sInfo.getDoctorId();
			int id = Integer.valueOf(request.getParameter("id"));
			String editable = sInfo.getCommand(doctorId, id);
			request.setAttribute("editable", editable);
			request.setAttribute("action", "editing");
		}
		//Change command
		else if (request.getParameter("action") != null && request.getParameter("action").contentEquals("edited_command") 
			&& request.getParameter("id") != null && request.getParameter("exam") != null)
		{
			redir = "/command_view.jsp";
			HttpSession session = request.getSession(true);
			SessionInfo sInfo = null;
			sInfo = (SessionInfo)session.getAttribute("sInfo");
			int doctorId = sInfo.getDoctorId();
			int id = Integer.valueOf(request.getParameter("id"));
			sInfo.updateDescription(doctorId, id, request.getParameter("exam"));
			request.removeAttribute("editable");
			request.setAttribute("action", "edited");
		}
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redir);
		dispatcher.forward(request,  response);	
	}

}
