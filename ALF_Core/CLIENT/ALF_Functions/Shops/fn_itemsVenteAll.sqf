#include "\ALF_Client\script_macros.hpp"

if ((time - life_action_delay) < 0.2) exitWith {};
life_action_delay = time;

disableSerialization;

private _display = findDisplay 39400;
private _listbox = _display displayCtrl 39403;
private _btn = _display displayCtrl 39406;
_btn ctrlEnable false;

private _count = lbSize 39403;
if (_count isEqualTo 0) exitWith {
    hint "Aucun objet à vendre.";
    _btn ctrlEnable true;
};

private _vendus = 0;
private _revenuTotal = 0;

for "_i" from 0 to (_count - 1) do {
    private _item = lbData[39403, _i];
    private _qty = lbValue[39403, _i]; // quantité réelle
    if (isNil "_item" || _item isEqualTo "") then { continue };
    if (_qty < 1) then { continue };

    // Récupère le prix unitaire depuis la config
    private _itemCfg = ["ARRAY", ["ItemsVente", uiNamespace getVariable ["Items_Vente",""], "items"]] call ALFTools_Client_Config_fnc_getConfig;
    private _index = [_item, _itemCfg] call TON_fnc_index;
    if (_index isEqualTo -1) then { continue };
    private _priceUnit = _itemCfg select _index select 1;
    if (_item isEqualTo "ALF_pierre_small" && {player getVariable ["ALF_EnPrison", false]}) then {
        _priceUnit = floor (_priceUnit / 21);
    };

    for "_j" from 1 to _qty do {
        // Retrait item
        private _removed = [_item, false] call ALF_fnc_handleItem;
        waitUntil { sleep 0.01; scriptDone _removed };
        if (_removed isEqualType true && {!_removed}) then { continue };

        life_cash = life_cash + _priceUnit;
        _revenuTotal = _revenuTotal + _priceUnit;

        // XP
        if (_item in ["ALF_Banane","ALF_Peche"]) then {
            [0,1] spawn ALF_fnc_addXP;
        } else {
            if (_item in ["ALF_Raisin","ALF_Huitre","ALF_Champignon"]) then {
                [0,3] spawn ALF_fnc_addXP;
            } else {
                if (_item in ["ALF_Fraise","ALF_Truffe"]) then {
                    [0,5] spawn ALF_fnc_addXP;
                };
            };
        };

        ALFBOURSE_NbAchat pushBack [_item, 1];
        _vendus = _vendus + 1;

        // Log serveur
        [name player, getPlayerUID player, "VENTE_ITEM_ALL", format["%1 a vendu %2 pour %3€", name player, _item, _priceUnit]] remoteExec ["ALF_Server_fnc_logIt", 2];
    };
};

[] call ALF_fnc_itemsVenteLoad;

if (_vendus > 0) then {
    hint format["Vous avez vendu %1 objets pour un total de <t color='#8cff9b'>%2€</t>.", _vendus, [_revenuTotal] call ALF_fnc_numberText];
} else {
    hint "Aucun item n'a pu être vendu.";
};

_btn ctrlEnable true;
