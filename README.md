# Hospital Management System 🏥💻

A robust and secure **Java EE (JSP & Servlets)** web application designed to streamline diagnostic and clinical workflows in healthcare centers. This platform provides specialized modules for administrators, patients, doctors, and pharmacists, and features integrated pharmacy shopping and payment handling.

---

## 🌟 Modules & Features

- **Admin Module**: Manage patients, doctors, and active appointments with a high-level visual control panel.
- **Patient Module**: Register, log in, schedule doctor appointments in specific timeslots, edit profiles, and view appointment history.
- **Doctor Module**: Specialized login to view scheduled appointments, patient diagnostic complaints, and manage active consultation lists.
- **Pharmacy & Shopping Module**: Built-in shop where patients can browse stock-tracked medicines, add items to a cart, input delivery addresses, and perform online mockup UPI payments.
- **Pharmacist Module**: Dedicated login for pharmacists to track stock counts, manage medicine supplies, and update prices in real-time.

---

## 🏗️ Technical Stack

- **Front-end**: JSP (JavaServer Pages), CSS (clean custom dark and light themes), and JavaScript.
- **Back-end Controllers**: Java Servlets (Java EE Web API).
- **Database**: MySQL Server (relational JDBC connection).
- **IDE Compatibility**: Pre-configured for Eclipse Enterprise IDE.

---

## 🗄️ Database Setup (MySQL)

The application utilizes JDBC to connect to a local MySQL server. Follow these steps to initialize your database:

### 1. Database Connection Config
The servlets are configured to connect using the following credentials:
- **JDBC Driver**: `com.mysql.cj.jdbc.Driver`
- **Database URL**: `jdbc:mysql://localhost:3306/hospital_db`
- **Username**: `root`
- **Password**: `Vasanth@15591`

*Note: If you have different MySQL credentials, update them inside the `init()` method in each Java Servlet class under `src/main/java/com/hms/servlet/`.*

### 2. Initialize Schema & Tables
We have provided a comprehensive `schema.sql` file in the project root containing all table definitions, relationships, and testing seed data.
1. Open **MySQL Workbench** or your preferred MySQL client.
2. Run the code from `schema.sql` to create `hospital_db` and all required tables.
3. The script automatically inserts testing accounts:
   - **Super Admin**: Username: `admin` | Password: `admin123`
   - **Pharmacist**: Username: `pharmacist` | Password: `pharm123`
   - **Doctor**: Username: `dr_smith` | Password: `doctor123`
   - Preloads a diverse set of medicines into the pharmacy database.

---

## 🚀 Execution & Setup Steps

### Method 1: Running inside Eclipse IDE (Recommended)

1. Open **Eclipse Enterprise Edition** (Eclipse IDE for Enterprise Java and Web Developers).
2. Click **File -> Import -> Existing Projects into Workspace**.
3. Select this project root folder as the directory and click **Finish**.
4. Right-click the project name in Eclipse, go to **Build Path -> Configure Build Path -> Libraries -> Add External JARs**.
5. Add the **`mysql-connector-j-x.x.x.jar`** (MySQL JDBC Driver) and click Apply.
6. Configure a Web Server (e.g., **Apache Tomcat 9 or 10**) inside Eclipse.
7. Right-click the project, select **Run As -> Run on Server**, and choose your Tomcat instance.
8. Access the portal locally via `http://localhost:8080/HOSPITAL-MANAGEMENT-SYSTEM-main/login.jsp`.

### Method 2: Running Standalone via Apache Tomcat

1. Compile the Java files inside `src/main/java/` (Note: pre-compiled classes are already present under `build/classes/`).
2. Verify that your compiled Servlet `.class` files are placed inside `src/main/webapp/WEB-INF/classes/com/hms/servlet/`.
3. Package the `src/main/webapp/` directory as a Web Archive (`.war`) file (e.g. `hospital.war`).
4. Copy the `.war` file and paste it into the `webapps/` folder of your standalone **Apache Tomcat** installation.
5. Download the MySQL JDBC driver jar and place it inside Tomcat's `lib/` directory.
6. Start Tomcat (`bin/startup.bat` on Windows).
7. Access the application in your browser at `http://localhost:8080/hospital/login.jsp`.
