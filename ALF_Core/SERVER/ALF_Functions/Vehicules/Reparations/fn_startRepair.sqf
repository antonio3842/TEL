/*
	File: fn_startRepair.sqf
	Author: ALF TEAM
*/

params [
	["_elevator", [], [[]]],
	["_unit", objNull, [objNull]]
];

private _repairDuration = 60;

private _garage = (nearestObjects [_unit,["Land_ALF_AtelierMecanique"],30]) select 0;
if (isNull (_garage getVariable [(_elevator select 0) + "_veh_charge", objNull])) exitWith {};

if (_garage getVariable [(_elevator select 0) + "_in_repair", false]) exitWith {
	private _elapsed = time - (_garage getVariable [(_elevator select 0) + "_repairTime", time]);
	private _remaining = (_repairDuration - _elapsed) max 0;
	if (_remaining <= 0) then {
		_garage setVariable [(_elevator select 0) + "_in_repair", false];
	} else {
		private _timeStr = [_remaining] call BIS_fnc_secondsToString;
		["GARAGE", format ["Le véhicule est déjà en cours de réparation. Il reste %1 de réparation.", _timeStr], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
	};
};

if ((_garage animationSourcePhase (_elevator select 1)) < 0.5) exitWith {};

private _veh = _garage getVariable [(_elevator select 0) + "_veh_charge", objNull];

if (isNull _veh) exitWith {
	["GARAGE", "Il n'y a aucun véhicule sur le pont élévateur.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];
};

if ((_garage getVariable [(_elevator select 0) + "_diag", 0]) != 2) exitWith {
	["GARAGE", "Vous devez d'abord lancer le diagnostic.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];
};

if (!("ALF_KitMecatechnic" in magazines _unit)) exitWith {
	["GARAGE", "Vous devez posséder une caisse de réparation.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];
};

private _damages = [];
private _allBackpack = true;

{
    _part = configName _x;
    _config = configFile >> "ALF_Repair" >> _part;
    
    // **Affichage des infos des `HitPoints` détectés :**
    diag_log format ["Partie : %1 - Dégâts actuels : %2", _part, _veh getHitPointDamage _part];

    if (isClass(_config)) then {
        diag_log format ["Classe ALF_Repair trouvée pour %1 : %2", _part, true];
        if ((_veh getHitPointDamage _part) > 0) then {
            _item = getText(_config >> "item");
            if (!(_item isEqualTo "") && !(_item in magazines _unit)) then {
                _allBackpack = false;
            };
            _damages pushBack [_part, _item];
            diag_log format ["[INFO] Pièce endommagée ajoutée à la liste : %1 - Nécessite l'item : %2", _part, _item];
        };
    } else {
        diag_log format ["[ERREUR] Pas de classe ALF_Repair trouvée pour %1", _part];
    };
} foreach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf(_veh) >> "HitPoints"));
diag_log format ["Configuration de réparation_2 : %1", ALF_Repair];


/*
private _damages = [];
private _allBackpack = true;
{

	_part = configName _x;
	_config = configFile >> "ALF_Repair" >> _part;

	if (isClass(_config)) then {
		if ((_veh getHitPointDamage _part) > 0) then {

			_item = getText(_config >> "item");

			if (!(_item isEqualTo "") && !(_item in magazines player)) then {
				_allBackpack = false;
			};
			_damages pushBack [_part, _item];
		};
	};
} foreach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf(_veh) >> "HitPoints"));
*/
if (_damages isEqualTo []) then {
    diag_log "[INFO] Le véhicule ne semble pas endommagé.";
    ["Info", "Le véhicule ne semble pas endommagé.", "danger"] spawn ALF_fnc_doMsg;
} else {
    diag_log "[INFO] Lancement de la réparation.";
    if (!(_allBackpack)) then {
        diag_log "[WARNING] Toutes les pièces ne sont pas présentes sur le joueur.";
        ["GARAGE", "Vous n'avez pas toutes les pièces sur vous. Le véhicule ne sera pas réparé entièrement.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
    };

    _garage setVariable [(_elevator select 0) + "_in_repair", true];
    _garage setVariable [(_elevator select 0) + "_repairTime", time];
    private _final_damages = [];

    {
        if ((_x select 1) != "") then {
            if ((_x select 1) in magazines _unit) then {
                _unit removeItem (_x select 1);
                diag_log format ["[INFO] Pièce utilisée pour réparation : %1", _x select 1];
                _final_damages pushBack _x;
            };
        } else {
            _final_damages pushBack _x;
        };
    } forEach _damages;

    ["GARAGE", "Vous avez lancé la réparation.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];

    diag_log format ["[DEBUG] Réparation en cours... Temps d'attente %1 secondes.", _repairDuration];
    uiSleep _repairDuration;

    if (
        ((_garage getVariable [(_elevator select 0) + "_veh_charge", objNull]) == _veh) &&
        ((_garage animationSourcePhase (_elevator select 1)) > 0.5)
    ) then {
        diag_log "[INFO] Réparation terminée avec succès.";
        playSound3D ["ALF_Client2\sounds\bip.ogg", _garage, false, _garage modelToWorld (_garage selectionPosition [(_elevator select 0), "Memory"]), 2, 1, 20];
        {
            if (!(local _veh)) then {
                [_veh, (_x select 0), 0] remoteExecCall ["ALF_fnc_setHPD", _veh];
            } else {
                _veh setHitPointDamage [(_x select 0), 0];
            };
        } foreach _final_damages;

        if (_allBackpack) then {
            _veh setDamage 0;
            private _parts = getAllHitPointsDamage _veh;

            {
                _veh setHitPointDamage [format ["%1", (_x select _forEachIndex)], 0];
            } forEach (_parts select 0);
        };
    } else {
        diag_log "[ERREUR] Véhicule déplacé ou ascenseur descendu pendant la réparation.";
    };

    _garage setVariable [(_elevator select 0) + "_in_repair", false];
    diag_log "[INFO] Réparation terminée et garage remis en état.";
};
/*
if (_damages isEqualTo []) then {
	["Info", "Le véhicule ne semble pas endommagé.", "danger"] spawn ALF_fnc_doMsg;
} else {
	if (!(_allBackpack)) then {
		["GARAGE", "Vous n'avez pas toutes les pièces sur vous. Le véhicule ne sera pas réparé entièrement.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];
	};

	_garage setVariable[(_elevator select 0) + "_in_repair", true];
	_garage setVariable[(_elevator select 0) + "_repairTime", time];
	private _final_damages = [];
		
	{
			
		if ((_x select 1) != "") then {
			if ((_x select 1) in magazines _unit) then {
				_unit removeItem (_x select 1);
				_final_damages pushBack _x;
			};
		} else {
			_final_damages pushBack _x;
		};
	} forEach _damages;

	["GARAGE", "Vous avez lancé la réparation.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];

	uiSleep 300;

	if (
		((_garage getVariable[(_elevator select 0) + "_veh_charge", objNull]) == _veh) && 
		((_garage animationSourcePhase (_elevator select 1)) > 0.5) 
		) then {

		playSound3D ["ALF_Client2\sounds\bip.ogg", _garage, false, _garage modelToWorld (_garage selectionPosition [(_elevator select 0), "Memory"]), 2, 1, 20];
		{
			if(!(local _veh)) then {
				[_veh,(_x select 0),0] remoteExecCall ["ALF_fnc_setHPD",_veh];
			} else {
				_veh setHitPointDamage [(_x select 0),0];
			};
		} foreach _final_damages;
			
		if (_allBackpack) then {
			_veh setDamage 0;
			private _parts = getAllHitPointsDamage _veh;

			{
				_veh setHitPointDamage [format["%1",(_x select _forEachIndex)],0];
			} forEach (_parts select 0);
		};
	};

	_garage setVariable [(_elevator select 0) + "_in_repair", false];
};
*/

/*
    File: fn_startRepair.sqf
    Author: ALF TEAM
*/
/*
params [
    ["_elevator", [], [[]]],  // ["Pont_X_Axis", "Nom de l'animation"]
    ["_unit", objNull, [objNull]] // Joueur ou unité qui lance la réparation
];

private _garage = (nearestObjects [_unit, ["Land_ALF_AtelierMecanique"], 30]) select 0;
diag_log format ["[DEBUG] Garage détecté : %1", _garage];

if (isNull (_garage getVariable [(_elevator select 0) + "_veh_charge", objNull])) exitWith {
    diag_log "[ERREUR] Aucun véhicule sur l'ascenseur pour lancer la réparation.";
};

if (_garage getVariable [(_elevator select 0) + "_in_repair", false]) exitWith {
    private _time = time - (_garage getVariable [(_elevator select 0) + "_repairTime", 0]);
    _time = 60 - _time;//900
    diag_log format ["[INFO] Réparation déjà en cours. Temps restant : %1 secondes.", _time];
    ["GARAGE", format["Le véhicule est déjà en cours de réparation. Il reste %1 de réparation.", [_time] call BIS_fnc_secondsToString], "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if ((_garage animationSourcePhase (_elevator select 1)) < 0.5) exitWith {
    diag_log "[ERREUR] L'ascenseur est en position basse.";
};

private _veh = _garage getVariable [(_elevator select 0) + "_veh_charge", objNull];
if (isNull _veh) exitWith {
    diag_log "[ERREUR] Aucun véhicule détecté sur le pont élévateur.";
    ["GARAGE", "Il n'y a aucun véhicule sur le pont élévateur.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

diag_log format ["[INFO] Véhicule détecté pour réparation : %1", _veh];

if ((_garage getVariable [(_elevator select 0) + "_diag", 0]) != 2) exitWith {
    diag_log "[ERREUR] Le diagnostic n'a pas encore été validé.";
    ["GARAGE", "Vous devez d'abord lancer le diagnostic.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

if (!("ALF_KitMecatechnic" in magazines _unit)) exitWith {
    diag_log "[ERREUR] L'unité ne possède pas la caisse de réparation.";
    ["GARAGE", "Vous devez posséder une caisse de réparation.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
};

private _damages = [];
private _allBackpack = true;
diag_log "[DEBUG] Vérification des pièces endommagées...";
diag_log format ["Configuration de réparation_1 : %1", ALF_Repair];
{
    _part = configName _x;
    _config = configFile >> "ALF_Repair" >> _part;
    
    // **Affichage des infos des `HitPoints` détectés :**
    diag_log format ["Partie : %1 - Dégâts actuels : %2", _part, _veh getHitPointDamage _part];

    if (isClass(_config)) then {
        diag_log format ["Classe ALF_Repair trouvée pour %1 : %2", _part, true];
        if ((_veh getHitPointDamage _part) > 0) then {
            _item = getText(_config >> "item");
            if (!(_item isEqualTo "") && !(_item in magazines _unit)) then {
                _allBackpack = false;
            };
            _damages pushBack [_part, _item];
            diag_log format ["[INFO] Pièce endommagée ajoutée à la liste : %1 - Nécessite l'item : %2", _part, _item];
        };
    } else {
        diag_log format ["[ERREUR] Pas de classe ALF_Repair trouvée pour %1", _part];
    };
} foreach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf(_veh) >> "HitPoints"));
diag_log format ["Configuration de réparation_2 : %1", ALF_Repair];
if (_damages isEqualTo []) then {
    diag_log "[INFO] Le véhicule ne semble pas endommagé.";
    ["Info", "Le véhicule ne semble pas endommagé.", "danger"] spawn ALF_fnc_doMsg;
} else {
    diag_log "[INFO] Lancement de la réparation.";
    if (!(_allBackpack)) then {
        diag_log "[WARNING] Toutes les pièces ne sont pas présentes sur le joueur.";
        ["GARAGE", "Vous n'avez pas toutes les pièces sur vous. Le véhicule ne sera pas réparé entièrement.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];
    };

    _garage setVariable [(_elevator select 0) + "_in_repair", true];
    _garage setVariable [(_elevator select 0) + "_repairTime", time];
    private _final_damages = [];

    {
        if ((_x select 1) != "") then {
            if ((_x select 1) in magazines _unit) then {
                _unit removeItem (_x select 1);
                diag_log format ["[INFO] Pièce utilisée pour réparation : %1", _x select 1];
                _final_damages pushBack _x;
            };
        } else {
            _final_damages pushBack _x;
        };
    } forEach _damages;

    ["GARAGE", "Vous avez lancé la réparation.", "warning"] remoteExec ["ALF_fnc_doMsg", _unit];

    diag_log "[DEBUG] Réparation en cours... Temps d'attente 1200 secondes.";
    uiSleep 60;//12000

    if (
        ((_garage getVariable [(_elevator select 0) + "_veh_charge", objNull]) == _veh) &&
        ((_garage animationSourcePhase (_elevator select 1)) > 0.5)
    ) then {
        diag_log "[INFO] Réparation terminée avec succès.";
        playSound3D ["ALF_Client2\sounds\bip.ogg", _garage, false, _garage modelToWorld (_garage selectionPosition [(_elevator select 0), "Memory"]), 2, 1, 20];
        {
            if (!(local _veh)) then {
                [_veh, (_x select 0), 0] remoteExecCall ["ALF_fnc_setHPD", _veh];
            } else {
                _veh setHitPointDamage [(_x select 0), 0];
            };
        } foreach _final_damages;

        if (_allBackpack) then {
            _veh setDamage 0;
            private _parts = getAllHitPointsDamage _veh;

            {
                _veh setHitPointDamage [format ["%1", (_x select _forEachIndex)], 0];
            } forEach (_parts select 0);
        };
    } else {
        diag_log "[ERREUR] Véhicule déplacé ou ascenseur descendu pendant la réparation.";
    };

    _garage setVariable [(_elevator select 0) + "_in_repair", false];
    diag_log "[INFO] Réparation terminée et garage remis en état.";
};
*/