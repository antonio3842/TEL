#define FDISPLAY(ctrl) ((findDisplay 4203) displayCtrl ctrl)

#define PgV(var) (tmp_medical_player getVariable var)
#define IMG_PATH "cba_tex_1\MEDICAL\3\"

#define getMInjuryNumber(var,var2) (getNumber (missionConfigFile >> "MEDICAL_injuries" >> var >> var2))
#define getMInjuryText(var,var2) (getText (missionConfigFile >> "MEDICAL_injuries" >> var >> var2))

#define getMTreatmentNumber(var,var2) (getNumber (missionConfigFile >> "MEDICAL_treatment" >> var >> var2))
#define getMTreatmentText(var,var2) (getText (missionConfigFile >> "MEDICAL_treatment" >> var >> var2))

#define getMDrugsText(var,var2) (getText (missionConfigFile >> "MEDICAL_drugs" >> var >> var2))
#define getMDrugsNumber(var,var2) (getNumber (missionConfigFile >> "MEDICAL_drugs" >> var >> var2))

#define getMBloodsText(var,var2) (getText (missionConfigFile >> "MEDICAL_bloods" >> var >> var2))
#define getMBloodsNumber(var,var2) (getNumber (missionConfigFile >> "MEDICAL_bloods" >> var >> var2))

//--- medical
#define IDC_MEDICAL_ST_INFO_DEFIB	3245
#define IDC_MEDICAL_BACK		3345
#define IDC_MEDICAL_O1		3346
#define IDC_MEDICAL_O2		3347
#define IDC_MEDICAL_O3		3348
#define IDC_MEDICAL_BACK_P1	3349
#define IDC_MEDICAL_BACK_P2	3350
#define IDC_MEDICAL_BACK_P3	3351
#define IDC_MEDICAL_B_COMP	3352
#define IDC_MEDICAL_I_T		3353
#define IDC_MEDICAL_I_JD		3354
#define IDC_MEDICAL_I_JG		3355
#define IDC_MEDICAL_I_BG		3356
#define IDC_MEDICAL_I_BD		3357
#define IDC_MEDICAL_I_H		3358
#define IDC_MEDICAL_B_INSUFL	3359
#define IDC_MEDICAL_B_CONTROL	3360
#define IDC_MEDICAL_B_MMASQUE	3361
#define IDC_MEDICAL_B_ACTU	3362
#define IDC_MEDICAL_B_MASQUE	3363
#define IDC_MEDICAL_BACK_P4	3364
#define IDC_MEDICAL_B_CHOC	3365
#define IDC_MEDICAL_I_P2_MASK	3366
#define IDC_MEDICAL_I_P2_BOTTLE	3367
#define IDC_MEDICAL_I_BPM		3368
#define IDC_MEDICAL_ST_SCORE	3369
#define IDC_MEDICAL_ED_DEFIB	3545
#define IDC_MEDICAL_T_BPM		3546
#define IDC_MEDICAL_T_O2		3547
#define IDC_MEDICAL_T_RESP	3548
#define IDC_MEDICAL_T_PS		3549
#define IDC_MEDICAL_T_PD		3550
#define IDC_MEDICAL_ED_O2		3551


createDialog "MEDICAL_3";
call CLIENT_fnc_temp_MedicalMenu_majInjuryInfos;
call CLIENT_fnc_temp_MedicalMenu_majColors;

FDISPLAY(IDC_MEDICAL_B_MASQUE) ctrlShow false;
FDISPLAY(IDC_MEDICAL_B_MMASQUE) ctrlShow false;
FDISPLAY(IDC_MEDICAL_B_ACTU) ctrlShow false;
FDISPLAY(IDC_MEDICAL_BACK_P2) ctrlShow false;
FDISPLAY(IDC_MEDICAL_I_P2_MASK) ctrlShow false;
FDISPLAY(IDC_MEDICAL_I_P2_BOTTLE) ctrlShow false;
FDISPLAY(IDC_MEDICAL_T_O2) ctrlShow false;
FDISPLAY(IDC_MEDICAL_ED_O2) ctrlShow false;

FDISPLAY(IDC_MEDICAL_O1) ctrlAddEventHandler ["ButtonClick",
{
	closeDialog 0;
	0 spawn {uisleep 0.01;[tmp_medical_player] call CLIENT_fnc_menu_medical1;};
}];
FDISPLAY(IDC_MEDICAL_O2) ctrlAddEventHandler ["ButtonClick",
{
	closeDialog 0;
	0 spawn {uisleep 0.01;[tmp_medical_player] call CLIENT_fnc_menu_medical2;};
}];

FDISPLAY(IDC_MEDICAL_B_COMP) ctrlAddEventHandler ["ButtonClick",
{
	if (isNil "tmp_cpr_timeStarted") then {tmp_cpr_timeStarted = time; /* systemChat "CPR démarré"; */};
	if ((tmp_medical_player getVariable "cpr_player") != player) then {tmp_medical_player setVariable ["cpr_player",player,true];}; // deg
	FDISPLAY(IDC_MEDICAL_ST_SCORE) ctrlSetStructuredText parseText "<t font='PuristaBold'>RCP</t><br/><t size='0.7'>démarré</t>";
	if (isNil "tmp_cpr_compNb") then {tmp_cpr_compNb = 0;}; tmp_cpr_compNb = tmp_cpr_compNb + 1;
}];
FDISPLAY(IDC_MEDICAL_B_INSUFL) ctrlAddEventHandler ["ButtonClick",
{
	if (isNil "tmp_cpr_insufNb") then {tmp_cpr_insufNb = 0;}; tmp_cpr_insufNb = tmp_cpr_insufNb + 1;
}];
FDISPLAY(IDC_MEDICAL_B_CONTROL) ctrlAddEventHandler ["ButtonClick",
{
	_elapsedTime = time - tmp_cpr_timeStarted;
	// systemChat format ["%1xCompression + %2xInsuflation in %3sec",tmp_cpr_compNb,tmp_cpr_insufNb,_elapsedTime];
	_successTime = round(40 - abs(_elapsedTime - 22.3)*5);
	_successComp = round(35 - abs(tmp_cpr_compNb - 30)*20);
	_successInsufl = round(25 - abs(tmp_cpr_insufNb - 2)*30);
	_successTotal = _successTime + _successComp + _successInsufl;
	_successCoef = _successTotal / 100;
	_str = "color='#ff0000'>RCP raté";
	if (_successCoef > 0.5) then {_str = "color='#C2FF00'>RCP ok";};
	if (_successCoef >= 0.95) then {_str = "color='#00FF00'>RCP parfait";};
	FDISPLAY(IDC_MEDICAL_ST_SCORE) ctrlSetStructuredText parseText format["<t font='PuristaBold'%1</t><br/><t size='0.5'>%2 + %3 | %4 sec</t>",_str,tmp_cpr_compNb,tmp_cpr_insufNb,_elapsedTime toFixed 1];
	tmp_cpr_compNb = nil;
	tmp_cpr_insufNb = nil;
	tmp_cpr_timeStarted = nil;
	_FIB_time = (15*_successCoef);
	_ASYS_time = (35*_successCoef);
	if (isNil "_successCoef" || {_successCoef < 0.5}) exitWith {systemChat "RCP échoué";};
	// systemChat format ["(+%1sec fib, +%2sec asys)",_FIB_time,_ASYS_time];
	[_FIB_time,_ASYS_time] remoteExec ["CLIENT_fnc_Medical_addTimer",tmp_medical_player];
	systemChat "CPR réussi";
	_AdrenalineML = ((tmp_medical_player getVariable "MEDICAL_DRUGS") get "MRP_Adrenaline");
	_AdrenalineChance = linearConversion [0,1.5,_AdrenalineML,0,25];
	_reviveChance = (8 + _AdrenalineChance) * _successCoef;
	_rdm = floor(random 100);
	// systemChat format ["Roll : %1 ?> %2",_reviveChance toFixed 2,_rdm];
	if (PgV("isASYS") && _rdm < _reviveChance) then {
		systemChat "Réanimation réussie";
		[nil,false,player,clientOwner] remoteExec ["CLIENT_fnc_Medical_rea",tmp_medical_player];
	};
}];

fnc_temp_MedicalMenu_CHOC = {
	FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText "";
	tmp_defib_isChargeSoundAlreadyPlayed = false;
	[tmp_defib_obj,"m_choc",150] remoteExecCall ["SERVER_fnc_globalSay3d",2];

	if (tmp_defib_load < 40) exitWith {tmp_defib_load = 0;};

	// systemChat str(tmp_defib_load);
	_rdm = random 0.5;
	_brul_chance = _rdm + linearConversion [150, 200, tmp_defib_load, 0.5, 0.75];
	if (_brul_chance > 1) then {
		["hitbody","BRUL_LOW"] remoteExec ["CLIENT_fnc_Medical_AddInjury", tmp_medical_player];
	};

	_AmiodaroneML = ((tmp_medical_player getVariable "MEDICAL_DRUGS") get "MRP_Amiodarone");
	_revive_chance = (tmp_medical_player getVariable "PS") + (tmp_defib_load/3) + (_AmiodaroneML*0.8) + random 30;

	// systemChat format["Charge : %1 J | Brulure = %2>1 ? | Revive = %3>125 ?",tmp_defib_load,_brul_chance toFixed 2,_revive_chance];
	[player,format["envoyé un choc de %1 J",tmp_defib_load]] remoteExec ["CLIENT_fnc_Medical_addToHistory",tmp_medical_player];
	tmp_defib_load = 0;

	0 spawn {
		FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText "!!!";
		sleep 2.2;
		if (isNil "tmp_chargeDAE") exitWith {};
		FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText "???";
		if (PgV("isFIB")) then // DAE
		{
			if (tmp_chargeDAE > 200) exitWith {
				FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText "?BPM?"; 
				[tmp_defib_obj,"dae_choc_end",150] remoteExecCall ["SERVER_fnc_globalSay3d",2];
			};
			[tmp_defib_obj,"dae_choc",150] remoteExecCall ["SERVER_fnc_globalSay3d",2]; sleep 22;
			sleep 45;
			if (isNull findDisplay 4203) exitWith {};
			if (PgV("isFIB") && !PgV("isASYS")) then {
				[tmp_defib_obj,"dae_analyse_choc_y",150] remoteExecCall ["SERVER_fnc_globalSay3d",2]; sleep 9;
				FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText "?BPM?"; 
				tmp_activeDAE = false;
				tmp_chargeDAE = tmp_chargeDAE + 20;
				FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText str(tmp_chargeDAE);
			} else {
				[tmp_defib_obj,"dae_analyse_choc_n",150] remoteExecCall ["SERVER_fnc_globalSay3d",2]; sleep 9;
				FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText "!BPM!"; 
			};
		} else {
			FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText "!BPM!"; 
			[tmp_defib_obj,"dae_choc_bpm",150] remoteExecCall ["SERVER_fnc_globalSay3d",2];
		};
	};

	if (PgV("isASYS")) exitWith {};
	if (!PgV("isFIB")) exitWith {[player] remoteExec ["CLIENT_fnc_Medical_extraChoc",tmp_medical_player];};

	if (_revive_chance >= 125) then {
		[false,nil,player,clientOwner] remoteExec ["CLIENT_fnc_Medical_rea",tmp_medical_player];
	};
};

FDISPLAY(IDC_MEDICAL_B_CHOC) ctrlAddEventHandler ["ButtonClick",
{	
	call fnc_temp_MedicalMenu_CHOC;
}];

_r = ["MRP_DAE"] call CLIENT_fnc_hasClassname_inNearestWeaponHolders_WhReturned;
_hasDAE = _r#0; if (_hasDAE) then {tmp_defib_obj = _r#1;};
_r = ["MRP_lifepack15"] call CLIENT_fnc_hasClassname_inNearestWeaponHolders_WhReturned;
_hasLifePack = _r#0; if (_hasLifePack) then {tmp_defib_obj = _r#1;};
_hasBrancard = false;
{if ((_x animationPhase "life_pack") == 1) then {_hasBrancard = true; tmp_defib_obj = _x};} forEach (player nearObjects 4);


[] spawn {
	waitUntil {(isNull findDisplay 4203)}; 
	// systemChat "MEDICAL MENU 3 CLOSED";
	tmp_cpr_compNb = nil;
	tmp_cpr_insufNb = nil;
	tmp_cpr_timeStarted = nil;
	tmp_defib_isChargeSoundAlreadyPlayed = nil;
	tmp_chargeDAE = nil;
	tmp_activeDAE = nil;
	if (!isNull (tmp_medical_player getVariable "cpr_player") && (tmp_medical_player getVariable "cpr_player") == player) then {
		tmp_medical_player setVariable ["cpr_player",objNull,true];
	};
	uiSleep 5; tmp_defib_obj = nil;
};


if (tmp_medical_player == player || !isNull (tmp_medical_player getVariable "cpr_player")) then 
{
	// systemChat "pas de RCP sur soi / multiples";
	FDISPLAY(IDC_MEDICAL_BACK_P1) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_B_COMP) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_B_INSUFL) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_B_CONTROL) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_ST_SCORE) ctrlShow false;
};

if (!_hasLifePack && !_hasBrancard && !_hasDAE) exitWith // stops script !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! <===== BE ADVISED FDP
{
	// systemChat "pas de LifePack / Brancard / DAE";
	FDISPLAY(IDC_MEDICAL_BACK_P3) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_BACK_P4) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_B_CHOC) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_I_BPM) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlShow false;
};

if (_hasDAE && !_hasLifePack && !_hasBrancard) then 
{
	// systemChat "DAE only";
	FDISPLAY(IDC_MEDICAL_BACK_P3) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_B_CHOC) ctrlEnable false;
	FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlEnable false;
	FDISPLAY(IDC_MEDICAL_I_BPM) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_T_BPM) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_T_PS) ctrlShow false;
	FDISPLAY(IDC_MEDICAL_T_PD) ctrlShow false;
	tmp_chargeDAE = -1;
	tmp_activeDAE = false;
};

FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetTextColor [0.08,0.86,0.21,1];
tmp_defib_load = 0;

[] spawn {
	_fnc_temp_MedicalMenu_cligolel = {
		params ["_IDC","_forced"];
		if (!isNil "tmp_chargeDAE") exitWith {};
		if (!isNil "_forced") exitWith {FDISPLAY(_IDC) ctrlShow true};
		if (ctrlShown FDISPLAY(_IDC)) then {FDISPLAY(_IDC) ctrlShow false} else {FDISPLAY(_IDC) ctrlShow true};
	};
	tmp_defib_isChargeSoundAlreadyPlayed = false;

	while {(!isNull findDisplay 4203)} do 
	{
		if (!isNull (tmp_medical_player getVariable "cpr_player") && (tmp_medical_player getVariable "cpr_player") != player) then 
		{
			FDISPLAY(IDC_MEDICAL_BACK_P1) ctrlShow false;
			FDISPLAY(IDC_MEDICAL_B_COMP) ctrlShow false;
			FDISPLAY(IDC_MEDICAL_B_INSUFL) ctrlShow false;
			FDISPLAY(IDC_MEDICAL_B_CONTROL) ctrlShow false;
			FDISPLAY(IDC_MEDICAL_ST_SCORE) ctrlShow false;
		};
		if (isNil "tmp_defib_obj") then {tmp_defib_obj = player}; // ez workaround
		_bpm = round(tmp_medical_player getVariable "BPM");
		if (isNil "tmp_chargeDAE") then 
		{
			if (PgV("isASYS") || PgV("isFIB")) then {
				FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetText "?";
				FDISPLAY(IDC_MEDICAL_T_PS) ctrlSetText "?";
				FDISPLAY(IDC_MEDICAL_T_PD) ctrlSetText "";
			} else {
				[IDC_MEDICAL_T_BPM,true] call _fnc_temp_MedicalMenu_cligolel;
				[IDC_MEDICAL_T_PS,true] call _fnc_temp_MedicalMenu_cligolel;
				FDISPLAY(IDC_MEDICAL_T_BPM) ctrlSetText str(_bpm);
				_ps = round(tmp_medical_player getVariable "PS"); FDISPLAY(IDC_MEDICAL_T_PS) ctrlSetText format["%1",_ps];
				_pd = round(tmp_medical_player getVariable "PD"); FDISPLAY(IDC_MEDICAL_T_PD) ctrlSetText format["%1",_pd];
			};
		};

		switch (true) do {
			case (PgV("isFIB")): {
				if ("bis" in ctrlText FDISPLAY(IDC_MEDICAL_I_BPM)) then {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\fib.paa"];}
				else {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\fib_bis.paa"];}; 
				[IDC_MEDICAL_T_BPM] call _fnc_temp_MedicalMenu_cligolel;
				[IDC_MEDICAL_T_PS] call _fnc_temp_MedicalMenu_cligolel;
				// [player,"m_fib_assy",25] remoteExecCall ["SERVER_fnc_globalSay3d",2];
			};
			case (PgV("isASYS")): {
				if ("bis" in ctrlText FDISPLAY(IDC_MEDICAL_I_BPM)) then {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\assys.paa"];}
				else {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\assys_bis.paa"];}; 
				[IDC_MEDICAL_T_BPM] call _fnc_temp_MedicalMenu_cligolel;
				[IDC_MEDICAL_T_PS] call _fnc_temp_MedicalMenu_cligolel;
				// [player,"m_fib_assy",25] remoteExecCall ["SERVER_fnc_globalSay3d",2];
			};
			case (_bpm > 0 && _bpm < 30): { 
				if ("bis" in ctrlText FDISPLAY(IDC_MEDICAL_I_BPM)) then {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\bas_0.paa"];}
				else {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\bas_0_bis.paa"];};
			};
			case (_bpm > 30 && _bpm < 50): { 
				if ("bis" in ctrlText FDISPLAY(IDC_MEDICAL_I_BPM)) then {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\bas_1.paa"];}
				else {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\bas_1_bis.paa"];};
			};
			case (_bpm >= 50 && _bpm < 70): { 
				if ("bis" in ctrlText FDISPLAY(IDC_MEDICAL_I_BPM)) then {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\bas_2.paa"];}
				else {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\bas_2_bis.paa"];}; 
			};
			case (_bpm >= 70 && _bpm < 90): { 
				if ("bis" in ctrlText FDISPLAY(IDC_MEDICAL_I_BPM)) then {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\moyen_1.paa"];}
				else {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\moyen_1_bis.paa"];}; 
			};
			case (_bpm >= 90 && _bpm < 110): { 
				if ("bis" in ctrlText FDISPLAY(IDC_MEDICAL_I_BPM)) then {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\moyen_2.paa"];}
				else {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\moyen_2_bis.paa"];}; 
			};
			case (_bpm >= 110 && _bpm < 130): { 
				if ("bis" in ctrlText FDISPLAY(IDC_MEDICAL_I_BPM)) then {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\rapide_1.paa"];}
				else {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\rapide_1_bis.paa"];}; 
			};
			case (_bpm >= 130): { 
				if ("bis" in ctrlText FDISPLAY(IDC_MEDICAL_I_BPM)) then {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\rapide_2.paa"];}
				else {FDISPLAY(IDC_MEDICAL_I_BPM) ctrlSetText format["%1",IMG_PATH + "bpm\rapide_2_bis.paa"];}; 
			};
			default { };
		};

		// if (_bpm >= 140) then {[player,"m_pasouf",25] remoteExecCall ["SERVER_fnc_globalSay3d",2];};

		if (!isNil "tmp_chargeDAE" && {tmp_chargeDAE < 0}) then // DAE INTRO
		{
			if (tmp_activeDAE) exitWith {};
			tmp_activeDAE = true;
			0 spawn {
				FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText "???";
				[tmp_defib_obj,"dae_intro",150] remoteExecCall ["SERVER_fnc_globalSay3d",2]; sleep 8; 
				if (isNull findDisplay 4203) exitWith {};
				if (PgV("isFIB")) then {
					tmp_chargeDAE = 160;
					[tmp_defib_obj,"dae_analyse_choc_y",150] remoteExecCall ["SERVER_fnc_globalSay3d",2]; sleep 10; 
					tmp_activeDAE = false;
				} else {
					[tmp_defib_obj,"dae_analyse_choc_n",150] remoteExecCall ["SERVER_fnc_globalSay3d",2]; sleep 10;
					if (isNull findDisplay 4203) exitWith {};
					if (PgV("isASYS")) then {
						[tmp_defib_obj,"dae_choc_n",150] remoteExecCall ["SERVER_fnc_globalSay3d",2];
						FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText "?BPM?";
					} else 
					{
						FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText "!BPM!";
					};
				};
			};
		};

		if ((PgV("isFIB") && !isNil "tmp_chargeDAE" && {tmp_chargeDAE > 0})) then // DAE
		{
			if (tmp_activeDAE) exitWith {};
			tmp_activeDAE = true;
			FDISPLAY(IDC_MEDICAL_ED_DEFIB) ctrlSetText str(tmp_chargeDAE);
		};


		_status_str = "<t color='#BFFFAA'>VIDE</t>";
		_j_target = parseNumber (ctrlText FDISPLAY(IDC_MEDICAL_ED_DEFIB));

		if (_j_target < 0) then {_j_target = 0}; if (_j_target > 199) then {_j_target = 199}; 
		if (tmp_defib_load <= 0) then {tmp_defib_load = 0; tmp_defib_isChargeSoundAlreadyPlayed = false;};
		if (tmp_defib_load > _j_target - 9 && tmp_defib_load < _j_target + 9) then {
			tmp_defib_load = _j_target;
		};

		if (tmp_defib_load > _j_target) then {tmp_defib_load = tmp_defib_load - 8 - random 6; _status_str = "<t color='#FDB620'>DISC</t>";} 
		else {
			if (tmp_defib_load < _j_target) then {
				tmp_defib_load = tmp_defib_load + 15 + random 10; _status_str = "<t color='#FDB620'>CHARGE</t>";
				if (!tmp_defib_isChargeSoundAlreadyPlayed) then {
					[tmp_defib_obj,"dae_chargement",150] remoteExecCall ["SERVER_fnc_globalSay3d",2];
					tmp_defib_isChargeSoundAlreadyPlayed = true;
				};
			};
		};

		tmp_defib_load = round(tmp_defib_load);
		if (tmp_defib_load == _j_target && tmp_defib_load > 0) then 
		{
			if ((PgV("isFIB") && !isNil "tmp_chargeDAE")) exitWith {call fnc_temp_MedicalMenu_CHOC;}; // DAE force
			[tmp_defib_obj,"m_choc_ready",150] remoteExecCall ["SERVER_fnc_globalSay3d",2];
			_status_str = "<t color='#00FF00'>PRET</t>";
		};
		FDISPLAY(IDC_MEDICAL_ST_INFO_DEFIB) ctrlSetStructuredText parseText format["<t align='center' size='0.6'>%1<br/>%3J/%2J</t>",_status_str,_j_target,tmp_defib_load];
		uiSleep 1;
	};
};