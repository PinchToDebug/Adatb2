PL/SQL Developer Test script 3.0
13
begin
  -- veterinarian_id seq starts at 100,
  -- p_treatment_type Surgery / Vaccination
  -- p_treatment_id must match the types
  adoption_pck.add_medical_record(p_pet_id          => :p_pet_id,
                     p_treatment_type  => :p_treatment_type,
                     p_treatment_id    => :p_treatment_id,
                     p_notes           => :p_notes,
                     p_veterinarian_id => :p_veterinarian_id);

  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE, 'HH24:MI:SS ') ||
                       'Medical record added');
end;
6
p_pet_id
1
1001
5
p_treatment_type
1
Surgery
5
p_treatment_id
1
S0001
5
p_notes
1
Went well
5
p_veterinarian_id
1
100
5
p_record_id
0
-5
0
