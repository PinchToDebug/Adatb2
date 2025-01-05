PL/SQL Developer Test script 3.0
5
begin
  -- The first ID will be S0001
  healthcare_pkg.add_surgery(p_s_name => :p_s_name, p_s_desc => :p_s_desc);
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE, 'HH24:MI:SS ') || 'Surgery added');
end;
2
p_s_name
1
Spay/Neuter
5
p_s_desc
0
5
0
