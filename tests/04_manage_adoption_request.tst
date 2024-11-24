PL/SQL Developer Test script 3.0
4
begin 
  -- p_action: Approve or Reject, ID must be valid
 adoption_pck.manage_adoption_request( p_request_id => :p_request_id, p_action => :p_action );
end;
2
p_request_id
1
1
5
p_action
1
Reject
5
0
