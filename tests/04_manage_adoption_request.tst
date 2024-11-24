PL/SQL Developer Test script 3.0
9
begin
  DBMS_OUTPUT.PUT_LINE(adoption_pck.fn_get_request_status(fn_request_id => :request_id));

  -- p_action: Approve or Reject, ID must be valid
  adoption_pck.manage_adoption_request(p_request_id => :request_id,
                                       p_action     => :action);

  DBMS_OUTPUT.PUT_LINE(adoption_pck.fn_get_request_status(fn_request_id => :request_id));
end;
2
action
1
Reject
5
request_id
1
1
5
0
