<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%
String user = (String) session.getAttribute("username");
if(user == null){
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Patient Dashboard</title>
<style>

.buy-btn {
    padding: 10px 15px;
    background: #27ae60;
    color: white;
    text-decoration: none;
    border-radius: 5px;
}
</style>
<link rel="stylesheet" href="css/patientHome.css">
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">Hospital System</div>

    <div class="dropdown">
        👤 <%= user %>
        <div class="dropdown-menu">
            <a href="PatientServlet?action=logout">Logout</a>
        </div>
    </div>
</div>

<div class="container">

<!-- BOOK APPOINTMENT -->
<div class="card">
<h3>Book Appointment</h3>

<form action="AppointmentServlet" method="post">
<input type="hidden" name="patient" value="<%= user %>">

<select name="doctor" required>

<option value="">-- Select Doctor --</option>

<option>Dr. R. Patel (Cardiologist)</option>
<option>Dr. S. Kumar (Neurologist)</option>
<option>Dr. A. Shah (Orthopedic)</option>
<option>Dr. M. Singh (Dermatologist)</option>
<option>Dr. K. Mehta (Pediatrician)</option>
<option>Dr. P. Reddy (ENT Specialist)</option>
<option>Dr. V. Iyer (General Physician)</option>
<option>Dr. N. Joshi (Gastroenterologist)</option>
<option>Dr. T. Verma (Oncologist)</option>
<option>Dr. H. Sharma (Pulmonologist)</option>
<option>Dr. D. Nair (Nephrologist)</option>
<option>Dr. B. Chatterjee (Psychiatrist)</option>
<option>Dr. G. Desai (Endocrinologist)</option>
<option>Dr. F. Khan (Urologist)</option>
<option>Dr. L. Roy (Gynecologist)</option>
<option>Dr. J. Thomas (Radiologist)</option>
<option>Dr. W. Fernandes (Anesthesiologist)</option>
<option>Dr. Y. Banerjee (Rheumatologist)</option>
<option>Dr. O. Kulkarni (Ophthalmologist)</option>
<option>Dr. C. Bhatt (Dentist)</option>
<option>Dr. E. Mishra (General Surgeon)</option>

</select>


<input type="date" name="date" required>
<label>Time Slot</label>
<select name="slot">
    <option>9 AM - 10 AM</option>
    <option>10 AM - 11 AM</option>
    <option>11 AM - 12 PM</option>
    <option>2 PM - 3 PM</option>
    <option>3 PM - 4 PM</option>
</select>


<input type="text" name="problem" placeholder="Problem" required>

<button type="submit">Book</button>
</form>
</div>

<!-- APPOINTMENT LIST -->
<div style="flex:1">
<h3>Your Appointments</h3>

<table>
<tr>
<th>ID</th>
<th>Doctor</th>
<th>Date</th>
<th>Problem</th>
<th>Action</th>
</tr>

<%
Connection conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hospital_db","root","Vasanth@15591");

PreparedStatement ps = conn.prepareStatement(
"SELECT * FROM appointment WHERE patient_username=?");

ps.setString(1,user);
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%= rs.getInt("appointment_id") %></td>
<td><%= rs.getString("doctor_name") %></td>
<td><%= rs.getString("appointment_date") %></td>
<td><%= rs.getString("problem") %></td>

<td>
<form action="AppointmentServlet" method="get">
<input type="hidden" name="deleteId" value="<%= rs.getInt("appointment_id") %>">
<button class="delete-btn">Delete</button>
</form>
</td>
</tr>

<% } %>

</table>
</div>

</div>
<center> <a href="shop.jsp" class="buy-btn">Buy Medicines</a>  </center>
</body>
</html>
