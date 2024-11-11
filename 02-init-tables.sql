-- PETS TABLE -- 
CREATE TABLE pets(
    pet_id NUMBER PRIMARY KEY,
    pet_name VARCHAR2(100 CHAR) NOT NULL,
    species CHAR(50 CHAR) NOT NULL,
    color VARCHAR2(30 CHAR),
    breed VARCHAR2(50 CHAR),
    age NUMBER,
    weight NUMBER,             -- Weight in kilogram
    status VARCHAR2(10 CHAR),  -- Available / Adopted
    notes VARCHAR2(300 CHAR),  -- Description of the pet
    added_at TIMESTAMP
)
TABLESPACE users;
