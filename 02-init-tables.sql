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
    added_at TIMESTAMP DEFAULT SYSDATE
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
    requested_at TIMESTAMP DEFAULT SYSDATE,
    notes VARCHAR2(300 CHAR)
)
TABLESPACE users;

COMMENT ON COLUMN adoption_requests.status  IS 'Status of the request. (Pending / Approved / Rejected)';

ALTER TABLE adoption_requests ADD CONSTRAINT fk_pet_id
      FOREIGN KEY(pet_id) REFERENCES pets(pet_id);


-- ADOPTERS TABLE -- 
CREATE TABLE adopters(
    adopter_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(100 CHAR) NOT NULL,
    last_name VARCHAR2(100 CHAR) NOT NULL,
    email VARCHAR2(100 CHAR) NOT NULL,
    phone VARCHAR2(12 CHAR),
    address VARCHAR2(200 CHAR),
    application_date DATE DEFAULT SYSDATE
)
TABLESPACE users;

ALTER TABLE adoption_requests ADD CONSTRAINT fk_adopter_id
      FOREIGN KEY(adopter_id) REFERENCES adopters(adopter_id);


-- VACCINE_TYPES TABLE 
CREATE TABLE vaccine_types (
    vaccine_id VARCHAR2(15) PRIMARY KEY,
    v_name VARCHAR2(150 CHAR) NOT NULL,
    v_desc VARCHAR2(150 CHAR)
)
TABLESPACE users;


-- SURGERY_TYPES TABLE
CREATE TABLE surgery_types (
    surgery_id VARCHAR2(15) PRIMARY KEY,
    s_name VARCHAR2(150 CHAR) NOT NULL,
    s_desc VARCHAR2(150 CHAR)
)
TABLESPACE users;


-- MEDICAL_HISTORY TABLE -- 
CREATE TABLE medical_history(
    record_id NUMBER PRIMARY KEY,
    pet_id VARCHAR2(100 CHAR) NOT NULL,
    treatment_date DATE DEFAULT SYSDATE,
    treatment_type VARCHAR2(12 CHAR) NOT NULL, -- Vaccination / Surgery
    treatment_id VARCHAR2(12 CHAR) NOT NULL,
    notes VARCHAR2(300 CHAR)
)
TABLESPACE users;

COMMENT ON COLUMN medical_history.treatment_type  IS 'Vaccination / Surgery';

ALTER TABLE medical_history ADD CONSTRAINT fk_vaccine
      FOREIGN KEY(treatment_id) REFERENCES vaccine_types(vaccine_id); 
ALTER TABLE medical_history ADD CONSTRAINT fk_surgery
      FOREIGN KEY(treatment_id) REFERENCES surgery_types(surgery_id);

