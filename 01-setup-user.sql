--------------------------------------
-- Create pet_shelter, add grants   --
--------------------------------------
BEGIN
  FOR c IN (SELECT 'ALTER SYSTEM KILL SESSION ''' || sid || ',' || serial# || ''' IMMEDIATE' AS command
      FROM v$session
     WHERE username = 'PET_SHELTER')
  LOOP
    EXECUTE IMMEDIATE c.command;
  END LOOP;
END;
/

DECLARE
  l_cnt NUMBER;
BEGIN
  SELECT COUNT(*) INTO l_cnt FROM dba_users t WHERE t.username = 'PET_SHELTER';
  IF l_cnt=1 THEN 
    EXECUTE IMMEDIATE 'DROP USER pet_shelter CASCADE';
  END IF;
END;
/
CREATE USER pet_shelter 
  IDENTIFIED BY 12345678
  DEFAULT TABLESPACE USERS
  QUOTA UNLIMITED ON users
;

GRANT CREATE SESSION TO pet_shelter;
GRANT CREATE TABLE TO pet_shelter;
GRANT CREATE VIEW TO pet_shelter;
GRANT CREATE SEQUENCE TO pet_shelter;
GRANT CREATE PROCEDURE TO pet_shelter;
GRANT CREATE TYPE TO pet_shelter;
GRANT EXECUTE ON dbms_lock TO pet_shelter;
GRANT CREATE TRIGGER to pet_shelter;

