// MRPV2_fnc_Interaction_Joueurs_Base_APPM = {
private _joueur = param [0,objnull];
if !([_curObj] call ALF_fnc_checkMenotter) then  
		{
			if (life_penit_service AND {life_pInact_curObject getVariable ["ALF_EnPrison",false]}) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlEnable true;
				_bouton ctrlSetText "Assigner cellule";
				_bouton buttonSetAction "closeDialog 0; [4,[],life_pInact_curObject] spawn ALF_fnc_menuMettrePrison;";
			};

			if(life_penit_service AND {player distance [3454.86,9233.92,0.01] <= 100}) then 
			{
				if !(life_pInact_curObject getVariable ["ALF_EnPrison",false]) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlEnable true;
					_bouton ctrlSetText "Mettre en prison";
					_bouton buttonSetAction "closeDialog 0; [0,[],life_pInact_curObject] spawn ALF_fnc_menuMettrePrison;";
				} else 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlEnable true;
					_bouton ctrlSetText "Sortir de prison";
					_bouton buttonSetAction "closeDialog 0; life_pInact_curObject setVariable ['ALF_EnPrison',true,true];";
				};
			};
		};

        if (life_penit_service) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText "FOUILLER";
					_bouton buttonSetAction "closeDialog 0; [life_pInact_curObject] spawn ALF_fnc_fouilleAnal;";
				};

		if (life_penit_service AND {license_medWork}) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "SOIGNER";
			if ("ALF_Bandage" in (magazines player)) then 
			{
				_bouton ctrlEnable true;
				_bouton buttonSetAction "closeDialog 0; [life_pInact_curObject] spawn ALF_fnc_soignerPompier;";
			} else 
			{
				_bouton ctrlEnable false;
			};
		};
if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};
// };

if (life_penit > 8) exitwith 
		{
			_btnmenu ctrlShow true;
			_btnmenu buttonSetAction "uiNamespace setVariable['interactPlayer',0]; [life_pInact_curObject] spawn ALF_fnc_interactionSystem;";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "[P] Passer Brigadier Principal";
			_bouton buttonSetAction "[5,player] remoteExecCall ['ALF_fnc_penitSetLevel',life_pInact_curObject];";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "[P] Passer Major";
			_bouton buttonSetAction "[6,player] remoteExecCall ['ALF_fnc_penitSetLevel',life_pInact_curObject];";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "[P] Passer Lieutenant";
			_bouton buttonSetAction "[7,player] remoteExecCall ['ALF_fnc_penitSetLevel',life_pInact_curObject];";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "[P] Passer Capitaine";
			_bouton buttonSetAction "[8,player] remoteExecCall ['ALF_fnc_penitSetLevel',life_pInact_curObject];";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "[P] Passer Commandant";
			_bouton buttonSetAction "[9,player] remoteExecCall ['ALF_fnc_penitSetLevel',life_pInact_curObject];";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "AJOUTER Medecin";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['medWork',player] remoteExecCall ['ALF_fnc_penitSetLic',life_pInact_curObject];";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "RETIRER Medecin";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['NOmedWork',player] remoteExecCall ['ALF_fnc_penitSetLic',life_pInact_curObject];";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "AJOUTER ERIS";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['eris',player] remoteExecCall ['ALF_fnc_penitSetLic',life_pInact_curObject];";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "RETIRER ERIS";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['NOeris',player] remoteExecCall ['ALF_fnc_penitSetLic',life_pInact_curObject];";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "AJOUTER CYNO";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['cynoAP',player] remoteExecCall ['ALF_fnc_penitSetLic',life_pInact_curObject];";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "RETIRER CYNO";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['NOcynoAP',player] remoteExecCall ['ALF_fnc_penitSetLic',life_pInact_curObject];";
		};

// if (life_penit > 2) then 
			// {
			// 	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			// 	_bouton ctrlShow true;
			// 	_bouton ctrlSetText "[P] Virer de la prison";
			// 	_bouton buttonSetAction "[0,player] remoteExecCall ['ALF_fnc_penitSetLevel',life_pInact_curObject];";

			// 	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			// 	_bouton ctrlShow true;
			// 	_bouton ctrlSetText "[P] Passer Agent Stagiaire";
			// 	_bouton buttonSetAction "[1,player] remoteExecCall ['ALF_fnc_penitSetLevel',life_pInact_curObject];";

			// 	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			// 	_bouton ctrlShow true;
			// 	_bouton ctrlSetText "[P] Passer Agent Titulaire";
			// 	_bouton buttonSetAction "[2,player] remoteExecCall ['ALF_fnc_penitSetLevel',life_pInact_curObject];";
			// };

			// if (life_penit > 6) then 
			// {
			// 	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			// 	_bouton ctrlShow true;
			// 	_bouton ctrlSetText "[P] Passer Agent Principal";
			// 	_bouton buttonSetAction "[3,player] remoteExecCall ['ALF_fnc_penitSetLevel',life_pInact_curObject];";

			// 	private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			// 	_bouton ctrlShow true;
			// 	_bouton ctrlSetText "[P] Passer Brigadier";
			// 	_bouton buttonSetAction "[4,player] remoteExecCall ['ALF_fnc_penitSetLevel',life_pInact_curObject];";	
			// };
		

		// if("ALF_Bracelet" in (magazines player) AND {!(life_pInact_curObject in (missionNamespace getVariable ["ALF_AllBracelets",[]]))} AND {life_penit > 0}) then 
		// 		{
		// 			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
		// 			_bouton ctrlShow true;
		// 			_bouton ctrlSetText "Ajouter Bracelet";
		// 			_bouton ctrlEnable true;
		// 			_bouton buttonSetAction "closeDialog 0; [0,[],life_pInact_curObject] spawn ALF_fnc_menuAjoutBracelet;";
		// 		} else 
		// 		{
		// 			if (life_pInact_curObject in (missionNamespace getVariable ["ALF_AllBracelets",[]]) AND {life_penit > 0}) then 
		// 			{
		// 				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
		// 				_bouton ctrlShow true;
		// 				_bouton ctrlSetText "Enlever Bracelet";
		// 				_bouton ctrlEnable true;
		// 				_bouton buttonSetAction "[1,life_pInact_curObject] call ALF_fnc_enleverBracelet; closeDialog 0;";
		// 			} else 
		// 			{
		// 				if (life_penit_service) then 
		// 				{
		// 					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
		// 					_bouton ctrlShow true;
		// 					_bouton ctrlSetText "AMENDE";
		// 					_bouton ctrlEnable true;
		// 					_bouton buttonSetAction "closeDialog 0; [life_pInact_curObject] call ALF_fnc_ticketActionPenit;";
		// 				};						
		// 			};
		// 		};