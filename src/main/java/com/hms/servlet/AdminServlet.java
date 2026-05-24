package com.hms.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AdminServlet extends HttpServlet {

    Connection conn;

    /* ================= DATABASE CONNECTION ================= */
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

    /* ================= MAIN CONTROLLER ================= */
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        try {

            /* ---------- ADMIN LOGIN ---------- */
            if(req.getParameter("username") != null){

                String username = req.getParameter("username");
                String password = req.getParameter("password");

                PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM admin WHERE username=? AND password=?");

                ps.setString(1, username);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if(rs.next()){

                    String role = rs.getString("role");

                    HttpSession session = req.getSession();
                    session.setAttribute("admin", username);
                    session.setAttribute("role", role);

                    if(role.equals("SUPER_ADMIN")){
                        res.sendRedirect("adminDashboard.jsp");
                    } else {
                        res.sendRedirect("pharmacyDashboard.jsp");
                    }

                } else {
                    req.setAttribute("error","Invalid Admin Credentials");
                    req.getRequestDispatcher("adminLogin.jsp").forward(req,res);
                }
            }

            /* ---------- DELETE PATIENT ---------- */
            else if(req.getParameter("deletePatient") != null){

                PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM patient WHERE patient_id=?");

                ps.setInt(1, Integer.parseInt(req.getParameter("deletePatient")));
                ps.executeUpdate();

                res.sendRedirect("adminDashboard.jsp");
            }

            /* ---------- DELETE DOCTOR ---------- */
            else if(req.getParameter("deleteDoctor") != null){

                PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM doctor WHERE doctor_id=?");

                ps.setInt(1, Integer.parseInt(req.getParameter("deleteDoctor")));
                ps.executeUpdate();

                res.sendRedirect("adminDashboard.jsp");
            }

            /* ---------- DELETE APPOINTMENT ---------- */
            else if(req.getParameter("deleteAppointment") != null){

                PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM appointment WHERE appointment_id=?");

                ps.setInt(1, Integer.parseInt(req.getParameter("deleteAppointment")));
                ps.executeUpdate();

                res.sendRedirect("adminDashboard.jsp");
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }

    /* ================= LOGOUT ================= */
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws IOException {

        if("logout".equals(req.getParameter("action"))){
            req.getSession().invalidate();
            res.sendRedirect("login.jsp");
        }
    }
}
