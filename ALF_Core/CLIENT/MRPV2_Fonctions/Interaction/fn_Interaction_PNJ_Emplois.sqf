// MRPV2_fnc_Interaction_PNJ_Emplois = {    
private _objCurseur = toLowerANSI str cursorObject;
private _liste_Actions = createHashMap;

[] call 
{
    if (toLowerANSI "MRPV2_PNJ_Emploi_Laposte" in _objCurseur) exitwith
    {
        if (isNil {player getVariable "ALF_LaPoste_Mission"}) then 
        {
            private _texte = "Prise de service";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                closeDialog 2; [] spawn ALF_fnc_laposte_initMission;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];  
        };

        private _texte = "Terminer son service ou continuer";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            if !(isNil {player getVariable ["ALF_LaPoste_Mission", nil]}) then
            {
                ["livEffec"] spawn ALF_fnc_laposte_fonctions;
            }
            else
            {
                ["ACCUEIL", "Vous n'êtes pas en service. Si c'est une erreur, contactez un supérieur.", "info"] spawn ALF_fnc_doMsg;
            };
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];  

        private _texte = "Magasin La Poste";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [nil,nil,nil,"laposte"] spawn ALF_fnc_clothingMenu;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
    };

        if (toLowerANSI "MRPV2_PNJ_Emploi_Eboueur" in _objCurseur) exitWith
    {
		if (MRP_Eboueur_EnService) then {
			private _texte = "Arrêter son service Eboueur";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[] call ALF_fnc_eboueur_terminerService;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];    	
		} else {
			private _texte = "Prendre son service Eboueur";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				if (license_eboueur) then	
				{
					[] call ALF_fnc_eboueur_initMission;
				} else 
				{
					["EMPLOI", "Vous devez posséder la licence d'éboueur pour utiliser ce service.", "warning"] spawn ALF_fnc_doMsg;
				};
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];     
		};
		
		if (license_eboueur && !MRP_Eboueur_EnService) then {
			private _texte = "Rejoindre un collègue en service";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				if (license_eboueur) then	
				{
					[] spawn ALF_fnc_eboueur_rejoindreService;
				} else 
				{
					["EMPLOI", "Vous devez posséder la licence d'éboueur pour utiliser ce service.", "warning"] spawn ALF_fnc_doMsg;
				};
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];     
		};
		
        if (license_eboueur && MRP_Eboueur_EnService) then 
        {
            private _texte = "Magasin de vêtements (Éboueur)";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [nil, nil, nil, "eboueur"] spawn ALF_fnc_clothingMenu;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        };
    };
if (toLowerANSI "MRPV2_PNJ_Emploi_Enedis" in _objCurseur) exitWith
    {
		if (MRP_Bie_EnService) then {
			private _texte = "Arrêter son service Enedis";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[] call ALF_fnc_enedis_terminerService;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];    	
		} else {
			private _texte = "Prendre son service Enedis";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				if (license_enedis) then	
				{
					[] call ALF_fnc_enedis_initMission;
				} else 
				{
					["EMPLOI", "Vous devez posséder la licence d'Enedis pour utiliser ce service.", "warning"] spawn ALF_fnc_doMsg;
				};
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];     
		};

        /*
		if (license_enedis && MRP_Bie_EnService) then 
        {
            private _texte = "Récupérer un camion";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [0] spawn ALF_fnc_enedis_getVl;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        };
		*/
		
        if (license_enedis && MRP_Bie_EnService) then 
        {
            private _texte = "Récupérer un camion";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [1] spawn ALF_fnc_enedis_getVl;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        };
        if (license_enedis && MRP_Bie_EnService) then 
        {
            private _texte = "Rendre le camion";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [] spawn ALF_fnc_enedis_delVl;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        };
		
        if (license_enedis && MRP_Bie_EnService) then 
        {
            private _texte = "Magasin de vêtements (Enedis)";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [nil, nil, nil, "enedis"] spawn ALF_fnc_clothingMenu;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        };

        if (license_enedis && MRP_Bie_EnService) then 
        {
            private _texte = "Shop (Enedis)";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [nil,nil,nil,"bie"] call ALF_fnc_weaponShopMenu;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        };
    };
    if ((toLowerANSI "MRPV2_PNJ_Emploi_Ambulancier_1" in _objCurseur) || (toLowerANSI "MRPV2_PNJ_Emploi_Ambulancier_2" in _objCurseur)) exitWith
    {
		if (MRP_Ambulancier_EnService) then {
				
            
            if (toLowerANSI MRP_Ambulancier_Destination == _objCurseur) then {
                private _texte = "Donner l'organe";
                private _texte_tooltype = "";
                private _action = 
                {closeDialog 0;
                    [MRP_Ambulancier_Destination] spawn ALF_fnc_ambulancier_donnerOrgane;
                };

                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
                _liste_Actions set ["",_liste_Sous_Actions];    
            } else {
                private _texte = "Arrêter son service Ambulancier";
                private _texte_tooltype = "";
                private _action = 
                {closeDialog 0;
                    [] spawn ALF_fnc_ambulancier_terminerService;
                };

                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
                _liste_Actions set ["",_liste_Sous_Actions];    

                if (!MRP_AmbulancierEnCours) then {
                    private _texte = "Commencer une mission";
                    private _texte_tooltype = "";
                    private _action = 
                    {closeDialog 0;
                    _objCurseur = toLowerANSI str cursorObject;
            
                        if (toLowerANSI "MRPV2_PNJ_Emploi_Ambulancier_1" in _objCurseur) then {
                            ["MRPV2_PNJ_Emploi_Ambulancier_1"] call ALF_fnc_ambulancier_initMission;
                        } else {
                            ["MRPV2_PNJ_Emploi_Ambulancier_2"] call ALF_fnc_ambulancier_initMission;
                        };
                            
                    };

                    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
                    _liste_Actions set ["",_liste_Sous_Actions];     
                };    
            };
		} else {
			private _texte = "Prendre son service Ambulancier";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [toLowerANSI str cursorObject] call ALF_fnc_ambulancier_initService;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];        	
		};
    };
	
    if (toLowerANSI "MRPV2_PNJ_Emploi_Taxi" in _objCurseur) exitWith
    {
        if (player getVariable ["MRP_Taxi_EnService", false]) then {
            private _vehTaxi = player getVariable ["MRP_Taxi_Vehicle", objNull];
            private _hasLiveVeh = !isNull _vehTaxi && {alive _vehTaxi};
            private _parkedTaxi = player getVariable ["MRP_Taxi_Parked", false];

            if (_hasLiveVeh && {!_parkedTaxi}) then {
                private _texte = "Ranger le véhicule";
                private _texte_tooltype = "";
                private _action =
                {closeDialog 0;
                    [] spawn ALF_fnc_taxi_rangerVehicle;
                };

                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
                _liste_Actions set ["",_liste_Sous_Actions];
            };

            private _texteFin = "Fin de service taxi";
            private _texte_tooltypeFin = "";
            private _actionFin =
            {closeDialog 0;
                [] spawn ALF_fnc_taxi_endService;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texteFin,_texte_tooltypeFin,_actionFin];
            _liste_Actions set ["",_liste_Sous_Actions];
        } else {
            private _texte = "Prendre mon service de taxi";
            private _texte_tooltype = "";
            private _action =
            {closeDialog 0;
                if (license_taxi) then {
                    [] spawn ALF_fnc_taxi_initService;
                } else {
                    ["TAXI", "Vous devez posséder la licence taxi pour utiliser ce service.", "warning"] spawn ALF_fnc_doMsg;
                };
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];

            if (license_taxi) then {
                private _texteRanger = "Ranger le véhicule";
                private _texte_tooltypeRanger = "";
                private _actionRanger =
                {closeDialog 0;
                    [] spawn ALF_fnc_taxi_rangerVehicle;
                };

                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texteRanger,_texte_tooltypeRanger,_actionRanger];
                _liste_Actions set ["",_liste_Sous_Actions];
            };
        };

        if (license_taxi && {player getVariable ["MRP_Taxi_EnService", false]}) then {
            private _texteVet = "Magasin de vêtements (Taxi)";
            private _texte_tooltypeVet = "";
            private _actionVet =
            {closeDialog 0;
                [nil, nil, nil, "taxi"] spawn ALF_fnc_clothingMenu;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texteVet, _texte_tooltypeVet, _actionVet];
            _liste_Actions set ["",_liste_Sous_Actions];
        };

        private _texteInfo = "Information métier taxi";
        private _texte_tooltypeInfo = "";
        private _actionInfo =
        {closeDialog 0;
            [] spawn ALF_fnc_taxi_showInfoMetier;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texteInfo, _texte_tooltypeInfo, _actionInfo];
        _liste_Actions set ["",_liste_Sous_Actions];
    };

    /* TEMPORAIRE — distributeur désactivé
    // Licence distributeur — traiter AVANT le PNJ service (nom contient aussi "Emploi_distrib")
    if (toLowerANSI "MRPV2_PNJ_Emploi_distrib_license" in _objCurseur) exitWith
    {
        if !(license_distrib) then {
            private _texte = "Acheter la licence Distributeur";
            private _texte_tooltype = "";
            private _action =
            {closeDialog 0;
                [] spawn ALF_fnc_buyDistribLicense;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        } else {
            private _texte = "Licence Distributeur";
            private _texte_tooltype = "";
            private _action =
            {closeDialog 0;
                ["EMPLOI", "Vous possédez déjà la licence distributeur.", "info"] spawn ALF_fnc_doMsg;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        };
    };

    if (toLowerANSI "MRPV2_PNJ_Emploi_distrib" in _objCurseur) exitWith
    {
        if (license_distrib) then {
            private _texteShop = "Acheter marchandises";
            private _texte_tooltypeShop = "Approvisionnement au prix marché";
            private _actionShop =
            {closeDialog 0;
                [nil, nil, nil, "distributeur_livreur"] call ALF_fnc_weaponShopMenu;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texteShop, _texte_tooltypeShop, _actionShop];
            _liste_Actions set ["",_liste_Sous_Actions];
        };

        if (MRP_Distrib_EnService) then {
            private _vehDistrib = player getVariable ["MRP_Distrib_Vehicle", objNull];
            private _hasLiveVeh = !isNull _vehDistrib && {alive _vehDistrib};
            private _parkedDistrib = MRP_Distrib_Parked;

            if (_hasLiveVeh && {!_parkedDistrib}) then {
                private _texte = "Ranger le véhicule";
                private _texte_tooltype = "";
                private _action =
                {closeDialog 0;
                    [] spawn ALF_fnc_distrib_rangerVehicle;
                };

                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
                _liste_Actions set ["",_liste_Sous_Actions];
            };

            private _texteFin = "Arrêter son service Distributeur";
            private _texte_tooltypeFin = "";
            private _actionFin =
            {closeDialog 0;
                [] call ALF_fnc_distrib_terminerService;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texteFin,_texte_tooltypeFin,_actionFin];
            _liste_Actions set ["",_liste_Sous_Actions];
        } else {
            private _texte = "Prendre son service Distributeur";
            private _texte_tooltype = "";
            private _action =
            {closeDialog 0;
                if (license_distrib) then {
                    [] call ALF_fnc_distrib_initService;
                } else {
                    ["EMPLOI", "Vous devez posséder la licence distributeur pour utiliser ce service.", "warning"] spawn ALF_fnc_doMsg;
                };
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        };
    };
    */

    if (toLowerANSI "MRPV2_PNJ_Emploi_Decharge" in _objCurseur) exitWith
    {
		if (MRP_Eboueur_EnService) then {
			private _texte = "Vider son camion";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[] call ALF_fnc_eboueur_viderCamion;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];    	
		};

    };

    // France Travail : géré par MRPV2_fnc_Interaction_PNJ_Divers (voir fn_Interaction_PNJ.sqf)

    if (toLowerANSI "MRPV2_PNJ_Emploi_BusJob" in _objCurseur) exitWith
    {
        if (isNil "MRP_BusJob_ServicePris") then { MRP_BusJob_ServicePris = false; };
        if (isNil "MRP_BusJob_EnService") then { MRP_BusJob_EnService = false; };
        if (isNil "MRP_BusJob_Bus") then { MRP_BusJob_Bus = objNull; };
        if (isNil "MRP_BusJob_DepotRayon") then { MRP_BusJob_DepotRayon = 100; };

        private _pnjBus = cursorObject;
        missionNamespace setVariable ["MRP_BusJob_DepotPNJ", _pnjBus];
        private _bus = MRP_BusJob_Bus;
        if (isNull _bus) then { _bus = player getVariable ["MRP_BusJob_Bus", objNull]; };

        private _busVivant = !isNull _bus && {alive _bus};
        private _busAuDepot = _busVivant && {!isNull _pnjBus} && {(_bus distance _pnjBus) <= MRP_BusJob_DepotRayon};
        private _parkedBus = MRP_BusJob_Parked || {player getVariable ["MRP_BusJob_Parked", false]};
        private _showLignes = MRP_BusJob_ServicePris && {!MRP_BusJob_EnService} && {
            !_busVivant || _busAuDepot
        };
        private _showRanger = MRP_BusJob_ServicePris && _busVivant && {!_parkedBus} && {
            MRP_BusJob_EnService || _busAuDepot
        };

        if (MRP_BusJob_ServicePris) then {
            if (_showRanger) then {
                private _texteBusPark = "Ranger le vehicule";
                private _texte_tooltypeBusPark = "Ranger le bus au depot";
                private _actionBusPark =
                {closeDialog 0;
                    [] spawn ALF_fnc_busjob_rangerVehicle;
                };
                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texteBusPark,_texte_tooltypeBusPark,_actionBusPark];
                _liste_Actions set ["",_liste_Sous_Actions];
            };

            if (_showLignes) then {
                private _texteBusLignes = "Choix des lignes";
                private _texte_tooltypeBusLignes = "Ouvrir le menu des lignes de bus";
                private _actionBusLignes =
                {closeDialog 0;
                    [] spawn {
                        uiSleep 0.1;
                        [] spawn ALF_fnc_busjob_openMenu;
                    };
                };
                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texteBusLignes,_texte_tooltypeBusLignes,_actionBusLignes];
                _liste_Actions set ["",_liste_Sous_Actions];
            };

            private _texteBusFin = "Fin de service (Bus)";
            private _texte_tooltypeBusFin = "";
            private _actionBusFin =
            {closeDialog 0;
                [] spawn ALF_fnc_busjob_endService;
            };
            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texteBusFin,_texte_tooltypeBusFin,_actionBusFin];
            _liste_Actions set ["",_liste_Sous_Actions];

        } else {
            private _texteBusStart = "Prendre le service (Bus)";
            private _texte_tooltypeBusStart = "";
            private _actionBusStart =
            {closeDialog 0;
                [] spawn ALF_fnc_busjob_prendreService;
            };
            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texteBusStart,_texte_tooltypeBusStart,_actionBusStart];
            _liste_Actions set ["",_liste_Sous_Actions];
        };
    };
};

_liste_Actions    
// };
