ALF_fnc_interactionSystem = {
if (isnull (findDisplay 25799)) then {createDialog "interactionSystem";};
disableSerialization;

private _display = findDisplay 25799;
private _pic1 = _display displayCtrl 25800;
private _pic2 = _display displayCtrl 25801;
private _bouton = _display displayCtrl 25802;
private _bouton = _display displayCtrl 25803;
private _bouton = _display displayCtrl 25804;
private _bouton = _display displayCtrl 25805;
private _bouton = _display displayCtrl 25806;
private _bouton = _display displayCtrl 25807;
private _bouton = _display displayCtrl 25808;
private _bouton = _display displayCtrl 25809;
private _bouton = _display displayCtrl 25810;
private _bouton = _display displayCtrl 25811;
private _bouton = _display displayCtrl 25812;
private _bouton = _display displayCtrl 25813;
private _btnmenu = _display displayCtrl 25814;

private _liste_Boutons = [];

for "_i" from 0 to 11 do 
{
    private _bouton = _display displayCtrl (25802 + _i);
    _liste_Boutons pushBack _bouton;
};

private _curObj = _this select 0;
life_pInact_curObject = _curObj;
licence_rankTarget params 
[
	["_CopRank",0,[0]],
	["_MedRank",0,[0]],
	["_PenRank",0,[0]],
	["_PubRank",0,[0]],
	["_pmo",false,[false]],
	["_sr",false,[false]],
	["_tic",false,[false]],
	["_psig",false,[false]],
	["_psig_sabre",false,[false]],
	["_gign",false,[false]],
	["_cyno",false,[false]]
];

private _menu = uiNamespace getVariable "interactPlayer";
switch (_menu) do 
{
	case 0 : 
	{
		_pic2 ctrlShow false;
		_pic1 ctrlShow true;
		_btnmenu ctrlShow true;

		{_x ctrlShow false} foreach _liste_Boutons;
		
		if (("ALF_identite" in (magazines player))) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "PRESENTER SA CARTE D'IDENTITE";
			_bouton buttonSetAction "[player,player getVariable ['IdentititeFausse',profileName]] remoteExecCall ['ALF_fnc_showIDcard',_t,false];}; closeDialog 0;";
		};

		if (("ALF_Permis" in (magazines player))) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "PRESENTER MON PERMIS";
			_bouton buttonSetAction "[player getVariable ['IdentititeFausse',name player],license_driver,license_trucking,life_permis,license_moto,license_boat,license_pilot] private _t=life_pInact_curObject; if(!isNull _t && {isPlayer _t} && {(owner _t)>=0}) then {remoteExec ['ALF_fnc_showPcard',_t,false];}; closeDialog 0;";
		};

		if (lifestate life_pInact_curObject in ["INCAPACITATED"]) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlEnable true;
			_bouton ctrlSetText "Porter le blessé";
			_bouton buttonSetAction "[0,life_pInact_curObject] spawn ALF_fnc_porterMort; closeDialog 0;";
				
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlEnable true;
			_bouton ctrlSetText "Mettre le blessé dans le veh.";
			_bouton buttonSetAction "[0, life_pInact_curObject] call ALF_fnc_voitureMort; closeDialog 0;";

			if ("ALF_identite" in (magazines life_pInact_curObject)) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlEnable true;
				_bouton ctrlSetText "Identifier le corps";
				_bouton buttonSetAction "[life_pInact_curObject, name life_pInact_curObject] call ALF_fnc_showIDcard; closeDialog 0;";
			};
		};

		if ([_curObj] call ALF_fnc_checkMenotter) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText toupper "démenotter";

			if ("ALF_cle_M" in (magazines player)) then 
			{
				_bouton buttonSetAction "[life_pInact_curObject] call ALF_fnc_unrestrain; closeDialog 0;";
			} else 
			{
				if ("ALF_ZipCutter" in (magazines player)) then 
				{
					_bouton buttonSetAction "[life_pInact_curObject] call ALF_fnc_unrestrain2; closeDialog 0;";
				};
			};
		};

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

			if (life_penit_service AND {player distance [3454.86,9233.92,0.01] <= 150}) then 
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

		if (life_gendarme_service AND {'ALF_Alcootest' in (magazines player)}) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Test d'alcoolémie";
			_bouton ctrlEnable true;
			__bouton buttonSetAction "private _t=life_pInact_curObject; if(!isNull _t && {isPlayer _t} && {(owner _t)>=0}) then {[player] private _t=life_pInact_curObject; if(!isNull _t && {isPlayer _t} && {(owner _t)>=0}) then {remoteExec ['ALF_fnc_testAlcoolemie',_t,false];}; closeDialog 0;";
		} else 
		{
			if ("ALF_Lockpick" in (magazines player) AND {life_pInact_curObject in (missionNamespace getVariable ["ALF_AllBracelets",[]])}) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "Crocheter Bracelet";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "[0,life_pInact_curObject] spawn ALF_fnc_enleverBracelet; closeDialog 0;";
			} else 
			{
				if("ALF_Bracelet" in (magazines player) AND {!(life_pInact_curObject in (missionNamespace getVariable ["ALF_AllBracelets",[]]))} AND {life_penit > 0}) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText "Ajouter Bracelet";
					_bouton ctrlEnable true;
					_bouton buttonSetAction "closeDialog 0; [0,[],life_pInact_curObject] spawn ALF_fnc_menuAjoutBracelet;";
				} else 
				{
					if (life_pInact_curObject in (missionNamespace getVariable ["ALF_AllBracelets",[]]) AND {life_penit > 0}) then 
					{
						private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
						_bouton ctrlShow true;
						_bouton ctrlSetText "Enlever Bracelet";
						_bouton ctrlEnable true;
						_bouton buttonSetAction "[1,life_pInact_curObject] call ALF_fnc_enleverBracelet; closeDialog 0;";
					} else 
					{
						if (life_penit_service) then 
						{
							private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
							_bouton ctrlShow true;
							_bouton ctrlSetText "AMENDE";
							_bouton ctrlEnable true;
							_bouton buttonSetAction "closeDialog 0; [life_pInact_curObject] call ALF_fnc_ticketActionPenit;";
						};						
					};
				};
			};
		};

		if (b_15) then 
		{
			if (licence_Target select 1) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlEnable true;
				_bouton ctrlSetText "Enlever license pilote";
				_bouton buttonSetAction "[3] remoteExecCall ['ALF_fnc_pilot',_t,false];}; ['Info', ""Vous avez retiré la licence de vol de cette personne.', ""success', false] spawn ALF_fnc_doMsg; closeDialog 0;";
			} else 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlEnable true;
				_bouton ctrlSetText "Donner license pilote";
				_bouton buttonSetAction "[2] remoteExecCall ['ALF_fnc_pilot',_t,false];}; ['Info', ""Vous avez donné la licence de vol à la personne.', ""success', false] spawn ALF_fnc_doMsg; closeDialog 0;";
			};
		};

		if (b_28) then 
		{
			if (licence_Target select 2) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlEnable true;
				_bouton ctrlSetText "Donner 1 point (permis)";
				_bouton buttonSetAction "[4] remoteExecCall ['ALF_fnc_driver',_t,false];}; closeDialog 0;";
			} else 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlEnable true;
				_bouton ctrlSetText "Donner permis conduire";
				_bouton buttonSetAction "[2] remoteExecCall ['ALF_fnc_driver',_t,false];}; ['Info', ""Vous avez donné le permis de conduire à la personne.', ""success', false] spawn ALF_fnc_doMsg; closeDialog 0;";
			};

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Vérifier point du client";
			_bouton buttonSetAction "['Info', format['Il reste %1 point(s) sur le permis de votre client !!', (licence_Target select 3)], ""success', false] spawn ALF_fnc_doMsg;";
		};

		if (b_7) then 
		{
			if !(licence_Target select 0) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlEnable true;
				_bouton ctrlSetText "Donner Permis Armes";
				_bouton buttonSetAction "[3] remoteExecCall ['ALF_fnc_Parmes',_t,false];}; ['Info', ""Vous avez donné le permis port d'armes à cette personne.', ""success', false] spawn ALF_fnc_doMsg; closeDialog 0;";
			};
		};

		if (life_gendarme_service OR {life_pompier_service}) then 
		{
			if (life_gendarme_service) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "AMENDE";
				_bouton buttonSetAction "closeDialog 0; [life_pInact_curObject] call ALF_fnc_ticketAction;";
				/*
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "Retirer le permis";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "[player] private _t=life_pInact_curObject; if(!isNull _t && {isPlayer _t} && {(owner _t)>=0}) then {remoteExec ['ALF_fnc_retirerPermis',_t,false];}; closeDialog 0;";
				
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "Enlever des points";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "[life_pInact_curObject] call ALF_fnc_actionPoints;";
				*/
				if ([player] call ALF_fnc_checkMenotter) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText "VERIFIER CASH";
					_bouton buttonSetAction "[player] remoteExecCall ['ALF_fnc_verifCash',_t,false];};";

					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText "SAISIR CASH";
					_bouton buttonSetAction "[player] remoteExecCall ['ALF_fnc_saisieCash',_t,false];};";
				};

				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "FOUILLER";
				_bouton buttonSetAction "closeDialog 0; [life_pInact_curObject] spawn ALF_fnc_fouilleAnal;";

				if (player distance (nearestObject [position player,"Land_mrp_gendarmerie_principale"]) < 100 OR {player distance (nearestObject [position player,"Land_mrp_gendarmerie_e"]) < 100} OR {player distance (nearestObject [position player,"Land_MRP_gendarmerie2"]) < 100} OR {player distance (nearestObject [position player,"Land_MRP_Caserne_GN"]) < 100}) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText "TEST ADN";
					_bouton buttonSetAction "closeDialog 0; [life_pInact_curObject] spawn ALF_fnc_getPlayerAdn;";

					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText "RECONNAISSANCE FACIAL";
					_bouton buttonSetAction "closeDialog 0; [life_pInact_curObject] spawn ALF_fnc_getPlayerFace;";
				};	

				if ("ALF_TestStup" in (magazines player)) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText toupper "Tester pour les stupéfiants";
					_bouton buttonSetAction "[player] private _t=life_pInact_curObject; if(!isNull _t && {isPlayer _t} && {(owner _t)>=0}) then {remoteExec ['ALF_fnc_testStup',_t,false];}; closeDialog 0;";
				};
			} else 
			{		
				if ("ALF_Bandage" in (magazines player)) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText "SOIGNER";
					_bouton buttonSetAction "closeDialog 0; [life_pInact_curObject] spawn ALF_fnc_soignerPompier;";
				};

				if (player getVariable ["isEmployed",""] isNotEqualTo "") then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText "Faire une facture";
					_bouton buttonSetAction "closeDialog 0; createDialog ""Life_facture"";";
				};

				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "Test groupe sanguin";
				_bouton buttonSetAction "[0,life_pInact_curObject] spawn ALF_fnc_testGroupeSanguin; closeDialog 0;";

				if (license_SAMU) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText "Faire une ordonnance";
					_bouton buttonSetAction "closeDialog 0; [player] remoteExecCall ['ALF_fnc_giveOrdonnance',_t,false];};";
				};

				if (_curObj getVariable["MedicalStats",[]] isnotequalto [] AND {"ALF_Guardian" in (magazines player) AND {life_pompier_service OR {life_penit_service AND {license_medWork}}}}) then 
				{				
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;

					_bouton ctrlShow TRUE;
					_bouton ctrlSetText "Ouvrir le menu du Guardian";
					_bouton ctrlAddEventHandler ["buttonClick",
					{closeDialog 2;
						private _joueur = cursorobject;
						if (isnull _joueur) exitwith {};
						[_joueur] spawn ALF_fnc_menuGuardian;	
					}];
				}; 
			};
		} else 
		{
			if (player getVariable ["isEmployed",""] isNotEqualTo "") then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "Faire une facture";
				_bouton buttonSetAction "closeDialog 0; createDialog ""Life_facture"";";

				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "Faire une facture";
				_bouton buttonSetAction "closeDialog 0; createDialog ""Life_fiche_paie"";";
			} else 
			{
				if (life_penit_service) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlSetText "FOUILLER";
					_bouton buttonSetAction "closeDialog 0; [life_pInact_curObject] spawn ALF_fnc_fouilleAnal;";
				};
			};

			if (life_penit > 2) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "[P] Virer de la prison";
				_bouton buttonSetAction "[0,player] remoteExecCall ['ALF_fnc_penitSetLevel',_t,false];};";

				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "[P] Passer Agent Stagiaire";
				_bouton buttonSetAction "[1,player] remoteExecCall ['ALF_fnc_penitSetLevel',_t,false];};";

				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "[P] Passer Agent Titulaire";
				_bouton buttonSetAction "[2,player] remoteExecCall ['ALF_fnc_penitSetLevel',_t,false];};";
			};

			if (life_penit > 6) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "[P] Passer Agent Principal";
				_bouton buttonSetAction "[3,player] remoteExecCall ['ALF_fnc_penitSetLevel',_t,false];};";

				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "[P] Passer Brigadier";
				_bouton buttonSetAction "[4,player] remoteExecCall ['ALF_fnc_penitSetLevel',_t,false];};";	
			};
		};

		if (life_copLevel < 1 AND {life_medicLevel < 9 AND {life_publique < 7 AND {life_penit < 8}}}) then {_btnmenu ctrlEnable false;};

		if (life_gendarme_service) then 
		{
			_btnmenu buttonSetAction "uiNamespace setVariable['interactPlayer',3]; [life_pInact_curObject] spawn ALF_fnc_interactionSystem;";
		} else 
		{
			_btnmenu buttonSetAction "uiNamespace setVariable['interactPlayer',1]; [life_pInact_curObject] spawn ALF_fnc_interactionSystem;";
		};

		if (life_pInact_curObject isKindOf "Man") then 
		{
			_btnmenu ctrlShow false;
			/*
			if (life_gendarme_service) then 
			{
				if ("ALF_identite" in (magazines life_pInact_curObject)) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlEnable true;
					_bouton ctrlSetText "Identifier le corps";
					_bouton buttonSetAction "[life_pInact_curObject, name life_pInact_curObject] call ALF_fnc_showIDcard; closeDialog 0;";
				};
			};
			*/
			if (isNull (attachedTo life_pInact_curObject)) then 
			{
				if (life_pInact_curObject getVariable ["ReviveMedic",false] AND {"ALF_Defibrilateur" in (magazines player)}) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlEnable true;

					_bouton ctrlSetText "Réanimer";
					_bouton buttonSetAction "[life_pInact_curObject] spawn ALF_fnc_revivePlayer;";
				};

				if ("ALF_Drap_Cadavre_Item" in (magazines player) AND {!alive life_pInact_curObject}) then 
				{
					private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
					_bouton ctrlShow true;
					_bouton ctrlEnable true;
					_bouton ctrlSetText "Mettre un drap mortuaire";
					_bouton buttonSetAction "[0,life_pInact_curObject] spawn ALF_fnc_drapMort; closeDialog 0;";
				};
			};
		};
	};

	case 1 : 
	{
		_pic1 ctrlShow false;
		_pic2 ctrlShow true;

		{_x ctrlShow false} foreach _liste_Boutons;

		if (life_copLevel > 5 AND {_CopRank < life_copLevel}) exitwith 
		{
			_btnmenu ctrlShow true;
			_btnmenu buttonSetAction "uiNamespace setVariable['interactPlayer',0]; [life_pInact_curObject] spawn ALF_fnc_interactionSystem;";						

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlSetText "Elève Gendarme";
			_bouton ctrlShow true;
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[1,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Gendarme";			
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[2,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Maréchal des logis chef";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[3,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Adjudant";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[4,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Adjudant-Chef"; 
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[5,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Major"; 
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[6,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Sous-Lieutenant"; 
			_bouton buttonSetAction "[7,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Lieutenant"; 
			_bouton buttonSetAction "[8,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Capitaine";
			_bouton buttonSetAction "[9,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Commandant";
			_bouton buttonSetAction "[10,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";
		
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;			
			_bouton ctrlShow true;
			_bouton ctrlSetText "Lieutenant-Colonel"; 
			_bouton buttonSetAction "[11,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;			
			_bouton ctrlShow true;
			_bouton ctrlSetText "Colonel"; 
			_bouton buttonSetAction "[12,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";
		};

		if (life_medicLevel >= 9 AND {_MedRank < life_medicLevel}) exitwith 
		{
			_btnmenu ctrlShow true;
			_btnmenu buttonSetAction "uiNamespace setVariable['interactPlayer',0]; [life_pInact_curObject] spawn ALF_fnc_interactionSystem;";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Licencier des Pompiers";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[0,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Sapeur";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[1,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Sapeur 1ère Cl";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[2,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Caporal";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[3,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Caporal chef";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[4,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Sergent"; 
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[5,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Sergent chef"; 
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[6,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Adjudant";
			_bouton buttonSetAction "[7,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Adjudant chef";
			_bouton buttonSetAction "[8,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Lieutenant";
			_bouton buttonSetAction "[9,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Capitaine";
			_bouton buttonSetAction "[10,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Ajouter/Supprimer 3SM";
			_bouton buttonSetAction "[11,player] remoteExecCall ['ALF_fnc_medSetLevel',_t,false];};";
		};

		if (life_penit > 8) exitwith 
		{
			_btnmenu ctrlShow true;
			_btnmenu buttonSetAction "uiNamespace setVariable['interactPlayer',0]; [life_pInact_curObject] spawn ALF_fnc_interactionSystem;";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "[P] Passer Brigadier Principal";
			_bouton buttonSetAction "[5,player] remoteExecCall ['ALF_fnc_penitSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "[P] Passer Major";
			_bouton buttonSetAction "[6,player] remoteExecCall ['ALF_fnc_penitSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "[P] Passer Lieutenant";
			_bouton buttonSetAction "[7,player] remoteExecCall ['ALF_fnc_penitSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "[P] Passer Capitaine";
			_bouton buttonSetAction "[8,player] remoteExecCall ['ALF_fnc_penitSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "[P] Passer Commandant";
			_bouton buttonSetAction "[9,player] remoteExecCall ['ALF_fnc_penitSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "AJOUTER Medecin";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['medWork',player] remoteExecCall ['ALF_fnc_penitSetLic',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "RETIRER Medecin";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['NOmedWork',player] remoteExecCall ['ALF_fnc_penitSetLic',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "AJOUTER ERIS";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['eris',player] remoteExecCall ['ALF_fnc_penitSetLic',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "RETIRER ERIS";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['NOeris',player] remoteExecCall ['ALF_fnc_penitSetLic',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "AJOUTER CYNO";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['cynoAP',player] remoteExecCall ['ALF_fnc_penitSetLic',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "RETIRER CYNO";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "['NOcynoAP',player] remoteExecCall ['ALF_fnc_penitSetLic',_t,false];};";
		};
		
		if (_PubRank < life_publique) then 
		{
			_btnmenu ctrlShow true;
			_btnmenu buttonSetAction "uiNamespace setVariable['interactPlayer',0]; [life_pInact_curObject] spawn ALF_fnc_interactionSystem;";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Virer du Service Publique";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[0,player] remoteExecCall ['ALF_fnc_pubSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Grade 1";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[1,player] remoteExecCall ['ALF_fnc_pubSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Grade 2";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[2,player] remoteExecCall ['ALF_fnc_pubSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Grade 3";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[3,player] remoteExecCall ['ALF_fnc_pubSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Grade 4";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[4,player] remoteExecCall ['ALF_fnc_pubSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Grade 5";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[5,player] remoteExecCall ['ALF_fnc_pubSetLevel',_t,false];};";

			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlEnable true;
			_bouton ctrlSetText "Grade 6";
			_bouton buttonSetAction "[6,player] remoteExecCall ['ALF_fnc_pubSetLevel',_t,false];};";
		};

		if (life_publique >= 7) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlEnable true;
			_bouton ctrlSetText "Grade 7";
			_bouton buttonSetAction "[7,player] remoteExecCall ['ALF_fnc_pubSetLevel',_t,false];};";
		};

		if (life_publique >= 8) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlEnable true;
			_bouton ctrlSetText "Grade 8";
			_bouton buttonSetAction "[8,player] remoteExecCall ['ALF_fnc_pubSetLevel',_t,false];};";
		};
	};

	case 2 : 
	{
		_pic1 ctrlShow false;
		_pic2 ctrlShow true;
		_btnmenu ctrlShow true;

		{_x ctrlShow false} foreach _liste_Boutons;

		if (life_copLevel < 6) then 
		{
			_btnmenu buttonSetAction "uiNamespace setVariable['interactPlayer',0]; [life_pInact_curObject] spawn ALF_fnc_interactionSystem;";
		} else 
		{
			_btnmenu buttonSetAction "uiNamespace setVariable['interactPlayer',1]; [life_pInact_curObject] spawn ALF_fnc_interactionSystem;";
		};	

		if (life_copLevel > 6) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlSetText "Virer de la Gendarmerie";
			_bouton ctrlEnable true;
			_bouton buttonSetAction "[0,player] remoteExecCall ['ALF_fnc_copSetLevel',_t,false];};";	

			if !(_cyno) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "AJOUTER CYNO";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['CYNO',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			} else 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "RETIRER CYNO";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['NOCYNO',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			};

			if !(_gign) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "AJOUTER GIGN";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['GIGN',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			} else 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "RETIRER GIGN";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['NOGIGN',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			};

			if !(_psig) then 
			{
				_bouton ctrlShow true;
				_bouton ctrlSetText "AJOUTER MOBILE";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['PSIG',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			} else 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "RETIRER MOBILE";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['NOPSIG',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			};

			if !(_psig_sabre) then 
			{
				_bouton ctrlShow true;
				_bouton ctrlSetText "AJOUTER PSIG Sabre";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['PSIG_Sabre',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			} else 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "RETIRER PSIG Sabre";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['NOPSIG_Sabre',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			};

			if !(_sr) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "AJOUTER SR";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['SR',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			} else 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "RETIRER SR";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['NOSR',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			};

			if !(_pmo) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "AJOUTER PMO";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['PMO',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			} else 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "RETIRER PMO";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['NOPMO',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			};

			if !(_tic) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "AJOUTER TIC";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['TIC',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			} else 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlSetText "RETIRER TIC";
				_bouton ctrlEnable true;
				_bouton buttonSetAction "['NOTIC',player] remoteExecCall ['ALF_fnc_copSetLic',_t,false];};";
			};
		};
	};

	case 3: 
	{
		_pic1 ctrlShow false;
		_pic2 ctrlShow true;

		_btnmenu ctrlShow true;
		_btnmenu buttonSetAction "uiNamespace setVariable['interactPlayer',2]; [life_pInact_curObject] spawn ALF_fnc_interactionSystem;";		

		{_x ctrlShow false} foreach _liste_Boutons;

		if (life_gendarme_service) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlEnable true;
			_bouton ctrlSetText "Verifier le permis armes";
			_bouton buttonSetAction "[player] private _t=life_pInact_curObject; if(!isNull _t && {isPlayer _t} && {(owner _t)>=0}) then {remoteExec ['ALF_fnc_verifParmes',_t,false];}; closeDialog 0;";			

			if (life_pInact_curObject in (missionNamespace getVariable ["ALF_AllBracelets",[]])) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlEnable true;
				_bouton ctrlSetText "Enlever le bracelet élect.";
				_bouton buttonSetAction "[1,life_pInact_curObject] call ALF_fnc_enleverBracelet; closeDialog 0;";
			};

			if ("ALF_Bracelet" in (magazines player) AND {!(life_pInact_curObject in (missionNamespace getVariable ["ALF_AllBracelets",[]]))}) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlEnable true;
				_bouton ctrlSetText "Mettre un bracelet élect.";
				_bouton buttonSetAction "closeDialog 0; [0,[],life_pInact_curObject] spawn ALF_fnc_menuAjoutBracelet;";
			};

			if (licence_Target select 0) then 
			{
				private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
				_bouton ctrlShow true;
				_bouton ctrlEnable true;
				_bouton ctrlSetText "Enlever le permis armes";
				_bouton buttonSetAction "[2] remoteExecCall ['ALF_fnc_Parmes',_t,false];}; ['Info', ""Vous avez retiré le permis port d'armes de la personne.', ""success', false] spawn ALF_fnc_doMsg; closeDialog 0;";
			};
		};		

		if ((life_coplevel >= 4) AND {player distance [11005.1,3701.35,0.00239563] <= 100}) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlEnable true;
			_bouton ctrlSetText "Mettre en prison";
			_bouton buttonSetAction "closeDialog 0; [0,[],life_pInact_curObject] spawn ALF_fnc_menuMettrePrison;";
		};

		if ((life_coplevel >= 4) AND {life_pInact_curObject getVariable ["ALF_EnPrison",false]}) then 
		{
			private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
			_bouton ctrlShow true;
			_bouton ctrlEnable true;
			_bouton ctrlSetText "Assigner une cellule";
			_bouton buttonSetAction "closeDialog 0; [4,[],life_pInact_curObject] spawn ALF_fnc_menuMettrePrison;";
		};
	};
};

[] spawn 
{
	if !(isNull (findDisplay 25799)) then 
	{
		for "_i" from 0 to 1 step 0 do 
		{
			if (isNull (findDisplay 25799)) exitWith {};
			if (life_pInact_curObject distance player > 4) exitWith {closeDialog 25799;};
			uiSleep 1;
		};
	};
};
};