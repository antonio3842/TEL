#define FDISPLAY(ctrl) ((findDisplay 4202) displayCtrl ctrl)

#define PgV(var) (tmp_medical_player getVariable var)

#define getMInjuryNumber(var,var2) (getNumber (missionConfigFile >> "MEDICAL_injuries" >> var >> var2))
#define getMInjuryText(var,var2) (getText (missionConfigFile >> "MEDICAL_injuries" >> var >> var2))

#define getMTreatmentNumber(var,var2) (getNumber (missionConfigFile >> "MEDICAL_treatment" >> var >> var2))
#define getMTreatmentText(var,var2) (getText (missionConfigFile >> "MEDICAL_treatment" >> var >> var2))

#define getMDrugsText(var,var2) (getText (missionConfigFile >> "MEDICAL_drugs" >> var >> var2))
#define getMDrugsNumber(var,var2) (getNumber (missionConfigFile >> "MEDICAL_drugs" >> var >> var2))

#define getMBloodsText(var,var2) (getText (missionConfigFile >> "MEDICAL_bloods" >> var >> var2))
#define getMBloodsNumber(var,var2) (getNumber (missionConfigFile >> "MEDICAL_bloods" >> var >> var2))

//--- medical
#define IDC_MEDICAL_ST_INJURIES	3245
#define IDC_MEDICAL_ST_HIST	3246
#define IDC_MEDICAL_BACK	3345
#define IDC_MEDICAL_O1		3346
#define IDC_MEDICAL_O2		3347
#define IDC_MEDICAL_O3		3348
#define IDC_MEDICAL_I_T		3353
#define IDC_MEDICAL_I_JD	3354
#define IDC_MEDICAL_I_JG	3355
#define IDC_MEDICAL_I_BG	3356
#define IDC_MEDICAL_I_BD	3357
#define IDC_MEDICAL_I_H		3358
#define IDC_MEDICAL_I_SALP	3364
#define IDC_MEDICAL_I_SANP	3365
#define IDC_MEDICAL_B_PERFU	3366
#define IDC_MEDICAL_B_INJECT	3367
#define IDC_MEDICAL_B_RED	3368
#define IDC_MEDICAL_B_POSER	3369
#define IDC_MEDICAL_B_APPLI	3370
#define IDC_MEDICAL_BACK_P1C	3371
#define IDC_MEDICAL_BACK_P1A	3372
#define IDC_MEDICAL_BACK_P1B	3373
#define IDC_MEDICAL_BACK_P21	3360
#define IDC_MEDICAL_BACK_P2A	3361
#define IDC_MEDICAL_BACK_P22	3362
#define IDC_MEDICAL_BACK_P23	3363
#define IDC_MEDICAL_B_STOP	3374
#define IDC_MEDICAL_ED_MED_VAL	3545
#define IDC_MEDICAL_LB_MED	3645
#define IDC_MEDICAL_LB_PERF	3646
#define IDC_MEDICAL_T_MED	3746
#define IDC_MEDICAL_T_PERF_SANG	3747
#define IDC_MEDICAL_T_PERF_SAL	3748
#define IDC_MEDICAL_CB_BAND	4245
#define IDC_MEDICAL_CB_ATL	4246
#define IDC_MEDICAL_CB_INJURIE	4247

createDialog "MEDICAL_2";
call CLIENT_fnc_temp_MedicalMenu_majInjuryInfos;
call CLIENT_fnc_temp_MedicalMenu_majColors;

FDISPLAY(IDC_MEDICAL_I_SANP) ctrlShow false;
FDISPLAY(IDC_MEDICAL_I_SALP) ctrlShow false;

_hasSeringue = (("MRP_Seringue_60mL_decapuchonnee" call CLIENT_fnc_countItem_classname) >= 1);
if (!_hasSeringue) then {
	FDISPLAY(IDC_MEDICAL_B_INJECT) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_BACK_P1B) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_ED_MED_VAL) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_T_MED) ctrlShow false;
};

if (tmp_medical_player == player) then 
{
	FDISPLAY(IDC_MEDICAL_BACK_P1C) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_B_PERFU) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_LB_PERF) ctrlShow false;
};
if (true && (tmp_medical_player == player)) then // && pas médecin et moi
{
	FDISPLAY(IDC_MEDICAL_B_RED) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_BACK_P23) ctrlShow false;
};

FDISPLAY(IDC_MEDICAL_O1) ctrlAddEventHandler ["ButtonClick",
{
	closeDialog 0;
	0 spawn {uisleep 0.01;[tmp_medical_player] call CLIENT_fnc_menu_medical1;};
}];
FDISPLAY(IDC_MEDICAL_O3) ctrlAddEventHandler ["ButtonClick",
{
	closeDialog 0;
	0 spawn {uisleep 0.01;[tmp_medical_player] call CLIENT_fnc_menu_medical3;};
}];

{
	FDISPLAY(_x) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_displayOrControl"];
		tmp_selectedIDCPart = (ctrlIDC _displayOrControl);
		call CLIENT_fnc_temp_MedicalMenu_majInjuryInfos;
		call CLIENT_fnc_temp_MedicalMenu_majOwnedBands;
	}];
} forEach tmp_medical_ath_partlist;

CLIENT_fnc_temp_MedicalMenu_majOwnedBands = {
	_owned_bands = [];
	_classname = [(missionConfigFile >> "MEDICAL_treatment")] call CLIENT_fnc_getClassnames_FromConfigPathsList;
	lbClear FDISPLAY(IDC_MEDICAL_CB_INJURIE);
	lbClear FDISPLAY(IDC_MEDICAL_CB_BAND);
	
	{
		_name = getMTreatmentText(_x,"name");
		_count = [_x] call CLIENT_fnc_countitem_classname;
		if (_count > 0) then {_owned_bands pushBack [format["%1 (x%2)",_name,_count],_x];};
	} forEach _classname;
	_owned_bands pushBack ["SUPPRIMER",""];
	
	{
		FDISPLAY(IDC_MEDICAL_CB_BAND) lbAdd _x#0;
		FDISPLAY(IDC_MEDICAL_CB_BAND) lbSetData [_forEachIndex,_x#1];
		FDISPLAY(IDC_MEDICAL_CB_BAND) lbSetPicture [_forEachIndex,getText (configFile >> "CfgMagazines" >> _x#1 >> "picture")];
	} forEach _owned_bands;
	_partInfo = (tmp_medical_ath_partlist get tmp_selectedIDCPart);
	_injuries_onPart = (tmp_medical_player getVariable "hitInjuries") get (_partInfo#0);
	// systemChat format["ONPART : %1",str(_injuries_onPart)];
	{
		// systemChat (_x#0);
		_name = getMInjuryText(_x#0,"name");
		FDISPLAY(IDC_MEDICAL_CB_INJURIE) lbAdd _name;
		FDISPLAY(IDC_MEDICAL_CB_INJURIE) lbSetData [_forEachIndex,str(_forEachIndex)];
	} forEach _injuries_onPart;
};
FDISPLAY(IDC_MEDICAL_CB_INJURIE) lnbSetCurSelRow 0;
FDISPLAY(IDC_MEDICAL_CB_BAND) lnbSetCurSelRow 0;
call CLIENT_fnc_temp_MedicalMenu_majOwnedBands;

FDISPLAY(IDC_MEDICAL_B_RED) ctrlAddEventHandler ["ButtonDown",
{
	params ["_displayOrControl"];
	_partInfo = (tmp_medical_ath_partlist get tmp_selectedIDCPart);
	_injuries_onPart = (tmp_medical_player getVariable "hitInjuries") get _partInfo#0;
	_index_toCompress = -1;
	// systemChat str(_injuries_onPart);
	{if (_x#0 == "FRACTURE" && _x#1 >= 0.7) exitWith {_index_toCompress = _forEachIndex;};} forEach _injuries_onPart;
	if (_index_toCompress == -1) then {systemChat "Aucune fracture à réduire";}; 
	[_partInfo#0,_index_toCompress,"REDUIRE",player] remoteExec ["CLIENT_fnc_Medical_applyHealing",tmp_medical_player];
}];
FDISPLAY(IDC_MEDICAL_B_STOP) ctrlAddEventHandler ["ButtonDown",
{
	params ["_displayOrControl"];
	_partInfo = (tmp_medical_ath_partlist get tmp_selectedIDCPart);
	_injuries_onPart = (tmp_medical_player getVariable "hitInjuries") get _partInfo#0;
	_index_toCompress = -1;
	// systemChat str(_injuries_onPart);
	{if (_x#2 == "") exitWith {_index_toCompress = _forEachIndex;};} forEach _injuries_onPart;
	tmp_medical_compression = [_index_toCompress,_partInfo#0];
	if (_index_toCompress == -1) exitWith {systemChat "Aucune blessure à compresser"};
	[_partInfo#0,_index_toCompress,"PRESSION",player] remoteExec ["CLIENT_fnc_Medical_applyHealing",tmp_medical_player];
	// systemChat format["%1 => %2",_partInfo#0,_index_toCompress];
	// systemChat 'down';
}];
FDISPLAY(IDC_MEDICAL_B_STOP) ctrlAddEventHandler ["ButtonClick",
{
	params ["_displayOrControl"];
	_partInfo = (tmp_medical_ath_partlist get tmp_selectedIDCPart);
	[_partInfo#0,tmp_medical_compression#0,"",player] remoteExec ["CLIENT_fnc_Medical_applyHealing",tmp_medical_player];
	// systemChat format["%1 => %2",_partInfo#0,tmp_medical_compression#0];
	tmp_medical_compression = nil;
	// systemChat 'click';
}];
FDISPLAY(IDC_MEDICAL_B_STOP) ctrlAddEventHandler ["ButtonUp",
{
	params ["_displayOrControl"];
	_partInfo = (tmp_medical_ath_partlist get tmp_selectedIDCPart);
	[_partInfo#0,tmp_medical_compression#0,"",player] remoteExec ["CLIENT_fnc_Medical_applyHealing",tmp_medical_player];
	// systemChat format["%1 => %2",_partInfo#0,tmp_medical_compression#0];
	tmp_medical_compression = nil;
	// systemChat 'up';
}];

FDISPLAY(IDC_MEDICAL_B_APPLI) ctrlAddEventHandler ["ButtonClick",
{
	params ["_displayOrControl"];
	_partInfo = (tmp_medical_ath_partlist get tmp_selectedIDCPart);
	_index = parseNumber (FDISPLAY(IDC_MEDICAL_CB_INJURIE) lbData (lbCurSel FDISPLAY(IDC_MEDICAL_CB_INJURIE)));
	_classname = FDISPLAY(IDC_MEDICAL_CB_BAND) lbData (lbCurSel FDISPLAY(IDC_MEDICAL_CB_BAND));
	[_partInfo#0,_index,_classname,player] remoteExec ["CLIENT_fnc_Medical_applyHealing",tmp_medical_player];
	// systemChat format["%1 => %2 => %3",_partInfo#0,_index,_classname];
	player removeItem _classname;
	call CLIENT_fnc_temp_MedicalMenu_majOwnedBands;
}];

FDISPLAY(IDC_MEDICAL_B_INJECT) ctrlAddEventHandler ["ButtonClick",
{
	params ["_displayOrControl"];

	_list_seringue = (["MRP_Seringue_60mL_decapuchonnee"] call CLIENT_fnc_getCountMagazines_byContainer_forClassname);
	_seringueIdx = -1;
	if (count (_list_seringue#2) >= 1) then {_seringueIdx = 2;};
	if (count (_list_seringue#1) >= 1) then {_seringueIdx = 1;};
	if (count (_list_seringue#0) >= 1) then {_seringueIdx = 0;};
	if (_seringueIdx == -1) exitWith {systemChat "Injection Impossible : pas de seringue décapuchonnée"};
	_seringueCharges = _list_seringue#_seringueIdx#0#1;

	_datas_array = (FDISPLAY(IDC_MEDICAL_LB_MED) lbData (lbCurSel FDISPLAY(IDC_MEDICAL_LB_MED))) splitString "|";
	if (count _datas_array == 0) exitWith {}; // empty
	// systemChat str(_datas_array);
	_classname = _datas_array#0;
	_name_pd = getMDrugsText(_classname,"name");
	_containerIdx = parseNumber (_datas_array#1);
	_actualNB = parseNumber (_datas_array#2);
	_injectedNB = ctrlText FDISPLAY(IDC_MEDICAL_ED_MED_VAL);
	// systemChat str(_targetNB);
	if ((_injectedNB find ",") != -1) exitWith {systemChat "Dosage incorrect : utilisez x.xx à la place de x,xx !"};
	_injectedNB = parseNumber _injectedNB; 
	if (_injectedNB <= 0) exitWith {systemChat "Injection Impossible : impossible de RIEN injecter !"};
	if (_injectedNB > 60) exitWith {systemChat "Dosage incorrect : impossible de remplir la seringue avec plus de 50mL !"};
	_actualNBtoScript = round (_actualNB);
	if (_injectedNB > _actualNBtoScript/10) then {_injectedNB = _actualNBtoScript/10};
	_targetNBtoScript = round (_actualNB-(_injectedNB * 10)); // "mL" to magazineNB
	// systemChat format["%1(%4) : %2 => %3",_classname,_actualNBtoScript,_targetNBtoScript,_containerIdx];
	_isok = [_classname,_actualNBtoScript,_targetNBtoScript,_containerIdx] call CLIENT_fnc_modifyMagazine_wClassname;
	if (!_isok) exitWith {};

	["MRP_Seringue_60mL_decapuchonnee",_seringueCharges,_seringueCharges-1,_seringueIdx] call CLIENT_fnc_modifyMagazine_wClassname;
	[_classname,_injectedNB] remoteExec ["CLIENT_fnc_Medical_addDrugs",tmp_medical_player]; // ["MRP_Adrenaline",0.1] remoteExec ["CLIENT_fnc_MedicalAddDrugs",player];
	_injected_str = format["injecté %1 mL de %2",_injectedNB,_name_pd];
	systemChat format["%1=>%2",_actualNBtoScript,_targetNBtoScript];
	[player,_injected_str] remoteExec ["CLIENT_fnc_Medical_addToHistory",tmp_medical_player];
	call CLIENT_fnc_temp_MedicalMenu_majLiquids;
	FDISPLAY(IDC_MEDICAL_ED_MED_VAL) ctrlSetText "";
	FDISPLAY(IDC_MEDICAL_T_MED) ctrlSetText "";
}];

FDISPLAY(IDC_MEDICAL_LB_MED) ctrlAddEventHandler ["LBSelChanged",
{
	params ["_control", "_selectedIndex"];
	_datas_array = (_control lbData _selectedIndex) splitString "|";
	_classname = _datas_array#0;
	_name = getMDrugsText(_classname,"name");
	FDISPLAY(IDC_MEDICAL_T_MED) ctrlSetText _name;
}];

CLIENT_fnc_temp_MedicalMenu_majLiquids = {
	lbClear FDISPLAY(IDC_MEDICAL_LB_MED);
	_allLiquids = [(missionConfigFile >> "MEDICAL_drugs")] call CLIENT_fnc_getClassnames_FromConfigPathsList;
	_allLiquidsSorted = [];
	{
		// systemChat str(getMDrugsNumber(_x,"canBeInjected"));
		if (getMDrugsNumber(_x,"canBeInjected") == 1) then {_allLiquidsSorted pushBack _x};		
	} forEach _allLiquids;
	_inUniform = [];
	_inVest = [];
	_inBackpack = [];

	{
		_return = [_x] call CLIENT_fnc_getCountMagazines_byContainer_forClassname;
		_inUniform append _return#0;
		_inVest append _return#1;
		_inBackpack append _return#2;
	} forEach _allLiquidsSorted;

	if (count _inUniform == 0 && count _inVest == 0 && count _inBackpack == 0) exitWith {
		FDISPLAY(IDC_MEDICAL_BACK_P1A) ctrlShow false;
		FDISPLAY(IDC_MEDICAL_LB_MED) ctrlShow false;
	};
	FDISPLAY(IDC_MEDICAL_BACK_P1A) ctrlShow true;
	FDISPLAY(IDC_MEDICAL_LB_MED) ctrlShow true;

	{
		_name = getMDrugsText(_x#0,"name");
		_idx = FDISPLAY(IDC_MEDICAL_LB_MED) lbAdd format["%1 (%2/%3mL)",_name,_x#1/10,_x#2/10];
		FDISPLAY(IDC_MEDICAL_LB_MED) lbSetPicture [_idx,getText (configFile >> "CfgMagazines" >> _x#0 >> "picture")];
		_datas = format["%1|0|%2",_x#0,_x#1];
		FDISPLAY(IDC_MEDICAL_LB_MED) lbSetData [_idx,_datas];
	} forEach _inUniform;
	{
		_name = getMDrugsText(_x#0,"name");
		_idx = FDISPLAY(IDC_MEDICAL_LB_MED) lbAdd format["%1 (%2/%3mL)",_name,_x#1/10,_x#2/10];
		FDISPLAY(IDC_MEDICAL_LB_MED) lbSetPicture [_idx,getText (configFile >> "CfgMagazines" >> _x#0 >> "picture")];
		_datas = format["%1|1|%2",_x#0,_x#1];
		FDISPLAY(IDC_MEDICAL_LB_MED) lbSetData [_idx,_datas];
	} forEach _inVest;
	{
		_name = getMDrugsText(_x#0,"name");
		_idx = FDISPLAY(IDC_MEDICAL_LB_MED) lbAdd format["%1 (%2/%3mL)",_name,_x#1/10,_x#2/10];
		FDISPLAY(IDC_MEDICAL_LB_MED) lbSetPicture [_idx,getText (configFile >> "CfgMagazines" >> _x#0 >> "picture")];
		_datas = format["%1|2|%2",_x#0,_x#1];
		FDISPLAY(IDC_MEDICAL_LB_MED) lbSetData [_idx,_datas];
	} forEach _inBackpack;
};
call CLIENT_fnc_temp_MedicalMenu_majLiquids;

CLIENT_fnc_temp_MedicalMenu_majOwnedBloods = {
	_owned_bloods = [];
	_classname = [(missionConfigFile >> "MEDICAL_bloods")] call CLIENT_fnc_getClassnames_FromConfigPathsList;
	lbClear FDISPLAY(IDC_MEDICAL_LB_PERF);
	
	{
		_name = getMBloodsText(_x,"name");
		_count = [_x] call CLIENT_fnc_countitem_classname;
		if (_count > 0) then {_owned_bloods pushBack [format["%1 (x%2)",_name,_count],_x];};
	} forEach _classname;

	if (count _owned_bloods == 0) exitWith {
		FDISPLAY(IDC_MEDICAL_BACK_P1C) ctrlShow false;
		FDISPLAY(IDC_MEDICAL_B_PERFU) ctrlShow false;
		FDISPLAY(IDC_MEDICAL_LB_PERF) ctrlShow false;
	};
	
	{
		FDISPLAY(IDC_MEDICAL_LB_PERF) lbAdd _x#0;
		FDISPLAY(IDC_MEDICAL_LB_PERF) lbSetData [_forEachIndex,_x#1];
		FDISPLAY(IDC_MEDICAL_LB_PERF) lbSetPicture [_forEachIndex,getText (configFile >> "CfgMagazines" >> _x#1 >> "picture")];
	} forEach _owned_bloods;
};
FDISPLAY(IDC_MEDICAL_LB_PERF) lnbSetCurSelRow 0;
call CLIENT_fnc_temp_MedicalMenu_majOwnedBloods;

CLIENT_fnc_temp_MedicalMenu_majBloodsOnPlayer = {
	_bloodML = PgV("BLOOD_OUT");
	_salineML = PgV("SALINE_OUT");
	if (_bloodML > 0) then {
		FDISPLAY(IDC_MEDICAL_I_SANP) ctrlShow true;
		FDISPLAY(IDC_MEDICAL_T_PERF_SANG) ctrlSetText (_bloodML toFixed 0);
	} 
	else {
		FDISPLAY(IDC_MEDICAL_I_SANP) ctrlShow false;
		FDISPLAY(IDC_MEDICAL_T_PERF_SANG) ctrlSetText "";
	};

	if (_salineML > 0) then {
		FDISPLAY(IDC_MEDICAL_I_SALP) ctrlShow true;
		FDISPLAY(IDC_MEDICAL_T_PERF_SAL) ctrlSetText (_salineML toFixed 0);
	} 
	else {
		FDISPLAY(IDC_MEDICAL_I_SALP) ctrlShow false;
		FDISPLAY(IDC_MEDICAL_T_PERF_SAL) ctrlSetText "";
	};
};

FDISPLAY(IDC_MEDICAL_B_PERFU) ctrlAddEventHandler ["ButtonClick",
{
	params ["_displayOrControl"];
	_className = (FDISPLAY(IDC_MEDICAL_LB_PERF) lbData (lbCurSel FDISPLAY(IDC_MEDICAL_LB_PERF)));
	_count = [_className] call CLIENT_fnc_countitem_classname;
	if (_count == 0) exitWith {systemChat "Perfusion inexistante ?"};
	[_className,player] remoteExec ["CLIENT_fnc_Medical_addBloods",tmp_medical_player];
	player removeItem _classname;
	call CLIENT_fnc_temp_MedicalMenu_majOwnedBloods;
}];

FDISPLAY(IDC_MEDICAL_I_SANP) ctrlAddEventHandler ["ButtonClick",
{
	params ["_displayOrControl"];
	["sang",player] remoteExec ["CLIENT_fnc_Medical_removeBloods",tmp_medical_player];
}];

FDISPLAY(IDC_MEDICAL_I_SALP) ctrlAddEventHandler ["ButtonClick",
{
	params ["_displayOrControl"];
	["saline",player] remoteExec ["CLIENT_fnc_Medical_removeBloods",tmp_medical_player];
}];

[] spawn {
	while {(!isNull findDisplay 4202)} do 
	{
		call CLIENT_fnc_temp_MedicalMenu_majBloodsOnPlayer;
		call CLIENT_fnc_temp_MedicalMenu_majOwnedBands;
		uiSleep 0.25;
	};
};

[] spawn {
	waitUntil {(isNull findDisplay 4202)}; 
	systemChat "MEDICAL MENU 2 CLOSED";
	if (!isNil "tmp_medical_compression") then {
		[tmp_medical_compression#1,tmp_medical_compression#0,"",player] remoteExec ["CLIENT_fnc_Medical_applyHealing",tmp_medical_player];
	};
	tmp_medical_compression = nil;
};