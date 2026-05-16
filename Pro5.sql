use e4;
CREATE TABLE employee5 (
    e_id INT PRIMARY KEY,
    e_name VARCHAR(10),
    age INT,
    salary DECIMAL(10,2)
);
desc employee5;

INSERT INTO employee5 VALUES (101,'ramkumar',32,45000.00);
INSERT INTO employee5 VALUES (102,'ajay',30,25000);
INSERT INTO employee5 VALUES (103,'sajan',34,70000);
INSERT INTO employee5 VALUES (104,'Manoj',36,170000);
select * from employee5;

DELIMITER $$

CREATE PROCEDURE show_employee5_cursor()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_e_id INT;
    DECLARE v_e_name VARCHAR(50);
    DECLARE v_age INT;
    DECLARE v_salary DECIMAL(10,2);

    DECLARE emp_cursor CURSOR FOR
        SELECT e_id, e_name, age, salary FROM employee5;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN emp_cursor;

    read_loop: LOOP
        FETCH emp_cursor INTO v_e_id, v_e_name, v_age, v_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT CONCAT(
            'employee id: ', v_e_id,
            ', name: ', v_e_name,
            ', age: ', v_age,
            ', salary: ', v_salary
        ) AS employee_details;

    END LOOP;

    CLOSE emp_cursor;
END$$

DELIMITER ;

CALL show_employee5_cursor();

