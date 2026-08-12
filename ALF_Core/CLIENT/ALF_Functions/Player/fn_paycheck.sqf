// ALF_fnc_paycheck = {
if (
	!life_pompier_service AND 
	{!life_gendarme_service AND 
	{!life_publique_service AND 
	{!life_penit_service AND 
	{!ALF_Prison AND 
	{!((player getVariable ["isEmployed",""]) in ["","732242699","732411765","732296190","732738627","732220530","732306569"])}}}}}
) exitWith {};

if (ALF_Prison) exitWith 
{
	life_cash = life_cash + 3;
	[0] call SOCK_fnc_updatePartial;
};

if (
	life_copLevel isEqualTo 0 AND 
	{life_medicLevel isEqualTo 0 AND 
	{life_publique isEqualTo 0 AND 
	{life_penit isEqualTo 0 AND 
	{!((player getVariable ["isEmployed",""]) in ["732242699","732411765","732296190","732738627","732220530","732306569"])}}}}) 
exitWith 
{
	if (!life_laactive AND {!life_lbactive} AND {!life_lcactive}) exitWith 
	{
		life_cash = life_cash + 400;
		[0] call SOCK_fnc_updatePartial;
		["INFO","Vous avez recu votre RSA. 400€ en liquide.","success"] spawn ALF_fnc_doMsg;
	};
	if ((life_livreta + 400) < 75000) exitWith 
	{
		life_livreta = life_livreta + 400;
		[6] call SOCK_fnc_updatePartial;
		["INFO","Vous avez recu votre RSA. 400€ sur votre Livret A.","success"] spawn ALF_fnc_doMsg;
	};
	if (!life_lbactive) exitWith 
	{
		life_cash = life_cash + 400;
		[0] call SOCK_fnc_updatePartial;
		["INFO","Vous avez recu votre RSA. 400€ en liquide.","success"] spawn ALF_fnc_doMsg;
	};
	if ((life_livretb + 400) < 500000) exitWith 
	{
		life_livretb = life_livretb + 400;
		[7] call SOCK_fnc_updatePartial;
		["INFO","Vous avez recu votre RSA. 400€ sur votre Livret B.","success"] spawn ALF_fnc_doMsg;
	};
	if (!life_lcactive) exitWith 
	{
		life_cash = life_cash + 400;
		[0] call SOCK_fnc_updatePartial;
		["INFO","Vous avez recu votre RSA. 400€ en liquide.","success"] spawn ALF_fnc_doMsg;
	};

	life_livretc = life_livretc + 400;
	[8] call SOCK_fnc_updatePartial;
	["INFO","Vous avez recu votre RSA. 400€ sur votre Livret C.","success"] spawn ALF_fnc_doMsg;
};

private _p = 0;
if (life_gendarme_service) then 
{
	switch (life_copLevel) do 
	{
		default {_p = 0};
		case 1 : {_p = 1500};
		case 2 : {_p = 1560};
		case 3 : {_p = 1620};
		case 4 : {_p = 1680};
		case 5 : {_p = 1740};
		case 6 : {_p = 1800};
		case 7 : {_p = 1860};
		case 8 : {_p = 1920};
		case 9 : {_p = 1990};
		case 10 : {_p = 2050};
		case 11 : {_p = 2100};
		case 12 : {_p = 2250};
	};
};

if (life_pompier_service) then 
{
	switch (life_medicLevel) do 
	{
		default {_p = 0};
		case 1 : {_p = 1500};
		case 2 : {_p = 1570};
		case 3 : {_p = 1640};
		case 4 : {_p = 1710};
		case 5 : {_p = 1780};
		case 6 : {_p = 1850};
		case 7 : {_p = 1920};
		case 8 : {_p = 1990};
		case 9 : {_p = 2060};
		case 10 : {_p = 2130};
		case 11 : {_p = 2200};
		case 12 : {_p = 2270};
	};
};

if (life_publique_service) then 
{
	//Salaire Préfecture
	if (b_13) exitwith
	{
		switch (life_publique) do 
		{
			default {_p = 0};
			case 1 : {_p = 1500};
			case 2 : {_p = 1750};
			case 3 : {_p = 2000};
			case 4 : {_p = 2250};
			case 5 : {_p = 2500};
			case 6 : {_p = 2750};
			case 7 : {_p = 3000};
		};
	};

	//Salaire Tribunal
	if (b_23) exitwith 
	{
		switch (life_publique) do 
		{
			default {_p = 0};
			case 1 : {_p = 1500};
			case 2 : {_p = 1750};
			case 3 : {_p = 1750};
			case 4 : {_p = 2000};
			case 5 : {_p = 2000};
			case 6 : {_p = 2250};
		};
	};

	switch (life_publique) do 
	{
		default {_p = 0};
		case 1 : {_p = 1500};
		case 2 : {_p = 1600};
		case 3 : {_p = 1700};
		case 4 : {_p = 1800};
		case 5 : {_p = 1900};
		case 6 : {_p = 2000};
		case 7 : {_p = 2100};
		case 8 : {_p = 2250};
	};	
};

if (life_penit_service) then 
{
	switch (life_penit) do 
	{
		default {_p = 0};
		case 1 : {_p = 1500};
		case 2 : {_p = 1560};
		case 3 : {_p = 1620};
		case 4 : {_p = 1680};
		case 5 : {_p = 1740};
		case 6 : {_p = 1800};
		case 7 : {_p = 1860};
		case 8 : {_p = 1920};
		case 9 : {_p = 1990};
		case 10 : {_p = 2050};
		case 11 : {_p = 2100};
		case 12 : {_p = 2250};
	};
};

if (_p <= 0) exitWith {};

if (!life_laactive AND {!life_lbactive AND {!life_lcactive}}) exitWith 
{
	life_cash = life_cash + _p;
	[0] call SOCK_fnc_updatePartial;
	["INFO",format["Vous avez reçu votre paye. %1€ en liquide.",_p],"success"] spawn ALF_fnc_doMsg;
};
if ((life_livreta + _p) < 75000) exitWith 
{
	life_livreta = life_livreta + _p;
	[6] call SOCK_fnc_updatePartial;
	["INFO",format["Vous avez reçu votre paye. %1€ sur votre Livret A.",_p],"success"] spawn ALF_fnc_doMsg;
};
if(!life_lbactive) exitWith 
{
	life_cash = life_cash + _p;
	[0] call SOCK_fnc_updatePartial;
	["INFO",format["Vous avez reçu votre paye. %1€ en liquide.",_p],"success"] spawn ALF_fnc_doMsg;
};
if((life_livretb + _p) < 500000) exitWith 
{
	life_livretb = life_livretb + _p;
	[7] call SOCK_fnc_updatePartial;
	["INFO",format["Vous avez reçu votre paye. %1€ sur votre Livret B.",_p],"success"] spawn ALF_fnc_doMsg;
};
if(!life_lcactive) exitWith 
{
	life_cash = life_cash + _p;
	[0] call SOCK_fnc_updatePartial;
	["INFO",format["Vous avez reçu votre paye. %1€ en liquide.",_p],"success"] spawn ALF_fnc_doMsg;
};

life_livretc = life_livretc + _p;
[8] call SOCK_fnc_updatePartial;
["INFO",format["Vous avez reçu votre paye. %1€ sur votre Livret C.",_p],"success"] spawn ALF_fnc_doMsg;
// };