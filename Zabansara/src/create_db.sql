/*======== CREATING THE USER AND ADDING THE PRIVILEGES ========*/

/*
Log into the root user in mysql and create the admin user
mysql -u root -p
*/
CREATE USER IF NOT EXISTS 'zabansara_admin'@'localhost' IDENTIFIED BY 'zabansaraadminpassword';

GRANT ALL PRIVILEGES ON *.* TO 'zabansara_admin'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;

/*
Log out of the root user and login using the admin credentials
mysql -u parking_admin -p
*/

/*======== CREATING THE DATABASE ========*/
CREATE DATABASE zabansara_db CHARACTER SET utf8
  COLLATE utf8_general_ci;;
USE zabansara_db;

/*======== CREATING THE TABLES  ========*/

/*==== customers ====*/
CREATE TABLE IF NOT EXISTS users
(
	id INT NOT NULL AUTO_INCREMENT,
	role ENUM('admin','teacher', 'student') NOT NULL DEFAULT 'student',
	username VARCHAR(100) NOT NULL,
	password VARCHAR(100) NOT NULL,
	fname VARCHAR(100) NOT NULL,
	lname VARCHAR(100) NOT NULL,
	cellphone VARCHAR(20) NOT NULL,
	email_addr VARCHAR(100) NOT NULL,
	national_code VARCHAR(100),
	student_id VARCHAR(100),
	photo_name VARCHAR(100),
	photo_name2 VARCHAR(100),
	PRIMARY KEY(id)
) ENGINE=INNODB;

/*==== news ====*/
CREATE TABLE IF NOT EXISTS news
(
	id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(200) NOT NULL,
	content TEXT NOT NULL,
	photo_name VARCHAR(100),
	PRIMARY KEY(id)
) ENGINE=INNODB;

/*==== terms ====*/
CREATE TABLE IF NOT EXISTS terms
(
	id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(200) NOT NULL,
	term_start VARCHAR(200) NOT NULL,
	classes_start VARCHAR(200) NOT NULL,
	finals_start VARCHAR(200) NOT NULL,
	term_end VARCHAR(200) NOT NULL,
	PRIMARY KEY(id)
) ENGINE=INNODB;

/*==== levels ====*/
CREATE TABLE IF NOT EXISTS levels
(
	id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(200) NOT NULL,
	PRIMARY KEY(id)
) ENGINE=INNODB;

/*==== availability ====*/
CREATE TABLE IF NOT EXISTS availabilities
(
	term_id INT NOT NULL,
	teacher_id INT NOT NULL,
	schedule_id INT NOT NULL,
	FOREIGN KEY(term_id) REFERENCES terms(id) ON DELETE CASCADE,
	FOREIGN KEY(teacher_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=INNODB;

/*==== class ====*/
CREATE TABLE IF NOT EXISTS classes
(
	id INT NOT NULL AUTO_INCREMENT,
	term_id INT NOT NULL,
	teacher_id INT NOT NULL,
	gender ENUM('boys','girls', 'both') NOT NULL DEFAULT 'boys',
	level_id INT NOT NULL,
	schedule_id INT NOT NULL,
	notes VARCHAR(200) NOT NULL,
	content LONGTEXT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(term_id) REFERENCES terms(id) ON DELETE CASCADE,
	FOREIGN KEY(teacher_id) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY(level_id) REFERENCES levels(id) ON DELETE CASCADE
) ENGINE=INNODB;

/*==== registrations ====*/
CREATE TABLE IF NOT EXISTS registrations
(
	student_id INT NOT NULL,
	class_id INT NOT NULL,
	FOREIGN KEY(student_id) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY(class_id) REFERENCES classes(id) ON DELETE CASCADE
) ENGINE=INNODB;

/*==== exams ====*/
CREATE TABLE IF NOT EXISTS exams
(
	id INT NOT NULL AUTO_INCREMENT,
	type ENUM('midterm','final', 'participation', 'general') NOT NULL,
	title VARCHAR(200),
	notes VARCHAR(200),
	class_id INT DEFAULT 0,
	PRIMARY KEY(id),
	FOREIGN KEY(class_id) REFERENCES classes(id) ON DELETE CASCADE
) ENGINE=INNODB;

/*==== grades ====*/
CREATE TABLE IF NOT EXISTS grades
(
	exam_id INT NOT NULL,
	student_id INT NOT NULL,
	grade VARCHAR(200) NOT NULL,
	notes VARCHAR(200),
	FOREIGN KEY(exam_id) REFERENCES exams(id) ON DELETE CASCADE,
	FOREIGN KEY(student_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=INNODB;

INSERT INTO users (role, username, password, fname, lname, cellphone, email_addr)
VALUE ('admin', 'admin', MD5('apass'), 'admin' , 'admin' , '09177777777', 'admin@admin.com');
INSERT INTO users (role, username, password, fname, lname, cellphone, email_addr, national_code, student_id, photo_name)
VALUE ('student', 'student1', MD5('spass'), 'Ali' , 'Mohammadi' , '09177777777', 'ali@student.org', '2280453361', '97000001' , 'student1.jpg');

INSERT INTO users (role, username, password, fname, lname, cellphone, email_addr, national_code, photo_name)
VALUE ('teacher', 'teacher1', MD5('tpass'), 'Fatemeh' , 'Masoudi' , '09177777777', 'fatemeh@teacher.org', '2280453361', 'teacher1.jpg');
INSERT INTO users (role, username, password, fname, lname, cellphone, email_addr, national_code, photo_name)
VALUE ('teacher', 'teacher2', MD5('tpass'), 'علی' , 'غلامی' , '09177777777', 'ali@teacher.org', '2280453361', 'teacher2.jpg');

