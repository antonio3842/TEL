MRPV2_fnc_Interaction_Joueurs_SP = {
private _liste_Actions = param [0,createhashmap];


if ((lifestate life_pInact_curObject) isequalto "INCAPACITATED") then 
{
    private _patient = (crew life_pInact_curObject) # 0;
    if ((typeof life_pInact_curObject) in ["ALF_Brancard_P","VEH_MRP_Brancard_Vsav"] AND {isnil {_patient}}) then
    {
        if (_patient getVariable["MedicalStats",[]] isnotequalto [] AND {"ALF_Guardian" in (magazines player) AND {life_pompier_service OR {life_penit_service AND {license_medWork}}}}) then 
        {
            private _texte = "Ouvrir le menu du Guardian";
            private _texte_tooltype = "Ouvrir le menu du Guardian pour gérer les soins du patient";
            private _action = 
            {closeDialog 0;
                private _patient = (crew life_pInact_curObject) # 0;
                if (isnil {_patient}) exitwith {};
                [_patient] spawn ALF_fnc_menuGuardian;
            };

            _liste_Sous_Actions = _liste_Actions getOrDefault ["SP - Base",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["SP - Base",_liste_Sous_Actions];
        };
    };

    private _brancard = ((nearestObjects [player,["ALF_Brancard_P","VEH_MRP_Brancard_Vsav"],10]) select {crew _x isequalto []}) # 0;
    if (isnull (attachedto life_pInact_curObject) AND {!isnil {_brancard} AND {_brancard distance player < 10}}) then
    {
        private _texte = "Mettre sur le brancard";
        private _texte_tooltype = "Déplacer le blessé sur le brancard";
        private _brancardType = typeof _brancard;
        private _action = compile format ["closeDialog 0;
            [life_pInact_curObject,'%1'] call ALF_fnc_putInCarsp;
        ", _brancardType];

        _liste_Sous_Actions = _liste_Actions getOrDefault ["SP - Base",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["SP - Base",_liste_Sous_Actions];        
    };

    if ("ALF_Defibrilateur" in (magazines player) AND {_patient getVariable["MedicalStats",[]] isequalto []}) then 
    {
        private _texte = "Réanimer le blessé";
        private _texte_tooltype = "Réanimer le blessé avec le défibrillateur";
        private _action = 
        {closeDialog 0;
            private _patient = (crew life_pInact_curObject) # 0;
            if (isnil {_patient}) exitwith {};
            [_patient] spawn ALF_fnc_revivePlayer;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["SP - Base",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["SP - Base",_liste_Sous_Actions];
    };
};

if (life_pompier_service) then 
{		
    if ("ALF_Bandage" in (magazines player)) then 
    {
        private _texte = "Soigner le blessé";
        private _texte_tooltype = "Soigne le blessé avec un bandage";
        private _action = 
        {closeDialog 0;
           [life_pInact_curObject] spawn ALF_fnc_soignerPompier;           
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["SP - Base",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["SP - Base",_liste_Sous_Actions];
    };

    // private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
    // _bouton ctrlShow true;
    // _bouton ctrlSetText "Test groupe sanguin";
    // _bouton buttonSetAction "[0,life_pInact_curObject] spawn ALF_fnc_testGroupeSanguin; closeDialog 0;";

    if (license_SAMU) then 
    {
        private _texte = "Faire une ordonnance";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            [player] remoteExecCall ['ALF_fnc_giveOrdonnance',life_pInact_curObject];          
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["SP - Base",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["SP - Base",_liste_Sous_Actions];
    };

    if (life_pInact_curObject getVariable["MedicalStats",[]] isnotequalto [] AND {"ALF_Guardian" in (magazines player) AND {life_pompier_service OR {life_penit_service AND {license_medWork}}}}) then 
    {
        private _texte = "Ouvrir le menu Guardian";
        private _texte_tooltype = "Ouvrir le menu de soin Guardian";
        private _action = 
        {closeDialog 0;
            [life_pInact_curObject] spawn ALF_fnc_menuGuardian;          
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["SP - Base",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["SP - Base",_liste_Sous_Actions];
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

if (life_medicLevel >= 9 AND {_MedRank < life_medicLevel}) then
{
    private _grades_Pompiers = [
        ["Renvoyer des Pompiers", 0],
        ["Sapeur", 1],
        ["Sapeur 1ère Classe", 2],
        ["Caporal", 3],
        ["Caporal chef", 4],
        ["Sergent", 5],
        ["Sergent chef", 6],
        ["Adjudant", 7],
        ["Adjudant chef", 8],
        ["Lieutenant", 9],
        ["Capitaine", 10],
        ["Commandant", 11],
        ["Lieutenant-Colonel", 12],
        ["Colonel", 13]
    ];

    private _categoryName = "SP - Gestion grade";

    {
        _grade_Nom = _x # 0;
        _grade_Niveau = _x # 1;

        if  (_grade_Niveau > life_medicLevel) exitwith {};

        private _texte = _grade_Nom;
        private _texte_tooltype = format ["Passer en %1", _grade_Nom];

        if (_grade_Niveau isequalto 0) then {_texte_tooltype = "Renvoyer le personnel des Pompiers"};

        private _action = compile format
        ["closeDialog 0;
            [%1, player] remoteExecCall ['ALF_fnc_medSetLevel', life_pInact_curObject];
        ",_grade_Niveau];

        private _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName, []];
        _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
        _liste_Actions set [_categoryName, _liste_Sous_Actions];
    } forEach _grades_Pompiers;
};

if (life_medicLevel >= 9) then
{
    private _categoryName = "SP - Gestion spécialité";

    private _texte = "Ajouter/Retirer 3SM";
    private _texte_tooltype = "Ajouter ou retirer la spécialité 3SM (SAMU)";
    private _action =
    {closeDialog 0;
        [11, player] remoteExecCall ['ALF_fnc_medSetLevel', life_pInact_curObject];
    };

    private _liste_Sous_Actions = _liste_Actions getOrDefault [_categoryName, []];
    _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
    _liste_Actions set [_categoryName, _liste_Sous_Actions];
};

_liste_Actions
};