CREATE OR REPLACE TRIGGER trg_update_pet_on_reject
  AFTER UPDATE ON adoption_request
  FOR EACH ROW
BEGIN
  IF :NEW.status = 'Rejected' AND :OLD.status != 'Rejected' THEN
    UPDATE pet SET status = 'Available' WHERE pet_id = :NEW.pet_id;
  END IF;
END;
/
