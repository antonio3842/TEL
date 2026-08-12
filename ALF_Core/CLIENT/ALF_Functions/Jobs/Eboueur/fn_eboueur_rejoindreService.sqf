/*
    File: fn_eboueur_initMission.sqf
    Author: MRP
    Description: Prise de service éboueur
*/
if (!alive player) exitWith {};
if !(isNil {player getVariable "MRP_Eboueur_EnService"}) exitWith {
    ["Éboueur", "Déjà en service", "danger"] spawn ALF_fnc_doMsg;
};
if (!license_eboueur) exitWith {
    ["Éboueur", "Pas de licence éboueur. Allez à la préfecture.", "danger"] spawn ALF_fnc_doMsg;
};

private _collegue = objNull;
{
    if (isPlayer _x && {_x getVariable ["MRP_Eboueur_EnService", false]}) exitWith {
        _collegue = _x;
    };
} forEach (allPlayers select {_x distance player < 50});

_vehicle = _collegue getVariable ["MRP_Eboueur_Camion", objNull];
_EboueurZoneTourne = _collegue getVariable ["MRP_Eboueur_Zone", ""];
_enserv = _collegue getVariable ["MRP_Eboueur_EnService", false];
_uid = _collegue getVariable ["MRP_Eboueur_Collegue", false];

if (isNull _collegue) exitWith {
    ["Éboueur", "Pas de collègue en service trouvé.", "danger"] spawn ALF_fnc_doMsg;
};

if (_vehicle isEqualTo "") exitWith {
    ["Éboueur", "Le collègue n'a pas de camion assigné.", "danger"] spawn ALF_fnc_doMsg;
};


// Initialisation variables
MRP_EboueurEnCours = false;
MRP_PoubelleAttachee = objNull;
// Variables joueur
MRP_Eboueur_EnService = true;
player setVariable ["MRP_Eboueur_EnService", true, true];
player setVariable ["MRP_Eboueur_Camion", _vehicle, true];
player setVariable ["MRP_Eboueur_NbColisRamasses", 0, true];
player setVariable ["MRP_Eboueur_Collegue", _uid, true];
// Ajouter actions
[_vehicle] call ALF_fnc_eboueur_ajouterActions;

player setVariable ["MRP_Eboueur_Zone", _EboueurZoneTourne, true];

private _msg = format ["Service démarré! Collectez les poubelles avec %1", name _collegue];
["Éboueur", _msg, "success"] spawn ALF_fnc_doMsg;