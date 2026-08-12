/*
    File: fn_initHC2.sqf
    Author: ALF Team
    Desc: Initialisation du Headless Client 2
    Fonctions: feuForet, startEventFire, startEventOrgane, wreckEventStart, countService
*/

// Ne s'execute que sur HC (pas serveur, pas client avec interface)
if (hasInterface) exitWith {};
if (isDedicated) exitWith {};

// Verifier que c'est bien hc_2
private _playerName = profileName;
if (_playerName != "hc_2") exitWith {
    diag_log format ["[MRP_HC2] Ce n'est pas hc_2 (nom: %1) - Skip init", _playerName];
};

// IMPORTANT: Wrapper dans spawn pour ne pas bloquer postInit
[] spawn {
    diag_log "[MRP_HC2] ========================================";
    diag_log "[MRP_HC2] Headless Client 2 detecte - Initialisation...";
    diag_log "[MRP_HC2] ========================================";

    // Attendre le nom de la BDD du serveur
    diag_log "[MRP_HC2] Attente du nom de la BDD du serveur...";
    waitUntil {sleep 0.5; !isNil "ALF_db_name"};
    diag_log format ["[MRP_HC2] Nom BDD recu: %1", ALF_db_name];

    // Initialisation extDB3 locale
    MRP_hc2_extDB_notLoaded = "";

    if (isNil {uiNamespace getVariable "life_sql_id"}) then {
        life_sql_id = round(random(9999));
        life_sql_id = compileFinal (if (life_sql_id isEqualType "") then {life_sql_id} else {str(life_sql_id)});
        uiNamespace setVariable ["life_sql_id", life_sql_id];

        try {
            private _result = "extDB3" callExtension format["9:ADD_DATABASE:%1", ALF_db_name];
            if !(_result isEqualTo "[1]") then {throw format["extDB3 HC_2: ADD_DATABASE failed: %1", _result]};
            _result = "extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%2:SQL:%1:TEXT2", call life_sql_id, ALF_db_name];
            if !(_result isEqualTo "[1]") then {throw format["extDB3 HC_2: ADD_PROTOCOL failed: %1", _result]};
        } catch {
            MRP_hc2_extDB_notLoaded = [true, _exception];
            diag_log format ["[MRP_HC2] extDB3 ERROR: %1", _exception];
        };

        publicVariable "MRP_hc2_extDB_notLoaded";
        if (MRP_hc2_extDB_notLoaded isEqualType []) exitWith {
            diag_log "[MRP_HC2] ERREUR CRITIQUE: extDB3 non charge - Arret init";
        };
        "extDB3" callExtension "9:LOCK";
        diag_log "[MRP_HC2] extDB3: Connected to Database";
    } else {
        life_sql_id = uiNamespace getVariable "life_sql_id";
        diag_log "[MRP_HC2] extDB3: Using existing connection";
    };

    if (MRP_hc2_extDB_notLoaded isEqualType []) exitWith {};

    // S'enregistrer aupres du serveur
    hc_2 = clientOwner;
    publicVariable "hc_2";

    // Compiler asyncCall local pour les requetes BDD
    ALF_Server_fnc_asyncCall = compile preprocessFileLineNumbers "\MRP_HC2\Functions\MySQL\fn_asyncCall.sqf";
    diag_log "[MRP_HC2] ALF_Server_fnc_asyncCall compile localement";

    // Delai avant lancement des fonctions
    sleep 3;

    diag_log "[MRP_HC2] Lancement des fonctions...";

    // === LANCEMENT DES FONCTIONS HC2 ===
    /*[] spawn MRP_HC2_fnc_feuForet;
    diag_log "[MRP_HC2] -> feuForet lance";

    [] spawn MRP_HC2_fnc_startEventFire;
    diag_log "[MRP_HC2] -> startEventFire lance";

    [] spawn MRP_HC2_fnc_startEventOrgane;
    diag_log "[MRP_HC2] -> startEventOrgane lance";*/

    [] spawn MRP_HC2_fnc_wreckEventStart;
    diag_log "[MRP_HC2] -> wreckEventStart lance";

    [] spawn MRP_HC2_fnc_countService;
    diag_log "[MRP_HC2] -> countService lance";

    disableRemoteSensors true;

    // Signaler au SERVEUR que HC2 est pret (publicVariable fait depuis le serveur pour JIP)
    [2] remoteExecCall ["ALF_Server_fnc_setHCReady", 2];

        diag_log "[MRP_HC2] ========================================";
    diag_log "[MRP_HC2] Toutes les fonctions HC2 lancees!";
    diag_log "[MRP_HC2] ========================================";
};
