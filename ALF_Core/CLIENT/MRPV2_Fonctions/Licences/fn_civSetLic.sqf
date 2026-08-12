/*
	File: fn_civSetLic.sqf
	Author: GrosPandaGéant
*/
//MRPV2_fnc_civSetLic = {

private _mode = _this select 0;
private _player = _this select 1;
private _msg = "";
private _msgLog = "";
private _msgDonor = "";
private _name = name player;
private _uid = getPlayerUID player;

private _varnameConfig = ["STRING", ["Licenses", _mode, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
private _level = missionNamespace getVariable [format["license_%1",_varnameConfig], false];

if(_level) exitWith {["INFO","Cette personne a déjà cette licence.", "success"] remoteExec ["ALF_fnc_doMsg",_player];};

switch (_mode) do {
	case "Trucking" : {
		license_trucking = true;
		_msg = "Vous avez obtenu le permis camion.";
		_msgDonor = "Vous avez délivrer le permis camion à cette personne.";
		_msgLog = format["A donner le permis camion a %1 (%2)",_name, _uid];
	}; 
	case "NOTrucking" : {
		license_trucking = false;
		_msg = "Vous avez perdu le permis camion.";
		_msgDonor = "Vous avez retiré le permis camion à cette personne.";
		_msgLog = format["A retirer le permis camion a %1 (%2)",_name, _uid];
	};
	case "Pilot" : {
		license_pilot = true;
		_msg = "Vous avez obtenu la licence de pilote.";
		_msgDonor = "Vous avez délivrer la licence de pilote à cette personne.";
		_msgLog = format["A donner la licence de pilote a %1 (%2)",_name, _uid];
	};
	case "NOPilot" : {
		license_pilot = false;
		_msg = "Vous avez perdu la licence de pilote.";
		_msgDonor = "Vous avez retiré la licence de pilote à cette personne.";
		_msgLog = format["A retirer la licence de pilote a %1 (%2)",_name, _uid];
	};
	case "Gun" : {
		license_gun = true;
		_msg = "Vous avez obtenu le permis de port d'armes.";
		_msgDonor = "Vous avez délivrer le permis de port d'armes à cette personne.";
		_msgLog = format["A donner le permis de port d'armes a %1 (%2)",_name, _uid];
	};
	case "NOGun" : {
		license_gun = false;
		_msg = "Vous avez perdu le permis de port d'armes.";
		_msgDonor = "Vous avez retiré le permis de port d'armes à cette personne.";
		_msgLog = format["A retirer le permis de port d'armes a %1 (%2)",_name, _uid];
	};
};

[1] call SOCK_fnc_updatePartial;

// LOG
[name _player, getPlayerUID _player, "LICENCE", _msgLog] remoteExec ["ALF_Server_fnc_logIt",2];

// Message au joueur
["INFO",format["%1",_msg],"success"] spawn ALF_fnc_doMsg;

// Confirmation au donneur
["INFO",format["%1",_msgDonor], "success"] remoteExec ["ALF_fnc_doMsg", _player];
//};