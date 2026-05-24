package com.hms.servlet;

import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.mail.*;
import javax.mail.internet.*;



public class DoctorServlet extends HttpServlet {

    Connection conn;

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital_db",
                "root","Vasanth@15591");
        } catch(Exception e){
            e.printStackTrace();
        }
    }

//    protected void doPost(HttpServletRequest req, HttpServletResponse res)
//        throws ServletException, IOException {
//
//        // CASE 1: LOGIN
//        if(req.getParameter("password") != null){
//
//            String username = req.getParameter("username");
//            String password = req.getParameter("password");
//
//            try {
//                PreparedStatement ps = conn.prepareStatement(
//                    "SELECT * FROM doctor WHERE username=? AND password=?");
//
//                ps.setString(1, username);
//                ps.setString(2, password);
//
//                ResultSet rs = ps.executeQuery();
//
//                if(rs.next()){
//                    HttpSession session = req.getSession();
//                    session.setAttribute("doctor", username);
//                    res.sendRedirect("doctorHome.jsp");
//                } else {
//                    req.setAttribute("error","Invalid Doctor Login");
//                    RequestDispatcher rd = req.getRequestDispatcher("doctorLogin.jsp");
//                    rd.forward(req,res);
//                }
//
//            } catch(Exception e){
//                e.printStackTrace();
//            }
//        }
//
//        // CASE 2: SEND EMAIL
//        else if(req.getParameter("emailUser") != null){
//
//            String patientUser = req.getParameter("emailUser");
//
//            try {
//                // GET PATIENT EMAIL
//                PreparedStatement ps = conn.prepareStatement(
//                    "SELECT email FROM patient WHERE username=?");
//
//                ps.setString(1, patientUser);
//                ResultSet rs = ps.executeQuery();
//
//                if(rs.next()){
//                    String toEmail = rs.getString("email");
//
//                    sendMail(toEmail);
//
//                    res.sendRedirect("doctorHome.jsp");
//                }
//
//            } catch(Exception e){
//                e.printStackTrace();
//            }
//        }
//    }

    
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // LOGIN
        if(req.getParameter("password") != null){
            loginDoctor(req, res);
        }

        // SEND EMAIL
        else if(req.getParameter("emailUser") != null){
            sendAppointmentMail(req, res);
        }

        // DELETE APPOINTMENT
        else if(req.getParameter("deleteId") != null){
            deleteAppointment(req, res);
        }
    }
    private void loginDoctor(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM doctor WHERE username=? AND password=?");

            ps.setString(1, req.getParameter("username"));
            ps.setString(2, req.getParameter("password"));

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                HttpSession session = req.getSession();
                session.setAttribute("doctor", req.getParameter("username"));
                res.sendRedirect("doctorHome.jsp");
            } else {
                req.setAttribute("error","Invalid Login");
                req.getRequestDispatcher("doctorLogin.jsp").forward(req,res);
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
    private void sendAppointmentMail(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        try {
            String patientUser = req.getParameter("emailUser");
            String doctorName = req.getParameter("doctorName");
            String date = req.getParameter("date");
            String slot = req.getParameter("slot");

            PreparedStatement ps = conn.prepareStatement(
                "SELECT email FROM patient WHERE username=?");

            ps.setString(1, patientUser);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                String toEmail = rs.getString("email");

                sendMail(toEmail, doctorName, date, slot);

                res.getWriter().println("<script>alert('Email Sent Successfully'); window.location='doctorHome.jsp';</script>");
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
    private void deleteAppointment(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        try {
            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM appointment WHERE appointment_id=?");

            ps.setInt(1, Integer.parseInt(req.getParameter("deleteId")));
            ps.executeUpdate();

            res.sendRedirect("doctorHome.jsp");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
    private void sendMail(String toEmail, String doctor, String date, String slot) throws Exception {

        String fromEmail = "vasanthreddy15591@gmail.com";
        String password = "hvxkignlamikiliu";

        Properties props = new Properties();
        props.put("mail.smtp.auth","true");
        props.put("mail.smtp.starttls.enable","true");
        props.put("mail.smtp.host","smtp.gmail.com");
        props.put("mail.smtp.port","587");

        Session session = Session.getInstance(props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

        msg.setSubject("Appointment Confirmation");

        msg.setText("Hello,\n\nYour appointment is confirmed.\n\n"
            + "Doctor: Dr. " + doctor
            + "\nDate: " + date
            + "\nTime Slot: " + slot
            + "\n\nThank you.");

        Transport.send(msg);
    }

    // EMAIL SENDING METHOD
    private void sendMail(String toEmail) throws Exception {

    	String fromEmail = "vasanthreddy15591@gmail.com";
    	String password = "bjleljtpmltkkmyx";

        Properties props = new Properties();
        props.put("mail.smtp.auth","true");
        props.put("mail.smtp.starttls.enable","true");
        props.put("mail.smtp.host","smtp.gmail.com");
        props.put("mail.smtp.port","587");

        Session session = Session.getInstance(props,
        	    new Authenticator() {
        	        protected PasswordAuthentication getPasswordAuthentication() {
        	            return new PasswordAuthentication(fromEmail, password);
        	        }
        	    });


        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipients(Message.RecipientType.TO,
            InternetAddress.parse(toEmail));

        msg.setSubject("Hospital Appointment Confirmation");

        msg.setText("Hello,\n\nYour appointment with doctor is confirmed.\n\nThank You.");

        Transport.send(msg);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws IOException {

        if("logout".equals(req.getParameter("action"))){
            req.getSession().invalidate();
            res.sendRedirect("login.jsp");
        }
    }
}
