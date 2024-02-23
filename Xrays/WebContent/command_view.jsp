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
	
	String commands = null;
	if (sInfo.isLoggedIn() && sInfo.getMyRole().contains("doctor"))
		commands = sInfo.getCommands(sInfo.getDoctorId());
	
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
					<li><a href="command.jsp">Έκδοση εντολής</a></li> 
					<li><a class="active" href="command_view.jsp">Προβολή εντολών</a></li>
					<li><a href="folder.jsp">Ανάγνωση φακέλων</a></li>
				<% } else if (sInfo.isLoggedIn() && sInfo.getMyRole().contains("radiologist")) { %>
					<li><a href="AdminItems.jsp">Έκδοση αναφοράς</a></li>
					<li><a href="folder.jsp">Ανάγνωση φακέλων</a></li>
				<% } %>
				
			</ul>
		</nav>
		<div class="path">
			Βρίσκεστε εδώ: 
			<a href="command.jsp">Προβολή εντολών</a>	</div>
		<div id="container">
		<h1>Προβολή εντολών</h1>
		</div>
		<article>
		<%if (sInfo.isLoggedIn() == false || !sInfo.getMyRole().contains("doctor")) { %> <h5>Η σελίδα αυτή είναι διαθέσιμη μόνο σε χρήστες της κατηγορίας "Θεράπων ιατρός".</h5> <% } else { %>
			<section id="search">
				
				<%if (action != null && action == "edited") { %>
				<h4>Η ακτινολογική εντολή τροποποιήθηκε με επιτυχία.</h4>
				<% } %>
				
				<%if (action != null && action == "editing") { %>
				<form method="post" id="edited" action="Doctor">
				<%=request.getAttribute("editable") %>
				<input type="hidden" name="action" id="action" value="edited_command">
				<p><input type="submit" class="submit" value="Τροποποίηση">&nbsp; &nbsp; 
				<input type="button" class="cancel" value="Πίσω" onclick="history.back()"></p>
				</form>
				<% } else { %>
				
				<p>Στη σελίδα αυτή μπορείτε να δείτε και να τροποποιήσετε τις ακτινολογικές εντολές που έχετε εκδώσει.</p>
				<form method="post" id="editform" action="Doctor">
				<p><%=commands%></p>
				<br>
				</p>
				<p><input type="button" class="submit" onclick="mysubmCommand();" value="Τροποποίηση">&nbsp; &nbsp; 
				<input type="reset" class="cancel" value="Καθαρισμός"></p>
				<input type="hidden" name="action" id="action" value="">
				<input type="hidden" name="patient_id" id="patient_id" value="">
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
