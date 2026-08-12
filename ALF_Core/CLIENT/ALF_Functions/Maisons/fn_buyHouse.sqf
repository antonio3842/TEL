// ALF_fnc_buyHouse = {

_house = param [0,objNull,[objNull]];
private _uid = getPlayerUID player;

if (isNull _house) exitWith {};
if !(_house isKindOf "House_F") exitWith {};
// Vérifier si la maison a un propriétaire (house_owner) plutôt que ALF_PorteFermer
if !(isNil {_house getVariable "house_owner"}) exitWith {hint localize "STR_House_alreadyOwned";};
if !(license_home) exitWith {hint localize "STR_House_License"};
private _houseLimitC = ["NUMBER", ["Life_Settings", "house_limit"]] call ALFTools_Client_Config_fnc_getConfig;
if (life_donOR) then {
	_houseLimitC = ["NUMBER", ["Life_Settings", "house_limit_donor"]] call ALFTools_Client_Config_fnc_getConfig;
};
if (count life_houses >= _houseLimitC) exitWith {hint format[localize "STR_House_Max_House",_houseLimitC]};
if ((typeOf(_house) isEqualTo "Land_i_Shed_Ind_F") AND count(nearestObjects[player, ["Land_tailleuse","Tank"], 60]) > 0) exitWith {["ERREUR","Ce batiment est interdit à l'achat.","warning"] spawn ALF_fnc_doMsg;};
closeDialog 0;

private _houseCfg = [(typeOf _house)] call ALF_fnc_houseConfig;
if(count _houseCfg isEqualTo 0) exitWith {};

private _action = 
[
	format[localize "STR_House_BuyMSG",
	[(_houseCfg # 0)] call ALF_fnc_numberText,
	(_houseCfg # 1)],localize "STR_House_Purchase",localize "STR_Global_Buy",localize "STR_Global_Cancel"
] call BIS_fnc_guiMessage;

if(_action) then 
{
	private _handle = [(_houseCfg # 0),false] call ALF_fnc_handleCB;
	if (_handle) exitWith {};

	[_uid,_house,profileName,getposatl _house,typeof _house] remoteExec ["ALF_Server_fnc_addHouse",2];
	[0] call SOCK_fnc_updatePartial;

	[name player,getPlayerUID player,"MAISON",format["A acheté un bien pour %1€ | POS : %2 | MAISON : %3.",(_houseCfg # 0), getPos _house, typeOf _house]] remoteExec ["ALF_Server_fnc_logIt",2];

	_house setVariable ["uid",floor(random 99999)];

	life_vehicles pushBack _house;
	life_houses pushBack (str(getPosATL _house));
	private _marker = createMarkerLocal [format["house_%1",(_house getVariable "uid")],getPosATL _house];
	private _houseName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >>  "displayName");
	_marker setMarkerTextLocal _houseName;
	_marker setMarkerColorLocal "ColorBlue";
	_marker setMarkerTypeLocal "loc_Lighthouse";

	_house setVariable ["ALF_PorteFermer",true,true];
};
// };