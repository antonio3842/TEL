#define FDISPLAY(ctrl) ((findDisplay 4201) displayCtrl ctrl)
#define FDISPLAY_2(ctrl) ((findDisplay 4202) displayCtrl ctrl)
#define FDISPLAY_3(ctrl) ((findDisplay 4203) displayCtrl ctrl)

#define PgV(var) (tmp_medical_player getVariable var)

#define getMInjuryNumber(var,var2) (getNumber (missionConfigFile >> "MEDICAL_injuries" >> var >> var2))
#define getMInjuryText(var,var2) (getText (missionConfigFile >> "MEDICAL_injuries" >> var >> var2))
#define getMTreatmentNumber(var,var2) (getNumber (missionConfigFile >> "MEDICAL_treatment" >> var >> var2))
#define getMTreatmentText(var,var2) (getText (missionConfigFile >> "MEDICAL_treatment" >> var >> var2))

//--- medical
#define IDC_MEDICAL_ST_INJURIES	3245
#define IDC_MEDICAL_ST_HIST	3246
#define IDC_MEDICAL_O1		3346
#define IDC_MEDICAL_O2		3347
#define IDC_MEDICAL_O3		3348
#define IDC_MEDICAL_I_T		3353
#define IDC_MEDICAL_I_JD	3354
#define IDC_MEDICAL_I_JG	3355
#define IDC_MEDICAL_I_BG	3356
#define IDC_MEDICAL_I_BD	3357
#define IDC_MEDICAL_I_H		3358
#define IDC_MEDICAL_B_1		3359
#define IDC_MEDICAL_B_2		3360
#define IDC_MEDICAL_B_3		3361
#define IDC_MEDICAL_E_1		3545
#define IDC_MEDICAL_E_2		3546
#define IDC_MEDICAL_E_3		3547
#define IDC_MEDICAL_E_4		3548
#define IDC_MEDICAL_E_5		3549
#define IDC_MEDICAL_E_6		3550
#define IDC_MEDICAL_E_7		3551
#define IDC_MEDICAL_E_8		3552
#define IDC_MEDICAL_E_9		3553
#define IDC_MEDICAL_E_10	3554
#define IDC_MEDICAL_T_BPM	3745
#define IDC_MEDICAL_T_PA	3746
#define IDC_MEDICAL_T_VENT	3747
#define IDC_MEDICAL_CK_1	4945
#define IDC_MEDICAL_CK_2	4946
#define IDC_MEDICAL_CK_3	4947

params [["_player",player]];
tmp_medical_player = _player;
if (tmp_medical_player != player) then {[tmp_medical_player,clientOwner] remoteExec ["CLIENT_fnc_subscribeMe",tmp_medical_player];};
waitUntil {!isnil {_player getVariable "BPM"};};

if (isNil "tmp_selectedIDCPart") then {tmp_selectedIDCPart = IDC_MEDICAL_I_H;};

createDialog "MEDICAL_1";
if (!isNil "CLIENT_fnc_temp_MedicalMenu_majInjuryInfos") then {call CLIENT_fnc_temp_MedicalMenu_majInjuryInfos;};
if (!isNil "CLIENT_fnc_temp_MedicalMenu_majColors") then {call CLIENT_fnc_temp_MedicalMenu_majColors;};

_hasTensiometre = (("MRP_Tensiometre" call CLIENT_fnc_countItem_classname) >= 1);
if (!_hasTensiometre) then {
	FDISPLAY(IDC_MEDICAL_B_2) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_T_PA) ctrlShow false;
};
_hasGlycometre = (("MRP_Lecteur_glycemie" call CLIENT_fnc_countItem_classname) >= 1);
if (!_hasGlycometre) then {
	FDISPLAY(IDC_MEDICAL_B_3) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_T_VENT) ctrlShow false;
};

FDISPLAY(IDC_MEDICAL_O2) ctrlAddEventHandler ["ButtonClick",
{
	closeDialog 0;
	0 spawn {uisleep 0.01;[tmp_medical_player] call CLIENT_fnc_menu_medical2;};
}];
FDISPLAY(IDC_MEDICAL_O3) ctrlAddEventHandler ["ButtonClick",
{
	closeDialog 0;
	0 spawn {uisleep 0.01;[tmp_medical_player] call CLIENT_fnc_menu_medical3;};
}];

FDISPLAY(IDC_MEDICAL_B_1) ctrlAddEventHandler ["ButtonClick",
{
	params ["_control"];
	if (!isNil "temp_medical_priseCONST") exitWith {};
	[] spawn {
		temp_medical_priseCONST = true;
		FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetText "."; sleep 2;
		FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetText ".."; sleep 2;
		FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetText "..."; sleep 2;
		FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetText "...."; sleep 2;
		FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetText "....."; sleep 2;
		_str = str(round(tmp_medical_player getVariable "BPM"));
		if (PgV("isFIB")) then {_str = "?";};
		FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetText _str;
		[player,format["pris le pouls (%1 BPM)",_str]] remoteExec ["CLIENT_fnc_Medical_addToHistory",tmp_medical_player];
		temp_medical_priseCONST = nil;
	};
}];
FDISPLAY(IDC_MEDICAL_B_2) ctrlAddEventHandler ["ButtonClick",
{
	params ["_control"];
	if (!isNil "temp_medical_priseCONST") exitWith {};
	[] spawn {
		temp_medical_priseCONST = true;
		[player,"m_prise_pa",150] remoteExecCall ["SERVER_fnc_globalSay3d",2];
		FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetText "";
		FDISPLAY(IDC_MEDICAL_T_PA) ctrlSetText "."; sleep 3;
		FDISPLAY(IDC_MEDICAL_T_PA) ctrlSetText ".."; sleep 3;
		FDISPLAY(IDC_MEDICAL_T_PA) ctrlSetText "..."; sleep 3;
		FDISPLAY(IDC_MEDICAL_T_PA) ctrlSetText "...."; sleep 3;
		FDISPLAY(IDC_MEDICAL_T_PA) ctrlSetText "....."; sleep 3;
		FDISPLAY(IDC_MEDICAL_T_PA) ctrlSetText "......"; sleep 3;
		FDISPLAY(IDC_MEDICAL_T_PA) ctrlSetText "......."; sleep 3;
		_str = format["%1 / %2",round(tmp_medical_player getVariable "PS"),round(tmp_medical_player getVariable "PD")];
		if (PgV("isFIB") || PgV("isASYS")) then {_str = "?";};
		FDISPLAY(IDC_MEDICAL_T_PA) ctrlSetText _str;
		[player,format["pris la tension (%1 MmHg)",_str]] remoteExec ["CLIENT_fnc_Medical_addToHistory",tmp_medical_player];
		_str = str(round(tmp_medical_player getVariable "BPM"));
		if (PgV("isFIB") || PgV("isASYS")) then {_str = "?";};
		FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetText _str;
		[player,format["pris le pouls (%1 BPM)",_str]] remoteExec ["CLIENT_fnc_Medical_addToHistory",tmp_medical_player];
		temp_medical_priseCONST = nil;
	};
}];
FDISPLAY(IDC_MEDICAL_B_3) ctrlAddEventHandler ["ButtonClick",
{
	params ["_control"];
	if (!isNil "temp_medical_priseCONST") exitWith {};
	[] spawn {
		temp_medical_priseCONST = true;
		FDISPLAY(IDC_MEDICAL_T_VENT) ctrlSetText "."; sleep 1;
		FDISPLAY(IDC_MEDICAL_T_VENT) ctrlSetText ".."; sleep 1;
		FDISPLAY(IDC_MEDICAL_T_VENT) ctrlSetText "..."; sleep 1;
		FDISPLAY(IDC_MEDICAL_T_VENT) ctrlSetText "...."; sleep 1;
		FDISPLAY(IDC_MEDICAL_T_VENT) ctrlSetText "....."; sleep 1;
		_str = (linearConversion [10,80,(tmp_medical_player getVariable "FAIM"),0.4,1.2,true]) toFixed 2;
		FDISPLAY(IDC_MEDICAL_T_VENT) ctrlSetText _str;
		[player,format["pris la glicémie (%1 mg/dl)",_str]] remoteExec ["CLIENT_fnc_Medical_addToHistory",tmp_medical_player];
		temp_medical_priseCONST = nil;
	};
}];

tmp_editList = [IDC_MEDICAL_E_1,IDC_MEDICAL_E_2,IDC_MEDICAL_E_3,IDC_MEDICAL_E_4,IDC_MEDICAL_E_5,IDC_MEDICAL_E_6,IDC_MEDICAL_E_7,IDC_MEDICAL_E_8,IDC_MEDICAL_E_9,IDC_MEDICAL_E_10];
{
	FDISPLAY(_x) ctrlAddEventHandler ["KeyDown",
	{
		params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
		if (_key == 42) exitWith {}; // MAJ
		_newSTR = ctrlText _displayOrControl;
		if (_key == 14) then {
			if (count _newSTR <= 1) then {_newSTR = ""} else {_newSTR = [_newSTR, 0, (count _newSTR - 2)] call BIS_fnc_trimString;};
		};
		systemChat format["key: %1 | STR: %2",_key,_newSTR];
		_datas = (tmp_medical_player getVariable "TRI_LIST");
		_index = tmp_editList find (ctrlIDC _displayOrControl);
		// systemChat format["%1 => %2 (%3)",_newSTR,(player getVariable "TRI_LIST")#_index,_index];
		_datas set [_index,_newSTR];
		[_datas] remoteExec ["CLIENT_fnc_Medical_majTRI",tmp_medical_player];
	}];
	FDISPLAY(_x) ctrlSetText ((tmp_medical_player getVariable "TRI_LIST")#_forEachIndex);
} forEach tmp_editList;

tmp_editList_2 = [IDC_MEDICAL_CK_1,IDC_MEDICAL_CK_2,IDC_MEDICAL_CK_3];
{
	FDISPLAY(_x) ctrlAddEventHandler ["CheckedChanged",
	{
		params ["_control", "_checked"];
		_startIndex = count tmp_editList;
		_index = tmp_editList_2 find (ctrlIDC _control);
		(tmp_medical_player getVariable "TRI_LIST") set [(_startIndex + _index),_checked];
		[(tmp_medical_player getVariable "TRI_LIST")] remoteExec ["CLIENT_fnc_Medical_majTRI",tmp_medical_player];
	}];
	_startIndex = count tmp_editList;
	_checked_nb = ((tmp_medical_player getVariable "TRI_LIST")#(_startIndex + _forEachIndex));
	// systemChat format["%1,%2",FDISPLAY(_x),_checked_nb];
	if (_checked_nb == 0) then {FDISPLAY(_x) cbSetChecked false;};
	if (_checked_nb == 1) then {FDISPLAY(_x) cbSetChecked true;};
} forEach tmp_editList_2;

tmp_medical_ath_partlist = createHashMapFromArray [
	[IDC_MEDICAL_I_H,["hithead","Tête"]],
	[IDC_MEDICAL_I_T,["hitbody","Corps"]],
	[IDC_MEDICAL_I_BD,["hitarmd","Bras Droit"]],
	[IDC_MEDICAL_I_BG,["hitarmg","Bras Gauche"]],
	[IDC_MEDICAL_I_JD,["hitlegd","Jambe Droite"]],
	[IDC_MEDICAL_I_JG,["hitlegg","Jambe Gauche"]]
];
{
	FDISPLAY(_x) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_displayOrControl"];
		tmp_selectedIDCPart = (ctrlIDC _displayOrControl);
		call CLIENT_fnc_temp_MedicalMenu_majInjuryInfos;
	}];
} forEach tmp_medical_ath_partlist;

CLIENT_fnc_temp_MedicalMenu_findPowerSTR = {
	params["_injuryInfo"];
	_powerBase = _injuryInfo#1;
	_mitigation = getMTreatmentNumber(_injuryInfo#2,"mitigation");
	if (_injuryInfo#3 <= 4) then {_mitigation = _mitigation * 0.1;};
	_powerNow = _powerBase - _mitigation;
	if (_powerNow <= 0) then {_powerNow = 0.01};
	_str = "";
	switch (true) do {
		case (_powerBase <= 0.15): {_str = "<t color='#00ff00'>Soigné</t>";};
		case (_powerNow <= 0.15): {_str = "<t color='#00ff00'>Stabilisé</t>";};
		case (_powerNow <= 0.5): {_str = "<t color='#ff7f00'>Mitigé</t>";};
		default {_str = "<t color='#ff0000'>Critique</t>";};
	};
	_str = _str + format[" (%1|%2)",_powerNow toFixed 2,_powerBase toFixed 2];
	_str
};

CLIENT_fnc_temp_MedicalMenu_findTreatmentSTR = {
	params["_injuryInfo"];
	_treatment = _injuryInfo#2;
	_name = getMTreatmentText(_treatment,"name");
	_timerActual = _injuryInfo#3;
	_timerMax = getMTreatmentNumber(_treatment,"durability");
	_destroyOnEnd = getMTreatmentNumber(_treatment,"destroyOnEnd");
	_picture = format["<img image='%1'></img>",getText (configFile >> "CfgMagazines" >> _treatment >> "picture")];
	switch (true) do {
		case (_name == ""): {_name = "<t color='#ff0000'>Aucun</t>"; _timerMax = 0;};
		case (_timerActual <= 4 && _destroyOnEnd == 0): {_name = format["<t color='#ff0000'>%1 (usagé)</t>",_name];};
		default {_name = format["<t color='#00ff00'>%1</t>",_name];};
	};
	_str = format["%4 %1 (%2/%3)",_name,_timerActual,_timerMax,_picture];
	_str
};

CLIENT_fnc_temp_MedicalMenu_majInjuryInfos = {
	_partInfo = (tmp_medical_ath_partlist get tmp_selectedIDCPart);
	// systemChat format["MAJ : %1",_partInfo];
	_strInjuries = format["<t font='PuristaBold' align='center' size='1.4'>%1</t><br/>",_partInfo#1];
	{
		_injuryInfos = _x;
		_state = [_injuryInfos] call CLIENT_fnc_temp_MedicalMenu_findPowerSTR;
		_treatment = [_injuryInfos] call CLIENT_fnc_temp_MedicalMenu_findTreatmentSTR;
		_name = format["<t font='PuristaBold' size='1'>%1</t>",getMInjuryText(_injuryInfos#0,"name")];
		_strInjuries = _strInjuries + format[
			"%1<br/><t size='0.8'>
			Etat : %2</t><br/>"
			,_name,_state
		];
		if (count (getArray (missionConfigFile >> "MEDICAL_injuries" >> (_injuryInfos#0) >> "treatments")) != 0) then {
			_strInjuries = _strInjuries + format["
			<t size='0.8'>Traitement : %1</t><br/>",_treatment];
		};
	} forEach ((tmp_medical_player getVariable "hitInjuries") get (_partInfo#0));
	FDISPLAY(IDC_MEDICAL_ST_INJURIES) ctrlSetStructuredText parseText _strInjuries;
	FDISPLAY_2(IDC_MEDICAL_ST_INJURIES) ctrlSetStructuredText parseText _strInjuries;

	// HISTORY
	_list = (tmp_medical_player getVariable "MEDICAL_HISTORY");
	_medical_history_str = "<t size='0.7' color='#808080'>";
	_count = ((count _list)-1);

	for "_i" from 0 to _count do {
		_index = _count-_i;
		_infos = (_list#_index splitString "|");
		_t = _infos#0;
		_name = _infos#1;
		if ((count _infos) > 4) then { // injury
			_partName = _infos#2;
			{
				if (_partName == _y#0) then {_partName = _y#1};
			} forEach tmp_medical_ath_partlist;
			_injuryName = getMInjuryText((_infos#3),"name");
			_treatment_Name = getMTreatmentText((_infos#4),"name");
			_medical_history_str = _medical_history_str + 
			format["<t color='#ffffff'>%1</t> : <t color='#ffffff'>%2</t> a traité <t color='#ffffff'>%3</t> sur <t color='#ffffff'>%4</t> avec <t color='#ffffff'>%5</t><br/>",
			_t,_name,_injuryName,_partName,_treatment_Name];
		}
		else
		{
			_truc = _infos#2;
			_medical_history_str = _medical_history_str + 
			format["<t color='#ffffff'>%1</t> : <t color='#ffffff'>%2</t> a <t color='#ffffff'>%3</t><br/>",
			_t,_name,_truc];
		};
	};
	_medical_history_str = _medical_history_str + "</t>";
	FDISPLAY(IDC_MEDICAL_ST_HIST) ctrlSetStructuredText parseText _medical_history_str;
	FDISPLAY_2(IDC_MEDICAL_ST_HIST) ctrlSetStructuredText parseText _medical_history_str;
};
call CLIENT_fnc_temp_MedicalMenu_majInjuryInfos;

CLIENT_fnc_temp_MedicalMenu_majColors = {
	{
		_injuries = ((tmp_medical_player getVariable "hitInjuries") get (_y#0));
		_allPowers = 0;
		{
			// systemChat str(_x);
			_allPowers = _allPowers + ([_x] call CLIENT_fnc_Medical_countDangerInjury);
		} forEach _injuries;
		// systemChat format["%1 : %2",_y#0,_allPowers];
		FDISPLAY(_x) ctrlSetTextColor [1,linearConversion [0,50,_allPowers,1,0],linearConversion [0,50,_allPowers,1,0],0.8];
		FDISPLAY_2(_x) ctrlSetTextColor [1,linearConversion [0,50,_allPowers,1,0],linearConversion [0,50,_allPowers,1,0],0.8];
		FDISPLAY_3(_x) ctrlSetTextColor [1,linearConversion [0,50,_allPowers,1,0],linearConversion [0,50,_allPowers,1,0],0.8];
	} forEach tmp_medical_ath_partlist;
};

[] spawn 
{
	if (!isNil "tmp_medical_ath_loop") exitWith {};
	systemChat "MedicalMenu : ATH loop START";
	tmp_medical_ath_loop = true;
	while {true} do 
	{
		call CLIENT_fnc_temp_MedicalMenu_majInjuryInfos;
		call CLIENT_fnc_temp_MedicalMenu_majColors;
		uiSleep 0.5;
		if (isNil 'tmp_medical_player' || {isNull tmp_medical_player || tmp_medical_player distance player > 5}) then {
			systemChat "MedicalMenu : Too far, close menu"; 
			closeDialog 0; sleep 0.1;
		};
		if ((isNull findDisplay 4201) && (isNull findDisplay 4202) && (isNull findDisplay 4203)) exitWith 
		{
			systemChat "MedicalMenu : ATH loop END"; 
			tmp_medical_ath_loop = nil;
			if (tmp_medical_player != player) then {[tmp_medical_player,clientOwner] remoteExec ["CLIENT_fnc_unSubscribeMe",tmp_medical_player];};
		};
	};
};

[] spawn {
	while {(!isNull findDisplay 4201)} do 
	{
		{FDISPLAY(_x) ctrlSetText ((tmp_medical_player getVariable "TRI_LIST")#_forEachIndex);} forEach tmp_editList;
		sleep 1;
	};
	systemChat "MEDICAL MENU 1 CLOSED";
	temp_medical_priseCONST = nil; tmp_maj_m1_in = nil;
};