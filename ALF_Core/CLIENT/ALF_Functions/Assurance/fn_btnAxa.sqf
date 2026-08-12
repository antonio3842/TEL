#include "\ALF_Client\script_macros.hpp"
/*
Author: ALF Team
*/
private _o = _this select 0;

switch (_o) do {
	case 0 : {
		private _action = ["Voulez-vous résilier votre assurance ? Cette opération désactivera l'assurance sur tous vos véhicules.","MACIF","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		[name player,getPlayerUID player,"ASSURANCE","A résilié toutes ses assurances."] remoteExec ["ALF_Server_fnc_logIt",2];
		[0,getPlayerUID player,player] remoteExec ["ALF_Server_fnc_Axa",2];
		life_axa = 0;
		life_axabank = 0;
		life_axacount = 0;
		life_axaprocount = 0;
	};
	case 1 : {
		if !(life_laactive) exitWith {["MACIF","Vous n'avez pas de livret A.","warning"] spawn ALF_fnc_doMsg;};
		private _p = 50;
		private _action = [format["Voulez-vous acheter cette offre pour %1€. La somme sera prélevée sur votre livret A chaque jour. Frais de dossier : 150€.",_p],"MACIF","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		if(life_livreta < 150) exitWith {["MACIF","Vous n'avez pas assez sur votre livret A pour les frais de dossier.","warning"] spawn ALF_fnc_doMsg;};

		life_livreta = life_livreta - 150;
		[6] call SOCK_fnc_updatePartial;

		[name player,getPlayerUID player,"ASSURANCE","A souscrit à l'offre 1."] remoteExec ["ALF_Server_fnc_logIt",2];
		[1,getPlayerUID player,player] remoteExec ["ALF_Server_fnc_Axa",2];
		life_axa = 1;
	};
	case 2 : {
		if !(life_laactive) exitWith {["MACIF","Vous n'avez pas de livret A.","warning"] spawn ALF_fnc_doMsg;};
		private _p = 200;
		private _action = [format["Voulez-vous acheter cette offre pour %1€. La somme sera prélevée sur votre livret A chaque jour. Frais de dossier : 300€.",_p],"MACIF","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		if(life_livreta < 300) exitWith {["MACIF","Vous n'avez pas assez sur votre livret A pour les frais de dossier.","warning"] spawn ALF_fnc_doMsg;};

		[name player,getPlayerUID player,"ASSURANCE","A souscrit à l'offre 2."] remoteExec ["ALF_Server_fnc_logIt",2];
		life_livreta = life_livreta - 300;
		[6] call SOCK_fnc_updatePartial;

		[2,getPlayerUID player,player] remoteExec ["ALF_Server_fnc_Axa",2];
		life_axa = 2;
	};
	case 3 : {
		if !(life_laactive) exitWith {["MACIF","Vous n'avez pas de livret A.","warning"] spawn ALF_fnc_doMsg;};
		private _p = 500;
		private _action = [format["Voulez-vous acheter cette offre pour %1€. La somme sera prélevée sur votre livret A chaque jour. Frais de dossier : 700€.",_p],"MACIF","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		if(life_livreta < 700) exitWith {["MACIF","Vous n'avez pas assez sur votre livret A pour les frais de dossier.","warning"] spawn ALF_fnc_doMsg;};

		[name player,getPlayerUID player,"ASSURANCE","A souscrit à l'offre 3."] remoteExec ["ALF_Server_fnc_logIt",2];
		life_livreta = life_livreta - 700;
		[6] call SOCK_fnc_updatePartial;

		[3,getPlayerUID player,player] remoteExec ["ALF_Server_fnc_Axa",2];
		life_axa = 3;
	};
	case 4 : {
		if !(life_laactive) exitWith {["MACIF","Vous n'avez pas de livret A.","warning"] spawn ALF_fnc_doMsg;};
		if (life_axabank isEqualTo 0) exitWith {["MACIF","Le prélèvement est déjà configuré sur ce compte.","warning"] spawn ALF_fnc_doMsg;};
		[name player,getPlayerUID player,"ASSURANCE","A configuré le prélèvement sur son livret A."] remoteExec ["ALF_Server_fnc_logIt",2];
		[4,getPlayerUID player,player] remoteExec ["ALF_Server_fnc_Axa",2];
		life_axabank = 0;
	};
	case 5 : {
		if !(life_lbactive) exitWith {["MACIF","Vous n'avez pas de livret B.","warning"] spawn ALF_fnc_doMsg;};
		if (life_axabank isEqualTo 1) exitWith {["MACIF","Le prélèvement est déjà configuré sur ce compte.","warning"] spawn ALF_fnc_doMsg;};
		[name player,getPlayerUID player,"ASSURANCE","A configuré le prélèvement sur son livret B."] remoteExec ["ALF_Server_fnc_logIt",2];
		[5,getPlayerUID player,player] remoteExec ["ALF_Server_fnc_Axa",2];
		life_axabank = 1;
	};
	case 6 : {
		if !(life_lcactive) exitWith {["MACIF","Vous n'avez pas de livret C.","warning"] spawn ALF_fnc_doMsg;};
		if (life_axabank isEqualTo 2) exitWith {["MACIF","Le prélèvement est déjà configuré sur ce compte.","warning"] spawn ALF_fnc_doMsg;};
		[name player,getPlayerUID player,"ASSURANCE","A configuré le prélèvement sur son livret C."] remoteExec ["ALF_Server_fnc_logIt",2];
		[6,getPlayerUID player,player] remoteExec ["ALF_Server_fnc_Axa",2];
		life_axabank = 2;
	};
	case 7 : {
		if !(life_laactive) exitWith {["MACIF","Vous n'avez pas de livret A.","warning"] spawn ALF_fnc_doMsg;};
		if !(life_donor) exitWith {["MACIF","Vous ne pouvez pas selectionner cette offre.","warning"] spawn ALF_fnc_doMsg;};
		private _p = 1250;
		private _action = [format["Voulez-vous acheter cette offre pour %1€. La somme sera prélevée sur votre livret A chaque jour. Frais de dossier : 2499€.",_p],"MACIF","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};
		if(life_livreta < 2499) exitWith {["MACIF","Vous n'avez pas assez sur votre livret A pour les frais de dossier.","warning"] spawn ALF_fnc_doMsg;};

		[name player,getPlayerUID player,"ASSURANCE","A souscrit à l'offre Donateur."] remoteExec ["ALF_Server_fnc_logIt",2];
		life_livreta = life_livreta - 2499;
		[6] call SOCK_fnc_updatePartial;

		[7,getPlayerUID player,player] remoteExec ["ALF_Server_fnc_Axa",2];
		life_axa = 4;
	};
};

[] call ALF_fnc_menuAxa;
