/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
if(isServer) exitWith {};
if(!hasInterface) exitWith {};

private _vm = getText(configFile >> "CfgPatches" >> "ALF_Client" >> "addonsversion");
if(isNil "_vm") exitWith {failMission "Addons"};
if !(_vm isEqualTo "18.00") exitWith {failMission "Addons"};


// [] call ALF_fnc_initSpy;
// [] call ALF_fnc_antiHackALF;

// [] call ALF_fnc_initClient;

// [] spawn {
//     waitUntil { !isNull player };
//     sleep 1;
//     setCurrentChannel 5;

//     player addEventHandler ["Respawn", {setCurrentChannel 5;}];
// };


[] spawn { // jeux de lumiere entreprise
    waitUntil { time > 0 };

    waitUntil {
        !(isNil "obj_multi_1") && {!(isNull obj_multi_1)} &&
        !(isNil "obj_multi_2") && {!(isNull obj_multi_2)} &&
        !(isNil "obj_multi_3") && {!(isNull obj_multi_3)} &&
        !(isNil "obj_multi_4") && {!(isNull obj_multi_4)}
    };

    private _hiddenObjects = [obj_multi_1, obj_multi_2, obj_multi_3, obj_multi_4];

    {
        _x hideObject true;
    } forEach _hiddenObjects;
};

// Normalement desactiver apr mod donc obsolete ici et ne focntionnais pas
// [] spawn {
//     waitUntil {!isNull findDisplay 46};

//     (findDisplay 46) displayAddEventHandler ["KeyDown", {
//         params ["_d", "_key", "_shift", "_ctrl", "_alt"];

//         // EMR interact (même touche que dans CBA !)
//         if (_key == 88 && _ctrl && _alt) exitWith {

//             // On empêche Arma d'utiliser l’action
//             // => aucune porte / aucun véhicule NE SERA impacté
//             [] call emr_main_fnc_action;
//             true;    // <--- LE PLUS IMPORTANT (bloque l'event Arma)
//         };

//         false;
//     }];
// };

[] spawn 
{    
    [player,TRUE] remoteExecCall ["hideObjectGlobal",2];
    0 fadeSound 0;

    disableSerialization;
    0 cutRsc ["init_progress","BLACK FADED"];
    0 cutFadeOut 9999999;

    private _ui = uiNamespace getVariable "init_progress";
    private _titleText = _ui displayCtrl 38302;

    _titleText ctrlSetText "Récupération des données du serveur...";

    // Attente simple du serveur prêt
    waitUntil {!isNull player AND {missionNamespace getVariable ["ALF_serverReady", false]}};

    //[] call ALF_fnc_initSpy;
    //[] call ALF_fnc_antiHackALF;

    //[] call ALF_fnc_startCompleteLogger;

    [] call ALF_fnc_initClient;


    sleep 1;
    setCurrentChannel 5;

    player addEventHandler ["Respawn", {setCurrentChannel 5;}];
};