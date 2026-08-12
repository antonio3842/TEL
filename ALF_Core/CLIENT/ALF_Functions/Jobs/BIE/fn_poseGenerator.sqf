/*
	File: PoseGenerator
	Author: MRP - Lopa
*/
params[
	["_mode",0],
	["_object",objNull,[objNull]],
	["_item",objNull]
];

switch (_mode) do {
	case 0: { //place petit generateur

		life_action_inUse = true;
		life_interrupted = false;
		disableSerialization;
		private _display = findDisplay 46;
		waitUntil { !isNull _display };

		private _barW = 0.3;
		private _barH = 0.04;
		private _barX = safeZoneX + (safeZoneW - _barW) / 2;
		private _barY = safeZoneY + (safeZoneH - _barH) / 2;

		private _progressBar = _display ctrlCreate ["RscProgress", -1];
		_progressBar ctrlSetPosition [_barX, _barY, _barW, _barH];
		_progressBar ctrlSetBackgroundColor [0, 0, 0, 0.5];
		_progressBar ctrlCommit 0;
		_progressBar progressSetPosition 0;

		private _upp = "Pose du générateur";
		private _text = _display ctrlCreate ["RscStructuredText", -1];
		_text ctrlSetPosition [_barX, _barY - 0.05, _barW, 0.04];
		_text ctrlSetStructuredText parseText format ["<t align='center' size='1.2'>%1</t>", _upp];
		_text ctrlCommit 0;

		private _cP = 0;
		for "_i" from 0 to 30 do {
			if (!alive player || player != vehicle player || life_interrupted) exitWith {};

			if (animationState player != "Acts_carFixingWheel") then {
				player switchMove "Acts_carFixingWheel";
				player playMoveNow "Acts_carFixingWheel";
			};

			_cP = _i / 30;
			_progressBar progressSetPosition _cP;
			sleep 0.1;
		};
		if (alive player and vehicle player isEqualTo player and !life_interrupted) then {
			_pos = player modelToWorld [0,1,0];
			_pos set [2, 0.5];
			_generator = "Land_Portable_generator_F" createVehicle [0,0,0];
			_dir = (getdir player) + 90;
			_generator setDir _dir;
			_generator setPosATL _pos;
			[_generator] spawn ALF_fnc_connectCable;
			_generator setVariable ["soundLoop", true];
			_generator setVariable ["generatorEssence", 0, true];
			[_generator,true] remoteExecCall ["enableDynamicSimulation",2];
			["BOXED_land_MRP_Petit_Generateur",false] remoteExec ["ALF_fnc_handleItem",player];
			["ENGIE","Générateur posé, penez à le remplir d'essence .","warning"] remoteExec ["ALF_fnc_doMsg",player];
		};
		ctrlDelete _progressBar;
		ctrlDelete _text;
		life_action_inUse = false;
		player playActionNow "stop";
		player switchMove "";
		if(life_interrupted) exitWith {life_interrupted = false; ["ENGIE", "Action annulée.", "danger", false] spawn ALF_fnc_doMsg;};
	};
	
	case 1: { //Remove petit generateur
	
		life_action_inUse = true;
		life_interrupted = false;
		disableSerialization;
		private _display = findDisplay 46;
		waitUntil { !isNull _display };

		private _barW = 0.3;
		private _barH = 0.04;
		private _barX = safeZoneX + (safeZoneW - _barW) / 2;
		private _barY = safeZoneY + (safeZoneH - _barH) / 2;

		private _progressBar = _display ctrlCreate ["RscProgress", -1];
		_progressBar ctrlSetPosition [_barX, _barY, _barW, _barH];
		_progressBar ctrlSetBackgroundColor [0, 0, 0, 0.5];
		_progressBar ctrlCommit 0;
		_progressBar progressSetPosition 0;

		private _upp = "Récupération du générateur";
		private _text = _display ctrlCreate ["RscStructuredText", -1];
		_text ctrlSetPosition [_barX, _barY - 0.05, _barW, 0.04];
		_text ctrlSetStructuredText parseText format ["<t align='center' size='1.2'>%1</t>", _upp];
		_text ctrlCommit 0;

		private _cP = 0;
		for "_i" from 0 to 20 do {
			if (!alive player || player != vehicle player || life_interrupted) exitWith {};

			if (animationState player != "Acts_carFixingWheel") then {
				player switchMove "Acts_carFixingWheel";
				player playMoveNow "Acts_carFixingWheel";
			};

			_cP = _i / 20;
			_progressBar progressSetPosition _cP;
			sleep 0.1;
		};

		if (alive player and vehicle player isEqualTo player and !life_interrupted) then {
			private _target = _object getVariable ["_cableTarget", objNull];
			private _anc1 = attachedObjects _object select { typeOf _x isEqualTo "C_Quadbike_01_F" };
			{
				private _rope = ropeAttachedTo _x;
				if !(isNull _rope) then { ropeDestroy _rope; };
				deleteVehicle _x;
			} forEach _anc1;

			if (!isNull _target) then {
				_target setVariable ["HasCourant", false, true];
			};
			_object setVariable ["soundLoop", false];
			deleteVehicle _object;
			[] spawn ALF_fnc_actionLamps;
			["BOXED_land_MRP_Petit_Generateur",true] remoteExec ["ALF_fnc_handleItem",player];
		};

		ctrlDelete _progressBar;
		ctrlDelete _text;
		life_action_inUse = false;
		player playActionNow "stop";
		player switchMove "";
		if(life_interrupted) exitWith {life_interrupted = false; ["ENGIE", "Action annulée.", "danger", false] spawn ALF_fnc_doMsg;};
	};
	
	case 2: {  //Place big generateur
		
		life_action_inUse = true;
		life_interrupted = false;
		disableSerialization;
		private _display = findDisplay 46;
		waitUntil { !isNull _display };

		private _barW = 0.3;
		private _barH = 0.04;
		private _barX = safeZoneX + (safeZoneW - _barW) / 2;
		private _barY = safeZoneY + (safeZoneH - _barH) / 2;

		private _progressBar = _display ctrlCreate ["RscProgress", -1];
		_progressBar ctrlSetPosition [_barX, _barY, _barW, _barH];
		_progressBar ctrlSetBackgroundColor [0, 0, 0, 0.5];
		_progressBar ctrlCommit 0;
		_progressBar progressSetPosition 0;

		private _upp = "Pose du générateur";
		private _text = _display ctrlCreate ["RscStructuredText", -1];
		_text ctrlSetPosition [_barX, _barY - 0.05, _barW, 0.04];
		_text ctrlSetStructuredText parseText format ["<t align='center' size='1.2'>%1</t>", _upp];
		_text ctrlCommit 0;

		private _cP = 0;
		for "_i" from 0 to 60 do {
			if (!alive player || player != vehicle player || life_interrupted) exitWith {};

			if (animationState player != "Acts_carFixingWheel") then {
				player switchMove "Acts_carFixingWheel";
				player playMoveNow "Acts_carFixingWheel";
			};

			_cP = _i / 60;
			_progressBar progressSetPosition _cP;
			sleep 0.1;
		};

		if (alive player and vehicle player isEqualTo player and !life_interrupted) then {
			_pos = player modelToWorld [0,1,0];
			_pos set [2, 0];
			_generator = "Land_PowerGenerator_F" createVehicle [0,0,0];
			_dir = (getdir player) + 90;
			_generator setDir _dir;
			_generator setPosATL _pos;
			_generator setVariable ["soundLoop", true];
			_generator setVariable ["generatorEssence", 0, true];
			[] spawn ALF_fnc_actionLamps;
			[_generator] spawn {
				while {true} do {
					_essence = _this#0 getVariable ["generatorEssence", 0];
					_essence  = _essence - 1;
					if (_essence <= 0) then {
						_essence = 0;
					};
					_this#0 setVariable ["generatorEssence", _essence, true];
					sleep 60;
				};
			};
			
			[_generator] spawn {
				while {(_this#0 getVariable ["soundLoop", false])} do {
					_essence = _this#0 getVariable ["generatorEssence", 0];
					if (_essence >= 15) then {
						[(_this#0), "LinkTerminal_01_Standby_Loop"] remoteExec ["say3D"];
					} else {
						if (_essence >= 1) then {
							[(_this#0), "LinkTerminal_02_Standby_Loop"] remoteExec ["say3D"];
						} else {
							//[(_this#0), ""] remoteExec ["say3D"];
						};
					};
					sleep 13.98;
				};
			};

			[_generator,true] remoteExecCall ["enableDynamicSimulation",2];
			["ENGIE","Générateur posé, penez à le remplir d'essence .","warning"] remoteExec ["ALF_fnc_doMsg",player];
			["BOXED_land_MRP_Grand_Generateur",false] remoteExec ["ALF_fnc_handleItem",player];
		};

		ctrlDelete _progressBar;
		ctrlDelete _text;
		life_action_inUse = false;
		player playActionNow "stop";
		player switchMove "";
		if(life_interrupted) exitWith {life_interrupted = false; ["ENGIE", "Action annulée.", "danger", false] spawn ALF_fnc_doMsg;};
		

	};
	
	case 3: { //Remove big generateur
	
		life_action_inUse = true;
		life_interrupted = false;
		disableSerialization;
		private _display = findDisplay 46;
		waitUntil { !isNull _display };

		private _barW = 0.3;
		private _barH = 0.04;
		private _barX = safeZoneX + (safeZoneW - _barW) / 2;
		private _barY = safeZoneY + (safeZoneH - _barH) / 2;

		private _progressBar = _display ctrlCreate ["RscProgress", -1];
		_progressBar ctrlSetPosition [_barX, _barY, _barW, _barH];
		_progressBar ctrlSetBackgroundColor [0, 0, 0, 0.5];
		_progressBar ctrlCommit 0;
		_progressBar progressSetPosition 0;

		private _upp = "Récupération du générateur";
		private _text = _display ctrlCreate ["RscStructuredText", -1];
		_text ctrlSetPosition [_barX, _barY - 0.05, _barW, 0.04];
		_text ctrlSetStructuredText parseText format ["<t align='center' size='1.2'>%1</t>", _upp];
		_text ctrlCommit 0;

		private _cP = 0;
		for "_i" from 0 to 30 do {
			if (!alive player || player != vehicle player || life_interrupted) exitWith {};

			if (animationState player != "Acts_carFixingWheel") then {
				player switchMove "Acts_carFixingWheel";
				player playMoveNow "Acts_carFixingWheel";
			};

			_cP = _i / 30;
			_progressBar progressSetPosition _cP;
			sleep 0.1;
		};

		if (alive player and vehicle player isEqualTo player and !life_interrupted) then {
			_object setVariable ["soundLoop", false];
			deleteVehicle _object;
			[] spawn ALF_fnc_actionLamps;
			["BOXED_land_MRP_Grand_Generateur",true] remoteExec ["ALF_fnc_handleItem",player];
		};

		ctrlDelete _progressBar;
		ctrlDelete _text;
		life_action_inUse = false;
		player playActionNow "stop";
		player switchMove "";
		if(life_interrupted) exitWith {life_interrupted = false; ["ENGIE", "Action annulée.", "danger", false] spawn ALF_fnc_doMsg;};
	};
	
	case 4: { //Refuel Generateur
	
		life_action_inUse = true;
		life_interrupted = false;
		disableSerialization;
		private _display = findDisplay 46;
		waitUntil { !isNull _display };

		private _barW = 0.3;
		private _barH = 0.04;
		private _barX = safeZoneX + (safeZoneW - _barW) / 2;
		private _barY = safeZoneY + (safeZoneH - _barH) / 2;

		private _progressBar = _display ctrlCreate ["RscProgress", -1];
		_progressBar ctrlSetPosition [_barX, _barY, _barW, _barH];
		_progressBar ctrlSetBackgroundColor [0, 0, 0, 0.5];
		_progressBar ctrlCommit 0;
		_progressBar progressSetPosition 0;

		private _upp = "Remplissage en cours";
		private _text = _display ctrlCreate ["RscStructuredText", -1];
		_text ctrlSetPosition [_barX, _barY - 0.05, _barW, 0.04];
		_text ctrlSetStructuredText parseText format ["<t align='center' size='1.2'>%1</t>", _upp];
		_text ctrlCommit 0;

		private _cP = 0;
		for "_i" from 0 to 20 do {
			if (!alive player || player != vehicle player || life_interrupted) exitWith {};

			if (animationState player != "Acts_carFixingWheel") then {
				player switchMove "Acts_carFixingWheel";
				player playMoveNow "Acts_carFixingWheel";
			};

			_cP = _i / 20;
			_progressBar progressSetPosition _cP;
			sleep 0.1;
		};

		if (alive player and vehicle player isEqualTo player and !life_interrupted) then {
			["Générateur", "Vous avez rechargé votre générateur pour environ 1h. Le générateur redémarre dans 1min", "success", false] spawn ALF_fnc_doMsg;
			_object setVariable ["generatorEssence", 60, true];
			[_item,false] spawn ALF_fnc_handleItem;
		};

		ctrlDelete _progressBar;
		ctrlDelete _text;
		life_action_inUse = false;
		player playActionNow "stop";
		player switchMove "";
		if(life_interrupted) exitWith {life_interrupted = false; ["ENGIE", "Action annulée.", "danger", false] spawn ALF_fnc_doMsg;};
	};
};