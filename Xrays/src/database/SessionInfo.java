package database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/* Plirofories pou sxetizontai me to session kai to xristi pou exei kanei login.
 * Tis xreiazomaste gia na exoume apeutheias prosvasi mesw tou session sto xristi
 * kai na apofeugoume tis askopes anazitiseis mesa ston kodika. 
*/

public class SessionInfo 
{
	private boolean loggedIn; //einai true an kapoios xristis einai loggedIn, alliws false
	private String role;	  //rolos tou xristi
	private String username;	  //email tou xristi (unique)
	private Integer userId;	  //userId tou xristi (unique)
	private Integer doctorId;
	private Integer patientId;
	private Integer radiologistId;
	
	//Constructor gia arxikopoiisi sti default periptwsi
	public SessionInfo() {
		super();
		loggedIn = false;
		role = null;
		username = null;
		userId = (int)-1;
		doctorId = (int)-1;
		patientId = (int)-1;
		radiologistId = (int)-1;
	}
	
	public boolean isLoggedIn() {
		return loggedIn;
	}
	public void setLoggedIn(boolean loggedIn) {
		this.loggedIn = loggedIn;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getDoctorId() {
		return doctorId;
	}
	public Integer getPatientId() {
		return patientId;
	}
	public Integer getRadiologistId() {
		return radiologistId;
	}
	public String getMyRole() {
		String ret = new String();
		if (role.equals("admin"))
			ret = "Διαχειριστής‚ (admin)";
		else if (role.equals("patient"))
			ret = "Ασθενής‚ (patient)";
		else if (role.equals("doctor"))
			ret = "Θεράπων ιατρός‚ (doctor)";
		else if (role.equals("radiologist"))
			ret = "Ακτινολόγος‚ (radiologist)";
		return ret;
	}
	public boolean checkLogin(String username, String password)
	{
		loggedIn = false;
		doctorId = (int)-1;
		patientId = (int)-1;
		radiologistId = (int)-1;
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();
			
			// Query to select users
			String sql = "SELECT * "
					+ "FROM user "
					+ "WHERE username = '" + username + "'"
					+ "AND password = '" + password + "'";
			
			Statement stmt = con.createStatement();

			// Execute the insert command using executeUpdate()
			// to make changes in database
			ResultSet rs = stmt.executeQuery(sql);
			// Get results
			try {
				while(rs.next()) {
				    //Display values
					loggedIn = true;
					role = rs.getString("user.type");
					this.username = rs.getString("user.username");
					userId = rs.getInt("user.idUser");
					if (role.contentEquals("doctor"))
						doctorId =  rs.getInt("user.Doctor_idDoctor");
					else if (role.contentEquals("patient"))
						patientId =  rs.getInt("user.Patient_idPatient");
					else if (role.contentEquals("radiologist"))
						radiologistId =  rs.getInt("user.Radiologist_idRadiologist");
				 }
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			// Close all the connections
			stmt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {	
		}
		return loggedIn;
	}
	public String getDoctorPatients()
	{
		String res = "<select name='patient_id' id='patient_id'>\n";
		res += "<option value=''>Επιλογή ασθενή</option>\n";
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			// Query to display details of all customers
			String sql = "SELECT * "
					+ "FROM doctor, patient, patient_has_doctor "
					+ "WHERE doctor.idDoctor = patient_has_doctor.Doctor_idDoctor "
					+ "AND patient.idPatient = patient_has_doctor.Patient_idPatient "
					+ "AND doctor.idDoctor = " + this.getDoctorId();

			Statement stmt = con.createStatement();

			// Execute the insert command using executeUpdate()
			// to make changes in database
			ResultSet rs = stmt.executeQuery(sql);
			// Get results
			try {
				while (rs.next()) {
					// Display values
					String fullname = rs.getString("patient.name") + " " + rs.getString("patient.surname");
					res += "<option value='" + rs.getString("patient.idPatient") + "'>" + fullname + "</option>\n";
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// Close all the connections
			stmt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			res += "</select>\n";
		}
		return res;
	}
	public int runInsert(String command, String checker, String checker_pk)
	{
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			String sql = command;
			Statement stmt = con.createStatement();

			// Execute the insert command using executeUpdate()
			// to make changes in database
			stmt.executeUpdate(sql);
			// Close all the connections
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
		
		int id = -1;
		//Return the id of the new entry
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			// Query to display details of all customers
			String sql = checker;

			Statement stmt = con.createStatement();

			// Execute the insert command using executeUpdate()
			// to make changes in database
			ResultSet rs = stmt.executeQuery(sql);
			// Get results
			try {
				while (rs.next()) {
					// Display values
					id = (Integer)rs.getInt(checker_pk);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// Close all the connections
			stmt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	
	public void updateFolderHasCommand(int patientId, int commandId)
	{
		int folderId = -1;
		//Return the id of the new entry
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			// Query to display details of all customers
			String sql = "SELECT idFolder FROM folder WHERE Patient_idPatient = " + patientId;
			Statement stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(sql);
			// Get results
			try {
				while (rs.next()) {
					// Display values
					folderId = (Integer)rs.getInt("idFolder");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// Close all the connections
			stmt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			String sql = "INSERT INTO folder_has_command VALUES (NULL, " + folderId + ", " + commandId + ")";
			Statement stmt = con.createStatement();

			// Execute the insert command using executeUpdate()
			// to make changes in database
			stmt.executeUpdate(sql);
			// Close all the connections
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getCommands(int doctorId)
	{
		String res = "<table class='mytable'>\n";
		res += "<tr>"
				+ "<th>&nbsp;</th>\n"
				+ "<th>Όνομα</th>\n"
				+ "<th>Επίθετο</th>\n"
				+ "<th>Α.Δ.Τ.</th>\n"
				+ "<th>Περιγραφή εντολής</tH>\n"
				+ "<th>Ημ/νία δημιουργίας</th>\n"
				+ "</tr>\n";
		//Return the id of the new entry
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			// Query to display details of all customers
			String sql = "SELECT * FROM doctor_issues_command, patient, command "
					+ "WHERE doctor_issues_command.Patient_idPatient = patient.idPatient "
					+ "AND doctor_issues_command.Command_idCommand = command.idCommand "
					+ "AND doctor_issues_command.Doctor_idDoctor = " + doctorId;
			Statement stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(sql);
			// Get results
			try {
				while (rs.next()) {
					// Display values
					res += "<tr>"
						+ "<td> <input type='radio' name='id' value=" + rs.getInt("id") + " required></td>\n"
						+ "<td>" + rs.getString("patient.name") + "</td>\n"
						+ "<td>" + rs.getString("patient.surname") + "</td>\n"
						+ "<td>" + rs.getString("patient.adt") + "</td>\n"
						+ "<td>" + rs.getString("command.description") + "</td>\n"
						+ "<td>" + rs.getString("issue_date") + "</td>\n"
						+ "</tr>\n";
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// Close all the connections
			stmt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		res += "</table>";
		return res;
	}
	public String getCommand(int doctorId, int id)
	{
		String res = "<table class='mytable'>\n";
		res += "<tr>"
				+ "<th>Όνομα</th>\n"
				+ "<th>Επίθετο</th>\n"
				+ "<th>Α.Δ.Τ.</th>\n"
				+ "<th>Περιγραφή εντολής</tH>\n"
				+ "<th>Ημ/νία δημιουργίας</th>\n"
				+ "</tr>\n";
		//Return the id of the new entry
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			// Query to display details of all customers
			String sql = "SELECT * FROM doctor_issues_command, patient, command "
					+ "WHERE doctor_issues_command.Patient_idPatient = patient.idPatient "
					+ "AND doctor_issues_command.Command_idCommand = command.idCommand "
					+ "AND doctor_issues_command.Doctor_idDoctor = " + doctorId 
					+ " AND id = " + id;
			Statement stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(sql);
			// Get results
			try {
				while (rs.next()) {
					// Display values
					res += "<tr>"
						+ "<td>" + rs.getString("patient.name") + "</td>\n"
						+ "<td>" + rs.getString("patient.surname") + "</td>\n"
						+ "<td>" + rs.getString("patient.adt") + "</td>\n"
						+ "<td> <i>Τρέχουσα: " + rs.getString("description") + "</i><br><br><select name='exam' id='exam'>"
						+ "<option value=\"\">Επιλέξτε τύπο εντολής</option>"
						+ "<option value=\"X-ray chest\">X-ray chest</option>"
						+ "<option value=\"X-ray hand L\">X-ray hand L</option>"
						+ "<option value=\"X-ray hand R\">X-ray hand R</option>"
						+ "<option value=\"MRI knee L\">MRI knee L</option>"
						+ "<option value=\"MRI knee R\">MRI knee R</option>"
						+ "<option value=\"MRI shoulder L\">MRI shoulder L</option>"
						+ "<option value=\"MRI shoulder R\">MRI shoulder R</option>"
						+ "</select></td>\n"
						+ "<td>" + rs.getString("issue_date") + "</td>\n"
						+ "</tr>\n";
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// Close all the connections
			stmt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		res += "</table>\n<input type=\"hidden\" name=\"id\" value=" + id + ">\n";
		return res;
	}
	
	public void updateDescription (int doctorId, int id, String newDescription)
	{
		int idCommand = -1;
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			// Query to display details of all customers
			String sql = "SELECT idCommand FROM doctor_issues_command, patient, command "
					+ "WHERE doctor_issues_command.Patient_idPatient = patient.idPatient "
					+ "AND doctor_issues_command.Command_idCommand = command.idCommand "
					+ "AND doctor_issues_command.Doctor_idDoctor = " + doctorId 
					+ " AND id = " + id;
			Statement stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(sql);
			// Get results
			try {
				while (rs.next()) {
					// Display values
					idCommand = rs.getInt("idCommand");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// Close all the connections
			stmt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			String sql = "UPDATE command SET description = '" + newDescription + "' WHERE idCommand = " + idCommand;
			Statement stmt = con.createStatement();

			// Execute the insert command using executeUpdate()
			// to make changes in database
			stmt.executeUpdate(sql);
			// Close all the connections
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getRadiologistPatients()
	{
		String res = "<select name='patient_id' id='patient_id'>\n";
		res += "<option value=''>Επιλογή ασθενή</option>\n";
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			// Query to display details of all customers
			String sql = "SELECT * "
					+ "FROM radiologist, patient, radiologist_issues_report "
					+ "WHERE radiologist.idRadiologist = radiologist_issues_report.Radiologist_idRadiologist "
					+ "AND patient.idPatient = radiologist_issues_report.Patient_idPatient "
					+ "AND radiologist.idRadiologist = " + this.getRadiologistId();

			Statement stmt = con.createStatement();

			// Execute the insert command using executeUpdate()
			// to make changes in database
			ResultSet rs = stmt.executeQuery(sql);
			// Get results
			try {
				while (rs.next()) {
					// Display values
					String fullname = rs.getString("patient.name") + " " + rs.getString("patient.surname");
					res += "<option value='" + rs.getString("patient.idPatient") + "'>" + fullname + "</option>\n";
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// Close all the connections
			stmt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			res += "</select>\n";
		}
		return res;
	}
	public String getFolderContentPrimary()
	{
		int counter = 0;
		String res = "";
		if (this.role.contains("doctor"))
			res = "<h2>Εντολές ασθενών</h2>"
				+ "<table class='mytable'>\n";
		else if (this.role.contains("radiologist"))
				res = "<h2>Αναφορές ασθενών</h2>"
					+ "<table class='mytable'>\n";
		res += "<tr>"
				+ "<th>ID φακέλου</th>\n"
				+ "<th>Όνομα</th>\n"
				+ "<th>Επίθετο</th>\n"
				+ "<th>Α.Δ.Τ.</th>\n"
				+ "<th>Ημ/νία δημιουργίας</tH>\n";
		if (this.role.contains("doctor"))
				res += "<th>Περιγραφή εντολής</th>\n"
					+ "</tr>\n";
		else if (this.role.contains("radiologist"))
			res += "<th>Περιγραφή αναφοράς</th>\n"
				+ "</tr>\n";
		
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			// Query to display details of all customers
			String sql = "";
			if (this.role.contains("doctor"))
				sql = "SELECT * "
					+ "FROM folder, patient, folder_has_command, command, doctor_issues_command "
					+ "WHERE folder.Patient_idPatient = patient.idPatient "
					+ "AND doctor_issues_command.Command_idCommand = command.idCommand "
					+ "AND folder_has_command.Folder_idFolder = folder.idFolder "
					+ "AND folder_has_command.Command_idCommand = command.idCommand "
					+ "and folder.Patient_idPatient in (SELECT phd.Patient_idPatient "
					+ "FROM patient_has_doctor phd "
					+ "WHERE phd.Doctor_idDoctor = " + this.getDoctorId() + ")";
			else if (this.role.contains("radiologist"))
				sql = "SELECT * "
						+ "FROM folder, patient, folder_has_report, report, radiologist_issues_report "
						+ "WHERE folder.Patient_idPatient = patient.idPatient "
						+ "AND radiologist_issues_report.Report_idReport = report.idReport "
						+ "AND folder_has_report.Folder_idFolder = folder.idFolder "
						+ "AND folder_has_report.Report_idReport = report.idReport "
						+ "and folder.Patient_idPatient in ("
						+ "SELECT e.patient_idPatient "
						+ "FROM executes e "
						+ "WHERE radiologist_idRadiologist = " + this.getRadiologistId()
						+ " UNION "
						+ "SELECT rir.patient_idPatient "
						+ "FROM radiologist_issues_report rir "
						+ "WHERE radiologist_idRadiologist = " + this.getRadiologistId()
						+ ")";

			Statement stmt = con.createStatement();

			// Execute the insert command using executeUpdate()
			// to make changes in database
			ResultSet rs = stmt.executeQuery(sql);
			// Get results
			try {
				while (rs.next()) {
					// Display values
					res += "<tr>"
						+ "<td>" + rs.getString("idFolder") + "</td>\n"
						+ "<td>" + rs.getString("patient.name") + "</td>\n"
						+ "<td>" + rs.getString("patient.surname") + "</td>\n"
						+ "<td>" + rs.getString("patient.adt") + "</td>\n"
						+ "<td>" + rs.getString("issue_date") + "</td>\n"
						+ "<td>" + rs.getString("description") + "</td>\n"
						+ "</tr>\n";		
					counter++;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// Close all the connections
			stmt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			res += "</table>\n<br>";
		}
		if (counter == 0)
			res = "<h2>Εντολές ασθενών</h2><i>Δε βρέθηκαν εγγραφές.</i><br><br>";
		return res;
	}
	public String getFolderContentSecondary()
	{
		int counter = 0;
		String res = "";
		if (this.role.contains("doctor"))
			res = "<h2>Αναφορές ασθενών</h2>"
				+ "<table class='mytable'>\n";
		else if (this.role.contains("radiologist"))
				res = "<h2>Εντολές ασθενών</h2>"
					+ "<table class='mytable'>\n";
		res += "<tr>"
				+ "<th>ID φακέλου</th>\n"
				+ "<th>Όνομα</th>\n"
				+ "<th>Επίθετο</th>\n"
				+ "<th>Α.Δ.Τ.</th>\n"
				+ "<th>Ημ/νία δημιουργίας</tH>\n";
		if (this.role.contains("doctor"))
				res += "<th>Περιγραφή αναφοράς</th>\n"
					+ "</tr>\n";
		else if (this.role.contains("radiologist"))
			res += "<th>Περιγραφή εντολής</th>\n"
				+ "</tr>\n";
		
		try {
			// Initialize the database
			Connection con = DatabaseConnection.initializeDatabase();

			// Query to display details of all customers
			String sql = "";
			if (this.role.contains("doctor"))
				sql = "SELECT * "
						+ "FROM folder, patient, folder_has_report, report, radiologist_issues_report "
						+ "WHERE folder.Patient_idPatient = patient.idPatient "
						+ "AND radiologist_issues_report.Report_idReport = report.idReport "
						+ "AND folder_has_report.Folder_idFolder = folder.idFolder "
						+ "AND folder_has_report.Report_idReport = report.idReport "
						+ "and folder.Patient_idPatient in (SELECT phd.Patient_idPatient "
						+ "FROM patient_has_doctor phd "
						+ "WHERE phd.Doctor_idDoctor = " + this.getDoctorId() + ")";
			else if (this.role.contains("radiologist"))
				sql = "SELECT * "
						+ "FROM folder, patient, folder_has_command, command, doctor_issues_command "
						+ "WHERE folder.Patient_idPatient = patient.idPatient "
						+ "AND folder_has_command.Folder_idFolder = folder.idFolder "
						+ "AND doctor_issues_command.Command_idCommand = command.idCommand "
						+ "AND folder_has_command.Command_idCommand = command.idCommand "
						+ "and folder.Patient_idPatient in ("
						+ "SELECT e.patient_idPatient "
						+ "FROM executes e "
						+ "WHERE radiologist_idRadiologist = " + this.getRadiologistId()
						+ " UNION "
						+ "SELECT rir.patient_idPatient "
						+ "FROM radiologist_issues_report rir "
						+ "WHERE radiologist_idRadiologist = " + this.getRadiologistId()
						+ ")";

			Statement stmt = con.createStatement();

			// Execute the insert command using executeUpdate()
			// to make changes in database
			ResultSet rs = stmt.executeQuery(sql);
			// Get results
			try {
				while (rs.next()) {
					// Display values
					res += "<tr>"
						+ "<td>" + rs.getString("idFolder") + "</td>\n"
						+ "<td>" + rs.getString("patient.name") + "</td>\n"
						+ "<td>" + rs.getString("patient.surname") + "</td>\n"
						+ "<td>" + rs.getString("patient.adt") + "</td>\n"
						+ "<td>" + rs.getString("issue_date") + "</td>\n"
						+ "<td>" + rs.getString("description") + "</td>\n"
						+ "</tr>\n";
					counter++;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// Close all the connections
			stmt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			res += "</table>\n";
		}
		if (counter == 0)
			res = "<h2>Αναφορές ασθενών</h2><i>Δε βρέθηκαν εγγραφές.</i><br>";

		return res;
	}
}
