
if (!(player getVariable ["MRP_Bie_EnService", false])) exitWith {
    ["Enedis", "Vous n'êtes pas en service!", "danger"] spawn ALF_fnc_doMsg;
};

_veh = player getVariable ["MRP_Bie_Camion", objNull];

if (isnull _veh) exitWith {
    ["Enedis", "Vous n'avez pas de véhicules affecté", "danger"] spawn ALF_fnc_doMsg;
};

if (_veh distance player > 100) exitWith {
    ["Enedis", "Votre véhicule n'est pas à proximité de vous", "danger"] spawn ALF_fnc_doMsg;
};
deleteVehicle _veh;

// Retirer du registre
{
    _x params ["_plaque", "_unit"];
    
    if (_unit isEqualTo player) exitWith {
        MRP_EBOUEUR_CARS deleteAt (MRP_EBOUEUR_CARS find _x);
        publicVariable "MRP_EBOUEUR_CARS";
    };
} forEach MRP_BIE_CARS;

player setVariable ["MRP_Bie_Camion", nil];
["Enedis", "Camion rangé", "success"] spawn ALF_fnc_doMsg;