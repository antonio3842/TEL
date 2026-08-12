/*
	File: fn_buyBFMCrime.sqf
	ALF Adam
*/
if (license_bfmCrime) exitWith {["INFO","Vous avez deja l'abonnement.","warning"] spawn ALF_fnc_doMsg;};

private _action = ["Voulez-vous acheter un abonnement à DeepNews pour 150 000 €.","Abonnement News","OUI","NON"] call BIS_fnc_guiMessage;
if(_action) then {

	if(life_cash < 150000) exitWith {["ERREUR","Vous n'avez pas 150 000 € sur vous.","warning"] spawn ALF_fnc_doMsg;};

	life_cash = life_cash - 150000;
	[0] call SOCK_fnc_updatePartial;

	license_bfmCrime = true;
	[1] call SOCK_fnc_updatePartial;

	["INFO","Vous avez acheté un abonnement à DeepNews.","success"] spawn ALF_fnc_doMsg;
};