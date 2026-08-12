// ALF_fnc_removeMobilier = {
private["_house","_action","_mobilier","_mobilierType","_mobiliers"];
_mobilier = param [0,objNull,[objNull]];


private _house = lineIntersectsSurfaces [getPosworld player vectorAdd [0,0,7],getPosworld player vectorAdd [0,0,-0.5],player,player,true,1,"GEOM","NONE"] # 0 # 3;

if (isnil {_house}) exitWith {["MOBILIER","Vous n'êtes pas dans une maison.","warning"] spawn ALF_fnc_doMsg;};

private _inventaire_Meuble = _mobilier getVariable ["gear",[]];
if (_inventaire_Meuble isNotequalto []) exitwith {["MOBILIER","Le mobilier doit être vide avant de pouvoir être retiré.","warning"] spawn ALF_fnc_doMsg;};

// Le check de propriété est fait côté serveur (fix appartements)
if (isNull _mobilier) exitWith {};
closeDialog 0;

_action = ["Voulez-vous enlever ce mobilier ?","Mobilier","OUI","NON"] call BIS_fnc_guiMessage;
if (_action) then 
{
	if (((getModelInfo _mobilier) # 1) isEqualTo "alf_batiments\alf_h_cocaine\alf_coco.p3d") exitWith 
	{
		private _upp = "Destruction de l'atelier ...";
		life_action_inUse = true;
		disableSerialization;

		5 cutRsc ["life_progress","PLAIN"];

		private _ui = uiNamespace getVariable "life_progress";
		private _progress = _ui displayCtrl 38201;
		private _pgText = _ui displayCtrl 38202;
		_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
		_progress progressSetPosition 0.01;
		private _cP = 0.01;

		for "_i" from 0 to 1 step 0 do 
		{
			if (isNull _mobilier) exitWith {};
			if (animationState player isnotequalto "AinvPknlMstpSnonWnonDnon_medic_1") then 
			{
				player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
				player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
			};

			sleep 0.27;

			_cP = _cP + 0.015;
			_progress progressSetPosition _cP;
			_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];

			if (_cP >= 1) exitWith {};
			if (!alive player) exitWith {};
			if (player isnotequalto vehicle player) exitWith {};
			if (life_interrupted) exitWith {};
		};

		life_action_inUse = false;
		5 cutText ["","PLAIN"];
		player playActionNow "stop";

		if (isNull _mobilier) exitWith {};
		if !(alive player) exitWith {};
		if (player isnotequalto vehicle player) exitWith {};
		if (life_interrupted) exitWith {life_interrupted = false; titleText["Action annulé.","PLAIN"];};

		[_mobilier,_house,getPlayerUID player] remoteExecCall ["ALF_Server_fnc_deleteDBmobilier",2];
		[name player,getPlayerUID player,"MAISON",format["A récupéré un atelier de cocaine | POS : %1 | MAISON : %2", getPos _mobilier, typeOf _house]] remoteExec ["ALF_Server_fnc_logIt",2];
	};

	private "_item";
	if (((getModelInfo _mobilier) # 1) isEqualTo "alf_mobiliers\alf_barrel\barrel.p3d") then {_item = "ALF_Barrel_boite";};
	if (((getModelInfo _mobilier) # 1) isEqualTo "alf_mobiliers\alf_security\alf_security.p3d") then {_item = "M_ALF_Security_boite";};

	private _name = _mobilier getVariable ["mobilier_name",""];
	private _classname = "";
	if (_name isEqualTo "") then 
	{
		_array = "true" configClasses (configFile >> "CfgVehicles");
		_model = ((getModelInfo _mobilier) # 1) select [0, count (getModelInfo _mobilier select 1) - 4];

		{
			if ((toLower (getText (_x >> "model"))) find (toLower (_model)) > -1) exitWith {_classname = configName _x;};
		} forEach _array;

		if (_classname isEqualTo "") exitWith {};
		_name = _classname;
	};
	if (_name isEqualTo "") exitWith {};

	{
		private _itemName = ["STRING", ["ALFCfgMobiliers", _x, "item"]] call ALFTools_Client_Config_fnc_getConfig;
		if (_itemName isEqualTo _name) exitWith {_item = _x};
	} forEach ALF_Mobiliers_Items;

	if (_item isNotEqualTo "") then 
	{
		[_item,true] spawn ALF_fnc_handleItem;
		[name player,getPlayerUID player,"MAISON",format["A récupéré un meuble | Item : %1 | POS : %2 | MAISON : %3", _item, getPos _mobilier, typeOf _house]] remoteExec ["ALF_Server_fnc_logIt",2];
	} else 
	{
		[name player,getPlayerUID player,"MAISON",format["A récupéré un meuble | Item : PAS RECUP | POS : %1 | MAISON : %2", getPos _mobilier, typeOf _house]] remoteExec ["ALF_Server_fnc_logIt",2];
	};

	[_mobilier,_house,getPlayerUID player] remoteExecCall ["ALF_Server_fnc_deleteDBmobilier",2];
};
// };