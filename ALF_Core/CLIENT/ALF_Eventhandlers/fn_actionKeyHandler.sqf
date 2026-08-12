/*
// ALF_fnc_actionKeyHandler = {
if (life_action_inUse) exitWith {};
if (life_interrupted) exitWith {life_interrupted = false;};
if ((time - life_action_delay) < 0.5) exitWith {};

life_action_delay = time;

if (dialog OR {(player getVariable ["ReviveMedic",false]) OR {!(alive player) OR {life_isknocked OR {life_istazed}}}}) exitWith {};
if ([player] call ALF_fnc_checkMenotter OR {[player] call ALF_fnc_checkSurrender}) exitWith {};

// Déverrouiller automatiquement les GroundWeaponHolder proches (sécurité pour éviter les blocages)
[] spawn {
	private _nearHolders = nearestObjects [player, ["GroundWeaponHolder", "WeaponHolderSimulated"], 5];
	{
		if (!isNull _x && {lockedInventory _x}) then {
			if (local _x) then {
				_x lockInventory false;
			} else {
				[_x, false] remoteExec ["lockInventory", _x];
			};
		};
	} forEach _nearHolders;
};

if (ALF_3DInteraction_Selected > -1) exitWith 
{
	_script = ["[ALF_3DInteraction_CursorObject] spawn {params [[""_target"",objNull,[objNull]]];",ALF_3DInteractionScript_Selected,"};"];
	[] spawn (compile (_script joinString ""));
};

private _curObject = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,5],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
if (isnil {_curObject}) exitwith {};

private _quitter = FALSE;

if (_quitter) exitwith {};

_quitter = [_curObject] call MRPV2_fnc_Interaction_Base;
systemChat format ["[DEBUG] actionKeyHandler: _quitter = %1, typeOf _curObject = %2", _quitter, typeof _curObject];
if (_quitter) exitwith {
	systemChat "[DEBUG] actionKeyHandler: Sortie car _quitter = TRUE";
};

if ((typeOf _curObject) in ["ALF_Brancard_P","VEH_MRP_Brancard_Vsav"] AND {alive _curObject AND {"ALF_Guardian" in (magazines player) AND {life_pompier_service}}} OR {life_penit_service AND {license_medWork AND {count (crew _curObject) > 0}}}) exitWith
{
	private _player = (crew _curObject) # 0;
	if (!isnil {_player} AND {crew _curObject isnotequalto []}) then {[_player] spawn ALF_fnc_menuGuardian;};
};

if (_curObject isKindOf "Land_ALF_radar_m") exitWith {[_curObject] spawn ALF_fnc_radarMenu;};
if (_curObject isKindOf "ALF_Poubelle") exitWith {[_curObject] call ALF_fnc_interactions_player_to_trash;};

if ([["ALF_OBJECTS", (typeOf _curObject)]]call ALFTools_Client_Config_fnc_isClass) exitWith 
{
	if !(_curObject call CBA_fnc_isTerrainObject) exitWith {[_curObject] call ALF_fnc_interactions_player_to_objects;};
};

if ((_curObject isKindOf "Land_ALF_bbq") AND {!(_curObject getVariable ["ALF_action_BBQ",false]) AND {!(_curObject call CBA_fnc_isTerrainObject)}}) exitWith 
{
	if (player canAdd "ALF_bbq_M") then 
	{
		_curObject setVariable ["ALF_action_BBQ",true,true];
		if ((_curObject animationSourcePhase "chacha_source") isEqualTo 0) then 
		{
			remoteExecCall ["", (_curObject getVariable ["ALF_bbq_JIP",""])]; 
			[3,_curObject] remoteExecCall ["ALF_fnc_barbecue",0];
		};
		[_curObject] spawn 
		{params ["_curObject"];
			uiSleep 1;
			deleteVehicle _curObject;
			["ALF_bbq_M",true] spawn ALF_fnc_handleItem;
			["INFO", "Vous avez récupéré le barbecue.", "success"] spawn ALF_fnc_doMsg;
		};
	} else 
	{
		["INFO", "Vous n'avez pas assez de place.", "danger"] spawn ALF_fnc_doMsg;
	};
};

_plant = (nearestObjects [player, ["Land_ALF_Plante_M"], 2]) # 0;
if !(isNil {_plant}) exitWith {[_plant] spawn ALF_fnc_takeMais;};

if (isNull _curObject) exitWith 
{
	private _isWater = surfaceIsWater (visiblePositionASL player);
	if (_isWater) then 
	{
		private _animalType = ["ARRAY", ["Life_Settings", "animaltypes_fish"]]call ALFTools_Client_Config_fnc_getConfig;
		private _fish = (nearestObjects[player,_animalType,3]) # 0;
		if (!isNil {_fish} AND {!alive _fish}) then {[_fish] call life_fnc_catchFish;};
	} else 
	{
		private _animalType = ["ARRAY", ["Life_Settings", "animaltypes_hunting"]]call ALFTools_Client_Config_fnc_getConfig;
		private _animal = (nearestObjects[player,_animalType,3]) # 0;
		if (!isNil {_animal} AND {!alive _animal}) then {[_animal] call ALF_fnc_gutAnimal;};
	};
};

comment "Partie pour veh, sortie si dans veh";
if !(isnull objectParent player) exitWith {};
life_action_inUse = true;

[] spawn {sleep 60;life_action_inUse = false;};

private _isVehicle = ["landVehicle","Ship","Air"] select {_curObject isKindOf _x} isNotequalto [];

if (_isVehicle) then 
{
	if !(dialog) then 
	{
		if ((player distance _curObject) < ((boundingBox _curObject # 1) # 0) + 2 AND {!(_curObject isKindOf "ALF_Don_Sang")} AND {!(_curObject isKindOf "ALF_Poubelle")}) then 
		{
			[_curObject] spawn ALF_fnc_menuVehicles;
		};
	};
} else 
{
	if((typeOf _curObject) isEqualTo "Land_Money_F" AND {!(_curObject getVariable ["inUse",false])}) then {[_curObject,player,true] remoteExecCall ["ALF_Server_fnc_pickupAction",2];};
};
// };


*/




// ALF_fnc_actionKeyHandler = {
if (life_action_inUse) exitWith {};
if (life_interrupted) exitWith {life_interrupted = false;};
if ((time - life_action_delay) < 0.5) exitWith {};

life_action_delay = time;

if (dialog OR {(player getVariable ["ReviveMedic",false]) OR {!(alive player) OR {life_isknocked OR {life_istazed}}}}) exitWith {};
if ([player] call ALF_fnc_checkMenotter OR {[player] call ALF_fnc_checkSurrender}) exitWith {};

if (ALF_3DInteraction_Selected > -1) exitWith 
{
	_script = ["[ALF_3DInteraction_CursorObject] spawn {params [[""_target"",objNull,[objNull]]];",ALF_3DInteractionScript_Selected,"};"];
	[] spawn (compile (_script joinString ""));
};

private _curObject = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,5],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
if (isnil {_curObject}) exitwith {};

private _quitter = FALSE;

if (_quitter) exitwith {};

_quitter = [_curObject] call MRPV2_fnc_Interaction_Base;
if (_quitter) exitwith {};

if ((typeOf _curObject) in ["ALF_Brancard_P","VEH_MRP_Brancard_Vsav"] AND {alive _curObject AND {"ALF_Guardian" in (magazines player) AND {life_pompier_service}}} OR {life_penit_service AND {license_medWork AND {count (crew _curObject) > 0}}}) exitWith
{
	private _player = (crew _curObject) # 0;
	if (!isnil {_player} AND {crew _curObject isnotequalto []}) then {[_player] spawn ALF_fnc_menuGuardian;};
};

if (_curObject isKindOf "Land_ALF_radar_m") exitWith {[_curObject] spawn ALF_fnc_radarMenu;};
if (_curObject isKindOf "ALF_Poubelle") exitWith {[_curObject] call ALF_fnc_interactions_player_to_trash;};

if ([["ALF_OBJECTS", (typeOf _curObject)]]call ALFTools_Client_Config_fnc_isClass) exitWith 
{
	if !(_curObject call CBA_fnc_isTerrainObject) exitWith {[_curObject] spawn MRPV2_fnc_Interaction_Objets;};
};

if ((_curObject isKindOf "Land_ALF_bbq") AND {!(_curObject getVariable ["ALF_action_BBQ",false]) AND {!(_curObject call CBA_fnc_isTerrainObject)}}) exitWith 
{
	if (player canAdd "ALF_bbq_M") then 
	{
		_curObject setVariable ["ALF_action_BBQ",true,true];
		if ((_curObject animationSourcePhase "chacha_source") isEqualTo 0) then 
		{
			remoteExecCall ["", (_curObject getVariable ["ALF_bbq_JIP",""])]; 
			[3,_curObject] remoteExecCall ["ALF_fnc_barbecue",0];
		};
		[_curObject] spawn 
		{params ["_curObject"];
			uiSleep 1;
			deleteVehicle _curObject;
			["ALF_bbq_M",true] spawn ALF_fnc_handleItem;
			["INFO", "Vous avez récupéré le barbecue.", "success"] spawn ALF_fnc_doMsg;
		};
	} else 
	{
		["INFO", "Vous n'avez pas assez de place.", "danger"] spawn ALF_fnc_doMsg;
	};
};

_plant = (nearestObjects [player, ["Land_ALF_Plante_M"], 2]) # 0;
if !(isNil {_plant}) exitWith {[_plant] spawn ALF_fnc_takeMais;};

if (isNull _curObject) exitWith 
{
	private _isWater = surfaceIsWater (visiblePositionASL player);
	if (_isWater) then 
	{
		private _animalType = ["ARRAY", ["Life_Settings", "animaltypes_fish"]]call ALFTools_Client_Config_fnc_getConfig;
		private _fish = (nearestObjects[player,_animalType,3]) # 0;
		if (!isNil {_fish} AND {!alive _fish}) then {[_fish] call life_fnc_catchFish;};
	} else 
	{
		private _animalType = ["ARRAY", ["Life_Settings", "animaltypes_hunting"]]call ALFTools_Client_Config_fnc_getConfig;
		private _animal = (nearestObjects[player,_animalType,3]) # 0;
		if (!isNil {_animal} AND {!alive _animal}) then {[_animal] call ALF_fnc_gutAnimal;};
	};
};

comment "Partie pour veh, sortie si dans veh";
if !(isnull objectParent player) exitWith {};
life_action_inUse = true;

[] spawn {sleep 60;life_action_inUse = false;};

private _isVehicle = ["landVehicle","Ship","Air"] select {_curObject isKindOf _x} isNotequalto [];

if (_isVehicle) then 
{
	if !(dialog) then 
	{
		if ((player distance _curObject) < ((boundingBox _curObject # 1) # 0) + 2 AND {!(_curObject isKindOf "ALF_Don_Sang")} AND {!(_curObject isKindOf "ALF_Poubelle")}) then 
		{
			[_curObject] spawn ALF_fnc_menuVehicles;
		};
	};
} else 
{
	if((typeOf _curObject) isEqualTo "Land_Money_F" AND {!(_curObject getVariable ["inUse",false])}) then {[_curObject,player,true] remoteExecCall ["ALF_Server_fnc_pickupAction",2];};
};
// };