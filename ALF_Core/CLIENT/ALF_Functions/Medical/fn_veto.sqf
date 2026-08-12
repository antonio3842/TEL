/*
	File: fn_veto.sqf
	Script qui soigne une personne depuis une clinique véto
	
	_param = 0 : heal player
	_param = 1 : réanimer coma
	
*/

params [
	["_param",0] 
];

//Spawn nb alerte GN
_infoGn = [0, 100] call BIS_fnc_randomInt;

//Spawn nb risque echec
_infoEchec = [0, 100] call BIS_fnc_randomInt;

switch _param do {

	case 0 : {

		if (damage player isEqualTo 0) exitWith {["Vétérinaire", "Vous n'êtes pas bléssé", "warning"] spawn ALF_fnc_doMsg;};
		
		private _timeout = player getVariable ["veto_heal", 0];
		if (time < _timeout) exitWith 
		{
			["INFO", "Vous êtes déjà aller voir le vétériaire, revenez plus tard.", "warning"] spawn ALF_fnc_doMsg;
		};
		
		player setVariable ['veto_heal', time + 450, true];
		
		if (_infoGn > 90) then { 
			["ALERTE", "Une personne menace un vétérinaire pour des soins."] remoteExecCall ["ALF_Server_fnc_doCopCall", 2];
		};
			if (25000 > life_cash) exitWith {["Vétérinaire", "Vous n'avez pas assez d'argent sur vous", "warning"] spawn ALF_fnc_doMsg;};
			life_cash = life_cash - 25000;
			["Vétérinaire", "Merci de ne pas bouger pendant 30 secondes. je tente de vous soigner", "danger"] spawn ALF_fnc_doMsg;
			private _pos = getPos player;
			uiSleep 30;

			if (_pos distance player > 5) exitWith {["Vétérinaire", "Vous avez bougé, donc les soins n'ont pas été appliqués.", "danger"] spawn ALF_fnc_doMsg;};
				
		if (_infoEchec > 90) then { //20% de chance de boitté 
			player setDamage 0.8;
			["Vétérinaire", "Je n'arrive pas à vous stabilier, ça ne fait qu'empirer, aller à l'hôpital", "danger"] spawn ALF_fnc_doMsg;
		} else {
			player setDamage 0.3;
			titleText ["Vous êtes soigné", "PLAIN"]; [] spawn {sleep 5;titleText ["", "PLAIN"];};
			["Vétérinaire", "J'ai fait ce que j'ai pu pour vous soigner.", "info"] spawn ALF_fnc_doMsg;
		};	
	};

	case 1 : {

		private _scanner = (nearestObjects [player, ["Land_ALF_IRM"], 15]) # 0;
		if (isNull _scanner) exitWith {};

		private _comaPlayers = (nearestObjects [_scanner, ["Man"], 15]) select {
			lifestate _x isEqualTo "INCAPACITATED"
		};
		
		if ((count _comaPlayers) > 0) then {
			private _timeout = player getVariable ["veto_coma", 0];
			if (time < _timeout) exitWith 
			{
				["INFO", "Vous êtes déjà aller voir le vétériaire, revenez plus tard.", "warning"] spawn ALF_fnc_doMsg;
			};
			
			player setVariable ['veto_coma', time + 600, true];
			
			if (_infoGn > 90) then { //10% de chance de prévenir la GN
				["ALERTE", "Une personne menace un vétérinaire pour des soins."] remoteExecCall ["ALF_Server_fnc_doCopCall", 2];
			};

			if (_infoEchec > 90) then { //10% de chance de ne pas être réa 
				["Vétérinaire", "Je ne peux rien faire pour lui, aller à l'hôpital", "danger"] spawn ALF_fnc_doMsg;
			} else {
				private _patient = _comaPlayers # 0;

				if (_patient getVariable ["onScanner", false]) then 
				{
					private _timeout = _patient getVariable ["scannerTimeout", 0];
					if (time < _timeout) exitWith 
					{
						["INFO", "La personne que vous essayez de réanimer est déjà prise en charge par un autre scanner.", "warning"] spawn ALF_fnc_doMsg;
					};
					_patient setVariable ["onScanner", false, true];
					_patient setVariable ["scannerTimeout", nil, true];
				};

				if (isNull _patient || { lifestate _patient != 'INCAPACITATED' }) exitWith 
				{
					['INFO', 'Le blessé n''est plus inconscient.', 'danger'] spawn ALF_fnc_doMsg;
				};

				if (_scanner getVariable ['wip', false]) exitWith 
				{
					['INFO', 'Un patient est déjà sur le scanner.', 'warning'] spawn ALF_fnc_doMsg;
				};

				if (_patient getVariable ['onScanner', false]) exitWith 
				{
					['INFO', 'Le patient est déjà en cours de scanner.', 'danger'] spawn ALF_fnc_doMsg;
				};

				if (100000 > life_cash) exitWith {["Vétérinaire", "Vous n'avez pas assez d'argent sur vous", "warning"] spawn ALF_fnc_doMsg;};
				life_cash = life_cash - 100000;
				_patient setVariable ['onScanner', true, true];
				_patient setVariable ['scannerTimeout', time + 150, true];
				[player, _patient] remoteExec ['ALF_fnc_scannerSystem', _patient];
			};
		} else {
			["Vétérinaire", "Il n'y a personne d'inconscient avec vous", "warning"] spawn ALF_fnc_doMsg;
		};
	};
};
