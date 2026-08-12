#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_keyGiveDefBill.sqf
	Author: ALF Dev Team
	
	Description:
	Système de facture pour donner définitivement les clés d'un véhicule
	Mode 0: Donneur - Créer et envoyer la facture
	Mode 1: Receveur - Recevoir et accepter/refuser la facture
	Mode 2: Donneur - Confirmation que le receveur a accepté, procéder au transfert
	Mode 3: Donneur - Notification que le receveur a refusé
*/
params [
	["_mode", -1, [0]]
];

if (_mode isEqualTo -1) exitWith {};

switch (_mode) do {
	// Donneur - Envoyer la facture
	case 0: {
		private _amount = param [1, 0, [0]];
		private _vehicle = param [2, objNull, [objNull]];
		private _unit = param [3, objNull, [objNull]];
		private _vehicleIndex = param [4, -1, [0]];
		
		// Vérifier si c'est une maison ou un véhicule
		private _isHouse = uiNamespace getVariable ["ALF_KeyGiveBill_IsHouse", false];
		
		if (_amount <= 0) exitWith {
			["INFO", "Le montant doit être supérieur à 0.", "warning"] spawn ALF_fnc_doMsg;
		};
		if (isNull _unit || isNull _vehicle) exitWith {};
		
		closeDialog 0;
		
		private _name = "";
		private _plate = "";
		
		if (_isHouse) then {
			// Pour les maisons, utiliser le type de maison comme nom
			_name = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
			if (_name isEqualTo "") then {
				_name = "Bien immobilier";
			};
		} else {
			// Pour les véhicules, récupérer le nom et la plaque
			_name = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
			
			// Récupérer la plaque depuis dbInfo (le donneur a accès à dbInfo car c'est son véhicule)
			private _dbInfo = _vehicle getVariable ["dbInfo", []];
			private _plateRaw = if (count _dbInfo > 1) then {_dbInfo select 1} else {""};
			// Convertir la plaque en chaîne - utiliser la même logique que le serveur
			if (_plateRaw != "") then {
				if (_plateRaw isEqualType []) then {
					// Si c'est un tableau, le convertir en chaîne (concaténer les éléments)
					// Exemple: ["MV", "703", "LA"] -> "MV703LA" ou ["MV-703-LA"] -> "MV-703-LA"
					_plate = _plateRaw joinString "";
				} else {
					// Si c'est déjà une chaîne, utiliser directement (mais enlever les guillemets si présents)
					private _plateStr = str _plateRaw;
					if ((_plateStr select [0,1]) == """") then {
						_plate = _plateStr select [1, count _plateStr - 2];
					} else {
						_plate = _plateStr;
					};
				};
			};
		};
		
		private _itemType = if (_isHouse) then {"Bien immobilier"} else {"véhicule"};
		["INFO", format["Facture de %1€ envoyée à %2 pour les clés du %3 : %4", [_amount] call ALF_fnc_numberText, name _unit, _itemType, _name], "success"] spawn ALF_fnc_doMsg;
		
		// Envoyer directement au receveur comme dans fn_payEntreprise et fn_ticketEntreprise
		private _senderUID = getPlayerUID player;
		private _vehicleID = netId _vehicle;
		private _receiverUID = getPlayerUID _unit;
		
		// Envoyer directement au receveur avec la plaque et l'info si c'est une maison (comme dans fn_ticketEntreprise ligne 95 avec false)
		[1, _amount, player, _vehicleID, _vehicleIndex, _name, _plate, _isHouse] remoteExec ["ALF_fnc_keyGiveDefBill", _unit, false];
		
		// Log
		private _logType = if (_isHouse) then {"MAISON"} else {"VEHICULE"};
		[name player, getPlayerUID player, _logType, format["A envoyé une facture de %1€ à %2 pour les clés de : %3", _amount, name _unit, _name]] remoteExec ["ALF_Server_fnc_logIt", 2];
	};
	
	// Receveur - Recevoir la facture et accepter/refuser (appelé directement depuis le donneur)
	case 1: {
		private _amount = param [1, -1, [0]];
		private _sender = param [2, objNull, [objNull]];
		private _vehicleID = param [3, "", [""]];
		private _vehicleIndexRecv = param [4, -1, [0]];
		private _name = param [5, "", [""]];
		private _plate = param [6, "", [""]]; // Plaque passée depuis Case 0 (vide pour les maisons)
		private _isHouse = param [7, false, [false]]; // Indique si c'est une maison
		
		if (!hasInterface) exitWith {};
		
		if (_amount <= 0) exitWith {};
		
		if (isNull _sender) exitWith {};
		
		if (_vehicleID isEqualTo "") exitWith {};
		
		// Récupérer le véhicule/maison à partir du netId (pour affichage dans le dialog)
		private _vehicle = objectFromNetId _vehicleID;
		
		if (isNull _vehicle) exitWith {};
		
		private _itemType = if (_isHouse) then {"bien immobilier"} else {"véhicule"};
		private _action = [format["%1 vous demande de payer %2€ en cash pour recevoir définitivement les clés du %3 : %4. Acceptez-vous ?", name _sender, [_amount] call ALF_fnc_numberText, _itemType, _name], format["Transaction clés %1", _itemType], "OUI", "NON"] call BIS_fnc_guiMessage;
		
		if (_action) then {
			// Accepter - Envoyer confirmation au donneur avec toutes les données nécessaires (y compris la plaque et l'info maison)
			[2, _amount, _vehicle, player, _vehicleIndexRecv, _name, _plate, _isHouse] remoteExecCall ["ALF_fnc_keyGiveDefBill", remoteExecutedOwner];
		} else {
			// Refuser - Notifier le donneur (utiliser remoteExecutedOwner comme dans fn_payEntreprise)
			[3] remoteExecCall ["ALF_fnc_keyGiveDefBill", remoteExecutedOwner];
			["INFO", format["Vous avez refusé de payer la facture de %1€ pour les clés de : %2", [_amount] call ALF_fnc_numberText, _name], "warning"] spawn ALF_fnc_doMsg;
		};
	};
	
	// Donneur - Le receveur a accepté, procéder au transfert
	case 2: {
		private _amount = param [1, 0, [0]];
		private _vehicle = param [2, objNull, [objNull]];
		private _receiver = param [3, objNull, [objNull]];
		private _vehicleIndexSender = param [4, -1, [0]];
		private _name = param [5, "", [""]];
		private _plate = param [6, "", [""]]; // Plaque passée depuis Case 1 (vide pour les maisons)
		private _isHouse = param [7, false, [false]]; // Indique si c'est une maison
		
		// TOUJOURS utiliser le véhicule/maison depuis uiNamespace (c'est le VRAI objet du donneur)
		// Le _vehicle passé depuis Case 1 est un objet REMOTE qui n'a pas de dbInfo côté donneur
		private _vehicleFromUI = uiNamespace getVariable ["ALF_KeyGiveBill_Vehicle", objNull];
		if (!isNull _vehicleFromUI) then {
			_vehicle = _vehicleFromUI;
		} else {
			// Fallback : essayer depuis life_vehicles ou life_houses avec l'index
			if (_isHouse) then {
				// Pour les maisons, utiliser life_houses
				if (_vehicleIndexSender >= 0 && _vehicleIndexSender < count life_houses) then {
					private _housePos = life_houses select _vehicleIndexSender;
					_vehicle = nearestObject [call compile _housePos, "House"];
				};
			} else {
				// Pour les véhicules, utiliser life_vehicles
				if (_vehicleIndexSender >= 0 && _vehicleIndexSender < count life_vehicles) then {
					_vehicle = life_vehicles select _vehicleIndexSender;
				};
			};
		};
		
		if (_amount <= 0) exitWith {
			["Erreur", "Montant invalide. Transaction annulée.", "danger"] spawn ALF_fnc_doMsg;
		};
		
		if (isNull _vehicle) exitWith {
			private _itemType = if (_isHouse) then {"bien"} else {"véhicule"};
			["Erreur", format["Impossible de trouver le %1. Transaction annulée.", _itemType], "danger"] spawn ALF_fnc_doMsg;
		};
		
		if (isNull _receiver) exitWith {
			["Erreur", "Receveur invalide. Transaction annulée.", "danger"] spawn ALF_fnc_doMsg;
		};
		
		// Récupérer la plaque depuis le vrai véhicule (uniquement pour les véhicules)
		if (!_isHouse && _plate == "" && !isNull _vehicle) then {
			private _dbInfo = _vehicle getVariable ["dbInfo", []];
			if (count _dbInfo > 1) then {
				private _plateRaw = _dbInfo select 1;
				if (_plateRaw isEqualType []) then {
					_plate = _plateRaw joinString "";
				} else {
					private _plateStr = str _plateRaw;
					if ((_plateStr select [0,1]) == """") then {
						_plate = _plateStr select [1, count _plateStr - 2];
					} else {
						_plate = _plateStr;
					};
				};
			};
		};
		
		// Envoyer au serveur pour effectuer le transfert
		// Mode 0 = véhicule, Mode 1 = maison
		private _mode = if (_isHouse) then {1} else {0};
		[_mode, _vehicle, _receiver, player, _amount, _vehicleIndexSender, _plate] remoteExec ["ALF_Server_fnc_keyGiveDef", 2];
		
		// Nettoyer les variables du dialog
		uiNamespace setVariable ["ALF_KeyGiveBill_Vehicle", nil];
		uiNamespace setVariable ["ALF_KeyGiveBill_Unit", nil];
		uiNamespace setVariable ["ALF_KeyGiveBill_Index", nil];
		uiNamespace setVariable ["ALF_KeyGiveBill_IsHouse", nil];

		// Nettoyer la variable d'interaction si elle existe
		if (!isNil "ALF_Interaction_Target_Unit") then {
			ALF_Interaction_Target_Unit = nil;
		};
	};
	
	// Donneur - Le receveur a refusé
	case 3: {
		["INFO", "Le receveur a refusé de payer la facture. Transaction annulée.", "warning"] spawn ALF_fnc_doMsg;
		
		// Nettoyer les variables du dialog
		uiNamespace setVariable ["ALF_KeyGiveBill_Vehicle", nil];
		uiNamespace setVariable ["ALF_KeyGiveBill_Unit", nil];
		uiNamespace setVariable ["ALF_KeyGiveBill_Index", nil];
		uiNamespace setVariable ["ALF_KeyGiveBill_IsHouse", nil];
	};
};

