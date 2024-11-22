CREATE OR REPLACE TRIGGER trg_log_pet_changes
  BEFORE INSERT OR UPDATE OR DELETE ON PETS
  FOR EACH ROW
BEGIN

  DECLARE
    v_dml_flag CHAR(1);
  BEGIN
    IF INSERTING THEN
      v_dml_flag := 'I';
      :new.version := 1;

    ELSIF UPDATING THEN
      v_dml_flag := 'U';
      :new.version := :old.version + 1;

    ELSIF DELETING THEN
      v_dml_flag := 'D';
      :new.version := :old.version + 1;
    END IF;

    INSERT INTO pet_log (
      pet_id,
      pet_name,
      species,
      color,
      breed,
      age,
      weight,
      status,
      notes,
      created_at,
      dml_flag,
      version,
      mod_date,
      mod_user
    ) VALUES (
      :NEW.pet_id,
      :NEW.pet_name,
      :NEW.species,
      :NEW.color,
      :NEW.breed,
      :NEW.age,
      :NEW.weight,
      :NEW.status,
      :NEW.notes,
      :NEW.added_at,
      v_dml_flag,
      :new.version,
      systimestamp,
      sys_context('USERENV', 'OS_USER')
    );
  END;
END trg_log_pet_changes;
/
