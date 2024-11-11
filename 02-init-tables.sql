-- PETS TABLE -- 
CREATE TABLE pets(
    pet_id NUMBER PRIMARY KEY,
    pet_name VARCHAR2(100 CHAR) NOT NULL,
    species VARCHAR2(50 CHAR) NOT NULL,
    color VARCHAR2(30 CHAR),
    breed VARCHAR2(50 CHAR),
    age NUMBER,
    weight NUMBER(5, 2),       -- Weight in kilogram
    status VARCHAR2(10 CHAR),  -- Available / Adopted / Fostered
    notes VARCHAR2(300 CHAR),  -- Description of the pet
    added_at TIMESTAMP
)
TABLESPACE users;

COMMENT ON COLUMN pets.weight IS 'Pets weight in kilogram.';
COMMENT ON COLUMN pets.status IS 'Status of the pet. (Available / Adopted / Fostered)';
COMMENT ON COLUMN pets.notes  IS 'Description and other information of the pet.';


-- ADOPTION_REQUEST TABLE -- 
CREATE TABLE adoption_requests(
    request_id NUMBER PRIMARY KEY,
    pet_id NUMBER NOT NULL,
    adopter_id NUMBER NOT NULL,
    status VARCHAR2(10 CHAR) NOT NULL,  -- Pending / Approved / Rejected
    requested_at TIMESTAMP,
    notes VARCHAR2(300 CHAR)
)
TABLESPACE users;

COMMENT ON COLUMN adoption_requests.status  IS 'Status of the request. (Pending / Approved / Rejected)';

ALTER TABLE adoption_requests ADD CONSTRAINT fk_pet_id
      FOREIGN KEY(pet_id) REFERENCES pets(pet_id);
