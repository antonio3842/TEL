//MRPV2_fnc_Interaction_Joueurs_Ent = {
private _liste_Actions = param [0,createhashmap];


if (player getVariable ["isEmployed",""] isNotEqualTo "") then 
{
    private _texte = "Faire une facture";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
        createDialog "Life_facture";
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["Entreprise",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["Entreprise",_liste_Sous_Actions];

    private _texte = "Faire une fiche de paie";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
        createDialog "Life_fiche_paie";
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["Entreprise",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["Entreprise",_liste_Sous_Actions];

};

// Interation DIR
if (b_18 && b_enService) then
{
    // Verifie si la personne n'a pas deja le permis camion
    private _hasTruckingLicence = (licence_Target # 4);

    if !(_hasTruckingLicence) then
    {
        private _texte = "Donner le permis camion";
        private _texte_tooltype = "Donner le permis camion";
        private _action =
        {
            closeDialog 0;
            // remoteExecCall vers la fonction qui donne la licence
            ['Trucking',player] remoteExecCall ['MRPV2_fnc_civSetLic',life_pInact_curObject];
        };
        
        _liste_Sous_Actions = _liste_Actions getOrDefault ["Entreprise",[]];
        _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
        _liste_Actions set ["Entreprise", _liste_Sous_Actions];
    };
};

// Interaction Armurerie
if (b_7) then
{
    // Verifie si la personne n'a pas deja le permis camion
    private _hasGunLicence = (licence_Target # 0);

    if !(_hasGunLicence) then
    {
        private _texte = "Donner le permis de port d'armes";
        private _texte_tooltype = "Donner le permis de port d'armes";
        private _action =
        {
            closeDialog 0;
            // remoteExecCall vers la fonction qui donne la licence
            ['Gun',player] remoteExecCall ['MRPV2_fnc_civSetLic',life_pInact_curObject];
        };
        
        _liste_Sous_Actions = _liste_Actions getOrDefault ["Entreprise",[]];
        _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
        _liste_Actions set ["Entreprise", _liste_Sous_Actions];
    };
};

// Interaction BIEM Sécu - Fouille de sac
if (b_6) then
{
    private _texte = "Fouiller le sac";
    private _texte_tooltype = "Fouiller le sac de la personne";
    private _action =
    {
        closeDialog 0;
        [life_pInact_curObject] spawn ALF_fnc_fouilleAnal;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["Entreprise",[]];
    _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
    _liste_Actions set ["Entreprise", _liste_Sous_Actions];
};

// Interaction Pilotage
if (b_15) then
{
    // Verifie si la personne n'a pas deja le permis camion
    private _hasPilotLicence = (licence_Target # 1);

    if !(_hasPilotLicence) then
    {
        private _texte = "Donner la licence de pilote";
        private _texte_tooltype = "Donner le licence de pilote";
        private _action =
        {
            closeDialog 0;
            // remoteExecCall vers la fonction qui donne la licence (adapter nom/filtres si nécessaire)
            ['Pilot',player] remoteExecCall ['MRPV2_fnc_civSetLic',life_pInact_curObject];
        };
        
        _liste_Sous_Actions = _liste_Actions getOrDefault ["Entreprise",[]];
        _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
        _liste_Actions set ["Entreprise", _liste_Sous_Actions];
    };
};

private _ent = (nearestObjects [player, ["Land_ALF_Entreprise"], 20]) # 0;
private _deja_Dans_Ent = getPlayerUID life_pInact_curObject in str((_ent getVariable "business") # 5);
if (!isnil {_ent} AND {!_deja_Dans_Ent}) then 
{
    private _texte = "Recruter dans l'entreprise";
    private _texte_tooltype = "Ouvre le menu de gestion d'entreprise et pré-remplis ce qu'il faut";
    private _action = 
    {closeDialog 0;
        if (life_pInact_curObject distance player > 5) exitwith 
        {
            ["ENTREPRISE","La personne n'est plus à coté de vous.","warning"] spawn ALF_fnc_doMsg;
        };

        [_ent,getPlayerUID life_pInact_curObject,name life_pInact_curObject] spawn alf_fnc_menuBusiness;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["Entreprise",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["Entreprise",_liste_Sous_Actions];
};

// if (b_15) then
// {
//     if (licence_Target # 1) then 
//     {
//         private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
//         _bouton ctrlShow true;
//         _bouton ctrlEnable true;
//         _bouton ctrlSetText "Enlever license pilote";
//         _bouton buttonSetAction "[3] remoteExecCall ['ALF_fnc_pilot',life_pInact_curObject]; ['Info', 'Vous avez retiré la licence de vol de cette personne.', 'success', false] spawn ALF_fnc_doMsg; closeDialog 0;";
//     } else 
//     {
//         private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
//         _bouton ctrlShow true;
//         _bouton ctrlEnable true;
//         _bouton ctrlSetText "Donner license pilote";
//         _bouton buttonSetAction "[2] remoteExecCall ['ALF_fnc_pilot',life_pInact_curObject]; ['Info', 'Vous avez donné la licence de vol à la personne.', 'success', false] spawn ALF_fnc_doMsg; closeDialog 0;";
//     };
// };

// if (b_28) then
// {
//     if (licence_Target # 2) then 
//     {
//         private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
//         _bouton ctrlShow true;
//         _bouton ctrlEnable true;
//         _bouton ctrlSetText "Donner 1 point (permis)";
//         _bouton buttonSetAction "[4] remoteExecCall ['ALF_fnc_driver',life_pInact_curObject]; closeDialog 0;";
//     } else 
//     {
//         private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
//         _bouton ctrlShow true;
//         _bouton ctrlEnable true;
//         _bouton ctrlSetText "Donner permis conduire";
//         _bouton buttonSetAction "[2] remoteExecCall ['ALF_fnc_driver',life_pInact_curObject]; ['Info', 'Vous avez donné le permis de conduire à la personne.', 'success', false] spawn ALF_fnc_doMsg; closeDialog 0;";
//     };

//     private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
//     _bouton ctrlShow true;
//     _bouton ctrlSetText "Vérifier point du client";
//     _bouton buttonSetAction "['Info', format['Il reste %1 point(s) sur le permis de votre client !!', (licence_Target select 3)], 'success', false] spawn ALF_fnc_doMsg;";
// };

// if (b_7) then 
// {
//     if !(licence_Target # 0) then 
//     {
//         private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
//         _bouton ctrlShow true;
//         _bouton ctrlEnable true;
//         _bouton ctrlSetText "Donner Permis Armes";
//         _bouton buttonSetAction "[3] remoteExecCall ['ALF_fnc_Parmes',life_pInact_curObject]; ['Info', 'Vous avez donné le permis port d'armes à cette personne.', 'success', false] spawn ALF_fnc_doMsg; closeDialog 0;";
//     };
// };

_liste_Actions
//};