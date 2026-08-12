#include "\ALF_Client\script_macros.hpp"
/*
    FICHE DE PAIE – VERSION MODIFIÉE
    L’entreprise paie un employé.
*/


/*

ALF_fnc_ticketEntreprise = {

params [
    ["_mode",-1,[0]]
];
if (_mode isEqualTo -1) exitWith {};

systemChat format ["[TICKET] ---- MODE %1 START ----", _mode];

switch (_mode) do
{


case 0:
{
    systemChat "[CASE 0] Début détection joueur devant";

    private _amount = param [1,"",[""]];

    if !([_amount] call TON_fnc_isnumber) exitWith {
        ["INFO","Montant invalide.","danger"] spawn ALF_fnc_doMsg;
        // systemChat "[CASE 0] Montant invalide → ABORT";
    };

    _amount = parseNumber _amount;

    if (_amount <= 0) exitWith {
        ["INFO","Montant invalide.","danger"] spawn ALF_fnc_doMsg;
        // systemChat "[CASE 0] Montant <= 0 → ABORT";
    };

    private _start = eyePos player;
    private _end   = _start vectorAdd (player weaponDirection "Throw" vectorMultiply 4);
    private _hit   = lineIntersectsSurfaces [_start, _end, player, objNull, true, 1, "VIEW", "FIRE"];

    private _receiver = objNull;

    if (!(_hit isEqualTo [])) then {
        private _obj = _hit # 0 # 2;
        if (!isNull _obj && {isPlayer _obj}) then {
            _receiver = _obj;
        };
    };

    if (isNull _receiver) then {
        {
            if (
                isPlayer _x &&
                alive _x &&
                _x != player &&
                [player, _x] call BIS_fnc_isInFrontOf &&
                (player distance _x) < 4
            ) exitWith {
                _receiver = _x;
            };
        } forEach (player nearEntities ["Man", 4]);
    };

    if (isNull _receiver) exitWith {
        ["INFO","Aucun joueur détecté.","danger"] spawn ALF_fnc_doMsg;
        systemChat "[CASE 0] Aucun joueur détecté (raycast+fallback) → ABORT";
    };

    systemChat format ["[CASE 0] Joueur détecté : %1", name _receiver];

    private _siret = "";
    private _emp = player getVariable ["isEmployed",""];

    {
        private _biz = _x getVariable ["business", []];
        if !(_biz isEqualTo []) then {
            if ((_biz select 2) isEqualTo _emp) exitWith {
                _siret = _biz select 2;
            };
        };
    } forEach ALF_allBusinesss;

    if (_siret isEqualTo "") exitWith {
        ["INFO","Impossible d'obtenir le SIRET de votre entreprise.","danger"] spawn ALF_fnc_doMsg;
        systemChat "[CASE 0] ERREUR → SIRET introuvable";
    };

    systemChat format ["[CASE 0] SIRET récupéré = %1", _siret];

    systemChat "[CASE 0] ENVOI remoteExec MODE 1...";
    [1, _amount, player, _siret] remoteExec ["ALF_fnc_ticketEntreprise", _receiver, false];

    closeDialog 0;

    [
        name player, getPlayerUID player, "ENTREPRISE",
        format["A envoyé une fiche de paie de %1 € à %2.", _amount, name _receiver]
    ] remoteExec ["ALF_Server_fnc_logIt",2];

    systemChat "[CASE 0] FIN CASE 0";
};



case 1:
{
    private _amount = param [1,-1,[0]];
    private _boss   = param [2,objNull,[objNull]];
    private _siret  = param [3,"INCONNU",[""]];

    systemChat format [
        "[CASE 1] Popup sur %1 → Boss=%2 | Montant=%3 | SIRET=%4",
        name player, name _boss, _amount, _siret
    ];

    if (!hasInterface) exitWith {};
    if (_amount <= 0 || isNull _boss) exitWith {};

    private _action = [
        format[
            "%1 vous envoie une fiche de paie de %2 € (Entreprise %3). Accepter ?",
            name _boss,
            [_amount] call ALF_fnc_numberText,
            _siret
        ],
        "Fiche de paie",
        "OUI",
        "NON"
    ] call BIS_fnc_guiMessage;

    systemChat format ["[CASE 1] Réponse = %1", _action];

    if (_action) then
    {
        systemChat "[CASE 1] ACCEPTÉ → MODE 2";
        [2, _amount, _boss, _siret] call ALF_fnc_ticketEntreprise;
    }
    else
    {
        systemChat "[CASE 1] REFUSÉ → MODE 3 au boss";
        [3, player] remoteExec ["ALF_fnc_ticketEntreprise", _boss];
    };
};


case 2:
{
    private _amount = param [1,-1,[0]];
    private _boss   = param [2,objNull,[objNull]];
    private _siret  = param [3,"INCONNU",[""]];

    private _receiver = player;

    systemChat "[CASE 2] ----- CREDIT & DEBIT ENTREPRISE -----";

    systemChat format ["[CASE 2] Cash AVANT = %1", life_cash];
    life_cash = life_cash + _amount;
    [0] call SOCK_fnc_updatePartial;

    [] spawn {
        uiSleep 0.2;
        [] call SOCK_fnc_updateRequest;
    };

    systemChat format ["[CASE 2] Cash APRÈS = %1", life_cash];

    ["INFO", format["Vous avez reçu %1 €.", _amount], "success"]
        spawn ALF_fnc_doMsg;


    private _building = objNull;

    {
        private _biz = _x getVariable ["business", []];
        if !(_biz isEqualTo []) then {
            if ((_biz select 2) isEqualTo _siret) exitWith {
                _building = _x;
            };
        };
    } forEach ALF_allBusinesss;

    if (!isNull _building) then
    {
        private _var = _building getVariable ["business", []];
        private _capital = _var select 3;

        private _newCap = _capital - _amount;
        if (_newCap < 0) then { _newCap = 0; };

        _var set [3, _newCap];
        _building setVariable ["business", _var, true];

        systemChat format ["[CASE 2] Capital AVANT=%1 | APRÈS=%2", _capital, _newCap];

        [_siret, _newCap] remoteExec ["ALF_Server_fnc_capitalBusiness", 2];
    }
    else {
        systemChat "[CASE 2] Aucun bâtiment associé à ce SIRET.";
    };


    [
        name _boss, getPlayerUID _boss, "ENTREPRISE",
        format["Entreprise %1 a payé %2 € à %3.", _siret, _amount, name _receiver]
    ] remoteExec ["ALF_Server_fnc_logIt",2];

    [
        name _boss, getPlayerUID _boss, "ENTREPRISE",
        format["Entreprise %1 a retiré %2 € de son capital pour payer %3.",
        _siret, _amount, name _receiver]
    ] remoteExec ["ALF_Server_fnc_logIt",2];


    if (!isNull _boss) then {
        ["INFO", format["%1 a accepté et a reçu %2 €.", name _receiver, _amount], "success"]
            remoteExec ["ALF_fnc_doMsg", _boss];
    };

    systemChat "[CASE 2] ----- FIN MODE 2 -----";
};


case 3:
{
    systemChat "[CASE 3] Le joueur a REFUSÉ la fiche de paie";

    ["INFO","Vous avez refusé la fiche de paie.","warning"]
        spawn ALF_fnc_doMsg;

    private _receiver = param [1,objNull,[objNull]];
    if (!isNull _receiver) then {
        ["INFO", format["%1 a refusé votre fiche de paie.", name _receiver], "warning"]
            remoteExec ["ALF_fnc_doMsg", _receiver];
    };
};



default {
    systemChat format ["[TICKET] Mode inconnu = %1", _mode];
};

};

systemChat format ["[TICKET] ---- MODE %1 END ----", _mode];


};

*/




//ALF_fnc_ticketEntreprise = {

params [
    ["_mode",-1,[0]]
];
if (_mode isEqualTo -1) exitWith {};

// systemChat format ["[TICKET] ---- MODE %1 START ----", _mode];

switch (_mode) do
{

case 0:
{
    // systemChat "[CASE 0] Début détection joueur devant";

    private _amount = param [1,"",[""]];

    if !([_amount] call TON_fnc_isnumber) exitWith {
        ["INFO","Montant invalide.","danger"] spawn ALF_fnc_doMsg;
        // systemChat "[CASE 0] Montant invalide → ABORT";
    };

    _amount = parseNumber _amount;

    if (_amount <= 0) exitWith {
        ["INFO","Montant invalide.","danger"] spawn ALF_fnc_doMsg;
        // systemChat "[CASE 0] Montant <= 0 → ABORT";
    };

    private _start = eyePos player;
    private _end   = _start vectorAdd (player weaponDirection "Throw" vectorMultiply 4);
    private _hit   = lineIntersectsSurfaces [_start, _end, player, objNull, true, 1, "VIEW", "FIRE"];

    private _receiver = objNull;

    if (!(_hit isEqualTo [])) then {
        private _obj = _hit # 0 # 2;
        if (!isNull _obj && {isPlayer _obj}) then {_receiver = _obj;};
    };

    if (isNull _receiver) then {
        {
            if (
                isPlayer _x &&
                alive _x &&
                _x != player &&
                [player, _x] call BIS_fnc_isInFrontOf &&
                (player distance _x) < 4
            ) exitWith {_receiver = _x;};
        } forEach (player nearEntities ["Man", 4]);
    };

    if (isNull _receiver) exitWith {
        ["INFO","Aucun joueur détecté.","danger"] spawn ALF_fnc_doMsg;
        // systemChat "[CASE 0] Aucun joueur détecté → ABORT";
    };

    // systemChat format ["[CASE 0] Joueur détecté : %1", name _receiver];

    private _siret   = "";
    private _bizName = "ENTREPRISE";
    private _emp = player getVariable ["isEmployed",""];

    {
        private _biz = _x getVariable ["business", []];
        if !(_biz isEqualTo []) then {
            if ((_biz select 2) isEqualTo _emp) exitWith {
                _bizName = _biz select 1; 
                _siret   = _biz select 2;
            };
        };
    } forEach ALF_allBusinesss;

    if (_siret isEqualTo "") exitWith {
        ["INFO","Impossible d'obtenir votre entreprise.","danger"] spawn ALF_fnc_doMsg;
        // systemChat "[CASE 0] ERREUR → SIRET introuvable";
    };

    // systemChat format ["[CASE 0] Entreprise='%1' | SIRET=%2", _bizName, _siret];

    [1, _amount, player, _bizName, _siret] 
        remoteExec ["ALF_fnc_ticketEntreprise", _receiver, false];

    closeDialog 0;

    [
        name player, getPlayerUID player, "ENTREPRISE",
        format["A envoyé une fiche de paie de %1 € à %2.", _amount, name _receiver]
    ] remoteExec ["ALF_Server_fnc_logIt",2];
		if (b_33) then {
			[
				name player, getPlayerUID player, "TROPICAUTO",
				format["A envoyé une fiche de paie de %1 € à %2.", _amount, name _receiver]
			] remoteExec ["ALF_Server_fnc_logIt",2];
		};

    // systemChat "[CASE 0] FIN CASE 0";
};


case 1:
{
    private _amount  = param [1,-1,[0]];
    private _boss    = param [2,objNull,[objNull]];
    private _bizName = param [3,"ENTREPRISE",[""]];
    private _siret   = param [4,"",[""]];

    // systemChat format [
    //     "[CASE 1] Popup sur %1 → Boss=%2 | Montant=%3 | Entreprise=%4",
    //     name player, name _boss, _amount, _bizName
    // ];

    if (!hasInterface || isNull _boss || _amount <= 0) exitWith {};

    private _action = [
        format[
            "%1 vous envoie une fiche de paie de %2 € (%3). Accepter ?",
            name _boss,
            [_amount] call ALF_fnc_numberText,
            _bizName
        ],
        "Fiche de paie",
        "OUI",
        "NON"
    ] call BIS_fnc_guiMessage;

    // systemChat format ["[CASE 1] Réponse = %1", _action];

    if (_action) then {
        [2, _amount, _boss, _bizName, _siret] call ALF_fnc_ticketEntreprise;
    }
    else {
        [3, player] remoteExec ["ALF_fnc_ticketEntreprise", _boss];
    };
};


case 2:
{
    private _amount  = param [1,-1,[0]];
    private _boss    = param [2,objNull,[objNull]];
    private _bizName = param [3,"ENTREPRISE",[""]];
    private _siret   = param [4,"INCONNU",[""]];

    private _receiver = player;

    // systemChat "[CASE 2] --- CREDIT / DEBIT ENTREPRISE ---";

    life_cash = life_cash + _amount;
    [0] call SOCK_fnc_updatePartial;

    [] spawn { uiSleep 0.2; [] call SOCK_fnc_updateRequest; };

    ["INFO", format["Vous avez reçu %1 €.", _amount], "success"]
        spawn ALF_fnc_doMsg;

    private _building = objNull;

    {
        private _biz = _x getVariable ["business", []];
        if !(_biz isEqualTo [] && isNull _building) then {
            // Rechercher sur le bâtiment principal (Land_ALF_Entreprise) ou les concessionnaires (Land_MRP_Concessionnaire)
            if ((_biz select 2) isEqualTo _siret && {typeOf _x in ["Land_ALF_Entreprise", "Land_MRP_Concessionnaire"]}) exitWith {
                _building = _x;
            };
        };
    } forEach ALF_allBusinesss;

    if (!isNull _building) then {
        private _data = _building getVariable ["business", []];
        private _capital = _data select 3;

        // Convertir le capital en nombre si c'est une string
        if (typeName _capital == "STRING") then {
            _capital = parseNumber _capital;
        };

        private _newCap = _capital - _amount;
        if (_newCap < 0) then {_newCap = 0;};

        _data set [3, _newCap];
        _building setVariable ["business", _data, true];

        [_siret, _newCap] remoteExec ["ALF_Server_fnc_capitalBusiness", 2];
    };

    if (!isNull _boss) then {
        ["INFO", format["%1 a accepté et reçu %2 € de %3.", name _receiver, _amount, _bizName], "success"]
            remoteExec ["ALF_fnc_doMsg", _boss];
    };

    // systemChat "[CASE 2] FIN CASE 2";
};



case 3:
{
    private _receiver = param [1,objNull,[objNull]];

    ["INFO","Vous avez refusé la fiche de paie.","warning"]
        spawn ALF_fnc_doMsg;

    if (!isNull _receiver) then {
        ["INFO", format["%1 a refusé votre fiche de paie.", name _receiver], "warning"]
            remoteExec ["ALF_fnc_doMsg", _receiver];
    };

};



default {
    // systemChat format ["[TICKET] Mode inconnu = %1", _mode];
};

};

// systemChat format ["[TICKET] ---- MODE %1 END ----", _mode];

//};