/*
	File: fn_addXP.sqf
	Author: ALF Team
	
	SYSTEME XP DESACTIVE - Variables non initialisees causent des erreurs
	Pour reactiver : decommenter le code et initialiser les variables dans fn_initClient.sqf
*/

// SYSTEME XP DESACTIVE - Ne rien faire
if (true) exitWith {};

private _mode = _this select 0;
private _xp_add = _this select 1;
if (_xp_add < 1) exitWith {};

//_xp_add = _xp_add * 2; // Double XP

private _xp = [
				[666,666,750,750,1166],
				[666,666,666,1166,1500,1500,1500,1500],
				[666,666,666,1166,1166,1166,1500,1500,1500],
				[500,500,1750,4500],
				[0,5000,10000,15000,20000,25000]
			  ];
			  
private _xp_temp = 0;
private _new_niv = 0;
			 
switch (_mode) do {
	case 0 : {
		alf_xp_recolte = alf_xp_recolte + _xp_add;
		
		_xp_temp = alf_xp_recolte;
		
		{
			if !(alf_niv_recolte >= _forEachIndex) then {
				if (_x <= _xp_temp) then {
					_xp_temp = _xp_temp - _x;
					_new_niv = _new_niv + 1;
				};
			};
		} forEach (_xp select 0);
		
		alf_xp_recolte = _xp_temp;
		if (_new_niv != 0) then {
			alf_niv_recolte = alf_niv_recolte + _new_niv;
			if (alf_niv_recolte > 9) then {alf_niv_recolte = 9;};
			["Expérience", format["Félicitations ! Vous venez de passer au niveau %1 de récolte.",alf_niv_recolte+1], "success"] spawn ALF_fnc_doMsg;
		};
	};
	
	case 1 : {
		alf_xp_minage = alf_xp_minage + _xp_add;
		_xp_temp = alf_xp_minage;
		
		{
			if !(alf_niv_minage >= _forEachIndex) then {
				if (_x <= _xp_temp) then {
					_xp_temp = _xp_temp - _x;
					_new_niv = _new_niv + 1;
				};
			};
		} forEach (_xp select 1);
		
		alf_xp_minage = _xp_temp;
		if (_new_niv != 0) then {
			alf_niv_minage = alf_niv_minage + _new_niv;
			if (alf_niv_minage > 9) then {alf_niv_minage = 9;};
			["Expérience", format["Félicitations ! Vous venez de passer au niveau %1 de minage.",alf_niv_minage+1], "success"] spawn ALF_fnc_doMsg;
		};
	};
	
	case 2 : {
		alf_xp_peche = alf_xp_peche + _xp_add;
		_xp_temp = alf_xp_peche;
		
		{
			if !(alf_niv_peche >= _forEachIndex) then {
				if (_x <= _xp_temp) then {
					_xp_temp = _xp_temp - _x;
					_new_niv = _new_niv + 1;
				};
			};
		} forEach (_xp select 2);
		
		alf_xp_peche = _xp_temp;
		if (_new_niv != 0) then {
			alf_niv_peche = alf_niv_peche + _new_niv;
			if (alf_niv_peche > 8) then {alf_niv_peche = 8;};
			["Expérience", format["Félicitations ! Vous venez de passer au niveau %1 de pêche.",alf_niv_peche+1], "success"] spawn ALF_fnc_doMsg;
		};
	};
	
	case 3 : {
		alf_xp_illegal = alf_xp_illegal + _xp_add;
		_xp_temp = alf_xp_illegal;
		
		{
			if !(alf_niv_illegal >= _forEachIndex) then {
				if (_x <= _xp_temp) then {
					_xp_temp = _xp_temp - _x;
					_new_niv = _new_niv + 1;
				};
			};
		} forEach (_xp select 3);
		
		alf_xp_illegal = _xp_temp;
		if (_new_niv != 0) then {
			alf_niv_illegal = alf_niv_illegal + _new_niv;
			if (alf_niv_illegal > 3) then {alf_niv_illegal = 3;};
			["Expérience", format["Félicitations ! Vous venez de passer au niveau %1 de l'illégal.",alf_niv_illegal+1], "success"] spawn ALF_fnc_doMsg;
		};
	};

	case 4 : {
		_xp_add = _xp_add / 2;
		alf_xp_endurance = alf_xp_endurance + _xp_add;
		_xp_temp = alf_xp_endurance;
		
		{
			if !(alf_niv_endurance >= _forEachIndex) then {
				if (_x <= _xp_temp) then {
					_xp_temp = _xp_temp - _x;
					_new_niv = _new_niv + 1;
					_newniv = true;
				};
			};
		} forEach (_xp select 4);
		
		alf_xp_endurance = _xp_temp;
		if (_new_niv != 0) then {
			alf_niv_endurance = alf_niv_endurance + _new_niv;
			[] spawn ALF_fnc_changeSpeed;
			if (alf_niv_endurance > 4) then {alf_niv_endurance = 4;};
			["Endurance", format["Félicitations ! Vous pouvez maintenant courir plus vite"], "success"] spawn ALF_fnc_doMsg;
		};
	};
};

[16] call SOCK_fnc_updatePartial;

if !(_mode isEqualTo 4) then {
	[_xp_add] spawn ALF_fnc_doXP;
};

