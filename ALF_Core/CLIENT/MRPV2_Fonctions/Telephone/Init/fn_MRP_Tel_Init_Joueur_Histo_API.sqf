// MRPV2_fnc_MRP_Tel_Init_Joueur_Histo_API_Crea = {
private _liste_Histo_ProfileName = 123;
private _intraID = player getVariable ["intraID",-1];


_payload = format["token=%1&uid=%2",intraTOKEN,_intraID];
_return = ["phone/call_list","POST",nil,_payload,false] call CLIENT_fnc_HTTP;

_return
// };