/*
    File: fn_handleCB.sqf
    Auhtor: ALF Team

    Description:
    Script pour payer par carte bleu

    _handle = ["1000",false] call ALF_fnc_handleCB;
    if (_handle) exitWith {["Carte Bancaire", "Le paiement à été refuse.", "danger", false] spawn ALF_fnc_doMsg;};
*/
private _number = _this # 0;
private _payentreprise = _this # 1;
private _return = false;
private _nomoney = false;
if("ALF_CB_Bronze" in (magazines player) OR {"ALF_CB_Gold" in (magazines player) OR {"ALF_CB_Black" in (magazines player)}}) then 
{
    if !(life_livreta >= 0) exitWith {_return = true; ["Credit Mutuel", "Vos comptes sont actuellement bloqués. Merci de renflouer votre livret A.", "danger", false] spawn ALF_fnc_doMsg;};
    switch (life_activecb) do 
    {
        case 0 : 
        {
            _return = true;
            ["INFO", "Votre carte bancaire n'est pas lié à un compte.", "warning", false] spawn ALF_fnc_doMsg;
        };
        case 1 : 
        {
            _action = [format["Voulez-vous payer %1€ par carte bancaire. La somme sera prélevé depuis votre Livret A.",[_number] call ALF_fnc_numberText],"Payer par carte","OUI","NON"] call BIS_fnc_guiMessage;
            if !(_action) exitWith {_return = true;};
            if (_number > life_livreta) exitWith {_return = true; _nomoney = true;};
            life_livreta = life_livreta - _number;

            [] spawn 
            {
                life_query_time = time;
                if !(alf_moneysave) then 
                {
                    alf_moneysave = true;
                    waitUntil {sleep 0.3; (time - life_query_time) >= 5};
                    [6] call SOCK_fnc_updatePartial;
                    alf_moneysave = false;
                };
            };

            ["Carte Bancaire", format["%1€ à été debité de votre livret A.",[_number] call ALF_fnc_numberText], "success", false] spawn ALF_fnc_doMsg;
        };
        case 2 : 
        {
            _action = [format["Voulez-vous payer %1€ par carte bancaire. La somme sera prélevé depuis votre Livret B.",[_number] call ALF_fnc_numberText],"Payer par carte","OUI","NON"] call BIS_fnc_guiMessage;
            if !(_action) exitWith {_return = true;};
            if (_number > life_livretb) exitWith {_return = true; _nomoney = true;};
            life_livretb = life_livretb - _number;

            [] spawn 
            {
                life_query_time = time;
                if !(alf_moneysave) then 
                {
                    alf_moneysave = true;
                    waitUntil {sleep 0.3; (time - life_query_time) >= 5};
                    [7] call SOCK_fnc_updatePartial;
                    alf_moneysave = false;
                };
            };

            ["Carte Bancaire", format["%1€ à été débité de votre livret B.",[_number] call ALF_fnc_numberText], "success", false] spawn ALF_fnc_doMsg;
        };
        case 3 : 
        {
            _action = [format["Voulez-vous payer %1€ par carte bancaire. La somme sera prélevé depuis votre Livret C.",[_number] call ALF_fnc_numberText],"Payer par carte","OUI","NON"] call BIS_fnc_guiMessage;
            if !(_action) exitWith {_return = true;};
            if (_number > life_livretc) exitWith {_return = true; _nomoney = true;};
            life_livretc = life_livretc - _number;

            [] spawn 
            {
                life_query_time = time;
                if !(alf_moneysave) then 
                {
                    alf_moneysave = true;
                    waitUntil {sleep 0.3; (time - life_query_time) >= 5};
                    [8] call SOCK_fnc_updatePartial;
                    alf_moneysave = false;
                };
            };

            ["Carte Bancaire", format["%1€ à été débité de votre livret C.",[_number] call ALF_fnc_numberText], "success", false] spawn ALF_fnc_doMsg;
        };
    };
} else {
    _return = true;
    if !(_payentreprise) then {["INFO", "Vous n'avez pas de carte bancaire.", "warning", false] spawn ALF_fnc_doMsg;};
};

if(_nomoney && {!(_payentreprise)}) then {["Carte Bancaire", "Le paiement à été refusé.", "danger", false] spawn ALF_fnc_doMsg;};

_return;
