/*
	File: fn_countService.sqf
	This file is for Nanou's HeadlessClient.
*/
private "_targets";
for "_i" from 0 to 1 step 0 do {
	private _cops = {_x getVariable ["CopService",false]} count playableUnits;
	private _meds = {_x getVariable ["MedService",false]} count playableUnits;
	private _penit = {_x getVariable ["PenitService",false]} count playableUnits;
	private _casse = {_x getVariable ["CasseService",false]} count playableUnits;
	_targets = ((playableUnits apply {_x getVariable ["ALF_ownerID",2]}) + [2]);
	missionNamespace setVariable ["ALF_Count_Cops",_cops,_targets];
	missionNamespace setVariable ["ALF_Count_Meds",_meds,_targets];
	missionNamespace setVariable ["ALF_Count_Penit",_penit,_targets];
	missionNamespace setVariable ["ALF_Count_Casse",_casse,_targets];
	uiSleep 300;
};
