_payload = format["token=%1&uid=%2",intraTOKEN,player getVariable ["intraID",-1]];
_return = ["player/get_mails","POST",nil,_payload,false] call CLIENT_fnc_HTTP;

_HTTP_Code = _return#0;
if (_HTTP_Code != 200) exitWith {systemChat format["get_mails : HTTP Error %1",_HTTP_Code];};

_mails = _return#1#0;
MRP_Telephone_Nouveau_Mails = _mails;