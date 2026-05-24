<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Login</title>

<link rel="stylesheet" href="css/patientLogin.css">

</head>
<body>

<div class="container">

<h2>Patient Login</h2>

<% if(request.getAttribute("error") != null){ %>
    <div class="error"><%= request.getAttribute("error") %></div>
<% } %>

<form action="PatientServlet" method="post">

<input type="hidden" name="action" value="login">

<input type="text" name="username" placeholder="Username" required>
<input type="password" name="password" placeholder="Password" required>

<button type="submit">Login</button>

<p>New User? <a href="patientRegister.jsp">Register Here</a></p>

</form>

</div>

</body>
</html>
