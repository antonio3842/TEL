/*
	File: fn_distrib_restockMenu.sqf
	Ouvre le menu réappro distributeur (Snickers / Eau + [+]).
	Doit être appelé depuis un spawn après closeDialog.
*/
disableSerialization;

uiNamespace setVariable ["MRP_Distrib_RestockOpen", false];
uiNamespace setVariable ["MRP_Distrib_RestockButtons", createHashMap];
uiNamespace setVariable ["MRP_Distrib_RestockGroup", controlNull];
uiNamespace setVariable ["MRP_Distrib_RestockLayout", nil];

private _machine = uiNamespace getVariable ["MRP_Distrib_RestockMachine", objNull];

if (isNull _machine) then {
	_machine = missionNamespace getVariable ["life_pInact_curObject", objNull];
	if (isNull _machine || {!([_machine] call ALF_fnc_distrib_isMachine)}) exitWith {
		["Distributeur", "Aucune machine sélectionnée.", "warning"] spawn ALF_fnc_doMsg;
	};
	uiNamespace setVariable ["MRP_Distrib_RestockMachine", _machine];
};

[_machine] call ALF_fnc_distrib_stockEnsure;

if (!createDialog "MRPV2_Interface_Diverse") exitWith {
	["Distributeur", "Impossible d'ouvrir le menu réappro.", "warning"] spawn ALF_fnc_doMsg;
};

private _timeout = time + 3;
waitUntil {
	!isNull (uiNamespace getVariable ["MRPV2_Interface_Diverse", controlNull]) || {time > _timeout}
};

private _display = uiNamespace getVariable ["MRPV2_Interface_Diverse", controlNull];
if (isNull _display) exitWith {
	["Distributeur", "Interface réappro indisponible.", "warning"] spawn ALF_fnc_doMsg;
};

private _layout = call ALF_fnc_distrib_restockCalcLayout;
uiNamespace setVariable ["MRP_Distrib_RestockLayout", _layout];

private _ctrlGroupRestock = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
uiNamespace setVariable ["MRP_Distrib_RestockGroup", _ctrlGroupRestock];
_ctrlGroupRestock ctrlSetPosition [-0.7, safeZoneY, safeZoneW, safeZoneH];
_ctrlGroupRestock ctrlCommit 0;

_ctrlGroupRestock ctrlAddEventHandler ["Destroy", {
	uiNamespace setVariable ["MRP_Distrib_RestockOpen", false];
	uiNamespace setVariable ["MRP_Distrib_RestockGroup", controlNull];
	uiNamespace setVariable ["MRP_Distrib_RestockButtons", createHashMap];
}];

private _ctrlFond = _display ctrlCreate ["RscPicture", -1, _ctrlGroupRestock];
_ctrlFond ctrlSetText "\MRPV2_Texture\asset\Menu_Inter_V2.paa";
_ctrlFond ctrlSetPosition [0.78, 0.4, 0.9, 1.2];
_ctrlFond ctrlEnable false;
_ctrlFond ctrlCommit 0;

uiNamespace setVariable ["MRP_Distrib_RestockOpen", true];
[] call ALF_fnc_distrib_restockRefresh;
