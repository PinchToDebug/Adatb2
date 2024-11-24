PL/SQL Developer Test script 3.0
6
begin 
  -- If you run it twice, it'll say it's pending
  adoption_pck.submit_request(p_pet_id     => :p_pet_id,
                              p_adopter_id => :p_adopter_id,
                              p_notes      => :p_notes);
end;
3
p_pet_id
1
1000
3
p_adopter_id
1
1000
3
p_notes
0
5
0
