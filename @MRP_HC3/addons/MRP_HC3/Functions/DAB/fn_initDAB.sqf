/*
    File: fn_initDAB.sqf
    Author: ALF Dev Team
    Executed on: HC3
    Description: Charge les ATMs depuis la BDD et initialise le HashMap
*/

// Charger depuis BDD
private _query = "SELECT pos_x, pos_y, cash_available FROM atm_dispo";
private _result = [_query, 2, true] call ALF_Server_fnc_asyncCall;

ALF_DAB_Dispo = createHashMap;

if (!isNil "_result" && {count _result > 0}) then {
    // ATMs existants en BDD
    {
        private _posKey = format ["%1_%2", _x select 0, _x select 1];
        private _cash = _x select 2;
        ALF_DAB_Dispo set [_posKey, _cash];
        diag_log format ["[HC3-DAB] Charge: %1 = %2", _posKey, _cash];
    } forEach _result;

    diag_log format ["[HC3-DAB] %1 ATMs charges depuis BDD", count _result];
} else {
    // Premiere init - scanner les ATMs et les ajouter en BDD
    private _atms = nearestObjects [[5322.37,5883.17,0], ["Land_ALF_ATM"], 20000];

    diag_log format ["[HC3-DAB] Premiere init - %1 ATMs trouves", count _atms];

    {
        if !(isNull _x) then {
            private _pos = getPos _x;
            private _posX = round (_pos # 0);
            private _posY = round (_pos # 1);
            private _cash = if ((floor random 10) < 2) then {20000} else {200000};
            private _posKey = format ["%1_%2", _posX, _posY];

            ALF_DAB_Dispo set [_posKey, _cash];

            // INSERT en BDD
            private _insertQuery = format [
                "INSERT INTO atm_dispo (pos_x, pos_y, cash_available) VALUES (%1, %2, %3) ON DUPLICATE KEY UPDATE cash_available=%3",
                _posX, _posY, _cash
            ];
            [_insertQuery, 1] call ALF_Server_fnc_asyncCall;

            diag_log format ["[HC3-DAB] Init ATM: %1 = %2", _posKey, _cash];
        };
    } forEach _atms;
};

publicVariable "ALF_DAB_Dispo";
diag_log format ["[HC3-DAB] Initialisation terminee - %1 ATMs", count ALF_DAB_Dispo];
