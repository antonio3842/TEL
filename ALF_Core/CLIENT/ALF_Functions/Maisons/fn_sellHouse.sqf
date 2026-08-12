private["_house","_uid","_action","_houseCfg"];
_house = param [0,objNull,[objNull]];
_uid = getPlayerUID player;

if (isNull _house) exitWith {};
if !(_house isKindOf "House_F") exitWith {};
if !(_house getVariable ["ALF_PorteFermer",false]) exitWith {hint "Le batiment doit être fermer pour pouvoir vendre";};
closeDialog 0;

_houseCfg = [(typeOf _house)] call ALF_fnc_houseConfig;
if(count _houseCfg isEqualTo 0) exitWith {};

_action = 
[
	format[localize "STR_House_SellHouseMSG",(round((_houseCfg select 0)/2)) call ALF_fnc_numberText,(_houseCfg select 1)],
	localize "STR_pInAct_SellHouse",
	localize "STR_Global_Sell",localize "STR_Global_Cancel"
] call BIS_fnc_guiMessage;

if(_action) then 
{
	[_house,getposatl _house,typeof _house] remoteExecCall ["ALF_Server_fnc_sellHouse",2];

	deleteMarkerLocal format["house_%1",_house getVariable "uid"];
	_house setVariable ["uid",nil];

	life_cash = life_cash + (round((_houseCfg select 0)/2));
	[0] call SOCK_fnc_updatePartial;
	_index = life_vehicles find _house;

	if(_index != -1) then {	life_vehicles deleteAt _index;};

	_index = life_houses find (str(getPosATL _house));
	if(_index != -1) then {	life_houses deleteAt _index;};

	[name player,getPlayerUID player,"MAISON",format["A vendu un bien pour %1€ | POS : %2 | MAISON : %3.",(round((_houseCfg select 0)/2)), getPos _house, typeOf _house]] remoteExec ["ALF_Server_fnc_logIt",2];

	["MAISON",format ["Vous avez vendu la maison pour %1 €.",(round((_houseCfg select 0)/2)) call ALF_fnc_numberText],"success"] call ALF_fnc_doMsg;

	[_house,getposatl _house,typeof _house] remoteExecCall ["ALF_Server_fnc_sellHousemobilier",2];
};