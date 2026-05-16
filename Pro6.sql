USE dbms_lab;

CREATE TABLE N_RollCall(
    id INT,
    name VARCHAR(10),
    roll INT
);

DESC N_RollCall;

CREATE TABLE O_RollCall(
    id INT,
    name VARCHAR(10),
    roll INT
);

DESC O_RollCall;

INSERT INTO N_RollCall VALUES (1121, 'satya12333', 111111111);
INSERT INTO N_RollCall VALUES (1121, 'satya12333', 111111111);
INSERT INTO N_RollCall VALUES (1121, 'satya12333', 111111111);
INSERT INTO N_RollCall VALUES (1121, 'satya12333', 111111111);
INSERT INTO N_RollCall VALUES (1122, 'satya12333', 111111111);

SELECT * FROM N_RollCall;

DELIMITER $$

CREATE PROCEDURE sync_rollcall()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_roll VARCHAR(50);
    DECLARE v_count INT;

    DECLARE cur_rollcall CURSOR FOR
        SELECT id, name, roll FROM N_RollCall;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_rollcall;

    read_loop: LOOP
        FETCH cur_rollcall INTO v_id, v_name, v_roll;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT COUNT(*) INTO v_count
        FROM O_RollCall
        WHERE id = v_id;

        IF v_count = 0 THEN
            INSERT INTO O_RollCall (id, name, roll)
            VALUES (v_id, v_name, v_roll);
            SELECT CONCAT('record inserted: ', v_id) AS message;
        ELSE
            SELECT CONCAT('record skipped: ', v_id) AS message;
        END IF;
    END LOOP;

    CLOSE cur_rollcall;

    COMMIT;
END$$

DELIMITER ;

CALL sync_rollcall();

SELECT * FROM N_RollCall;

SELECT * FROM O_RollCall;

COMMIT;