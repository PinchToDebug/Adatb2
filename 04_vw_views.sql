-- pet VW --
CREATE OR REPLACE VIEW wv_pet AS
SELECT pet_id, pet_name, species, color, breed, age, weight, status
  FROM pet;


-- PENDING ADOPTION VW --
CREATE OR REPLACE VIEW vw_pending_adoption_request AS
SELECT ar.request_id,
       ar.requested_at,
       p.pet_name,
       a.first_name || ' ' || a.last_name AS adopter_name
  FROM adoption_request ar
  JOIN pet p
    ON ar.pet_id = p.pet_id
  JOIN adopter a
    ON ar.adopter_id = a.adopter_id
 WHERE ar.status = 'Pending';


-- AVAILABLE ADOPTION VIEW --
CREATE OR REPLACE VIEW vw_pet_available AS
SELECT pet_id, pet_name, species, color, breed, age, weight, status
  FROM pet
 WHERE status = 'Available';
 
 
-- MEDICAL HISTORY VIEW --
CREATE OR REPLACE VIEW vw_pet_medical_history AS
SELECT mh.record_id,
       mh.pet_id,
       p.pet_name,
       mh.treatment_date,
       mh.treatment_type,
       mh.notes AS notes,
       v.first_name || ' ' || v.last_name AS veterinarian_name
  FROM medical_history mh
  JOIN pet p
    ON mh.pet_id = p.pet_id
  LEFT JOIN veterinarian v
    ON mh.veterinarian_id = v.veterinarian_id;


-- ADOPTION STATISTICS VIEW --
CREATE OR REPLACE VIEW vw_adoption_stats AS
SELECT COUNT(*) AS total_requests,
       COUNT(CASE
               WHEN status = 'Approved' THEN
                1
             END) AS approved_requests,
       COUNT(CASE
               WHEN status = 'Rejected' THEN
                1
             END) AS rejected_requests,
       COUNT(CASE
               WHEN status = 'Pending' THEN
                1
             END) AS pending_requests
  FROM adoption_request;


-- MEDICAL HISTORY STATISTICS VIEW --
CREATE OR REPLACE VIEW vw_pet_medical_history_stats AS
SELECT mh.pet_id,
       p.pet_name,
       mh.treatment_type,
       mh.treatment_date,
       mh.notes
  FROM medical_history mh
  JOIN pet p
    ON mh.pet_id = p.pet_id
 WHERE mh.treatment_type IS NOT NULL
 ORDER BY mh.treatment_date DESC;
