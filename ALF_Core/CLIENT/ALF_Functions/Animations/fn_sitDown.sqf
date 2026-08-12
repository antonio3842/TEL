// ALF_fnc_sitDown = {
private _obj = param [0, objNull, [objNull]];
private _pos = param [1, "", [""]];

if (isNull _obj OR {_pos isEqualTo ""}) exitWith {};

private _pos2 = getPosATL _obj;

MRPV2_Pos_Avant_Assis_Siege = [getPosATL player, getDir player];

[player, "Crew"] remoteExecCall ["ALF_fnc_switchMove", 0];
player setPosATL _pos2;
player setDir (getDir _obj + 180);
jesuisassis = true;

standup = player addAction ["<t color='#0099FF'>Se lever</t>", ALF_fnc_standUp, _obj];
// };