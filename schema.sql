-- =======================================================
-- HOSPITAL MANAGEMENT SYSTEM DATABASE SCHEMA (MySQL)
-- =======================================================

-- Create Database if not exists
CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- 1. Patients Table
CREATE TABLE IF NOT EXISTS patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

-- 2. Doctors Table
CREATE TABLE IF NOT EXISTS doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- 3. Admins/Pharmacists Table
CREATE TABLE IF NOT EXISTS admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL -- 'SUPER_ADMIN' or 'PHARMACIST'
);

-- 4. Appointments Table
CREATE TABLE IF NOT EXISTS appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_username VARCHAR(50) NOT NULL,
    doctor_name VARCHAR(50) NOT NULL,
    appointment_date VARCHAR(50) NOT NULL,
    problem TEXT,
    timeslot VARCHAR(50) NOT NULL,
    FOREIGN KEY (patient_username) REFERENCES patient(username) ON DELETE CASCADE
);

-- 5. Medicine Table
CREATE TABLE IF NOT EXISTS medicine (
    med_id INT AUTO_INCREMENT PRIMARY KEY,
    med_name VARCHAR(100) NOT NULL,
    company VARCHAR(100) NOT NULL,
    price DOUBLE NOT NULL,
    stock INT NOT NULL
);

-- 6. Cart Table
CREATE TABLE IF NOT EXISTS cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    med_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (username) REFERENCES patient(username) ON DELETE CASCADE,
    FOREIGN KEY (med_id) REFERENCES medicine(med_id) ON DELETE CASCADE
);

-- 7. Patient Address Table
CREATE TABLE IF NOT EXISTS address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    full_address TEXT NOT NULL,
    city VARCHAR(50) NOT NULL,
    pincode VARCHAR(20) NOT NULL,
    FOREIGN KEY (username) REFERENCES patient(username) ON DELETE CASCADE
);

-- 8. Orders Table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    total DOUBLE NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    order_date VARCHAR(50) NOT NULL,
    FOREIGN KEY (username) REFERENCES patient(username) ON DELETE CASCADE
);

-- 9. Order Items Table
CREATE TABLE IF NOT EXISTS order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    med_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (med_id) REFERENCES medicine(med_id) ON DELETE CASCADE
);

-- =======================================================
-- SEED DATA FOR TESTING
-- =======================================================

-- Default Admins and Pharmacists
INSERT IGNORE INTO admin (username, password, role) VALUES 
('admin', 'admin123', 'SUPER_ADMIN'),
('pharmacist', 'pharm123', 'PHARMACIST');

-- Default Doctors
INSERT IGNORE INTO doctor (username, password, email) VALUES 
('dr_smith', 'doctor123', 'smith@example.com'),
('dr_jones', 'doctor123', 'jones@example.com');

-- Default Medicines
INSERT IGNORE INTO medicine (med_name, company, price, stock) VALUES 
('Paracetamol', 'GSK', 15.00, 150),
('Amoxicillin', 'Abbott', 45.50, 80),
('Ibuprofen', 'Pfizer', 25.00, 100),
('Aspirin', 'Bayer', 12.00, 200),
('Cough Syrup', 'Dabur', 65.00, 40),
('Multivitamin Capsules', 'Revital', 120.00, 60);
