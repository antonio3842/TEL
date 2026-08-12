/*
	File : fn_playPoker.sqf
	Author: ALF Team

	Client-side Poker (Texas Hold'em)
*/
params [
	["_mode",-1,[0]]
];

if (_mode isEqualTo -1) exitWith {};

// Guard : si le joueur a quitté la table, ignorer les messages tardifs
// Exceptions : case 0 (lancer), case 1 (cartes HUD), case 10 (blinds), case 11 (init), case 12 (HUD texte)
if (_mode != 0 && {_mode != 1} && {_mode != 10} && {_mode != 11} && {_mode != 12} && {ALF_Current_Table isEqualTo objNull}) exitWith {
	closeDialog 0;
	"pokerCarte" cutText ["","PLAIN"];
};

switch (_mode) do {
	// === Case 0 : Lancer la partie ===
	case 0: {
		private _table = player getVariable ["ALF_Poker_MyTable", objNull];
		if (isNull _table && {!isNull objectParent player}) then {
			private _veh = objectParent player;
			if (((toLowerANSI (typeOf _veh)) find "alf_poker") > -1) then {
				_table = _veh;
			};
		};
		if (isNull _table) then {
			private _near = nearestObjects [player, ["AllVehicles"], 6] select {((toLowerANSI (typeOf _x)) find "alf_poker") > -1};
			if (_near isNotEqualTo []) then {
				_table = _near # 0;
			};
		};

		if (isNull _table) exitWith {["Poker", "Il vous faut une table de poker proche de vous.", "danger", false] spawn ALF_fnc_doMsg;};
		if !(player in _table) exitWith {["Poker", "Vous devez être assis à la table pour lancer la partie.", "danger", false] spawn ALF_fnc_doMsg;};

		if (life_cash < 2500) exitWith {["Poker", "Il vous faut au moins 2 500 € en liquide pour jouer au poker.", "danger", false] spawn ALF_fnc_doMsg;};

		// Vérifier qu'on n'est pas déjà dans une partie
		if !(ALF_Current_Table isEqualTo objNull) exitWith {
			["Poker", "Vous êtes déjà dans une partie.", "danger", false] spawn ALF_fnc_doMsg;
		};

		// Vérifier qu'aucune partie n'est en cours sur cette table
		if (_table getVariable ["ALF_Poker_InGame", false]) exitWith {
			["Poker", "Une partie est déjà en cours à cette table.", "danger", false] spawn ALF_fnc_doMsg;
		};

		ALF_Poker_SelectPlayer = [];
		{ ALF_Poker_SelectPlayer pushBack _x; } forEach (crew _table);

		if ((count ALF_Poker_SelectPlayer) > 8 || {(count ALF_Poker_SelectPlayer) < 2}) exitWith {
			["Poker", "Vous ne pouvez jouer seulement entre 2 et 8 joueurs au poker. La partie a été annulée.", "danger", false] spawn ALF_fnc_doMsg;
			ALF_Poker_SelectPlayer = [];
		};

		private _countNull = {isNull _x || {!(_x in _table)}} count ALF_Poker_SelectPlayer;
		if (_countNull > 0) exitWith {
			["Poker", "Un joueur est mort ou déconnecté ou n'est pas assis. La partie a été annulée.", "danger", false] spawn ALF_fnc_doMsg;
			ALF_Poker_SelectPlayer = [];
		};

		[ALF_Poker_SelectPlayer, _table] remoteExec ["ALF_Server_fnc_playPoker", 2];
		ALF_Poker_SelectPlayer = [];
	};

	// === Case 1 : Affichage des cartes ===
	case 1: {
		private _cartes = param [1, [], [[]]];
		private _id = 544151;

		disableSerialization;
		private _display = uiNamespace getVariable ["pokerHUD",displayNull];

		if (isNull _display) then {
			"pokerCarte" cutRsc ["pokerHUD", "PLAIN", 2, false];
			_display = uiNameSpace getVariable ["pokerHUD",displayNull];
		};

		// Afficher le label des cartes sur tapis (comme au BJ)
		(_display displayCtrl 544158) ctrlShow true;
		(_display displayCtrl 544158) ctrlSetText "Cartes sur tapis : -";
		(_display displayCtrl 544159) ctrlShow false;

		private "_texture";
		{
			_control = _display displayCtrl _id;
			_texture = [_x] call ALF_fnc_recupPokerTexture;
			_control ctrlSetText _texture;
			_id = _id + 1;
		} forEach _cartes;
	};

	// === Case 2 : Dialog mise initiale (Miser / Checker / Se coucher) ===
	// Quand personne n'a encore misé dans ce tour
	case 2: {
		ALF_Current_Partie = param [1, -1, [0]];
		private _currentBet = param [2, 0, [0]];
		ALF_Poker_CurrentBet = 0;

		if (ALF_Current_Partie isEqualTo -1) exitWith {};
		if !(createDialog "alfpoker") exitWith {["Poker","Erreur lors de la création du dialog.","warning"] spawn ALF_fnc_doMsg;};
		disableSerialization;

		private _display = findDisplay 541618;

		// Sous-titre
		(_display displayCtrl 5416190) ctrlSetText "Placez votre mise ou checkez";

		// Afficher : Edit + Miser + Checker + Se coucher
		(_display displayCtrl 5416181) ctrlShow true;
		(_display displayCtrl 5416182) ctrlShow true;
		(_display displayCtrl 5416182) ctrlSetText "Miser";
		(_display displayCtrl 5416188) ctrlShow true;
		(_display displayCtrl 5416184) ctrlShow true;

		// Cacher : Suivre
		(_display displayCtrl 5416183) ctrlShow false;

		// Info pot
		(_display displayCtrl 5416185) ctrlSetText "";
	};

	// === Case 3 : Dialog avec relance (Suivre / Relancer / Se coucher) ===
	// Quand quelqu'un a misé et il faut suivre ou relancer
	case 3: {
		ALF_Current_Partie = param [1, -1, [0]];
		private _currentBet = param [2, 0, [0]];
		ALF_Poker_ToCall = param [3, 0, [0]];
		ALF_Poker_CurrentBet = _currentBet;

		if (ALF_Current_Partie isEqualTo -1) exitWith {};
		if !(createDialog "alfpoker") exitWith {["Poker","Erreur lors de la création du dialog.","warning"] spawn ALF_fnc_doMsg;};
		disableSerialization;

		private _display = findDisplay 541618;

		// Sous-titre
		(_display displayCtrl 5416190) ctrlSetText "Suivez, relancez ou couchez-vous";

		// Afficher : Edit + Relancer + Suivre + Se coucher
		(_display displayCtrl 5416181) ctrlShow true;
		(_display displayCtrl 5416182) ctrlShow true;
		(_display displayCtrl 5416182) ctrlSetText "Relancer";
		(_display displayCtrl 5416183) ctrlShow true;
		(_display displayCtrl 5416183) ctrlSetText format["Suivre (%1 €)", [ALF_Poker_ToCall] call ALF_fnc_numberText];
		(_display displayCtrl 5416184) ctrlShow true;

		// Cacher : Checker
		(_display displayCtrl 5416188) ctrlShow false;

		// Info mise en cours
		(_display displayCtrl 5416185) ctrlSetText format["Mise en cours : %1 €", [_currentBet] call ALF_fnc_numberText];
	};

	// === Case 4 : Bouton Suivre ===
	case 4: {
		private _toCall = ALF_Poker_ToCall;
		if (isNil "_toCall" || {_toCall <= 0}) exitWith {["Poker","Aucune mise à suivre.", "danger", false] spawn ALF_fnc_doMsg;};
		if (life_cash <= 0) exitWith {["Poker","Vous n'avez plus d'argent. Vous devez vous coucher.", "danger", false] spawn ALF_fnc_doMsg;};

		// All-in si pas assez pour suivre
		if (life_cash < _toCall) then {
			_toCall = life_cash;
			["Poker", format["Tapis ! Vous suivez pour %1 €.", [_toCall] call ALF_fnc_numberText], "warning", false] spawn ALF_fnc_doMsg;
		};

		life_cash = life_cash - _toCall;
		missionNamespace setVariable [format ["ALF_Poker%1_CurrentAction", ALF_Current_Partie], ["suivre", _toCall], true];
		closeDialog 0;
	};

	// === Case 5 : Bouton Se coucher ===
	case 5: {
		missionNamespace setVariable [format ["ALF_Poker%1_CurrentAction", ALF_Current_Partie], ["coucher", -1], true];
		closeDialog 0;
	};

	// === Case 6 : Bouton Miser / Relancer ===
	case 6: {
		disableSerialization;
		private _display = findDisplay 541618;
		private _btnText = ctrlText (_display displayCtrl 5416182);
		private _value = ctrlText (_display displayCtrl 5416181);

		if !([_value] call TON_fnc_isnumber) exitWith {["Poker","Vous devez entrer un nombre.", "danger", false] spawn ALF_fnc_doMsg;};

		_value = parseNumber _value;
		if (_value < 500) exitWith {["Poker","La mise minimum est de 500 €.", "danger", false] spawn ALF_fnc_doMsg;};
		if (life_cash <= 0) exitWith {["Poker","Vous n'avez plus d'argent.", "danger", false] spawn ALF_fnc_doMsg;};

		if (_btnText isEqualTo "Relancer") then {
			// Validation minimum relance
			private _minRaise = if (ALF_Poker_CurrentBet > 500) then {ALF_Poker_CurrentBet} else {500};
			if (_value < _minRaise) exitWith {
				["Poker", format["La relance minimum est de %1 €.", _minRaise], "danger", false] spawn ALF_fnc_doMsg;
			};

			// Relancer : le joueur doit payer le call + la relance
			private _toCall = if (isNil "ALF_Poker_ToCall") then {0} else {ALF_Poker_ToCall};
			private _total = _toCall + _value;

			// All-in si pas assez pour la relance complète
			if (life_cash < _total) then {
				_total = life_cash;
				["Poker", format["Tapis ! Vous misez tout : %1 €.", [_total] call ALF_fnc_numberText], "warning", false] spawn ALF_fnc_doMsg;
			};

			life_cash = life_cash - _total;

			// Si le total all-in ne dépasse pas le call → envoyer comme suivi (pas une vraie relance)
			if (_total <= _toCall) then {
				missionNamespace setVariable [format ["ALF_Poker%1_CurrentAction", ALF_Current_Partie], ["suivre", _total], true];
			} else {
				missionNamespace setVariable [format ["ALF_Poker%1_CurrentAction", ALF_Current_Partie], ["relancer", _total], true];
			};
			closeDialog 0;
		} else {
			// Miser — all-in si pas assez
			if (life_cash < _value) then {
				_value = life_cash;
				["Poker", format["Tapis ! Vous misez tout : %1 €.", [_value] call ALF_fnc_numberText], "warning", false] spawn ALF_fnc_doMsg;
			};

			life_cash = life_cash - _value;
			missionNamespace setVariable [format ["ALF_Poker%1_CurrentAction", ALF_Current_Partie], ["miser", _value], true];
			closeDialog 0;
		};
	};

	// === Case 7 : Fin de partie — Gagnant ===
	case 7: {
		private _gagnant = param [1, objNull, [objNull]];
		private _potTotal = param [2, 0, [0]];
		private _handName = param [3, "", [""]];

		if (player isEqualTo _gagnant) then {
			if (_handName != "") then {
				["Poker", format["Vous avez gagné le pot de %1 € avec %2 !", [_potTotal] call ALF_fnc_numberText, _handName], "success", false] spawn ALF_fnc_doMsg;
			} else {
				["Poker", format["Vous remportez le pot de %1 € !", [_potTotal] call ALF_fnc_numberText], "success", false] spawn ALF_fnc_doMsg;
			};
			life_cash = life_cash + _potTotal;
		} else {
			if !(isNull _gagnant) then {
				if (_handName != "") then {
					["Poker", format["%1 remporte le pot avec %2.", name _gagnant, _handName], "danger", false] spawn ALF_fnc_doMsg;
				} else {
					["Poker", format["%1 remporte le pot.", name _gagnant], "danger", false] spawn ALF_fnc_doMsg;
				};
			} else {
				["Poker", "La partie est terminée.", "warning", false] spawn ALF_fnc_doMsg;
			};
		};

		"pokerCarte" cutText ["","PLAIN"];
		ALF_Current_Partie = -1;
		ALF_Current_Table = objNull;
	};

	// === Case 8 : Fin de partie — Erreur ===
	case 8: {
		["Poker","Erreur : partie poker terminée. Un joueur a quitté la partie.", "danger", false] spawn ALF_fnc_doMsg;
		"pokerCarte" cutText ["","PLAIN"];
		ALF_Current_Partie = -1;
		ALF_Current_Table = objNull;
	};

	// === Case 9 : Bouton Checker ===
	case 9: {
		missionNamespace setVariable [format ["ALF_Poker%1_CurrentAction", ALF_Current_Partie], ["checker", 0], true];
		closeDialog 0;
	};

	// === Case 10 : Notification blinds forcées ===
	case 10: {
		private _amount = param [1, 0, [0]];
		private _type = param [2, "", [""]];

		if (life_cash < _amount) then {
			["Poker", format["Vous n'avez pas assez pour la %1 blind (%2 €). Vous perdez ce que vous avez.", _type, _amount], "danger", false] spawn ALF_fnc_doMsg;
			_amount = life_cash;
		};

		life_cash = life_cash - _amount;
		["Poker", format["Vous payez la %1 blind : %2 €", _type, [_amount] call ALF_fnc_numberText], "warning", false] spawn ALF_fnc_doMsg;

		// Remonter le montant réellement payé au serveur
		if !(isNull ALF_Current_Table) then {
			ALF_Current_Table setVariable [format["ALF_Poker_BlindPaid_%1", getPlayerUID player], _amount, true];
		};
	};

	// === Case 12 : Mise à jour HUD texte (main + pot) envoyé par le serveur ===
	case 12: {
		private _handText = param [1, "", [""]];
		private _potText = param [2, "", [""]];

		disableSerialization;
		private _display = uiNamespace getVariable ["pokerHUD", displayNull];
		// Re-créer le HUD s'il a été détruit (desync, conflit avec un autre jeu)
		if (isNull _display) then {
			"pokerCarte" cutRsc ["pokerHUD", "PLAIN", 2, false];
			_display = uiNamespace getVariable ["pokerHUD", displayNull];
		};
		if !(isNull _display) then {
			if (_handText != "") then {
				(_display displayCtrl 544158) ctrlShow true;
				(_display displayCtrl 544158) ctrlSetText _handText;
			};
			if (_potText != "") then {
				(_display displayCtrl 544159) ctrlShow true;
				(_display displayCtrl 544159) ctrlSetText _potText;
			};
		};
	};

	// === Case 11 : Initialisation client — envoyé par le serveur à TOUS les joueurs ===
	case 11: {
		private _table = param [1, objNull, [objNull]];
		private _partie = param [2, -1, [0]];

		if (isNull _table) exitWith {};

		ALF_Current_Table = _table;
		ALF_Current_Partie = _partie;

		["Poker", "La partie vient de se lancer !", "success", false] spawn ALF_fnc_doMsg;

		// Monitoring : si le joueur quitte la table (sort du véhicule ou s'éloigne)
		[_table, _partie] spawn {
			params ["_tbl", "_pid"];
			private _leftCount = 0;
			waitUntil {
				sleep 2;
				if (ALF_Current_Table isEqualTo objNull || {ALF_Current_Partie != _pid} || {!alive player}) then {
					true
				} else {
					// Vérifier si le joueur est toujours assis ou proche de la table
					if (vehicle player != _tbl && {player distance _tbl > 5}) then {
						_leftCount = _leftCount + 1;
					} else {
						_leftCount = 0;
					};
					// Confirmer le départ après 2 checks consécutifs (évite les faux positifs de desync)
					_leftCount >= 2
				};
			};
			// Agir seulement si on est toujours dans CETTE partie
			if (ALF_Current_Partie isEqualTo _pid && {!(ALF_Current_Table isEqualTo objNull)}) then {
				closeDialog 0;
				"pokerCarte" cutText ["","PLAIN"];
				["Poker","Vous avez quitté la table. Vous perdez votre mise.", "danger", false] spawn ALF_fnc_doMsg;
				missionNamespace setVariable [format ["ALF_Poker%1_CurrentAction", _pid], ["coucher", -1], true];
				ALF_Current_Partie = -1;
				ALF_Current_Table = objNull;
			};
		};
	};
};
