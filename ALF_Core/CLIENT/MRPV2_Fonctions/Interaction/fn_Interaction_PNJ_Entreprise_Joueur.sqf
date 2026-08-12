// [{
// MRPV2_fnc_Interaction_PNJ_Entreprise_Joueur = {    
private _objCurseur = toloweransi str cursorObject;
private _liste_Actions = createHashMap;

[] call 
{
    if (toloweransi "MRPV2_PNJ_Ent_Joueur_Boite_de_nuit" in  _objCurseur AND {b_20}) exitwith
    {	
        private _texte = "Magasin Boite de nuit";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [cursorobject,player,"Magasin Boite de nuit","b_20"] call ALF_fnc_weaponShopMenu;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];  
    };

    if (toloweransi "MRPV2_PNJ_Ent_Joueur_Sechage_tabac" in  _objCurseur) exitwith
    {	
        private _texte = "Séchage du Tabac";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [cursorobject] spawn ALF_fnc_sechageTabac;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];  
    };

    if (toloweransi "MRPV2_PNJ_Ent_Joueur_Confection_tabac" in _objCurseur) exitwith
    {
        private _texte = "Confection de Cigarette";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [cursorObject] spawn ALF_fnc_createCigarette;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];   

        private _texte = "Confection de Cigars";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [cursorObject] spawn ALF_fnc_createCigare;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];  

        private _hasWeed = ({_x in ["ALF_Weed","ALF_Weed_2","ALF_Weed_3"]} count magazines player) > 0;
        if (_hasWeed) then 
        {
            private _texte = "Confection de Joint";
            private _texte_tooltype = "";
            private _action = 
            {closeDialog 0;
                [cursorObject] spawn ALF_fnc_createjoint;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];       
        };
    };
    if (toloweransi "MRPV2_PNJ_Ent_Joueur_CMFA" in  _objCurseur AND {b_15}) exitwith
    {	
        private _texte = "Magasin CMFA";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [cursorobject,player,"Magasin CMFA","b_15"] call ALF_fnc_vehicleShopMenuV2;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];  
    };
};

_liste_Actions
// };}] remoteExec ['call',0,true];