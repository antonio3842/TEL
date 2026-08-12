/*
	File : fn_playBJ.sqf
	Author: ALF Adam
*/
params [
	["_mode",-1,[0]],
	["_inputTable",objNull,[objNull]]
];

if (_mode isEqualTo -1) exitWith {};

// Si le joueur a quitté la table, ignorer tout message du serveur (sauf rejoindre = case 0, rejouer = case 10, croupier = case 11, cartes HUD = case 3, cleanup HUD = case 12)
if (_mode != 0 && {_mode != 3} && {_mode != 10} && {_mode != 11} && {_mode != 12} && {_mode != 14} && {ALF_Current_Table isEqualTo objNull}) exitWith {
	closeDialog 0;
	"pokerCarte" cutText ["","PLAIN"];
};

switch (_mode) do {
	//Rejoindre la table de BJ
	case 0: {
		private _table = _inputTable;
		if (isNull _table || {typeOf _table isNotEqualTo "ALF_TableBlackJack"}) then {
			_table = nearestObject [player, "ALF_TableBlackJack"];
		};
		if (isNull _table) exitWith {["Blackjack", "Il vous faut une table de blackjack proche de vous.", "warning", false] spawn ALF_fnc_doMsg;};

		if (life_cash < 2500) exitWith {["Blackjack","Il vous faut au moins 2 500 € en liquide pour jouer au blackjack.", "warning"] spawn ALF_fnc_doMsg;};

		if (ALF_Current_Partie isEqualTo -1 && {ALF_Current_Table isEqualTo objNull}) then {
			[0,_table,player] remoteExec ["ALF_Server_fnc_playBJ",2];
			ALF_Current_Table = _table;

			// Monitoring distance : si le joueur s'éloigne de plus de 5m, il quitte la partie
			[_table] spawn {
				params ["_tbl"];
				waitUntil {
					sleep 2;
					(ALF_Current_Table isEqualTo objNull) || {!(ALF_Current_Table isEqualTo _tbl)} || {player distance _tbl > 5} || {!alive player}
				};
				// Si la partie BJ est encore en cours sur CETTE table (pas déjà terminée ou remplacée par une partie poker)
				if (ALF_Current_Table isEqualTo _tbl) then {
					// Notifier le serveur de retirer le joueur de la partie
					[4, _tbl, player] remoteExec ["ALF_Server_fnc_playBJ", 2];
					closeDialog 0;
					"pokerCarte" cutText ["","PLAIN"];
					["Blackjack","Vous vous êtes éloigné de la table. Vous perdez votre mise.", "danger", false] spawn ALF_fnc_doMsg;
					ALF_Current_Partie = -1;
					ALF_Current_Table = objNull;
					ALF_BJ_Mise = 0;
				};
			};
		} else {
			["BlackJack", "Vous êtes deja dans une partie.", "warning"] spawn ALF_fnc_doMsg;
		};
	};

	//Afficher menu mise
	case 1: {
		if (life_cash < 2500) exitWith {
			["Blackjack","Il vous faut au moins 2 500 € en liquide pour lancer la partie. Vous êtes exclu.", "warning"] spawn ALF_fnc_doMsg;
			if !(ALF_Current_Table isEqualTo objNull) then {
				[4, ALF_Current_Table, player] remoteExec ["ALF_Server_fnc_playBJ", 2];
			};
			"pokerCarte" cutText ["","PLAIN"];
			ALF_Current_Partie = -1;
			ALF_Current_Table = objNull;
			ALF_BJ_Mise = 0;
			ALF_BJ_DealerInfoText = nil;
		};

		if !(createDialog "alfbj") exitWith {["INFO","Une erreur s'est produite lors de la création du dialog du blackjack.","warning"] spawn ALF_fnc_doMsg;};
		disableSerialization;

		uiNamespace setVariable ["ALF_BJ_Phase", "mise"];

		private _display = findDisplay 541619;

		// Sous-titre
		(_display displayCtrl 5416180) ctrlSetText "";

		// Afficher : Edit + Miser
		(_display displayCtrl 5416181) ctrlShow true;
		(_display displayCtrl 5416182) ctrlShow true;

		// Cacher : Action + Rejouer
		(_display displayCtrl 5416183) ctrlShow false;
		(_display displayCtrl 5416184) ctrlShow false;
		(_display displayCtrl 5416185) ctrlShow false;
		(_display displayCtrl 5416186) ctrlShow false;
		(_display displayCtrl 5416187) ctrlShow false;
	};

	//Appuie bouton miser
	case 2: {
		private _value = ctrlText 5416181;
		if !([_value] call TON_fnc_isnumber) exitWith {["Blackjack","Vous n'avez pas mis un nombre dans la mise.", "warning"] spawn ALF_fnc_doMsg;};

		_value = parseNumber _value;
		if (_value < 500) exitWith {["Blackjack","La mise minimale est de 500 €.", "warning"] spawn ALF_fnc_doMsg;};
		if (life_cash < _value) exitWith {["Blackjack","Vous n'avez pas assez d'argent sur vous pour miser ceci.", "warning"] spawn ALF_fnc_doMsg;};

		life_cash = life_cash - _value;
		ALF_BJ_Mise = _value;
		[2, ALF_Current_Table, player, _value] remoteExec ["ALF_Server_fnc_playBJ", 2];
		closeDialog 0;
	};

	//Affichage des cartes
	case 3: {
		private _cartes = param [1, [], [[]]];
		private _id = 544151;

		disableSerialization;
		private _display = uiNamespace getVariable ["pokerHUD",displayNull];

		if (isNull _display) then {
			"pokerCarte" cutRsc ["pokerHUD", "PLAIN", 2, false];
			_display = uiNameSpace getVariable ["pokerHUD",displayNull];
			// Cacher les textes BJ par défaut (le croupier et le poker ne doivent pas les voir)
			(_display displayCtrl 544158) ctrlShow false;
			(_display displayCtrl 544159) ctrlShow false;
		};

		// Nettoyer tous les slots de cartes d'abord
		for "_i" from 544151 to 544157 do {
			(_display displayCtrl _i) ctrlSetText "";
		};

		private "_texture";
		{
			_control = _display displayCtrl _id;
			_texture = [_x] call ALF_fnc_recupPokerTexture;
			_control ctrlSetText _texture;
			_id = _id + 1;
		} forEach _cartes;

		// --- BJ HUD : Score de la main reçue (joueur OU croupier) ---
		if ((count _cartes) > 0) then {
			// Calcul du score BJ côté client
			private _score = 0;
			private _aces = 0;
			{
				private _val = _x select 0;
				if (_val isEqualTo 14) then {
					_score = _score + 11;
					_aces = _aces + 1;
				} else {
					if (_val >= 11) then {
						_score = _score + 10;
					} else {
						_score = _score + _val;
					};
				};
			} forEach _cartes;
			while {_score > 21 && {_aces > 0}} do {
				_score = _score - 10;
				_aces = _aces - 1;
			};

			private _handLabel = if (ALF_Current_Table isEqualTo objNull) then {"Main du croupier"} else {"Vos cartes"};
			(_display displayCtrl 544158) ctrlShow true;
			(_display displayCtrl 544158) ctrlSetText format["%1 (%2)", _handLabel, _score];
		};

		// Info croupier uniquement pour les joueurs de la table
		if (!(ALF_Current_Table isEqualTo objNull) && {!(isNil "ALF_BJ_DealerInfoText")}) then {
			(_display displayCtrl 544159) ctrlShow true;
			(_display displayCtrl 544159) ctrlSetText format["Main du croupier : %1", ALF_BJ_DealerInfoText];
		} else {
			(_display displayCtrl 544159) ctrlShow false;
		};
	};

	//Afficher menu demande carte supp. (phase action)
	case 4: {
		private _canDouble = param [1, true, [true]];

		if !(createDialog "alfbj") exitWith {["INFO","Une erreur s'est produite lors de la création du dialog du blackjack.","warning"] spawn ALF_fnc_doMsg;};
		disableSerialization;

		uiNamespace setVariable ["ALF_BJ_Phase", "action"];

		private _display = findDisplay 541619;

		// Sous-titre
		(_display displayCtrl 5416180) ctrlSetText "Choisissez votre action";

		// Cacher : Edit + Miser + Rejouer
		(_display displayCtrl 5416181) ctrlShow false;
		(_display displayCtrl 5416182) ctrlShow false;
		(_display displayCtrl 5416186) ctrlShow false;
		(_display displayCtrl 5416187) ctrlShow false;

		// Afficher : Action (Doubler seulement si 2 cartes en main)
		(_display displayCtrl 5416183) ctrlShow true;
		(_display displayCtrl 5416184) ctrlShow true;
		(_display displayCtrl 5416185) ctrlShow _canDouble;
	};

	//Appuie bouton doubler (déduit la mise avant d'envoyer au serveur)
	case 5: {
		if (ALF_BJ_Mise <= 0) exitWith {
			["Blackjack","Impossible de doubler sans mise valide.", "warning"] spawn ALF_fnc_doMsg;
		};

		if (life_cash < ALF_BJ_Mise) exitWith {
			["Blackjack", format["Il vous faut au moins %1 € pour doubler.", [ALF_BJ_Mise] call ALF_fnc_numberText], "warning"] spawn ALF_fnc_doMsg;
		};

		private _doubleAmount = ALF_BJ_Mise;
		life_cash = life_cash - _doubleAmount;
		[3, ALF_Current_Table, player, "doubler", _doubleAmount] remoteExec ["ALF_Server_fnc_playBJ", 2];
		closeDialog 0;
	};

	//Fin de la partie, gagnant ou perdant
	case 7: {
		private _gagnant = param [1, objNull, [objNull]];
		private _cashgagne = param [2, 0, [0]];

		if (player isEqualTo _gagnant) then {
			["Blackjack",format["Vous avez gagné %1 €",[_cashgagne] call ALF_fnc_numberText], "success", false] spawn ALF_fnc_doMsg;
			life_cash = life_cash + _cashgagne;
		} else {
			["Blackjack","Vous avez perdu votre mise.", "danger", false] spawn ALF_fnc_doMsg;
		};

		"pokerCarte" cutText ["","PLAIN"];
		ALF_Current_Partie = -1;
		ALF_Current_Table = objNull;
		ALF_BJ_Mise = 0;
		ALF_BJ_DealerInfoText = nil;

		// Proposer de rejouer après un délai
		[] spawn {
			sleep 3;
			[10] call ALF_fnc_playBJ;
		};
	};

	//Fin de la partie, erreur
	case 8: {
		private _casharray = param [1, [], [[]]];

		{
			if (player isEqualTo (_x select 0)) then {
				life_cash = life_cash + (_x select 1);
			};
		} forEach _casharray;

		["Blackjack","Erreur : partie blackjack terminée. Un joueur a quitté la table.", "danger", false] spawn ALF_fnc_doMsg;

		"pokerCarte" cutText ["","PLAIN"];
		ALF_Current_Partie = -1;
		ALF_Current_Table = objNull;
		ALF_BJ_Mise = 0;
		ALF_BJ_DealerInfoText = nil;
	};

	//Égalité (push) - remboursement de la mise
	case 9: {
		private _refund = param [1, 0, [0]];

		life_cash = life_cash + _refund;
		["Blackjack",format["Égalité ! Votre mise de %1 € vous est remboursée.",[_refund] call ALF_fnc_numberText], "warning", false] spawn ALF_fnc_doMsg;

		"pokerCarte" cutText ["","PLAIN"];
		ALF_Current_Partie = -1;
		ALF_Current_Table = objNull;
		ALF_BJ_Mise = 0;
		ALF_BJ_DealerInfoText = nil;

		// Proposer de rejouer après un délai
		[] spawn {
			sleep 3;
			[10] call ALF_fnc_playBJ;
		};
	};

	// === Case 11 : Croupier — choisit Tirer ou Rester ===
	case 11: {
		private _dealerScore = param [1, 0, [0]];
		ALF_BJ_CroupierTable = param [2, objNull, [objNull]];

		if (isNull ALF_BJ_CroupierTable) exitWith {};

		// Fermer tout dialog existant (interaction menu, dialog précédent, etc.)
		// Marquer comme répondu pour éviter que le onUnload auto-reste
		uiNamespace setVariable ["ALF_BJ_DialogAnswered", true];
		closeDialog 0;

		if !(createDialog "alfbj") exitWith {
			["Blackjack","Erreur : impossible d'ouvrir le menu croupier.", "danger", false] spawn ALF_fnc_doMsg;
			ALF_BJ_CroupierTable setVariable ["ALF_BJ_CroupierAction", "rester", true];
		};
		disableSerialization;

		uiNamespace setVariable ["ALF_BJ_Phase", "croupier"];
		// Stocker le score pour le onUnload (timeout auto-action)
		uiNamespace setVariable ["ALF_BJ_CroupierScore", _dealerScore];

		private _display = findDisplay 541619;

		// Cacher tout sauf les boutons nécessaires
		(_display displayCtrl 5416181) ctrlShow false;
		(_display displayCtrl 5416182) ctrlShow false;
		(_display displayCtrl 5416185) ctrlShow false;
		(_display displayCtrl 5416186) ctrlShow false;
		(_display displayCtrl 5416187) ctrlShow false;

		// Sous-titre avec le score
		(_display displayCtrl 5416180) ctrlSetText format["Score : %1 — Choisissez votre action", _dealerScore];

		// Afficher Tirer et Rester (libre choix du croupier)
		(_display displayCtrl 5416183) ctrlShow true;
		(_display displayCtrl 5416183) ctrlSetText "Tirer";
		(_display displayCtrl 5416183) ctrlSetEventHandler ["ButtonClick", "
			uiNamespace setVariable ['ALF_BJ_DialogAnswered', true];
			ALF_BJ_CroupierTable setVariable ['ALF_BJ_CroupierAction', 'tirer', true];
			closeDialog 0;
		"];
		(_display displayCtrl 5416184) ctrlShow true;
		(_display displayCtrl 5416184) ctrlSetText "Rester";
		(_display displayCtrl 5416184) ctrlSetEventHandler ["ButtonClick", "
			uiNamespace setVariable ['ALF_BJ_DialogAnswered', true];
			ALF_BJ_CroupierTable setVariable ['ALF_BJ_CroupierAction', 'rester', true];
			closeDialog 0;
		"];
	};

	// === Case 12 : Cleanup HUD croupier en fin de partie ===
	case 12: {
		"pokerCarte" cutText ["","PLAIN"];
		ALF_BJ_CroupierTable = objNull;
	};

	// === Case 14 : Mise à jour info croupier dans le HUD (joueurs uniquement) ===
	case 14: {
		private _text = param [1, "", [""]];
		ALF_BJ_DealerInfoText = _text;

		disableSerialization;
		private _display = uiNamespace getVariable ["pokerHUD", displayNull];
		if !(isNull _display) then {
			(_display displayCtrl 544159) ctrlShow true;
			(_display displayCtrl 544159) ctrlSetText format["Main du croupier : %1", _text];
		};
	};

	//Proposer de rejouer
	case 10: {
		// Vérifier qu'on est toujours près d'une table
		private _table = nearestObject [player, "ALF_TableBlackJack"];
		if (isNull _table || {player distance _table > 5}) exitWith {};

		if !(createDialog "alfbj") exitWith {};
		disableSerialization;

		uiNamespace setVariable ["ALF_BJ_Phase", "rejouer"];

		private _display = findDisplay 541619;

		// Sous-titre
		(_display displayCtrl 5416180) ctrlSetText "";

		// Cacher : Edit + Miser + Action
		(_display displayCtrl 5416181) ctrlShow false;
		(_display displayCtrl 5416182) ctrlShow false;
		(_display displayCtrl 5416183) ctrlShow false;
		(_display displayCtrl 5416184) ctrlShow false;
		(_display displayCtrl 5416185) ctrlShow false;

		// Afficher : Rejouer + Quitter
		(_display displayCtrl 5416186) ctrlShow true;
		(_display displayCtrl 5416187) ctrlShow true;
	};
};
