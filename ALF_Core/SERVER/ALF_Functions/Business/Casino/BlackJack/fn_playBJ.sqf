/*
	File: fn_playBJ.sqf
	Author: ALF Team
*/
params [
	["_mode",0,[0]],
	["_table",objNull,[objNull]],
	["_player",objNull,[objNull]]
];

// Anti-spoof client -> serveur (join/mise/action/leave)
if (_mode in [0,2,3,4,6]) then {
	if (isNull _table || {isNull _player} || {!isPlayer _player}) exitWith {};

	private _caller = remoteExecutedOwner call BIS_fnc_getUnitByOwner;
	if (isNull _caller || {!(_caller isEqualTo _player)} || {owner _player != remoteExecutedOwner}) exitWith {
		diag_log format ["[BJ-SEC] Rejet appel spoof : mode=%1 owner=%2 player=%3", _mode, remoteExecutedOwner, _player];
	};

	if (_mode in [0,2,3,6] && {_player distance _table > 8}) exitWith {
		["Blackjack","Vous êtes trop loin de la table.", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
	};
};

private _cards = [[14,"T"],[14,"CO"],[14,"CA"],[14,"P"],[13,"T"],[13,"CO"],[13,"CA"],[13,"P"],[12,"T"],[12,"CO"],[12,"CA"],[12,"P"],[11,"T"],[11,"CO"],[11,"CA"],[11,"P"],[10,"T"],[10,"CO"],[10,"CA"],[10,"P"],[9,"T"],[9,"CO"],[9,"CA"],[9,"P"],[8,"T"],[8,"CO"],[8,"CA"],[8,"P"],[7,"T"],[7,"CO"],[7,"CA"],[7,"P"],[6,"T"],[6,"CO"],[6,"CA"],[6,"P"],[5,"T"],[5,"CO"],[5,"CA"],[5,"P"],[4,"T"],[4,"CO"],[4,"CA"],[4,"P"],[3,"T"],[3,"CO"],[3,"CA"],[3,"P"],[2,"T"],[2,"CO"],[2,"CA"],[2,"P"]];
private _players = _table getVariable ["allPlayers",[]];
// NE PAS filtrer objNull : les index doivent rester alignés avec _mises
private _partieID = _table getVariable ["ID",-1];

switch (_mode) do {
	//Rejoindre la table de BJ
	case 0: {
		// Vérifier qu'un croupier (employé b_20) est présent à la table
		private _croupier = _table getVariable ["ALF_BJ_Croupier", objNull];
		if (isNull _croupier || {!alive _croupier} || {_croupier distance _table > 5}) exitWith {
			["Blackjack", "Pas de croupier. Un employé du casino doit tenir cette table.", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
			// Nettoyer si le croupier a disparu
			if !(isNull _croupier) then {
				_table setVariable ["ALF_BJ_Croupier", objNull, true];
			};
		};

		// Nettoyer les joueurs déconnectés/null entre les parties
		if (_partieID isEqualTo -1) then {
			_players = _players select {!isNull _x};
			_table setVariable ["allPlayers", _players];
		};

		if (count (_players select {!isNull _x}) >= 5) exitWith {
			["Blackjack", "Cette table de jeu est complète.", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
		};
		if (_partieID != -1) exitWith {
			["Blackjack", "La partie a déjà commencé.", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
		};
		if (_player in _players) exitWith {
			["Blackjack", "Vous êtes déjà à cette table.", "warning"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
		};

		if (count _players isEqualTo 0) then {
			_table setVariable ["time",time];
			[_table] spawn {
				params ["_tbl"];

				// Countdown messages
				uiSleep 15;
				private _p = _tbl getVariable ["allPlayers",[]];
				_p = _p select {!(isNull _x)};
				if (count _p > 0) then {
					["Blackjack", "La partie se lance dans 10 secondes !", "warning"] remoteExec ["ALF_fnc_doMsg", _p];
					private _cr = _tbl getVariable ["ALF_BJ_Croupier", objNull];
					if !(isNull _cr) then {
						["Blackjack", "La partie se lance dans 10 secondes !", "warning"] remoteExec ["ALF_fnc_doMsg", _cr];
					};
				};

				uiSleep 5;
				_p = _tbl getVariable ["allPlayers",[]];
				_p = _p select {!(isNull _x)};
				if (count _p > 0) then {
					["Blackjack", "La partie se lance dans 5 secondes !", "warning"] remoteExec ["ALF_fnc_doMsg", _p];
					private _cr = _tbl getVariable ["ALF_BJ_Croupier", objNull];
					if !(isNull _cr) then {
						["Blackjack", "La partie se lance dans 5 secondes !", "warning"] remoteExec ["ALF_fnc_doMsg", _cr];
					};
				};

				uiSleep 5;
				private _players2 = _tbl getVariable ["allPlayers",[]];
				_players2 = _players2 select {!(isNull _x)};

				if (count _players2 > 0) then {
					// Re-vérifier le croupier avant de lancer
					private _croupier = _tbl getVariable ["ALF_BJ_Croupier", objNull];
					if (isNull _croupier || {!alive _croupier} || {_croupier distance _tbl > 5}) then {
						["Blackjack", "Le croupier a quitté la table. La partie est annulée.", "danger"] remoteExec ["ALF_fnc_doMsg", _players2];
						_tbl setVariable ["allPlayers",[]];
						_tbl setVariable ["time",0];
						_tbl setVariable ["ALF_BJ_Croupier", objNull, true];
					} else {
						["Blackjack", "La partie se lance !", "success"] remoteExec ["ALF_fnc_doMsg", _players2];
						["Blackjack", "Une partie de Blackjack commence à votre table.", "success"] remoteExec ["ALF_fnc_doMsg", _croupier];
						[1,_tbl] spawn ALF_Server_fnc_playBJ;
					};
				} else {
					_tbl setVariable ["time",0];
				};
			};
		};
		private _time = _table getVariable ["time",0];

		["Blackjack", format["Vous avez rejoint cette table. Il y a %1 joueur(s). Début dans %2 seconde(s).",count(_players)+1,round(_time+25-time)], "success"] remoteExec ["ALF_fnc_doMsg",remoteExecutedOwner];
		["Blackjack", format["Un joueur a rejoint la table. Il y a %1 joueur(s). Début dans %2 seconde(s).",count(_players)+1,round(_time+25-time)], "success"] remoteExec ["ALF_fnc_doMsg",_players];

		_players pushBack _player;
		_table setVariable ["allPlayers",_players];
	};

	//Start Game - Boucle principale
	case 1: {
		// Récupérer le croupier pour les messages
		private _croupier = _table getVariable ["ALF_BJ_Croupier", objNull];

		// Helper : nom lisible d'une carte
		private _fnc_cardName = {
			params ["_card"];
			private _val = _card select 0;
			private _suit = _card select 1;
			private _valName = switch (_val) do {
				case 14: {"As"}; case 13: {"Roi"}; case 12: {"Reine"};
				case 11: {"Valet"}; default {str _val};
			};
			private _suitName = switch (_suit) do {
				case "T": {"Trèfle"}; case "CO": {"Coeur"};
				case "CA": {"Carreau"}; case "P": {"Pique"};
			};
			format["%1 de %2", _valName, _suitName]
		};

		private _partie = [500,5000000] call BIS_fnc_randomInt;
		_table setVariable ["ID",_partie];
		_table setVariable ["mises",[0,0,0,0,0]];
		_table setVariable ["playerReste",[]];
		_table setVariable ["playerTirer",[]];
		_table setVariable ["playerDoubler",[]];
		_table setVariable ["ALF_BJ_DealerHand",[]];

		// --- PHASE 1 : Demande des mises ---
		["Blackjack", "Placez vos mises ! Vous avez 60 secondes.", "warning"] remoteExec ["ALF_fnc_doMsg", _players];
		[1] remoteExec ["ALF_fnc_playBJ",_players];

		private _betTimeout = time + 60;
		private _30sWarned = false;
		private _10sWarned = false;
		waitUntil {
			uiSleep 1;
			private _m = _table getVariable ["mises",[0,0,0,0,0]];
			private _p = _table getVariable ["allPlayers",[]];
			_p = _p select {!(isNull _x)};

			// Messages de rappel
			private _remaining = _betTimeout - time;
			if (_remaining <= 30 && !_30sWarned) then {
				_30sWarned = true;
				["Blackjack", "Plus que 30 secondes pour miser !", "warning"] remoteExec ["ALF_fnc_doMsg", _p];
			};
			if (_remaining <= 10 && !_10sWarned) then {
				_10sWarned = true;
				["Blackjack", "Plus que 10 secondes pour miser !", "danger"] remoteExec ["ALF_fnc_doMsg", _p];
			};

			(count(_m select {_x != 0}) >= count _p) || (time > _betTimeout)
		};

		_players = _table getVariable ["allPlayers",[]];
		// NE PAS filtrer objNull : les index doivent rester alignés avec _mises
		private _mises = _table getVariable ["mises",[0,0,0,0,0]];

		// Joueurs qui ont misé (ignorer les slots objNull = joueurs déconnectés)
		private _activePlayers = [];
		{
			if (isNull _x) then {
				// Slot vide (joueur déconnecté), ignorer
			} else {
				if ((_mises select _forEachIndex) != 0) then {
					_activePlayers pushBack _x;
				} else {
					["Blackjack","Vous n'avez pas misé à temps. Vous êtes exclu de cette partie.", "danger"] remoteExec ["ALF_fnc_doMsg", _x];
				};
			};
		} forEach _players;

		if (count _activePlayers == 0) exitWith {
			["Blackjack", "Aucun joueur n'a misé. La partie est annulée.", "danger"] remoteExec ["ALF_fnc_doMsg", _players];
			if !(isNull _croupier) then {
				["Blackjack", "Aucun joueur n'a misé. La partie est annulée.", "danger"] remoteExec ["ALF_fnc_doMsg", _croupier];
			};
			_table setVariable ["ID",-1];
			_table setVariable ["allPlayers",[]];
			_table setVariable ["mises",[0,0,0,0,0]];
			_table setVariable ["time",0];
		};

		// --- PHASE 2 : Distribution des cartes (2 par joueur + 2 croupier) ---
		["Blackjack", "Les mises sont fermées. Distribution des cartes...", "success"] remoteExec ["ALF_fnc_doMsg", _activePlayers];
		if !(isNull _croupier) then {
			["Blackjack", format["%1 joueur(s) ont misé. Distribution des cartes...", count _activePlayers], "success"] remoteExec ["ALF_fnc_doMsg", _croupier];
		};
		uiSleep 1;

		for "_i" from 0 to 1 do {
			{
				_cards = [_x,_cards] call ALF_Server_fnc_distributeBJCards;
				uiSleep 0.25;
			} forEach _activePlayers;
		};

		// Cartes du croupier
		private _dealerHand = [];
		private _card = _cards deleteAt floor(random (count _cards));
		_dealerHand pushBack _card;
		_card = _cards deleteAt floor(random (count _cards));
		_dealerHand pushBack _card;
		_table setVariable ["ALF_BJ_DealerHand",_dealerHand];

		private _dealerScore = [_dealerHand] call ALF_Server_fnc_checkScoreBJ;

		// Montrer la 1ère carte du croupier (face visible, comme au vrai BJ)
		private _visibleCard = _dealerHand select 0;
		private _cardName = [_visibleCard] call _fnc_cardName;
		private _visibleScore = if ((_visibleCard select 0) > 10) then {
			if ((_visibleCard select 0) == 14) then {11} else {10}
		} else {_visibleCard select 0};
		["Blackjack", format["Le croupier montre : %1 (valeur : %2). La 2ème carte est cachée.", _cardName, _visibleScore], "warning"] remoteExec ["ALF_fnc_doMsg", _activePlayers];
		// Mise à jour HUD joueurs : carte visible du croupier
		[14, format["%1 + ?", _cardName]] remoteExec ["ALF_fnc_playBJ", _activePlayers];

		// Montrer la main complète au croupier (message texte + HUD visuel)
		if !(isNull _croupier) then {
			private _card1Name = [_dealerHand select 0] call _fnc_cardName;
			private _card2Name = [_dealerHand select 1] call _fnc_cardName;
			["Blackjack", format["Vos cartes : %1 + %2. Score : %3.", _card1Name, _card2Name, _dealerScore], "warning"] remoteExec ["ALF_fnc_doMsg", _croupier];
			[3, _dealerHand] remoteExec ["ALF_fnc_playBJ", _croupier];
		};

		uiSleep 1;

		// Vérifier les blackjacks naturels (21 avec 2 cartes) → auto-stand
		private _playersStillPlaying = [];
		{
			private _hand = _x getVariable ["ALF_BJ_Hand",[]];
			private _score = [_hand] call ALF_Server_fnc_checkScoreBJ;
			if (_score == 21) then {
				["Blackjack","Blackjack ! Vous avez 21 !", "success"] remoteExec ["ALF_fnc_doMsg", _x];
				// Notifier le croupier du blackjack naturel
				if !(isNull _croupier) then {
					["Blackjack", format["%1 a un Blackjack naturel (21) !", name _x], "danger"] remoteExec ["ALF_fnc_doMsg", _croupier];
				};
			} else {
				_playersStillPlaying pushBack _x;
			};
		} forEach _activePlayers;

		// --- PHASE 3 : Boucle d'actions des joueurs ---
		private _tour = 1;
		while {count _playersStillPlaying > 0} do {
			// Reset des actions pour ce tour
			_table setVariable ["playerReste",[]];
			_table setVariable ["playerTirer",[]];
			_table setVariable ["playerDoubler",[]];

			["Blackjack", format["Tour %1 — Choisissez votre action.", _tour], "warning"] remoteExec ["ALF_fnc_doMsg", _playersStillPlaying];
			{
				private _hand = _x getVariable ["ALF_BJ_Hand",[]];
				private _canDouble = count _hand == 2;
				[4, _canDouble] remoteExec ["ALF_fnc_playBJ",_x];
			} forEach _playersStillPlaying;

			// Attente des réponses (timeout 60s)
			private _actionTimeout = time + 60;
			waitUntil {
				uiSleep 1;
				private _r = count(_table getVariable ["playerReste",[]]);
				private _t = count(_table getVariable ["playerTirer",[]]);
				private _d = count(_table getVariable ["playerDoubler",[]]);
				((_r + _t + _d) >= count _playersStillPlaying) || (time > _actionTimeout)
			};

			private _reste = _table getVariable ["playerReste",[]];
			private _tirer = _table getVariable ["playerTirer",[]];
			private _doubler = _table getVariable ["playerDoubler",[]];

			// Joueurs qui n'ont pas répondu → auto-rester
			{
				if !(_x in _reste || {_x in _tirer} || {_x in _doubler}) then {
					_reste pushBack _x;
					["Blackjack","Temps écoulé. Vous restez automatiquement.", "warning"] remoteExec ["ALF_fnc_doMsg", _x];
				};
			} forEach _playersStillPlaying;

			// Traiter les joueurs qui tirent
			{
				_cards = [_x,_cards] call ALF_Server_fnc_distributeBJCards;
				private _hand = _x getVariable ["ALF_BJ_Hand",[]];
				private _score = [_hand] call ALF_Server_fnc_checkScoreBJ;
				private _lastCard = _hand select (count _hand - 1);
				private _drawnCardName = [_lastCard] call _fnc_cardName;
				if (_score > 21) then {
					["Blackjack",format["Vous avez %1. Vous dépassez 21 !",_score], "danger"] remoteExec ["ALF_fnc_doMsg", _x];
				} else {
					["Blackjack",format["Vous avez %1.",_score], "success"] remoteExec ["ALF_fnc_doMsg", _x];
				};
				// Notifier le croupier de la carte tirée
				if !(isNull _croupier) then {
					["Blackjack", format["%1 tire : %2. Score : %3.", name _x, _drawnCardName, _score], "warning"] remoteExec ["ALF_fnc_doMsg", _croupier];
				};
				uiSleep 0.5;
			} forEach _tirer;

			// Traiter les joueurs qui doublent (tirent 1 carte puis stop)
			{
				_cards = [_x,_cards] call ALF_Server_fnc_distributeBJCards;
				private _hand = _x getVariable ["ALF_BJ_Hand",[]];
				private _score = [_hand] call ALF_Server_fnc_checkScoreBJ;
				private _lastCard = _hand select (count _hand - 1);
				private _drawnCardName = [_lastCard] call _fnc_cardName;
				if (_score > 21) then {
					["Blackjack",format["Vous avez doublé et obtenu %1. Vous dépassez 21 !",_score], "danger"] remoteExec ["ALF_fnc_doMsg", _x];
				} else {
					["Blackjack",format["Vous avez doublé. Votre score est %1.",_score], "success"] remoteExec ["ALF_fnc_doMsg", _x];
				};
				// Notifier le croupier du doublage
				if !(isNull _croupier) then {
					["Blackjack", format["%1 double : %2. Score : %3.", name _x, _drawnCardName, _score], "warning"] remoteExec ["ALF_fnc_doMsg", _croupier];
				};
				uiSleep 0.5;
			} forEach _doubler;

			// Notifier le croupier des joueurs qui restent
			if !(isNull _croupier) then {
				{
					private _hand = _x getVariable ["ALF_BJ_Hand",[]];
					private _score = [_hand] call ALF_Server_fnc_checkScoreBJ;
					["Blackjack", format["%1 reste. Score : %2.", name _x, _score], "warning"] remoteExec ["ALF_fnc_doMsg", _croupier];
				} forEach _reste;
			};

			// Mettre à jour les joueurs encore actifs
			_playersStillPlaying = _playersStillPlaying select {
				private _inReste = _x in _reste;
				private _inDoubler = _x in _doubler;
				private _hand = _x getVariable ["ALF_BJ_Hand",[]];
				private _score = [_hand] call ALF_Server_fnc_checkScoreBJ;
				private _bust = _score > 21;
				!_inReste && !_inDoubler && !_bust
			};

			_tour = _tour + 1;
			uiSleep 0.5;
		};

		// --- PHASE 4 : Le croupier joue ---
		private _anyAlive = false;
		{
			if !(isNull _x) then {
				private _hand = _x getVariable ["ALF_BJ_Hand",[]];
				if (_hand isNotEqualTo []) then {
					private _score = [_hand] call ALF_Server_fnc_checkScoreBJ;
					if (_score <= 21) then {_anyAlive = true;};
				};
			};
		} forEach _activePlayers;

		_dealerHand = _table getVariable ["ALF_BJ_DealerHand",[]];
		_dealerScore = [_dealerHand] call ALF_Server_fnc_checkScoreBJ;

		if (_anyAlive) then {
			// Révéler la main complète aux joueurs
			private _allCardNames = "";
			{ _allCardNames = _allCardNames + ([_x] call _fnc_cardName) + " + "; } forEach _dealerHand;
			_allCardNames = _allCardNames select [0, count _allCardNames - 3];
			["Blackjack", format["Le croupier révèle ses cartes : %1. Score : %2.", _allCardNames, _dealerScore], "warning"] remoteExec ["ALF_fnc_doMsg", _activePlayers];
			// Mise à jour HUD joueurs : score complet du croupier après révélation
			[14, format["Score : %1", _dealerScore]] remoteExec ["ALF_fnc_playBJ", _activePlayers];
			if !(isNull _croupier) then {
				["Blackjack", format["Vos cartes : %1. Score : %2.", _allCardNames, _dealerScore], "warning"] remoteExec ["ALF_fnc_doMsg", _croupier];
			};
			uiSleep 2;

			// Boucle interactive : croupier confirme l'action (règles forcées : tirer <17, rester >=17)
			private _croupierDone = false;
			while {!_croupierDone && {_dealerScore < 21}} do {
				// Envoyer dialog au croupier (case 11)
				_table setVariable ["ALF_BJ_CroupierAction", ""];
				if !(isNull _croupier) then {
					[11, _dealerScore, _table] remoteExec ["ALF_fnc_playBJ", _croupier];
				};

				// Attendre réponse ou timeout 30s
				private _timeout = time + 30;
				waitUntil {
					uiSleep 0.5;
					(_table getVariable ["ALF_BJ_CroupierAction", ""]) != "" ||
					time > _timeout || isNull _croupier || !alive _croupier
				};

				private _action = _table getVariable ["ALF_BJ_CroupierAction", ""];

				// Timeout ou croupier déconnecté → action automatique (tirer si <17, rester sinon)
				if (_action isEqualTo "" || isNull _croupier || !alive _croupier) then {
					_action = if (_dealerScore < 17) then {"tirer"} else {"rester"};
					if !(isNull _croupier) then {
						["Blackjack", format["Temps écoulé. Action automatique : %1.", _action], "warning"] remoteExec ["ALF_fnc_doMsg", _croupier];
					};
				};

				if (_action isEqualTo "rester") then {
					_croupierDone = true;
					["Blackjack", format["Le croupier reste à %1.", _dealerScore], "warning"] remoteExec ["ALF_fnc_doMsg", _activePlayers];
					if !(isNull _croupier) then {
						["Blackjack", format["Vous restez à %1.", _dealerScore], "success"] remoteExec ["ALF_fnc_doMsg", _croupier];
					};
				} else {
					// Tirer une carte
					_card = _cards deleteAt floor(random (count _cards));
					_dealerHand pushBack _card;
					_dealerScore = [_dealerHand] call ALF_Server_fnc_checkScoreBJ;

					private _newCardName = [_card] call _fnc_cardName;
					["Blackjack", format["Le croupier tire : %1. Score : %2.", _newCardName, _dealerScore], "warning"] remoteExec ["ALF_fnc_doMsg", _activePlayers];
					// Mise à jour HUD joueurs : nouveau score du croupier après tirage
					[14, format["Score : %1", _dealerScore]] remoteExec ["ALF_fnc_playBJ", _activePlayers];
					if !(isNull _croupier) then {
						["Blackjack", format["Vous tirez : %1. Score : %2.", _newCardName, _dealerScore], "warning"] remoteExec ["ALF_fnc_doMsg", _croupier];
						[3, _dealerHand] remoteExec ["ALF_fnc_playBJ", _croupier];
					};
				};

				uiSleep 1;
			};

			// Nettoyage variable
			_table setVariable ["ALF_BJ_CroupierAction", nil];
			_table setVariable ["ALF_BJ_DealerHand",_dealerHand];

			if (_dealerScore > 21) then {
				["Blackjack",format["Le croupier a %1. Il dépasse 21 !",_dealerScore], "success"] remoteExec ["ALF_fnc_doMsg", _activePlayers];
				if !(isNull _croupier) then {
					["Blackjack",format["Vous dépassez 21 avec %1.",_dealerScore], "danger"] remoteExec ["ALF_fnc_doMsg", _croupier];
				};
			} else {
				if (_dealerScore == 21 && {!_croupierDone}) then {
					// Atteint 21 exactement après un tirage
					["Blackjack","Le croupier a 21 !", "warning"] remoteExec ["ALF_fnc_doMsg", _activePlayers];
					if !(isNull _croupier) then {
						["Blackjack","Vous avez 21 !", "success"] remoteExec ["ALF_fnc_doMsg", _croupier];
					};
				};
			};
			uiSleep 2;
		} else {
			["Blackjack", "Tous les joueurs ont dépassé 21. Le croupier ne joue pas.", "danger"] remoteExec ["ALF_fnc_doMsg", _activePlayers];
			// Mise à jour HUD joueurs : score du croupier même si tous bust
			[14, format["Score : %1", _dealerScore]] remoteExec ["ALF_fnc_playBJ", _activePlayers];
			if !(isNull _croupier) then {
				["Blackjack", "Tous les joueurs ont dépassé 21. Vous n'avez pas besoin de jouer.", "success"] remoteExec ["ALF_fnc_doMsg", _croupier];
			};
			uiSleep 1;
		};

		// --- PHASE 5 : Résultats et paiements ---
		// Filtrer les joueurs qui ont quitté en cours de partie (main nil/vide)
		private _currentPlayers = _table getVariable ["allPlayers",[]];
		_activePlayers = _activePlayers select {
			!(isNull _x) && {(_x getVariable ["ALF_BJ_Hand",[]]) isNotEqualTo []}
		};

		["Blackjack", "Résultats de la partie :", "warning"] remoteExec ["ALF_fnc_doMsg", _activePlayers];
		uiSleep 1;

		_mises = _table getVariable ["mises",[0,0,0,0,0]];
		private _totalGainCasino = 0;
		private _totalPerteCasino = 0;
		private _isDealerNaturalBJ = (_dealerScore == 21) && {count _dealerHand == 2};

		{
			private _hand = _x getVariable ["ALF_BJ_Hand",[]];
			private _score = [_hand] call ALF_Server_fnc_checkScoreBJ;
			private _ind = _players find _x;
			private _mise = _mises select _ind;
			private _isNaturalBJ = (_score == 21) && {count _hand == 2};

			if (_score > 21) then {
				// Joueur bust → perd sa mise (capital déjà ajouté)
				[7, objNull, 0] remoteExec ["ALF_fnc_playBJ", _x];
				_totalGainCasino = _totalGainCasino + _mise;
			} else {
				if (_dealerScore > 21) then {
					// Croupier bust → joueur gagne
					private _gain = if (_isNaturalBJ) then {floor(_mise * 2.5)} else {_mise * 2};
					[7, _x, _gain] remoteExec ["ALF_fnc_playBJ", _x];
					[20, _gain] call ALF_Server_fnc_withdrawCapitalBySecteur;
					_totalPerteCasino = _totalPerteCasino + _gain;
				} else {
					if (_score > _dealerScore) then {
						// Joueur bat le croupier
						private _gain = if (_isNaturalBJ) then {floor(_mise * 2.5)} else {_mise * 2};
						[7, _x, _gain] remoteExec ["ALF_fnc_playBJ", _x];
						[20, _gain] call ALF_Server_fnc_withdrawCapitalBySecteur;
						_totalPerteCasino = _totalPerteCasino + _gain;
					} else {
						if (_score isEqualTo _dealerScore) then {
							// Même score — vérifier BJ naturel vs non-naturel
							if (_isNaturalBJ && !_isDealerNaturalBJ) then {
								// BJ naturel joueur bat le 21 non-naturel du croupier
								private _gain = floor(_mise * 2.5);
								[7, _x, _gain] remoteExec ["ALF_fnc_playBJ", _x];
								[20, _gain] call ALF_Server_fnc_withdrawCapitalBySecteur;
								_totalPerteCasino = _totalPerteCasino + _gain;
							} else {
								if (!_isNaturalBJ && _isDealerNaturalBJ) then {
									// BJ naturel croupier bat le 21 non-naturel du joueur
									[7, objNull, 0] remoteExec ["ALF_fnc_playBJ", _x];
									_totalGainCasino = _totalGainCasino + _mise;
								} else {
									// Même type de 21 (les deux naturels ou les deux non-naturels) → push
									[9, _mise] remoteExec ["ALF_fnc_playBJ", _x];
									[20, _mise] call ALF_Server_fnc_withdrawCapitalBySecteur;
								};
							};
						} else {
							// Croupier gagne → capital déjà ajouté lors de la mise
							[7, objNull, 0] remoteExec ["ALF_fnc_playBJ", _x];
							_totalGainCasino = _totalGainCasino + _mise;
						};
					};
				};
			};

			_x setVariable ["ALF_BJ_Hand",nil];
		} forEach _activePlayers;

		// Résumé pour le croupier
		if !(isNull _croupier) then {
			if (_totalGainCasino > 0 && _totalPerteCasino > 0) then {
				["Blackjack", format["Bilan : +%1 € (gains) / -%2 € (pertes) pour le casino.", _totalGainCasino, _totalPerteCasino], "warning"] remoteExec ["ALF_fnc_doMsg", _croupier];
			} else {
				if (_totalGainCasino > 0) then {
					["Blackjack", format["Le casino gagne %1 € cette partie.", _totalGainCasino], "success"] remoteExec ["ALF_fnc_doMsg", _croupier];
				} else {
					["Blackjack", format["Le casino perd %1 € cette partie.", _totalPerteCasino], "danger"] remoteExec ["ALF_fnc_doMsg", _croupier];
				};
			};
		};

		// Cleanup HUD croupier
		if !(isNull _croupier) then {
			[12] remoteExec ["ALF_fnc_playBJ", _croupier];
		};

		// --- PHASE 6 : Nettoyage de la table ---
		_table setVariable ["ID",-1];
		_table setVariable ["allPlayers",[]];
		_table setVariable ["mises",[0,0,0,0,0]];
		_table setVariable ["playerReste",[]];
		_table setVariable ["playerTirer",[]];
		_table setVariable ["playerDoubler",[]];
		_table setVariable ["ALF_BJ_DealerHand",[]];
		_table setVariable ["time",0];
	};

	//Return mise
	case 2: {
		private _mises = _table getVariable ["mises",[0,0,0,0,0]];
		private _mise = _this select 3;

		// --- Validation serveur ---
		if !(_mise isEqualType 0) exitWith {};
		if (_mise < 500) exitWith {
			["Blackjack","La mise minimale est de 500 €.", "warning"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
		};
		if (_mise > 10000000) exitWith {
			["Blackjack","Mise invalide.", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
		};
		private _ind = _players find _player;
		if (_ind < 0) exitWith {};
		if ((_mises select _ind) != 0) exitWith {
			["Blackjack","Vous avez déjà misé.", "warning"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
		};

		_mises set[_ind, _mise];
		_table setVariable ["mises",_mises];

		// Ajouter la mise au capital du casino (secteur 20)
		[20, _mise] call ALF_Server_fnc_addCapitalBySecteur;

		["Blackjack", format["Votre mise de %1 € a été enregistrée. En attente des autres joueurs...", _mise], "success"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];

		// Notifier le croupier
		private _croupier = _table getVariable ["ALF_BJ_Croupier", objNull];
		if !(isNull _croupier) then {
			["Blackjack", format["%1 a misé %2 €.", name _player, _mise], "success"] remoteExec ["ALF_fnc_doMsg", _croupier];
		};
	};

	//Return action
	case 3: {
		private _action = _this select 3;

		switch (true) do {
			case (_action isEqualTo "rester"): {
				private _playerReste = _table getVariable ["playerReste",[]];
				_playerReste pushBack _player;
				_table setVariable ["playerReste",_playerReste];
			};
			case (_action isEqualTo "tirer"): {
				private _playerTirer = _table getVariable ["playerTirer",[]];
				_playerTirer pushBack _player;
				_table setVariable ["playerTirer",_playerTirer];
			};
			case (_action isEqualTo "doubler"): {
				// Le client doit envoyer exactement le montant de sa mise initiale
				private _doubleAmount = if (count _this > 4) then {_this select 4} else {0};
				private _mises = _table getVariable ["mises",[0,0,0,0,0]];
				private _ind = _players find _player;
				private _ancienneMise = if (_ind >= 0) then {_mises select _ind} else {0};

				// --- Validation serveur ---
				// Le joueur doit avoir une mise existante et le montant doit être valide
				if (_ind < 0 || {_ancienneMise <= 0}) exitWith {
					// Joueur invalide → traiter comme "rester"
					private _playerReste = _table getVariable ["playerReste",[]];
					_playerReste pushBack _player;
					_table setVariable ["playerReste",_playerReste];
				};

				// Vérifier que le joueur a seulement 2 cartes (condition pour doubler)
				private _hand = _player getVariable ["ALF_BJ_Hand",[]];
				if (count _hand != 2) exitWith {
					["Blackjack","Vous ne pouvez doubler qu'avec 2 cartes.", "warning"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
					private _playerReste = _table getVariable ["playerReste",[]];
					_playerReste pushBack _player;
					_table setVariable ["playerReste",_playerReste];
				};

				if (_doubleAmount != _ancienneMise) exitWith {
					["Blackjack","Double refusé : il faut avoir exactement la somme de la mise pour doubler.", "warning"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
				};

				private _playerDoubler = _table getVariable ["playerDoubler",[]];
				_playerDoubler pushBack _player;
				_table setVariable ["playerDoubler",_playerDoubler];

				_mises set[_ind, _ancienneMise + _doubleAmount];
				_table setVariable ["mises",_mises];

				// Ajouter le montant réel au capital du casino (secteur 20)
				[20, _doubleAmount] call ALF_Server_fnc_addCapitalBySecteur;

				["Blackjack", format["Votre mise est maintenant de %1 €.",(_mises select _ind)], "success"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
			};
		};
	};

	//Joueur quitte la table (distance ou déconnexion)
	case 4: {
		// Marquer le joueur comme absent (objNull) sans décaler les index
		private _allPlayers = _table getVariable ["allPlayers",[]];
		private _idx = _allPlayers find _player;
		if (_idx >= 0) then { _allPlayers set [_idx, objNull]; };
		_table setVariable ["allPlayers",_allPlayers];

		// Aussi le mettre dans playerReste pour ne pas bloquer les waitUntil
		private _playerReste = _table getVariable ["playerReste",[]];
		_playerReste pushBack _player;
		_table setVariable ["playerReste",_playerReste];

		// Nettoyer sa main
		_player setVariable ["ALF_BJ_Hand",nil];
	};

	// Croupier prend/quitte une table
	case 6: {
		private _setAsCroupier = if (count _this > 3) then {(_this select 3) isEqualTo 1} else {false};
		private _current = _table getVariable ["ALF_BJ_Croupier", objNull];

		if (_setAsCroupier) then {
			if !(isNull _current) exitWith {
				if !(_current isEqualTo _player) then {
					["Blackjack","Cette table a deja un croupier.", "warning"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
				};
			};

			_table setVariable ["ALF_BJ_Croupier", _player, true];
		} else {
			if (_current isEqualTo _player) then {
				_table setVariable ["ALF_BJ_Croupier", objNull, true];
			};
		};
	};
};
