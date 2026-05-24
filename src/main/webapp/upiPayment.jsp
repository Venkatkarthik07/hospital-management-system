<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
int orderId = (int) session.getAttribute("orderId");
double amount = (double) session.getAttribute("amount");

/* CREATE UPI STRING */
String upiString = "upi://pay?pa=vasanthreddy15591@oksbi&pn=HMS Pharmacy&am=" 
                    + amount + "&cu=INR";

/* QR API LINK */
String qrURL = "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=" 
                + java.net.URLEncoder.encode(upiString, "UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UPI Payment</title>

<style>
body { text-align:center; font-family: Arial; }
button { padding:12px 20px; background:#27ae60; color:white; border:none; }
</style>

</head>

<body>

<h2>Scan & Pay via UPI</h2>

<h3>Amount to Pay: ₹ <%= amount %></h3>

<h3 id="timer">Time Remaining: 120 sec</h3>

<img src="<%= qrURL %>" alt="UPI QR Code">

<br><br>

<form action="PaymentServlet" method="post">
<input type="hidden" name="orderId" value="<%= orderId %>">
<button id="payBtn" disabled>Verify Payment</button>
</form>

</body>
</html>



<script>
let time = 120;
let timer = document.getElementById("timer");

let interval = setInterval(() => {
    time--;
    timer.innerHTML = "Time Remaining: " + time + " sec";

    if(time <= 0){
        clearInterval(interval);
        alert("Payment session expired!");
        window.location = "cart.jsp";
    }
}, 1000);
</script>

<script>
setTimeout(() => {
    document.getElementById("payBtn").disabled = false;
}, 10000);
</script>


