// [{
// MRPV2_fnc_Interaction_PNJ_SP_Hopital = {    
private _objCurseur = toloweransi str cursorObject;
private _liste_Actions = createHashMap;

[] call
{
    if (toloweransi "MRPV2_PNJ_SP_Incendie" in _objCurseur AND {life_medicLevel > 4}) exitwith
    {
        private _texte = "Lancer un incendie (Entraînement)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [cursorobject,player,"Lancer un incendie","incendie"] spawn ALF_fnc_trainingFire;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
    };

    if (toloweransi "MRPV2_PNJ_SP_Veto" in _objCurseur) exitwith
    {
        private _texte = "Payer le véto pour vous soigner";
        private _texte_tooltype = "25 000€";
        private _action = 
        {closeDialog 0;
			[0] spawn ALF_fnc_veto;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];

        private _texte = "Soigner un blessé inconscient";
        private _texte_tooltype = "100 000€";
        private _action = 
        {closeDialog 0;
			[1] spawn ALF_fnc_veto;
        };
        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
    };

    if (toloweransi "MRPV2_PNJ_SP_Hopital_Acceuil" in _objCurseur) exitwith
    {
        private _texte = "Se soigner";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            private _groupe_SP = units ((groups civilian select {"Pompiers" in groupId _x}) # 0);
            if (isNil {_groupe_SP}) then 
            {
                [0,[]] spawn ALF_fnc_soin;            
            } else 
            {
                ["INFO", "Des pompiers sont en service, merci de les contacter.", "warning"] spawn ALF_fnc_doMsg;
            };
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];

        private _texte = "Pharmacie";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [nil,nil,nil,"Pharmacie"] call ALF_fnc_weaponShopMenu; 
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];

        if (life_mediclevel > 0) then 
        {
            private _texte = "Marché général médicale";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [nil,nil,nil,"med"] call ALF_fnc_weaponShopMenu; 
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        };

        if true exitwith {};

        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Transport d'organe (WIP)";
        _bouton ctrlAddEventHandler ["buttonClick", 
        {params ["_control"]; closeDialog 2;
            ["ACCUEIL", "Désolé nous navons pas de demande de transport d'organe pour le moment.","info"] spawn ALF_fnc_doMsg;
        }];

        if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};
    };

    if (toloweransi "MRPV2_PNJ_SP_Prise_Service" in _objCurseur) exitWith
    {
        if (life_medicLevel > 0) then 
        {
            if (life_pompier_service) then 
            {
                private _texte = "Fin de service";
                private _texte_tooltype = "";
                private _action = 
                {closeDialog 0;
                    [cursorObject, player, "Fin de service"] call ALF_fnc_MedService;
                };

                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
                _liste_Actions set ["",_liste_Sous_Actions];

                // Option Service Incendie (uniquement si en service)
                private _texte_incendie = "Service Incendie ON/OFF";
                private _texte_tooltype_incendie = "Active ou désactive les événements de feux automatiques";
                private _action_incendie =
                {closeDialog 0;
                    [] remoteExecCall ["ALF_Server_fnc_serviceIncendie", 2];
                };

                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texte_incendie,_texte_tooltype_incendie,_action_incendie];
                _liste_Actions set ["",_liste_Sous_Actions];
            } else
            {
                private _texte = "Prise de service";
                private _texte_tooltype = "";
                private _action = 
                {closeDialog 0;
                    [cursorObject, player, "Debut de service", "priseservice_18"] call ALF_fnc_MedService;
                };

                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
                _liste_Actions set ["",_liste_Sous_Actions];                  
            };

            private _texte = "Vêtements pompiers";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [nil, nil, nil, "med"] spawn ALF_fnc_clothingMenu;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];     

            private _texte = "Vêtements civils";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [nil, nil, nil, "SP_Civ"] spawn ALF_fnc_clothingMenu;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];     

            private _texte = "Marché général";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [nil, nil, nil, "med"] call ALF_fnc_weaponShopMenu;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];         
        } else 
        {
            ["POMPIER", "Vous ne faites pas partie des pompiers. Si il y a un problème, voyez avec vos supérieurs.", "warning"] spawn ALF_fnc_doMsg;
        };
    };

    if (toloweransi "MRPV2_PNJ_SP_Garage_Aerien" in _objCurseur) exitWith
    {
        if (life_medicLevel > 3) then 
        {
            private _texte = "Magasin aérien Pompier";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                ["pompier_heli","Aérien Pompier"] call ALF_fnc_vehicleShopMenuV2;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions]; 

            private _texte = "Garage aérien";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                ["vehicles_med", "Air", player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
                createDialog "Life_impound_menuCopSP";
                disableSerialization;
                ctrlSetText [2802, "Chargement..."];
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];

            private _texte = "Ranger l'hélicoptère";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
               ["Air","Pompiers"] call MRPV2_fnc_Vehicule_Garage_Ranger;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        } else 
        {
            ["SP", "Vous ne faites pas partie des Pompiers. Si il y a un problème, voyez avec vos supérieurs.", "warning"] spawn ALF_fnc_doMsg;
        };
    };

    if (toloweransi "MRPV2_PNJ_SP_Garage" in _objCurseur) exitWith
    {
        if (life_medicLevel > 0) then 
        {
            if (life_medicLevel > 6) then 
            {
                private _texte = "Magasin véhicules pompiers";
                private _texte_tooltype = "";
                private _action = 
                {closeDialog 0;
                    ["pompier","Magasin véhicule Pompier"] call ALF_fnc_vehicleShopMenuV2;
                };

                _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
                _liste_Actions set ["",_liste_Sous_Actions];              
            };

            private _texte = "Garage pompier";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                ["vehicles_med","Car",player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD",2];
                createDialog "Life_impound_menuCopSP";
                disableSerialization;
                ctrlSetText [2802, "Chargement..."];
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];   

            private _texte = "Ranger véhicule Pompier";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                ["Car","Pompiers"] call MRPV2_fnc_Vehicule_Garage_Ranger;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];  
        };
    };
};

_liste_Actions
// };}] remoteExec ['call',0,true];