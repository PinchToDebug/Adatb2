CREATE OR REPLACE PROCEDURE add_veterinarian(p_first_name     IN VARCHAR2,
                                             p_last_name      IN VARCHAR2,
                                             p_specialization IN VARCHAR2,
                                             p_phone          IN VARCHAR2,
                                             p_email          IN VARCHAR2) IS
BEGIN
  IF p_first_name IS NULL THEN
    pkg_log.log_error(p_message => 'First name cannot be null',
                      p_api     => 'add_veterinarian');
    RAISE_APPLICATION_ERROR(-20006, 'First name cannot be null');
  END IF;

  IF p_last_name IS NULL THEN
    pkg_log.log_error(p_message => 'Last name cannot be null',
                      p_api     => 'add_veterinarian');
    RAISE_APPLICATION_ERROR(-20007, 'Last name cannot be null');
  END IF;

  IF p_specialization IS NULL THEN
    pkg_log.log_error(p_message => 'Specialization cannot be null',
                      p_api     => 'add_veterinarian');
    RAISE_APPLICATION_ERROR(-20008, 'Specialization cannot be null');
  END IF;

  IF p_phone IS NULL AND p_email IS NULL THEN
    pkg_log.log_error(p_message => 'Either phone or email must be provided',
                      p_api     => 'add_veterinarian');
    RAISE_APPLICATION_ERROR(-20009,
                            'Either phone or email must be provided');
  END IF;

  BEGIN
    INSERT INTO veterinarians
      (veterinarian_id,
       first_name,
       last_name,
       specialization,
       phone,
       email)
    VALUES
      (seq_veterinarian_id.nextval,
       p_first_name,
       p_last_name,
       p_specialization,
       p_phone,
       p_email);
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      pkg_log.log_error(p_message => 'Error while adding veterinarian',
                        p_api     => 'add_veterinarian');
      RAISE;
  END;
END;
/
