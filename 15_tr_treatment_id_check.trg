CREATE OR REPLACE TRIGGER trg_validate_treatment_id
  BEFORE INSERT OR UPDATE ON medical_history
  FOR EACH ROW
DECLARE
  v_exists_in_vaccines  NUMBER;
  v_exists_in_surgeries NUMBER;
BEGIN

  SELECT COUNT(*)
    INTO v_exists_in_vaccines
    FROM vaccines
   WHERE vaccine_id = :NEW.treatment_id;

  SELECT COUNT(*)
    INTO v_exists_in_surgeries
    FROM surgeries
   WHERE surgery_id = :NEW.treatment_id;

  IF v_exists_in_vaccines = 0 AND v_exists_in_surgeries = 0 THEN
    RAISE_APPLICATION_ERROR(-20012,
                            'Treatment ID does not exist in vaccines or surgeries tables');
  END IF;
END;
/
