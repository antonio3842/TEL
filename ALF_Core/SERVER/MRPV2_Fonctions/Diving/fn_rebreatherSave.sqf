// SERVER
// Sauvegarde l'O2 restant dans la mémoire serveur (pas de persistance disque)
params ["_who","_rem"];
if (!isServer) exitWith {};

private _uid = if (_who isEqualType objNull) then { getPlayerUID _who } else { _who };
if (_uid isEqualTo "") exitWith {};

private _key = format ["MRP_REBR_R_%1", _uid];
private _val = (_rem max 0);

missionNamespace setVariable [_key, _val];

diag_log format ["[Rebreather][SAVE] uid=%1 rem=%2", _uid, _val];

// (NE PAS écrire dans profileNamespace, pour que le restart remette plein)
