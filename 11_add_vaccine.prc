CREATE OR REPLACE PROCEDURE add_vaccine(p_v_name IN VARCHAR2,
                                        p_v_desc IN VARCHAR2) AS
BEGIN
  IF p_v_name IS NULL THEN
    pkg_log.log_error(p_message => 'Vaccine name cannot be null',
                      p_api     => 'add_vaccine');
    RAISE_APPLICATION_ERROR(-20010, 'Vaccine name cannot be null');
  END IF;
  BEGIN
    INSERT INTO vaccines
      (vaccine_id, v_name, v_desc)
    VALUES
      (('V' || LPAD(seq_vaccine_id.nextval, 4, '0')), p_v_name, p_v_desc);
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      pkg_log.log_error(p_message => 'Error while adding a new vaccine',
                        p_api     => 'add_vaccine');
      RAISE;
  END;
END add_vaccine;
/
