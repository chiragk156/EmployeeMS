CREATE TABLE IF NOT EXISTS login (
  	username varchar(50) NOT NULL,
  	password varchar(255) NOT NULL,
    PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS facultydept (
  name varchar(30) NOT NULL,
  address varchar(100) DEFAULT NULL,
  PRIMARY KEY(name)
);

CREATE TABLE IF NOT EXISTS staffdept (
  name varchar(30) NOT NULL,
  address varchar(100) DEFAULT NULL,
  PRIMARY KEY(name)
);

CREATE TABLE IF NOT EXISTS faculty (
  id varchar(20) NOT NULL,
  name varchar(30) NOT NULL,
  email varchar(30) NOT NULL,
  DOJ date NOT NULL,
  GOE int(11) DEFAULT NULL,
  DOB date DEFAULT NULL,
  DOL date DEFAULT NULL,
  remaningLeaves int(11) DEFAULT NULL,
  dept varchar(30) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (dept) REFERENCES facultydept(name)
);

CREATE TABLE IF NOT EXISTS staff (
  id varchar(20) NOT NULL,
  name varchar(30) NOT NULL,
  email varchar(30) NOT NULL,
  DOJ date NOT NULL,
  GOE int(11) DEFAULT NULL,
  DOB date DEFAULT NULL,
  DOL date DEFAULT NULL,
  remaningLeaves int(11) DEFAULT NULL,
  dept varchar(30) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (dept) REFERENCES staffdept(name)
);

CREATE TABLE IF NOT EXISTS hod (
  facultyID varchar(20) NOT NULL,
  dept varchar(30) NOT NULL,
  startdate date NOT NULL,
  PRIMARY KEY (dept),
  FOREIGN KEY (facultyID) REFERENCES faculty(id),
  FOREIGN KEY (dept) REFERENCES facultydept(name)
);

CREATE TABLE IF NOT EXISTS hod_hist (
  facultyID varchar(20) NOT NULL,
  dept varchar(30) NOT NULL,
  startdate date NOT NULL,
  enddate date NOT NULL,
  PRIMARY KEY (dept, facultyID, startdate),
  FOREIGN KEY (facultyID) REFERENCES faculty(id),
  FOREIGN KEY (dept) REFERENCES facultydept(name)
);

CREATE TABLE IF NOT EXISTS asst_reg (
  staffID varchar(20) NOT NULL,
  dept varchar(30) NOT NULL,
  startdate date NOT NULL,
  PRIMARY KEY (dept),
  FOREIGN KEY (staffID) REFERENCES staff(id),
  FOREIGN KEY (dept) REFERENCES staffdept(name)
);

CREATE TABLE IF NOT EXISTS asst_reg_hist (
  staffID varchar(20) NOT NULL,
  dept varchar(30) NOT NULL,
  startdate date NOT NULL,
  PRIMARY KEY (dept),
  FOREIGN KEY (staffID) REFERENCES staff(id),
  FOREIGN KEY (dept) REFERENCES staffdept(name)
);

CREATE TABLE IF NOT EXISTS crossfac (
  facultyID varchar(20) NOT NULL,
  role varchar(30) NOT NULL,
  startdate date NOT NULL,
  PRIMARY KEY (role),
  FOREIGN KEY (facultyID) REFERENCES faculty(id)
);

CREATE TABLE IF NOT EXISTS crossfac_hist (
  facultyID varchar(20) NOT NULL,
  role varchar(30) NOT NULL,
  startdate date NOT NULL,
  enddate date NOT NULL,
  PRIMARY KEY (role, facultyID, startdate),
  FOREIGN KEY (facultyID) REFERENCES faculty(id)
);

CREATE TABLE IF NOT EXISTS crossstaff (
  staffID varchar(20) NOT NULL,
  id varchar(20) NOT NULL,
  startdate date NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (staffID) REFERENCES staff(id)
);

CREATE TABLE IF NOT EXISTS crossstaff_hist (
  staffID varchar(20) NOT NULL,
  id varchar(20) NOT NULL,
  startdate date NOT NULL,
  enddate date NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (staffID) REFERENCES staff(id)
);

CREATE TABLE IF NOT EXISTS deansecy (
  crossstaffID varchar(20) NOT NULL,
  dean varchar(30) NOT NULL,
  FOREIGN KEY (crossstaffID) REFERENCES crossstaff(id),
  FOREIGN KEY (dean) REFERENCES crossfac(role)
);

CREATE TABLE IF NOT EXISTS deptsecy (
  dept varchar(30) NOT NULL,
  crossstaffID varchar(20) NOT NULL,
  FOREIGN KEY (crossstaffID) REFERENCES crossstaff(id),
  FOREIGN KEY (dept) REFERENCES facultydept(name)
);

CREATE TABLE IF NOT EXISTS login_faculty (
  username varchar(50) NOT NULL,
  facultyID varchar(20) NOT NULL,
  PRIMARY KEY (username),
  FOREIGN KEY (username) REFERENCES login(username),
  FOREIGN KEY (facultyID) REFERENCES faculty(id)
);

CREATE TABLE IF NOT EXISTS login_staff (
  username varchar(50) NOT NULL,
  staffID varchar(20) NOT NULL,
  PRIMARY KEY (username),
  FOREIGN KEY (username) REFERENCES login(username),
  FOREIGN KEY (staffID) REFERENCES staff(id)
);

