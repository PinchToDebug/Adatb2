PL/SQL Developer Test script 3.0
10
begin
  -- Either email or phone must be provided
  healthcare_pgk.add_veterinarian(p_first_name     => :p_first_name,
                                  p_last_name      => :p_last_name,
                                  p_specialization => :p_specialization,
                                  p_phone          => :p_phone,
                                  p_email          => :p_email);
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE, 'HH24:MI:SS ') ||
                       'Veterinarian added');
end;
5
p_first_name
1
John
5
p_last_name
1
Dough
5
p_specialization
1
Surgeon
5
p_phone
0
5
p_email
1
john@mail.com
5
0
