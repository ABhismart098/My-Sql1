show databases;
use sampledatabase;

select * from customers;



use sampledatabase;
select contactfirstname,city,state,country,creditlimit from customers;
show databases;
use mydatabase;

use mydatabase;
use sampledatabase;
select contactfirstname,creditlimit,creditlimit*0.15,customernumber,customernumber%3 from customers;

select contactfirstname,creditlimit,creditlimit*0.15,customernumber,customernumber%3 from customers where customernumber%3=0;

select contactfirstname,creditlimit from customers where creditlimit=60300;
select contactfirstname,creditlimit from customers where creditlimit<60300;
select contactfirstname,creditlimit from customers where creditlimit<=60300;
select contactfirstname,creditlimit from customers where creditlimit>60300;
select contactfirstname,creditlimit from customers where creditlimit>=60300;
select count(*)from customers;
select contactfirstname,creditlimit from customers where creditlimit!=60300;



select customernumber,contactfirstname,creditlimit,state,country
from customers
order by country,state;

select customernumber,contactfirstname,creditlimit,state,country
from customers
where country='usa' and state='NY' and creditlimit>100000
order by country,state;

select customernumber,contactfirstname,creditlimit,state,country
from customers
where country='usa' and state='NY' or creditlimit>100000
order by country,state;

select customernumber,contactfirstname,creditlimit,state,country
from customers
where country='usa' and state='NY' or creditlimit>100000
order by country,state;



use mydatabase;
desc students;



use sampledatabase;
select * from customers;
select contactfirstname,city,state,country,creditlimit from customers order by creditlimit desc limit 10 offset 2 ;
use mydatabase;
show tables;
create database pratice;
use pratice;

CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL CHECK (age BETWEEN 5 AND 120),
    gender CHAR(1) NOT NULL CHECK (gender IN ('M','F','O')), 
    phone_no BIGINT NOT NULL, 
    email VARCHAR(100) NOT NULL UNIQUE,
    registered_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table course (
course_id int primary key,
Course_name varchar(50) unique not null,
decrption text ,
fees decimal(5,2) not null check(fees>0),
duration int);

-- 1. Create table (only once)
CREATE TABLE course_purchase (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    std_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_id VARCHAR(200) UNIQUE,

    CONSTRAINT fk_std FOREIGN KEY (std_id) REFERENCES student(id)
      ,
    CONSTRAINT fk_crs FOREIGN KEY (course_id) REFERENCES course(course_id)
       
);
SHOW TABLES;
CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL CHECK (age BETWEEN 5 AND 120),
    gender CHAR(1) NOT NULL CHECK (gender IN ('M','F','O')),
    phone_no BIGINT NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    registered_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);





DELIMITER $$

CREATE TRIGGER trg_enrollment_id
BEFORE INSERT ON course_purchase
FOR EACH ROW
BEGIN
    DECLARE sname VARCHAR(100);
    DECLARE cname VARCHAR(50);
    DECLARE ryear INT;

    -- get student first word + registered year
    SELECT 
        SUBSTRING_INDEX(name, ' ', 1),
        YEAR(registered_At)
    INTO sname, ryear
    FROM student
    WHERE id = NEW.std_id;

    -- get course first word
    SELECT 
        SUBSTRING_INDEX(Course_name, ' ', 1)
    INTO cname
    FROM course
    WHERE course_id = NEW.course_id;

    -- set enrollment id
    SET NEW.enrollment_id = CONCAT(sname, '_', cname, '_', ryear);
END$$

DELIMITER ;


INSERT INTO student (id, name, age, gender, phone_no, email, registered_At) VALUES
(1001, 'Simran Anand', 22, 'F', 9876543210, 'simran1001@gmail.com', '2025-01-12 10:00:00'),
(1002, 'Rahul Sharma', 24, 'M', 9876501111, 'rahul1002@outlook.com', '2024-12-05 09:30:00'),
(1003, 'Priya Singh', 21, 'F', 9988776655, 'priya1003@yahoo.com', '2023-11-20 14:45:00'),
(1004, 'Amit Kumar', 23, 'M', 9123456789, 'amit1004@gmail.com', '2024-07-15 11:15:00'),
(1005, 'Neha Verma', 25, 'F', 9234567890, 'neha1005@outlook.com', '2025-05-05 16:22:00'),
(1006, 'Arjun Mehta', 26, 'M', 9001122334, 'arjun1006@yahoo.com', '2022-09-18 08:55:00'),
(1007, 'Sara Khan', 20, 'F', 8112233445, 'sara1007@gmail.com', '2023-03-11 17:10:00'),
(1008, 'Rohit Das', 22, 'M', 8223344556, 'rohit1008@outlook.com', '2025-06-20 12:00:00'),
(1009, 'David Miller', 27, 'M', 8334455667, 'david1009@yahoo.com', '2021-06-01 13:37:00'),
(1010, 'Komal Patil', 24, 'F', 8445566778, 'komal1010@gmail.com', '2024-10-25 19:45:00');


INSERT INTO course (course_id, Course_name, decrption, fees, duration) VALUES
(2001, 'Web Development', 'Full stack website building course', 499.99, 6),
(2002, 'Data Science', 'Learn data analysis, ML, and visualization', 599.50, 8),
(2003, 'Cyber Security', 'Ethical hacking and network protection', 450.00, 5),
(2004, 'Mobile App Development', 'Android and iOS app building', 550.75, 7),
(2005, 'Cloud Computing', 'AWS, Azure and DevOps basics', 620.25, 9);
use pratice;


-- Insert 10 course purchase records (1 per student)
INSERT INTO course_purchase (std_id, course_id) VALUES
(1001, 2001),
(1002, 2002), 
(1003, 2003 ),
(1004, 2004), 
(1005, 2005),
(1006, 2001), 
(1007, 2002),
(1008, 2003),
(1009, 2004),
(1010, 2005);


CREATE TABLE course (
    course_id INT PRIMARY KEY,
    Course_name VARCHAR(50) UNIQUE NOT NULL,
    decrption TEXT,
    fees DECIMAL(5,2) NOT NULL CHECK (fees>0),
    duration INT
);



use pratice;

select * from course;

insert into course_purchase(std_id,course_id)  value (1004,2003);
select * from course_purchase where std_id=1004;

INSERT INTO student (id, name, age, gender, phone_no, email) VALUES
(1011, 'Kabir Roy', 23, 'M', 9102233445, 'kabir1011@gmail.com'),
(1012, 'Isha Gupta', 22, 'F', 9203344556, 'isha1012@outlook.com'),
(1013, 'Manoj Tripathy', 24, 'M', 9304455667, 'manoj1013@yahoo.com'),
(1014, 'Alina D\'Costa', 21, 'F', 9405566778, 'alina1014@gmail.com'),
(1015, 'Ravi Naik', 25, 'M', 9506677889, 'ravi1015@outlook.com');




INSERT INTO course (course_id, Course_name, decrption, fees, duration) VALUES
(2006, 'AI Fundamentals', 'Introduction to artificial intelligence and basics', 300.00, 4),
(2007, 'Machine Learning', 'Supervised, unsupervised and model training concepts', 520.00, 7),
(2008, 'Frontend Design', 'HTML, CSS, JS with UI/UX responsive skills', 250.00, 3),
(2009, 'Backend Engineering', 'Server, API, database connection and logic', 480.00, 6),
(2010, 'Blockchain Basics', 'Crypto, decentralized apps and ledger concept', 400.00, 5);

select * from INSERT INTO course (course_id, Course_name, decrption, fees, duration) VALUES
(2006, 'AI Fundamentals', 'Introduction to artificial intelligence and basics', 300.00, 4),
(2007, 'Machine Learning', 'Supervised, unsupervised and model training concepts', 520.00, 7),
(2008, 'Frontend Design', 'HTML, CSS, JS with UI/UX responsive skills', 250.00, 3),
(2009, 'Backend Engineering', 'Server, API, database connection and logic', 480.00, 6),
(2010, 'Blockchain Basics', 'Crypto, decentralized apps and ledger concept', 400.00, 5);



use pratice;
select * from course_purchase;
select s.id, s.name,pc.enrollement_id from student s
inner join course_purchase pc on s.id=pc.std_id
order by s.id;



select * from student s
inner join course_purchase pc on s.id=pc.std_id
order by s.id;



select * from student s
left join course_purchase pc on s.id=pc.std_id
order by s.id;


SELECT *
FROM student s
INNER JOIN course_purchase pc ON s.id = pc.std_id
INNER JOIN course c ON pc.course_id = c.course_id
ORDER BY s.id;

SELECT s.id,c.course_name,pc.enrollment_id,c.fees,c.duration
FROM student s
INNER JOIN course_purchase pc ON s.id = pc.std_id
INNER JOIN course c ON pc.course_id = c.course_id
ORDER BY s.id;

select * from student s
left join course_purchase pc on s.id=pc.std_id
order by s.id;


-- only left join data
select * from student s
left join course_purchase pc on s.id=pc.std_id
where pc.std_id is null
order by s.id;


-- right join 
select * from course_purchase pc
 right join course c 
 on pc.course_id=c.course_id
 order by c.course_id;
 
 
 
 -- only right Join 
 
 select * from course_purchase pc
 right join course c 
 on pc.course_id=c.course_id
 where pc.course_id is null
 order by pc.course_id;
 
SELECT *
FROM student s
LEFT JOIN course_purchase pc ON s.id = pc.std_id

UNION

SELECT *
FROM student s
RIGHT JOIN course_purchase pc ON s.id = pc.std_id;


create database employee;
use employee;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    job_role VARCHAR(50),
    city VARCHAR(40)
);

INSERT INTO employees VALUES
(5001,'Ananya Rao','QA Engineer','Pune'),
(5002,'Rohan Das','Software Engineer','Bangalore'),
(5003,'Meera Singh','Backend Developer','Hyderabad'),
(5004,'Liam ONeil','Cloud Engineer','Chennai'),
(5005,'Amit Joshi','DevOps Engineer','Mumbai'),
(5006,'Sana Wong','Frontend Developer','Delhi'),
(5007,'Kabir Ali','Security Analyst','Noida'),
(5008,'Priya Nair','Data Engineer','Kochi'),
(5009,'Chris Martin','Product Manager','Gurgaon'),
(5010,'Isha Kapoor','Mobile Developer','Kolkata');

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(120),
    emp_id INT
);

INSERT INTO projects VALUES
(9001,'Banking App Revamp',5001),
(9002,'E-Commerce API',5002),
(9003,'Cloud Migration',5003),
(9004,'DevSecOps Pipeline',5004),
(9005,'Stock Market Analyzer',5005),
(9006,'HRMS Frontend',5006),
(9007,'Threat Monitoring System',5007),
(9008,'Big Data Dashboard',5008),
(9009,'Loan Processing Automation',5009),
(9010,'Travel App',5010);
use employee;


CREATE TABLE trainings (
    training_id INT PRIMARY KEY,
    training_name VARCHAR(100),
    emp_id INT
);
INSERT INTO trainings VALUES
(8001,'Manual Testing',5001),
(8002,'Java Fullstack',5002),
(8003,'Advanced SQL',5003),
(8004,'AWS Solutions',5004),
(8005,'Docker & Kubernetes',5005),
(8006,'React JS',5006),
(8007,'Network Security',5007),
(8008,'Data Analytics',5008),
(8009,'Product Strategy',5009),
(8010,'Android Development',5010);

CREATE TABLE project_training_purchase (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT,
    emp_id INT,
    amount DECIMAL(8,2),
    purchase_date DATE,
    CONSTRAINT fk_proj FOREIGN KEY (project_id) REFERENCES projects(project_id) ,
    CONSTRAINT fk_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id) 
);

INSERT INTO project_training_purchase (project_id,emp_id,amount,purchase_date) VALUES
(9001,5001,300.00,'2025-01-10'),
(9002,5002,450.00,'2025-01-11'),
(9003,5003,250.00,'2025-01-12'),
(9004,5004,700.00,'2025-01-13'),
(9005,5005,520.00,'2025-01-14'),
(9006,5006,320.00,'2025-01-15'),
(9007,5007,900.00,'2025-01-16'),
(9008,5008,410.00,'2025-01-17'),
(9009,5009,650.00,'2025-01-18'),
(9010,5010,280.00,'2025-01-19');

ALTER TABLE trainings
ADD CONSTRAINT fk_emp_training
FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
ON DELETE CASCADE;



use sampledatabase;

show tables;
use sampledatabase;
select * from employees;
 -- self  Join 
 select * from employees e
 inner join employees m  
 on e.employeenumber=m.employeenumber
 ;
 
 select e.employeenumber,e.firstName,e.jobtitle,
 concat("Report to" ,m.jobtitle, "-->", m.firstname,"(",e.reportsto,")") as status from employees e
 inner join employees m  
 on e.reportsto=m.employeenumber
 ;
 
 
 -- group by
select country, count(*) as totalcust, Avg(creditlimit), min(creditlimit),max(creditlimit)
from customers
group by country
having totalcust>5
order by country ;





-- views
show databases;
use mydatabase;



use sampledatabase;
 
-- select contactFirstName,city,state,country,creditLimit
-- from customers
-- where country='USA'
-- order by creditLimit desc
-- limit 10 offset 25;
 
use meraDatabase;
 
-- constraints -> rule
 
-- UIDAI
create table students(
id int primary key auto_increment,
name varchar(255) not null,
gender char(1),
email varchar(255) not null unique,
country varchar(50) default 'INDIA',
mobileNo bigint unique,
age int check(age>=18)
);
 
desc students;
drop table students;
 
# primary key -> not null + unique -> 1 primary key per table
 
insert into students(name,gender,email,mobileNo,age) values
("Gaurav Tiwari",'M','gaurav@gmail.com',8448179215,26);
select * from students;
 
-- foreign key : Data integrity,Normalization
 
create table course(
studentId int,
    courseId int primary key,
    coursename varchar(255),
    price decimal(9,2),
    constraint ducat_enrollment foreign key(studentId) references students(id)
);


use `WE_MySQL@7`;
CREATE TABLE students (
    ducat_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    dob DATE NOT NULL,
    gender char(1) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    duration_in_weeks INT NOT NULL,
    fees DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
create table Student_Course(
ducat_id int,course_id int,
purchase_id int primary key auto_increment, -- 1 student can enroll in same course again and again
startedAt timestamp default current_timestamp,
foreign key(ducat_id) references students(ducat_id),
foreign key(course_id) references courses(course_id)
);
 
insert into students values(19582,'abhishek','yadav','abhisheky220920@gmail.com',8130036352,'2000-09-22','M',now(),now());
insert into courses values(20001,'Java Fullstack','core java ,react,springboot,mysql',30,50000,now());
insert into student_course(ducat_id,course_id,purchase_id) values(19582,20001,600000);
 
select * from students;
select * from student_course order by ducat_id;
select * from courses;
 
INSERT INTO courses (course_name, description, duration_in_weeks, fees)
VALUES
('Python Fullstack', 'Python, Flask, React, MySQL', 28, 45000),
('Data Science', 'Python, ML, DL, Statistics', 32, 65000),
('DevOps', 'AWS, Docker, Kubernetes, CI/CD', 20, 55000),
('MERN Stack', 'MongoDB, Express, React, Node', 26, 48000),
('Cyber Security', 'Ethical hacking, networking, Linux', 24, 50000);
 
INSERT INTO students (ducat_id, first_name, last_name, email, phone, dob, gender)
VALUES
(20278,'gaurav','kumar','gaurav20278@example.com','9876543210','2000-01-01','M'),
(17459,'kritika','sharma','kritika17459@example.com','9876543211','1999-04-11','F'),
(21448,'sourav','singh','sourav21448@example.com','9876543212','1998-06-21','M'),
(21220,'sujal','verma','sujal21220@example.com','9876543213','2001-09-18','M'),
(19432,'abhishek','gupta','abhishek19432@example.com','9876543214','1999-02-14','M'),
(20675,'amit','kumar','amit20675@example.com','9876543215','1997-03-23','M'),
(20951,'varsha','jain','varsha20951@example.com','9876543216','1998-12-08','F'),
(19675,'himanshu','rai','himanshu19675@example.com','9876543217','1997-07-15','M'),
(20264,'parag','mehta','parag20264@example.com','9876543218','1998-09-09','M');
 
 
 
INSERT INTO student_course (ducat_id, course_id)
VALUES
(20278, 20001),
(17459, 20002),
(21448, 20003),
(21220, 20004),
(19432, 20005),
(20675, 20006),
(20951, 20001),
(19675, 20001),
(20264, 20001);
 
insert into student_course(ducat_id,course_id) values(17459,20005),(17459,20001);

-- view
create view student as 
select ducat_id, first_name,last_name,email
from students
where gender = 'm';
select * from student;
/*
In SQL, a View is a virtual table that shows data from one or more real tables, but doesn’t store data itself.

It is created using a saved query and is stored in the database as a definition.

Key points:

It looks like a table, so you can run SELECT on it ✅

It gets data from real tables every time you call it 🔄

It saves complex queries to reuse easily 🧠

No extra storage for data (only the query is saved) 💾❌
When views are useful:

To simplify long queries

To secure data (show only selected columns)

To avoid writing same query again and again

To combine data from multiple tables
*/


-- Stroed Procedures
-- pre-complied query 

/*
Stored Procedures in SQL

A stored procedure is a saved block of SQL code that you can reuse to perform specific tasks in the database.

✅ Main benefits

Reuse queries easily 🔁

Faster execution (compiled by database engine)

Supports parameters (input/output)

Can include logic like IF, loops, etc.

Helps automate database operations

💾 Where it's stored

Inside the database system like MySQL or Microsoft SQL Server.*/
DELIMITER $$

CREATE PROCEDURE getmobilebyid(IN id INT, OUT mobno BIGINT)
BEGIN
    SELECT phone INTO mobno FROM students WHERE ducat_id = id;
END $$

DELIMITER ;
SET @mobno = 0;
CALL getmobilebyid(19432, @mobno);
SELECT @mobno;


drop procedure getmobilebyid;



-- create a function procesured


delimiter $$
create procedure increasefee(in cid int, inout per float)
begin
set @oldfee=0;
select fees into @oldFee from courses where course_id=cid;
set @newFee=@oldfee+@oldFee*per;
select @newFee into per;
update courses set fees=@newfee where course_id=cid;


end $$
delimiter ;

set @c_data=0.15;
call increasefee(20001,@c_data);
select concat("new fess is" , @c_data);

drop procedure increasefee;
use  `we_mysql@7`;
show databases;


DELIMITER $$

CREATE PROCEDURE increasefees(IN cid INT, INOUT per FLOAT)
BEGIN
    DECLARE oldFee FLOAT;
    DECLARE newFee FLOAT;

    SELECT fees INTO oldFee FROM courses WHERE course_id = cid;

    IF oldFee < 50000 THEN
        SET newFee = oldFee + (oldFee * per);
        UPDATE courses SET fees = newFee WHERE course_id = cid;
        SET per = newFee;  -- return new fee
    ELSE
        SET per = oldFee;  -- return unchanged fee
    END IF;

END $$

DELIMITER ;

/*
In this function we are learn about string realted function to be solve  
*/
show databases;
use pratice;

show tables;
desc student;
select * from student;
select length(name) from student where id=1001;
select lower(name) from student where id = 1001;
select upper(name) from student where id = 1001;
select concat(name, age) from student where id = 1001;
select substring(name, 4, 7) from student where id = 1001;
select replace("-", " ", name ) from student where id = 1001;
SELECT LEFT(name, 5) 
FROM student 
WHERE id = 1001;

SELECT right(name, 5) 
FROM student 
WHERE id = 1001;


SELECT right(name, 5) 
FROM student 
WHERE id = 1001;


SELECT right(name, 5) 
FROM student 
WHERE id = 1001;

SELECT lpad(name, 3, "*") 
FROM student 
WHERE id = 1001;

SELECT rpad(name, 3, "*") 
FROM student 
WHERE id = 1001;



SELECT instr(name, 'a') 
FROM student 
WHERE id = 1001;
select name from student where id =1001;

select format(name) from student where id = 1001;


-- now Pratice on Numaric Function

use mysampledatabase;
use sampledatabase;
select * from customers;
select abs(creditlimit) from customers where customernumber=103;
select round(creditlimit) from customers where customernumber=119;
select ceil(creditlimit) from customers where customernumber=119;
select floor(creditlimit) from customers where customernumber=119;
select mod(creditlimit, 1000) from customers where customernumber=119;
select power(2,5);
select rand(creditlimit)from customers;
select greatest(20,50,150) from customers;










 