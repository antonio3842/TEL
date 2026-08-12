// MRPV2_fnc_MRP_Tel_Init_Conf_API = {
private _intraID = player getVariable ["intraID",-1];

_payload = format["token=%1&uid=%2",intraTOKEN,_intraID];
_return = ["phone/config_get","POST",nil,_payload,false] call CLIENT_fnc_HTTP;

_return
// };