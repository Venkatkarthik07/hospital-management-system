<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Registration</title>

<link rel="stylesheet" href="css/patientRegister.css">

</head>
<body>

<div class="container">

<h2>Patient Registration</h2>

<% if(request.getAttribute("error") != null){ %>
    <div class="error"><%= request.getAttribute("error") %></div>
<% } %>

<form action="PatientServlet" method="post">

<input type="hidden" name="action" value="register">

<input type="text" name="fullname" placeholder="Full Name" required>
<input type="text" name="username" placeholder="Username" required>
<input type="password" name="password" placeholder="Password" required>
<input type="email" name="email" placeholder="Email" required>
<input type="text" name="phone" placeholder="Phone" required>

<button type="submit">Register</button>

<p>Already have account? <a href="patientLogin.jsp">Login</a></p>

</form>

</div>

</body>
</html>
