#include "\ALF_Core\SERVER\script_macros.hpp"
/*
	File: fn_playPoker.sqf
	Author: ALF Team

	Texas Hold'em Poker — Serveur
	Paramètres : [_allPlayers, _table]
*/
params [
	["_allPlayers",[],[[]]],
	["_table",objNull,[objNull]]
];

// Anti-spoof : valider la table, l'owner appelant et la liste des joueurs
if (isNull _table || {((toLowerANSI (typeOf _table)) find "alf_poker") isEqualTo -1}) exitWith {};

private _caller = remoteExecutedOwner call BIS_fnc_getUnitByOwner;
if (isNull _caller || {!isPlayer _caller}) exitWith {};
if !(_caller in _table) exitWith {
	["Poker", "Vous devez être assis à cette table.", "danger", false] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
};

private _validatedPlayers = [];
{
	if (!isNull _x && {alive _x} && {isPlayer _x} && {_x in _table} && {!(_x in _validatedPlayers)}) then {
		_validatedPlayers pushBack _x;
	};
} forEach _allPlayers;
_allPlayers = _validatedPlayers;

if !(_caller in _allPlayers) exitWith {
	["Poker", "Démarrage refusé (joueurs invalides).", "danger", false] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
};

if ((count _allPlayers) < 2 || {(count _allPlayers) > 8}) exitWith {
	["Poker", "Vous devez être entre 2 et 8 joueurs assis pour lancer une partie.", "danger", false] remoteExec ["ALF_fnc_doMsg", _allPlayers select {!(isNull _x)}];
};

// === Vérification du verrou : empêcher les parties simultanées ===
if (_table getVariable ["ALF_Poker_InGame", false]) exitWith {
	["Poker", "Une partie est déjà en cours à cette table.", "danger", false] remoteExec ["ALF_fnc_doMsg", _allPlayers select {!(isNull _x)}];
};
_table setVariable ["ALF_Poker_InGame", true, true];

diag_log format["Poker : démarrage partie avec %1 joueurs", count _allPlayers];
_table allowDamage false;

private _cards = [[14,"T"],[14,"CO"],[14,"CA"],[14,"P"],[13,"T"],[13,"CO"],[13,"CA"],[13,"P"],[12,"T"],[12,"CO"],[12,"CA"],[12,"P"],[11,"T"],[11,"CO"],[11,"CA"],[11,"P"],[10,"T"],[10,"CO"],[10,"CA"],[10,"P"],[9,"T"],[9,"CO"],[9,"CA"],[9,"P"],[8,"T"],[8,"CO"],[8,"CA"],[8,"P"],[7,"T"],[7,"CO"],[7,"CA"],[7,"P"],[6,"T"],[6,"CO"],[6,"CA"],[6,"P"],[5,"T"],[5,"CO"],[5,"CA"],[5,"P"],[4,"T"],[4,"CO"],[4,"CA"],[4,"P"],[3,"T"],[3,"CO"],[3,"CA"],[3,"P"],[2,"T"],[2,"CO"],[2,"CA"],[2,"P"]];
private _partie = [500,5000000] call BIS_fnc_randomInt;
private _activePlayers = +_allPlayers;
private _pot = 0;
private _aborted = false;

// Un joueur est actif seulement s'il est vivant et toujours assis a cette table.
private _fnc_isSeatActive = {
	params ["_player", "_tbl"];
	!isNull _player && {alive _player} && {_player in _tbl}
};

// Helper : générer le chemin texture d'une carte (inline car ALF_fnc_recupPokerTexture est client-only)
private _fnc_getTexture = {
	params ["_carte"];
	if (_carte isEqualTo []) exitWith {""};
	private _val = _carte select 0;
	private _suit = _carte select 1;
	private _suitName = switch (_suit) do {
		case "T": {"trefle"}; case "CO": {"coeur"};
		case "CA": {"carreau"}; case "P": {"pique"};
	};
	if (_val <= 10) then {
		format["\ALF_Poker\data\%1_%2.paa", _val, _suitName]
	} else {
		private _valName = switch (_val) do {
			case 11: {"valet"}; case 12: {"reine"};
			case 13: {"roi"}; case 14: {"as"};
		};
		format["\ALF_Poker\data\%1_%2.paa", _valName, _suitName]
	};
};

// Helper : convertir une carte en texte court (ex: "A♠", "R♥", "10♣")
private _fnc_cardText = {
	params ["_carte"];
	private _val = _carte select 0;
	private _suit = _carte select 1;
	private _suitSymbol = switch (_suit) do {
		case "T": {"T"}; case "CO": {"CO"};
		case "CA": {"CA"}; case "P": {"P"};
	};
	private _valText = switch (_val) do {
		case 14: {"A"}; case 13: {"R"}; case 12: {"D"}; case 11: {"V"};
		default {str _val};
	};
	format["%1%2", _valText, _suitSymbol]
};

// Stocker l'état sur la table
_table setVariable ["ALF_Poker_Partie", _partie];
_table setVariable ["ALF_Poker_Pot", 0];
_table setVariable ["ALF_Poker_PlayerBets", []]; // [[player, totalMisé], ...]

// Initialiser les mises par joueur (pour le remboursement en cas d'erreur)
private _playerBets = [];
{ _playerBets pushBack [_x, 0]; } forEach _allPlayers;

// === Initialiser TOUS les clients (ALF_Current_Table, monitoring) ===
{[11, _table, _partie] remoteExec ["ALF_fnc_playPoker", _x];} forEach _activePlayers;
uiSleep 1;

// ============================================================
// HELPER : Tour de mise
// Retourne [_activePlayers, _pot, _currentBet]
// ============================================================
private _fnc_bettingRound = {
	params ["_activePlayers", "_startIndex", "_currentBet", "_pot", "_partie", "_table", "_playerBets", ["_initialBets", [], [[]]], ["_allPlayersRef", [], [[]]]];

	private _numPlayers = count _activePlayers;
	if (_numPlayers <= 1) exitWith {[_activePlayers, _pot, _currentBet, _playerBets]};

	// Nombre de joueurs qui doivent encore agir
	private _playersToAct = _numPlayers;
	private _currentIndex = _startIndex mod _numPlayers;
	private _roundBets = []; // [[player, montant misé ce tour], ...]
	{ _roundBets pushBack [_x, 0]; } forEach _activePlayers;

	// Appliquer les mises initiales (blinds au pre-flop)
	{
		private _p = _x select 0;
		private _v = _x select 1;
		{ if ((_x select 0) isEqualTo _p) exitWith { _x set [1, _v]; }; } forEach _roundBets;
	} forEach _initialBets;

	while {_playersToAct > 0 && {count _activePlayers > 1}} do {
		// Exclure immediatement les joueurs qui ont quitte la table.
		_activePlayers = _activePlayers select {[_x, _table] call _fnc_isSeatActive};
		_roundBets = _roundBets select {(_x select 0) in _activePlayers};
		if (count _activePlayers <= 1) exitWith {};

		if (_currentIndex >= count _activePlayers) then { _currentIndex = 0; };
		private _player = _activePlayers select _currentIndex;

		// Combien ce joueur a déjà misé ce tour
		private _playerRoundBet = 0;
		{ if ((_x select 0) isEqualTo _player) exitWith { _playerRoundBet = _x select 1; }; } forEach _roundBets;
		private _toCall = _currentBet - _playerRoundBet;

		// Envoyer le bon dialog au client
		missionNamespace setVariable [format["ALF_Poker%1_CurrentAction", _partie], "", true];

		if (_toCall <= 0) then {
			// Rien à payer : Checker / Miser / Se coucher
			[2, _partie, 0] remoteExec ["ALF_fnc_playPoker", _player];
		} else {
			// Il y a une mise à suivre : Suivre / Relancer / Se coucher
			[3, _partie, _currentBet, _toCall] remoteExec ["ALF_fnc_playPoker", _player];
		};

		// Attendre la réponse avec timeout 60s
		private _timeout = time + 60;
		waitUntil {
			uiSleep 0.5;
			private _action = missionNamespace getVariable [format["ALF_Poker%1_CurrentAction", _partie], ""];
			!(_action isEqualType "") || {time > _timeout} || {!([_player, _table] call _fnc_isSeatActive)}
		};

		private _action = missionNamespace getVariable [format["ALF_Poker%1_CurrentAction", _partie], ""];

		// Timeout ou joueur non assis/deconnecte/mort -> auto-fold
		if (_action isEqualType "" || {!([_player, _table] call _fnc_isSeatActive)}) then {
			_action = ["coucher", -1];
			if (!isNull _player && {alive _player}) then {
				["Poker", "Temps écoulé. Vous vous couchez automatiquement.", "warning", false] remoteExec ["ALF_fnc_doMsg", _player];
			};
		};

		private _actionType = _action select 0;
		private _actionValue = _action select 1;
		private _broadcastTargets = _allPlayersRef select {!(isNull _x)};

		// Validation serveur : type/borne pour limiter les montants injectés côté client
		if (_actionType in ["miser","suivre","relancer"]) then {
			if !(_actionValue isEqualType 0) then {
				diag_log format["[POKER-SEC] Valeur d'action invalide (%1) de %2, converti en fold", _actionValue, name _player];
				_actionType = "coucher";
				_actionValue = -1;
			} else {
				if (_actionValue <= 0 || {_actionValue > 10000000}) then {
					diag_log format["[POKER-SEC] Valeur hors bornes (%1) de %2, converti en fold", _actionValue, name _player];
					_actionType = "coucher";
					_actionValue = -1;
				};
			};
		};

		// Anti-triche : checker interdit si mise à suivre
		if (_actionType isEqualTo "checker" && {_toCall > 0}) then {
			diag_log format["Poker : %1 checker invalide (toCall=%2), converti en fold", name _player, _toCall];
			_actionType = "coucher";
			_actionValue = -1;
		};

		// Anti-triche : miser interdit si mise à suivre (doit relancer, pas miser)
		if (_actionType isEqualTo "miser" && {_toCall > 0}) then {
			diag_log format["Poker : %1 miser invalide (toCall=%2), converti en fold", name _player, _toCall];
			_actionType = "coucher";
			_actionValue = -1;
		};

		switch (_actionType) do {
			case "checker": {
				diag_log format["Poker : %1 checke", name _player];
				["Poker", format["%1 checke. Pot : %2 €.", name _player, _pot], "info", false] remoteExec ["ALF_fnc_doMsg", _broadcastTargets];
				_playersToAct = _playersToAct - 1;
				_currentIndex = _currentIndex + 1;
			};

			case "miser": {
				// Validation serveur : mise minimum 500 €
				if (_actionValue < 500) then { _actionValue = 500; };
				diag_log format["Poker : %1 mise %2", name _player, _actionValue];
				_pot = _pot + _actionValue;
				// Le nouveau currentBet doit inclure ce que le joueur avait déjà investi (ex: blind)
				_currentBet = _playerRoundBet + _actionValue;

				// Mettre à jour round bets (total investi ce tour)
				{ if ((_x select 0) isEqualTo _player) exitWith { _x set [1, _playerRoundBet + _actionValue]; }; } forEach _roundBets;
				// Mettre à jour total bets
				{ if ((_x select 0) isEqualTo _player) exitWith { _x set [1, (_x select 1) + _actionValue]; }; } forEach _playerBets;

				// Capital casino
				[20, _actionValue] call ALF_Server_fnc_addCapitalBySecteur;

				["Poker", format["%1 mise %2 €. Pot : %3 €.", name _player, _actionValue, _pot], "info", false] remoteExec ["ALF_fnc_doMsg", _broadcastTargets];

				// Tous les autres doivent agir à nouveau
				_playersToAct = (count _activePlayers) - 1;
				_currentIndex = _currentIndex + 1;
			};

			case "suivre": {
				if (_actionValue > _toCall) then {
					diag_log format["[POKER-SEC] Suivi surévalué (%1 > %2) de %3, clamp", _actionValue, _toCall, name _player];
					_actionValue = _toCall;
				};
				diag_log format["Poker : %1 suit %2", name _player, _actionValue];
				_pot = _pot + _actionValue;

				// Mettre à jour round bets
				{ if ((_x select 0) isEqualTo _player) exitWith { _x set [1, (_x select 1) + _actionValue]; }; } forEach _roundBets;
				// Mettre à jour total bets
				{ if ((_x select 0) isEqualTo _player) exitWith { _x set [1, (_x select 1) + _actionValue]; }; } forEach _playerBets;

				// Capital casino
				[20, _actionValue] call ALF_Server_fnc_addCapitalBySecteur;

				["Poker", format["%1 suit (%2 €). Pot : %3 €.", name _player, _actionValue, _pot], "info", false] remoteExec ["ALF_fnc_doMsg", _broadcastTargets];

				_playersToAct = _playersToAct - 1;
				_currentIndex = _currentIndex + 1;
			};

			case "relancer": {
				diag_log format["Poker : %1 relance à %2", name _player, _actionValue];
				// _actionValue = montant total que le joueur met (incluant le call)
				private _newBet = _playerRoundBet + _actionValue;

				// Validation serveur : la relance doit augmenter la mise courante
				if (_newBet <= _currentBet) then {
					// All-in insuffisant pour relancer → traiter comme un suivi
					diag_log format["Poker : relance de %1 insuffisante (%2 <= %3), converti en suivi", name _player, _newBet, _currentBet];
					_pot = _pot + _actionValue;

					{ if ((_x select 0) isEqualTo _player) exitWith { _x set [1, (_x select 1) + _actionValue]; }; } forEach _roundBets;
					{ if ((_x select 0) isEqualTo _player) exitWith { _x set [1, (_x select 1) + _actionValue]; }; } forEach _playerBets;

					[20, _actionValue] call ALF_Server_fnc_addCapitalBySecteur;

					["Poker", format["%1 suit (tapis %2 €). Pot : %3 €.", name _player, _actionValue, _pot], "info", false] remoteExec ["ALF_fnc_doMsg", _broadcastTargets];

					_playersToAct = _playersToAct - 1;
					_currentIndex = _currentIndex + 1;
				} else {
					_pot = _pot + _actionValue;
					_currentBet = _newBet;

					// Mettre à jour round bets
					{ if ((_x select 0) isEqualTo _player) exitWith { _x set [1, _newBet]; }; } forEach _roundBets;
					// Mettre à jour total bets
					{ if ((_x select 0) isEqualTo _player) exitWith { _x set [1, (_x select 1) + _actionValue]; }; } forEach _playerBets;

					// Capital casino
					[20, _actionValue] call ALF_Server_fnc_addCapitalBySecteur;

					["Poker", format["%1 relance à %2 €. Pot : %3 €.", name _player, _newBet, _pot], "info", false] remoteExec ["ALF_fnc_doMsg", _broadcastTargets];

					// Tous les autres doivent agir
					_playersToAct = (count _activePlayers) - 1;
					_currentIndex = _currentIndex + 1;
				};
			};

			case "coucher": {
				diag_log format["Poker : %1 se couche", name _player];
				["Poker", format["%1 se couche.", name _player], "info", false] remoteExec ["ALF_fnc_doMsg", _broadcastTargets];
				_activePlayers = _activePlayers - [_player];
				// Ne pas incrémenter _currentIndex car le joueur a été retiré
				_playersToAct = _playersToAct - 1;
				// Recalculer roundBets
				_roundBets = _roundBets select {!((_x select 0) isEqualTo _player)};
			};
		};

		if (count _activePlayers <= 1) exitWith {};
	};

	[_activePlayers, _pot, _currentBet, _playerBets]
};

// ============================================================
// HELPER : Trouver le premier joueur actif après une position de référence
// Utilisé pour le post-flop (commence après le dealer)
// ============================================================
private _fnc_findPostFlopStart = {
	params ["_activePlayers", "_allPlayers", "_refIdx"];
	private _n = count _allPlayers;
	private _result = 0;
	for "_i" from 1 to _n do {
		private _checkPlayer = _allPlayers select ((_refIdx + _i) mod _n);
		private _idx = _activePlayers find _checkPlayer;
		if (_idx >= 0) exitWith { _result = _idx; };
	};
	_result
};

// ============================================================
// PHASE 0 : Distribution des cartes (2 par joueur)
// ============================================================
private _exit = false;
for "_i" from 0 to 1 do {
	if (!_exit) then {
		{
			if (isNull _x || {!alive _x}) exitWith { _exit = true; };
			_cards = [_x, _cards] call ALF_Server_fnc_distributeCards;
			uiSleep 0.25;
		} forEach _activePlayers;
	};
};

if (_exit) exitWith {
	[8] remoteExec ["ALF_fnc_playPoker", _allPlayers select {!(isNull _x)}];
	// Nettoyage complet
	{
		_x setVariable ["ALF_Poker_Hand", nil];
	} forEach _allPlayers;
	_table setVariable ["ALF_Poker_Partie", nil];
	_table setVariable ["ALF_Poker_Pot", nil];
	_table setVariable ["ALF_Poker_PlayerBets", nil];
	_table setVariable ["ALF_Poker_InGame", false, true];
};

// Sélectionner les 5 cartes de la table
private _carteTable = [];
for "_i" from 0 to 4 do {
	private _card = _cards deleteAt floor(random (count _cards));
	_carteTable pushBack _card;
};

// ============================================================
// PHASE 1 : PRE-FLOP (Blinds)
// ============================================================
private _dealerIdx = ((_table getVariable ["ALF_Poker_DealerIdx", -1]) + 1) mod (count _activePlayers);
_table setVariable ["ALF_Poker_DealerIdx", _dealerIdx];

// Heads-up (2 joueurs) : le dealer est SB, l'autre est BB
// 3+ joueurs : SB = dealer+1, BB = dealer+2
private _sbIdx = 0;
private _bbIdx = 0;
if (count _activePlayers == 2) then {
	_sbIdx = _dealerIdx;
	_bbIdx = (_dealerIdx + 1) mod 2;
} else {
	_sbIdx = (_dealerIdx + 1) mod (count _activePlayers);
	_bbIdx = (_dealerIdx + 2) mod (count _activePlayers);
};

private _sbPlayer = _activePlayers select _sbIdx;
private _bbPlayer = _activePlayers select _bbIdx;
private _sbAmount = 250;
private _bbAmount = 500;

// Noms de variables pour les blinds payées
private _sbPaidVar = format["ALF_Poker_BlindPaid_%1", getPlayerUID _sbPlayer];
private _bbPaidVar = format["ALF_Poker_BlindPaid_%1", getPlayerUID _bbPlayer];

// Notifier et forcer les blinds
[10, _sbAmount, "petite"] remoteExec ["ALF_fnc_playPoker", _sbPlayer];
[10, _bbAmount, "grosse"] remoteExec ["ALF_fnc_playPoker", _bbPlayer];

// Sécurité : les blinds côté serveur sont fixes (ne pas faire confiance au montant reporté client)
private _sbPaidRaw = _table getVariable [_sbPaidVar, _sbAmount];
private _bbPaidRaw = _table getVariable [_bbPaidVar, _bbAmount];
private _sbPaid = _sbAmount;
private _bbPaid = _bbAmount;
if (_sbPaidRaw != _sbAmount || {_bbPaidRaw != _bbAmount}) then {
	diag_log format ["[POKER-SEC] Blind mismatch ignoré : SB raw=%1 expected=%2 | BB raw=%3 expected=%4", _sbPaidRaw, _sbAmount, _bbPaidRaw, _bbAmount];
};

// Nettoyer les variables temporaires
_table setVariable [_sbPaidVar, nil];
_table setVariable [_bbPaidVar, nil];

_pot = _pot + _sbPaid + _bbPaid;

// Capital casino pour les blinds (montants réels)
[20, _sbPaid] call ALF_Server_fnc_addCapitalBySecteur;
[20, _bbPaid] call ALF_Server_fnc_addCapitalBySecteur;

// Tracker les blinds dans playerBets (montants réels)
{ if ((_x select 0) isEqualTo _sbPlayer) exitWith { _x set [1, (_x select 1) + _sbPaid]; }; } forEach _playerBets;
{ if ((_x select 0) isEqualTo _bbPlayer) exitWith { _x set [1, (_x select 1) + _bbPaid]; }; } forEach _playerBets;

["Poker", format["Blinds : %1 (SB: %2 €) — %3 (BB: %4 €) | Pot: %5 €", name _sbPlayer, _sbPaid, name _bbPlayer, _bbPaid, _pot], "warning", false] remoteExec ["ALF_fnc_doMsg", _allPlayers select {!(isNull _x)}];
uiSleep 1;

// HUD : pré-flop, aucune carte communautaire
[12, "Cartes sur tapis : -", format["Pot : %1 €", _pot]] remoteExec ["ALF_fnc_playPoker", _activePlayers select {!isNull _x}];

// Tour de mise pre-flop : heads-up = SB/dealer agit en premier, sinon après la BB
private _startIdx = if (count _activePlayers == 2) then {_sbIdx} else {(_bbIdx + 1) mod (count _activePlayers)};
private _initialBets = [[_sbPlayer, _sbPaid], [_bbPlayer, _bbPaid]];
private _result = [_activePlayers, _startIdx, _bbPaid, _pot, _partie, _table, _playerBets, _initialBets, _allPlayers] call _fnc_bettingRound;
_activePlayers = _result select 0;
_pot = _result select 1;
_playerBets = _result select 3;

// HUD : mettre à jour le pot après les mises pre-flop
{[12, "", format["Pot : %1 €", _pot]] remoteExec ["ALF_fnc_playPoker", _x];} forEach (_activePlayers select {!isNull _x});

// Vérifier s'il ne reste qu'un joueur
if (count _activePlayers <= 1) then { _exit = true; };

// ============================================================
// PHASE 2 : FLOP (3 cartes)
// ============================================================
if (!_exit) then {
	_table setObjectTextureGlobal [0, ([_carteTable select 0] call _fnc_getTexture)];
	_table setObjectTextureGlobal [1, ([_carteTable select 1] call _fnc_getTexture)];
	_table setObjectTextureGlobal [2, ([_carteTable select 2] call _fnc_getTexture)];

	["Poker", format["Flop ! Pot: %1 €", _pot], "success", false] remoteExec ["ALF_fnc_doMsg", _allPlayers select {!(isNull _x)}];
	uiSleep 2;

	// HUD : afficher les 3 cartes communautaires du flop
	private _flopText = format["Cartes sur tapis : %1  %2  %3",
		[_carteTable select 0] call _fnc_cardText,
		[_carteTable select 1] call _fnc_cardText,
		[_carteTable select 2] call _fnc_cardText];
	[12, _flopText, format["Pot : %1 €", _pot]] remoteExec ["ALF_fnc_playPoker", _activePlayers];

	// Tour de mise post-flop : premier joueur actif après le dealer
	_startIdx = [_activePlayers, _allPlayers, _dealerIdx] call _fnc_findPostFlopStart;
	_result = [_activePlayers, _startIdx, 0, _pot, _partie, _table, _playerBets, [], _allPlayers] call _fnc_bettingRound;
	_activePlayers = _result select 0;
	_pot = _result select 1;
	_playerBets = _result select 3;

	// HUD : mettre à jour le pot après les mises du flop
	{[12, "", format["Pot : %1 €", _pot]] remoteExec ["ALF_fnc_playPoker", _x];} forEach (_activePlayers select {!isNull _x});

	if (count _activePlayers <= 1) then { _exit = true; };
};

// ============================================================
// PHASE 3 : TURN (1 carte)
// ============================================================
if (!_exit) then {
	_table setObjectTextureGlobal [3, ([_carteTable select 3] call _fnc_getTexture)];

	["Poker", format["Turn ! Pot: %1 €", _pot], "success", false] remoteExec ["ALF_fnc_doMsg", _allPlayers select {!(isNull _x)}];
	uiSleep 2;

	// HUD : afficher les 4 cartes communautaires (flop + turn)
	private _turnText = format["Cartes sur tapis : %1  %2  %3  %4",
		[_carteTable select 0] call _fnc_cardText,
		[_carteTable select 1] call _fnc_cardText,
		[_carteTable select 2] call _fnc_cardText,
		[_carteTable select 3] call _fnc_cardText];
	[12, _turnText, format["Pot : %1 €", _pot]] remoteExec ["ALF_fnc_playPoker", _activePlayers];

	_startIdx = [_activePlayers, _allPlayers, _dealerIdx] call _fnc_findPostFlopStart;
	_result = [_activePlayers, _startIdx, 0, _pot, _partie, _table, _playerBets, [], _allPlayers] call _fnc_bettingRound;
	_activePlayers = _result select 0;
	_pot = _result select 1;
	_playerBets = _result select 3;

	// HUD : mettre à jour le pot après les mises du turn
	{[12, "", format["Pot : %1 €", _pot]] remoteExec ["ALF_fnc_playPoker", _x];} forEach (_activePlayers select {!isNull _x});

	if (count _activePlayers <= 1) then { _exit = true; };
};

// ============================================================
// PHASE 4 : RIVER (1 carte)
// ============================================================
if (!_exit) then {
	_table setObjectTextureGlobal [4, ([_carteTable select 4] call _fnc_getTexture)];

	["Poker", format["River ! Pot: %1 €", _pot], "success", false] remoteExec ["ALF_fnc_doMsg", _allPlayers select {!(isNull _x)}];
	uiSleep 2;

	// HUD : afficher les 5 cartes communautaires (flop + turn + river)
	private _riverText = format["Cartes sur tapis : %1  %2  %3  %4  %5",
		[_carteTable select 0] call _fnc_cardText,
		[_carteTable select 1] call _fnc_cardText,
		[_carteTable select 2] call _fnc_cardText,
		[_carteTable select 3] call _fnc_cardText,
		[_carteTable select 4] call _fnc_cardText];
	[12, _riverText, format["Pot : %1 €", _pot]] remoteExec ["ALF_fnc_playPoker", _activePlayers];

	_startIdx = [_activePlayers, _allPlayers, _dealerIdx] call _fnc_findPostFlopStart;
	_result = [_activePlayers, _startIdx, 0, _pot, _partie, _table, _playerBets, [], _allPlayers] call _fnc_bettingRound;
	_activePlayers = _result select 0;
	_pot = _result select 1;
	_playerBets = _result select 3;
};

// ============================================================
// NETTOYAGE : retirer les textures de la table
// ============================================================
for "_i" from 0 to 4 do {
	_table setObjectTextureGlobal [_i, ""];
};

// ============================================================
// HELPERS : Noms de mains pour le showdown
// ============================================================
private _fnc_valName = {
	params ["_val"];
	switch (_val) do {
		case 14: {"As"};
		case 13: {"Rois"};
		case 12: {"Dames"};
		case 11: {"Valets"};
		case 10: {"10"};
		default {str _val};
	};
};

private _fnc_handName = {
	params ["_score"];
	private _rank = _score select 0;
	switch (_rank) do {
		case 0: {format["Hauteur %1", [_score select 1] call _fnc_valName]};
		case 1: {format["Paire de %1", [_score select 1] call _fnc_valName]};
		case 2: {format["Double paire %1 et %2", [_score select 1] call _fnc_valName, [_score select 2] call _fnc_valName]};
		case 3: {format["Brelan de %1", [_score select 1] call _fnc_valName]};
		case 4: {"Quinte"};
		case 5: {"Couleur"};
		case 6: {format["Full %1 par les %2", [_score select 1] call _fnc_valName, [_score select 2] call _fnc_valName]};
		case 7: {format["Carré de %1", [_score select 1] call _fnc_valName]};
		case 8: {"Quinte flush"};
		case 9: {"Quinte flush royale"};
		default {"Main inconnue"};
	};
};

// ============================================================
// PHASE 5 : SHOWDOWN / Résultats
// ============================================================
_activePlayers = _activePlayers select {[_x, _table] call _fnc_isSeatActive};
private _validPlayers = _allPlayers select {!(isNull _x) && {alive _x}};

if (count _activePlayers == 0) then {
	// Tous se sont couchés ou déconnectés
	[8] remoteExec ["ALF_fnc_playPoker", _validPlayers];
} else {
	if (count _activePlayers == 1) then {
		// Un seul joueur restant → il gagne le pot (pas de showdown)
		private _gagnant = _activePlayers select 0;
		private _winReason = "forfait des autres joueurs";

		// Envoyer le gain au gagnant avec raison explicite (évite le message vide côté client)
		[7, _gagnant, _pot, _winReason] remoteExec ["ALF_fnc_playPoker", _gagnant];
		// Envoyer la notification aux perdants
		private _losers = _validPlayers - [_gagnant];
		if (count _losers > 0) then {
			[7, _gagnant, 0, _winReason] remoteExec ["ALF_fnc_playPoker", _losers];
		};

		[20, _pot] call ALF_Server_fnc_withdrawCapitalBySecteur;
	} else {
		// Showdown : évaluer les mains
		private _allScores = [];
		{
			private _hand = _x getVariable ["ALF_Poker_Hand", []];
			private _fullHand = _carteTable + _hand;
			private _score = [_fullHand] call ALF_Server_fnc_checkScore;
			_allScores pushBack [_score, _x];
		} forEach _activePlayers;

		// Trier par score décroissant
		_allScores sort false;

		private _bestScore = (_allScores select 0) select 0;
		private _handName = [_bestScore] call _fnc_handName;

		// Trouver tous les gagnants (égalité possible)
		private _winners = (_allScores select { (_x select 0) isEqualTo _bestScore }) apply { _x select 1 };

		if (count _winners > 1) then {
			// Égalité — partager le pot
			private _share = floor(_pot / (count _winners));
			private _tieHandName = format["%1 (pot partagé)", _handName];
			{
				// Chaque gagnant reçoit sa part individuellement
				[7, _x, _share, _tieHandName] remoteExec ["ALF_fnc_playPoker", _x];
			} forEach _winners;

			// Notifier les perdants (un seul message)
			private _losers = _validPlayers - _winners;
			if (count _losers > 0) then {
				[7, _winners select 0, 0, _tieHandName] remoteExec ["ALF_fnc_playPoker", _losers];
			};
		} else {
			private _gagnant = _winners select 0;
			// Envoyer le gain au gagnant
			[7, _gagnant, _pot, _handName] remoteExec ["ALF_fnc_playPoker", _gagnant];
			// Notifier les perdants
			private _losers = _validPlayers - [_gagnant];
			if (count _losers > 0) then {
				[7, _gagnant, 0, _handName] remoteExec ["ALF_fnc_playPoker", _losers];
			};
		};

		[20, _pot] call ALF_Server_fnc_withdrawCapitalBySecteur;
	};
};

// Nettoyage des variables joueurs
{
	_x setVariable ["ALF_Poker_Hand", nil];
} forEach _allPlayers;

// Nettoyage des variables table
_table setVariable ["ALF_Poker_Partie", nil];
_table setVariable ["ALF_Poker_Pot", nil];
_table setVariable ["ALF_Poker_PlayerBets", nil];

// Libérer le verrou
_table setVariable ["ALF_Poker_InGame", false, true];

diag_log "Poker : partie terminée";
