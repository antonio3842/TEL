/*
	GET YOUR PATH
	Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https// www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https// www.getyourpath.fr)
	YOU ARE not ALLOWED to COPY or DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https// www.bistudio.com/community/game-content-usage-rules
	Contact : kainnon@getyourpath.fr
*/
private _amount = round(random(2));

if ((ALF_Stress >= 45) && (ALF_Stress <= 50) && (isNil "ALF_StressWarning1") && (!(player getVariable ["Incapacitated", false]))) then {
	ALF_StressWarning1 = true;
};

if ((ALF_Stress >= 15) && (ALF_Stress <= 20) && (isNil "ALF_StressWarning2") && (!(player getVariable ["Incapacitated", false]))) then {
	ALF_StressWarning2 = true;
};

if ((ALF_Stress >= 5) && (ALF_Stress <= 10) && (isNil "ALF_StressWarning3") && (!(player getVariable ["Incapacitated", false]))) then {
	ALF_StressWarning3 = true;
};

call ALF_fnc_stressVerify;

if (ALF_Stress < 90) then {
	private ["_effect"];
	ALF_StressWarning3 = nil;
	ALF_StressWarning1 = nil;

	if (!isNil "ALF_StressEmpty") exitWith {};
	[] spawn {
		ALF_StressEmpty = true;
		_effect = ["DynamicBlur", [0.1]] call ALF_fnc_PPEffect;
		ALF_StressEmpty = nil;
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;
	};
};
if (ALF_Stress < 80) then {
	private ["_effect"];
	ALF_StressWarning3 = nil;
	ALF_StressWarning1 = nil;

	if (!isNil "ALF_StressEmpty") exitWith {};
	[] spawn {
		ALF_StressEmpty = true;
		_effect = ["DynamicBlur", [0.15]] call ALF_fnc_PPEffect;
		ALF_StressEmpty = nil;
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;
	};
};
if (ALF_Stress < 60) then {
	private ["_effect"];
	ALF_StressWarning3 = nil;
	ALF_StressWarning1 = nil;

	if (!isNil "ALF_StressEmpty") exitWith {};
	[] spawn {
		ALF_StressEmpty = true;
		_effect = ["DynamicBlur", [0.25]] call ALF_fnc_PPEffect;
		ALF_StressEmpty = nil;
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;
	};
};
if (ALF_Stress < 50) then {
	private ["_effect"];
	ALF_StressWarning3 = nil;
	ALF_StressWarning1 = nil;

	if (!isNil "ALF_StressEmpty") exitWith {};
	[] spawn {
		ALF_StressEmpty = true;
		_effect = ["DynamicBlur", [0.40]] call ALF_fnc_PPEffect;
		ALF_StressEmpty = nil;
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;
	};
};
if (ALF_Stress < 40) then {
	private ["_effect"];
	ALF_StressWarning3 = nil;
	ALF_StressWarning1 = nil;

	if (!isNil "ALF_StressEmpty") exitWith {};
	[] spawn {
		ALF_StressEmpty = true;
		_effect = ["DynamicBlur", [0.60]] call ALF_fnc_PPEffect;
		ALF_StressEmpty = nil;
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;
	};
};
if (ALF_Stress < 30) then {
	private ["_effect"];
	ALF_StressWarning3 = nil;
	ALF_StressWarning1 = nil;

	if (!isNil "ALF_StressEmpty") exitWith {};
	[] spawn {
		ALF_StressEmpty = true;
		_effect = ["DynamicBlur", [0.70]] call ALF_fnc_PPEffect;
		ALF_StressEmpty = nil;
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;
	};
};
if (ALF_Stress < 20) then {
	private ["_effect"];
	ALF_StressWarning3 = nil;
	ALF_StressWarning1 = nil;

	if (!isNil "ALF_StressEmpty") exitWith {};
	[] spawn {
		ALF_StressEmpty = true;
		_effect = ["DynamicBlur", [0.80]] call ALF_fnc_PPEffect;
		ALF_StressEmpty = nil;
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;
	};
};
if (ALF_Stress < 10) then {
	private ["_effect"];
	ALF_StressWarning3 = nil;
	ALF_StressWarning1 = nil;

	if (!isNil "ALF_StressEmpty") exitWith {};
	[] spawn {
		ALF_StressEmpty = true;
		_effect = ["DynamicBlur", [0.90]] call ALF_fnc_PPEffect;
		ALF_StressEmpty = nil;
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;
	};
};
if (ALF_Stress <= 0) then {
	private ["_effect"];
	ALF_StressWarning3 = nil;
	ALF_StressWarning1 = nil;

	if (!isNil "ALF_StressEmpty") exitWith {};
	[] spawn {
		ALF_StressEmpty = true;
		_effect = ["DynamicBlur", [1]] call ALF_fnc_PPEffect;
		while { ALF_Stress <= 0 } do {
			uiSleep 1;
			player setStamina 0;
		};
		ALF_StressEmpty = nil;
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;
	};
};