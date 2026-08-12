#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_mobilierInvSearch.sqf
*/
params [
	["_container",objNull,[objNull]]
];
if(isNull _container) exitWith {};

private _mode = _this select 1;

// Vérifier si c'est un coffre fort (ne peut pas être forcé avec lockpick)
private _modelPath = (getModelInfo _container) select 1;
private _isSafe = (!isNil "_modelPath" && {_modelPath isEqualTo "alf_mobiliers\alf_safe_1\alf_safe_1.p3d"});

if (_isSafe) exitWith {
	["Info", "Les coffres forts ne peuvent pas être forcés avec un lockpick. Utilisez une perceuse.", "warning", false] spawn ALF_fnc_doMsg;
};

if(_mode isEqualTo 0) then {
	// Mode 0 : Gendarmes avec lockpick - Barre de progression + vérification lockpick
	// Vérifier qu'on a un lockpick
	if !("ALF_Lockpick" in (magazines player)) exitWith {
		["Info", "Vous avez besoin d'un lockpick pour forcer ce coffre.", "warning", false] spawn ALF_fnc_doMsg;
	};
	
	// Vérifier la distance
	if (player distance _container > 3) exitWith {
		["Info", "Vous êtes trop loin du coffre.", "warning", false] spawn ALF_fnc_doMsg;
	};
	
	if (life_action_inUse) exitWith {};
	life_action_inUse = true;
	life_interrupted = false;
	
	private _title = "Forçage du coffre";
	private _3dlock = "Land_File_F" createVehicle [0,0,0];
	_3dlock attachTo [player, [-0.015,0.08,0], "RightHandMiddle1"];
	_3dlock setDir 180;
	
	// Setup progress bar
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN"];
	private _ui = uiNameSpace getVariable "life_progress";
	private _progressBar = _ui displayCtrl 38201;
	private _titleText = _ui displayCtrl 38202;
	_titleText ctrlSetText format["%2 (1%1)...","%",_title];
	_progressBar progressSetPosition 0.01;
	private _cP = 0.01;
	private _cpRate = 0.01;
	
	for "_i" from 0 to 1 step 0 do {
		if (animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
			player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
			player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
		};
		sleep 0.5;
		_cP = _cP + _cpRate;
		_progressBar progressSetPosition _cP;
		_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
		
		if (_cP >= 1 OR !alive player) exitWith {};
		if (life_istazed) exitWith {detach _3dlock; deleteVehicle _3dlock;};
		if (life_isknocked) exitWith {detach _3dlock; deleteVehicle _3dlock;};
		if (life_interrupted) exitWith {detach _3dlock; deleteVehicle _3dlock;};
		if ([player] call ALF_fnc_checkMenotter) exitWith {detach _3dlock; deleteVehicle _3dlock;};
		if (player distance _container > 3) exitWith {detach _3dlock; deleteVehicle _3dlock;};
	};
	
	// Kill UI
	5 cutText ["","PLAIN"];
	player playActionNow "stop";
	if (!isNull _3dlock) then { detach _3dlock; deleteVehicle _3dlock; };
	
	life_action_inUse = false;
	
	if (!alive player OR life_istazed OR life_isknocked) exitWith {};
	if ([player] call ALF_fnc_checkMenotter) exitWith {};
	if (life_interrupted) exitWith {
		life_interrupted = false;
		["Info", "Action annulée.", "warning"] spawn ALF_fnc_doMsg;
	};
	if (player distance _container > 3) exitWith {
		["Info", "Vous êtes trop loin du coffre.", "warning"] spawn ALF_fnc_doMsg;
	};
	
	// Vérifier qu'on a toujours un lockpick
	if !("ALF_Lockpick" in (magazines player)) exitWith {
		["Info", "Vous n'avez plus de lockpick.", "warning"] spawn ALF_fnc_doMsg;
	};
	
	// Gendarmes : succès garanti mais toujours laisser de l'ADN pour traçabilité
	private _adn = (player getVariable ["adnface", ["Inconnu","Inconnu"]]) select 0;
	
	["Info", "Le coffre a été forcé avec succès !", "success"] spawn ALF_fnc_doMsg;
	[name player,getPlayerUID player,"Lockpick",format["(Gendarme) A forcé un coffre avec succès | POS : %1", getPos _container]] remoteExec ["ALF_Server_fnc_logIt",2];
	
	// Laisser de l'ADN (pour traçabilité RP)
	private _data = _container getVariable ["ilyadeladn",[]];
	if (count _data isEqualTo 0) then {
		_container setVariable["ilyadeladn",[_adn],true];
	} else {
		_data pushBack _adn;
		_container setVariable["ilyadeladn",_data,true];
	};
	
	// Ouvrir l'inventaire
	[_container] call ALF_fnc_mobilierInv;
} else {
	if(_mode isEqualTo 1) then {
		// Mode 1 : Civils avec lockpick - Barre de progression + vérification lockpick
		
		// Vérifier qu'on a un lockpick
		if !("ALF_Lockpick" in (magazines player)) exitWith {
			["Info", "Vous avez besoin d'un lockpick pour forcer ce coffre.", "warning", false] spawn ALF_fnc_doMsg;
		};
		
		// Vérifier la distance
		if (player distance _container > 3) exitWith {
			["Info", "Vous êtes trop loin du coffre.", "warning", false] spawn ALF_fnc_doMsg;
		};
		
		if (life_action_inUse) exitWith {};
		life_action_inUse = true;
		life_interrupted = false;
		
		private _title = "Forçage du coffre";
		private _3dlock = "Land_File_F" createVehicle [0,0,0];
		_3dlock attachTo [player, [-0.015,0.08,0], "RightHandMiddle1"];
		_3dlock setDir 180;
		
		// Setup progress bar
		disableSerialization;
		5 cutRsc ["life_progress","PLAIN"];
		private _ui = uiNameSpace getVariable "life_progress";
		private _progressBar = _ui displayCtrl 38201;
		private _titleText = _ui displayCtrl 38202;
		_titleText ctrlSetText format["%2 (1%1)...","%",_title];
		_progressBar progressSetPosition 0.01;
		private _cP = 0.01;
		private _cpRate = 0.01;
		
		for "_i" from 0 to 1 step 0 do {
			if (animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
				player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
				player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
			};
			sleep 0.5;
			_cP = _cP + _cpRate;
			_progressBar progressSetPosition _cP;
			_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
			
			if (_cP >= 1 OR !alive player) exitWith {};
			if (life_istazed) exitWith {detach _3dlock; deleteVehicle _3dlock;};
			if (life_isknocked) exitWith {detach _3dlock; deleteVehicle _3dlock;};
			if (life_interrupted) exitWith {detach _3dlock; deleteVehicle _3dlock;};
			if ([player] call ALF_fnc_checkMenotter) exitWith {detach _3dlock; deleteVehicle _3dlock;};
			if (player distance _container > 3) exitWith {detach _3dlock; deleteVehicle _3dlock;};
		};
		
		// Kill UI
		5 cutText ["","PLAIN"];
		player playActionNow "stop";
		if (!isNull _3dlock) then { detach _3dlock; deleteVehicle _3dlock; };
		
		life_action_inUse = false;
		
		if (!alive player OR life_istazed OR life_isknocked) exitWith {};
		if ([player] call ALF_fnc_checkMenotter) exitWith {};
		if (life_interrupted) exitWith {
			life_interrupted = false;
			["Info", "Action annulée.", "warning"] spawn ALF_fnc_doMsg;
		};
		if (player distance _container > 3) exitWith {
			["Info", "Vous êtes trop loin du coffre.", "warning"] spawn ALF_fnc_doMsg;
		};
		
		// Vérifier qu'on a toujours un lockpick
		if !("ALF_Lockpick" in (magazines player)) exitWith {
			["Info", "Vous n'avez plus de lockpick.", "warning"] spawn ALF_fnc_doMsg;
		};
		
		// Tentative de forçage avec chance de succès/échec
		private _dice = random(1000);
		private _adn = (player getVariable ["adnface", ["Inconnu","Inconnu"]]) select 0;
		
		if (_dice >= 500) then {
			// ÉCHEC - Le lockpick se casse
			["Info", "Vous avez cassé le lockpick ! Le coffre résiste.", "warning"] spawn ALF_fnc_doMsg;
			["ALF_Lockpick",false] spawn ALF_fnc_handleItem;
			[name player,getPlayerUID player,"Lockpick",format["A tenté de forcer un coffre (ÉCHEC) | POS : %1", getPos _container]] remoteExec ["ALF_Server_fnc_logIt",2];
			
			// Chance de laisser de l'ADN même en échec
			if (_dice > 700 && {_dice < 950}) then {
				private _data = _container getVariable ["ilyadeladn",[]];
				if (count _data isEqualTo 0) then {
					_container setVariable["ilyadeladn",[_adn],true];
				} else {
					_data pushBack _adn;
					_container setVariable["ilyadeladn",_data,true];
				};
			};
		} else {
			// SUCCÈS - Le coffre s'ouvre
			["Info", "Le coffre a été forcé avec succès !", "success"] spawn ALF_fnc_doMsg;
			[name player,getPlayerUID player,"Lockpick",format["A forcé un coffre avec succès | POS : %1", getPos _container]] remoteExec ["ALF_Server_fnc_logIt",2];
			
			// Laisser de l'ADN (70% de chance)
			if (_dice >= 200 && {_dice <= 900}) then {
				private _data = _container getVariable ["ilyadeladn",[]];
				if (count _data isEqualTo 0) then {
					_container setVariable["ilyadeladn",[_adn],true];
				} else {
					_data pushBack _adn;
					_container setVariable["ilyadeladn",_data,true];
				};
			};
			
			// Ouvrir l'inventaire après succès
			[_container] call ALF_fnc_mobilierInv;
		};
	};
};
