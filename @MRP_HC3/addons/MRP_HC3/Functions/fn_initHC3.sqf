/*
    File: fn_initHC3.sqf
    Author: ALF Team
    Desc: Initialisation du Headless Client 3
    Fonctions: randomEvent (Bourse), countDownForfait, countDownBracelet, countDownPrison, initReboot, vehicleAutoSync
*/

// Ne s'execute que sur HC (pas serveur, pas client avec interface)
if (hasInterface) exitWith {};
if (isDedicated) exitWith {};

// Verifier que c'est bien hc_3
private _playerName = profileName;
if (_playerName != "hc_3") exitWith {
    diag_log format ["[MRP_HC3] Ce n'est pas hc_3 (nom: %1) - Skip init", _playerName];
};

// IMPORTANT: Wrapper dans spawn pour ne pas bloquer postInit
[] spawn {
    diag_log "[MRP_HC3] ========================================";
    diag_log "[MRP_HC3] Headless Client 3 detecte - Initialisation...";
    diag_log "[MRP_HC3] ========================================";

    // Attendre le nom de la BDD du serveur
    diag_log "[MRP_HC3] Attente du nom de la BDD du serveur...";
    waitUntil {sleep 0.5; !isNil "ALF_db_name"};
    diag_log format ["[MRP_HC3] Nom BDD recu: %1", ALF_db_name];

    // Initialisation extDB3 locale
    MRP_hc3_extDB_notLoaded = "";

    if (isNil {uiNamespace getVariable "life_sql_id"}) then {
        life_sql_id = round(random(9999));
        life_sql_id = compileFinal (if (life_sql_id isEqualType "") then {life_sql_id} else {str(life_sql_id)});
        uiNamespace setVariable ["life_sql_id", life_sql_id];

        try {
            private _result = "extDB3" callExtension format["9:ADD_DATABASE:%1", ALF_db_name];
            if !(_result isEqualTo "[1]") then {throw format["extDB3 HC_3: ADD_DATABASE failed: %1", _result]};
            _result = "extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%2:SQL:%1:TEXT2", call life_sql_id, ALF_db_name];
            if !(_result isEqualTo "[1]") then {throw format["extDB3 HC_3: ADD_PROTOCOL failed: %1", _result]};
        } catch {
            MRP_hc3_extDB_notLoaded = [true, _exception];
            diag_log format ["[MRP_HC3] extDB3 ERROR: %1", _exception];
        };

        publicVariable "MRP_hc3_extDB_notLoaded";
        if (MRP_hc3_extDB_notLoaded isEqualType []) exitWith {
            diag_log "[MRP_HC3] ERREUR CRITIQUE: extDB3 non charge - Arret init";
        };
        "extDB3" callExtension "9:LOCK";
        diag_log "[MRP_HC3] extDB3: Connected to Database";
    } else {
        life_sql_id = uiNamespace getVariable "life_sql_id";
        diag_log "[MRP_HC3] extDB3: Using existing connection";
    };

    if (MRP_hc3_extDB_notLoaded isEqualType []) exitWith {};

    // S'enregistrer aupres du serveur
    hc_3 = clientOwner;
    publicVariable "hc_3";

    // Compiler asyncCall local pour les requetes BDD
    ALF_Server_fnc_asyncCall = compile preprocessFileLineNumbers "\MRP_HC3\Functions\MySQL\fn_asyncCall.sqf";
    diag_log "[MRP_HC3] ALF_Server_fnc_asyncCall compile localement";

    // Compiler les fonctions DAB
    ALF_Server_fnc_initDAB = compile preprocessFileLineNumbers "\MRP_HC3\Functions\DAB\fn_initDAB.sqf";
    ALF_Server_fnc_updateDABDispo = compile preprocessFileLineNumbers "\MRP_HC3\Functions\DAB\fn_updateDABDispo.sqf";
    ALF_Server_fnc_checkDABDispo = compile preprocessFileLineNumbers "\MRP_HC3\Functions\DAB\fn_checkDABDispo.sqf";
    ALF_Server_fnc_retraitDAB = compile preprocessFileLineNumbers "\MRP_HC3\Functions\DAB\fn_retraitDAB.sqf";
    ALF_Server_fnc_bag_vehicle = compile preprocessFileLineNumbers "\MRP_HC3\Functions\DAB\fn_bag_vehicle.sqf";
    diag_log "[MRP_HC3] Fonctions DAB compilees";

    // Delai avant lancement des fonctions
    sleep 3;

    diag_log "[MRP_HC3] Lancement des fonctions...";

    // === LANCEMENT DES FONCTIONS HC3 ===
    [] spawn MRP_HC3_fnc_countDownForfait;
    diag_log "[MRP_HC3] -> countDownForfait lance";

    [] spawn MRP_HC3_fnc_countDownBracelet;
    diag_log "[MRP_HC3] -> countDownBracelet lance";

    [] spawn MRP_HC3_fnc_countDownPrison;
    diag_log "[MRP_HC3] -> countDownPrison lance";

    [] spawn MRP_HC3_fnc_initReboot;
    diag_log "[MRP_HC3] -> initReboot lance";

    // === FONCTIONS DAB ===
    [] call ALF_Server_fnc_initDAB;
    diag_log "[MRP_HC3] -> initDAB lance";

    disableRemoteSensors true;

    // Signaler au SERVEUR que HC3 est pret (publicVariable fait depuis le serveur pour JIP)
    [3] remoteExecCall ["ALF_Server_fnc_setHCReady", 2];

    diag_log "[MRP_HC3] ========================================";
    diag_log "[MRP_HC3] Toutes les fonctions HC3 lancees!";
    diag_log "[MRP_HC3] ========================================";
};
