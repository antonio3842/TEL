params [
    ["_texte1", "", [""]],
    ["_texte2", "", [""]]
];

if (_texte1 isEqualTo "" || {_texte2 isEqualTo ""}) exitWith {
    diag_log "[WL NOTIF] ❌ Annulé : titre ou texte vide.";
};

diag_log format ["[WL NOTIF] ✅ Requête reçue : Titre='%1' | Texte='%2'", _texte1, _texte2];

// Log détaillé pour tous les joueurs GN (CopService=true)
{
    private _name = name _x;
    private _cop = _x getVariable ["CopService", false];
    private _sabre = _x getVariable ["license_cop", false];
    diag_log format ["[WL DEBUG] %1 | CopService: %2 | license_cop: %3", _name, _cop, _sabre];
} forEach playableUnits;

// Sélection des cibles
private _cibles = playableUnits select {
    (_x getVariable ["CopService", false]) &&
    (_x getVariable ["license_cop", false]) isEqualTo true
};

diag_log format ["[WL NOTIF] 🎯 Cibles trouvées : %1 joueur(s)", count _cibles];

if (_cibles isEqualTo []) exitWith {
    diag_log "[WL NOTIF] ⚠ Aucun joueur avec CopService && license_cop.";
};

[_texte1, _texte2] remoteExec ["ALF_fnc_doCopCall", _cibles];
diag_log "[WL NOTIF] 🚀 Notification envoyée aux license_cop.";
