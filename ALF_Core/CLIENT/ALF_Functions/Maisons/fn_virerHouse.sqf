private["_house","_uid","_action","_houseCfg"];
_house = param [0,objNull,[objNull]];
_proprio = param [1,""];

if (isNull _house) exitWith {};
if !(_house isKindOf "House_F") exitWith {};
closeDialog 0;

private _isPresent = true;
private _uid = _house getVariable "uid";
private _unit = playableUnits param [playableUnits findIf {getPlayerUID _x isEqualTo _proprio}, objNull];

if(isNull _unit) then {
	_isPresent = false;
	
};

_action = 
[
	"Confirmez-vous d'expulser les habitants de cette maison ?",
	"PREFECTURE",
	"CONFIRMEZ",localize "STR_Global_Cancel"
] call BIS_fnc_guiMessage;

if(_action) then 
{
	[_house,getposatl _house,typeof _house] remoteExecCall ["ALF_Server_fnc_sellHouse",2];
	
if (_isPresent) then {
	[_house,_uid] remoteExecCall ["ALF_fnc_bevirerHouse",_unit];
};
	
	_house setVariable ["uid",nil];

	[name player,getPlayerUID player,"PREF",format["A expulsé le proprio | POS : %1 | MAISON : %2 | PROPRIO : %3", getPos _house, typeOf _house, _proprio]] remoteExec ["ALF_Server_fnc_logIt",2];

	["PREFECTURE","Vous avez expulsé les habitants du logement","success"] call ALF_fnc_doMsg;

	[_house,getposatl _house,typeof _house] remoteExecCall ["ALF_Server_fnc_sellHousemobilier",2];
};
