PL/SQL Developer Test script 3.0
10
begin
  -- Email or phone must be provided
  adoption_pck.add_adopter(p_first_name => :p_first_name,
                           p_last_name  => :p_last_name,
                           p_email      => :p_email,
                           p_phone      => :p_phone,
                           p_address    => :p_address);
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE, 'HH24:MI:SS ') ||
                       'Adopter added');
end;
5
p_first_name
1
John
5
p_last_name
1
Doe
5
p_email
1
john.doe@mail.com
5
p_phone
0
5
p_address
2
Feldstrasse 12,
Lindenburg, 45-6789
5
0
