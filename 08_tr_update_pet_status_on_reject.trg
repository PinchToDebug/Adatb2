CREATE OR REPLACE TRIGGER trg_update_pet_on_reject
  AFTER UPDATE ON adoption_requests
  FOR EACH ROW
BEGIN
  IF :NEW.status = 'Rejected' AND :OLD.status != 'Rejected' THEN
    UPDATE pets SET status = 'Available' WHERE pet_id = :NEW.pet_id;
  END IF;
END;
/
