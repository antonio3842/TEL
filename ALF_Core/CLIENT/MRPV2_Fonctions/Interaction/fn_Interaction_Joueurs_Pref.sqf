//MRPV2_fnc_Interaction_Joueurs_Pref = {
private _liste_Actions = param [0,createhashmap];

if (life_publique >= 2 AND {b_13}) then
{   
    private _categoryName = "Pref - Gestion licences";
    
    private _hasGunLicence = (licence_Target # 0);
    private _hasPilotLicence = (licence_Target # 1);
    private _hasTruckingLicence = (licence_Target # 4);

    if (_hasGunLicence) then 
    {
        private _texte = "Retirer le permis de port d'armes";
        private _texte_tooltype = "Retirer le permis de port d'armes";
        private _action = 
        {closeDialog 0;
            ['NOGun',player] remoteExecCall ['MRPV2_fnc_civSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];	        
    }else {
        private _texte = "Donner le permis de port d'armes";
        private _texte_tooltype = "Donner le permis de port d'armes";
        private _action = 
        {closeDialog 0;
            ['Gun',player] remoteExecCall ['MRPV2_fnc_civSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    };

    if (_hasPilotLicence) then 
    {
        private _texte = "Retirer la licence de pilote";
        private _texte_tooltype = "Retirer la licence de pilote";
        private _action = 
        {closeDialog 0;
            ['NOPilot',player] remoteExecCall ['MRPV2_fnc_civSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    }else {
        private _texte = "Donner la licence de pilote";
        private _texte_tooltype = "Donner la licence de pilote";
        private _action = 
        {closeDialog 0;
            ['Pilot',player] remoteExecCall ['MRPV2_fnc_civSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    };

    if (_hasTruckingLicence) then 
    {
        private _texte = "Retirer le permis camion";
        private _texte_tooltype = "Retirer le permis camion";
        private _action = 
        {closeDialog 0;
            ['NOTrucking',player] remoteExecCall ['MRPV2_fnc_civSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    }else {
        private _texte = "Donner le permis camion";
        private _texte_tooltype = "Donner le permis camion";
        private _action = 
        {closeDialog 0;
            ['Trucking',player] remoteExecCall ['MRPV2_fnc_civSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    };
};

_liste_Actions
//};