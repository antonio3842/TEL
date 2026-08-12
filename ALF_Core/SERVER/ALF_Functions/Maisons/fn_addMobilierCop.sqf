/*
    Serveur : Ajout casier GN
    - CursorObject obligatoire
    - 1 casier max par joueur
    - Pas de doublon à la même position
    - id_house selon bâtiment
*/


//ALF_Server_fnc_addMobilierCop = {

params ["_uid", "_mobilier"];   // _mobilier = cursorObject envoyé par client

// === 1) Validation OBJET ===
if (isNull _mobilier) exitWith {
    ["ERREUR","Aucun objet détecté (cursorObject manquant).","danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
};

private _className = typeOf _mobilier;

// Casier obligatoire
if (_className != "Land_MRP_MEUBLE_COFFRE_casier") exitWith {
    ["ERREUR","Cet objet n'est pas un casier GN.","danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
};


// === 2) Position / rotation depuis l'objet ===
private _pos = getPosATL _mobilier;
private _posStr = str _pos;  // format SQL exact
private _dir = getDir _mobilier;


// === 3) Vérif : casier déjà existant à la même position ===
private _qPos = format [
    "SELECT id FROM mobiliers WHERE classname='Land_MRP_MEUBLE_COFFRE_casier' AND pos='%1'",
    _posStr
];
private _resPos = [_qPos,2] call ALF_Server_fnc_asyncCall;

if (count _resPos > 0) exitWith {
    ["ERREUR","Un casier existe déjà à cette position (anti-duplication).","danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
};


// === 4) Vérif : joueur a déjà un casier ===
private _qPID = format [
    "SELECT id FROM mobiliers WHERE pid='%1' AND classname='Land_MRP_MEUBLE_COFFRE_casier'",
    _uid
];
private _resPID = [_qPID,2] call ALF_Server_fnc_asyncCall;

if (count _resPID > 0) exitWith {
    ["ERREUR","Vous avez déjà un casier GN enregistré.","danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
};


// === 5) Détection bâtiment GN (id_house) ===
private _houseType = typeOf (_mobilier getVariable ["house", objNull]);

private _id_house = 0;

switch (_houseType) do {
    case "Land_mrp_gendarmerie_principale": { _id_house = 9001; };
    case "Land_mrp_gendarmerie_e":         { _id_house = 9002; };
    case "Land_MRP_gendarmerie2":         { _id_house = 9003; };
    case "Land_MRP_Caserne_GN":         { _id_house = 9004; };
    default                                { _id_house = 9000; }; // fallback
};


// === 6) INSERT SQL ===
private _sql = format [
    "INSERT INTO mobiliers (pid, classname, pos, gear, dir, code, id_house) 
     VALUES('%1','%2','%3','[]','%4','0000','%5')",
     _uid, _className, _posStr, _dir, _id_house
];

[_sql,1] call ALF_Server_fnc_asyncCall;


// === 7) Récup ID SQL ===
uiSleep 0.2;

private _q2 = format [
    "SELECT id FROM mobiliers WHERE pid='%1' AND pos='%2' AND classname='%3'",
    _uid, _posStr, _className
];
private _res2 = [_q2,2] call ALF_Server_fnc_asyncCall;

private _id = _res2 # 0;


// === 8) Variables ARMA sur l’objet ===
_mobilier setVariable ["mobilier_data", [_uid, _id, _className, objNull, "0000", true], true];
_mobilier setVariable ["gear", [], true];

diag_log format ["[CASIER GN] Casier ID %1 créé pour %2 à la pos %3", _id, _uid, _pos];


//};