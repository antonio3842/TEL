/*
	File: fn_callSystem.sqf
	Author: ALF Team
	Input : ALF_Phone_Anonyme,ALF_Phone_Number,_numbercalling,player
	Call_info = 0 - reset / 1 - trycall / 2 - en appel
*/
params [
	["_Anonyme",false,[false]],
	["_playerNumber","",[""]],
	["_cibleNumber","",[""]],
	["_unit",objNull,[objNull]],
	["_cibleUnit",objNull,[objNull]]
];

if(_playerNumber isEqualTo "" OR {_cibleNumber isEqualTo ""} OR {isNull _unit}) exitWith {};

private _fnc_normPhone = {
	params ["_n"];
	if (!(_n isEqualType "")) then { _n = str _n; };
	_n regexReplace [" ", ""]
};

_playerNumber = [_playerNumber] call _fnc_normPhone;
_cibleNumber = [_cibleNumber] call _fnc_normPhone;

[format["INSERT INTO tel_appel (anonyme, expediteur, destinataire, position) VALUES('%1','%2','%3','%4')",parseNumber(_Anonyme),_playerNumber,_cibleNumber,str(getPos _unit)],1] call ALF_Server_fnc_asyncCall;

//CENTRAL D'APPEL
if(_cibleNumber isEqualTo "17") exitWith {
	private _cops = playableUnits select {_x getVariable ["CopService",false]};
	if !(_cops isEqualTo []) then {
	if(_Anonyme) then {
			["Central de la Gendarmerie.","Un numéro anonyme tente de joindre la Gendarmerie. Merci de bien vouloir vous connecter au central."] remoteExec ["ALF_fnc_doCopCall",_cops];
		} else {
			["Central de la Gendarmerie.",format["Le numéro %1 tente de joindre la Gendarmerie. Merci de bien vouloir vous connecter au central.",_playerNumber]] remoteExec ["ALF_fnc_doCopCall",_cops];
		};

	};
	[_unit,_playerNumber,_Anonyme,_cibleNumber] spawn ALF_Server_fnc_centralSystem;
};
if(_cibleNumber isEqualTo "18") exitWith {
	private _meds = playableUnits select {_x getVariable ["MedService",false]};
	if !(_meds isEqualTo []) then {
		if(_Anonyme) then {
			["Central des Pompiers.","Un numéro anonyme tente de joindre les Pompiers. Merci de bien vouloir vous connecter au central."] remoteExec ["ALF_fnc_doMedCall",_meds];
		} else {
			["Central des Pompiers.",format["Le numéro %1 tente de joindre les Pompiers. Merci de bien vouloir vous connecter au central.",_playerNumber]] remoteExec ["ALF_fnc_doMedCall",_meds];
		};
	};
	[_unit,_playerNumber,_Anonyme,_cibleNumber] spawn ALF_Server_fnc_centralSystem;
};
if(_cibleNumber isEqualTo "21") exitWith {
	private _pm = playableUnits select {_x getVariable ["PenitService",false]};
	if !(_pm isEqualTo []) then {
		if(_Anonyme) then {
			//["Central de la Police Municipale.","Un numéro anonyme tente de joindre les PM. Merci de bien vouloir vous connecter au central.", "warning"] remoteExec ["ALF_Server_fnc_doPenitCall",HC_Life];
			["Central de la Police Municipale.","Un numéro anonyme tente de joindre les PM. Merci de bien vouloir vous connecter au central.", "warning"] remoteExec ["ALF_fnc_doMsg",_pm];
		} else {
			//["Central de la Police Municipale.",format["Le numéro %1 tente de joindre les PM. Merci de bien vouloir vous connecter au central.",_playerNumber], "warning"] remoteExec ["ALF_Server_fnc_doPenitCall",HC_Life];
			["Central de la Police Municipale.",format["Le numéro %1 tente de joindre les PM. Merci de bien vouloir vous connecter au central.",_playerNumber], "warning"] remoteExec ["ALF_fnc_doMsg",_pm]; 
		};
	};
	[_unit,_playerNumber,_Anonyme,_cibleNumber] spawn ALF_Server_fnc_centralSystem;
};
if(_cibleNumber isEqualTo "124") exitWith {
	/*private _meds = playableUnits select {_x getVariable ["MedService",false]};
	if !(_meds isEqualTo []) then {
		if(_Anonyme) then {
			["Central depanneur.","Un numéro anonyme tente de joindre les Depanneurs. Merci de bien vouloir vous connecter au central."] remoteExec ["ALF_fnc_doMedCall",_meds];
		} else {
			["Central depanneur.",format["Le numéro %1 tente de joindre les Depanneurs. Merci de bien vouloir vous connecter au central.",_playerNumber]] remoteExec ["ALF_fnc_doMedCall",_meds];
		};
	};
	*/
	[_unit,_playerNumber,_Anonyme,_cibleNumber] spawn ALF_Server_fnc_centralSystem;
};

//On cherche le joueur qu'on appel (ou cible directe pour appel taxi)
private _cible = if (!isNull _cibleUnit && {alive _cibleUnit}) then {
	_cibleUnit
} else {
	playableUnits param [playableUnits findIf {
		([_x getVariable ["phoneNumber", ""]] call _fnc_normPhone) isEqualTo _cibleNumber
	}, objNull]
};
if (isNull _cible) exitWith {};

//On vérifie si la personne est capable de recevoir un appel (sauf cible directe taxi).
if (isNull _cibleUnit && {!(_cible getVariable ["call_info", 0] isEqualTo 0)}) exitWith {};

//On parametre les variables
_unit setVariable ["call_info",2]; //Lancement de l'appel
_cible setVariable ["call_info",1]; //Recoit l'appel

//On envoit l'appel a la cible.
[_Anonyme,_playerNumber] remoteExec ["ALF_fnc_ringPlayer",_cible];

for "_i" from 0 to 1 step 0 do {
	if(isNull _unit OR {isNull _cible}) exitWith {};
	if(_unit getVariable ["call_info",0] isEqualTo 0) exitWith {};
	if(_cible getVariable ["call_info",0] isEqualTo 0) exitWith {};
	if((_cible getVariable ["call_info",0]) isEqualTo (_unit getVariable ["call_info",0])) exitWith {
		//On lance l'appel
		[_unit,_cible] spawn ALF_Server_fnc_inCallSystem;
	};
	// OPTIMISE: 0.1s au lieu de 0.01s (10 checks/s au lieu de 100 - suffisant pour un appel telephonique)
	uiSleep 0.1;
};
