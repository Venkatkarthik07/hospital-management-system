<%@ page import="java.sql.*" %>

<%
/* ===== SESSION CHECK ===== */
String doctor = (String) session.getAttribute("doctor");
if(doctor == null){
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Doctor Dashboard</title>
<link rel="stylesheet" href="css/doctor.css">
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div>Welcome Dr. <%= doctor %></div>
    <a href="DoctorServlet?action=logout" style="color:white;">Logout</a>
</div>

<h2 style="text-align:center;">Your Appointments</h2>

<table>

<tr>
<th>Patient</th>
<th>Date</th>
<th>Time Slot</th>
<th>Problem</th>
<th>Actions</th>
</tr>

<%
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/hospital_db","root","Vasanth@15591");

    ps = conn.prepareStatement(
        "SELECT * FROM appointment WHERE doctor_name LIKE ?");

    ps.setString(1, "%" + doctor + "%");
    rs = ps.executeQuery();

    while(rs.next()){
%>

<tr>

<td><%= rs.getString("patient_username") %></td>
<td><%= rs.getString("appointment_date") %></td>
<td><%= rs.getString("timeslot") %></td>
<td><%= rs.getString("problem") %></td>

<td>

<!-- SEND EMAIL BUTTON -->
<form action="DoctorServlet" method="post" style="display:inline;">
<input type="hidden" name="emailUser" value="<%= rs.getString("patient_username") %>">
<input type="hidden" name="doctorName" value="<%= doctor %>">
<input type="hidden" name="date" value="<%= rs.getString("appointment_date") %>">
<input type="hidden" name="slot" value="<%= rs.getString("timeslot") %>">
<button type="submit">Send Mail</button>
</form>

<!-- DELETE BUTTON -->
<form action="DoctorServlet" method="post" style="display:inline;">
<input type="hidden" name="deleteId" value="<%= rs.getInt("appointment_id") %>">
<button type="submit" style="background:red;color:white;">Delete</button>
</form>

</td>

</tr>

<%
    }
} catch(Exception e){
    e.printStackTrace();
}
%>

</table>

</body>
</html>
