PL/SQL Developer Test script 3.0
15
BEGIN
  DBMS_OUTPUT.PUT_LINE('Adopter: ' ||
                       adoption_pck.fn_get_adopter_info(fn_adopter_id => :adopter_id));

  DBMS_OUTPUT.PUT_LINE('Available before request: ' ||
                       adoption_pck.fn_is_pet_available(fn_pet_id => :pet_id));

  -- First pet_id and adopter_id are both 1000
  adoption_pck.submit_request(p_pet_id     => :pet_id,
                              p_adopter_id => :adopter_id,
                              p_notes      => :notes);

  DBMS_OUTPUT.PUT_LINE('Available after  request: ' ||
                       adoption_pck.fn_is_pet_available(fn_pet_id => :pet_id));
END;
3
adopter_id
1
1000
5
pet_id
1
1000
5
notes
1
Wants to take the pet this week.
5
0
