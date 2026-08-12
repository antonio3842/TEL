// /*
// 	    Interaction PNJ Garages
// 	    Retourne une HashMap : clé = catégorie (ici ""), valeur = tableau d’actions
// 	    Chaque action = [texte, tooltip, code]
// */

// MRPV2_fnc_Interaction_PNJ_Garages = {
	private _objCurseur = toLowerANSI str cursorObject;
	private _liste_Actions = createHashMap;
	private _liste_Sous_Actions = [];

	[] call {
		// --- PNJ : Garage Bateau ---
		if (toLowerANSI "mrpv2_pnj_garage_bateau" in _objCurseur) exitWith {
			private _texte = "Magasin de bateau";
			private _texte_tooltype = "";
			private _action = {
				closeDialog 0;
				["ship", "Bateau Civil"] call ALF_fnc_vehicleShopMenuV2;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
			_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
			_liste_Actions set ["", _liste_Sous_Actions];

			_texte = "Mon garage bateau";
			_texte_tooltype = "";
			_action = {
				closeDialog 0;
				["vehicles", "Ship", player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
				createDialog "Life_impound_menu";
				disableSerialization;
				ctrlSetText [2802, "Chargement..."];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
			_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
			_liste_Actions set ["", _liste_Sous_Actions];

			_texte = "Ranger mon bateau";
			_texte_tooltype = "";
			_action = {
				closeDialog 0;
				["ship", "Civil"] call MRPV2_fnc_Vehicule_Garage_Ranger;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
			_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
			_liste_Actions set ["", _liste_Sous_Actions];
		};

		if (toLowerANSI "MRPV2_PNJ_garage_Wiki_Tropic" in _objCurseur) exitWith {

			if !(b_2) then {
				closeDialog 2;
        		["ENTREPRISE", "Vous devez faire partie de l'entreprise pour utiliser ces services.", "warning"] spawn ALF_fnc_doMsg;
			} else {

				private _texte = "Magasin de bateau";
				private _texte_tooltype = "";
				private _action = {
					closeDialog 0;
					["wiki_tropic", "Bateau Civil"] call ALF_fnc_vehicleShopMenuV2;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
				_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
				_liste_Actions set ["", _liste_Sous_Actions];

				_texte = "Mon garage bateau";
				_texte_tooltype = "";
				_action = {
					closeDialog 0;
					["vehicles", "Ship", player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
					createDialog "Life_impound_menu";
					disableSerialization;
					ctrlSetText [2802, "Chargement..."];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
				_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
				_liste_Actions set ["", _liste_Sous_Actions];

				_texte = "Ranger mon bateau";
				_texte_tooltype = "";
				_action = {
					closeDialog 0;
					["ship", "Civil"] call MRPV2_fnc_Vehicule_Garage_Ranger;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
				_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
				_liste_Actions set ["", _liste_Sous_Actions];
			};
		};

		if (toLowerANSI "MRPV2_PNJ_garage_Marine_et_Riviere" in _objCurseur) exitWith {

			if !(b_34) then {
				closeDialog 2;
        		["ENTREPRISE", "Vous devez faire partie de l'entreprise pour utiliser ces services.", "warning"] spawn ALF_fnc_doMsg;
			} else {

				private _texte = "Magasin de bateau";
				private _texte_tooltype = "";
				private _action = {
					closeDialog 0;
					["marine_et_riviere", "Bateau Civil"] call ALF_fnc_vehicleShopMenuV2;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
				_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
				_liste_Actions set ["", _liste_Sous_Actions];

				_texte = "Mon garage bateau";
				_texte_tooltype = "";
				_action = {
					closeDialog 0;
					["vehicles", "Ship", player, 34] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
					createDialog "Life_impound_menu";
					disableSerialization;
					ctrlSetText [2802, "Chargement..."];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
				_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
				_liste_Actions set ["", _liste_Sous_Actions];

				_texte = "Ranger mon bateau";
				_texte_tooltype = "";
				_action = {
					closeDialog 0;
					["ship", "Civil", 34] call MRPV2_fnc_Vehicule_Garage_Ranger;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
				_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
				_liste_Actions set ["", _liste_Sous_Actions];
			};
		};

		if (toLowerANSI "mrpv2_pnj_garage_civil" in _objCurseur) exitWith {
			private _texte = "Mon garage";
			private _texte_tooltype = "Récupérer mon véhicule entreposé dans un garage public";
			private _action = {
				closeDialog 0;
				["vehicles", "Car", player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
				createDialog "Life_impound_menu";
				disableSerialization;
				ctrlSetText [2802, "Chargement..."];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
			_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
			_liste_Actions set ["", _liste_Sous_Actions];

			_texte = "Ranger mon véhicule";
			_texte_tooltype = "Range le véhicule m'appartenant le plus proche dans un garage public";
			_action = {
				closeDialog 0;
				["Car", "Civil"] call MRPV2_fnc_Vehicule_Garage_Ranger;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
    	};

		
		// --- PNJ : Garage Préfecture (Secteur 13) ---
		if (toLowerANSI "MRPV2_PNJ_garage_prefecture" in _objCurseur OR {toLowerANSI "MRPV2_PNJ_garage_secteur_13" in _objCurseur}) exitWith {
			if !(b_13) then {
				closeDialog 2;
				["ENTREPRISE", "Vous devez faire partie de la Préfecture pour utiliser ces services.", "warning"] spawn ALF_fnc_doMsg;
			} else {
				private _texte = "Mon garage Préfecture";
				private _texte_tooltype = "Récupérer mon véhicule entreposé dans le garage Préfecture";
				private _action = {
					closeDialog 0;
					["vehicles", "Car", player, 13] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
					createDialog "Life_impound_menu";
					disableSerialization;
					ctrlSetText [2802, "Chargement..."];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
				_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
				_liste_Actions set ["", _liste_Sous_Actions];

				_texte = "Ranger mon véhicule";
				_texte_tooltype = "Range le véhicule m'appartenant le plus proche dans le garage Préfecture";
				_action = {
					closeDialog 0;
					["Car", "Civil", 13] call MRPV2_fnc_Vehicule_Garage_Ranger;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
				/*
				_texte = "Ranger mon véhicule Préfecture";
				_texte_tooltype = "Range le véhicule d'entreprise le plus proche dans le garage Préfecture";
				_action = {
					closeDialog 2;
					[cursorObject] call ALF_fnc_BusinessRangerGarage;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];

				_texte = "Concessionaire Préfecture";
				_texte_tooltype = "Acheter un véhicule pour la Préfecture";
				_action = {
					closeDialog 2;
					["b_13","Achat véhicule"] call ALF_fnc_vehicleShopMenuV2;
				};
				
				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];

				_texte = "Garage de l'entreprise";
				_texte_tooltype = "Accéder au garage de l'entreprise et récupérer les véhicules";
				_action = {
					closeDialog 2;
					// Le SIRET est déjà défini sur le PNJ au début du bloc if
					[cursorObject] spawn ALF_fnc_BusinessGarage;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
				*/
			};
		};

		// --- PNJ : Garage Tribunal (Secteur 23) ---
		if (toLowerANSI "MRPV2_PNJ_garage_tribunal" in _objCurseur OR {toLowerANSI "MRPV2_PNJ_garage_secteur_23" in _objCurseur}) exitWith {
			if !(b_23) then {
				closeDialog 2;
				["ENTREPRISE", "Vous devez faire partie du Tribunal pour utiliser ces services.", "warning"] spawn ALF_fnc_doMsg;
			} else {
				private _texte = "Mon garage Personnel";
				private _texte_tooltype = "Récupérer mon véhicule entreposé dans le garage Tribunal";
				private _action = {
					closeDialog 0;
					["vehicles", "Car", player, 23] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
					createDialog "Life_impound_menu";
					disableSerialization;
					ctrlSetText [2802, "Chargement..."];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
				_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
				_liste_Actions set ["", _liste_Sous_Actions];

				_texte = "Ranger mon véhicule";
				_texte_tooltype = "Range le véhicule m'appartenant le plus proche dans le garage Tribunal";
				_action = {
					closeDialog 0;
					["Car", "Civil", 23] call MRPV2_fnc_Vehicule_Garage_Ranger;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
				/*
				_texte = "Ranger mon véhicule tribunal";
				_texte_tooltype = "Range le véhicule d'entreprise le plus proche dans le garage Tribunal";
				_action = {
					closeDialog 2;
					[cursorObject] call ALF_fnc_BusinessRangerGarage;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];

				_texte = "Garage de l'entreprise";
				_texte_tooltype = "Accéder au garage de l'entreprise et récupérer les véhicules";
				_action = {
					closeDialog 2;
					// Le SIRET est déjà défini sur le PNJ au début du bloc if
					[cursorObject] spawn ALF_fnc_BusinessGarage;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];


				private _texte = "Concessionaire tribunal";
				private _texte_tooltype = "Concessionaire du Tribunal";
				private _action = 
				{closeDialog 2;
					["b_23","Achat véhicule"] call ALF_fnc_vehicleShopMenuV2;  
				};
				
				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
				*/
			};
		};

				// --- PNJ : Garage Tropicauto (Secteur 33) ---
		if (toLowerANSI "MRPV2_PNJ_garage_entreprise_tropicauto" in _objCurseur OR {toLowerANSI "MRPV2_PNJ_garage_secteur_33" in _objCurseur}) exitWith {
			if !(b_33) then {
				closeDialog 2;
				["ENTREPRISE", "Vous devez faire partie de Tropicauto pour utiliser ces services.", "warning"] spawn ALF_fnc_doMsg;
			} else {
				private _texte = "Mon garage Personnel";
				private _texte_tooltype = "Récupérer mon véhicule entreposé dans le garage Tropicauto";
				private _action = {
					closeDialog 0;
					["vehicles", "Car", player, 33] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
					createDialog "Life_impound_menu";
					disableSerialization;
					ctrlSetText [2802, "Chargement..."];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
				_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
				_liste_Actions set ["", _liste_Sous_Actions];

				_texte = "Ranger mon véhicule";
				_texte_tooltype = "Range le véhicule m'appartenant le plus proche dans le garage Tropicauto";
				_action = {
					closeDialog 0;
					["Car", "Civil", 33] call MRPV2_fnc_Vehicule_Garage_Ranger;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
				
				_texte = "Garage de l'entreprise";
				_texte_tooltype = "Acceder au véhicule de l'entreprise";
				_action = {
					closeDialog 0;
					private _ent = ((nearestTerrainObjects [player,["house","building"],50]) select {typeof _x isequalto "Land_MRP_Concessionnaire"}) # 0;
					if (isnil {_ent} OR {isNull _ent}) exitwith {};
					[_ent] spawn ALF_fnc_BusinessGarage;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
				
				_texte = "Ranger mon véhicule d'entreprise";
				_texte_tooltype = "Range le véhicule de l'entreprise";
				_action = {
					closeDialog 0;
					private _ent = ((nearestTerrainObjects [player,["house","building"],50]) select {typeof _x isequalto "Land_MRP_Concessionnaire"}) # 0;
					if (isnil {_ent} OR {isNull _ent}) exitwith {};
					[_ent] call ALF_fnc_BusinessRangerGarage;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};
		};

	
    // if (toloweransi "MRPV2_PNJ_Garage_tribunal" in _objCurseur) exitwith         Land_MRP_Prefecture2    Land_MRP_Palais_Justice
    // {
    //     private _texte = "Mon garage personnel";
    //     private _texte_tooltype = "Récupérer mon véhicule entreposer dans un garage publique";
    //     private _action = 
    //     {closeDialog 0;
    //         ["vehicles","Car",player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
    //         createDialog "Life_impound_menu"; 
    //         disableSerialization; 
    //         ctrlSetText [2802,"Chargement..."];   
    //     };

    //     _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    //     _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    //     _liste_Actions set ["",_liste_Sous_Actions];

    //     private _texte = "Ranger mon véhicule personnel";
    //     private _texte_tooltype = "Range le véhicule m'appartenant le plus proche dans un garage publique";
    //     private _action = 
    //     {closeDialog 0;
    //         ["Car","Civil"] call MRPV2_fnc_Vehicule_Garage_Ranger;
    //     };

    //     _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    //     _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    //     _liste_Actions set ["",_liste_Sous_Actions];

    //     private _texte = "Garage tribunal";
    //     private _texte_tooltype = "Range le véhicule m'appartenant le plus proche dans un garage publique";
    //     private _action = 
    //     {closeDialog 0;
    //         ["Car","Civil"] call MRPV2_fnc_Vehicule_Garage_Ranger;
    //     };

    //     _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    //     _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    //     _liste_Actions set ["",_liste_Sous_Actions];


    //     private _texte = "Ranger mon véhicule tribunal";
    //     private _texte_tooltype = "Range le véhicule m'appartenant le plus proche dans un garage publique";
    //     private _action = 
    //    {closeDialog 2;
    //             [cursorObject] call ALF_fnc_BusinessRangerGarage;

    //     };

    //     _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    //     _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    //     _liste_Actions set ["",_liste_Sous_Actions];

    //     private _texte = "Concessionaire tribunal";
    //     private _texte_tooltype = "concess";
    //     private _action = 
    //     {closeDialog 2;
    //                ["b_23","Achat véhicule"] call ALF_fnc_vehicleShopMenuV2;  
    //     };
        
    //     _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    //     _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    //     _liste_Actions set ["",_liste_Sous_Actions];
    // };*/
};
_liste_Actions
// };