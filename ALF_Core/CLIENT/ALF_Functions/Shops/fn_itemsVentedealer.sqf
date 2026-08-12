/*
//ALF_fnc_itemsVentedealer = {



params ["_p1", "_p2", "_p3", "_categorie"];


if (isNil "_categorie" || {_categorie isEqualTo ""}) then {
    private _dealerTmp = cursorObject;

    if (!isNull _dealerTmp) then {
        _categorie = _dealerTmp getVariable ["deal_categorie", ""];
    };

    if (_categorie isEqualTo "") then {
        systemChat "[DEALER] ⚠ Catégorie manquante => vente_drogues utilisée";
        _categorie = "vente_drogues";
    };
};


if ((time - life_action_delay) < 0.2) exitWith {};
life_action_delay = time;


private _dealer = cursorObject;
uiNamespace setVariable ["current_dealer", _dealer];


uiNamespace setVariable ["Items_Vente", _categorie];


private _shopTitle = ["STRING", ["ItemsVente", _categorie, "name"]] call ALFTools_Client_Config_fnc_getConfig;


if (!(createDialog "life_itemsvente")) exitWith {};

disableSerialization;
ctrlSetText [39401, _shopTitle];


private _btnTout = (findDisplay 39400 displayCtrl 39406);
_btnTout ctrlShow false;
_btnTout ctrlEnable false;


[] call ALF_fnc_itemsVenteLoad;


private _btn = (findDisplay 39400 displayCtrl 39405);
_btn ctrlRemoveAllEventHandlers "ButtonClick";

_btn ctrlAddEventHandler ["ButtonClick", {

    [] spawn {

        disableSerialization;

        private _index = lbCurSel 39403;
        if (_index isEqualTo -1) exitWith {
            hint localize "STR_Shop_Weapon_NoSelect";
        };

        private _price = lbValue [39403, _index];
        if (isNil "_price") then { _price = 0 };

        private _item = lbData [39403, _index];


        [_item, _price] spawn {

            private _item = _this select 0;
            private _prix = _this select 1;

            if !(alf_moneysave) then {

                alf_moneysave = true;
                life_query_time = time;

                systemChat format["[DEBUG] ARGENT AVANT = %1€", life_cash];
                life_cash = life_cash + _prix;
                systemChat format["[DEBUG] ARGENT APRÈS = %1€", life_cash];

                waitUntil { sleep 0.3; (time - life_query_time) >= 5 };


                [0] call SOCK_fnc_updatePartial;


                [
                    name player,
                    getPlayerUID player,
                    "VENTE",
                    format ["A vendu %2 pour %3€. CASH : %1€", life_cash, _item, _prix]
                ] remoteExec ["ALF_Server_fnc_logIt", 2];


                if (_item in [
                    "ALF_Weed","ALF_Weed_2","ALF_Weed_3",
                    "ALF_Weed_P","ALF_Weed_P_2","ALF_Weed_P_3",
                    "ALF_Cocaine_U","ALF_Cocaine",
                    "ALF_Meth50","ALF_Meth90"
                ]) then {


                    private _h = date select 3;
                    private _m = date select 4;
                    if (_m < 10) then { _m = format["0%1", _m] };
                    private _time = format ["%1:%2", _h, _m];


                    private _adn = player getVariable ["adnface", ["UNKN"]] select 0;


                    private _dealer = uiNamespace getVariable ["current_dealer", objNull];
                    if (!isNull _dealer) then {

                        private _info = _dealer getVariable ["info", []];


                        _info pushBack [
                            _time,
                            _item,
                            _adn
                        ];

                        _dealer setVariable ["info", _info, true];

                    } else {
                        diag_log "[DEALER] Dealer introuvable (uiNamespace)";
                    };
                };

                alf_moneysave = false;
            };
        };


        private _rm = [_item, false] spawn ALF_fnc_handleItem;
        ALFBOURSE_NbAchat pushBack [_item, 1];

        waitUntil { sleep 0.05; scriptDone _rm };


        [] call ALF_fnc_itemsVenteLoad;


        private _itemInfo = [_item] call ALF_fnc_fetchCfgDetails;

        hint parseText format [
            "Vous avez vendu un %1 pour <t color='#8cff9b'>%2€</t>.",
            _itemInfo select 1,
            [_price] call ALF_fnc_numberText
        ];
    };
}];


//};


*/






//ALF_fnc_itemsVentedealer = {



params ["_p1", "_p2", "_p3", "_categorie"];

if (isNil "_categorie" || {_categorie isEqualTo ""}) then {
    private _dealerTmp = cursorObject;
    if (!isNull _dealerTmp) then {
        _categorie = _dealerTmp getVariable ["deal_categorie", ""];
    };
    if (_categorie isEqualTo "") then {
        systemChat "[DEALER] ⚠ Catégorie manquante => vente_drogues utilisée";
        _categorie = "vente_drogues";
    };
};

if ((time - life_action_delay) < 0.2) exitWith {};
life_action_delay = time;

private _dealer = cursorObject;
uiNamespace setVariable ["current_dealer", _dealer];
uiNamespace setVariable ["Items_Vente", _categorie];

private _shopTitle = ["STRING", ["ItemsVente", _categorie, "name"]] call ALFTools_Client_Config_fnc_getConfig;

if (!(createDialog "life_itemsvente")) exitWith {};

disableSerialization;
ctrlSetText [39401, _shopTitle];

private _btnTout = (findDisplay 39400 displayCtrl 39406);
_btnTout ctrlShow false;
_btnTout ctrlEnable false;

[] call ALF_fnc_itemsVenteLoad;

private _btn = (findDisplay 39400 displayCtrl 39405);
_btn ctrlRemoveAllEventHandlers "ButtonClick";

_btn ctrlAddEventHandler ["ButtonClick", {

    disableSerialization;
    private _btn = _this select 0;

    // 🔒 Désactive totalement le bouton
    _btn ctrlEnable false;

    [] spawn {

        disableSerialization;

        private _index = lbCurSel 39403;
        if (_index isEqualTo -1) exitWith {

            hint localize "STR_Shop_Weapon_NoSelect";

            // 🔓 réactive le bouton immédiatement
            private _btn = findDisplay 39400 displayCtrl 39405;
            _btn ctrlEnable true;
        };

        private _price = lbValue [39403, _index];
        if (isNil "_price") then { _price = 0 };

        private _item = lbData [39403, _index];

        // PROCESS VENTE
        [_item, _price] spawn {

            params ["_item","_prix"];

            if !(alf_moneysave) then {

                alf_moneysave = true;
                life_query_time = time;

                systemChat format["[DEBUG] ARGENT AVANT = %1€", life_cash];
                life_cash = life_cash + _prix;
                systemChat format["[DEBUG] ARGENT APRÈS = %1€", life_cash];

                waitUntil { sleep 0.3; (time - life_query_time) >= 5 };

                // Update DB
                [0] call SOCK_fnc_updatePartial;

                // LOG SERVEUR
                [
                    name player,
                    getPlayerUID player,
                    "VENTE",
                    format ["A vendu %2 pour %3€. CASH : %1€", life_cash, _item, _prix]
                ] remoteExec ["ALF_Server_fnc_logIt", 2];

                // TRAITEMENT SPECIAL DEALER / ADN
                if (_item in [
                    "ALF_Weed","ALF_Weed_2","ALF_Weed_3",
                    "ALF_Weed_P","ALF_Weed_P_2","ALF_Weed_P_3",
                    "ALF_Cocaine_U","ALF_Cocaine",
                    "ALF_Meth50","ALF_Meth90"
                ]) then {

                    private _h = date select 3;
                    private _m = date select 4;
                    if (_m < 10) then { _m = format["0%1", _m] };
                    private _time = format ["%1:%2", _h, _m];

                    private _adn = player getVariable ["adnface", ["UNKN"]] select 0;

                    private _dealer = uiNamespace getVariable ["current_dealer", objNull];
                    if (!isNull _dealer) then {
                        private _info = _dealer getVariable ["info", []];
                        _info pushBack [_time, _item, _adn];
                        _dealer setVariable ["info", _info, true];
                    };
                };

                alf_moneysave = false;
            };

            // Retrait item
            private _rm = [_item, false] spawn ALF_fnc_handleItem;
            ALFBOURSE_NbAchat pushBack [_item, 1];

            waitUntil { sleep 0.05; scriptDone _rm };

            // Refresh liste
            [] call ALF_fnc_itemsVenteLoad;

            // Infos item
            private _itemInfo = [_item] call ALF_fnc_fetchCfgDetails;

            hint parseText format [
                "Vous avez vendu un %1 pour <t color='#8cff9b'>%2€</t>.",
                _itemInfo select 1,
                [_prix] call ALF_fnc_numberText
            ];

            // 🔓 Réactive le bouton FIN DE VENTE
            private _btn = findDisplay 39400 displayCtrl 39405;
            _btn ctrlEnable true;
        };
    };
}];



//};