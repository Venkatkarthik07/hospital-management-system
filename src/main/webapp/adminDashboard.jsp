<%@ page import="java.sql.*" %>

<%
String admin = (String) session.getAttribute("admin");
String role = (String) session.getAttribute("role");

if(admin == null || !role.equals("SUPER_ADMIN")){
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<link rel="stylesheet" href="css/admin.css">

</head>


<body>

<div class="navbar">
    Welcome Admin: <%= admin %>
    <a href="AdminServlet?action=logout" style="color:white;">Logout</a>
</div>

<%
Connection conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hospital_db","root","Vasanth@15591");
%>

<!-- ================= PATIENT TABLE ================= -->
<h2>All Patients</h2>

<table>
<tr>
<th>ID</th>
<th>Username</th>
<th>Email</th>
<th>Action</th>
</tr>

<%
PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM patient");
ResultSet rs1 = ps1.executeQuery();

while(rs1.next()){
%>

<tr>
<td><%= rs1.getInt("patient_id") %></td>
<td><%= rs1.getString("username") %></td>
<td><%= rs1.getString("email") %></td>

<td>
<form action="AdminServlet" method="post">
<input type="hidden" name="deletePatient" value="<%= rs1.getInt("patient_id") %>">
<button class="delete">Delete</button>
</form>
</td>
</tr>

<% } %>
</table>

<!-- ================= DOCTOR TABLE ================= -->
<h2>All Doctors</h2>

<table>
<tr>
<th>ID</th>
<th>Username</th>
<th>Email</th>
<th>Action</th>
</tr>

<%
PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM doctor");
ResultSet rs2 = ps2.executeQuery();

while(rs2.next()){
%>

<tr>
<td><%= rs2.getInt("doctor_id") %></td>
<td><%= rs2.getString("username") %></td>
<td><%= rs2.getString("email") %></td>

<td>
<form action="AdminServlet" method="post">
<input type="hidden" name="deleteDoctor" value="<%= rs2.getInt("doctor_id") %>">
<button class="delete">Delete</button>
</form>
</td>
</tr>

<% } %>
</table>

<!-- ================= APPOINTMENTS ================= -->
<h2>All Appointments</h2>

<table>
<tr>
<th>ID</th>
<th>Patient</th>
<th>Doctor</th>
<th>Date</th>
<th>Slot</th>
<th>Action</th>
</tr>

<%
PreparedStatement ps3 = conn.prepareStatement("SELECT * FROM appointment");
ResultSet rs3 = ps3.executeQuery();

while(rs3.next()){
%>

<tr>
<td><%= rs3.getInt("appointment_id") %></td>
<td><%= rs3.getString("patient_username") %></td>
<td><%= rs3.getString("doctor_name") %></td>
<td><%= rs3.getString("appointment_date") %></td>
<td><%= rs3.getString("timeslot") %></td>

<td>
<form action="AdminServlet" method="post">
<input type="hidden" name="deleteAppointment" value="<%= rs3.getInt("appointment_id") %>">
<button class="delete">Delete</button>
</form>
</td>
</tr>

<% } %>

</table>

</body>
</html>
