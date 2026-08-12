_exit = false;

if (!alive player) exitWith {};

if (!(player getVariable ["MRP_Ambulancier_EnService", false])) exitWith {
    ["Ambulancier", "Vous n'êtes pas en service!", "danger"] spawn ALF_fnc_doMsg;
};

private _camion = player getVariable ["MRP_Ambulancier_Camion", objNull];

if (!(isNull _camion) && player distance _camion > 20) exitWith {
    ["Ambulancier", "Camion trop loin!", "danger"] spawn ALF_fnc_doMsg;
};
if (MRP_AmbulancierEnCours) then {
    _exit = !(["Vois avez une mission en cours, êtes-vous sûr d'annuler ?", "Ambulancier", "OUI", "NON"] call BIS_fnc_guiMessage);
    
};

if (_exit) exitWith {};

if (!(isNull _camion)) then {


    deleteVehicle _camion;

    // Retirer du registre
    {
        _x params ["_plaque", "_unit"];
        
        if (_unit isEqualTo player) exitWith {
            MRP_AMBULANCIER_CARS deleteAt (MRP_AMBULANCIER_CARS find _x);
            publicVariable "MRP_AMBULANCIER_CARS";
        };
    } forEach MRP_AMBULANCIER_CARS;

};



["Ambulancier", "Service terminé. À bientôt!", "info"] spawn ALF_fnc_doMsg;


// Nettoyage variables
player setVariable ["MRP_Ambulancier_EnService", nil, true];
player setVariable ["MRP_Ambulancier_Camion", nil];

MRP_AmbulancierEnCours = false;
MRP_Ambulancier_EnService = false;