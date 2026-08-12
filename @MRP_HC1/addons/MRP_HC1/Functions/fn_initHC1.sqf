/*
    File: fn_initHC1.sqf
    Author: ALF Team
    Desc: Initialisation du Headless Client 1
    Fonctions: cleanup, appleSystem, raisinSystem, spawnAlgues, sanctuaireTurtles, objetsCarteEnObjetSimple, objetsTxtEnObjetSimple
*/

// Ne s'execute que sur HC (pas serveur, pas client avec interface)
if (hasInterface) exitWith {};
if (isDedicated) exitWith {};

// Verifier que c'est bien hc_1
private _playerName = profileName;
if (_playerName != "hc_1") exitWith {
    diag_log format ["[MRP_HC1] Ce n'est pas hc_1 (nom: %1) - Skip init", _playerName];
};

// IMPORTANT: Wrapper dans spawn pour ne pas bloquer postInit
[] spawn {
    diag_log "[MRP_HC1] ========================================";
    diag_log "[MRP_HC1] Headless Client 1 detecte - Initialisation...";
    diag_log "[MRP_HC1] ========================================";

    // Attendre le nom de la BDD du serveur
    diag_log "[MRP_HC1] Attente du nom de la BDD du serveur...";
    waitUntil {sleep 0.5; !isNil "ALF_db_name"};
    diag_log format ["[MRP_HC1] Nom BDD recu: %1", ALF_db_name];

    // Initialisation extDB3 locale
    MRP_hc1_extDB_notLoaded = "";

    if (isNil {uiNamespace getVariable "life_sql_id"}) then {
        life_sql_id = round(random(9999));
        life_sql_id = compileFinal (if (life_sql_id isEqualType "") then {life_sql_id} else {str(life_sql_id)});
        uiNamespace setVariable ["life_sql_id", life_sql_id];

        try {
            private _result = "extDB3" callExtension format["9:ADD_DATABASE:%1", ALF_db_name];
            if !(_result isEqualTo "[1]") then {throw format["extDB3 HC_1: ADD_DATABASE failed: %1", _result]};
            _result = "extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%2:SQL:%1:TEXT2", call life_sql_id, ALF_db_name];
            if !(_result isEqualTo "[1]") then {throw format["extDB3 HC_1: ADD_PROTOCOL failed: %1", _result]};
        } catch {
            MRP_hc1_extDB_notLoaded = [true, _exception];
            diag_log format ["[MRP_HC1] extDB3 ERROR: %1", _exception];
        };

        publicVariable "MRP_hc1_extDB_notLoaded";
        if (MRP_hc1_extDB_notLoaded isEqualType []) exitWith {
            diag_log "[MRP_HC1] ERREUR CRITIQUE: extDB3 non charge - Arret init";
        };
        "extDB3" callExtension "9:LOCK";
        diag_log "[MRP_HC1] extDB3: Connected to Database";
    } else {
        life_sql_id = uiNamespace getVariable "life_sql_id";
        diag_log "[MRP_HC1] extDB3: Using existing connection";
    };

    if (MRP_hc1_extDB_notLoaded isEqualType []) exitWith {};

    // S'enregistrer aupres du serveur
    hc_1 = clientOwner;
    publicVariable "hc_1";

    // Compiler asyncCall local pour les requetes BDD
    ALF_Server_fnc_asyncCall = compile preprocessFileLineNumbers "\MRP_HC1\Functions\MySQL\fn_asyncCall.sqf";
    diag_log "[MRP_HC1] ALF_Server_fnc_asyncCall compile localement";

    // Delai avant lancement des fonctions
    sleep 3;

    diag_log "[MRP_HC1] Lancement des fonctions...";

    // === LANCEMENT DES FONCTIONS HC1 ===
    [] spawn MRP_HC1_fnc_cleanup;
    diag_log "[MRP_HC1] -> cleanup lance";

    [] spawn MRP_HC1_fnc_appleSystem;
    diag_log "[MRP_HC1] -> appleSystem lance";

    [] spawn MRP_HC1_fnc_raisinSystem;
    diag_log "[MRP_HC1] -> raisinSystem lance";

    [] spawn MRP_HC1_fnc_spawnAlgues;
    diag_log "[MRP_HC1] -> spawnAlgues lance";

    [] spawn MRP_HC1_fnc_sanctuaireTurtles;
    diag_log "[MRP_HC1] -> sanctuaireTurtles lance";

    [] spawn MRP_HC1_fnc_objetsCarteEnObjetSimple;
    diag_log "[MRP_HC1] -> objetsCarteEnObjetSimple lance";

    [] spawn MRP_HC1_fnc_objetsTxtEnObjetSimple;
    diag_log "[MRP_HC1] -> objetsTxtEnObjetSimple lance";

    disableRemoteSensors true;

    // Signaler au SERVEUR que HC1 est pret (publicVariable fait depuis le serveur pour JIP)
    [1] remoteExecCall ["ALF_Server_fnc_setHCReady", 2];

    diag_log "[MRP_HC1] ========================================";
    diag_log "[MRP_HC1] Toutes les fonctions HC1 lancees!";
    diag_log "[MRP_HC1] ========================================";
};
