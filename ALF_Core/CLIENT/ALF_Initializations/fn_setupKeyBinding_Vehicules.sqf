//ALF_fnc_setupKeyBinding_Vehicules = {
["Martinique RP", "Sirenne_vehicule_ALF", ["Sirène vehicule", "Touche pour activer/desactiver les sirènes de votre vehicule."], 
{
    private _handle = false;
    if(vehicle player != player AND {life_pompier_service OR life_gendarme_service OR {life_penit_service AND {typeOf (vehicle player) in [
        "V_ALF_Berlingo2019PM_MRPV2",
        "V_ALF_Raptor_AP_MRPV2",
        "V_ALF_Bus_AP_MRPV2",
        "V_ALF_Berlingo2019AP_MRPV2",
        "VEH_Mercura_MRP_308_2022_AP",
        "VEH_Mercura_MRP_Mercedes_Sprinter_prison",
        "V_ALF_V250_AP_MRPV2",
        "VEH_Mercura_MRP_3008_2021_PM",
        "VEH_Mercura_MRP_308_2022_PM",
        "VEH_Mercura_MRP_Mercedes_Vito_Ap",
        "VEH_Mercura_MRP_Mercedes_Vito_Bana_Ap",
        "VEH_Mercura_MRP_Skoda_Karoq_Ap",
        "VEH_Mercura_MRP_Skoda_Karoq_Pm",
        "VEH_MRP_Mercura_Peugeot_Partner_Pm",
        "VEH_MRP_Mercura_Peugeot_Partner_Pm2",
        "VEH_MRP_Mercura_clio_2_Ap_Bana",
        "VEH_MRP_Mercura_clio_2_Pm_Bana",
        "VEH_Mercura_MRP_Ineos_Grenadier_Pm",
        "VEH_Mercura_MRP_Ineos_Grenadier_Ap",
        "VEH_Mercura_Bana_MRP_3008_2021_Ap"
        ]}}} AND {(driver vehicle player) isEqualTo player}) then 
    {
        _handle = true;
        private _veh = vehicle player;
        
        if (({typeOf _x isEqualTo "#dynamicsound"} count (attachedObjects _veh)) > 0) then 
        {
            {
                if ((typeOf _x) isEqualTo "#dynamicsound") exitWith 
                {
                    detach _x;
                    deleteVehicle _x;
                };
            } forEach (attachedObjects _veh);
        } 
        else 
        {
            private _type_Syrene = "ALFSirenLong";

            [] call 
            {    
                if (life_pompier_service) exitWith {_type_Syrene = "ALFmedicSiren";};
                if (life_penit_service) exitWith {_type_Syrene = "ALFpenitSiren";};
            };

            private _sound = createSoundSource [_type_Syrene, position player, [], 0];
            _sound attachTo [_veh];
        };
    };
    _handle
}, {}, [33, [false, false, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Deverouiller_vehiculemaison_ALF", ["Deverouiller le véhicule", "Touche pour ouvrir/fermer votre véhicule."], 
{
    private "_veh";
    if(isNull objectParent player) then 
    {
        _veh = cursorObject;
    } 
    else 
    {
        _veh = vehicle player;
    };

    [] call 
    {
        private _info_owner = tolower str ((_veh getvariable ["vehicle_info_owners",["",""]]) # 0);
        if (life_pompier_service AND {tolower "pompiers" in _info_owner}) exitwith 
        {
            life_vehicles pushBackUnique _veh;
            life_vehicles = life_vehicles select {!isnull _x};
        };

        if (life_gendarme_service AND {tolower "gendarme" in _info_owner}) exitwith 
        {
            life_vehicles pushBackUnique _veh;
            life_vehicles = life_vehicles select {!isnull _x};
        };
    };

    if(_veh in life_vehicles AND {(player distance _veh < 9) OR (_veh isKindOf "Boat" AND (player distance _veh < 12))}) then 
    {
        private _locked = locked _veh;
        if (_locked isEqualTo 2) then 
        {
            if (local _veh) then 
            {
                _veh lock 0;
            } 
            else 
            {
                [_veh,0] remoteExecCall ["ALF_fnc_lockVehicle",_veh];
            };

            [_veh,FALSE] remoteExec ["lockInventory",_veh];
            playSound3D ["ALF_Client2\sounds\unlock.ogg", _veh, false, getPosASL _veh, 3, 1, 20];
        } 
        else 
        {
            if (local _veh) then 
            {
                _veh lock 2;
            } 
            else 
            {
                [_veh,2] remoteExecCall ["ALF_fnc_lockVehicle",_veh];
            };

            [_veh,TRUE] remoteExec ["lockInventory",_veh];
            playSound3D ["ALF_Client2\sounds\car_lock.ogg", _veh, false, getPosASL _veh, 3, 1, 20];
        };
    };   
}, {}, [22, [false, false, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Activer_orateur_vehicule_ALF", ["Activer/Desactiver orateur sur le vehicule", "Touche pour activer/desativer l'orateur sur votre voiture."], 
{
    if (vehicle player != player AND {typeOf (vehicle player) in ["V_ALF_Stinger_GND",
        "V_ALF_EC135_Gendarmerie",
        "ALF_Stinger_GND",
        "V_ALF_Megane_G_Gendarmerie",
        "V_ALF_Berlingo_Gendarmerie",
        "V_ALF_Subaru_Gendarmerie",
        "V_ALF_GIGN",
        "V_ALF_Titan_Gendarmerie",
        "V_ALF_DV15_Gendarmerie",
        "V_ALF_Vito_Gendarmerie",
        "V_ALF_Berlingo2019G",
        "ALF_Peugeot_3008_2021_GN",
        "ALF_Peugeot_308_2022_GN",
        "V_ALF_SVR_G",
        "ALF_Peugeot_5008_2021_GN"]}) then 
    {
        [] call ALF_fnc_setVehSpeaker;
    };
}, {}, [21, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Activer_radio_aerienne_ALF", ["Activer/Desactiver la radio aerienne", "Touche pour activer/desativer la radio aerienne."], 
{
    if ((vehicle player) isKindOf "Air") then {[] call ALF_fnc_setAirRadio;};
}, {}, [33, [true, false, false]]] call CBA_fnc_addKeybind;

// ———————————— Portail service ————————————
["Martinique RP", "Open_Portail_MRP", ["Ouvrir/Fermer les portails", "Touche pour ouvrir/fermer les portails."],
{
    if (!isNil {soundportail}) exitWith {};
    soundportail = true;
    [] spawn {sleep 2; soundportail = nil;};

    // Chercher les bâtiments proches (entreprises, palais de justice, et concessionnaires)
    private _bats_Proches = nearestObjects [player, ["Land_ALF_Entreprise", "Land_MRP_Palais_Justice", "Land_MRP_Concessionnaire", "Land_MRP_Prefecture2"], 400];
    
    // Filtrer les concessionnaires pour ne garder que celui à la position spécifique (6798.42,7333.26,0)
    _bats_Proches = _bats_Proches select {
        !(typeOf _x == "Land_MRP_Concessionnaire") OR 
        {((getPosATL _x) distance [6798.42,7333.26,0]) < 1}
    };
    
    private _bat_Proche = _bats_Proches # 0;

    // Bloque si pas de batiment ET aucun service (police/medic/pénit) ET pas b_18 en service
    if (isNil {_bat_Proche} AND {life_coplevel isEqualTo 0 AND {life_medicLevel isEqualTo 0} AND {!life_penit_service} AND {!b_18} AND {!b_6}}) exitWith {};  // AJOUT pénit et b_18 b_6 service

    private _joueur_Proche_Son_Ent = getPlayerUID player in str (_bat_Proche getVariable ["business",[]]) AND {getPosATL player distance _bat_Proche < 400};

    // Autorise si police, medic, pénit, proprio d'entreprise, ou b_18 en service
    if ((life_coplevel > 0) OR (life_medicLevel > 0) OR (life_penit > 0) OR ((b_18 OR b_6) AND b_enService) OR {_joueur_Proche_Son_Ent}) exitWith   // AJOUT pénit et b_18 b_6 service
    {
        private _portail_Proche = (nearestObjects [player, [], 20] select {("mrp_portail" in str _x) OR (typeof _x == "land_MRP_Portail_3_PUBLIC")}) # 0;

        if !(isNil {_portail_Proche}) then
        {
            private _etat = _portail_Proche animationSourcePhase "Portail_source";
            private _texte = "";
            private _soundToPlay = "";

            [] call
            {
                if (_etat > 0.3 AND {_etat <= 1}) exitWith
                {
                    _etat = 0;
                    _texte = "Le portail de service se ferme.";
                    _soundToPlay = "\ALF_Client2\sounds\bip_portail.ogg";
                };

                if (_etat < 0.6 AND {_etat >= 0}) then
                {
                    _etat = 1;
                    _texte = "Le portail de service s'ouvre.";
                    _soundToPlay = "\ALF_Client2\sounds\bip_portail.ogg";
                };
            };

            _portail_Proche animateSource ["Portail_source", _etat];
            playSound3D [_soundToPlay, _portail_Proche, false, getPosASL _portail_Proche, 1, 1, 50];

            ["INFO", _texte, "success"] spawn ALF_fnc_doMsg;
        };
    };
}, {}, [22, [true, false, false]]] call CBA_fnc_addKeybind;

// ———————————— Sirène vehicule Tony ————————————

["Martinique RP", "Sirenne_vehicule_Tony", ["Sirène vehicule Tony", "Touche pour activer/desactiver les sirènes de votre vehicule."], 
{   
    if (vehicle player != player AND {life_gendarme_service} AND {(driver vehicle player) isEqualTo player}) then     
    {   
        if (!isNil {soundtony}) exitWith {};
        private _veh = vehicle player;
        soundtony = true;
        [] spawn {
            sleep 2;
            soundtony = nil;
        };
        if (({typeOf _x isEqualTo "#dynamicsound"} count (attachedObjects _veh)) > 0) then 
        {
            {
                if ((typeOf _x) isEqualTo "#dynamicsound") exitWith 
                {
                    detach _x;
                    deleteVehicle _x;
                };
            } forEach (attachedObjects _veh);
        }        
        else 
        {
            if (life_copLevel > 0) then 
            {                
                private _sirens = [
                    "\ALF_Client2\sounds\tony1.ogg", 
                    "\ALF_Client2\sounds\tony2.ogg"
                ];
                private _selectedSiren = selectRandom _sirens;

                playSound3D [_selectedSiren, _veh, false, getPosASL _veh, 7, 1, 200];
            };
        };        
    };
}, {}, [33, [true, false, false]]] call CBA_fnc_addKeybind;
//};