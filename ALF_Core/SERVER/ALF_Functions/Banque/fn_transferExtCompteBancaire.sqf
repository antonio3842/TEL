#include "\ALF_Core\SERVER\script_macros.hpp"
/*
	File: fn_transferExtCompteBancaire.sqf
	Author: ALF Team

	This file is for Nanou's HeadlessClient.

	Description:
	Procedure MySQL pour le transfert externe d'un compte bancaire.

*/
private["_uidcible","_xuid","_lcactive","_livretc","_lbactive","_livretb","_livreta","_numacc","_mode","_number","_raison","_query","_result","_unit","_myuid","_unitcible","_exit","_isSiret","_siret","_businessResult","_capital","_businessName"];
_numacc = _this select 0;
_mode = _this select 1;
_unit = _this select 2;
_number = _this select 3;
_myuid = _this select 4;
_isSiret = if (count _this > 5) then {_this select 5} else {false};
_exit = false;
_raison = 0;

// Si c'est un SIRET, chercher dans la table business
if (_isSiret) then {
	_siret = _numacc;
	_query = format["SELECT name, capital FROM business WHERE siret='%1' AND active='1'",_siret];
	_businessResult = [_query,2] call ALF_Server_fnc_asyncCall;
	
	if (!(_businessResult isEqualType []) || {count _businessResult == 0}) then {
		_exit = true;
		_raison = 0; // Entreprise introuvable
	} else {
		// Avec _multiarr=false (défaut), extDB3 retourne directement ["nom", "capital"] et non [["nom", "capital"]]
		// Vérifier si c'est un tableau de tableaux ou un tableau direct
		private _row = if ((_businessResult select 0) isEqualType []) then {
			// C'est [["nom", "capital"]]
			_businessResult select 0
		} else {
			// C'est directement ["nom", "capital"]
			_businessResult
		};
		
		if (count _row >= 2) then {
			_businessName = _row select 0;
			// Le capital peut être une chaîne ou un nombre selon la base de données
			private _capitalRaw = _row select 1;
			_capital = if (_capitalRaw isEqualType "") then {
				parseNumber _capitalRaw
			} else {
				_capitalRaw
			};
			
			// Créditer le capital de l'entreprise
			_capital = _capital + _number;
			[_siret, _capital] call ALF_Server_fnc_capitalBusiness;
			
			// Confirmer le virement
			[_siret,_mode,_number,true,_businessName] remoteExecCall ["ALF_fnc_afterTransferCompteBancaire",_unit];
		} else {
			_exit = true;
			_raison = 0;
		};
	};
} else {
	// Comportement normal pour un numéro de compte bancaire
	_query = format["SELECT playerid, livreta, livretb, lbactive, livretc, lcactive FROM bank WHERE numacc='%1'",_numacc];
	_result = [_query,2] call ALF_Server_fnc_asyncCall;

	if ((count _result) > 0) then {

		_uidcible = _result select 0;
		_livreta = _result select 1;
		_livretb = _result select 2;
		_lbactive = _result select 3;
		_livretc = _result select 4;
		_lcactive = _result select 5;

		switch (_mode) do {
			case 0 : {
				if (_uidcible isEqualTo _myuid) exitWith {_exit = true; _raison = 1;};
				if ((_livreta + _number) > 75000) exitWith {_exit = true; _raison = 4;};
				_livreta = _livreta + _number;
				[format["UPDATE bank SET livreta='%1' WHERE playerid='%2'",_livreta,_uidcible],1] call ALF_Server_fnc_asyncCall;
				[_numacc,_mode,_number,false,""] remoteExecCall ["ALF_fnc_afterTransferCompteBancaire",_unit];
			};
			case 1 : {
				if (_uidcible isEqualTo _myuid) exitWith {_exit = true; _raison = 1;};
				if (_lbactive isEqualTo 0) exitWith {_exit = true; _raison = 2;};
				if ((_livretb + _number) > 500000) exitWith {_exit = true; _raison = 5;};
				_livretb = _livretb + _number;
				[format["UPDATE bank SET livretb='%1' WHERE playerid='%2'",_livretb,_uidcible],1] call ALF_Server_fnc_asyncCall;
				[_numacc,_mode,_number,false,""] remoteExecCall ["ALF_fnc_afterTransferCompteBancaire",_unit];
			};
			case 2 : {
				if (_uidcible isEqualTo _myuid) exitWith {_exit = true; _raison = 1;};
				if (_lcactive isEqualTo 0) exitWith {_exit = true; _raison = 3;};
				_livretc = _livretc + _number;
				[format["UPDATE bank SET livretc='%1' WHERE playerid='%2'",_livretc,_uidcible],1] call ALF_Server_fnc_asyncCall;
				[_numacc,_mode,_number,false,""] remoteExecCall ["ALF_fnc_afterTransferCompteBancaire",_unit];
			};
		};
		
		// Notification au joueur cible si connecté
		if (!_exit) then {
			_exit = false;
			_uidcible = _result select 0;
			{
				_xuid = getPlayerUID _x;
				if (_xuid isEqualTo _uidcible) exitWith {
				  _unitcible = _x;
				  _exit = true;
				};
			} forEach playableUnits;
			if (_exit) then {
				_ciblenumberacc = ([format["SELECT numacc FROM bank WHERE playerid='%1'",_myuid],2] call ALF_Server_fnc_asyncCall) select 0;
				[_number,_ciblenumberacc,_mode] remoteExecCall ["ALF_fnc_infoTransferCompteBancaire",_unitcible];
			};
		};
	} else {
		_exit = true;
	};
};

if (_exit) exitWith { [_raison] remoteExecCall ["ALF_fnc_badTransferCompteBancaire",_unit];	};
