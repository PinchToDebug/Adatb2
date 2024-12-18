  -- Trigger for PET table
CREATE OR REPLACE TRIGGER trg_pet_auto_id
  BEFORE INSERT ON pet
  FOR EACH ROW
BEGIN
  IF :NEW.pet_id IS NULL THEN
    :NEW.pet_id := seq_pet_id.NEXTVAL;
  END IF;
END;
/

  -- Trigger for ADOPTION_REQUEST table
  CREATE OR REPLACE TRIGGER trg_request_auto_id
  BEFORE INSERT ON adoption_request
  FOR EACH ROW BEGIN IF :NEW.request_id IS NULL THEN :NEW.request_id := seq_request_id.NEXTVAL; END IF; END;
/

  -- Trigger for ADOPTER table
  CREATE OR REPLACE TRIGGER trg_adopter_auto_id
  BEFORE INSERT ON adopter
  FOR EACH ROW BEGIN IF :NEW.adopter_id IS NULL THEN :NEW.adopter_id := seq_adopter_id.NEXTVAL; END IF; END;
/

  -- Trigger for MEDICAL_HISTORY table
  CREATE OR REPLACE TRIGGER trg_record_auto_id
  BEFORE INSERT ON medical_history
  FOR EACH ROW BEGIN IF :NEW.record_id IS NULL THEN :NEW.record_id := seq_record_id.NEXTVAL; END IF; END;
/

  -- Trigger for LOG table
  CREATE OR REPLACE TRIGGER trg_log_auto_id
  BEFORE INSERT ON log
  FOR EACH ROW BEGIN IF :NEW.log_id IS NULL THEN :NEW.log_id := seq_log_id.NEXTVAL; END IF; END;
/

-- Trigger for ADOPTION_REQUEST table
  CREATE OR REPLACE TRIGGER trg_request_id
  BEFORE INSERT ON adoption_request
  FOR EACH ROW
  WHEN (NEW.request_id IS NULL) BEGIN SELECT seq_request_id.NEXTVAL INTO :NEW.request_id FROM DUAL; END;
/
-- Trigger for ADOPTER table
  CREATE OR REPLACE TRIGGER trg_adopter_id
  BEFORE INSERT ON adopter
  FOR EACH ROW
  WHEN(NEW.adopter_id IS NULL) BEGIN SELECT seq_adopter_id.NEXTVAL INTO :NEW.adopter_id FROM DUAL; END;
/
-- Trigger for MEDICAL_HISTORY table
  CREATE OR REPLACE TRIGGER trg_record_id
  BEFORE INSERT ON medical_history
  FOR EACH ROW
  WHEN(NEW.record_id IS NULL) BEGIN SELECT seq_record_id.NEXTVAL INTO :NEW.record_id FROM DUAL; END;
/
-- Trigger for LOG table
  CREATE OR REPLACE TRIGGER trg_log_id
  BEFORE INSERT ON log
  FOR EACH ROW
  WHEN(NEW.log_id IS NULL) BEGIN SELECT seq_log_id.NEXTVAL INTO :NEW.log_id FROM DUAL; END;
/
