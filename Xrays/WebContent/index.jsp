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
				<li><a class="active" href="index.jsp">Αρχική</a></li>
				<% if (sInfo.isLoggedIn() && sInfo.getMyRole().contains("doctor")) { %>
					<li><a href="command.jsp">Έκδοση εντολής</a></li> 
					<li><a href="command_view.jsp">Προβολή εντολών</a></li>
					<li><a href="folder.jsp">Ανάγνωση φακέλων</a></li>
				<% } else if (sInfo.isLoggedIn() && sInfo.getMyRole().contains("radiologist")) { %>
					<li><a href="report.jsp">Εκτέλεση εντολής</a></li>
					<li><a href="not_ready.jsp">Έκδοση αναφοράς</a></li>
					<li><a href="not_ready.jsp">Προβολή αναφορών</a></li>
					<li><a href="folder.jsp">Ανάγνωση φακέλων</a></li>
				<% } %>
				
			</ul>
		</nav>
		<div class="path">
			Βρίσκεστε εδώ: 
			<a href="index.jsp">Αρχική</a>	</div>
		<div id="container">
		<h1>Αρχική σελίδα</h1>
		</div>
		<article>
			<section id="search">				
				<p>Καλώς ήρθατε στη σελίδα της Υγειονομικής Περιφέρειας Αττικής!</p>
				<p>Μπορείτε να κάνετε login στο σύστημα, εισάγοντας τα στοιχεία σας πάνω δεξιά στην ιστοσελίδα μας.<br><br>
				Οι <b>ασθενείς</b> μπορείτε να βλέπετε τις εντολές και τις αναφορές σας.<br><br>
				Οι <b>θεράποντες ιατροί</b> μπορείτε να εκδώσετε ακτινολογικές εντολές ή να επεξεργαστείτε κάποιες παλιές. Επίσης μπορείτε να διαβάσετε
				στοιχεία που έχουν καταχωρηθεί στους ιατρικούς φακέλους των ασθενών σας.<br><br>
				Οι <b>ακτινολόγοι</b> μπορείτε να εκδώσετε ακτινολογικές αναφορές ή να επεξεργαστείτε κάποιες παλιές. Επίσης μπορείτε να διαβάσετε
				στοιχεία που έχουν καταχωρηθεί στους ιατρικούς φακέλους ασθενών που εκτελέσατε ακτινολογική πράξη.<br>
				</p>				
				
				<p>
				<%=content%>
				</p>
			</section>
		</article>
		<footer>
		 &copy; Designed by <strong>Καλλίτσα Τζιουρτζιώτη</strong>
		</footer>
	</body>
</html>
