CREATE DATABASE dbms_lab;
USE dbms_lab;

CREATE TABLE employee (
    empno INT,
    ename VARCHAR(10),
    job VARCHAR(10),
    manager_no INT,
    sal INT,
    commission INT
);

DESC employee;

--RUN THE BELOW PART IN MAIN LOCAL-INSTANCE CONNECTION, AFTER THE USER IS CREATED,
--CREATE A NEW CONNECTION WITH THIS USERNAME AND PASSWORD, use USE db_name AND CONTINUE WORKING WITH THE CODE
CREATE USER 'c_dbms'@'localhost' IDENTIFIED BY 'dbms403';
GRANT ALL PRIVILEGES ON dbms_lab.* TO 'c_dbms'@'localhost';
FLUSH PRIVILEGES;

SELECT user, host FROM mysql.user;
