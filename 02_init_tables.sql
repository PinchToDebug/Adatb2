-- pet TABLE -- 
CREATE TABLE pet(
    pet_id   NUMBER PRIMARY KEY,
    pet_name VARCHAR2(100 CHAR) NOT NULL,
    species  VARCHAR2(50 CHAR)  NOT NULL,
    color    VARCHAR2(30 CHAR),
    breed    VARCHAR2(50 CHAR),
    age      NUMBER,
    weight   NUMBER(5, 2),       -- Weight in kilogram
    status   VARCHAR2(10 CHAR),  -- Available / Adopted / Fostered
    notes    VARCHAR2(300 CHAR), -- Description of the pet
    added_at TIMESTAMP DEFAULT SYSDATE,
    version  NUMBER DEFAULT 1
)
TABLESPACE users;

COMMENT ON COLUMN pet.weight IS 'pet weight in kilogram.';
COMMENT ON COLUMN pet.status IS 'Status of the pet. (Available / Adopted / Fostered)';
COMMENT ON COLUMN pet.notes  IS 'Description and other information of the pet.';


-- ADOPTION_REQUEST TABLE -- 
CREATE TABLE adoption_request(
    request_id NUMBER PRIMARY KEY,
    pet_id     NUMBER NOT NULL,
    adopter_id NUMBER NOT NULL,
    status     VARCHAR2(10 CHAR) NOT NULL,  -- Pending / Approved / Rejected
    requested_at TIMESTAMP DEFAULT SYSDATE,
    notes VARCHAR2(50 CHAR)
)
TABLESPACE users;

COMMENT ON COLUMN adoption_request.status  IS 'Status of the request. (Pending / Approved / Rejected)';

ALTER TABLE adoption_request ADD CONSTRAINT fk_pet_id
      FOREIGN KEY(pet_id) REFERENCES pet(pet_id);


-- adopter TABLE -- 
CREATE TABLE adopter(
    adopter_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(100 CHAR) NOT NULL,
    last_name  VARCHAR2(100 CHAR) NOT NULL,
    email   VARCHAR2(100 CHAR) NOT NULL,
    phone   VARCHAR2(12 CHAR),
    address VARCHAR2(200 CHAR),
    application_date DATE DEFAULT SYSDATE
)
TABLESPACE users;

ALTER TABLE adoption_request ADD CONSTRAINT fk_adopter_id
      FOREIGN KEY(adopter_id) REFERENCES adopter(adopter_id);


-- vaccine TABLE --
CREATE TABLE vaccine (
    vaccine_id VARCHAR2(15)   PRIMARY KEY,
    v_name VARCHAR2(150 CHAR) NOT NULL,
    v_desc VARCHAR2(150 CHAR)
)
TABLESPACE users;


-- surgery TABLE --
CREATE TABLE surgery (
    surgery_id VARCHAR2(15)   PRIMARY KEY,
    s_name VARCHAR2(150 CHAR) NOT NULL,
    s_desc VARCHAR2(150 CHAR)
)
TABLESPACE users;


-- MEDICAL_HISTORY TABLE -- 
CREATE TABLE medical_history(
    record_id      NUMBER  PRIMARY KEY,
    pet_id         NUMBER  NOT NULL,
    treatment_date DATE    DEFAULT SYSDATE,
    treatment_type VARCHAR2(12 CHAR) NOT NULL, -- Vaccination / Surgery
    vaccine_id     VARCHAR2(15),
    surgery_id     VARCHAR2(15),
    notes VARCHAR2(300 CHAR),
    veterinarian_id NUMBER,
    CONSTRAINT fk_pet FOREIGN KEY (pet_id) REFERENCES pet(pet_id),         
    CONSTRAINT fk_vaccine FOREIGN KEY (vaccine_id) REFERENCES vaccine(vaccine_id),
    CONSTRAINT fk_surgery FOREIGN KEY (surgery_id) REFERENCES surgery(surgery_id),
    CONSTRAINT fk_vet FOREIGN KEY (veterinarian_id) REFERENCES veterinarian(veterinarian_id),
    CONSTRAINT chk_treatment_type CHECK (
        (treatment_type = 'Vaccination' AND vaccine_id IS NOT NULL AND surgery_id IS NULL) OR
        (treatment_type = 'Surgery' AND surgery_id IS NOT NULL AND vaccine_id IS NULL)
    ) 
)
TABLESPACE users;

COMMENT ON COLUMN medical_history.treatment_type  IS 'Vaccination / Surgery';


-- veterinarian TABLE -- 
CREATE TABLE veterinarian(
    veterinarian_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(100 CHAR) NOT NULL,
    last_name  VARCHAR2(100 CHAR) NOT NULL,
    phone  VARCHAR2(12 CHAR),
    email  VARCHAR2(100 CHAR),
    specialization VARCHAR2(150)
)
TABLESPACE users;

ALTER TABLE medical_history ADD CONSTRAINT fk_veterinarian_id
      FOREIGN KEY(veterinarian_id) REFERENCES veterinarian(veterinarian_id);


-- PET_LOG TABLE --
CREATE TABLE pet_log (
    pet_id        NUMBER,
    pet_name      VARCHAR2(100 CHAR),
    species       VARCHAR2(50 CHAR),
    color         VARCHAR2(30 CHAR),
    breed         VARCHAR2(50 CHAR),
    age           NUMBER,
    weight        NUMBER(5, 2),
    status        VARCHAR2(10 CHAR),
    notes         VARCHAR2(300 CHAR),
    created_at    TIMESTAMP DEFAULT SYSDATE,
    dml_flag      VARCHAR2(1 CHAR),
    version       NUMBER,
    mod_date      TIMESTAMP DEFAULT SYSDATE,
    mod_user      VARCHAR2(250 CHAR)
);


-- LOG TABLE --
CREATE TABLE log (
    log_id       NUMBER PRIMARY KEY,
    log_time     TIMESTAMP DEFAULT systimestamp,
    severity     VARCHAR2(10),
    sql_code     NUMBER,
    message      VARCHAR2(4000),
    api          VARCHAR2(100),
    backtrace    VARCHAR2(4000)
);

COMMENT ON COLUMN log.api  IS 'Raiser of the Error';
COMMENT ON TABLE  log IS 'Errors are logged here';
