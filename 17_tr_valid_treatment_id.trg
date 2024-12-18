CREATE OR REPLACE TRIGGER trg_validate_treatment_id
  BEFORE INSERT OR UPDATE ON medical_history
  FOR EACH ROW
DECLARE
  v_exists_in_surgery NUMBER;
  v_exists_in_vaccine  NUMBER;
BEGIN
  IF UPPER(:NEW.treatment_type) = 'SURGERY' THEN
    SELECT COUNT(*)
      INTO v_exists_in_surgery
      FROM surgery
     WHERE surgery_id = :NEW.treatment_id;
  
    IF v_exists_in_surgery = 0 THEN
      pkg_log.log_error(p_message => 'Treatment ID does not exist in the surgery table for Surgery type',
                        p_api     => 'add_medical_record');
      RAISE_APPLICATION_ERROR(-20014,
                              'Treatment ID does not exist in the surgery table for Surgery type');
    END IF;
  END IF;

  IF UPPER(:NEW.treatment_type) = 'VACCINE' THEN
    SELECT COUNT(*)
      INTO v_exists_in_vaccine
      FROM vaccine
     WHERE vaccine_id = :NEW.treatment_id;
  
    IF v_exists_in_vaccine = 0 THEN
      pkg_log.log_error(p_message => 'Treatment ID does not exist in the vaccine table for Vaccine type',
                        p_api     => 'add_medical_record');
      RAISE_APPLICATION_ERROR(-20015,
                              'Treatment ID does not exist in the vaccine table for Vaccine type');
    END IF;
  END IF;
END;
/
