/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
if (!isNil "life_curWep_h" && {!(life_curWep_h isEqualTo "")}) then {
	life_curWep_h = currentWeapon player;
	player action ["SwitchWeapon", player, player, 100];
	player switchCamera cameraView;
};

if (!(currentWeapon player isEqualTo "") && (ALF_Phone_tryCall || {ALF_Phone_inCall} || {ALF_Phone_Ring} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender})) then {
	life_curWep_h = currentWeapon player;
	player action ["SwitchWeapon", player, player, 100];
	player switchCamera cameraView;
};

if ([player] call ALF_fnc_checkMenotter) then {
	player playActionNow "ALF_Menotter";
};

if ([player] call ALF_fnc_checkSurrender) then {
	player playActionNow "ALF_Surrender";
};

if !(isNull ALF_PhoneObject) then {
	detach ALF_PhoneObject;
	ALF_PhoneObject attachTo [player, [0.02,0.01,0.15], "RightHandMiddle1"];
	ALF_PhoneObject setVectorDirAndUp [[-0.21017,0.265195,-0.94101],[-0.949623,0.173499,0.260989]];
	[{player playActionNow "ALF_Tel";}] call CBA_fnc_execNextFrame;
};

if ( (_this select 0) isEqualTo player && { (_this select 2) isKindOf "Ship" } ) then {
    ["stop", (_this select 2)] call ALF_fnc_pecheBateau;
};