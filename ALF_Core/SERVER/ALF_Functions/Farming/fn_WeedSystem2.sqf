/*
	This file is for Nanou's HeadlessClient.
*/
params [
	["_object",objNull,[objNull]],
	["_speed",1,[0]]
];

private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);

if (!isnil {_GN_En_Service} AND {count (units _GN_En_Service) <= 2 AND {life_gendarme_service}}) exitwith {closeDialog 2;["Production bloquée", "Impossible de lancer la prod les bleus ne sont pas en service.", "danger", false] spawn alf_fnc_doMsg;};
if (isnil {_GN_En_Service} OR {count (units _GN_En_Service) <= 2}) exitwith {closeDialog 2;["Production bloquée", "La production est verrouillée : pas assez de gendarmes en service.", "danger", false] spawn alf_fnc_doMsg;};

["ALF_Graine_W",false] remoteExec ["ALF_fnc_handleItem",remoteExecutedOwner];

_object animateSource ["et_1_source",0,true];

private _fire = false;
private _count = 0;
private _step = 0;
private _pure = 0;
for "_i" from 0 to 1 step 0 do {
	if(isNull _object) exitWith {};
	if(_step isEqualTo 0 && {_count > 50} && {_object animationSourcePhase "et_1_source" isEqualTo 0} && {_object animationSourcePhase "et_2_source" isEqualTo 1} && {_object animationSourcePhase "et_3_source" isEqualTo 1} && {_object animationSourcePhase "et_4_source" isEqualTo 1}) then {
		_step = 1;
		_object animateSource ["et_1_source",1,true];
		_object animateSource ["et_2_source",0,true];
	};
	if(_step isEqualTo 1 && {_count > 100} && {_object animationSourcePhase "et_1_source" isEqualTo 1} && {_object animationSourcePhase "et_2_source" isEqualTo 0} && {_object animationSourcePhase "et_3_source" isEqualTo 1} && {_object animationSourcePhase "et_4_source" isEqualTo 1}) then {
		_step = 2;
		_object animateSource ["et_2_source",1,true];
		_object animateSource ["et_3_source",0,true];
		if(_object animationSourcePhase "hide_uv_source" < 0.9) then {
			private _dice = random(1000);
			if(_dice <= 10) then {
				private _hs = nearestObjects [position _object, ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_01_b_white_F","Land_i_House_Big_01_b_brown_F","Land_i_House_Big_01_b_blue_F","Land_i_House_Big_01_b_whiteblue_F","Land_i_House_Big_01_b_pink_F","Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_i_House_Big_02_b_blue_F","Land_i_House_Big_02_b_white_F","Land_i_House_Big_02_b_whiteblue_F","Land_i_House_Big_02_b_yellow_F","Land_i_House_Big_02_b_brown_F","Land_i_House_Big_02_b_pink_F","Land_House_Big_02_F","Land_House_Big_03_F","Land_i_House_Small_03_V1_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_01_V1_F","MRP_Wooden_House_03_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_House_Big_01_F","Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V3_F","Land_i_Stone_HouseSmall_V1_F","Land_House_Small_02_F","Land_HouseA","Land_HouseB","Land_HouseC","Land_HouseD","Land_Hotel_02_F"],50];
				if !(_hs isEqualTo []) then {
					private _h = _hs select 0;
					if !(isNil {_h getVariable "house_owner"}) then {
						[_h] spawn ALF_Server_fnc_burn_building;
						[_h] spawn {
							private _h = _this select 0;
							uiSleep 1500;
							if(_h getVariable ["IsOnfire", false]) then {
								//[_h] remoteExecCall ["ALF_Server_fnc_sellHousemobilier",hc_2];
								[_h] call ALF_Server_fnc_sellHousemobilier;
								_h setDamage 1;
							};
						};
					};
				};
			};
		};
	};
	if(_step isEqualTo 2 && {_count > 150} && {_object animationSourcePhase "et_1_source" isEqualTo 1} && {_object animationSourcePhase "et_2_source" isEqualTo 1} && {_object animationSourcePhase "et_3_source" isEqualTo 0} && {_object animationSourcePhase "et_4_source" isEqualTo 1}) exitWith {
		_step = 3;
		_object animateSource ["et_3_source",1,true];
		_object animateSource ["et_4_source",0,true];
	};
	_vitesse = 1;
	if(_object animationSourcePhase "hide_uv_source" < 0.9) then {
		_vitesse = _vitesse + 0.4;
		_pure = _pure + 1;
	};
	_count = _count + _vitesse;
	_object setVariable ["pure",_pure];
	uiSleep _speed;
};
