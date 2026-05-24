package com.hms.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class PatientServlet extends HttpServlet {

    private Connection conn;

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital_db",
                    "root", "Vasanth@15591");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if (action.equals("register"))
            registerPatient(req, res);
        else if (action.equals("login"))
            loginPatient(req, res);
    }

    private void registerPatient(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String username = req.getParameter("username");

            PreparedStatement check = conn.prepareStatement(
                    "SELECT * FROM patient WHERE username=?");
            check.setString(1, username);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                req.setAttribute("error", "Username already exists!");
                RequestDispatcher rd = req.getRequestDispatcher("patientRegister.jsp");
                rd.forward(req, res);
                return;
            }

            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO patient(fullname,username,password,email,phone) VALUES(?,?,?,?,?)");

            ps.setString(1, req.getParameter("fullname"));
            ps.setString(2, username);
            ps.setString(3, req.getParameter("password"));
            ps.setString(4, req.getParameter("email"));
            ps.setString(5, req.getParameter("phone"));

            ps.executeUpdate();

            res.sendRedirect("patientLogin.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void loginPatient(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM patient WHERE username=? AND password=?");

            ps.setString(1, req.getParameter("username"));
            ps.setString(2, req.getParameter("password"));

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("username", rs.getString("username"));
                res.sendRedirect("patientHome.jsp");
            } else {
                req.setAttribute("error", "Invalid User Credentials");
                RequestDispatcher rd = req.getRequestDispatcher("patientLogin.jsp");
                rd.forward(req, res);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        if ("logout".equals(req.getParameter("action"))) {
            req.getSession().invalidate();
            res.sendRedirect("login.jsp");
        }
    }
}
