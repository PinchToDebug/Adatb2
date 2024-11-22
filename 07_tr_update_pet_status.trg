CREATE OR REPLACE TRIGGER trg_update_pet_status
  AFTER INSERT ON adoption_requests
  FOR EACH ROW
BEGIN
  UPDATE pets SET status = 'Pending' WHERE pet_id = :NEW.pet_id;
END;
/
