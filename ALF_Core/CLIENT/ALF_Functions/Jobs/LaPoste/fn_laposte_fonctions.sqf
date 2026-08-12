// /*
// 	Projet : ALF
// 	Codeur : Mikael Libertis 
// 	File   : fn_laposte_fonctions
// */
ALF_fnc_laposte_fonctions = {
if !(alive player) exitWith {};

private _switch = param[0, "", [""]];

switch (_switch) do {
	case "addColisToPlayer": 
	{		
		if ((player getVariable["ALF_LaPoste_Mission", []]) isEqualTo []) exitWith {};
		if !(ALF_LaPosteEnCours) exitWith {};
		if (ALF_colisPris) exitWith {};

		// Gestion du Timer Local
		private _nextColisTime = player getVariable ["ALF_NextColisTime", 0];
		if (time < _nextColisTime) exitWith {
			private _remainingTime = round(_nextColisTime - time);
			["La Poste", format["Patientez encore %1 secondes avant de pouvoir prendre un nouveau colis.", _remainingTime], "warning"] spawn ALF_fnc_doMsg;
		};

		// Synchronisation immédiate en local (pas de `publicVariable`)
		ALF_colisPris = true;
		player setVariable ["ALF_NextColisTime", time + 30];  // Cooldown de 30 secondes

		if (isNil "ALF_LaPosteTimer") then 
		{
			ALF_LaPosteTimer = time;		
		}
		else
		{
			if ((time - ALF_LaPosteTimer) < 5) exitWith {}; 
		};

		private _qdt = player getVariable["ALF_LaPoste_Mission", []] param[2, 0, [0]];
		private _house = player getVariable["ALF_LaPoste_Mission", []] param[0, objNull, [objNull]];
		private _housePos = getPosATL _house;

		private _canAdd = player canAdd["ALF_Colis", _qdt];

		if !(_canAdd) exitWith 
		{
			["La Poste", "Vous n'avez pas assez de place dans votre inventaire !!", "danger"] spawn ALF_fnc_doMsg;
			ALF_colisPris = false;  
		};

		for "_i" from 1 to _qdt do 
		{
			player addItem "ALF_Colis";
		};

		player playMoveNow "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";

		["La Poste", format["Vous venez de récupérer %1 colis, votre destination a été mise sur votre carte, votre véhicule se trouve derrière le bâtiment !!", _qdt], "success"] spawn ALF_fnc_doMsg;

		private _marker = createMarkerLocal ["La Poste", _housePos];
		_marker setMarkerColorLocal "ColorYellow";
		_marker setMarkerTypeLocal "Mil_dot";
		_marker setMarkerTextLocal "Adresse de livraison";

		_house setVariable["LaPoste_Colis", getPlayerUID player];
		player getVariable ["ALF_LaPosteHouse", nil];		

		uiSleep 5;

		ALF_LaPosteTimer = nil;
		ALF_colisPris = true;
	};

	case "returnColis": 
	{
		if !(ALF_LaPosteEnCours) exitWith {};

		private _mag 	= magazines player;
		private _qdt 	= player getVariable["ALF_LaPoste_Mission", []] param[2, 0, [0]];
		private _house 	= player getVariable["ALF_LaPoste_Mission", []] param[0, objNull, [objNull]];

		private _veh = nearestObjects[player, ["V_ALF_Sprinter_C_Laposte_MRPV2", "V_ALF_Berlingo2019Poste_MRPV2"], 100];
		if (_veh isEqualTo []) exitWith {["La Poste", "Il n'y a pas de voiture de la poste dans les environs !!", "danger"] spawn ALF_fnc_doMsg;};

		private _count = 0;
		{
			if (_x isEqualTo "ALF_Colis") then {_count = _count + 1};
		} forEach _mag;

		if (_count < _qdt) exitWith {["La Poste", "Vous n'avez pas assez de colis sur vous !!", "danger"] spawn ALF_fnc_doMsg;};

		for "_i" from 1 to _qdt do 
		{
			player removeMagazine "ALF_colis";
		};

		player playMoveNow "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";

		["La Poste", "Livraison terminée, rentrez au QG pour la suite et l'argent !!", "success"] spawn ALF_fnc_doMsg;		

		deleteMarkerLocal "La Poste";

		private _colis = player getVariable["ALF_LaPoste_Colis", 0];
		_colis = _colis + _qdt;
		player setVariable["ALF_LaPoste_Colis", _colis];
		_house setVariable["LaPoste_Colis", nil];
		ALF_LaPosteEnCours = false;	
	};

	case "livEffec": 
	{
		private _qdt 	= player getVariable["ALF_LaPoste_Mission", []] param[2, 0, [0]];
		private _house 	= player getVariable["ALF_LaPoste_Mission", []] param[0, objNull, [objNull]];
		private _dist 	= player distance _house;
		private _colis  = player getVariable["ALF_LaPoste_Colis", 0];

		if (ALF_LaPosteEnCours) exitWith {["La Poste", "Terminez votre livraison avant de venir me voir !!", "danger"] spawn ALF_fnc_doMsg;};

		private _veh = nearestObjects[player, ["V_ALF_Sprinter_C_Laposte", "V_ALF_Berlingo2019Poste"], 500];

		private _ALF_Message = false;
		_ALF_Message = ["Voulez-vous continuer ?", "La poste", "Continuer", "Terminer"] call BIS_fnc_guiMessage;

		if (_ALF_Message) then
		{			
			player setVariable["ALF_LaPoste_Mission", []];

			//On creer la nouvelle mission.
			private _arrayVille 		= ["ARRAY", ["ALF_LA_POSTE_CONFIG", "liste_villes"]] call ALFTools_Client_Config_fnc_getConfig;
			private _arrayCar 			= ["ARRAY", ["ALF_LA_POSTE_CONFIG", "classname"]] call ALFTools_Client_Config_fnc_getConfig;
			private _selectRandomVille 	= selectRandom _arrayVille;

			//Return de l'adresse
			[_selectRandomVille, player] remoteExec ["ALF_Server_fnc_laposte_returnHouse",2];
			waitUntil {!(isNil{player getVariable "ALF_LaPosteHouse"})};

			private _houseNew = player getVariable ["ALF_LaPosteHouse", objNull];

			//On random la qdt.
			private _qdtnew = ceil(random 10);

			//On random l'etg.
			private _etgnew = ceil(random [2,4,9]);

			//On set la var.
			player setVariable["ALF_LaPoste_Mission", [_houseNew, getPosATL _houseNew, _qdtnew, _etgnew]];			

			ALF_LaPosteEnCours = true;
			ALF_colisPris = false;

			["La Poste","Vous recevrez votre paye à la fin de votre service.", "success"] spawn ALF_fnc_doMsg;
			["La Poste", "Vous venez de prendre une nouvelle livraison, les colis sont sur les étagères.", "warning"] spawn ALF_fnc_doMsg;
			player setVariable["ALF_LaPosteHouse", nil, true];
			
		}else
		{
			if !((_house getVariable["LaPoste_Colis", ""]) isEqualTo "") exitWith {["La Poste", "Vous devez livrer les colis avant !!", "warning"] spawn ALF_fnc_doMsg;};
			
			private _prix = 550 * _colis;						

			//On suppr le veh.
			private _monveh = objNull;
			{
				if ((_x getVariable["owner", ""]) isEqualTo (getPlayerUID player)) exitWith {_monveh = _x};
				
			} forEach _veh;

			if (_monveh isEqualTo objNull) exitWith {["La Poste", "Je ne vois pas le véhicule, vous comptez avoir votre paye sans me le retourner ?!", "danger"] spawn ALF_fnc_doMsg;};
			
			deleteVehicle _monveh;	

			["La Poste", format["Bravo pour votre travail vous avez touché %1€ !!", _prix], "success"] spawn ALF_fnc_doMsg;

			//On add le fric.
			life_cash = life_cash + _prix;
			[0] call SOCK_fnc_updatePartial;

			//On delete du tableau.
			{
				_x param["_p", "_units"];

				if (_units isEqualTo player) exitWith
				{
					ALF_LAPOSTE_CARS deleteAt (ALF_LAPOSTE_CARS find _x);
					publicVariable "ALF_LAPOSTE_CARS";
				};								
			} forEach ALF_LAPOSTE_CARS;

			ALF_LaPosteEnCours 	= false;
			ALF_colisPris 		= false;
			
			player setVariable["ALF_LaPoste_Mission", nil];
			player setVariable["LaPoste_Colis", nil];	
			player setVariable["ALF_LaPosteHouse", nil, true];			
		};		
	};
};
};