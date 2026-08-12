// MRPV2_fnc_MRP_Tel_Menu_Banque = {

params ["_intraID"];

_payload = format["token=%1&uid=%2&codepin_banque=%3",intraTOKEN,_intraID,4406];
_return = ["bank/list","POST",nil,_payload,false] call CLIENT_fnc_HTTP;


_HTTP_Code = _return#0;
if (_HTTP_Code != 200) exitWith {
	// systemChat format["DOC : HTTP Error %1",_HTTP_Code];
    // createHashMap
};
_data = (_return#1);
data = _data;
_data
// };

[player getVariable ["intraID",-1]] spawn MRPV2_fnc_MRP_Tel_Menu_Banque;


return = return # 1;
return = str return regexReplace ["{","["];
return = return regexReplace ["{","["];
return = [text(return regexReplace ["",""])];
return = str return regexReplace ["}","]"];
return = [text(return regexReplace ["",""])];
return = call compile return;

// (str(return # 1) regexReplace ["","["])