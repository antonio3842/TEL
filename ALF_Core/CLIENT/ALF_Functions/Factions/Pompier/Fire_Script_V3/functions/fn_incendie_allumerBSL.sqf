[player,"bsl_on"] remoteExec ["ALF_fnc_incendie_say3D",0];
byscream_bsl = true;
byscream_bsl_time = 0;
byscream_bsl_pos = position player;

_fn_bsl_sonnerie_1 = {
	while {!(isNil "byscream_bsl_time") && {byscream_bsl_pos isEqualTo position player && byscream_bsl_time < 30}} do {
		[player,"bsl_sonnerie_1"] remoteExec ["ALF_fnc_incendie_say3D",0];
		sleep 1.01;
	};	
};
_fn_bsl_sonnerie_2 = {
	while {!(isNil "byscream_bsl_time") && {byscream_bsl_pos isEqualTo position player  && byscream_bsl_time < 34}} do {
		[player,"bsl_sonnerie_2"] remoteExec ["ALF_fnc_incendie_say3D",0];
		sleep 0.51;
	};	
};
_fn_bsl_sonnerie_3 = {
	while {!(isNil "byscream_bsl_time") && {byscream_bsl_pos isEqualTo position player  && byscream_bsl_time < 39}} do {
		[player,"bsl_sonnerie_3"] remoteExec ["ALF_fnc_incendie_say3D",0];
		sleep 0.73;
	};	
};
_fn_bsl_sonnerie_haute = {
	while {!isNil "byscream_bsl"} do {
		[player,"bsl_sonnerie_haute"] remoteExec ["ALF_fnc_incendie_say3D",0];
		sleep 1.4;
	};	
};

while {!isNil "byscream_bsl" && {byscream_bsl_time < 40}} do {
	sleep 1;
	if (isNil "byscream_bsl_time") exitWith {};
	if (byscream_bsl_pos isEqualTo position player) then {
		byscream_bsl_time = byscream_bsl_time+1;
		if (byscream_bsl_time == 25) then {
			[] spawn _fn_bsl_sonnerie_1;
		};
		if (byscream_bsl_time == 30) then {
			[] spawn _fn_bsl_sonnerie_2;
		};
		if (byscream_bsl_time == 35) then {
			[] spawn _fn_bsl_sonnerie_3;
		};
		if (byscream_bsl_time == 40) then {
			[] spawn _fn_bsl_sonnerie_haute;
		};
	} else {
		byscream_bsl_time = 0;
		byscream_bsl_pos = position player;
	};
	
};