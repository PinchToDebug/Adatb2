PL/SQL Developer Test script 3.0
10
begin
  -- veterinarian_id seq starts at 100,
  -- p_treatment_type Surgery / Vaccine
  -- p_treatment_id must match the types
  add_medical_record(p_pet_id          => :p_pet_id,
                     p_treatment_type  => :p_treatment_type,
                     p_treatment_id    => :p_treatment_id,
                     p_notes           => :p_notes,
                     p_veterinarian_id => :p_veterinarian_id);
end;
5
p_pet_id
1
1000
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
0
5
p_veterinarian_id
1
100
5
0
