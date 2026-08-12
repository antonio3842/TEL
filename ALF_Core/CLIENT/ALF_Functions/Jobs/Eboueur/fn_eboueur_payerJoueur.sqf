/*
    File: fn_eboueur_payerJoueur.sqf
    Description: Payer le joueur
*/
private _salaire = _this select 0;
life_cash = life_cash + _salaire;
[0] call SOCK_fnc_updatePartial;

		private _msg = format ["Voici votre salaire : %1", _salaire];
		["Éboueur", _msg, "success"] spawn ALF_fnc_doMsg;