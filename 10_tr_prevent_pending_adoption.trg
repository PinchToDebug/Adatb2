CREATE OR REPLACE TRIGGER trg_prevent_pending_adoption
BEFORE INSERT ON adoption_request
FOR EACH ROW
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO v_count
    FROM adoption_request
   WHERE pet_id = :NEW.pet_id
     AND status = 'Pending';

  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'An adoption request for this pet is already pending.');
  END IF;
END;
/
/
