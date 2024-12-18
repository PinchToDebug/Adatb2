CREATE OR REPLACE TRIGGER trg_update_pet_status
  AFTER INSERT ON adoption_request
  FOR EACH ROW
BEGIN
  UPDATE pet SET status = 'Pending' WHERE pet_id = :NEW.pet_id;
END;
/
