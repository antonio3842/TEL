/*
    Fichier : fn_busjob_validerArret.sqf
    Auteur  : MRP
    Desc    : Valide le passage à l'arrêt actuel, paie le joueur et passe au suivant
*/

if (!MRP_BusJob_EnService) exitWith {
    ["Bus", "Vous n'êtes pas en service.", "danger"] spawn ALF_fnc_doMsg;
};

if (!((driver (vehicle player)) isEqualTo player)) exitWith {
    ["Bus", "Vous devez être le conducteur du bus.", "danger"] spawn ALF_fnc_doMsg;
};

private _idx = MRP_BusJob_ArretActuel;

if (_idx >= count MRP_BusJob_Arrets) exitWith {
    ["Bus", "Aucun arret en cours. Reprenez une ligne au depot si besoin.", "info"] spawn ALF_fnc_doMsg;
};

private _arretData = MRP_BusJob_Arrets select _idx;
private _pos       = _arretData select 0;
private _num       = if (isNil "MRP_BusJob_ArretAffiche") then { _idx + 1 } else { MRP_BusJob_ArretAffiche };

// Vérification distance
private _maxDist = (missionNamespace getVariable ["MRP_BusJob_ArretDist", 25]) + (missionNamespace getVariable ["MRP_BusJob_ArretDistTol", 3]);
if (player distance _pos > _maxDist) exitWith {
    ["Bus", format ["Vous êtes trop loin de l'arrêt %1. Approchez à moins de %2m.", _num, round _maxDist], "warning"] spawn ALF_fnc_doMsg;
};

// Récupérer le salaire de la ligne active
private _ligneConfig = MRP_BusJob_Config select (MRP_BusJob_Config findIf { (_x select 0) isEqualTo MRP_BusJob_LigneActive });
private _salaire = if (_ligneConfig isEqualTo []) then { 1440 } else { _ligneConfig select 2 };
private _bonus   = if (_ligneConfig isEqualTo []) then { 500 } else { _ligneConfig select 3 };
private _nomLigne = if (_ligneConfig isEqualTo []) then { "" } else { _ligneConfig select 1 };

// ── Payer le joueur ────────────────────────────────────────────────────────
[_salaire] call ALF_fnc_busjob_payerJoueur;

if (isNil "MRP_BusJob_ArretsSession") then { MRP_BusJob_ArretsSession = 0; };
MRP_BusJob_ArretsSession = MRP_BusJob_ArretsSession + 1;

// ── Avancer au prochain arrêt ──────────────────────────────────────────────
MRP_BusJob_ArretActuel = _idx + 1;

private _nbArrets = count MRP_BusJob_Arrets;

// ── Terminus : repartir en sens inverse (boucle illimitée) ─────────────────
if (MRP_BusJob_ArretActuel >= _nbArrets) then {
    reverse MRP_BusJob_Arrets;
    MRP_BusJob_ArretActuel = if (_nbArrets > 1) then { 1 } else { 0 };
    MRP_BusJob_ArretAffiche = 1;

    [_bonus] call ALF_fnc_busjob_payerJoueur;

    private _prochain = MRP_BusJob_ArretAffiche;

    [] spawn ALF_fnc_busjob_gpsUpdate;

    ["Bus", format [
        "Terminus — sens inverse. Bonus +%1 EUR — Prochain arret %2/%3 (+%4 EUR)",
        _bonus, _prochain, MRP_BusJob_ArretTotal, _salaire
    ], "success"] spawn ALF_fnc_doMsg;

    diag_log format ["[MRP_BUSJOB] Terminus %1 — sens inverse pour %2", MRP_BusJob_LigneActive, name player];

} else {
    MRP_BusJob_ArretAffiche = MRP_BusJob_ArretAffiche + 1;
    private _prochain = MRP_BusJob_ArretAffiche;

    [] spawn ALF_fnc_busjob_gpsUpdate;

    ["Bus", format [
        "Arret %1 valide +%2 EUR — Prochain arret %3/%4 (+%2 EUR)",
        _num, _salaire, _prochain, MRP_BusJob_ArretTotal
    ], "success"] spawn ALF_fnc_doMsg;
};
