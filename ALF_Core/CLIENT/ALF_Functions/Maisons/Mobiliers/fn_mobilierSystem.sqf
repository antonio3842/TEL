// ALF_fnc_mobilierSystem = {
params[["_kit","",[""]]];
if(_kit isEqualTo "") exitWith {};

private _batiment = lineIntersectsSurfaces [getPosworld player vectorAdd [0,0,7],getPosworld player vectorAdd [0,0,0-0.5],player,player,true,1,"GEOM","NONE"] # 0 # 3;

if (isnull _batiment) exitWith {["Attention", "Vous n'êtes pas dans un bâtiment.", "warning", false] spawn ALF_fnc_doMsg;};

if (((player getVariable ["isEmployed",""]) isEqualTo "") AND {_kit isEqualTo "ALF_Conteneur_Ent_boite"}) exitWith 
{
	["ERREUR", "Vous devez faire parti d'une entreprise pour placer ce mobilier.", "danger"] spawn ALF_fnc_doMsg;
};

if (_batiment getVariable ["business",[]] isEqualTo [] AND {_kit isEqualTo "ALF_Conteneur_Ent_boite"}) exitWith 
{
	["ERREUR", "Ce meuble est réservé aux entreprises.", "danger"] spawn ALF_fnc_doMsg;
};

life_mobilier_activeHouse = _batiment;

[_kit,false] spawn ALF_fnc_handleItem;

private _3dkit = createVehicle ["groundweaponholder", [0,0,0], [], 0, "CAN_COLLIDE"];
_3dkit attachTo [player,[0,1.5,0.7]];
_3dkit addMagazineCargoGlobal [_kit,1];

private _upp = "Montage du mobilier";
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
	if(isNull _3dkit OR {count(magazineCargo _3dkit) isEqualTo 0}) exitWith {};
	if(animationState player isNotEqualTo "AinvPknlMstpSnonWnonDnon_medic_1") then 
	{
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};
	sleep 0.27;
	// sleep 0.01;
	_cP = _cP + 0.035;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if (_cP >= 1) exitWith {player playMoveNow "amovpercmstpsnonwnondnon";};
	if !(alive player) exitWith {};
	if (player isNotEqualTo vehicle player) exitWith {};
	if (life_interrupted) exitWith {};
};
life_action_inUse = false;
5 cutText ["","PLAIN"];
player playActionNow "stop";

if(isNull _3dkit OR {(count magazineCargo _3dkit) isEqualTo 0}) exitWith 
{
	life_interrupted = false;
	titleText["Action annulé.","PLAIN"]; 
	if !(isNull _3dkit) then 
	{
		detach _3dkit;
		deletevehicle _3dkit;
	};
};

detach _3dkit;
deletevehicle _3dkit;

if !(alive player) exitWith {};
if (player isNotEqualTo vehicle player) exitWith {};
if (life_interrupted) exitWith 
{
	player addMagazine _kit;
	life_interrupted = false;
	titleText ["Action annulé.","PLAIN"];
};

private _name = ["STRING", ["ALFCfgMobiliers", _kit, "item"]] call ALFTools_Client_Config_fnc_getConfig;
if (isNil "ALF_Mobiliers_Objects" OR {isNil "ALF_Mobiliers_Objects_Data"}) exitWith {titleText ["Erreur: Variables mobiliers non chargées.","PLAIN"];};
private _index = ALF_Mobiliers_Objects find _name;
if (_index isEqualTo -1) exitWith {};
private _data = ALF_Mobiliers_Objects_Data # _index;

private "_object";
// if(_name isEqualTo "Land_ALF_Plante_W_2") then 
// {

_object = _name createVehicle [0,0,0];

_object allowDammage false;
_object enablesimulation false;
[_object,true] remoteExec ["lockInventory",0,true];
[_object,true] remoteExecCall ["enableDynamicSimulation",2];
if (isnull _object) then
{
	_object = createSimpleObject [_data,[0,0,0]];
};

if (isnull _object) exitwith {['sortie truc deconnatn'] remoteExec ['systemchat',0];};

_object setPosWorld [(getPosWorld _3dkit) # 0,(getPosWorld _3dkit) # 1,((getPosWorld _3dkit) # 2) + 0.01];
_object setDir (getdir player);

life_mobilier_active = true;

life_mobilier_activeName = _name;
life_mobilier_activeObj = _object;
life_mobilier_activeMun = _kit;

private _handle = (findDisplay 46) displayAddEventHandler ["MouseZChanged", 
{
	if (life_mobilier_active) then 
	{
		if(life_mobilier_activeObj isEqualTo objNull) exitWith {};
		private _mobilier = life_mobilier_activeObj;
		private _dir = getDir _mobilier;
		if ((_this # 1) < 0) then 
		{
			_dir = _dir - 1;
			if (_dir <= 0) then {_dir = 360;};
		} else 
		{
			_dir = _dir + 1;
			if (_dir >= 360) then {_dir = 0;};
		};

		_mobilier setDir _dir;
	};
}];

waituntil
{
	if !(life_mobilier_active) exitWith {(findDisplay 46) displayRemoveEventHandler ["MouseZChanged",_handle]; TRUE};
	if (!alive player OR {!isnull objectParent player OR {isnull _object}}) exitWith 
	{
		life_mobilier_active = false; 
		detach _object;	
		deletevehicle _object; 
		(findDisplay 46) displayRemoveEventHandler ["MouseZChanged",_handle];

		titleText ["","PLAIN"];

		TRUE
	};

	private _hauteur_Neg = (0 boundingBoxReal _batiment) # 0 # 2;
	private _hauteur_Pos = (0 boundingBoxReal _batiment) # 1 # 2;
	private _bat_Obj = lineIntersectsSurfaces [getPosworld _object vectorAdd [0,0,_hauteur_Pos],getPosworld _object vectorAdd [0,0,_hauteur_Neg],_object,_object,true,1,"GEOM","NONE"] # 0 # 3;

	if(!isnil {_bat_Obj} AND {_bat_Obj isequalto _batiment}) then 
	{
		titleText ["[ESPACE] pour placer l'object, [MOLETTE] pour l'orienter. [FLECHES] pour le déplacer. [SHIFT + FLECHES] pour la hauteur.", "PLAIN", 0];
	} else 
	{
		titleText ["[ESPACE] pour annuler, [MOLETTE] pour l'orienter. [FLECHES] pour le déplacer. [SHIFT + FLECHES] pour la hauteur.", "PLAIN", 0];
	};
	uiSleep 0.5;

	FALSE
};
// };