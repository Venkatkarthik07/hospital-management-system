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
<title>Online Pharmacy</title>
<link rel="stylesheet" href="css/shop.css">
</head>

<body>

<div class="navbar">
    <h2>Online Pharmacy</h2>
    <a href="cart.jsp" class="cart-btn">🛒 Cart</a>
</div>

<div class="container">

<%
Connection conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hospital_db","root","Vasanth@15591");

PreparedStatement ps = conn.prepareStatement("SELECT * FROM medicine WHERE stock > 0");
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<div class="card">

<img src="images/<%= rs.getString("image") %>">

<h3><%= rs.getString("med_name") %></h3>

<p class="rating">⭐ <%= rs.getDouble("rating") %></p>

<p class="price">
₹ <%= rs.getDouble("price") - rs.getDouble("discount") %>
<span class="old">₹ <%= rs.getDouble("price") %></span>
</p>

<form action="CartServlet" method="post">
<input type="hidden" name="medId" value="<%= rs.getInt("med_id") %>">
<input type="number" name="qty" value="1" min="1">
<button class="cart-btn1">Add to Cart</button>
</form>

</div>

<% } %>

</div>

</body>
</html>
