/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
(findDisplay 46) displayAddEventHandler["KeyDown", {_this call ALF_fnc_EventHandlers_HandleDown;}];
player addEventHandler["Killed", {_this call ALF_fnc_onPlayerKilled}];
player addEventHandler["handleDamage",{_this call ALF_fnc_handleDamage;}];
player addEventHandler["Respawn", {_this call ALF_fnc_onPlayerRespawn}];
player addEventHandler["Fired",{_this call ALF_fnc_onFired}];
player addEventHandler["FiredNear", {_this call ALF_fnc_firstViewCombat}];
player addEventHandler["InventoryClosed", {_this call ALF_fnc_inventoryClosed}];
player addEventHandler["InventoryOpened", {_this call ALF_fnc_inventoryOpened}];
player addEventHandler["GetInMan", {_this call ALF_fnc_getInMan;}];
player addEventHandler["GetOutMan", {_this call ALF_fnc_getOutMan;}];
player addEventHandler["SeatSwitchedMan", {_this call ALF_fnc_seatSwitchedMan}];
player addEventHandler["Put", {_this spawn ALF_fnc_silentGearSave;}];
player addEventHandler["Take", {_this spawn ALF_fnc_onTake; _this spawn ALF_fnc_silentGearSave;}];
player addEventHandler["HandleRating", {0}];

["player", "OnBeforeTangent", 
{
	if (_this select 4) then {
		if (player getVariable["ALF_comRadio",false]) exitWith {};
		player setVariable ["ALF_comRadio", true];
		if (alive player) then {
			if ((vest player) in ["V_ALF_GIGN_Leger_3", "V_ALF_GIGN_Leger_4", "V_ALF_GIGN_Leger_5", "V_ALF_GIGN_Leger_6", "V_ALF_GIGN_Leger_7", "V_ALF_GIGN_Leger_8", "V_ALF_GIGN_Leger_9", "V_ALF_GIGN_Leger_10", "V_ALF_GIGN_Leger_11",
			"V_ALF_GIGN_Leger_12", "V_ALF_Gdep_1", "V_ALF_Gdep_2", "V_ALF_Gdep_3", "V_ALF_Gdep_4", "V_ALF_Gdep_5", "V_ALF_Gdep_6", "V_ALF_Gdep_7", "V_ALF_Gdep_8", "V_ALF_Gdep_9", "V_ALF_Gdep_10", "V_ALF_Gdep_11",
			"V_ALF_Gdep_12", "V_ALF_Nego_2", "V_ALF_Nego_3", "V_ALF_Nego_4", "V_ALF_Nego_5", "V_ALF_Nego_6","V_ALF_Nego_7", "V_ALF_Nego_8", "V_ALF_Nego_9", "V_ALF_Nego_10", "V_ALF_Nego_11", "V_ALF_Nego_12", "V_ALF_Psig_2",
			"V_ALF_Psig_3", "V_ALF_Psig_4", "V_ALF_Psig_5", "V_ALF_Psig_6", "V_ALF_Psig_7", "V_ALF_Psig_8", "V_ALF_Psig_9", "V_ALF_Psig_10", "V_ALF_Psig_11", "V_ALF_Psig_12","V_ALF_sr_2","V_ALF_sr_3","V_ALF_sr_4", "V_ALF_sr_5", "V_ALF_sr_6",
			"V_ALF_sr_7", "V_ALF_sr_8", "V_ALF_sr_9",  "V_ALF_sr_10", "V_ALF_sr_11", "V_ALF_sr_12", "V_ALF_Gilet_AP","V_ALF_GiletSR_MDC","V_ALF_GiletSR_ADJ","V_ALF_GiletSR_ADC","V_ALF_GiletSR_MAJ","V_ALF_GiletSR_SLT","V_ALF_GiletSR_LTN","V_ALF_GiletSR_CNE",
			"V_ALF_GiletSR_CDT","V_ALF_GiletSR_LCL","V_ALF_GiletSR_COL","V_ALF_GiletNego_GND","V_ALF_GiletNego_MDC","V_ALF_GiletNego_ADJ","V_ALF_GiletNego_ADC","V_ALF_GiletNego_MAJ","V_ALF_GiletNego_SLT","V_ALF_GiletNego_LTN","V_ALF_GiletNego_CNE","V_ALF_GiletNego_CDT",
			"V_ALF_GiletNego_LCL","V_ALF_GiletNego_COL","V_ALF_GiletPsig_GND","V_ALF_GiletPsig_MDC","V_ALF_GiletPsig_ADJ","V_ALF_GiletPsig_ADC","V_ALF_GiletPsig_MAJ","V_ALF_GiletPsig_SLT","V_ALF_GiletPsig_LTN","V_ALF_GiletPsig_CNE","V_ALF_GiletPsig_CDT","V_ALF_GiletPsig_LCL",
			"V_ALF_GiletPsig_COL","V_ALF_GiletGDEP_GND","V_ALF_GiletGDEP_MDC","V_ALF_GiletGDEP_ADJ","V_ALF_GiletGDEP_ADC","V_ALF_GiletGDEP_MAJ","V_ALF_GiletGDEP_SLT","V_ALF_GiletGDEP_LTN","V_ALF_GiletGDEP_CNE","V_ALF_GiletGDEP_CDT","V_ALF_GiletGDEP_LCL","V_ALF_GiletGDEP_COL","V_ALF_GiletPSIGSabre_ADJ",
			"V_ALF_GiletPSIGSabre_ADC","V_ALF_GiletPSIGSabre_MAJ","V_ALF_GiletPSIGSabre_SLT","V_ALF_GiletPSIGSabre_LTN","V_ALF_GiletPSIGSabre_CNE","V_ALF_GiletPSIGSabre_CDT","V_ALF_GiletPSIGSabre_LCL","V_ALF_GiletPSIGSabre_COL"]) then {
				player playActionNow "ALF_ComRadio2";
			} else {
				player playActionNow "ALF_comradio";
			};
		};
	} else {
		player playActionNow "GestureNod"; 
		player setVariable ["ALF_comRadio", false];
	};
}, Player] call TFAR_fnc_addEventHandler;

player addEventHandler ["AnimChanged", {
	params ["_unit", "_anim"];
	if (animationState _unit in ["amovpercmevasnonwnondf","amovpercmrunsnonwnondf"]) then {
		if !(_unit getVariable ["onRun",false]) then {
			_startDistance = getPos _unit;
			_unit setVariable ["onRun",true,true];
			_unit setVariable ["onRun_SD", _startDistance,true];
		};
	} else {
		if (_unit getVariable ["onRun",false]) then {
			_startDistance = _unit getVariable ["onRun_SD",""];
			_finishDistance = getPos _unit;
			_unit setVariable ["onRun",false,true];
			_distance = _startDistance distance _finishDistance;
			[4,round(_distance)] spawn ALF_fnc_addXP;
		};
	};
}];
