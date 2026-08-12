#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_copSetLic.sqf
	Author: NANOU
*/
private _mode = _this select 0;
private _cop = _this select 1;
private _msg = "";
private _msg2 = "";
private _name = name player;

if(life_copLevel isEqualTo 0) exitWith {["INFO","Cette personne n'est pas Gendarme.", "success"] remoteExec ["ALF_fnc_doMsg",_cop];};

private _varnameConfig = ["STRING", ["Licenses", _mode, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
private _level = missionNamespace getVariable [format["license_%1",_varnameConfig], false];

if(_level) exitWith {["INFO","Cette personne a déjà cette licence.", "success"] remoteExec ["ALF_fnc_doMsg",_cop];};

switch (_mode) do {
	case "PMO" : {
		license_PMO = true;
		_msg = "Tu es promu PMO.";
		_msg2 = format["%1 à été promu au PMO.",_name];
	}; 
	case "NOPMO" : {
		license_PMO = false;
		_msg = "Tu es viré du PMO.";
		_msg2 = format["%1 à été viré du PMO.",_name];
	};
	case "SR" : {
		license_SR = true;
		_msg = "Tu es promu SR.";
		_msg2 = format["%1 à été promu a la SR.",_name];
	}; 
	case "NOSR" : {
		license_SR = false;
		_msg = "Tu es viré de la SR.";
		_msg2 = format["%1 à été viré de la SR.",_name];
	};
	case "TIC" : {
		license_TIC = true;
		_msg = "Tu es promu TIC.";
		_msg2 = format["%1 à été promu TIC.",_name];
	}; 
	case "NOTIC" : {
		license_TIC = false;
		_msg = "Tu es viré des TIC.";
		_msg2 = format["%1 à été viré des TIC.",_name];
	};
	case "PSIG" : {
		license_PSIG = true;
		_msg = "Tu es promu MOBILE.";
		_msg2 = format["%1 à été promu MOBILE.",_name];
	}; 
	case "NOPSIG" : {
		license_PSIG = false;
		_msg = "Tu es viré de MOBILE.";
		_msg2 = format["%1 à été viré du MOBILE.",_name];
	};
	case "PSIG_Sabre" : {
		license_PSIG_Sabre = true;
		_msg = "Tu es promu PSIG Sabre.";
		_msg2 = format["%1 à été promu PSIG Sabre.",_name];
	};
	case "NOPSIG_Sabre" : {
		license_PSIG_Sabre = false;
		_msg = "Tu es viré du PSIG Sabre.";
		_msg2 = format["%1 à été viré du PSIG Sabre.",_name];
	};
	case "GIGN" : {
		license_GIGN = true;
		_msg = "Tu es promu GIGN.";
		_msg2 = format["%1 à été promu GIGN.",_name];
	}; 
	case "NOGIGN" : {
		license_GIGN = false;
		_msg = "Tu es viré du GIGN.";
		_msg2 = format["%1 à été viré du GIGN.",_name];
	};
	case "CYNO" : {
		license_CYNO = true;
		_msg = "Tu es promu CYNOPHILE.";
		_msg2 = format["%1 à été promu CYNOPHILE.",_name];
	};
	case "NOCYNO" : {
		license_CYNO = false;
		_msg = "Tu es viré de la CYNOPHILE.";
		_msg2 = format["%1 à été viré de la CYNOPHILE.",_name];
	};
};
[1] call SOCK_fnc_updatePartial;

["INFO",format["%1",_msg],"success"] spawn ALF_fnc_doMsg;

//Annonce pour tous les Gendarmes
["Gendarmerie.",format["%1",_msg2]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];
["Gendarmerie.", format["%1", _msg2]] remoteExecCall ["ALF_Server_fnc_doCopCallWL", 2];