CREATE OR REPLACE PROCEDURE add_surgery(p_s_name IN VARCHAR2,
                                        p_s_desc IN VARCHAR2) AS
BEGIN
  IF p_s_name IS NULL THEN
    pkg_log.log_error(p_message => 'Surgery name cannot be null',
                      p_api     => 'add_surgery');
    RAISE_APPLICATION_ERROR(-20011, 'Surgery name cannot be null');
  END IF;
  BEGIN
    INSERT INTO surgery
      (surgery_id, s_name, s_desc)
    VALUES
      (('S' || LPAD(seq_surgery_id.nextval, 4, '0')), p_s_name, p_s_desc);
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      pkg_log.log_error(p_message => 'Error while adding a new surgery',
                        p_api     => 'add_surgery');
      RAISE;
  END;
END add_surgery;
/
