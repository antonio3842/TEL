/*
	File: fn_distrib_getRestockPay.sqf
	Gain réappro = prix d'achat marché + 2€.
*/
params [["_className", "", [""]]];

([_className] call ALF_fnc_distrib_getItemBuyPrice) + 2
