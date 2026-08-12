/*
    File: fn_eboueur_terminerService.sqf
    Author: MRP
    Description: Termine le service éboueur
    
    OPTIMISATIONS BOHEMIA APPLIQUÉES:
    - Variables déclarées directement
    - isEqualTo au lieu de ==
*/

_exit = false;

if (!alive player) exitWith {};

if (!(player getVariable ["MRP_Eboueur_EnService", false])) exitWith {
    ["Éboueur", "Vous n'êtes pas en service!", "danger"] spawn ALF_fnc_doMsg;
};

private _camion = nearestObjects [player, ["VEH_Mercura_MRP_Volvo_Poubelle"], 100];

if (count _camion > 0) then {

_camion = _camion select 0;
private _nbOrdures = _camion getVariable ["MRP_Eboueur_NbOrdures", 0];

if (_nbOrdures > 0) exitWith {
    ["Éboueur", "Videz le camion avant de terminer!", "danger"] spawn ALF_fnc_doMsg;
	_exit = true;
};

// Vérifier ordures coffre
private _itemsCoffre = getMagazineCargo _camion;
private _orduresDansCoffre = 0;

if (count _itemsCoffre > 0) then {
    private _items = _itemsCoffre select 0;
    private _quantites = _itemsCoffre select 1;
    
    {
        if (_x isEqualTo "MRP_Ordure") then {
            _orduresDansCoffre = _orduresDansCoffre + (_quantites select _forEachIndex);
        };
    } forEach _items;
};

if (_orduresDansCoffre > 0) exitWith {
    ["Éboueur", format["Coffre contient %1 sacs! Videz-les.", _orduresDansCoffre], "danger"] spawn ALF_fnc_doMsg;
	_exit = true;
};




deleteVehicle _camion;

// Retirer du registre
{
    _x params ["_plaque", "_unit"];
    
    if (_unit isEqualTo player) exitWith {
        MRP_EBOUEUR_CARS deleteAt (MRP_EBOUEUR_CARS find _x);
        publicVariable "MRP_EBOUEUR_CARS";
    };
} forEach MRP_EBOUEUR_CARS;

};

if (_exit) exitWith {};

["Éboueur", "Service terminé. À bientôt!", "info"] spawn ALF_fnc_doMsg;


// Nettoyage variables
player setVariable ["MRP_Eboueur_EnService", nil, true];
player setVariable ["MRP_Eboueur_Camion", nil];
player setVariable ["MRP_Eboueur_NbColisRamasses", nil];

MRP_EboueurEnCours = false;
MRP_PoubelleAttachee = objNull;
MRP_Eboueur_EnService = false;