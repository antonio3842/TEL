// MRPV2_Server_fnc_Vehicule_Configurations = {

private _veh         = param [0, objNull];
private _uid         = param [1, ""];
private _plaque      = param [2, ""];
private _magasin     = param [3, ""];
private _info_Pos_BDD= param [4, ""];

if (isNull _veh) exitWith {};

private _type_Garage  = "";
private _info_Proprio = [];

// --- Détermination du type de garage + proprio
[] call {
    if (_magasin in ["Civil Garage","MaisonContemporaine","MaisonMitoyenne","LandHouse","Civil Achat","Fourrière"]) exitWith {
        _type_Garage = "vehicles";
        private _joueur = (allPlayers select { getPlayerUID _x isEqualTo _uid }) param [0, objNull];
        if (!isNull _joueur) then { _info_Proprio = [name _joueur, _uid]; };

        if (_magasin isEqualTo "Fourrière") then {
            [format["UPDATE vehicles SET lockveh='0' WHERE plate='%1'", _plaque], 1] spawn ALF_Server_fnc_asyncCall;
        };
    };

    if ("SP " in _magasin) exitWith {
        _type_Garage   = "vehicles_med";
        _info_Proprio  = ["Pompiers",""];
        private _vehicules = missionNamespace getVariable ["VehiculeSP", []];
        _vehicules pushBack _veh;                         // <-- FIX: _veh (pas _vehicle)
        missionNamespace setVariable ["VehiculeSP", _vehicules, true];
    };

    if ("GN " in _magasin) exitWith {
        _type_Garage   = "vehicles_cop";
        _info_Proprio  = ["Gendarmerie",""];
        private _vehicules = missionNamespace getVariable ["VehiculeGN", []];
        _vehicules pushBack _veh;
        missionNamespace setVariable ["VehiculeGN", _vehicules, true];

        private _liste_Veh_GN = [
            "V_ALF_Megane_G_Gendarmerie","V_ALF_Berlingo_Gendarmerie","V_ALF_Subaru_Gendarmerie","V_ALF_GIGN",
            "V_ALF_DV15_Gendarmerie","V_ALF_Vito_Gendarmerie","Berlingo2019G","V_ALF_Titan_Gendarmerie"
        ];
        if ((typeOf _veh) in _liste_Veh_GN) then {
            _veh setVariable ["TF_RadioType", "alf_megaphone", true];
            { _veh setHit [_x, 1]; } forEach [
                "lightg01_h","lightg02_h","lightg03_h","lightg04_h",
                "lightg05_h","lightg06_h","lightg07_h","lightg08_h"
            ];
        };
    };

    if ("AP " in _magasin) exitWith {
        _type_Garage   = "vehicles_penit";
        _info_Proprio  = ["policemunicipale",""];
        private _vehicules = missionNamespace getVariable ["VehiculePM", []];
        _vehicules pushBack _veh;                         // <-- FIX: _veh (pas _vehicle)
        missionNamespace setVariable ["VehiculePM", _vehicules, true];
    };

};

if (_info_Proprio isEqualTo []) exitWith {};

// --- Position & active=1
[format["UPDATE %1 SET position='%2', active=1 WHERE plate='%3'", _type_Garage, _info_Pos_BDD, _plaque], 1] call ALF_Server_fnc_asyncCall;

// --- Lecture BDD : SELECT différent selon la table
private _requete = if (_type_Garage isEqualTo "vehicles")
    then { format["SELECT gear, fuel, damage, insure FROM %1 WHERE plate='%2'", _type_Garage, _plaque] }
    else { format["SELECT gear, fuel, damage FROM %1 WHERE plate='%2'", _type_Garage, _plaque] };

private _reponse = [_requete, 2] call ALF_Server_fnc_asyncCall;

// --- Inventaire
private _inventaire = _reponse param [0, []];
[_veh, _inventaire] call MRPV2_Server_fnc_Vehicule_Inventaire_Chargement;

// --- Carburant
private _fuel = _reponse param [1, 1];
[_veh, _fuel] remoteExecCall ["setFuel", _veh];

// --- Dégâts (index 2 dans les deux SELECT) : appliquer côté propriétaire (localité client)
private _damageList = [_reponse param [2, "[]"]] call ALF_Server_fnc_mresToArray;
if (_damageList isEqualType "") then { _damageList = call compile format["%1", _damageList]; };
if (!isNil "_damageList" && { count _damageList > 0 }) then {
    // application bornée côté client (fonction client nécessaire)
    [_veh, _damageList] remoteExecCall ["MRPV2_fnc_Vehicule_ApplyVehicleDamage", _veh];

    // optionnel: double passe en différé (anti "réparation" par d'autres scripts)
    [_veh, _damageList] remoteExec ["MRPV2_fnc_Vehicule_ApplyVehicleDamage_Delayed", _veh];
};

// --- Assurance (uniquement pour 'vehicles' qui retourne 4 colonnes)
private _assurance = if (_type_Garage isEqualTo "vehicles") then { _reponse param [3, 0] } else { 0 };
if (_assurance > 0) then {
    _veh animateSource ["assu", 0, true];
} else {
    _veh animateSource ["assu", 1, true];
};

// --- Radio hélico (FIX: utiliser _veh)
if (_veh isKindOf "Air") then {
    _veh setVariable ["TF_RadioType", "alf_radioheli", true];
    private _freq = random [1000, 5000, 9999];
    _veh setVariable ["helicofreq", _freq, true];
};

// --- Peinture
private _requetePeinture = format ["SELECT peinture FROM %1 WHERE plate='%2'", _type_Garage, _plaque];
private _peinture = flatten ([_requetePeinture, 2] call ALF_Server_fnc_asyncCall);
// Logs plus propres :
diag_log format ["[MRPV2_Config] plate=%1 | peintureRaw=%2", _plaque, _peinture];

if (_peinture isNotEqualTo []) then {
    private _textureIndex = if ("_mrp_" in toLower (typeOf _veh)) then { 11 } else { 0 };

    private _texture  = _peinture param [0, ""];
    private _material = _peinture param [1, ""];

    if (!isNil "_texture"  && { _texture  != "" }) then { _veh setObjectTextureGlobal  [_textureIndex, _texture];  };
    if (!isNil "_material" && { _material != "" }) then { _veh setObjectMaterialGlobal [_textureIndex, _material]; };

    if (((getObjectTextures _veh)  param [_textureIndex, ""]) isEqualTo "") then { _veh setObjectTextureGlobal  [_textureIndex, "#reset"]; };
    if (((getObjectMaterials _veh) param [_textureIndex, ""]) isEqualTo "") then { _veh setObjectMaterialGlobal [_textureIndex, "#reset"]; };
};

// --- Plaque & lock
[_veh, _plaque] remoteExec ["setPlateNumber", owner _veh];

private _plSplit = _plaque splitString "";
_veh setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plSplit param [0,""]]];
_veh setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plSplit param [1,""]]];
_veh setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plSplit param [3,""]]];
_veh setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plSplit param [4,""]]];
_veh setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plSplit param [5,""]]];
_veh setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plSplit param [7,""]]];
_veh setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa", _plSplit param [8,""]]];

[_veh, 2] remoteExec ['lock', _veh];

_veh setVariable ["vehicle_info_owners", _info_Proprio, true];
_veh setVariable ["dbInfo", [_uid, _plaque, 1, 0, 0]];
_veh setVariable ["Flashed", false];
_veh disableTIEquipment true;

// };
