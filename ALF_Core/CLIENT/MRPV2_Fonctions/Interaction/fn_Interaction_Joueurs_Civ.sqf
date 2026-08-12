// MRPV2_fnc_Interaction_Joueurs_Civ = {
private _liste_Actions = param [0,createhashmap];


if ("ALF_identite" in (magazines player)) then 
{
    private _texte = "Présenter ma CNI";
    private _texte_tooltype = "Présenter votre carte d'identité";
    private _action = 
    {
        [player,player getVariable ['IdentititeFausse',profileName]] remoteExecCall ['ALF_fnc_showIDcard',life_pInact_curObject]; 
        closeDialog 0;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["Civil",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["Civil",_liste_Sous_Actions];
};

if (("ALF_Permis" in (magazines player)) AND {!(lifestate life_pInact_curObject in ["INCAPACITATED"])}) then 
{
    private _texte = "Présenter mon permis";
    private _texte_tooltype = "Présenter votre permis de conduire";
    private _action = 
    {closeDialog 0;
        [player getVariable ['IdentititeFausse',name player],license_driver,license_trucking,life_permis,license_moto,license_boat,license_pilot] remoteExec ['ALF_fnc_showPcard',life_pInact_curObject]; 
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["Civil",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["Civil",_liste_Sous_Actions];
};

if (lifestate life_pInact_curObject in ["INCAPACITATED"]) then
{
    private _texte = "Porter le blessé";
    private _texte_tooltype = "Porter le blessé sur son dos (action longue)";
    private _action = 
    {closeDialog 0;
       [0,life_pInact_curObject] spawn ALF_fnc_porterMort; 
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["Civil",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["Civil",_liste_Sous_Actions];

    private _texte = "Mettre le blessé dans un véhicule";
    private _texte_tooltype = "Mettre le blessé dans le véhicule le plus proche";
    private _action = 
    {closeDialog 0;
       [0,life_pInact_curObject] call ALF_fnc_voitureMort;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["Civil",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["Civil",_liste_Sous_Actions];

    if (("ALF_identite" in (magazines life_pInact_curObject))) then 
    {
        private _texte = "Regarder la CNI";
        private _texte_tooltype = "Fouiller la personne et regarder sa carte d'identité";
        private _action = 
        {closeDialog 0;
            [life_pInact_curObject, name life_pInact_curObject] call ALF_fnc_showIDcard;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["Civil",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["Civil",_liste_Sous_Actions];
    };    
};

if ([life_pInact_curObject] call ALF_fnc_checkMenotter) then 
{
    private _texte = "Démenotter la personne";
    private _texte_tooltype = "Démenotter la personne à l'aide d'une clé ou d'un coupe-zip";
    private _action = 
    {closeDialog 0;
        if ("ALF_cle_M" in (magazines player)) exitwith {[life_pInact_curObject] call ALF_fnc_unrestrain;};          
        if ("ALF_ZipCutter" in (magazines player)) then {[life_pInact_curObject] call ALF_fnc_unrestrain2;};
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["Civil",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["Civil",_liste_Sous_Actions];
};

if ("ALF_Lockpick" in (magazines player) AND {life_pInact_curObject in (missionNamespace getVariable ["ALF_AllBracelets",[]])}) then 
{
    private _texte = "Crocheter le bracelet";
    private _texte_tooltype = "Utiliser un outil de crochetage pour enlever le bracelet électronique";
    private _action = 
    {closeDialog 0;
        [0,life_pInact_curObject] spawn ALF_fnc_enleverBracelet;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["Civil",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["Civil",_liste_Sous_Actions];
};

_liste_Actions
// };