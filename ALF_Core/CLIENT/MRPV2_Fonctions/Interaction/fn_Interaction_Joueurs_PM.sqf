// MRPV2_fnc_Interaction_Joueurs_Pm = {
private _liste_Actions = param [0,createhashmap];


if (life_penit_service) then 
{   
    private _categoryName = "PM - Base";

    private _texte = "Infliger une amende";
    private _texte_tooltype = "Remplir un PV et infliger une amende";
    private _action = 
    {closeDialog 0;
        [life_pInact_curObject] call ALF_fnc_ticketActionPenit;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set [_categoryName,_liste_Sous_Actions];

    private _texte = "Enlever des points";
    private _texte_tooltype = "Enlever des points sur le permis de conduire de la personne";
    private _action = 
    {closeDialog 0;
        [life_pInact_curObject] call ALF_fnc_actionPoints;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set [_categoryName,_liste_Sous_Actions];

    private _texte = "Fouiller l'individu";
    private _texte_tooltype = "Faire l'inventaire de ses poches";
    private _action = 
    {closeDialog 0;
        [life_pInact_curObject] spawn ALF_fnc_fouilleAnal;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set [_categoryName,_liste_Sous_Actions];

    private _texte = "prison,";
    private _texte_tooltype = "Prison";
    private _action = 
    {closeDialog 0;
        [life_pInact_curObject] spawn ALF_fnc_menuMettrePrison;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set [_categoryName,_liste_Sous_Actions];

    if ('ALF_Alcootest' in (magazines player)) then 
    {
        private _texte = "Test d'alcoolémie";
        private _texte_tooltype = "Faire souffler dans le ballon";
        private _action = 
        {closeDialog 0;
            [player] remoteExec ['ALF_fnc_testAlcoolemie',life_pInact_curObject];    
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    };

    if ([life_pInact_curObject] call ALF_fnc_checkMenotter) then 
    {
        private _texte = "Vérifier le liquide sur l'individu";
        private _texte_tooltype = "Vérifier le liquide contenu dans ses poches";
        private _action = 
        {closeDialog 0;
            [player] remoteExecCall ['ALF_fnc_verifCash',life_pInact_curObject];   
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];

        private _texte = "Embarquer l'individu";
        private _texte_tooltype = "Embarquer l'individu le plus proche.";
        private _action =
        {
            closeDialog 0;
            private _nearestVehicleArray = nearestObjects [player, ["Car","Ship","Submarine","Air"], 10];

            if ((count _nearestVehicleArray) > 0) then {
                private _nearestVehicle = _nearestVehicleArray select 0;
                [life_pInact_curObject, _nearestVehicle] call ALF_fnc_putInCar;
            } else {
                hint "Aucun véhicule proche trouvé !";
            };
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName, []];
        _liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
        _liste_Actions set [_categoryName, _liste_Sous_Actions];

    };

    if ("ALF_TestStup" in (magazines player)) then 
    {
        private _texte = "Tester pour les stupéfiants";
        private _texte_tooltype = "Tester l'individu pour prise de stupéfiants";
        private _action = 
        {closeDialog 0;
            [player] remoteExec ['ALF_fnc_testStup',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    };


    if ("ALF_identite" in (magazines life_pInact_curObject)) then 
	{
        private _texte = "Identifier le corps";
        private _texte_tooltype = "Identifier le corps";
        private _action = 
        {closeDialog 0;
            [life_pInact_curObject, name life_pInact_curObject] call ALF_fnc_showIDcard;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    };  	

    private _texte = "Verifier le permis armes";
    private _texte_tooltype = "Verifier si la personne a un permis de port d'arme";
    private _action = 
    {closeDialog 0;
        [player] remoteExec ['ALF_fnc_verifParmes',life_pInact_curObject];
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set [_categoryName,_liste_Sous_Actions];


    // private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
    // _bouton ctrlShow true;
    // _bouton ctrlEnable true;
    // _bouton ctrlSetText "Verifier le permis armes";
    // _bouton buttonSetAction "[player] remoteExec ['ALF_fnc_verifParmes',life_pInact_curObject]; closeDialog 0;";			

    if (life_pInact_curObject in (missionNamespace getVariable ["ALF_AllBracelets",[]])) then 
    {
        private _texte = "Enlever le bracelet électronique";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [1,life_pInact_curObject] call ALF_fnc_enleverBracelet;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    };

    if ("ALF_Bracelet" in (magazines player) AND {!(life_pInact_curObject in (missionNamespace getVariable ["ALF_AllBracelets",[]]))}) then 
    {
        private _texte = "Mettre un bracelet électronique";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [0,[],life_pInact_curObject] spawn ALF_fnc_menuAjoutBracelet;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    };
};

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
    ["_gign",false,[false]],
    ["_cyno",false,[false]]
];


if (life_penit > 8 ) then 
{
    private _grades_PM = 
    [
        ["Renvoyer de la pm", 0],
        ["Stagiaire", 1],
        ["Titulaire", 2],
        ["Gardien principal", 3],
        ["Brigadier", 4],
        ["Brigadier-Chef", 5],
        ["Chef de Police", 6],
        ["Chef de service stagiaire", 7],
        ["Chef de service classe Normale", 8],
        ["Chef de service classe Supérieur", 9],
        ["Chef de service classe Execeptionnelle", 10],
        ["Directeur Stagiaire  ", 11],
        ["Directeur", 12]
    ];

    private _categoryName = "pm - Gestion grade";

    {
        _grade_Nom = _x # 0;
        _grade_Niveau = _x # 1;

        if  (_grade_Niveau > life_penit) exitwith {};

        private _texte = _grade_Nom;
        private _texte_tooltype = format ["Passer en %1", _grade_Nom];

        if (_grade_Niveau isequalto 0) then {_texte_tooltype = "Renvoyer le personnel de la Police Municipale"};

        private _action = compile format 
        ["closeDialog 0;
            [%1, player] remoteExecCall ['ALF_fnc_PenitSetLevel', life_pInact_curObject];
        ",_grade_Niveau];

        private _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName, []];
        _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
        _liste_Actions set [_categoryName, _liste_Sous_Actions];
    } forEach _grades_PM;
};

_liste_Actions
// };