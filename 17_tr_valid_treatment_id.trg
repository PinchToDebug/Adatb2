CREATE OR REPLACE TRIGGER trg_validate_treatment_id
  BEFORE INSERT OR UPDATE ON medical_history
  FOR EACH ROW
DECLARE
  v_exists_in_surgeries NUMBER;
  v_exists_in_vaccines  NUMBER;
BEGIN
  IF UPPER(:NEW.treatment_type) = 'SURGERY' THEN
    SELECT COUNT(*)
      INTO v_exists_in_surgeries
      FROM surgeries
     WHERE surgery_id = :NEW.treatment_id;
  
    IF v_exists_in_surgeries = 0 THEN
       pkg_log.log_error(p_message => 'Treatment ID does not exist in the surgeries table for Surgery type',
                         p_api     => 'add_medical_record');
      RAISE_APPLICATION_ERROR(-20014,
                              'Treatment ID does not exist in the surgeries table for Surgery type');
    END IF;
  END IF;

  IF UPPER(:NEW.treatment_type) = 'VACCINE' THEN
    SELECT COUNT(*)
      INTO v_exists_in_vaccines
      FROM vaccines
     WHERE vaccine_id = :NEW.treatment_id;
  
    IF v_exists_in_vaccines = 0 THEN
             pkg_log.log_error(p_message => 'Treatment ID does not exist in the vaccines table for Vaccine type',
                               p_api     => 'add_medical_record');
      RAISE_APPLICATION_ERROR(-20015,
                              'Treatment ID does not exist in the vaccines table for Vaccine type');
    END IF;
  END IF;
END;
/
