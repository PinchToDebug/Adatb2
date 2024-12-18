CREATE OR REPLACE TRIGGER trg_validate_treatment_id
  BEFORE INSERT OR UPDATE ON medical_history
  FOR EACH ROW
DECLARE
  v_exists_in_vaccine  NUMBER;
  v_exists_in_surgery NUMBER;
BEGIN

  SELECT COUNT(*)
    INTO v_exists_in_vaccine
    FROM vaccine
   WHERE vaccine_id = :NEW.treatment_id;

  SELECT COUNT(*)
    INTO v_exists_in_surgery
    FROM surgery
   WHERE surgery_id = :NEW.treatment_id;

  IF v_exists_in_vaccine = 0 AND v_exists_in_surgery = 0 THEN
    RAISE_APPLICATION_ERROR(-20012,
                            'Treatment ID does not exist in vaccine or surgery tables');
  END IF;
END;
/
