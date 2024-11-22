CREATE OR REPLACE TRIGGER trg_validate_veterinarian_id
  BEFORE INSERT OR UPDATE ON medical_history
  FOR EACH ROW
DECLARE
  v_exists_in_veterinarians NUMBER;
BEGIN

  SELECT COUNT(*)
    INTO v_exists_in_veterinarians
    FROM veterinarians
   WHERE veterinarian_id = :NEW.veterinarian_id;

  IF v_exists_in_veterinarians = 0 THEN
    RAISE_APPLICATION_ERROR(-20013,
                            'Veterinarian ID does not exist in the veterinarians table');
  END IF;
END;
/
