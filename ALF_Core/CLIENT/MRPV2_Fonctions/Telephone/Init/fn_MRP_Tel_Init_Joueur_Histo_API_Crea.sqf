// MRPV2_fnc_MRP_Tel_Init_Conf_API_Crea = {
private _liste_Histo_ProfileName = param [0,[]];


private _intraID = player getVariable ["intraID",-1];
private _num = player getvariable ["phonenumber",""];

_payload = format["token=%1&uid=%2&number=%3&config=%4",intraTOKEN,_intraID,_num,_config_Tel];
_return = ["phone/config_create","POST",nil,_payload,false] call CLIENT_fnc_HTTP;
// };