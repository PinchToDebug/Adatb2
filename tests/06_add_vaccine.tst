PL/SQL Developer Test script 3.0
5
begin
  -- The first ID will be V0001
  healthcare_pgk.add_vaccine(p_v_name => :p_v_name, p_v_desc => :p_v_desc);
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE, 'HH24:MI:SS ') || 'Vaccine added');
end;
2
p_v_name
1
Rabies shot
5
p_v_desc
0
5
0
