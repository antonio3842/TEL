(uiNamespace getVariable "ath_coma") closeDisplay 1;
uiNamespace setVariable ["ath_coma",nil];
closeDialog 0;
[] spawn {sleep 120; [player] call MRPV2_fnc_MRP_Coma_Suppression_Marqueur;};
0 spawn {
	sleep 1;
	closeDialog 0;
	5 fadeSound 1;
	player setVariable ["tf_globalVolume", 1, true];
	player setVariable ["tf_voiceVolume", 1, true]
};