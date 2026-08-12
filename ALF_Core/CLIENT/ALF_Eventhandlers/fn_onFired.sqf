// ALF_fnc_onFired = {
private ["_unit","_ammo","_cfg","_anim","_pr","_mg"];
_unit = _this select 0;
_ammo = _this select 4;
_mg = _this select 5;
_pr = _this select 6;

if (_ammo isEqualTo "ALF_FireNozzle_Ammo" AND {isNull ropeAttachedTo player}) exitWith {
	deleteVehicle _pr;
	player action ["SwitchWeapon", player, player, 100];
};

if (_ammo isEqualTo "ALF_FireNozzle_Ammo" AND {!life_firenozzle}) exitWith {
	life_firenozzle = true;
	_pr spawn {
		// Initialiser _position immediatement pour eviter nil si projectile disparait vite
		private _position = getPosATL _this;
		while {!isNull _this} do {
            _position = getPosATL _this;
            uiSleep 0.05;
        };
		// Verifier que _position est valide avant d'appeler fireNozzle
		if (!isNil "_position" && {count _position == 3}) then {
			[_position] spawn ALF_fnc_fireNozzle;
		};
		life_firenozzle = false;
	};
};

if (!isNull _pr && {_ammo == "KA_40mm_M7A3" || {_mg isKindOf "LBD_40mm_lacrymo"}}) exitWith {
	[_pr] spawn {
		params ["_proj"];
		sleep 0.5;
		for "_i" from 1 to 60 do {
			if (isNull _proj) exitWith {};
			private _pos = getPosASL _proj;
			_pos set [2, 0];
			{
				private _inside = (_x distance _pos < 8);
				private _wasInside = _x getVariable ["MA_inGasCloud", false];
								
				if (_inside && !_wasInside) then {
					[_x] remoteExec ["ALF_fnc_actionFumee", _x];
				};
			} forEach allPlayers;
		
			sleep 1;
		};
	};
};

if (!isNull _pr && {_ammo == "MRP_Gazeuse_Gaz" || {_mg isKindOf "MRP_Gazeuse_Bonbonne"}}) exitWith {
	[_unit] spawn {
		params ["_shooter"];
			if (isNull _shooter) exitWith {};

			private _pos = getPosASL _shooter;
			private _dir = getDir _shooter;
			{
				private _distance = _x distance _pos;
				private _bearing = _pos getDir (getPosASL _x);
				private _angleDiff = abs ((_bearing - _dir) mod 360);
				if (_angleDiff > 180) then { _angleDiff = 360 - _angleDiff; };

				private _inFront = (_distance < 6) && (_angleDiff < 45);
				private _wasInside = _x getVariable ["MA_inGasCloud", false];
	
				
				if (_inFront && !_wasInside) then {
					[_x, 1] remoteExec ["ALF_fnc_actionFumee", _x];
				};
			} forEach allPlayers;
	};
};

if (!isNull _pr && {_ammo == "GrenadePLMP7C_ammo" || {_mg isKindOf "GrenadePLMP7C"}}) exitWith {
	[_pr] spawn {
		params ["_proj"];
        private _lastPos = getPosASL _proj;

        waitUntil {
            sleep 0.05;
            if (!isNull _proj) then { _lastPos = getPosASL _proj; };
            isNull _proj
        };

        if (_lastPos isEqualTo [0,0,0]) exitWith {};

        for "_i" from 1 to 60 do {
            {
                private _inside = (_x distance _lastPos < 20);
                private _wasInside = _x getVariable ["MA_inGasCloud", false];

                if (_inside && !_wasInside) then {
                    [_x] remoteExec ["ALF_fnc_actionFumee", _x];
                };				
            } forEach allPlayers;

            sleep 1;
        };
	};
};


if (currentWeapon _unit isEqualTo "hgun_Pistol_Signal_F") exitWith {
	_bullet = _this select 6;
	deleteVehicle _bullet;
	_pos = getPosATL player;
	_direction = player weaponDirection (currentWeapon player);
	["random",_pos,"normal",_direction] remoteExec ["ALF_Server_fnc_fire",2];
};

if (_mg isEqualTo "KA_M7290") exitWith {
	_pr spawn {
        private "_position";
        while {!isNull _this} do {
            _position = ASLtoATL (visiblePositionASL _this);
            uiSleep 0.05;
        };
        [_position] remoteExec ["ALF_fnc_flashbang",playableUnits select {_x distance _position < 20}];
    };
};

if (_mg isEqualTo "KA_M814") exitWith {
	_pr spawn {
        private "_position";
        while {!isNull _this} do {
            _position = ASLtoATL (visiblePositionASL _this);
            uiSleep 0.05;
        };
		private _vehs = _position nearEntities [["Air", "Car", "Ship"], 7];
		if ((count _vehs) > 0) then {
			{
				private _locked = locked _x;
				if (_locked isEqualTo 2) then {
					if (local _x) then {
						_x lock 0;
					} else {
						[_x,0] remoteExecCall ["ALF_fnc_lockVehicle",_x];
					};
				};
			} forEach _vehs;
		};
        [_position] remoteExec ["ALF_fnc_iem",playableUnits select {_x distance _position < 8}];
    };
};

if (_mg isEqualTo "KA_M84") exitWith {
	_pr spawn {
        private "_position";
        while {!isNull _this} do {
            _position = ASLtoATL (visiblePositionASL _this);
            uiSleep 0.05;
        };
        [_position] remoteExec ["ALF_fnc_stunGrenade",playableUnits select {_x distance _position < 20}];
    };
};

if ((currentWeapon _unit isEqualTo primaryWeapon _unit) AND primaryWeapon _unit isEqualTo "ALF_CanneAPeche" AND !ALF_PecheEnCours) exitWith {
	[] spawn ALF_fnc_peche;
};

if (_ammo isKindOf "Melee") then {
	_cfg = (configFile >> "CfgAmmo" >> _ammo >> "Melee");
	_anim = getText(_cfg >> "anim");
	_unit playActionNow _anim;
};

if (currentWeapon _unit isEqualTo "ALF_Hache" AND {cursorObject isKindOf "House_F"} AND {life_mediclevel > 0}) exitWith {
	if (isNil {(cursorObject getVariable ["ALF_PorteFermer",false])}) exitWith {};
	private _door = [cursorObject,player] call ALF_fnc_nearestDoor;
	if (_door isEqualTo 0) exitWith {};
	if !(cursorObject getVariable ["ALF_PorteFermer",false]) exitWith {};
	if ((time - life_hit_time) > 10) then { life_ALF_Hit = 0; };
	life_hit_time = time;
	life_ALF_Hit = life_ALF_Hit + 1;
	if (life_ALF_Hit >= 5) then {
		cursorObject animateSource [format ["Door_%1_sound_source",_door],1];
		cursorObject animate [format ["Door_%1",_door],1];
		cursorObject animate [format ["Door%1",_door],1];
		life_ALF_Hit = 0;
		["Info",format["%1 vient d'enfoncer une porte.",name player]] remoteExecCall ["ALF_Server_fnc_doMedCall",2];
	};
};

if (currentWeapon _unit in ["ALF_Hache","ALF_Pioche","ALF_Batte","ALF_Faux","ALF_Couteau"] AND {cursorObject isKindOf "Man"} AND {(_unit distance cursorObject) < 2.2}) exitWith {
	[currentWeapon _unit] remoteExec ["ALF_fnc_kickSystem",cursorObject];
};

/* ====== MINAGE : suppression des verrous XP, on lance directement selon la cible ====== */
if (currentWeapon _unit isEqualTo "ALF_Pioche" AND {(_unit distance cursorObject) < 1.5}) exitWith {
	// Pierre basique
	if (typeOf cursorObject isEqualTo "Land_ALF_Pierre") exitWith {
		["ALF_pierre_small",0] spawn ALF_fnc_minageSystem;
	};
	// Cuivre
	if (typeOf cursorObject isEqualTo "Land_ALF_Pierre_cui") exitWith {
		["ALF_pierre_cui_small",1] spawn ALF_fnc_minageSystem;
	};
	// Fer
	if (typeOf cursorObject isEqualTo "Land_ALF_Pierre_fer") exitWith {
		["ALF_pierre_fer_small",2] spawn ALF_fnc_minageSystem;
	};
	// Saphir
	if (typeOf cursorObject isEqualTo "Land_ALF_Pierre_saphir") exitWith {
		["ALF_saphir_small",3] spawn ALF_fnc_minageSystem;
	};
	// Diamant
	if (typeOf cursorObject isEqualTo "Land_ALF_Pierre_dia") exitWith {
		["ALF_pierre_dia_small",3] spawn ALF_fnc_minageSystem;
	};
	// Or
	if (typeOf cursorObject isEqualTo "Land_ALF_Pierre_or") exitWith {
		["ALF_Pepite_Or",3] spawn ALF_fnc_minageSystem;
	};
};

/* ====== BOIS : suppression du niveau de récolte ====== */
private _nom_Modele = getModelInfo cursorObject # 0;
private _cible_Est_Arbre = "t_" in _nom_Modele AND {!("t_f" in _nom_Modele)};

if (currentWeapon _unit isEqualTo "ALF_Hache" AND {(_unit distance cursorObject) < 15 AND {b_18 && b_enService}}) exitWith {
	[cursorObject] spawn ALF_fnc_woodSystemDIR;
};

if (currentWeapon _unit isEqualTo "ALF_Hache" AND {(_unit distance cursorObject) < 15 AND {_cible_Est_Arbre}}) exitWith {
	[cursorObject] spawn ALF_fnc_woodSystem;
};

/* ====== SABLE : suppression du niveau requis ====== */
if (currentWeapon player isEqualTo "ALF_Pioche" AND (player distance (getMarkerPos "sable") < 50)) then {
	[] spawn ALF_fnc_sandSystem;
};

// };
