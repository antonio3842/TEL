#include "\ALF_Client\script_macros.hpp"
/*
File: fn_permisCar.sqf
Author: ALF Team
Description:
Système pour passer son permis voiture.
*/

// alf_fnc_permisCar = 

if (license_driver) exitWith {["Moniteur d'auto-école", "Vous avez déjà le permis de conduire.", "danger", false] spawn ALF_fnc_doMsg;};
if (life_permis_action) exitWith {["Moniteur d'auto-école", "Vous passez déjà votre permis.", "danger", false] spawn ALF_fnc_doMsg;};
if (life_permis_time) exitWith {["Moniteur d'auto-école", "Vous ne pouvez passer votre permis que toutes les 24H.", "danger", false] spawn ALF_fnc_doMsg;};

private _desactiver = false;
{if (_x getVariable["ALF_Moniteur", false]) exitWith {_desactiver = true}} forEach playableUnits;

if (_desactiver) exitWith {["Auto-Ecole", "Il y à l'auto-école d'ouverte, rendez-vous là-bas !", "danger", false] spawn ALF_fnc_doMsg;};

_price = 1500;

_action = [format["Voulez-vous passer votre permis pour %1€. Attention, l'épreuve est éliminatoire à 5 erreurs.",_price],"Inscription au permis de conduire","OUI","NON"] call BIS_fnc_guiMessage;

if(_action) then 
{

    if(count((getMarkerPos "p_latrinite_start") nearEntities [["Car","Ship","Air"],6]) > 0) exitWith {["Moniteur d'auto-école", "Un véhicule gêne l'auto-école.", "danger", false] spawn ALF_fnc_doMsg;};
    if(life_cash < _price) exitWith {["Moniteur d'auto-école", "Vous n'avez pas assez d'argent sur vous.", "danger", false] spawn ALF_fnc_doMsg;};

    _startPos = getPosATL player;
    [3] spawn SOCK_fnc_updatePartial;

    life_permis_action = true;

    life_cash = life_cash - _price;
    [0] call SOCK_fnc_updatePartial;

    _vehicle = createVehicle ["V_ALF_308_auto_m", [0,0,2000], [], 0, "NONE"];
    _vehicle allowDamage false;
    _vehicle setPos (getMarkerPos "p_latrinite_start");
    _vehicle setVectorUp (surfaceNormal (getMarkerPos "p_latrinite_start"));
    _vehicle setDir (markerDir "p_latrinite_start");
    _vehicle lock 2;
    [_vehicle] call ALF_fnc_clearVehicleAmmo;
    _vehicle addMagazineCargoGlobal ["ALF_Roue",4];
    _vehicle setVariable ["vehicle_info_owners",["",getPlayerUID player],true];
    _vehicle disableTIEquipment true;

    _vehicle setObjectTextureGlobal [1, "\ALF_Vehicules\ALF_data\plaque\-.paa"];
    _vehicle setObjectTextureGlobal [2, "\ALF_Vehicules\ALF_data\plaque\E.paa"];
    _vehicle setObjectTextureGlobal [3, "\ALF_Vehicules\ALF_data\plaque\C.paa"];
    _vehicle setObjectTextureGlobal [4, "\ALF_Vehicules\ALF_data\plaque\O.paa"];
    _vehicle setObjectTextureGlobal [5, "\ALF_Vehicules\ALF_data\plaque\L.paa"];
    _vehicle setObjectTextureGlobal [6, "\ALF_Vehicules\ALF_data\plaque\E.paa"];
    _vehicle setObjectTextureGlobal [7, "\ALF_Vehicules\ALF_data\plaque\-.paa"];

    _vehicle allowDamage true;
    life_vehicles pushBack _vehicle;
    [getPlayerUID player,_vehicle,1] remoteExecCall ["ALF_Server_fnc_keyManagement",2];

    [player,_vehicle,_startPos] remoteExec ["ALF_Server_fnc_permisVerif",2];

    _permis = true;
    _exit = false;
    _exit_Temps = false;
    _erreur = 0;
    _myerreur = 0;
    _etape1 = false;
    _etape2 = false;
    _etape3 = false;
    _etape4 = false;
    _etape5 = false;
    _etape6 = false;
    _etape7 = false;
    _etape8 = false;
    _etape9 = false;
    _etape10 = false;
    _etape11 = false;
    _etape12 = false;
    _etape13 = false;
    _etape14 = false;
    _etape15 = false;
    _etape16 = false;
    _etape17 = false;
    _etape18 = false;
    _etape19 = false;
    _etape20 = false;
    _etape21 = false;
    _etape22 = false;
    _etape23 = false;
    _etape24 = false;
    _passageTime = time;

    ["Moniteur d'auto-école", "Le moniteur vous attend, vous pouvez monter dans la voiture.", "warning", false] spawn ALF_fnc_doMsg;

    for "_i" from 0 to 1 step 0 do {
        if (time - _passageTime > 300) exitWith {_exit_Temps = true;};
        if (typeOf (vehicle player) isKindOf "V_ALF_308_auto_m") exitWith {_etape1 = true;};
        if (player distance _vehicle > 100) exitWith {_exit = true;};
        sleep 1;
    };
    if (_exit) exitWith {hint "Vous avez raté votre permis, le moniteur est parti."};
    if (_exit_Temps) exitWith {hint "Le moniteur vous à attendus trop longtemps et est parti."};

    waitUntil {sleep 0.3; _etape1;};
    ["D", "5m", "Sortez du parking et tournez à droite"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez de faire une erreur."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_1") > 500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_1") < 10) exitWith {_etape2 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape2;};

    ["G", "20m", "Après le passage piéton tournez à gauche"] spawn ALF_fnc_doGps;
    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_2") > 500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_2") < 10) exitWith {_etape3 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape3;};

    ["D", "20m", "Au STOP tournez à droite"] spawn ALF_fnc_doGps;
    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_3") > 500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_3") < 10) exitWith {_etape4 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape4;};
    ["D", "20m", "A la prochaine intersection tournez à droite et continuez jusqu'au STOP"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_4") > 500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_4") < 10) exitWith {_etape5 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape5;};
    ["G", "10m", "Au STOP tournez à gauche"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_5") > 500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_5") < 10) exitWith {_etape6 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape6;};
    ["D", "20m", "A cette intersection tournez à droite"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_6") > 4000) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_6") < 20) exitWith {_etape7 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape7;};
    ["D", "20m", "A la prochaine intersection tournez à droite, direction le rond-point"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_7") > 3000) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_7") < 20) exitWith {_etape8 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape8;};
    ["RP", "20m", "Au rond-point, prenez la deuxième sortie"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_8") > 500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_8") < 10) exitWith {_etape9 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape9;};
    ["D", "10m", "Au cédez-le-passage, tournez à droite pour prendre la route nationale 1"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 110 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_9") > 500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_9") < 20) exitWith {_etape10 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape10;};
    ["TD", "1.2km", "Continuez tout droit"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 110 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_10") > 3000) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_10") < 20) exitWith {_etape11 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape11;};
    ["G", "200m", "Attention ralentissez, à la prochaine intersection tournez à gauche jusqu'au prochain rond-point"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 90 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_11") > 2300) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_11") < 20) exitWith {_etape12 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape12;};
    ["RP", "20m", "Au rond-point, prenez la quatrième sortie et prenez le pont"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 90 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_12") > 2000) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_12") < 20) exitWith {_etape13 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape13;};
    ["RP", "20m", "Au rond-point, prenez la troisième sortie vers la voie d'insertion de l'autoroute A1"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 130 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_13") > 1000) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_13") < 20) exitWith {_etape14 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape14;};
    ["TD", "1km", "Continuez sur l'autoroute jusqu'au prochain rond-point"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 90 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_14") > 2000) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_14") < 20) exitWith {_etape15 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape15;};
    ["RP", "100m", "Au rond-point, prenez la deuxième sortie"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 90 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_15") > 3000) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_15") < 20) exitWith {_etape16 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape16;};
    ["D", "20m", "Au STOP, tourner à droite sur la nationale 3"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 110 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_16") > 3000) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_16") < 40) exitWith {_etape17 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape17;};
    ["G", "60m", "A la prochaine intersection tournez à gauche."] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 90 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_17") > 3500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_17") < 20) exitWith {_etape18 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape18;};
    ["RP", "20m", "Au rond-point, prenez la deuxième sortie"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 90 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_18") > 3500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_18") < 10) exitWith {_etape19 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape19;};
    ["D", "20m", "Au STOP, tourner à droite"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_19") > 2500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_19") < 10) exitWith {_etape20 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape20;};
    ["G", "10m", "Au STOP, tourner à gauche"] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_20") > 2500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_20") < 20) exitWith {_etape21 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape21;};
    ["D", "10m", "Après le passage piéton, tournez à droite sur le parking de l'auto-école."] spawn ALF_fnc_doGps;

    _myerreur = _erreur;
    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        _speed = round speed (vehicle player);
        if (round _speed > 50 && _erreur isEqualTo _myerreur) then {_erreur = _erreur + 1; hint "Attention, vous allez trop vite, vous venez d'avoir une erreur en plus."; [] spawn {sleep 5; hint "";};};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_end") > 2500) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_end") < 20) exitWith {_etape23 = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape23;};
    ["D", "5m", "Garez-vous devant le parking de l'auto-école et arrêtez le véhicule."] spawn ALF_fnc_doGps;

    _passageTime = time;
    for "_i" from 0 to 1 step 0 do {
        if ( round speed (vehicle player) isEqualTo 0) exitWith {_etape24 = true;};
        if ((vehicle player) distance (getMarkerPos "p_latrinite_end") > 350) exitWith {_exit = true;};
        if (time - _passageTime > 300) exitWith {_exit = true;};
        sleep 0.5;
    };
    if (_exit) exitWith {life_permis_action = false; player allowDamage false; [] spawn {sleep 5; player allowDamage true;}; deleteVehicle _vehicle; player setPosATL _startPos; ["Moniteur d'auto-école", "Vous avez raté votre permis, vous êtes parti trop loin.", "warning", false] spawn ALF_fnc_doMsg;};
    waitUntil {sleep 0.3; _etape24;};

    deleteVehicle _vehicle;

    ["Moniteur d'auto-école",format["Votre nombre d'erreur(s) : %1",_erreur], "warning", false] spawn ALF_fnc_doMsg;
    sleep 2;
    if (_erreur < 6) then {
        ["Moniteur d'auto-école", "Vous avez votre permis, félicitations !", "success", false] spawn ALF_fnc_doMsg;
        if (!("ALF_Permis" in (magazines player)) && {player canAdd "ALF_Permis"}) then {
            ["ALF_Permis",true] spawn ALF_fnc_handleItem;
        };
        license_driver = true;
        [1] call SOCK_fnc_updatePartial;
        life_permis = 12;
        [14] call SOCK_fnc_updatePartial;
        life_permis_action = false;
    } else {
        ["Moniteur d'auto-école", "Vous avez fait trop d'erreurs, vous n'avez pas eu votre permis.", "danger", false] spawn ALF_fnc_doMsg;
        life_permis_action = false;
    };
};
// };