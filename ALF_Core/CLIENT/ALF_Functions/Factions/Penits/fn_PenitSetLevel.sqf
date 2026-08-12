// #include "\ALF_Client\script_macros.hpp"
// /*
// 	File: fn_PenitSetLevel.sqf
// 	Author: NANOU
// */
// ALF_fnc_PenitSetLevel = {
private _grade = param [0,0];
private _pm = param [1,objnull];



private _msg = "Vous êtes viré de la Police Municipale.";
private _name = name player;
private _msg2 = format["%1 à été viré de la Police Municipale.",_name];

if (life_penit isEqualTo _grade) exitWith {["INFO","Cette personne possède déjà ce grade.", "success"] remoteExec ["ALF_fnc_doMsg",_pm];};

switch (_grade) do 
{
	case 0 : 
	{
		life_penit = 0;
//		license_cop = false;
	}; 
	case 1 : 
	{
		life_penit = 1;
//		license_cop = true;
		_msg = "Vous êtes promu Stagiaire.";
		_msg2 = format["%1 à été promu Stagiaire.",_name];
	};
	case 2 : 
	{
		life_penit = 2;
//		license_cop = true;
		_msg = "Vous êtes promu Titulaire.";
		_msg2 = format["%1 à été promu Titulaire.",_name];
	}; 
	case 3 : 
	{
		life_penit = 3;
//		license_cop = true;
		_msg = "Vous êtes promu Gardien principal.";
		_msg2 = format["%1 à été promu Gardien principal.",_name];
	}; 
	case 4 : 
	{
		life_penit = 4;
//		license_cop = true;
		_msg = "Vous êtes promu Brigadier.";
		_msg2 = format["%1 à été promu Brigadier.",_name];
	}; 
	case 5 : 
	{
		life_penit = 5;
//		license_cop = true;
		_msg = "Vous êtes promu Brigadier-Chef.";
		_msg2 = format["%1 à été promu Brigadier-Chef.",_name];
	}; 
	case 6 : 
	{
		life_penit = 6;
//		license_cop = true;
		_msg = "Vous êtes promu Chef de Police.";
		_msg2 = format["%1 à été promu Chef de Police.",_name];
	}; 
	case 7 : 
	{
		life_penit = 7;
//		license_cop = true;
		_msg = "Vous êtes promu Chef de service stagiaire.";
		_msg2 = format["%1 à été promu Chef de service stagiaire.",_name];
	}; 
	case 8 : 
	{
		life_penit = 8;
//		license_cop = true;
		_msg = "Vous êtes promu Chef de service classe Normale.";
		_msg2 = format["%1 à été promu Chef de service classe Normale.",_name];
	}; 
	case 9 : 
	{
		life_penit = 9;
//		license_cop = true;
		_msg = "Vous êtes promu Chef de service classe Supérieur.";
		_msg2 = format["%1 à été promu Chef de service classe Supérieur.",_name];
	}; 
	case 10 : 
	{
		life_penit = 10;
//		license_cop = true;
		_msg = "Vous êtes promu Chef de service classe Execeptionnelle.";
		_msg2 = format["%1 à été promu Chef de service classe Execeptionnelle.",_name];
	}; 
	case 11 : 
	{
		life_penit = 11;
//		license_cop = true;
		_msg = "Vous êtes promu Directeur Stagiaire.";
		_msg2 = format["%1 à été promu Directeur Stagiaire.",_name];
	};
	case 12 : 
	{
		life_penit = 12;
//		license_cop = true;
		_msg = "Vous êtes promu Directeur Directeur.";
		_msg2 = format["%1 à été promu Directeur Directeur.",_name];
	}; 
};

[1] call SOCK_fnc_updatePartial;
[11] call SOCK_fnc_updatePartial;

["INFO",format["%1",_msg],"success"] spawn ALF_fnc_doMsg;

//Annonce pour tous les Gendarmes
["Police Municipale.",format["%1",_msg2]] remoteExecCall ["ALF_Server_fnc_doPenitCall",2];
// };