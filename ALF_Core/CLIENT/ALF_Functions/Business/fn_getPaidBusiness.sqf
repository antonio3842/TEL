#include "\ALF_Client\script_macros.hpp"
/*
File: getPaidBusiness.sqf
Author: ALF Nanou
*/
private["_paye"];
_paye = _this select 0;

life_cash = life_cash + _paye;
[0] call SOCK_fnc_updatePartial;

["INFO",format["Vous avez reçu votre paie en espèces. (%1 €)",[_paye] call ALF_fnc_numberText],"success"] spawn ALF_fnc_doMsg;
[name player,getPlayerUID player,"BANK",format["A recu une paie de %1 € en espèces | Espèces = %2 €",_paye,life_cash]] remoteExec ["ALF_Server_fnc_logIt",2];
