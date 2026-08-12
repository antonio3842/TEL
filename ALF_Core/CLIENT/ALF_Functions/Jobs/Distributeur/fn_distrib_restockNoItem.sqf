/*
	File: fn_distrib_restockNoItem.sqf
	Client — message si pas d'article en inventaire.
*/
params [["_label", "", [""]]];

["Distributeur", format ["Vous n'avez pas de %1 dans votre inventaire.", _label], "warning"] spawn ALF_fnc_doMsg;
