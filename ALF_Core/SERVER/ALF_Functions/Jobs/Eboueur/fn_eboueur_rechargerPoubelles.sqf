/*
    File: fn_eboueur_rechargerPoubelles.sqf
    Author: MRP / Corrigé ALF
    Description: SERVEUR - Recharge poubelles
    
    CORRECTIONS:
    - Fix vérification isServer
    - Ajout logs debug
*/

if (!isServer) exitWith {
    diag_log "EBOUEUR_RECHARGE: ERREUR - Pas sur le serveur!";
};

private _pairs = [
    [MRP_EBOUEUR_POUBELLESMR, "MR"],
    [MRP_EBOUEUR_POUBELLESAN, "AN"],
    [MRP_EBOUEUR_POUBELLESFD, "FD"],
    [MRP_EBOUEUR_POUBELLESST, "ST"],
    [MRP_EBOUEUR_POUBELLESMA, "MA"],
    [MRP_EBOUEUR_POUBELLESLO, "LO"],
    [MRP_EBOUEUR_POUBELLESTR, "TR"],
    [MRP_EBOUEUR_POUBELLESFR, "FR"],
    [MRP_EBOUEUR_POUBELLESVA, "VA"],
    [MRP_EBOUEUR_POUBELLESAU, "AU"]
];
{
    _x params ["_listePoubelles", "_prefix"];

    {
        if (!isNull _x) then {
            
            private _nbOrdures = 1 + floor random 5;
            _x setVariable ["MRP_Eboueur_NbOrdures", _nbOrdures, true];

            clearItemCargoGlobal _x;
            clearMagazineCargoGlobal _x;

            for "_i" from 1 to _nbOrdures do {
                _x addItemCargoGlobal ["MRP_Ordure", 1];
            };
        };
    } forEach _listePoubelles;

} forEach _pairs;

// Notifier les joueurs en service
{
    if (_x getVariable ["MRP_Eboueur_EnService", false]) then {
        ["Éboueur", "Poubelles rechargées!", "info"] remoteExec ["ALF_fnc_doMsg", _x];
    };
} forEach allPlayers;