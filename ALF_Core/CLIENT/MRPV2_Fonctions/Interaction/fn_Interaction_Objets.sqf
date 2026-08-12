/*
// MRPV2_fnc_Interaction_Objets = {
private _obj = param [0,objnull];


if (gestureState player isEqualTo "<none>" OR {_obj distance player > 3}) exitWith {};
if !(dialog) then {createDialog "interactionSystem";};

private _affichage = findDisplay 25799;
private _liste_Boutons = [];
private _info_Modele = tolowerANSI ((getModelInfo _obj) # 0);

for "_i" from 0 to 11 do 
{
    private _bouton = _affichage displayCtrl (25802 + _i);
    _bouton ctrlShow FALSE;
    _liste_Boutons pushBack _bouton;
};




if (tolowerANSI "casier.p3d" in _info_Modele) exitwith 
{    
    private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
    _bouton ctrlShow TRUE;
    _bouton ctrlSetText "M'assigné ce casier";
    _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [] call ALF_fnc_addMobilierCopclient;}];

    if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};
};



private _liste_Mobiliers = ["officechair_01_f"];
if (_liste_Mobiliers select {_x in _info_Modele} isnotequalto [] AND {_obj distance player < 2}) exitWith 
{
    private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
    _bouton ctrlShow TRUE;
    _bouton ctrlSetText "S'asseoir";
    _bouton setvariable ["_obj",_obj];
    _bouton ctrlAddEventHandler ["buttonClick", 
    {params ["_ctrl"]; closeDialog 2;
        private _obj = (_ctrl getVariable ["_obj",objnull]);
        if (animationstate player isNotequalto "crew") then {[_obj,"action"] call ALF_fnc_sitDown;};
    }];

    if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};
};

if (tolowerANSI "pcset_01_screen_f " in _info_Modele) exitwith 
{
    if !(b_33) exitwith {};
    
    private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
    _bouton ctrlShow TRUE;
    _bouton ctrlSetText (_infos # 1);
    _bouton setVariable ["_infos",_infos];
    _bouton ctrlAddEventHandler ["buttonClick", 
    {closeDialog 2;
        ["b_33","Achat véhicule"] call ALF_fnc_vehicleShopMenuV2;            
    }];

    if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};
};

if (tolowerANSI "pcset_01_screen_f" in _info_Modele) exitwith 
{
    private _CSP_Proche = (nearestTerrainObjects [player, [], 20] select {"Land_Caserne_MRP" in str _x}) isnotequalto [];
    if (life_medicLevel > 9 AND {_CSP_Proche}) exitwith 
    {        
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Consulter le CNP";
        _bouton ctrlAddEventHandler ["buttonClick",{closeDialog 2; [0] call ALF_fnc_cnpMenu;}];

        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Liste des retraits";
        _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [1] call ALF_fnc_cnpMenu;}];
    };

    private _dans_Cybercafe = (allmapmarkers select {markerpos _x distance player < 20 AND {markertype _x isequalto "MRPV2_cyber_icon"}}) isnotequalto [];
    if (_dans_Cybercafe) exitwith 
    {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Accéder à Internet";
        _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [] call ALF_fnc_menuInternet;}];
    };

    private _gendarmerie_Principale_Proche = (nearestTerrainObjects [player, [], 50] select {"Land_mrp_gendarmerie_principale" in str _x}) isnotequalto [];
    private _gendarmerie_Proche = (nearestTerrainObjects [player, [], 50] select {"Land_mrp_gendarmerie_e" in str _x || "Land_MRP_Caserne_GN" in str _x}) isnotequalto [];
    if ((_gendarmerie_Principale_Proche OR {_gendarmerie_Proche}) AND {life_gendarme_service}) exitwith 
    {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "CNG";
        _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [] call ALF_fnc_cngMenu;}];

        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Base de donnée ADN";
        _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [] call ALF_fnc_adnMenu;}];

        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Base de donnée FACIES";
        _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [] call ALF_fnc_faceMenu;}];

        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Menu Haut Parleur";
        _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [0] call ALF_fnc_copHautParleur;}];
    };

    if (b_33) exitwith 
    {    
        private _ent = (nearestObjects [player, ["Land_MRP_Concessionnaire"], 20]) # 0;
        private _info_Ent = _ent getVariable ["business",[]];

        if (_info_Ent isNotEqualTo []) then 
        {
            private _joueur_Est_Gerant = ((_info_Ent # 5) select {getPlayerUID player isequalto (_x # 1) AND {4 isequalto (_x # 2)}}) isNotequalto [];  
            if (_joueur_Est_Gerant) then 
            {
               private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
                _bouton ctrlShow TRUE;
                _bouton ctrlSetText "Gestion de l'entreprise";
                _bouton setvariable ["_ent",_ent];
                _bouton ctrlAddEventHandler ["buttonClick", 
                {closeDialog 2;
                    private _ent = (_this # 0) getVariable "_ent";
                    [_ent] spawn alf_fnc_menuBusiness;
                }];
               
                private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
                _bouton ctrlShow TRUE;
                _bouton ctrlSetText "Achat de véhicule";
                _bouton ctrlAddEventHandler ["buttonClick", 
                {closeDialog 2;
                    ["b_33","Achat véhicule"] call ALF_fnc_vehicleShopMenuV2; 
                }];         
            };

			// Prendre/Terminer son service
			private _nom_Ent = _info_Ent # 1;
			private _groupe_Ent_Existe = (groupId group player) isEqualTo _nom_Ent;
			if (_groupe_Ent_Existe) then
			{
				private _texte = "Terminer son service";
				private _texte_tooltype = "";
				private _action =
				{closeDialog 0;
					private _nom_Ent = groupId group player;
					private _collegues = (units group player) - [player];
					[player] joinSilent (createGroup civilian);
					b_enService = false;
					if (b_Depanneur) then {b_Depanneur = false;player setVariable ["CasseService",false,true];};
					if (b_18) then {player setVariable ["CasseService",false,true];player setVariable ["b_18",false,true];};
					["Entreprise", format["Vous avez terminé votre service de %1.", _nom_Ent], "info"] spawn ALF_fnc_doMsg;
					{["Entreprise", format["%1 a terminé son service.", name player], "info"] remoteExec ["ALF_fnc_doMsg", _x]} forEach _collegues;
					[false] call CLIENT_fnc_MRP_Tel_Divers_Prise_Service_CA;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			} else 
			{
				private _texte = "Prendre son service";
				private _texte_tooltype = "";
				private _action =
				{closeDialog 0;
					private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
					private _info_Ent = _ent getVariable ["business",[]];
					private _nom_Ent = _info_Ent # 1;
					private _groupe_Ent_Existe = ((groups civilian) select {groupId _x isEqualto _nom_Ent}) isnotequalto [];
					private _groupe = "";
					if (_groupe_Ent_Existe) then
					{
						_groupe = ((groups civilian) select {groupId _x isEqualto _nom_Ent}) # 0;
						[player] joinSilent _groupe;
					} else 
					{
						_groupe = createGroup civilian;
						_groupe setGroupIdGlobal [_nom_Ent];
						[player] joinSilent _groupe;
					};
					b_enService = true;
					if (toloweransi "HORIZON" in (toloweransi groupid _groupe) OR {toloweransi "DEPANNAGE" in (toloweransi groupid _groupe)}) then
					{
						b_Depanneur = true;
						player setVariable ["CasseService",true,true];
						player setVariable ["b_Depanneur",true,true];
					};
					if (toloweransi "DIR MARTINIQUE" in (toloweransi groupid _groupe)) then
					{
						player setVariable ["CasseService",true,true];
						player setVariable ["b_18",true,true];
					};

					private _collegues = (units group player) - [player];
					["Entreprise", format["Vous avez pris votre service de %1.", _nom_Ent], "info"] spawn ALF_fnc_doMsg;
					{["Entreprise", format["%1 a pris son service.", name player], "info"] remoteExec ["ALF_fnc_doMsg", _x]} forEach _collegues;
					player setVariable ["entreprise",_nom_Ent,true];
					player setVariable ["batEnt",_ent,true];
					[true] call CLIENT_fnc_MRP_Tel_Divers_Prise_Service_CA;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};

			// Ouvrir / Fermer entreprise
			private _open = _info_Ent # 12;
			if (_open) then
			{
				private _texte = "Fermer l'entreprise";
				private _texte_tooltype = "";
				private _action =
				{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				private _info_Ent = _ent getVariable ["business",[]];
				private _nom_Ent = _info_Ent select 1;
				private _open = _info_Ent select 12;

				private _newvalue = false;
				private _var = _ent getVariable ["business",[]];
				_var set[12,_newvalue];

				_ent setVariable ["business",_var,true];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			} else 
			{
				private _texte = "Ouvrir l'entreprise";
				private _texte_tooltype = "";
				private _action =
				{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				private _info_Ent = _ent getVariable ["business",[]];
				private _nom_Ent = _info_Ent select 1;
				private _open = _info_Ent select 12;

				private _newvalue = true;
				private _var = _ent getVariable ["business",[]];
				_var set[12,_newvalue];

				_ent setVariable ["business",_var,true];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};


            if (license_fisc) then 
            {
                private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
                _bouton ctrlShow TRUE;
                _bouton ctrlSetText "Menu FISC";
                _bouton setvariable ["_ent",_ent];
                _bouton ctrlAddEventHandler ["buttonClick", 
                {closeDialog 2;
                    private _ent = (_this # 0) getVariable "_ent";
                    [0,_ent getVariable ["business",[]] select 2] call ALF_fnc_dialogFisc;
                }];         
            };

            private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Achat de fourn. de base";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [nil,nil,nil,"b_0"] call ALF_fnc_weaponShopMenu;
            }];

            private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Achat de fourn. d'entreprise";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [nil,nil,nil,"b_33"] call ALF_fnc_weaponShopMenu;                
            }];
            
            private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Magasin de Vetments";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [nil,nil,nil,"b_33"] call ALF_fnc_clothingMenu;
            }];     
        };

        if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};
    };

    if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};
};

if (tolowerANSI "bureau1" in _info_Modele OR {tolowerANSI "mrp_bureau" in _info_Modele}) exitwith 
{
    private _gendarmerie_Principale_Proche = (nearestTerrainObjects [player, [], 50] select {"Land_mrp_gendarmerie_principale" in str _x}) isnotequalto [];
    private _gendarmerie_Proche = (nearestTerrainObjects [player, [], 50] select {"Land_mrp_gendarmerie_e" in str _x || "Land_MRP_Caserne_GN" in str _x}) isnotequalto [];
    if ((_gendarmerie_Principale_Proche OR {_gendarmerie_Proche}) AND {life_gendarme_service}) exitwith 
    {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "CNG";
        _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [] call ALF_fnc_cngMenu;}];

        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Base de donnée ADN";
        _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [] call ALF_fnc_adnMenu;}];

        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Base de donnée FACIES";
        _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [] call ALF_fnc_faceMenu;}];

        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Menu Haut Parleur";
        _bouton ctrlAddEventHandler ["buttonClick", {closeDialog 2; [0] call ALF_fnc_copHautParleur;}];
    };
};


//if (tolowerANSI "concentrateur" in _info_Modele) exitwith 
//{
//    private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
//    _bouton ctrlShow TRUE;
//    
//    _bouton ctrlSetText "Raffiner le baril de pétrole";
//    _bouton ctrlAddEventHandler ["buttonClick",
//    {closeDialog 2; 
//    [cursorobject] spawn ALF_fnc_transformPetrol;}];  
//
//    if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};   
//};

if (tolowerANSI "alf_brancard" in _info_Modele) exitwith 
{
    private _patient = (crew cursorobject) # 0;
    if (isnil {_patient}) exitwith {if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};};

    if ("ALF_Defibrilateur" in (magazines player)) then 
    {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Réanimer";
        _bouton ctrlAddEventHandler ["buttonClick", 
        {closeDialog 2;
            private _patient = (crew cursorobject) # 0;
             if (isnil {_patient}) exitwith {};
            [_patient] spawn ALF_fnc_revivePlayer;
        }];
    };

    if (_patient getVariable["MedicalStats",[]] isnotequalto [] AND {"ALF_Guardian" in (magazines player) AND {life_pompier_service OR {life_penit_service AND {license_medWork}}}}) then 
    {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Ouvrir le menu du Guardian";
        _bouton ctrlAddEventHandler ["buttonClick",
        {closeDialog 2;
            private _patient = (crew cursorobject) # 0;
            if (isnil {_patient}) exitwith {};
            [_patient] spawn ALF_fnc_menuGuardian;  
        }];
    };  

    if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};
};

if (tolowerANSI "table_bois" in _info_Modele) exitwith 
    {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
         _bouton ctrlShow TRUE;
         _bouton ctrlSetText "Découper le bois";
         _bouton ctrlAddEventHandler ["buttonClick", 
         {closeDialog 2;
             [cursorobject,[["ALF_Buche",1]],[["ALF_Planche_B",2],["copeaux_bois",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
         }];
        
        if(b_10) exitWith 
        {
           private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Création de Bobine";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["ALF_Planche_B",3]],[["bobine",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];

            private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Création de Linteau de Bois";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["ALF_Buche",1]],[["MRP_Linteau",4],["copeaux_bois",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];
        };
    };

if (tolowerANSI "workbench" in _info_Modele) exitwith 
    {
        if(b_10) exitWith 
        {
            private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Conditionnement de linteau";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["MRP_Linteau",6]],[["MRP_Linteau_x6",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];

             private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Creation de Palette";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["ALF_Planche_B",6],["MRP_Plot_Palette",9]],[["MRP_Palette",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];

            private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Création de Plot pour Palette";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["copeaux_bois",4],["MRP_Seau_Colle",1]],[["MRP_Plot_Palette",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];

             private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Création de Tonneau en Bois";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["ALF_Planche_B",6],["cerceau",4]],[["Barrel",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];
        };
         if(b_29) exitWith 
        {
           private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Conditionnement IPN x6";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["MRP_IPN",6]],[["MRP_IPN_x6",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];

             private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Création de bobine de fil de fer";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["bobine",1],["ALF_Fer",4]],[["MRP_IPN_x6",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];
        };
    };

if (tolowerANSI "embouteillage" in _info_Modele) exitwith 
    {

    private _b26 = missionNamespace getVariable ["b_26", false];
    private _b4  = missionNamespace getVariable ["b_4",  false];

    if (_b26 or _b4) then {
            private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Mise en Bouteille du Rhum";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["Bidon_Rhum",1],["bouteille_vide",5]],[["bouteille_rhum",5],["Bidon_Vide",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];
        };
    };

if (tolowerANSI "mixeur" in _info_Modele) exitwith 
    {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Mixer les bananes";
        _bouton ctrlAddEventHandler ["buttonClick", 
        {closeDialog 2;
            [cursorobject,[["ALF_banane",1]],[["TAG_Compote_F_F",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        }];
    };

if (tolowerANSI "milling" in _info_Modele) exitwith 
    {
        private _btns = _liste_Boutons select {!ctrlShown _x}; if (_btns isEqualTo []) exitWith {};
        private _b = _btns # 0;

        private _cargo = getMagazineCargo cursorObject;
        private _cls = _cargo # 0; private _cnt = _cargo # 1;
        private _lcls = _cls apply { toLower _x };
        private _countIC = {
          params ["_name"];
          private _i = _lcls find (toLower _name);
          if (_i < 0) exitWith {0};
          _cnt # _i
        };

        private _hasDiamant  = (["ALF_Pierre_dia_small"]  call _countIC) > 0;
        private _hasSaphir = (["ALF_saphir_small"] call _countIC) > 0;

          if (_hasDiamant) then {
            _b ctrlShow TRUE; _b ctrlSetText "Traitement du Diamant";
            _b ctrlAddEventHandler ["buttonClick", { closeDialog 2; [cursorObject,[["ALF_Pierre_dia_small",1]],[["ALF_diamant_taille",1]],10] spawn MRPV2_fnc_Traitement_Artisanat; }];
          }; 
            if (_hasSaphir) then {
              _b ctrlShow TRUE; _b ctrlSetText "Traitement du Saphir";
              _b ctrlAddEventHandler ["buttonClick", { closeDialog 2; [cursorObject,[["ALF_saphir_small",1]],[["ALF_saphir_taille",1]],10] spawn MRPV2_fnc_Traitement_Artisanat; }];
            };
       
        if (b_14) then {
          private _btns2 = _liste_Boutons select {!ctrlShown _x};
          if !(_btns2 isEqualTo []) then {
            private _b2 = _btns2 # 0;
            _b2 ctrlShow TRUE;
            _b2 ctrlSetText "Taille du Diamant Précieux";
            _b2 ctrlAddEventHandler ["buttonClick", {
              closeDialog 2;
              [cursorObject,[["ALF_diamant_taille",1]],[["ALF_diamant_precieux",1]],20] spawn MRPV2_fnc_Traitement_Artisanat;
            }];
          };
        };

        if (b_17) then {
          private _btns2 = _liste_Boutons select {!ctrlShown _x};
          if !(_btns2 isEqualTo []) then {
            private _b2 = _btns2 # 0;
            _b2 ctrlShow TRUE;
            _b2 ctrlSetText "Taille du Saphir Précieux";
            _b2 ctrlAddEventHandler ["buttonClick", {
              closeDialog 2;
              [cursorObject,[["ALF_saphir_taille",1]],[["MRP_saphir_precieux",1]],20] spawn MRPV2_fnc_Traitement_Artisanat;
            }];
          };
        };
    };


if (tolowerANSI "barrel" in _info_Modele) exitwith 
    {

    private _b26 = missionNamespace getVariable ["b_26", false];
    private _b4  = missionNamespace getVariable ["b_4",  false];

    if (_b26 or _b4) then {
            private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Fermentation du Rhum";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["Bidon_Canne",1]],[["Bidon_Rhum",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];
        };
    };

if (tolowerANSI "fedex" in _info_Modele) exitWith {
  private _btns = _liste_Boutons select {!ctrlShown _x}; if (_btns isEqualTo []) exitWith {};
  private _b = _btns # 0;

  private _cargo = getMagazineCargo cursorObject;
  private _cls = _cargo # 0; private _cnt = _cargo # 1;
  private _lcls = _cls apply { toLower _x };
  private _countIC = {
    params ["_name"];
    private _i = _lcls find (toLower _name);
    if (_i < 0) exitWith {0};
    _cnt # _i
  };

  private _hassushisaumon  = (["ALF_Thon"]  call _countIC) > 0;
  private _hassushithon = (["ALF_Saumon"] call _countIC) > 0;

    if (_hassushisaumon) then {
      _b ctrlShow TRUE; _b ctrlSetText "sushi thon";
      _b ctrlAddEventHandler ["buttonClick", { closeDialog 2; [cursorobject,[["ALF_Thon",1],["Algues",4]],[["MRP_Sushi_Thon",2]],10] spawn MRPV2_fnc_Traitement_Artisanat }];
    };
      if (_hassushithon) then {
        _b ctrlShow TRUE; _b ctrlSetText "sushi saumon";
        _b ctrlAddEventHandler ["buttonClick", { closeDialog 2; [cursorobject,[["ALF_Saumon",1],["Algues",4]],[["MRP_Sushi_Saumon",2]],10] spawn MRPV2_fnc_Traitement_Artisanat }];
    };
};

if (tolowerANSI "conditionnement" in _info_Modele) exitWith {
   
    private _b26 = missionNamespace getVariable ["b_26", false];
    private _b4  = missionNamespace getVariable ["b_4",  false];

    if (_b26 or _b4) then {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Conditionnement du Rhum";
        _bouton ctrlAddEventHandler ["buttonClick", {
            closeDialog 2;
            [cursorObject,
                [["bouteille_rhum",6],["carton_plat",1]],
                [["carton_rhum",1]],
                10
            ] spawn MRPV2_fnc_Traitement_Artisanat;
        }];
    };


    if (b_25) then {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Conditionnement de Compote";
        _bouton ctrlAddEventHandler ["buttonClick", {
            closeDialog 2;
            [cursorObject,
                [["TAG_Compote_F_F",6],["carton_plat",1]],
                [["MRP_Carton_Compote",1]],
                10
            ] spawn MRPV2_fnc_Traitement_Artisanat;
        }];
    };
};

if (tolowerANSI "furnace" in _info_Modele) exitWith {
  private _btns = _liste_Boutons select {!ctrlShown _x}; if (_btns isEqualTo []) exitWith {};
  private _b = _btns # 0;

  private _cargo = getMagazineCargo cursorObject;
  private _cls = _cargo # 0; private _cnt = _cargo # 1;
  private _lcls = _cls apply { toLower _x };
  private _countIC = {
    params ["_name"];
    private _i = _lcls find (toLower _name);
    if (_i < 0) exitWith {0};
    _cnt # _i
  };

  private _hasFer  = (["ALF_pierre_fer_small"]  call _countIC) > 0;
  private _hasCuiv = (["ALF_pierre_cui_small"] call _countIC) > 0;
  private _hasGlass = (["sable"]      call _countIC) > 0;

    if (_hasFer) then {
      _b ctrlShow TRUE; _b ctrlSetText "Fondre le Fer";
      _b ctrlAddEventHandler ["buttonClick", { closeDialog 2; [cursorObject,[["ALF_pierre_fer_small",1]],[["ALF_Fer",1]],20] spawn MRPV2_fnc_Traitement_Artisanat; }];
    };
      if (_hasCuiv) then {
        _b ctrlShow TRUE; _b ctrlSetText "Fondre le Cuivre";
        _b ctrlAddEventHandler ["buttonClick", { closeDialog 2; [cursorObject,[["ALF_pierre_cui_small",1]],[["ALF_Cuivre",1]],20] spawn MRPV2_fnc_Traitement_Artisanat; }];
    };
      if (_hasGlass) then {
        _b ctrlShow TRUE; _b ctrlSetText "Fondre le Sable";
        _b ctrlAddEventHandler ["buttonClick", { closeDialog 2; [cursorObject,[["sable",1]],[["Verre_plat",1]],20] spawn MRPV2_fnc_Traitement_Artisanat; }];
    };

   if(b_29) exitWith 
        {
            private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Fabrication IPN";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["ALF_Fer",2]],[["MRP_IPN",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];

             private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText "Fabrication Cerceau";
            _bouton ctrlAddEventHandler ["buttonClick", 
            {closeDialog 2;
                [cursorobject,[["ALF_Fer",1]],[["cerceau",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
            }];
        };
};


if (tolowerANSI "secheurTabac" in _info_Modele) exitwith 
{
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Sechage des Feuilles de Tabac";
        _bouton ctrlAddEventHandler ["buttonClick", 
        {closeDialog 2;
            [cursorobject,[["ALF_Tabac",1]],[["ALF_Tabac_Seche",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        }];
};

if ((toLower _info_Modele) find "recharge" >= 0) exitWith {
    private _bouton = (_liste_Boutons select { !ctrlShown _x }) param [0, controlNull];
    if (isNull _bouton) exitWith {
        diag_log "Aucun bouton disponible pour 'Recharger'.";
    };
        _bouton ctrlShow true;
        _bouton ctrlSetText "Recharger";
        _bouton ctrlRemoveAllEventHandlers "ButtonClick";
        _bouton ctrlAddEventHandler ["ButtonClick",
        {
            params ["_ctrl"];
            private _station = cursorObject; 
            [_station, 120, 3.5] spawn MRPV2_fnc_rebreatherRecharge;
            systemChat "Recharge du recycleur lancée…";
        }
    ];
};

if (tolowerANSI "cigcigare" in _info_Modele) exitwith 
{
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Confection de Cigarettes";
        _bouton ctrlAddEventHandler ["buttonClick", 
        {closeDialog 2;
            [cursorobject,[["ALF_Tabac_Seche",5]],[["murshun_cigs_cig0",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        }];

        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Confection de Cigares";
        _bouton ctrlAddEventHandler ["buttonClick", 
        {closeDialog 2;
            [cursorobject,[["ALF_Tabac_Seche",5]],[["immersion_cigs_cigar0",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        }];
};

if (toLowerANSI "pressoir" in _info_Modele) exitWith {


    private _b26 = missionNamespace getVariable ["b_26", false];
    private _b4  = missionNamespace getVariable ["b_4",  false];

    if (_b26 or _b4) then {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Pressage de la canne à sucre";
        _bouton ctrlAddEventHandler ["buttonClick", {
            closeDialog 2;
            [ cursorObject,
              [["canne_a_sucre",5],["Bidon_Vide",1]],
              [["Copeaux_canne_sucre",5],["Bidon_Canne",1]],
              10
            ] spawn MRPV2_fnc_Traitement_Artisanat;
        }];
    };
};

if (toLowerANSI "concentrateur" in _info_Modele) exitWith {

    if (b_12) then {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Traitement du pétrole";
        _bouton ctrlAddEventHandler ["buttonClick", {
            closeDialog 2;
            [ cursorObject,
              [["ALF_Barile_P_F",1]],
              [["ALF_Barile_P_E",1],["ALF_Barile_Station",2]],
              20
            ] spawn MRPV2_fnc_Traitement_Artisanat;
        }];
    } else {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Traitement du pétrole";
        _bouton ctrlAddEventHandler ["buttonClick", {
            closeDialog 2;
            [ cursorObject,
              [["ALF_Barile_P_F",1]],
              [["ALF_Barile_Station",1]],
              20
            ] spawn MRPV2_fnc_Traitement_Artisanat;
        }];
    };
};

if (tolowerANSI "alf_slotmachine" in _info_Modele AND {_obj distance player < 1.5}) exitwith 
{
    [_obj,_liste_Boutons] call MRPV2_fnc_Interaction_Objets_Casino_Machine_A_Sous;
};

if (tolowerANSI "suitcase_f" in _info_Modele AND {isnull attachedto _obj}) exitwith 
{
   private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
    _bouton ctrlShow TRUE;
    _bouton ctrlSetText "Prendre la malette";
    _bouton ctrlAddEventHandler ["buttonClick", 
    {closeDialog 2;}];
};


if (_liste_Boutons select {ctrlshown _x} isequalto []) then {closeDialog 2;};
// };
*/








// MRPV2_fnc_Interaction_Objets = {
private _obj = param [0,objnull];

private _maxDist = if (typeOf _obj in ["Land_PortableLight_single_F","Land_PortableLight_double_F"] || {typeOf _obj isEqualTo "ALF_Barricades"}) then {5} else {3};
if (gestureState player isEqualTo "<none>" OR {_obj distance player > _maxDist}) exitWith {};

life_pInact_curObject = _obj;

private _liste_Actions = createhashmap;
private _liste_Sous_Actions = [];
private _info_Modele = tolowerANSI ((getModelInfo _obj) # 0);

// Casier
if (tolowerANSI "casier.p3d" in _info_Modele) exitwith 
{    
    private _texte = "M'assigné ce casier";
    private _texte_tooltype = "S'assigner ce casier";
    private _action = 
    {
        closeDialog 0;
        [] call ALF_fnc_addMobilierCopclient;
    };
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Mobilier - S'asseoir
private _liste_Mobiliers = ["officechair_01_f","alf_g_chaise_bois","alf_chaise_3","alf_g_chaise"];
if (_liste_Mobiliers select {_x in _info_Modele} isnotequalto [] AND {_obj distance player < 2}) exitWith 
{
    private _texte = "S'asseoir";
    private _texte_tooltype = "S'asseoir sur le mobilier";
    private _action = 
    {
        closeDialog 0;
        private _obj = life_pInact_curObject;
        if (animationstate player isNotequalto "crew") then {[_obj,"action"] call ALF_fnc_sitDown;};
    };
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};
private _poubelles = ["wheeliebin"];
if (_poubelles select {_x in _info_Modele} isnotequalto [] AND {_obj distance player < 2}) exitWith 
{
    private _texte = "Allumer un feu de poubelle";
    private _texte_tooltype = "Allumer un feu de poubelle";
    private _action = 
    {
        closeDialog 0;
        private _obj = life_pInact_curObject;
        if !([player,"murshun_cigs_lighter"] call BIS_fnc_hasItem) exitWith {["Feu", "Vous n'avez pas de briquet !", "warning"] spawn ALF_fnc_doMsg;};
        private _adn = player getVariable "adnface" select 0;
        [_obj] remoteExec ["ALF_Server_fnc_burn_poubelle",2];
        private _dice = random(100);
        if(_dice < 75) then {
            _data = _obj getVariable ["ilyadeladn",[]];
            if(count _data isEqualTo 0) then {
                _obj setVariable["ilyadeladn",[_adn],true];
            } else {
                _data pushBack _adn;
                _obj setVariable["ilyadeladn",_data,true]; 
            };
        };
    };
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

//DIR Objet sur les routes
if (tolowerANSI "tyre_f" in _info_Modele) exitwith  
{
    if !(b_18 && b_enService) exitwith {};

        private _texte1 = "Rammasser l'objet";
        private _texte_tooltype1 = "Rammasser l'objet";
        private _action1 = {closeDialog 0; [] spawn  ALF_fnc_dirMenu;};
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];
		
        _liste_Actions set ["",_liste_Sous_Actions];
        [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Projecteurs portables
if (typeOf _obj in ["Land_PortableLight_single_F","Land_PortableLight_double_F"]) exitWith
{
	private _texte1 = "RECUPERER";
	private _texte_tooltype1 = "Récupérer l'objet";
	private _action1 =
	{
		closeDialog 0;
		[life_pInact_curObject] spawn ALF_fnc_object_packup;
	};
	_liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

	private _texte2 = "DEPLACER";
	private _texte_tooltype2 = "Déplacer l'objet";
	private _action2 =
	{
		closeDialog 0;
		[life_pInact_curObject] spawn ALF_fnc_object_escort;
	};
	_liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];

	_liste_Actions set ["",_liste_Sous_Actions];
	[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Barrière
if (typeOf _obj isEqualTo "ALF_Barricades") exitWith
{
	private _texte1 = "RECUPERER";
	private _texte_tooltype1 = "Récupérer l'objet";
	private _action1 =
	{
		closeDialog 0;
		[life_pInact_curObject] spawn ALF_fnc_object_packup;
	};
	_liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

	private _texte2 = "DEPLACER";
	private _texte_tooltype2 = "Déplacer l'objet";
	private _action2 =
	{
		closeDialog 0;
		[life_pInact_curObject] spawn ALF_fnc_object_escort;
	};
	_liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];

	_liste_Actions set ["",_liste_Sous_Actions];
	[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

//Generateur
if (tolowerANSI "portable_generator_f" in _info_Modele) exitwith  
{
        private _texte1 = "Rammasser l'objet";
        private _texte_tooltype1 = "Rammasser l'objet";
        private _action1 = {closeDialog 0; [1, life_pInact_curObject] spawn  ALF_fnc_poseGenerator;};
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];
		
        _liste_Actions set ["",_liste_Sous_Actions];
        [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};
if (tolowerANSI "powergenerator_f" in _info_Modele) exitwith  
{
    if !(MRP_Bie_EnService || b_18) exitwith {};

        private _texte1 = "Rammasser l'objet";
        private _texte_tooltype1 = "Rammasser l'objet";
        private _action1 = {closeDialog 0; [3, life_pInact_curObject] spawn  ALF_fnc_poseGenerator;};
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];
		
        _liste_Actions set ["",_liste_Sous_Actions];
        [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// PC Screen
if (tolowerANSI "pcset_01_screen_f" in _info_Modele) exitwith 
{
    private _CSP_Proche = (nearestTerrainObjects [player, [], 20] select {"Land_Caserne_MRP" in str _x}) isnotequalto [];
    if (life_medicLevel > 9 AND {_CSP_Proche}) exitwith 
    {        
        private _texte1 = "Consulter le CNP";
        private _texte_tooltype1 = "Consulter le CNP";
        private _action1 = {closeDialog 0; [0] call ALF_fnc_cnpMenu;};
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

        private _texte2 = "Liste des retraits";
        private _texte_tooltype2 = "Voir la liste des retraits";
        private _action2 = {closeDialog 0; [1] call ALF_fnc_cnpMenu;};
        _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];

        _liste_Actions set ["",_liste_Sous_Actions];
        [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
    };

    private _dans_Cybercafe = (allmapmarkers select {markerpos _x distance player < 20 AND {markertype _x isequalto "MRPV2_cyber_icon"}}) isnotequalto [];
    if (_dans_Cybercafe) exitwith 
    {
        private _texte = "Accéder à Internet";
        private _texte_tooltype = "Accéder à Internet";
        private _action = {closeDialog 0; [] call ALF_fnc_menuInternet;};
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
        [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
    };

    private _gendarmerie_Principale_Proche = (nearestTerrainObjects [player, [], 50] select {"Land_mrp_gendarmerie_principale" in str _x}) isnotequalto [];
    private _gendarmerie_Proche = (nearestTerrainObjects [player, [], 50] select {"Land_mrp_gendarmerie_e" in str _x || "Land_MRP_Caserne_GN" in str _x}) isnotequalto [];
    if ((_gendarmerie_Principale_Proche OR {_gendarmerie_Proche}) AND {life_gendarme_service}) exitwith 
    {
        private _texte1 = "CNG";
        private _texte_tooltype1 = "Ouvrir le CNG";
        private _action1 = {closeDialog 0; [] call ALF_fnc_cngMenu;};
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

        private _texte2 = "Base de donnée ADN";
        private _texte_tooltype2 = "Ouvrir la base de données ADN";
        private _action2 = {closeDialog 0; [] call ALF_fnc_adnMenu;};
        _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];

        private _texte3 = "Base de donnée FACIES";
        private _texte_tooltype3 = "Ouvrir la base de données FACIES";
        private _action3 = {closeDialog 0; [] call ALF_fnc_faceMenu;};
        _liste_Sous_Actions pushback [_texte3,_texte_tooltype3,_action3];

        private _texte4 = "Menu Haut Parleur";
        private _texte_tooltype4 = "Ouvrir le menu haut parleur";
        private _action4 = {closeDialog 0; [0] call ALF_fnc_copHautParleur;};
        _liste_Sous_Actions pushback [_texte4,_texte_tooltype4,_action4];

        _liste_Actions set ["",_liste_Sous_Actions];
        [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
    };

    if (b_33) exitwith 
    {    
        private _ent = (nearestObjects [player, ["Land_MRP_Concessionnaire"], 20]) # 0;
        private _info_Ent = _ent getVariable ["business",[]];

        if (_info_Ent isNotEqualTo []) then 
        {
			private _uid = getPlayerUID player;
			private _joueur_Est_Gerant = ((_info_Ent # 5) select {
				(_x # 1) isEqualTo _uid AND {(_x # 2) in [3,4]}
			}) isNotEqualTo [];

            //private _joueur_Est_Gerant = ((_info_Ent # 5) select {getPlayerUID player isequalto (_x # 1) AND {4 isequalto (_x # 2)}}) isNotequalto [];  
            if (_joueur_Est_Gerant) then 
            {
                private _texte1 = "Gestion de l'entreprise";
                private _texte_tooltype1 = "Gérer l'entreprise";
                private _action1 = 
                {
                    closeDialog 0;
                    private _ent = (nearestObjects [player, ["Land_MRP_Concessionnaire"], 20]) # 0;
                    [_ent] spawn alf_fnc_menuBusiness;
                };
                _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];           
            };

            private _nom_Ent = _info_Ent # 1;
            private _groupe_Ent_Existe = (groupId group player) isEqualTo _nom_Ent;
            if (_groupe_Ent_Existe) then
            {
                private _texte = "Terminer son service";
                private _texte_tooltype = "Terminer son service";
                private _action =
                {
                    closeDialog 0;
                    private _nom_Ent = groupId group player;
                    private _collegues = (units group player) - [player];
                    [player] joinSilent (createGroup civilian);
                    if (b_Depanneur) then {b_Depanneur = false;};
                    ["Entreprise", format["Vous avez terminé votre service de %1.", _nom_Ent], "info"] spawn ALF_fnc_doMsg;
                    {["Entreprise", format["%1 a terminé son service.", name player], "info"] remoteExec ["ALF_fnc_doMsg", _x]} forEach _collegues;
                };
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            } else 
            {
                private _texte = "Prendre son service";
                private _texte_tooltype = "Prendre son service";
                private _action = 
                {
                    closeDialog 0;
                    private _ent = (nearestObjects [player, ["Land_MRP_Concessionnaire"], 20]) # 0;
                    private _info_Ent = _ent getVariable ["business",[]];
                    private _nom_Ent = _info_Ent # 1;
                    private _groupe_Ent_Existe = ((groups civilian) select {groupId _x isEqualto _nom_Ent}) isnotequalto [];
                    if (_groupe_Ent_Existe) then
                    {
                        private _groupe = ((groups civilian) select {groupId _x isEqualto _nom_Ent}) # 0;
                        [player] joinSilent _groupe;                    
                    } else 
                    {
                        private _groupe = createGroup civilian;
                        _groupe setGroupIdGlobal [_nom_Ent];
                        [player] joinSilent _groupe;
                    };
                    if (tolowerANSI "HORIZON" in (tolowerANSI groupid _groupe) AND {tolowerANSI "DEPANNAGE" in (tolowerANSI groupid _groupe)}) then
                    {
                        b_Depanneur = true;
                    };
                    private _collegues = (units group player) - [player];
                    ["Entreprise", format["Vous avez pris votre service de %1.", _nom_Ent], "info"] spawn ALF_fnc_doMsg;
                    {["Entreprise", format["%1 a pris son service.", name player], "info"] remoteExec ["ALF_fnc_doMsg", _x]} forEach _collegues;
                };
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            };

            if (license_fisc) then 
            {
                private _texte = "Menu FISC";
                private _texte_tooltype = "Ouvrir le menu FISC";
                private _action = 
                {
                    closeDialog 0;
                    private _ent = (nearestObjects [player, ["Land_MRP_Concessionnaire"], 20]) # 0;
                    [0,_ent getVariable ["business",[]] select 2] call ALF_fnc_dialogFisc;
                };
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            };

            private _texte2 = "Achat de véhicule";
            private _texte_tooltype2 = "Acheter un véhicule";
            private _action2 = {closeDialog 0; ["b_33","Achat véhicule"] call ALF_fnc_vehicleShopMenuV2;};
            _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];

            private _texte1 = "Achat de fourn. de base";
            private _texte_tooltype1 = "Acheter des fournitures de base";
            private _action1 = {closeDialog 0; [nil,nil,nil,"b_0"] call ALF_fnc_weaponShopMenu;};
            _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

            private _texte2 = "Achat de fourn. d'entreprise";
            private _texte_tooltype2 = "Acheter des fournitures d'entreprise";
            private _action2 = {closeDialog 0; [nil,nil,nil,"b_33"] call ALF_fnc_weaponShopMenu;};
            _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];
            
            private _texte3 = "Magasin de Vetements";
            private _texte_tooltype3 = "Ouvrir le magasin de vêtements";
            private _action3 = {closeDialog 0; [nil,nil,nil,"b_33"] call ALF_fnc_clothingMenu;};
            _liste_Sous_Actions pushback [_texte3,_texte_tooltype3,_action3];
        };

        _liste_Actions set ["",_liste_Sous_Actions];
        [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
    };
};

// Bureau
if (tolowerANSI "bureau1" in _info_Modele OR {tolowerANSI "mrp_bureau" in _info_Modele}) exitwith 
{
    private _gendarmerie_Principale_Proche = (nearestTerrainObjects [player, [], 50] select {"Land_mrp_gendarmerie_principale" in str _x}) isnotequalto [];
    private _gendarmerie_Proche = (nearestTerrainObjects [player, [], 50] select {"Land_mrp_gendarmerie_e" in str _x || "Land_MRP_Caserne_GN" in str _x}) isnotequalto [];
    if ((_gendarmerie_Principale_Proche OR {_gendarmerie_Proche}) AND {life_gendarme_service}) exitwith 
    {
        private _texte1 = "CNG";
        private _texte_tooltype1 = "Ouvrir le CNG";
        private _action1 = {closeDialog 0; [] call ALF_fnc_cngMenu;};
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

        private _texte2 = "Base de donnée ADN";
        private _texte_tooltype2 = "Ouvrir la base de données ADN";
        private _action2 = {closeDialog 0; [] call ALF_fnc_adnMenu;};
        _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];

        private _texte3 = "Base de donnée FACIES";
        private _texte_tooltype3 = "Ouvrir la base de données FACIES";
        private _action3 = {closeDialog 0; [] call ALF_fnc_faceMenu;};
        _liste_Sous_Actions pushback [_texte3,_texte_tooltype3,_action3];

        private _texte4 = "Menu Haut Parleur";
        private _texte_tooltype4 = "Ouvrir le menu haut parleur";
        private _action4 = {closeDialog 0; [0] call ALF_fnc_copHautParleur;};
        _liste_Sous_Actions pushback [_texte4,_texte_tooltype4,_action4];

        _liste_Actions set ["",_liste_Sous_Actions];
        [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
    };
};

// Brancard (VEH_MRP_Brancard_Vsav et ALF_Brancard_P)
if (typeOf _obj in ["ALF_Brancard_P", "VEH_MRP_Brancard_Vsav"]) exitwith
{
    private _patient = (crew cursorobject) # 0;
    if (isnil {_patient}) exitwith {};

    if ("ALF_Defibrilateur" in (magazines player)) then 
    {
        private _texte = "Réanimer";
        private _texte_tooltype = "Réanimer le patient";
        private _action = 
        {
            closeDialog 0;
            private _patient = (crew cursorobject) # 0;
            if (isnil {_patient}) exitwith {};
            [_patient] spawn ALF_fnc_revivePlayer;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    if (_patient getVariable["MedicalStats",[]] isnotequalto [] AND {"ALF_Guardian" in (magazines player) AND {life_pompier_service OR {life_penit_service AND {license_medWork}}}}) then
    {
        private _texte = "Ouvrir le menu du Guardian";
        private _texte_tooltype = "Ouvrir le menu du Guardian";
        private _action =
        {
            closeDialog 0;
            private _patient = (crew cursorobject) # 0;
            if (isnil {_patient}) exitwith {};
            [_patient] spawn ALF_fnc_menuGuardian;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    // Sortir le patient du brancard (pompier ou médecin niveau > 0)
    if (crew cursorobject isNotEqualTo [] AND {life_medicLevel > 0 OR life_pompier_service}) then
    {
        private _texte2 = "Sortir le patient du brancard";
        private _texte_tooltype2 = "Faire descendre le patient du brancard";
        private _action2 =
        {
            closeDialog 0;
            private _patient = (crew cursorobject) # 0;
            if (isNil "_patient" OR {isNull _patient}) exitWith {
                ["INFO", "Le brancard est vide.", "warning"] spawn ALF_fnc_doMsg;
            };
            moveOut _patient;
            ["INFO", "Vous avez sorti le patient du brancard.", "success"] spawn ALF_fnc_doMsg;
        };
        _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];
    };

    if (_liste_Sous_Actions isequalto []) exitwith {};
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Table bois
if (tolowerANSI "table_bois" in _info_Modele) exitwith 
{
    private _texte = "Découper le bois";
    private _texte_tooltype = "Découper le bois";
    private _action = 
    {
        closeDialog 0;
        [cursorobject,[["ALF_Buche",1]],[["ALF_Planche_B",2],["copeaux_bois",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
    };
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    
    if(b_10) then 
    {
        private _texte1 = "Création de Bobine";
        private _texte_tooltype1 = "Créer une bobine";
        private _action1 = 
        {
            closeDialog 0;
            [cursorobject,[["ALF_Planche_B",3]],[["bobine",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

        private _texte2 = "Création de Linteau de Bois";
        private _texte_tooltype2 = "Créer un linteau de bois";
        private _action2 = 
        {
            closeDialog 0;
            [cursorobject,[["ALF_Buche",1]],[["MRP_Linteau",4],["copeaux_bois",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];
    };

    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Workbench
if (tolowerANSI "workbench" in _info_Modele) exitwith 
{
    if(b_10) then 
    {
        private _texte1 = "Conditionnement de linteau";
        private _texte_tooltype1 = "Conditionner le linteau";
        private _action1 = 
        {
            closeDialog 0;
            [cursorobject,[["MRP_Linteau",6]],[["MRP_Linteau_x6",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

        private _texte2 = "Creation de Palette";
        private _texte_tooltype2 = "Créer une palette";
        private _action2 = 
        {
            closeDialog 0;
            [cursorobject,[["ALF_Planche_B",6],["MRP_Plot_Palette",9]],[["MRP_Palette",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];

        private _texte3 = "Création de Plot pour Palette";
        private _texte_tooltype3 = "Créer un plot pour palette";
        private _action3 = 
        {
            closeDialog 0;
            [cursorobject,[["copeaux_bois",4],["MRP_Seau_Colle",1]],[["MRP_Plot_Palette",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte3,_texte_tooltype3,_action3];

        private _texte4 = "Création de Tonneau en Bois";
        private _texte_tooltype4 = "Créer un tonneau en bois";
        private _action4 = 
        {
            closeDialog 0;
            [cursorobject,[["ALF_Planche_B",6],["cerceau",4]],[["Barrel",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte4,_texte_tooltype4,_action4];
    };
    
    if(b_29) then 
    {
        private _texte1 = "Conditionnement IPN x6";
        private _texte_tooltype1 = "Conditionner l'IPN";
        private _action1 = 
        {
            closeDialog 0;
            [cursorobject,[["MRP_IPN",6]],[["MRP_IPN_x6",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

        private _texte2 = "Création de bobine de fil de fer";
        private _texte_tooltype2 = "Créer une bobine de fil de fer";
        private _action2 = 
        {
            closeDialog 0;
            [cursorobject,[["bobine",1],["ALF_Fer",4]],[["MRP_IPN_x6",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];
    };

    if(b_24) then 
    {
        private _texte1 = "Conditionnement Verre X10";
        private _texte_tooltype1 = "Conditionner le verre";
        private _action1 = 
        {
            closeDialog 0;
            [cursorobject,[["Verre_plat",10]],[["Verre_plat_x10",1]],20] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];
    };

    if (_liste_Sous_Actions isequalto []) exitwith {};
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Embouteillage
if (tolowerANSI "embouteillage" in _info_Modele) exitwith 
{
    private _b26 = missionNamespace getVariable ["b_26", false];
    private _b4  = missionNamespace getVariable ["b_4",  false];

    if (_b26 or _b4) then 
    {
        private _texte = "Mise en Bouteille du Rhum";
        private _texte_tooltype = "Mettre le rhum en bouteille";
        private _action = 
        {
            closeDialog 0;
            [cursorobject,[["Bidon_Rhum",1],["bouteille_vide",5]],[["bouteille_rhum",5],["Bidon_Vide",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    if (_liste_Sous_Actions isequalto []) exitwith {};
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Mixeur
if (tolowerANSI "mixeur" in _info_Modele) exitwith 
{
    private _texte = "Mixer les bananes";
    private _texte_tooltype = "Mixer les bananes";
    private _action = 
    {
        closeDialog 0;
        [cursorobject,[["ALF_banane",1]],[["TAG_Compote_F_F",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
    };
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Milling
if (tolowerANSI "milling" in _info_Modele) exitwith 
{
    private _cargo = getMagazineCargo cursorObject;
    private _cls = _cargo # 0; 
    private _cnt = _cargo # 1;
    private _lcls = _cls apply { toLower _x };
    private _countIC = {
        params ["_name"];
        private _i = _lcls find (toLower _name);
        if (_i < 0) exitWith {0};
        _cnt # _i
    };

    private _hasDiamant = (["ALF_Pierre_dia_small"] call _countIC) > 0;
    private _hasSaphir = (["ALF_saphir_small"] call _countIC) > 0;

    if (_hasDiamant) then 
    {
        private _texte = "Traitement du Diamant";
        private _texte_tooltype = "Traiter le diamant";
        private _action = 
        {
            closeDialog 0;
            [cursorObject,[["ALF_Pierre_dia_small",1]],[["ALF_diamant_taille",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };
    
    if (_hasSaphir) then 
    {
        private _texte = "Traitement du Saphir";
        private _texte_tooltype = "Traiter le saphir";
        private _action = 
        {
            closeDialog 0;
            [cursorObject,[["ALF_saphir_small",1]],[["ALF_saphir_taille",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };
   
    if (b_14) then 
    {
        private _texte = "Taille du Diamant Précieux";
        private _texte_tooltype = "Tailler le diamant précieux";
        private _action = 
        {
            closeDialog 0;
            [cursorObject,[["ALF_diamant_taille",1]],[["ALF_diamant_precieux",1]],20] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    if (b_17) then 
    {
        private _texte = "Taille du Saphir Précieux";
        private _texte_tooltype = "Tailler le saphir précieux";
        private _action = 
        {
            closeDialog 0;
            [cursorObject,[["ALF_saphir_taille",1]],[["MRP_saphir_precieux",1]],20] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    if (_liste_Sous_Actions isequalto []) exitwith {};
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Barrel
if (tolowerANSI "barrel" in _info_Modele) exitwith 
{
    private _b26 = missionNamespace getVariable ["b_26", false];
    private _b4  = missionNamespace getVariable ["b_4",  false];

    if (_b26 or _b4) then 
    {
        private _texte = "Fermentation du Rhum";
        private _texte_tooltype = "Fermenter le rhum";
        private _action = 
        {
            closeDialog 0;
            [cursorobject,[["Bidon_Canne",1]],[["Bidon_Rhum",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    if (_liste_Sous_Actions isequalto []) exitwith {};
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Fedex
if (tolowerANSI "fedex" in _info_Modele) exitWith 
{
    private _cargo = getMagazineCargo cursorObject;
    private _cls = _cargo # 0; 
    private _cnt = _cargo # 1;
    private _lcls = _cls apply { toLower _x };
    private _countIC = {
        params ["_name"];
        private _i = _lcls find (toLower _name);
        if (_i < 0) exitWith {0};
        _cnt # _i
    };

    private _hassushisaumon = (["ALF_Thon"] call _countIC) > 0;
    private _hassushithon = (["ALF_Saumon"] call _countIC) > 0;

    if (_hassushisaumon) then 
    {
        private _texte = "sushi thon";
        private _texte_tooltype = "Faire des sushis au thon";
        private _action = 
        {
            closeDialog 0;
            [cursorobject,[["ALF_Thon",1],["Algues",4]],[["MRP_Sushi_Thon",2]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };
    
    if (_hassushithon) then 
    {
        private _texte = "sushi saumon";
        private _texte_tooltype = "Faire des sushis au saumon";
        private _action = 
        {
            closeDialog 0;
            [cursorobject,[["ALF_Saumon",1],["Algues",4]],[["MRP_Sushi_Saumon",2]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    if (_liste_Sous_Actions isequalto []) exitwith {};
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Conditionnement
if (tolowerANSI "conditionnement" in _info_Modele) exitWith 
{
    private _b26 = missionNamespace getVariable ["b_26", false];
    private _b4  = missionNamespace getVariable ["b_4",  false];

    if (_b26 or _b4) then 
    {
        private _texte = "Conditionnement du Rhum";
        private _texte_tooltype = "Conditionner le rhum";
        private _action = 
        {
            closeDialog 0;
            [cursorObject,[["bouteille_rhum",6],["carton_plat",1]],[["carton_rhum",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    if (b_25) then 
    {
        private _texte = "Conditionnement de Compote";
        private _texte_tooltype = "Conditionner la compote";
        private _action = 
        {
            closeDialog 0;
            [cursorObject,[["TAG_Compote_F_F",6],["carton_plat",1]],[["MRP_Carton_Compote",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    if (_liste_Sous_Actions isequalto []) exitwith {};
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Furnace
if (tolowerANSI "furnace" in _info_Modele) exitWith 
{
    private _cargo = getMagazineCargo cursorObject;
    private _cls = _cargo # 0; 
    private _cnt = _cargo # 1;
    private _lcls = _cls apply { toLower _x };
    private _countIC = {
        params ["_name"];
        private _i = _lcls find (toLower _name);
        if (_i < 0) exitWith {0};
        _cnt # _i
    };

    private _hasFer = (["ALF_pierre_fer_small"] call _countIC) > 0;
    private _hasCuiv = (["ALF_pierre_cui_small"] call _countIC) > 0;
    private _hasGlass = (["sable"] call _countIC) > 0;

    if (_hasFer) then 
    {
        private _texte = "Fondre le Fer";
        private _texte_tooltype = "Fondre le fer";
        private _action = 
        {
            closeDialog 0;
            [cursorObject,[["ALF_pierre_fer_small",1]],[["ALF_Fer",1]],20] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };
    
    if (_hasCuiv) then 
    {
        private _texte = "Fondre le Cuivre";
        private _texte_tooltype = "Fondre le cuivre";
        private _action = 
        {
            closeDialog 0;
            [cursorObject,[["ALF_pierre_cui_small",1]],[["ALF_Cuivre",1]],20] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };
    
    if (_hasGlass) then 
    {
        private _texte = "Fondre le Sable";
        private _texte_tooltype = "Fondre le sable";
        private _action = 
        {
            closeDialog 0;
            [cursorObject,[["sable",1]],[["Verre_plat",1]],20] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    if(b_29) then 
    {
        private _texte1 = "Fabrication IPN";
        private _texte_tooltype1 = "Fabriquer de l'IPN";
        private _action1 = 
        {
            closeDialog 0;
            [cursorobject,[["ALF_Fer",2]],[["MRP_IPN",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

        private _texte2 = "Fabrication Cerceau";
        private _texte_tooltype2 = "Fabriquer un cerceau";
        private _action2 = 
        {
            closeDialog 0;
            [cursorobject,[["ALF_Fer",1]],[["cerceau",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];
    };

    if (_liste_Sous_Actions isequalto []) exitwith {};
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Secheur Tabac
if (tolowerANSI "secheurTabac" in _info_Modele) exitwith 
{
    private _texte = "Sechage des Feuilles de Tabac";
    private _texte_tooltype = "Sécher les feuilles de tabac";
    private _action = 
    {
        closeDialog 0;
        [cursorobject,[["ALF_Tabac",1]],[["ALF_Tabac_Seche",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
    };
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Recharge
if ((toLower _info_Modele) find "recharge" >= 0) exitWith 
{
    private _texte = "Recharger";
    private _texte_tooltype = "Recharger le recycleur";
    private _action = 
    {
        closeDialog 0;
        private _station = cursorObject; 
        [_station, 120, 3.5] spawn MRPV2_fnc_rebreatherRecharge;
    };
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// CigCigare
if (tolowerANSI "cigcigare" in _info_Modele) exitwith 
{
    private _texte1 = "Confection de Cigarettes";
    private _texte_tooltype1 = "Confectionner des cigarettes";
    private _action1 = 
    {
        closeDialog 0;
        [cursorobject,[["ALF_Tabac_Seche",5]],[["murshun_cigs_cig0",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
    };
    _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

    private _texte2 = "Confection de Cigares";
    private _texte_tooltype2 = "Confectionner des cigares";
    private _action2 = 
    {
        closeDialog 0;
        [cursorobject,[["ALF_Tabac_Seche",5]],[["immersion_cigs_cigar0",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
    };
    _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];

    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Pressoir
if (toLowerANSI "pressoir" in _info_Modele) exitWith 
{
    private _b26 = missionNamespace getVariable ["b_26", false];
    private _b4  = missionNamespace getVariable ["b_4",  false];

    if (_b26 or _b4) then 
    {
        private _texte = "Pressage de la canne à sucre";
        private _texte_tooltype = "Presser la canne à sucre";
        private _action = 
        {
            closeDialog 0;
            [cursorObject,[["canne_a_sucre",5],["Bidon_Vide",1]],[["Copeaux_canne_sucre",5],["Bidon_Canne",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    if (_liste_Sous_Actions isequalto []) exitwith {};
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Concentrateur
if (toLowerANSI "concentrateur" in _info_Modele) exitWith 
{
    private _texte = "Traitement du pétrole";
    private _texte_tooltype = "Traiter le pétrole";
    private _action = 
    {
        closeDialog 0;
        if (b_12) then 
        {
            [cursorObject,[["ALF_Barile_P_F",1]],[["ALF_Barile_P_E",1],["ALF_Barile_Station",2]],20] spawn MRPV2_fnc_Traitement_Artisanat;
        } else 
        {
            [cursorObject,[["ALF_Barile_P_F",1]],[["ALF_Barile_Station",1]],20] spawn MRPV2_fnc_Traitement_Artisanat;
        };
    };
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Table de Blackjack (table directe OU joueur assis dedans)
private _bjTable = objNull;
if (typeOf _obj isEqualTo "ALF_TableBlackJack") then {
    _bjTable = _obj;
} else {
    if (_obj isKindOf "Man") then {
        private _veh = objectParent _obj;
        if !(isNull _veh) then {
            if (typeOf _veh isEqualTo "ALF_TableBlackJack") then {
                _bjTable = _veh;
            };
        };
    };
};

if (!(isNull _bjTable) AND {_bjTable distance player < 3}) exitWith
{
    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    uiNamespace setVariable ["ALF_BJ_InteractionTable", _bjTable];

    // Employé casino (b_20) : options croupier
    if (b_20) then {
        private _croupier = _bjTable getVariable ["ALF_BJ_Croupier", objNull];

        if (player isEqualTo _croupier) then {
            // Déjà croupier → quitter le poste
            private _texte = "Quitter le poste de croupier";
            private _texte_tooltype = "Vous ne tiendrez plus cette table";
            private _action = {
                closeDialog 0;
                private _tbl = uiNamespace getVariable ["ALF_BJ_InteractionTable", objNull];
                if (isNull _tbl) then {
                    _tbl = nearestObject [player, "ALF_TableBlackJack"];
                };
                if (isNull _tbl) exitWith {
                    ["Blackjack","Table introuvable.", "danger", false] spawn ALF_fnc_doMsg;
                };
                _tbl setVariable ["ALF_BJ_Croupier", objNull, true];
                [6, _tbl, player, 0] remoteExec ["ALF_Server_fnc_playBJ", 2];
                ["Blackjack","Vous avez quitté votre poste de croupier.", "warning", false] spawn ALF_fnc_doMsg;
            };
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        } else {
            if (isNull _croupier) then {
                // Pas de croupier → devenir croupier
                private _texte = "Tenir la table (Croupier)";
                private _texte_tooltype = "Devenir le croupier de cette table de Blackjack";
                private _action = {
                    closeDialog 0;
                    private _tbl = uiNamespace getVariable ["ALF_BJ_InteractionTable", objNull];
                    if (isNull _tbl) then {
                        _tbl = nearestObject [player, "ALF_TableBlackJack"];
                    };
                    if (isNull _tbl) exitWith {
                        ["Blackjack","Table introuvable.", "danger", false] spawn ALF_fnc_doMsg;
                    };
                    _tbl setVariable ["ALF_BJ_Croupier", player, true];
                    [6, _tbl, player, 1] remoteExec ["ALF_Server_fnc_playBJ", 2];
                    ["Blackjack","Vous êtes maintenant le croupier de cette table.", "success", false] spawn ALF_fnc_doMsg;

                    // Monitoring : si le croupier s'éloigne, il quitte automatiquement
                    [_tbl] spawn {
                        params ["_tbl"];
                        waitUntil {
                            sleep 2;
                            private _c = _tbl getVariable ["ALF_BJ_Croupier", objNull];
                            (isNull _c) || {!(_c isEqualTo player)} || {player distance _tbl > 5} || {!alive player}
                        };
                        // Si c'est nous qui sommes partis
                        private _c = _tbl getVariable ["ALF_BJ_Croupier", objNull];
                        if (player isEqualTo _c) then {
                            _tbl setVariable ["ALF_BJ_Croupier", objNull, true];
                            [6, _tbl, player, 0] remoteExec ["ALF_Server_fnc_playBJ", 2];
                            ["Blackjack","Vous avez quitté votre poste de croupier.", "danger", false] spawn ALF_fnc_doMsg;
                        };
                    };
                };
                _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            };
            // Employe casino non-croupier : peut aussi jouer comme un joueur normal
            private _texte = "Jouer au Blackjack";
            private _texte_tooltype = "Rejoindre la table de Blackjack (mise min. 500 EUR)";
            private _action = {
                closeDialog 0;
                private _tbl = uiNamespace getVariable ["ALF_BJ_InteractionTable", objNull];
                [0, _tbl] spawn ALF_fnc_playBJ;
            };
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        };
    } else {
        // Joueur normal → jouer
        private _texte = "Jouer au Blackjack";
        private _texte_tooltype = "Rejoindre la table de Blackjack (mise min. 500 €)";
        private _action = {
            closeDialog 0;
            private _tbl = uiNamespace getVariable ["ALF_BJ_InteractionTable", objNull];
            [0, _tbl] spawn ALF_fnc_playBJ;
        };
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    };

    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Machine à sous - Utilise encore l'ancien système mais adapté
if (tolowerANSI "alf_slotmachine" in _info_Modele AND {_obj distance player < 1.5}) exitwith
{
    private _actions_Machine = [_obj] call MRPV2_fnc_Interaction_Objets_Casino_Machine_A_Sous;
    if (_actions_Machine isNotEqualTo createHashMap) then 
    {
        [_actions_Machine] call MRPV2_fnc_Interaction_Menu_Creation;
    };
};

// Malette
if (tolowerANSI "suitcase_f" in _info_Modele AND {isnull attachedto _obj}) exitwith
{
    MRPV2_Interaction_Malette = _obj;
    private _texte = "Prendre la malette";
    private _texte_tooltype = "Prendre la malette";
    private _action = {
        closeDialog 0;
        [MRPV2_Interaction_Malette] spawn ALF_fnc_moneyBagHandle;
    };
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};

// Fallback - ALF_OBJECTS génériques (RECUPERER/DEPLACER)
// Si l'objet est un ALF_OBJECT mais ne correspond à aucun type spécifique ci-dessus
private _isAlfObject = [["ALF_OBJECTS", (typeOf _obj)]] call ALFTools_Client_Config_fnc_isClass;
if (_isAlfObject) then
{
    private _texte1 = "RECUPERER";
    private _texte_tooltype1 = "Récupérer l'objet";
    private _action1 =
    {
        closeDialog 0;
        [life_pInact_curObject] spawn ALF_fnc_object_packup;
    };
    _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

    private _texte2 = "DEPLACER";
    private _texte_tooltype2 = "Déplacer l'objet";
    private _action2 =
    {
        closeDialog 0;
        [life_pInact_curObject] spawn ALF_fnc_object_escort;
    };
    _liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];

    _liste_Actions set ["",_liste_Sous_Actions];
    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};
// };
