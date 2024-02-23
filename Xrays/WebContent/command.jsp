<%@ page import="database.SessionInfo"%>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Υγειονομική περιφέρεια</title>
		<link rel="icon" type="image/x-icon" href="images/favicon.ico">
		<meta charset="utf-8"/>
		<style type="text/css">
			@import url('css/style.css');
		</style>
		<script src="js/mycode.js"></script>
	</head>
	
	<%
	SessionInfo sInfo = new SessionInfo();
	
	String login = null;
	if (request.getAttribute("login") != null)
		login = (String)request.getAttribute("login");
	
	if (session.isNew() == false)
	{
		if (session.getAttribute("sInfo") != null)
			sInfo = (SessionInfo)session.getAttribute("sInfo");
	}
	
	String patients = null;
	if (sInfo.isLoggedIn() && sInfo.getMyRole().contains("doctor"))
		patients = sInfo.getDoctorPatients();
	
	String action = null;
	if (request.getAttribute("action") != null)
		action = (String)request.getAttribute("action");
	
	String content = null;
	content = "";
	%>
	
	<body>
		<header>
			<span class="header_first"> <a href="index.jsp"><img src="images/logo.png" width="420px" height="110px;"></a> </span>
			<span class="header_second"> &nbsp; </span>
			<span class="header_userdata"> 
			<% if (sInfo.isLoggedIn()) { %>
			<form method="post" action="Login"> 
			Συνδεθήκατε ως: <strong><%=sInfo.getUsername() %></strong> <br/><strong><%=sInfo.getMyRole() %></strong> <br/><br/> <input type="submit" class="cancel small" name="logout" value="Αποσύνδεση">
			</form>
			<% } else { %>
			<form method="post" action="Login">
			<center>Σύνδεση χρήστη</center>
			<label class="userlabel">Username:</label> <input type="text" name="username" class="userinput" placeholder="username" required><br/>
			<label class="userlabel">Κωδικός:</label> <input type="password" name="pass" class="userinput" placeholder="password" required><br> 
			<% if (login != null) { %> <center><span class="loginfail"> <%=login %> </span></center> <% } else { %> <span class="loginfail"> &nbsp; </span> <% }%> 
			<center><input type="submit" class="submit small" name="login" value="Σύνδεση"> &nbsp; &nbsp; <input type="reset" class="cancel small" value="Καθαρισμός"></center>
			</form>
			<% } %> 
			</span>
		</header>		
		<nav>
			<ul>
				<li><a href="index.jsp">Αρχική</a></li>
				<% if (sInfo.isLoggedIn() && sInfo.getMyRole().contains("doctor")) { %>
					<li><a class="active" href="command.jsp">Έκδοση εντολής</a></li> 
					<li><a href="command_view.jsp">Προβολή εντολών</a></li>
					<li><a href="folder.jsp">Ανάγνωση φακέλων</a></li>
				<% } else if (sInfo.isLoggedIn() && sInfo.getMyRole().contains("radiologist")) { %>
					<li><a href="AdminItems.jsp">Έκδοση αναφοράς</a></li>
					<li><a href="folder.jsp">Ανάγνωση φακέλων</a></li>
				<% } %>
				
			</ul>
		</nav>
		<div class="path">
			Βρίσκεστε εδώ: 
			<a href="command.jsp">Έκδοση εντολής</a>	</div>
		<div id="container">
		<h1>Έκδοση εντολής</h1>
		</div>
		<article>
		<%if (sInfo.isLoggedIn() == false || !sInfo.getMyRole().contains("doctor")) { %> <h5>Η σελίδα αυτή είναι διαθέσιμη μόνο σε χρήστες της κατηγορίας "Θεράπων ιατρός".</h5> <% } else { %>
			<section id="search">
				
				<%if (action != null && action == "inserted") { %>
				<h4>Η ακτινολογική εντολή εστάλη με επιτυχία.</h4>
				<% } else { %>
				
				<p>Στη σελίδα αυτή μπορείτε να εκδώσετε ακτινολογική εντολή για τους ασθενείς σας.<br><br>
				Επιλέξτε παρακάτω τον ασθενή που επιθυμείτε (εμφανίζονται <b>μόνο</b> οι ασθενείς σας):</p>
				<form method="post" id="examform" action="Doctor">
				<p>Λίστα ασθενών σας: <%=patients%></p>
				<p>Επιλέξτε τύπο αντινολογικής εντολής: 
					<select name='exam' id='exam'>
						<option value="">Επιλέξτε τύπο εντολής</option>
						<option value="X-ray chest">X-ray chest</option>
						<option value="X-ray hand L">X-ray hand L</option>
						<option value="X-ray hand R">X-ray hand R</option>
						<option value="MRI knee L">MRI knee L</option>
						<option value="MRI knee R">MRI knee R</option>
						<option value="MRI shoulder L">MRI shoulder L</option>
						<option value="MRI shoulder R">MRI shoulder R</option>
					</select>
				<br>
				<br>
				<i>Σημείωση: Στη νέα ακτινολογική εντολή θα προστεθεί αυτόματα η τρέχουσα ημερομηνία και ώρα.</i>
				</p>
				<p><button class="submit" onclick="mysubmExam();">Έκδοση</button></p>
				<input type="hidden" name="action" id="action" value="">
				</form>
				
				<% } %>
				
			</section>
		<% } %>
		</article>
		<footer>
		 &copy; Designed by <strong>Καλλίτσα Τζιουρτζιώτη</strong>
		</footer>
	</body>
</html>
