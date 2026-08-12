// #include "\ALF_Client\script_macros.hpp"
// /*
// 	File: fn_copSetLevel.sqf
// 	Author: NANOU
// */
// ALF_fnc_copSetLevel = {
private _grade = param [0,0];
private _gendarme = param [1,objnull];



private _msg = "Vous êtes viré de la Gendarmerie.";
private _name = name player;
private _msg2 = format["%1 à été viré de la Gendarmerie.",_name];

if (life_copLevel isEqualTo _grade) exitWith {["INFO","Cette personne possède déjà ce grade.", "success"] remoteExec ["ALF_fnc_doMsg",_gendarme];};

switch (_grade) do 
{
	case 0 : 
	{
		life_copLevel = 0;
		license_cop = false;
	}; 
	case 1 : 
	{
		life_copLevel = 1;
		license_cop = true;
		_msg = "Vous êtes promu Elève Gendarme.";
		_msg2 = format["%1 à été promu Elève Gendarme.",_name];
	};
	case 2 : 
	{
		life_copLevel = 2;
		license_cop = true;
		_msg = "Vous êtes promu Gendarme.";
		_msg2 = format["%1 à été promu Gendarme.",_name];
	}; 
	case 3 : 
	{
		life_copLevel = 3;
		license_cop = true;
		_msg = "Vous êtes promu Maréchal des logis chef.";
		_msg2 = format["%1 à été promu Maréchal des logis chef.",_name];
	}; 
	case 4 : 
	{
		life_copLevel = 4;
		license_cop = true;
		_msg = "Vous êtes promu Adjudant.";
		_msg2 = format["%1 à été promu Adjudant.",_name];
	}; 
	case 5 : 
	{
		life_copLevel = 5;
		license_cop = true;
		_msg = "Vous êtes promu Adjudant-Chef.";
		_msg2 = format["%1 à été promu Adjudant-Chef.",_name];
	}; 
	case 6 : 
	{
		life_copLevel = 6;
		license_cop = true;
		_msg = "Vous êtes promu Major.";
		_msg2 = format["%1 à été promu Major.",_name];
	}; 
	case 7 : 
	{
		life_copLevel = 7;
		
		license_cop = true;
		_msg = "Vous êtes promu Sous-Lieutenant.";
		_msg2 = format["%1 à été promu Sous-Lieutenant.",_name];
	}; 
	case 8 : 
	{
		life_copLevel = 8;
		license_cop = true;
		_msg = "Vous êtes promu Lieutenant.";
		_msg2 = format["%1 à été promu Lieutenant.",_name];
	}; 
	case 9 : 
	{
		life_copLevel = 9;
		license_cop = true;
		_msg = "Vous êtes promu Capitaine.";
		_msg2 = format["%1 à été promu Capitaine.",_name];
	}; 
	case 10 : 
	{
		life_copLevel = 10;
		license_cop = true;
		_msg = "Vous êtes promu Commandant.";
		_msg2 = format["%1 à été promu Commandant.",_name];
	}; 
	case 11 : 
	{
		life_copLevel = 11;
		license_cop = true;
		_msg = "Vous êtes promu Lieutenant-Colonnel.";
		_msg2 = format["%1 à été promu Lieutenant-Colonnel.",_name];
	}; 
};

[1] call SOCK_fnc_updatePartial;
[11] call SOCK_fnc_updatePartial;

["INFO",format["%1",_msg],"success"] spawn ALF_fnc_doMsg;

//Annonce pour tous les Gendarmes
["Gendarmerie.",format["%1",_msg2]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];
// };