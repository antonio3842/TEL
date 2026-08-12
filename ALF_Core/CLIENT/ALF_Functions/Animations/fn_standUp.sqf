// ALF_fnc_standUp = {
private _obj = param [0,objnull];
if (isNull _obj) exitWith {};

[player, ""] remoteExecCall ["ALF_fnc_switchMove",0];
player removeAction standup;
jesuisassis = false;
private _pos = MRPV2_Pos_Avant_Assis_Siege # 0;
private _dir = MRPV2_Pos_Avant_Assis_Siege # 1;
player setPosATL _pos;
player setDir (_dir + 180);
MRPV2_Pos_Avant_Assis_Siege = nil;
// };