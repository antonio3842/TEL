// SERVER
// Demande client: renvoie l'O2 restant persistant, sinon plein (après restart)
params ["_unit"];
if (!isServer) exitWith {};

if (isNull _unit) exitWith {};
private _uid = getPlayerUID _unit;
if (_uid isEqualTo "") exitWith {};

private _key = format ["MRP_REBR_R_%1", _uid];

// fallback plein si aucune valeur en mémoire (serveur fraîchement redémarré)
private _maxSeconds = missionNamespace getVariable ["MRP_rebreather_maxSeconds", 1200];
private _remaining  = missionNamespace getVariable [_key, -1];
if (_remaining < 0) then { _remaining = _maxSeconds; };

diag_log format ["[Rebreather][REQ] uid=%1 rem=%2", _uid, _remaining];

// Envoi au client
[_remaining] remoteExecCall ["MRPV2_fnc_rebreatherSetRemaining", _unit];
