CREATE OR REPLACE PROCEDURE add_medical_record(p_pet_id          NUMBER,
                                               p_treatment_type  VARCHAR2,
                                               p_treatment_id    VARCHAR2,
                                               p_notes           VARCHAR2,
                                               p_veterinarian_id NUMBER) IS
BEGIN

  IF p_pet_id IS NULL THEN
    pkg_log.log_error(p_message => 'Pet ID cannot be null',
                      p_api     => 'add_medical_record');
    RAISE_APPLICATION_ERROR(-20003, 'Pet ID cannot be null');
  END IF;

  IF p_treatment_type IS NULL THEN
    pkg_log.log_error(p_message => 'Treatment type cannot be null',
                      p_api     => 'add_medical_record');
    RAISE_APPLICATION_ERROR(-20004, 'Treatment type cannot be null');
  END IF;

  IF p_treatment_id IS NULL THEN
    pkg_log.log_error(p_message => 'Treatment ID cannot be null',
                      p_api     => 'add_medical_record');
    RAISE_APPLICATION_ERROR(-20002, 'Treatment ID cannot be null');
  END IF;

  IF p_veterinarian_id IS NULL THEN
    pkg_log.log_error(p_message => 'Veterinarian ID cannot be null',
                      p_api     => 'add_medical_record');
    RAISE_APPLICATION_ERROR(-20005, 'Veterinarian ID cannot be null');
  END IF;

  BEGIN
    INSERT INTO medical_history
      (record_id,
       pet_id,
       treatment_date,
       treatment_type,
       treatment_id,
       notes,
       veterinarian_id)
    VALUES
      (seq_record_id.nextval,
       p_pet_id,
       sysdate,
       p_treatment_type,
       upper(p_treatment_id),
       p_notes,
       p_veterinarian_id);
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      pkg_log.log_error(p_message => 'Error while adding medical record',
                        p_api     => 'add_medical_record');
      RAISE;
  END;
END;
/
