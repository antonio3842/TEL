/*
	File: fn_keyGiveDef.sqf
	Author: ALF Dev Team
	0 = veh
	1 = house
*/
/*
private _mode = _this select 0;
private _obj = _this select 1;
private _unit = _this select 2;
private _player = _this select 3;
private _uid = getPlayerUID _unit;
private _name = getText(configFile >> "CfgVehicles" >> (typeOf _obj) >> "displayName");

switch (_mode) do {
	case 0 : {
		private _var = _obj getVariable["dbInfo",[]];
		if(count _var isEqualTo 0) exitWith {diag_log "fn_keyGiveDef : exit #1";};
		private _plate = _var select 1;
		_plate = [_plate] call ALF_Server_fnc_mresArray;
		
		private _check = format["SELECT id FROM vehicles WHERE plate='%1'",_plate];
		private _result = [_check,2] call ALF_Server_fnc_asyncCall;
		if(count _result isEqualTo 0) exitWith {diag_log "fn_keyGiveDef : exit #2";};
		
		private _vid = _result select 0;
		
		_obj setVariable ["vehicle_info_owners",["",(getPlayerUID _unit)],true];
		private _vinfo = _obj getVariable ["dbInfo",[]];
		_vinfo set[0,_uid];
		_obj setVariable ["dbInfo",_vinfo];
		
		private _type = switch(true) do {
			case (_obj isKindOf "Car"): {"Car"};
			case (_obj isKindOf "Air"): {"Air"};
			case (_obj isKindOf "Ship"): {"Ship"};
		};
		
		[format["UPDATE vehicles SET pid='%1', type='%3', insure='0', insurecount='0' WHERE id='%2'",_uid,_vid,_type],1] call ALF_Server_fnc_asyncCall;
		[format["DELETE FROM keysTime WHERE mode='0' AND idobj='%1'",_vid],1] call ALF_Server_fnc_asyncCall;
		
		[name _player,getPlayerUID _player,"VEHICULE",format["vient de donner le véhicule %1 (%4) à %2 (%3).",_vid,name _unit,getPlayerUID _unit, typeOf _obj]] spawn ALF_Server_fnc_logIt;
		[name _unit,getPlayerUID _unit,"VEHICULE",format["vient de recevoir le véhicule %1 (%4) de %2 (%3).",_vid,name _player,getPlayerUID _player, typeOf _obj]] spawn ALF_Server_fnc_logIt;

		[_obj,_unit] remoteExecCAll ["TON_fnc_clientGetKey",_unit];
	};
	case 1 : {
		private _hid = _obj getVariable ["house_id",-1];
		if(_hid isEqualTo -1) exitWith {diag_log "fn_keyGiveDef : exit #3";};
		
		private _query = format["SELECT * FROM houses WHERE pid='%1'",_uid];
		private _queryResult = [_query,2] call ALF_Server_fnc_asyncCall;
		if (count(_queryResult) isEqualTo 4) exitWith {["Maison","Cette personne a déjà le nombre maximum de bien.","success"] remoteExec ["ALF_fnc_doMsg",_player];};
		
		_query = format["UPDATE houses SET pid='%1' WHERE id='%2'",_uid,_hid];
		[_query,1] call ALF_Server_fnc_asyncCall;

		[_obj,_unit] remoteExecCAll ["TON_fnc_clientGetKey",_unit];

		["Maison", format["Vous avez recu définitivement les clés de : %1. La Préfecture peut mettre quelques heures a finaliser vos papiers.",_name],"success"] remoteExec ["ALF_fnc_doMsg",_unit];
		["Maison", format["Vous avez donné définitivement les clés de : %1. La Préfecture peut mettre quelques heures a finaliser les papiers.",_name],"success"] remoteExec ["ALF_fnc_doMsg",_player];
	};
};
*/


/*
	File: fn_keyGiveDef.sqf
	Author: ALF Dev Team
	0 = veh
	1 = house
*/
private _mode = _this select 0;
private _obj = _this select 1;
private _unit = _this select 2;
private _player = _this select 3;
private _amount = if (count _this > 4) then {_this select 4} else {0}; // Montant de la transaction (optionnel, 0 par défaut pour rétrocompatibilité)
private _vehicleIndexSender = if (count _this > 5) then {_this select 5} else {-1}; // Index du véhicule côté client (pour retirer de life_vehicles après confirmation)
private _plateParam = if (count _this > 6) then {_this select 6} else {""}; // Plaque passée en paramètre (pour retrouver le véhicule si l'objet est REMOTE)
private _uid = getPlayerUID _unit;
private _playerUID = getPlayerUID _player;

	switch (_mode) do {
	case 0 : {
		// Vérification : Les membres b_33 peuvent donner à n'importe qui
		// Les joueurs non-b_33 ne peuvent donner qu'aux membres b_33
		private _giverB33 = _player getVariable ["b_33", false];
		if (!_giverB33) then {
			// Le donneur n'est pas b_33, vérifier que le receveur est b_33
			private _receiverB33 = _unit getVariable ["b_33", false];
			if (!_receiverB33) exitWith {
				["Erreur", "Vous ne pouvez donner définitivement les clés qu'à des membres de TropicAuto.", "danger"] remoteExec ["ALF_fnc_doMsg", _player];
				["Erreur", "Vous devez être membre de TropicAuto pour recevoir définitivement des clés.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
			};
		};
		// Si le donneur est b_33, aucune restriction (peut donner à n'importe qui)
		
		// Si l'objet est null, essayer de le retrouver depuis les véhicules du joueur
		if (isNull _obj) then {
			// Récupérer la liste des véhicules du joueur depuis la variable serveur
			private _playerKeys = missionNamespace getVariable [format["%1_KEYS",_playerUID],[]];
			// Prendre le dernier véhicule de la liste (ou le premier si _vehicleIndexSender est spécifié)
			if (count _playerKeys > 0) then {
				private _indexToUse = if (_vehicleIndexSender >= 0 && _vehicleIndexSender < count _playerKeys) then {_vehicleIndexSender} else {(count _playerKeys - 1)};
				_obj = _playerKeys select _indexToUse;
			};
		};
		
		if (isNull _obj) exitWith {
			["Erreur", "Impossible de trouver le véhicule. Transaction annulée.", "danger"] remoteExec ["ALF_fnc_doMsg", _player];
			["Erreur", "Impossible de trouver le véhicule. Transaction annulée.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
		};
		
		// Récupérer dbInfo depuis l'objet véhicule (comme dans le code initial)
		private _var = _obj getVariable["dbInfo",[]];
		
		// Si dbInfo est vide, l'objet est peut-être un REMOTE non synchronisé - essayer de retrouver le véhicule par plaque
		if(count _var isEqualTo 0 && _plateParam != "") then {
			// Chercher le véhicule parmi tous les véhicules par plaque
			{
				private _vInfo = _x getVariable ["dbInfo", []];
				if (count _vInfo > 1) then {
					private _vPlateRaw = _vInfo select 1;
					// Convertir la plaque du véhicule en chaîne (même logique que plus bas)
					private _vPlate = if (_vPlateRaw isEqualType []) then {
						[_vPlateRaw] call ALF_Server_fnc_mresArray
					} else {
						private _vPlateStr = str _vPlateRaw;
						if ((_vPlateStr select [0,1]) == """") then {
							_vPlateStr select [1, count _vPlateStr - 2]
						} else {
							_vPlateStr
						}
					};
					// Comparer les plaques
					if (_vPlate == _plateParam) exitWith {
						_obj = _x;
						_var = _vInfo;
					};
				};
			} forEach vehicles;
			
			// Si toujours pas trouvé, essayer dans la liste du joueur
			if(count _var isEqualTo 0) then {
				private _playerKeys = missionNamespace getVariable [format["%1_KEYS",_playerUID],[]];
				if (count _playerKeys > 0 && _vehicleIndexSender >= 0 && _vehicleIndexSender < count _playerKeys) then {
					_obj = _playerKeys select _vehicleIndexSender;
					_var = _obj getVariable["dbInfo",[]];
				};
			};
		};
		
		if(count _var isEqualTo 0) exitWith {
			["Erreur", "Impossible de trouver les informations du véhicule. Transaction annulée.", "danger"] remoteExec ["ALF_fnc_doMsg", _player];
			["Erreur", "Impossible de trouver les informations du véhicule. Transaction annulée.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
		};
		
		private _plateRaw = _var select 1;
		private _name = getText(configFile >> "CfgVehicles" >> (typeOf _obj) >> "displayName");
		// mresArray ne doit être utilisé que si la plaque est un tableau, sinon utiliser directement la chaîne
		private _plate = if (_plateRaw isEqualType []) then {
			// Si c'est un tableau, utiliser mresArray
			[_plateRaw] call ALF_Server_fnc_mresArray
		} else {
			// Si c'est déjà une chaîne, enlever les guillemets éventuels
			private _plateStr = str _plateRaw;
			if ((_plateStr select [0,1]) isEqualTo """" && (_plateStr select [(count _plateStr)-1,1]) isEqualTo """") then {
				_plateStr select [1, (count _plateStr)-2]
			} else {
				_plateStr
			}
		};
		
		private _check = format["SELECT id FROM vehicles WHERE plate='%1'",_plate];
		private _result = [_check,2] call ALF_Server_fnc_asyncCall;
		if(count _result isEqualTo 0) exitWith {
			["Erreur", format["Véhicule non trouvé en base de données (plaque: %1). Transaction annulée.", _plate], "danger"] remoteExec ["ALF_fnc_doMsg", _player];
			["Erreur", "Véhicule non trouvé en base de données. Transaction annulée.", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
		};
		
		private _vid = _result select 0;
		
		// Récupérer l'UID de l'ancien propriétaire AVANT de modifier dbInfo (sauvegarder les valeurs originales)
		private _vinfo = _obj getVariable ["dbInfo",[]];
		private _oldOwnerUID = if (count _vinfo > 0) then {_vinfo select 0} else {""};
		private _oldVehicleInfoOwners = _obj getVariable ["vehicle_info_owners", []];
		
		private _type = switch(true) do {
			case (_obj isKindOf "Car"): {"Car"};
			case (_obj isKindOf "Air"): {"Air"};
			case (_obj isKindOf "Ship"): {"Ship"};
		};
		
		// Gérer le transfert en cash AVANT de modifier les clés (pour pouvoir annuler si pas assez d'argent)
		private _transactionCancelled = false;
		if (_amount > 0) then {
			// Récupérer le cash des deux joueurs depuis la base de données
			private _queryReceiver = format["SELECT playerid, cash FROM players WHERE playerid='%1'", _uid];
			private _resultReceiver = [_queryReceiver,2] call ALF_Server_fnc_asyncCall;
			
			private _queryGiver = format["SELECT playerid, cash FROM players WHERE playerid='%1'", _playerUID];
			private _resultGiver = [_queryGiver,2] call ALF_Server_fnc_asyncCall;
			
			if ((count _resultReceiver > 0) && (count _resultGiver > 0)) then {
				// Récupérer le cash (peut être un nombre ou une string)
				private _cashReceiverRaw = _resultReceiver select 1;
				private _cashGiverRaw = _resultGiver select 1;
				
				private _cashReceiver = if (_cashReceiverRaw isEqualType "") then {parseNumber _cashReceiverRaw} else {_cashReceiverRaw};
				private _cashGiver = if (_cashGiverRaw isEqualType "") then {parseNumber _cashGiverRaw} else {_cashGiverRaw};
				
				// Vérifier que le receveur a assez d'argent
				if (_cashReceiver < _amount) then {
					["Erreur", format["Transaction annulée: %1 n'a pas assez d'argent en cash", name _unit], "danger"] remoteExec ["ALF_fnc_doMsg", _player];
					["Erreur", format["Transaction annulée: Vous n'avez pas assez d'argent en cash (%1€ requis)", _amount], "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
					_transactionCancelled = true; // Marquer la transaction comme annulée
				} else {
					// Effectuer le transfert - Débiter le cash du receveur
					private _newCashReceiver = _cashReceiver - _amount;
					private _updateReceiver = format["UPDATE players SET cash='%1' WHERE playerid='%2'", _newCashReceiver, _uid];
					[_updateReceiver,1] call ALF_Server_fnc_asyncCall;
					
					// Créditer le cash du donneur
					private _newCashGiver = _cashGiver + _amount;
					private _updateGiver = format["UPDATE players SET cash='%1' WHERE playerid='%2'", _newCashGiver, _playerUID];
					[_updateGiver,1] call ALF_Server_fnc_asyncCall;
					
					// Mettre à jour le cash côté client (comme dans fn_payEntreprise ligne 42-43)
					// Le receveur perd de l'argent - modifier life_cash et synchroniser avec BDD
					[-_amount] remoteExec ["ALF_fnc_updateCashClient", _unit];
					// Le donneur gagne de l'argent - modifier life_cash et synchroniser avec BDD
					[_amount] remoteExec ["ALF_fnc_updateCashClient", _player];
					
					// Notifier les clients du changement de cash (via message avec montant)
					["INFO", format["Vous avez reçu %1€ en cash", _amount], "success"] remoteExec ["ALF_fnc_doMsg", _player];
					["INFO", format["Vous avez payé %1€ en cash", _amount], "success"] remoteExec ["ALF_fnc_doMsg", _unit];
					
					// Logs de transaction
					[name _player, _playerUID, "CASH", format["Transaction clé véhicule: +%1€ en cash (solde: %2€)", _amount, _newCashGiver]] spawn ALF_Server_fnc_logIt;
					[name _unit, _uid, "CASH", format["Transaction clé véhicule: -%1€ en cash (solde: %2€)", _amount, _newCashReceiver]] spawn ALF_Server_fnc_logIt;
				};
			} else {
				["Erreur", "Transaction annulée: Joueur introuvable", "danger"] remoteExec ["ALF_fnc_doMsg", _player];
				["Erreur", "Transaction annulée: Joueur introuvable", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
				_transactionCancelled = true; // Marquer la transaction comme annulée
			};
		};
		
		// Si la transaction bancaire a été annulée, sortir de la fonction
		if (_transactionCancelled) exitWith {
			// Restaurer les valeurs originales de dbInfo et vehicle_info_owners
			if (_oldOwnerUID != "") then {
				private _vinfoRestored = +_vinfo;
				_vinfoRestored set[0,_oldOwnerUID];
				_obj setVariable ["dbInfo",_vinfoRestored];
				_obj setVariable ["vehicle_info_owners",_oldVehicleInfoOwners,true];
			};
		};
		
		// Modifier dbInfo et vehicle_info_owners UNIQUEMENT si la transaction est validée
		_obj setVariable ["vehicle_info_owners",["",(getPlayerUID _unit)],true];
		_vinfo set[0,_uid];
		_obj setVariable ["dbInfo",_vinfo];
		
		private _updateVehicle = format["UPDATE vehicles SET pid='%1', type='%3', insure='0', insurecount='0' WHERE id='%2'",_uid,_vid,_type];
		[_updateVehicle,1] call ALF_Server_fnc_asyncCall;
		
		// Supprimer les clés temporaires de l'ancien et nouveau propriétaire
		private _deleteKeysTime = format["DELETE FROM keysTime WHERE mode='0' AND idobj='%1'",_vid];
		[_deleteKeysTime,1] call ALF_Server_fnc_asyncCall;
		
		// Supprimer les clés permanentes de l'ancien propriétaire
		if (_oldOwnerUID != "" && _oldOwnerUID != _uid) then {
			private _deleteKeysPerm = format["DELETE FROM keysPerm WHERE pid='%1' AND mode='0' AND idobj='%2'",_oldOwnerUID,_vid];
			[_deleteKeysPerm,1] call ALF_Server_fnc_asyncCall;
		};
		
		// Vérifier si le nouveau propriétaire a déjà une clé permanente
		private _checkKey = format["SELECT COUNT(*) FROM keysPerm WHERE pid='%1' AND mode='0' AND idobj='%2'",_uid,_vid];
		private _keyExistsResult = [_checkKey,2] call ALF_Server_fnc_asyncCall;
		private _keyExists = if (count _keyExistsResult > 0) then {
			private _val = _keyExistsResult select 0;
			if (_val isEqualType "") then {parseNumber _val} else {_val}
		} else {0};
		
		// Ajouter les clés permanentes au nouveau propriétaire
		if (_keyExists isEqualTo 0) then {
			private _insertKeysPerm = format["INSERT INTO keysPerm (pid, mode, idobj) VALUES('%1','0','%2')", _uid, _vid];
			[_insertKeysPerm,1] call ALF_Server_fnc_asyncCall;
		};
		
		[name _player,getPlayerUID _player,"VEHICULE",format["vient de donner le véhicule %1 (%4) à %2 (%3).",_vid,name _unit,getPlayerUID _unit, typeOf _obj]] spawn ALF_Server_fnc_logIt;
		[name _unit,getPlayerUID _unit,"VEHICULE",format["vient de recevoir le véhicule %1 (%4) de %2 (%3).",_vid,name _player,getPlayerUID _player, typeOf _obj]] spawn ALF_Server_fnc_logIt;

		// Mettre à jour la variable serveur des clés
		[_uid,_obj,1] call ALF_Server_fnc_keyManagement;
		
		// Retirer les clés de l'ancien propriétaire dans la variable serveur
		if (_oldOwnerUID != "" && _oldOwnerUID != _uid) then {
			private _oldOwnerKeys = missionNamespace getVariable [format["%1_KEYS",_oldOwnerUID],[]];
			_oldOwnerKeys = _oldOwnerKeys - [_obj];
			missionNamespace setVariable[format["%1_KEYS",_oldOwnerUID],_oldOwnerKeys];
		};
		
		[_obj,_unit] remoteExecCall ["TON_fnc_clientGetKey",_unit];
		
		// Retirer le véhicule de la liste du donneur APRÈS confirmation serveur
		if (_vehicleIndexSender >= 0) then {
			[_vehicleIndexSender] remoteExec ["ALF_fnc_keyGiveDefRemoveVehicle", _player];
		};
		
		// Notifier les deux joueurs
		private _amountText = if (_amount > 0) then {format["%1€", _amount]} else {"0€"};
		["INFO", format["Transaction réussie. Les clés de %1 ont été transférées à %2.", _name, name _unit], "success"] remoteExec ["ALF_fnc_doMsg", _player];
		["INFO", format["Vous avez reçu définitivement les clés de : %1.", _name], "success"] remoteExec ["ALF_fnc_doMsg", _unit];
	};
	case 1 : {
		private _hid = _obj getVariable ["house_id",-1];
		if(_hid isEqualTo -1) exitWith {};
		
		// Vérifier le statut donateur pour la limite de maisons
		private _donorQuery = format["SELECT isPremium FROM players WHERE playerid='%1'",_uid];
		private _donorResult = [_donorQuery,2] call ALF_Server_fnc_asyncCall;
		private _isDonor = if (count _donorResult > 0) then {
			private _val = _donorResult select 0;
			if (_val isEqualType "") then {parseNumber _val} else {_val}
		} else {0};
		private _houseLimit = if (_isDonor > 0) then {6} else {4};

		private _query = format["SELECT * FROM houses WHERE pid='%1'",_uid];
		private _queryResult = [_query,2] call ALF_Server_fnc_asyncCall;
		if (count(_queryResult) >= _houseLimit) exitWith {["Maison","Cette personne a déjà le nombre maximum de bien.","success"] remoteExec ["ALF_fnc_doMsg",_player];};
		
		// Gérer le transfert en cash AVANT de modifier les clés (pour pouvoir annuler si pas assez d'argent)
		private _transactionCancelled = false;
		if (_amount > 0) then {
			// Récupérer le cash des deux joueurs depuis la base de données
			private _queryReceiver = format["SELECT playerid, cash FROM players WHERE playerid='%1'", _uid];
			private _resultReceiver = [_queryReceiver,2] call ALF_Server_fnc_asyncCall;
			
			private _queryGiver = format["SELECT playerid, cash FROM players WHERE playerid='%1'", _playerUID];
			private _resultGiver = [_queryGiver,2] call ALF_Server_fnc_asyncCall;
			
			if ((count _resultReceiver > 0) && (count _resultGiver > 0)) then {
				// Récupérer le cash (peut être un nombre ou une string)
				private _cashReceiverRaw = _resultReceiver select 1;
				private _cashGiverRaw = _resultGiver select 1;
				
				private _cashReceiver = if (_cashReceiverRaw isEqualType "") then {parseNumber _cashReceiverRaw} else {_cashReceiverRaw};
				private _cashGiver = if (_cashGiverRaw isEqualType "") then {parseNumber _cashGiverRaw} else {_cashGiverRaw};
				
				// Vérifier que le receveur a assez d'argent
				if (_cashReceiver < _amount) then {
					["Erreur", format["Transaction annulée: %1 n'a pas assez d'argent en cash", name _unit], "danger"] remoteExec ["ALF_fnc_doMsg", _player];
					["Erreur", format["Transaction annulée: Vous n'avez pas assez d'argent en cash (%1€ requis)", _amount], "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
					_transactionCancelled = true; // Marquer la transaction comme annulée
				} else {
					// Effectuer le transfert - Débiter le cash du receveur
					private _newCashReceiver = _cashReceiver - _amount;
					private _updateReceiver = format["UPDATE players SET cash='%1' WHERE playerid='%2'", _newCashReceiver, _uid];
					[_updateReceiver,1] call ALF_Server_fnc_asyncCall;
					
					// Créditer le cash du donneur
					private _newCashGiver = _cashGiver + _amount;
					private _updateGiver = format["UPDATE players SET cash='%1' WHERE playerid='%2'", _newCashGiver, _playerUID];
					[_updateGiver,1] call ALF_Server_fnc_asyncCall;
					
					// Mettre à jour le cash côté client
					// Le receveur perd de l'argent - modifier life_cash et synchroniser avec BDD
					[-_amount] remoteExec ["ALF_fnc_updateCashClient", _unit];
					// Le donneur gagne de l'argent - modifier life_cash et synchroniser avec BDD
					[_amount] remoteExec ["ALF_fnc_updateCashClient", _player];
					
					// Notifier les clients du changement de cash
					["INFO", format["Vous avez reçu %1€ en cash", _amount], "success"] remoteExec ["ALF_fnc_doMsg", _player];
					["INFO", format["Vous avez payé %1€ en cash", _amount], "success"] remoteExec ["ALF_fnc_doMsg", _unit];
					
					// Logs de transaction
					[name _player, _playerUID, "CASH", format["Transaction clé maison: +%1€ en cash (solde: %2€)", _amount, _newCashGiver]] spawn ALF_Server_fnc_logIt;
					[name _unit, _uid, "CASH", format["Transaction clé maison: -%1€ en cash (solde: %2€)", _amount, _newCashReceiver]] spawn ALF_Server_fnc_logIt;
				};
			} else {
				["Erreur", "Transaction annulée: Joueur introuvable", "danger"] remoteExec ["ALF_fnc_doMsg", _player];
				["Erreur", "Transaction annulée: Joueur introuvable", "danger"] remoteExec ["ALF_fnc_doMsg", _unit];
				_transactionCancelled = true; // Marquer la transaction comme annulée
			};
		};
		
		// Si la transaction bancaire a été annulée, sortir de la fonction
		if (_transactionCancelled) exitWith {};
		
		// Modifier le propriétaire de la maison UNIQUEMENT si la transaction est validée
		_query = format["UPDATE houses SET pid='%1' WHERE id='%2'",_uid,_hid];
		[_query,1] call ALF_Server_fnc_asyncCall;

		[_obj,_unit] remoteExecCall ["TON_fnc_clientGetKey",_unit];

		// Retirer la maison de la liste du donneur APRÈS confirmation serveur
		if (_vehicleIndexSender >= 0) then {
			[_vehicleIndexSender] remoteExec ["ALF_fnc_keyGiveDefRemoveHouse", _player];
		};

		// Notifier les deux joueurs
		private _name = getText(configFile >> "CfgVehicles" >> (typeOf _obj) >> "displayName");
		if (_name isEqualTo "") then {
			_name = "Bien immobilier";
		};
		
		private _amountText = if (_amount > 0) then {format["%1€", _amount]} else {"0€"};
		["Maison", format["Vous avez reçu définitivement les clés du logement : %1. Vos papiers seront finalisés après la tempête.", _name],"success"] remoteExec ["ALF_fnc_doMsg",_unit];
		["Maison", format["Vous avez donné définitivement les clés du logement : %1. Vos papiers seront finalisés après la tempête.", _name],"success"] remoteExec ["ALF_fnc_doMsg",_player];
		
		// Logs
		[name _player, _playerUID, "MAISON", format["vient de donner le bien %1 (%2) à %3 (%4).", _hid, typeOf _obj, name _unit, _uid]] spawn ALF_Server_fnc_logIt;
		[name _unit, _uid, "MAISON", format["vient de recevoir le bien %1 (%2) de %3 (%4).", _hid, typeOf _obj, name _player, _playerUID]] spawn ALF_Server_fnc_logIt;
	};
};

