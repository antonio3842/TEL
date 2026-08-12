/*
    Client : ajout mobilier spécial GN (casier / coffre)
    Contrôle service GN + appel serveur
    PAS de code PIN pour l’instant
*/

//ALF_fnc_addMobilierCopclient = {

params ["_obj"];
if (isNull _obj) exitWith {};


// --- Vérification service GN ---
if !(life_gendarme_service) exitWith {
    ["ERREUR", "Vous devez être <t color='#00aaff'>en service Gendarmerie</t> pour utiliser ce mobilier.", "danger"] spawn ALF_fnc_doMsg;
};


// --- Si ok, envoi serveur ---
private _uid = getPlayerUID player;

[_uid, _obj] remoteExecCall ["ALF_Server_fnc_addMobilierCop", 2];

["INFO", "Mobilier GN enregistré.", "success"] spawn ALF_fnc_doMsg;

//};