/*
// ALF_fnc_keyGiveDef = {
disableSerialization;

_dialog = findDisplay 123450;
_list = _dialog displayCtrl 123457;

_sel = lbCurSel _list;
if ((_list lbData _sel) isEqualTo "") exitWith {hint localize "STR_NOTF_didNotSelectVehicle";};
_index = (parseNumber(_list lbData _sel));
_vehicle = life_vehicles select _index;
['_vehicle ' + str(_vehicle)] remoteExec ['systemchat',0];
_unit = cursorObject;
if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {};
if (_unit isEqualTo player) exitWith {};
if !(_unit isKindOf "Man") exitWith {};
if (!isPlayer _unit) exitWith {};
if (!alive _unit) exitWith {};

if (typeOf(_vehicle) isEqualTo "V_ALF_Camion_MRPV2") exitWith {["Erreur","Vous ne pouvez pas donner un véhicule de service.","warning"] spawn ALF_fnc_doMsg;};

if !(_vehicle isKindOf "House") then {
	if ((_vehicle getVariable ["business_veh",""]) isEqualTo "") then {

		private _owners = (_vehicle getVariable ["vehicle_info_owners",["",""]]) # 1;
		if (((getPlayerUID player) isEqualTo _owners)) exitWith {["Erreur", "Vous n'êtes pas le propriétaire du vehicule.", "warning"] spawn ALF_fnc_doMsg;};

		private _name = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");

		private _action = [format["Etes-vous certain de vouloir donner definitivement le %1 ?",_name],"Vehicule","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {["INFO","Annulation..","warning"] spawn ALF_fnc_doMsg;};

		life_vehicles deleteAt _index;
		closeDialog 0;

		["INFO", format["Vous venez de donner définitivement les clés de : %1",_name],"success"] spawn ALF_fnc_doMsg;

		[0,_vehicle,_unit,player] remoteExec ["ALF_Server_fnc_keyGiveDef",2];
		["INFO", format["On t'a donné définitivement les clés de : %1",_name], "success"] remoteExec ["ALF_fnc_doMsg",_unit];
	} else {
		if ((b_1 || b_13 || b_33 || b_15) && ((player getVariable ["isEmployed",""]) isEqualTo ((_vehicle getVariable ["business_veh",""]) select 0))) then {
			private _name = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
			if (b_15 && !(typeOf _vehicle in ["V_ALF_Havok","V_ALF_EC145","V_ALF_PW207"])) exitWith {
				["INFO","Vous pouvez vendre uniquement des véhicules aérien","warning"] spawn ALF_fnc_doMsg;
			};
			private _action = [format["Etes-vous certain de vouloir donner definitivement le %1 ?",_name],"Vehicule","OUI","NON"] call BIS_fnc_guiMessage;
			if (!_action) exitWith {["INFO","Annulation..","warning"] spawn ALF_fnc_doMsg;};

			life_vehicles deleteAt _index;
			closeDialog 0;

			["INFO", format["Vous venez de donner définitivement les clés de : %1",_name],"success"] spawn ALF_fnc_doMsg;

			[0,_vehicle,_unit,player] remoteExec ["ALF_Server_fnc_keyGiveDef",2];
			["INFO", format["On t'a donné définitivement les clés de : %1",_name], "success"] remoteExec ["ALF_fnc_doMsg",_unit];
		} else {
			["Erreur","Impossible de donner ce véhicule d'entreprise.","warning"] spawn ALF_fnc_doMsg;
		};
	};
} else {
	_index = life_houses find (str(getPosATL _vehicle));
	if (_index isEqualTo -1) exitWith {["ERREUR","Vous n'êtes pas le propriétaire de ce bien.","warning"] spawn ALF_fnc_doMsg;};

	private _action = ["Etes-vous certain de vouloir donner definitivement ce bien ?","Bien","OUI","NON"] call BIS_fnc_guiMessage;
	if (!_action) exitWith {["INFO","Annulation..","warning"] spawn ALF_fnc_doMsg;};
	
	life_houses deleteAt _index;
	
	[1,_vehicle,_unit,player] remoteExec ["ALF_Server_fnc_keyGiveDef",2];
};
// };

*/




// ALF_fnc_keyGiveDef = {
disableSerialization;

_dialog = findDisplay 123450;
_list = _dialog displayCtrl 123457;

_sel = lbCurSel _list;
if ((_list lbData _sel) isEqualTo "") exitWith {hint localize "STR_NOTF_didNotSelectVehicle";};
_index = (parseNumber(_list lbData _sel));
_vehicle = life_vehicles select _index;

// Utiliser la personne visée depuis le menu d'interaction si disponible, sinon utiliser cursorObject
_unit = if (!isNil "ALF_Interaction_Target_Unit" && {!isNull ALF_Interaction_Target_Unit}) then {
    ALF_Interaction_Target_Unit
} else {
    cursorObject
};

if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {};
if (_unit isEqualTo player) exitWith {};
if !(_unit isKindOf "Man") exitWith {};
if (!isPlayer _unit) exitWith {};
if (!alive _unit) exitWith {};

// Vérification : Les membres b_33 peuvent donner à n'importe qui
// Les joueurs non-b_33 ne peuvent donner qu'aux membres b_33
if (!b_33) then {
	private _receiverB33 = _unit getVariable ["b_33", false];
	if (!_receiverB33) exitWith {
		["Erreur", "Vous ne pouvez donner définitivement les clés qu'à des membres de TropicAuto.", "warning"] spawn ALF_fnc_doMsg;
	};
};
// Si le donneur est b_33, aucune restriction (peut donner à n'importe qui)

if (typeOf(_vehicle) isEqualTo "V_ALF_Camion_MRPV2") exitWith {["Erreur","Vous ne pouvez pas donner un véhicule de service.","warning"] spawn ALF_fnc_doMsg;};

if !(_vehicle isKindOf "House") then {
	if ((_vehicle getVariable ["business_veh",""]) isEqualTo "") then {

		private _vehicleInfoOwners = _vehicle getVariable ["vehicle_info_owners",["",""]];
		
		private _owners = _vehicleInfoOwners # 1;
		private _playerUID = getPlayerUID player;		
		
		if (!((getPlayerUID player) isEqualTo _owners)) exitWith {
			["Erreur", "Vous n'êtes pas le propriétaire du vehicule.", "warning"] spawn ALF_fnc_doMsg;
		};
		
		private _name = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");

		private _action = [format["Etes-vous certain de vouloir donner definitivement le %1 ?",_name],"Vehicule","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {["INFO","Annulation..","warning"] spawn ALF_fnc_doMsg;};

		// Ouvrir le dialog pour saisir le montant (système de facture)
		closeDialog 0;
		uiNamespace setVariable ["ALF_KeyGiveBill_Vehicle", _vehicle];
		uiNamespace setVariable ["ALF_KeyGiveBill_Unit", _unit];
		uiNamespace setVariable ["ALF_KeyGiveBill_Index", _index];
		
		if (!createDialog "Life_keyGiveBill") exitWith {
			["INFO", "Impossible d'ouvrir le menu de facture.", "warning"] spawn ALF_fnc_doMsg;
		};
		
		disableSerialization;
		private _display = findDisplay 3755;
		if (!isNull _display) then {
			private _titleCtrl = _display displayCtrl 3756;
			_titleCtrl ctrlSetText format["Montant du transfert à %1", name _unit];
		};
	} else {
		if ((b_1 || b_13 || b_33 || b_15) && ((player getVariable ["isEmployed",""]) isEqualTo ((_vehicle getVariable ["business_veh",""]) select 0))) then {
			private _name = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
			if (b_15 && !(typeOf _vehicle in ["V_ALF_Havok","V_ALF_EC145","V_ALF_PW207"])) exitWith {
				["INFO","Vous pouvez vendre uniquement des véhicules aérien","warning"] spawn ALF_fnc_doMsg;
			};
			private _action = [format["Etes-vous certain de vouloir donner definitivement le %1 ?",_name],"Vehicule","OUI","NON"] call BIS_fnc_guiMessage;
			if (!_action) exitWith {["INFO","Annulation..","warning"] spawn ALF_fnc_doMsg;};

			life_vehicles deleteAt _index;
			closeDialog 0;

			["INFO", format["Vous venez de donner définitivement les clés de : %1",_name],"success"] spawn ALF_fnc_doMsg;

			[0,_vehicle,_unit,player] remoteExec ["ALF_Server_fnc_keyGiveDef",2];
			["INFO", format["On t'a donné définitivement les clés de : %1",_name], "success"] remoteExec ["ALF_fnc_doMsg",_unit];
		
			// Nettoyer la variable d'interaction si elle existe
			if (!isNil "ALF_Interaction_Target_Unit") then {
				ALF_Interaction_Target_Unit = nil;
			};

		} else {
			["Erreur","Impossible de donner ce véhicule d'entreprise.","warning"] spawn ALF_fnc_doMsg;

			// Nettoyer la variable d'interaction si elle existe
			if (!isNil "ALF_Interaction_Target_Unit") then {
				ALF_Interaction_Target_Unit = nil;
			};

		};
	};
} else {
	_index = life_houses find (str(getPosATL _vehicle));
	if (_index isEqualTo -1) exitWith {["ERREUR","Vous n'êtes pas le propriétaire de ce bien.","warning"] spawn ALF_fnc_doMsg;};

	// Ouvrir le dialog pour saisir le montant (système de facture)
	closeDialog 0;
	uiNamespace setVariable ["ALF_KeyGiveBill_Vehicle", _vehicle];
	uiNamespace setVariable ["ALF_KeyGiveBill_Unit", _unit];
	uiNamespace setVariable ["ALF_KeyGiveBill_Index", _index];
	uiNamespace setVariable ["ALF_KeyGiveBill_IsHouse", true]; // Marquer que c'est une maison
	
	if (!createDialog "Life_keyGiveBill") exitWith {
		["INFO", "Impossible d'ouvrir le menu de facture.", "warning"] spawn ALF_fnc_doMsg;
	};
	
	disableSerialization;
	private _display = findDisplay 3755;
	if (!isNull _display) then {
		private _titleCtrl = _display displayCtrl 3756;
		_titleCtrl ctrlSetText format["Montant du transfert à %1", name _unit];
	};

};
// };
