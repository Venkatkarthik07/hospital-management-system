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
<meta charset="UTF-8">
<title>Checkout</title>
<link rel="stylesheet" href="css/checkout.css">
</head>

<body>

<h2>Checkout</h2>

<%
Connection conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hospital_db","root","Vasanth@15591");

/* GET CART TOTAL */
PreparedStatement ps = conn.prepareStatement(
"SELECT SUM(m.price*c.quantity) AS total FROM cart c JOIN medicine m ON c.med_id=m.med_id WHERE username=?");

ps.setString(1,user);
ResultSet rs = ps.executeQuery();
rs.next();
double total = rs.getDouble("total");
%>

<h3>Total Amount: ₹ <%= total %></h3>

<form action="OrderServlet" method="post">

<h3>Delivery Address</h3>

<textarea name="address" required></textarea>
<input type="text" name="city" placeholder="City" required>
<input type="text" name="pincode" placeholder="Pincode" required>

<h3>Payment Method</h3>

<select name="payment">
<option>Cash On Delivery</option>
<option>UPI</option>
<option>Card</option>
</select>

<button type="submit">Place Order</button>

</form>

</body>
</html>
