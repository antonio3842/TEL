/* Copyright 2023 - Association Get Your Path. All rights reserved */
if ((lbCurSel 4515) isEqualTo -1) exitWith {["Erreur","Vous devez sélectionner un document pour continuer !","warning"] spawn ALF_fnc_doMsg;};

private _data = lbData [4515,(lbCurSel 4515)];
if (_data isEqualTo "NULL") exitWith {["Erreur","Vous devez sélectionner un document pour continuer !","warning"] spawn ALF_fnc_doMsg;};
_data = call compile format ["%1",_data];

private _copy = _data select 8;
private _isExpired = ((_data select 11) == 1);
if ((_copy isEqualTo 0) && !_isExpired) exitWith {["Erreur","Vous ne pouvez pas supprimer un document original en cours de validité !","warning"] spawn ALF_fnc_doMsg;};

private _id = _data select 0;

private _action = [
    format ["Êtes vous sûr de vouloir supprimer le document numéro #%1 ?",_id],
    "Supprimer le document",
    "Oui",
    "Non"
] call BIS_fnc_guiMessage;

if !(_action) exitWith {};

private _from_uid = _data select 1;
private _to_uid = _data select 2;
private _side = _data select 7;

[_id,_from_uid,_to_uid,_side,_copy] remoteExec ["ALF_Server_fnc_deleteDocument",2];
["Suppression","Le document a bien été supprimé.","success"] spawn ALF_fnc_doMsg;

closeDialog 0;
