// MRPV2_fnc_Interaction_Joueurs_GN = {
private _liste_Actions = param [0,createhashmap];

// Extraire les variables de la cible depuis licence_rankTarget
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

if (life_gendarme_service) then
{   
    private _categoryName = "GN - Base";

    private _texte = "Infliger une amende";
    private _texte_tooltype = "Remplir un PV et infliger une amande";
    private _action = 
    {closeDialog 0;
        [life_pInact_curObject] call ALF_fnc_ticketAction;   
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set [_categoryName,_liste_Sous_Actions];

    private _texte = "Retirer le permis";
    private _texte_tooltype = "Retirer le permis de conduire de la personne";
    private _action = 
    {closeDialog 0;
        [player] remoteExec ['ALF_fnc_retirerPermis',life_pInact_curObject]; 
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

    if (license_PMO) then 
    {
        private _texte = "Ajouter des points";
        private _texte_tooltype = "Ajouter des points sur le permis de conduire de la personne";
        private _action = 
        {closeDialog 0;
            [life_pInact_curObject] call ALF_fnc_actionPointsAdd;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
    };

    private _texte = "Vérifier le liquide sur l'individu";
    private _texte_tooltype = "Vérifier le liquide contenu dans ses poches";
    private _action = 
    {closeDialog 0;
        [player] remoteExecCall ['ALF_fnc_verifCash',life_pInact_curObject];   
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


        private _texte = "Saisir le liquide sur l'individu";
        private _texte_tooltype = "Saisir le liquide contenu dans ses poches";
        private _action = 
        {closeDialog 0;
            [player] remoteExecCall ['ALF_fnc_saisieCash',life_pInact_curObject]; 
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];
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

    if (player distance (nearestObject [position player,"Land_mrp_gendarmerie_principale"]) < 100 OR 
    {player distance (nearestObject [position player,"Land_mrp_gendarmerie_e"]) < 100} OR 
    {player distance (nearestObject [position player,"Land_MRP_gendarmerie2"]) < 100} OR 
    {player distance (nearestObject [position player,"Land_MRP_Caserne_GN"]) < 100}) then 
    {
        private _texte = "Tester l'adn de l'individu";
        private _texte_tooltype = "Tester l'adn de l'individu pour voir si il est fiché";
        private _action = 
        {closeDialog 0;
            [life_pInact_curObject] spawn ALF_fnc_getPlayerAdn;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];

        private _texte = "Reconnaissance faciale de l'individu";
        private _texte_tooltype = "Vérifier si le de l'individu est fiché";
        private _action = 
        {closeDialog 0;
            [life_pInact_curObject] spawn ALF_fnc_getPlayerFace;
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

    private _permis_Port_Arme = licence_Target # 0;
    if (_permis_Port_Arme) then 
    {
        private _texte = "Enlever le permis de port d'armes";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [2] remoteExecCall ['ALF_fnc_Parmes',life_pInact_curObject]; 
            ["Info", "Vous avez retiré le permis port d'armes de la personne.", "success", false] spawn ALF_fnc_doMsg;
        };
    };
};

if (life_copLevel > 5 AND {_CopRank < life_copLevel}) then 
{
    private _grades_Gendarmes = 
    [
        ["Renvoyer de la Gendarmerie", 0],
        ["Elève Gendarme", 1],
        ["Gendarme", 2],
        ["Maréchal des logis chef", 3],
        ["Adjudant", 4],
        ["Adjudant-Chef", 5],
        ["Major", 6],
        ["Sous-Lieutenant", 7],
        ["Lieutenant", 8],
        ["Capitaine", 9],
        ["Commandant", 10],
        ["Lieutenant-Colonel", 11],
        ["Colonel", 12]
    ];

    private _categoryName = "GN - Gestion grade";

    {
        _grade_Nom = _x # 0;
        _grade_Niveau = _x # 1;

        if  (_grade_Niveau > life_copLevel) exitwith {};

        private _texte = _grade_Nom;
        private _texte_tooltype = format ["Passer en %1", _grade_Nom];

        if (_grade_Niveau isequalto 0) then {_texte_tooltype = "Renvoyer le personnel de la Gendarmerie"};

        private _action = compile format 
        ["closeDialog 0;
            [%1, player] remoteExecCall ['ALF_fnc_copSetLevel', life_pInact_curObject];
        ",_grade_Niveau];

        private _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName, []];
        _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
        _liste_Actions set [_categoryName, _liste_Sous_Actions];
    } forEach _grades_Gendarmes;
};

if (life_copLevel > 6) then 
{
    private _categoryName = "GN - Gestion spécialité";

    if (_cyno) then 
    {
        private _texte = "Retirer la spécialité (Cynophile)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['NOCYNO',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];	        
    } else 
    {
        private _texte = "Ajouter la spécialité (Cynophile)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['CYNO',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];			
    };

    if (_gign) then 
    {
        private _texte = "Retirer la spécialité (GIGN)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['NOGIGN',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];	        
    } else 
    {
        private _texte = "Ajouter la spécialité (GIGN)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['GIGN',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];			
    };

    if (_psig) then 
    {
        private _texte = "Retirer la spécialité (MOBILE)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['NOPSIG',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];	        
    } else 
    {
        private _texte = "Ajouter la spécialité (MOBILE)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['PSIG',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];			
    };

    if (_sr) then 
    {
        private _texte = "Retirer la spécialité (SR)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['NOSR',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];	        
    } else 
    {
        private _texte = "Ajouter la spécialité (SR)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['SR',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];			
    };

    if (_pmo) then 
    {
        private _texte = "Retirer la spécialité (PMO)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['NOPMO',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];	        
    } else 
    {
        private _texte = "Ajouter la spécialité (PMO)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['PMO',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];			
    };

    if (_tic) then 
    {
        private _texte = "Retirer la spécialité (TIC)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['NOTIC',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];	        
    } else 
    {
        private _texte = "Ajouter la spécialité (TIC)";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ['TIC',player] remoteExecCall ['ALF_fnc_copSetLic',life_pInact_curObject];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName,[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set [_categoryName,_liste_Sous_Actions];			
    };
};

_liste_Actions
// };