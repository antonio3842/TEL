/*
	File: fn_distrib_restockPay.sqf
	Client — paiement après réapprovisionnement serveur.
*/
params [
	["_amount", 50, [0]],
	["_label", "article", [""]]
];

life_cash = life_cash + _amount;

[] spawn {
	life_query_time = time;
	if !(alf_moneysave) then {
		alf_moneysave = true;
		waitUntil {
			sleep 0.3;
			(time - life_query_time) >= 5
		};
		[0] call SOCK_fnc_updatePartial;
		alf_moneysave = false;
	};
};

["Distributeur", format ["+%1€ — %2 ajouté au stock.", _amount, _label], "success"] spawn ALF_fnc_doMsg;

[] call ALF_fnc_distrib_restockRefresh;
