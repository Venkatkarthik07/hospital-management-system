package com.hms.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class AppointmentServlet extends HttpServlet {

    Connection conn;

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital_db",
                "root","Vasanth@15591");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        try {
            String deleteId = req.getParameter("deleteId");

            if(deleteId != null){
                PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM appointment WHERE appointment_id=?");
                ps.setInt(1, Integer.parseInt(deleteId));
                ps.executeUpdate();
            }

            res.sendRedirect("patientHome.jsp");

        } catch(Exception e){
            e.printStackTrace();
        }
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws IOException {

        try {
            PreparedStatement ps = conn.prepareStatement(
            		"INSERT INTO appointment(patient_username,doctor_name,appointment_date,problem,timeslot) VALUES(?,?,?,?,?)");


            ps.setString(1, req.getParameter("patient"));
            ps.setString(2, req.getParameter("doctor"));
            ps.setString(3, req.getParameter("date"));
            ps.setString(4, req.getParameter("problem"));
            ps.setString(5, req.getParameter("slot"));


            ps.executeUpdate();

            res.sendRedirect("patientHome.jsp");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
