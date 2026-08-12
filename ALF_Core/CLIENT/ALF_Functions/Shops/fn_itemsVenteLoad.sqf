#include "\ALF_Client\script_macros.hpp"

if (!dialog) exitWith {};

private _itemList = ((findDisplay 39400) displayCtrl 39403);
lbClear _itemList;

private _shop         = uiNamespace getVariable ["Items_Vente",""];
private _config       = [];
private _listedItems  = [];

_config = (assignedItems player) + (uniformItems player) + (vestItems player) + (backpackItems player);

((findDisplay 39400) displayCtrl 39405) ctrlSetText "VENDRE";
ctrlShow [39402, true];

private _itemArray = ["ARRAY", ["ItemsVente", _shop, "items"]] call ALFTools_Client_Config_fnc_getConfig;

{
    if (!(_x in _listedItems) && _x != "") then {
        private _iS = [_x, _itemArray] call TON_fnc_index;
        if (_iS != -1) then {
            private _itemInfo  = [_x] call ALF_fnc_fetchCfgDetails;   // [class, name, picturePath, ...]
            _listedItems pushBack _x;

            private _itemCount = { _x isEqualTo (_itemInfo select 0) } count _config;

            // Ajout texte + récupération de l'index créé par lbAdd
            private _idx = if (_itemCount > 1) then {
                _itemList lbAdd format ["[x%2] %1", _itemInfo select 1, _itemCount];
            } else {
                _itemList lbAdd format ["%1", _itemInfo select 1];
            };

            // Renseigner les données de la même ligne
            _itemList lbSetData    [_idx, _itemInfo select 0];
            _itemList lbSetPicture [_idx, _itemInfo select 2];
            _itemList lbSetValue   [_idx, _itemCount];
        };
    };
} forEach _config;

_itemList lbSetCurSel 0;

private _itemsPossibles = _listedItems apply { format ["%1", _x] };
[name player, getPlayerUID player, "VENTE_MENU",
 format ["%1 a ouvert le menu de vente %2 avec ces objets valides : %3",
        name player, _shop, _itemsPossibles joinString ", "]
] remoteExec ["ALF_Server_fnc_logIt", 2];
