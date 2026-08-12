#include "\ALF_Client\script_macros.hpp"
/*
File: fn_weaponshopBuySell.sqf
Author: Bryan "tonic" Boardwine

Description:
Master handling of the weapon shop for buying / selling an item.
*/
disableSerialization;
if ((lbCurSel 38403) isEqualto -1) exitwith {
    ["Info", "Il faut selectionner quelque chose.", "warning"] spawn ALF_fnc_doMsg;
};
if ((time - life_action_delay) < 0.3) exitwith {
    ["Info", "Vous appuyez trop vite.", "warning"] spawn ALF_fnc_doMsg;
};
life_action_delay = time;

private _price = lbValue[38403, (lbCurSel 38403)];
if (isnil "_price") then {
    _price = 0;
};
private _item = lbData[38403, (lbCurSel 38403)];
private _iteminfo = [_item] call ALF_fnc_fetchCfgDetails;

private _shop = uiNamespace getVariable ["Weapon_Shop", ""];
private _isDistribBuy = (
	_shop isEqualTo "distributeur_auto" &&
	{(uiNamespace getVariable ["Weapon_Shop_Filter", 0]) isEqualTo 0}
);
private _distribMachine = if (_isDistribBuy) then {
	uiNamespace getVariable ["MRP_Distrib_Machine", objNull]
} else {
	objNull
};
private _distribBlocked = false;

if (_isDistribBuy) then {
	if (isNull _distribMachine) then {
		_distribBlocked = true;
		["Distributeur", "Machine invalide.", "danger"] spawn ALF_fnc_doMsg;
	} else {
		private _stock = [_distribMachine] call ALF_fnc_distrib_stockEnsure;
		if ((_stock getOrDefault [_item, 0]) < 1) then {
			_distribBlocked = true;
			["Distributeur", "Rupture de stock.", "warning"] spawn ALF_fnc_doMsg;
		} else {
			if (MRP_Distrib_EnService && {!([_distribMachine, _item] call ALF_fnc_distrib_canBuyFromMachine)}) then {
				_distribBlocked = true;
				private _label = _iteminfo param [1, _item];
				[
					"Distributeur",
					format [
						"Limite livreur : max %1 %2 par distributeur jusqu'au reboot serveur.",
						[] call ALF_fnc_distrib_getServiceBuyLimit,
						_label
					],
					"warning"
				] spawn ALF_fnc_doMsg;
			};
		};
	};
};

if (_distribBlocked) exitWith {};

private _radio = tolower (call TFAR_fnc_activeSwRadio);

private _exit = false;

if (_item in ["alf_neogend", "alf_sonypm", "alf_SonyPo", "ALF_3310", "ALF_iPhone"]) then {
    if (_radio isNotEqualto "") exitwith {_exit = true};
};

if (_exit) exitwith {
    ["Info", "Il faut enlever votre tablette ou votre téléphone du slot réservé aux radios pour en acheter un autre.", "danger"] spawn ALF_fnc_doMsg;
};

if(_item isEqualto "ALF_CB_Bronze" && {
    !life_laactive
}) exitwith {
    ["Info", "Vous n'avez pas de livret A.", "warning"] spawn ALF_fnc_doMsg;
};
if(_item isEqualto "ALF_CB_Bronze" && {
    life_lbactive
}) exitwith {
    ["Info", "Vous ne pouvez pas acheter cette carte.", "warning"] spawn ALF_fnc_doMsg;
};
if(_item isEqualto "ALF_CB_Gold" && {
    !life_lbactive
}) exitwith {
    ["Info", "Vous n'avez pas de livret B.", "warning"] spawn ALF_fnc_doMsg;
};
if(_item isEqualto "ALF_CB_Gold" && {
    life_lcactive
}) exitwith {
    ["Info", "Vous ne pouvez pas acheter cette carte.", "warning"] spawn ALF_fnc_doMsg;
};
if(_item isEqualto "ALF_CB_Black" && {
    !life_lcactive
}) exitwith {
    ["Info", "Vous n'avez pas de livret C.", "warning"] spawn ALF_fnc_doMsg;
};
if(_item isEqualto "ALF_3310" && {
    ALF_forfait isEqualto -1
}) exitwith {
    ["Info", "Vous n'avez pas d'abonnement'.", "warning"] spawn ALF_fnc_doMsg;
};
if(_item isEqualto "ALF_iPhone" && {
    ALF_forfait isEqualto -1
}) exitwith {
    ["Info", "Vous n'avez pas d'abonnement.", "warning"] spawn ALF_fnc_doMsg;
};

// Sacs / parachute : canAdd est faux même avec de la place — équipement via addBackpack (fn_handleItem)
private _isBackpackItem = (
	_item isEqualTo "B_Parachute" || {_item isEqualTo "MRP_B_Parachute"} ||
	{
		isClass (configFile >> "CfgVehicles" >> _item) &&
		{
			(getNumber (configFile >> "CfgVehicles" >> _item >> "isBackpack")) isEqualTo 1 ||
			{toLower (getText (configFile >> "CfgVehicles" >> _item >> "vehicleClass")) isEqualTo "backpacks"}
		}
	} ||
	{(count _iteminfo > 16) && {(_iteminfo select 16) isEqualTo 1}}
);

if (
	!_isBackpackItem &&
	{!(player canAdd _item)} &&
	{(uiNamespace getVariable ["Weapon_Shop_Filter", 0]) != 1}
) exitWith {
	["Info", "Vous n'avez pas la place pour acheter cet objet.", "warning"] spawn ALF_fnc_doMsg;
};

private _exit = false;
private _distribPurchaseDone = false;

if ((uiNamespace getVariable["Weapon_Shop_Filter", 0]) isEqualto 1) then {
    life_cash = life_cash + _price;
    
    [] spawn {
        life_query_time = time;
        if !(alf_moneysave) then {
            alf_moneysave = true;
            waitUntil {
                sleep 0.3;
                (time - life_query_time) >= 5
            };
            [0] call SOCK_fnc_updatePartial;
            alf_moneysave = false;
        };
    };
    
    [_item, false] spawn ALF_fnc_handleItem;
    ["Info", format["Vous avez vendu %1 pour %2€.", _iteminfo select 1, [_price] call ALF_fnc_numberText], "success"] spawn ALF_fnc_doMsg;
    [nil, (uiNamespace getVariable["Weapon_Shop_Filter", 0])] call ALF_fnc_weaponshopFilter;
    // Update the menu.
} else {
    private _distribServerOk = true;

    if (_isDistribBuy && {!isNull _distribMachine}) then {
        player setVariable ["MRP_Distrib_PurchaseResult", nil];
        [_distribMachine, _item, player] remoteExecCall ["ALF_Server_fnc_distrib_purchaseStock", 2];
        private _timeout = time + 3;
        waitUntil {
            !isNil {player getVariable "MRP_Distrib_PurchaseResult"} || {time > _timeout}
        };
        if (!(player getVariable ["MRP_Distrib_PurchaseResult", false])) then {
            _distribServerOk = false;
            if (isNil {player getVariable "MRP_Distrib_PurchaseResult"}) then {
                ["Distributeur", "Réponse serveur expirée, réessayez.", "warning"] spawn ALF_fnc_doMsg;
            };
        };
    };

    if (!_distribServerOk) exitWith {};

    if (ALF_Prison) exitwith {
        if (_price > life_cash) then {
            ["Info", "Vous n'avez pas assez d'argent.", "success"] spawn ALF_fnc_doMsg;
        } else {
            [_item, true] spawn ALF_fnc_handleItem;
            if (_item in ["ALF_pioche", "ALF_Batte", "ALF_Faux", "ALF_Hache"]) then {
                player addMagazine "sharp_swing";
            };
            
            life_cash = life_cash - _price;
            
            [] spawn {
                life_query_time = time;
                if !(alf_moneysave) then {
                    alf_moneysave = true;
                    waitUntil {
                        sleep 0.3;
                        (time - life_query_time) >= 5
                    };
                    [0] call SOCK_fnc_updatePartial;
                    alf_moneysave = false;
                };
            };
            ["Info", format["Vous avez acheté %1 pour %2€.", _iteminfo select 1, [_price] call ALF_fnc_numberText], "success"] spawn ALF_fnc_doMsg;
            _distribPurchaseDone = true;
        };
    };
    if(_item in ["ALF_Medoc_rhume", "ALF_Medoc_toux"] && {
        (alf_ordonnance select 1) < 1
    }) exitwith {
        ["ERREUR", "votre ordonnance n'est plus valide. Vous avez acheté trop de médicaments", "danger"] spawn ALF_fnc_doMsg;
    };
    
    if (_price > life_cash) then {
        private _handle = [_price, false] call ALF_fnc_handleCB;
        if (_handle) exitwith {
            _exit = true;
        };
        [_item, true] spawn ALF_fnc_handleItem;
        ["Info", format["Vous avez acheté %1 pour %2€.", _iteminfo select 1, [_price] call ALF_fnc_numberText], "success"] spawn ALF_fnc_doMsg;
        
        if (_item in ["ALF_pioche", "ALF_Batte", "ALF_Faux", "ALF_Hache"]) then {
            player addMagazine "sharp_swing";
        };
        if (_item in ["ALF_Medoc_rhume", "ALF_Medoc_toux"]) then {
            alf_ordonnance = [alf_ordonnance select 0, (alf_ordonnance select 1) - 1];
        };
        _distribPurchaseDone = true;
    } else {
        ["Info", format["Vous avez acheté %1 pour %2€.", _iteminfo select 1, [_price] call ALF_fnc_numberText], "success"] spawn ALF_fnc_doMsg;
        life_cash = life_cash - _price;
        
        [] spawn {
            life_query_time = time;
            if !(alf_moneysave) then {
                alf_moneysave = true;
                waitUntil {
                    sleep 0.3;
                    (time - life_query_time) >= 5
                };
                [0] call SOCK_fnc_updatePartial;
                alf_moneysave = false;
            };
        };
        
        [_item, true] spawn ALF_fnc_handleItem;
        
        if (_item in ["ALF_pioche", "ALF_Batte", "ALF_Faux", "ALF_Hache"]) then {
            player addMagazine "sharp_swing";
        };
        if (_item in ["ALF_Medoc_rhume", "ALF_Medoc_toux"]) then {
            alf_ordonnance = [alf_ordonnance select 0, (alf_ordonnance select 1) - 1];
        };
        _distribPurchaseDone = true;
    };

    if (_distribPurchaseDone && _isDistribBuy && {!isNull _distribMachine}) then {
        if (MRP_Distrib_EnService) then {
            [_distribMachine, _item] call ALF_fnc_distrib_registerServiceBuy;
        };
        private _filterIdx = uiNamespace getVariable ["Weapon_Shop_Filter", 0];
        private _curSel = lbCurSel 38403;
        uiNamespace setVariable ["Weapon_Shop_KeepSelection", _item];
        uiNamespace setVariable ["Weapon_Shop_KeepIndex", _curSel];
        [_distribMachine] remoteExecCall ["ALF_fnc_distrib_updateMapMarker", 0];
        [nil, _filterIdx] call ALF_fnc_weaponShopFilter;
    };
};
