/*
    MRP – ANTI-CHEAT ULTRA LOGGER (RPT ONLY)
*/

[] spawn {
    waitUntil { !isNull player };

    private _name = name player;
    private _uid  = getPlayerUID player;

    AC_Log = {
        params ["_msg", "_name", "_uid"];
        [_name, _uid, _msg] remoteExecCall ["ALF_Server_fnc_ACDiag", 2];
    };

    ["Client Anti-Cheat démarré", _name, _uid] call AC_Log;


    // ---------------------------------------
    // 1. KEYLOGGER
    // ---------------------------------------
    // Définition des touches suspectes
    private _susKeys = [
        210,211,199,207,201,209,    // Insert, Delete, Home, End, PgUp, PgDown
     55,59,60,61,62,63,64,65,66,67,68,87,88   // F1 à F12 *
    ];

    // Stockage global accessible au EH
    uiNamespace setVariable ["AC_susKeys", _susKeys];

    // === KEY LOGGER ===
    (findDisplay 46) displayAddEventHandler ["KeyDown", {
        params ["_d","_dik","_shift","_ctrlKey","_alt"];

        private _sus = uiNamespace getVariable ["AC_susKeys", []];

        if (_dik in _sus) then {
            [
                format["TOUCHE SUSPECTE : KEY=%1 SHIFT=%2 CTRL=%3 ALT=%4",
                _dik, _shift, _ctrlKey, _alt],
                name player,
                getPlayerUID player
            ] call AC_Log;
        };
    }];



    // ---------------------------------------
    // 2. DISPLAY LOGGER
    // ---------------------------------------
    private _displayWhitelist = [
        46,     // main
        12,     // map
        49,     // inventory
        602,603,
        632,
        0,
        8,
        18,
        70,
        39400,39401
    ];

    private _lastDisplayLog = 0;

    addMissionEventHandler ["Draw3D", {
        private _now = time;

        if (_now - _lastDisplayLog < 0.5) exitWith {};
        _lastDisplayLog = _now;

        {
            private _idd = ctrlIDD _x;

            if !(_idd in _displayWhitelist) then {
                private _lastIDD = missionNamespace getVariable ["AC_lastIDD", -1];

                if (_idd != _lastIDD) then {
                    missionNamespace setVariable ["AC_lastIDD", _idd];

                    [
                        format["DISPLAY SUSPECT OUVERT : IDD=%1", _idd],
                        name player,
                        getPlayerUID player
                    ] call AC_Log;
                };
            };
        } forEach allDisplays;
    }];


    // ---------------------------------------
    // 3. SCRIPT EXEC
    // ---------------------------------------
    missionNamespace setVariable ["AC_execCheck", time];

    addMissionEventHandler ["EachFrame", {
        private _now = time;

        if ((_now - (missionNamespace getVariable ["AC_execCheck",0])) < 0.001) then {
            ["EXECUTION SCRIPT SUSPECTE", name player, getPlayerUID player] call AC_Log;
        };

        missionNamespace setVariable ["AC_execCheck", time];
    }];


    // ---------------------------------------
    // 4. ESP HOOK
    // ---------------------------------------
    [] spawn {
        sleep 5;

        private _orig = missionNamespace getVariable "drawIcon3D";

        if (!isNil "_orig") then {
            missionNamespace setVariable ["drawIcon3D",
            {
                params ["_texture","_color","_pos","_size","_angle","_text"];

                [
                    format["ESP détecté : TEX=%1 TXT=%2", _texture,_text],
                    name player,
                    getPlayerUID player
                ] call AC_Log;

                _this call (missionNamespace getVariable "drawIcon3D_orig");
            }];

            missionNamespace setVariable ["drawIcon3D_orig", _orig];
        };
    };


    // ---------------------------------------
    // 5. SPEEDHACK / TP
    // ---------------------------------------
    [] spawn {
        private _last = getPosATL player;

        while {true} do {
            private _p = getPosATL player;
            private _dist = _last distance _p;

            if (_dist > 40 && vehicle player == player) then {
                [
                    format["TP/SPEEDHACK : %1 mètres en 1 seconde", _dist],
                    name player,
                    getPlayerUID player
                ] call AC_Log;
            };

            _last = _p;
            sleep 1;
        };
    };


    // ---------------------------------------
    // 6. SPAWN OBJETS + WHITELIST
    // ---------------------------------------
    [] spawn {
        private _known = [];

        // WHITELIST OBJETS → IGNORÉS
        private _spawnWhitelist = [
            // --- ANIMAUX & OBJETS VANILLA ---
            "Turtle_F",
            "GroundWeaponHolder",
            "Land_File1_F",
            "Land_BuoyBig_F",
            "Land_HeatPump_F",
            "Land_Net_Fence_pole_F",
            "Land_Target_Oval_Wall_Bottom_F",
            "Land_Target_Line_01_F",
            "BloodSplatter_01_Medium_Old_F",
            "BloodSplatter_01_Large_New_F",
            "BloodTrail_01_Old_F",
            "Land_BagFence_Long_F",
            "Land_Hedge_01_s_4m_F",
            "Land_Loudspeakers_F",
            "Land_MapBoard_01_Wall_F",
            "Land_MapBoard_01_Wall_Enoch_F",
            "Land_Sunshade_01_F",
            "Land_BackAlley_02_l_1m_F",
            "Land_Plank_01_4m_F",
            "Land_Target_Oval_Wall_Bottom_F",
            "Land_WoodenTable_large_F",
            "Land_TouristShelter_01_F",
            "Land_Bench_01_F",
            "Land_Campfire_burning_F",

            // --- PERSONNAGES VANILLA ---
            "C_man_polo_1_F",
            "C_man_polo_2_F",
            "C_man_polo_3_F",
            "C_man_polo_4_F",
            "C_man_polo_5_F",
            "C_man_polo_6_F",
            "C_man_1",
            "C_Man_formal_1_F",
            "C_Man_formal_2_F_tanoan",
            "C_Man_formal_3_F_tanoan",
            "C_man_p_shorts_1_F",
            "C_Man_casual_5_F",
            "C_Man_Paramedic_01_F",

            // --- OBJETS ALF ---
            "ALF_Petrin",
            "ALF_Projecteur",
            "ALF_Projecteur2",
            "ALF_Projecteur_2",
            "ALF_Projecteur_2_2",
            "ALF_Table_1",
            "ALF_Table_B_2",
            "ALF_TV_1",
            "ALF_Katana_M",
            "ALF_Gros_Frigo",
            "ALF_Safe_2",
            "ALF_G_Chaise_Bois",
            "ALF_G_Chaise",
            "ALF_Borne_22",
            "ALF_Coco",
            "ALF_Pierre_fer",
            "ALF_Pierre_saphir",
            "ALF_Pierre_cui",
            "ALF_Plante_W_2",

            // --- MOBILIERS ALF ---
            "Land_ALF_Security",
            "Land_ALF_Pompe",
            "Land_ALF_ATM",
            "Land_ALF_G_Chaise_Bois",
            "Land_ALF_G_Chaise",
            "Land_ALF_Pierre_fer",
            "Land_ALF_Pierre_saphir",
            "Land_ALF_Pierre_cui",
            "Land_ALF_Plante_W_2",
            "Land_ALF_Borne_22",
            "Land_ALF_H_bed",

            // --- OBJETS TRANSFO ---
            "TRANSFO_MRP_Milling",
            "TRANSFO_table_bois",
            "TRANSFO_workbench",
            "TRANSFO_furnace",
            "TRANSFO_Fedex",

            // --- OBJETS MRP ---
            "MRP_ligneparking",
            "MRP_ligneparking_reserve",
            "MRP_Grillage_A_2m",
            "MRP_Grillage_A_porte",
            "MRP_FlagFrance",

            // --- MEUBLES MRP ---
            "land_MRP_MEUBLE_armoire_1",
            "land_MRP_MEUBLE_armoire_1_1",
            "land_MRP_MEUBLE_armoire_1_2",
            "land_MRP_MEUBLE_COFFRE_casier",
            "land_MRP_Meuble_TableReunion",
            "land_MRP_meuble_bureau_9",
            "land_MRP_meuble_canape_6",

            // --- PROPS DIVERS (MODS MAP / PROPS) ---
            "plp_up_PropaneTankA",
            "plp_up_RattanTableVarGry",
            "GalleryFrame_01_large_portrait_F",
            "Weapon_R3F_JIM_LR",
            "R3F_SIT_COMDE",
            "R3F_WeaponBox",

            // --- VEHICULES (IGNORÉS POUR EVITER LE SPAM) ---
            "C_Boat_Civil_01_F",
            "V_ALF_EC145",
            "V_ALF_LaFerrari_MRPV2",
            "V_ALF_R8",
            "V_ALF_Actros_DEP_4000_MRPV2",
            "V_ALF_Ferrari_488_MRPV2",

            // --- BÂTIMENTS MRP ---
            "land_MRP_MEUBLE_armoire_1",
            "land_MRP_MEUBLE_armoire_1_1",
            "land_MRP_MEUBLE_armoire_1_2",
            "land_MRP_MEUBLE_COFFRE_casier",
            "land_MRP_meuble_bureau_9",
            "land_MRP_meuble_canape_6",
            "land_MRP_Meuble_TableReunion",

            // --- DIVERT ---
           "ALF_Cupidon_M",
           "ALF_LX_premium_dp_MRPV2",
           "ALF_Poster_pmo",
           "ALF_Safe_1",
           "ALF_Table_2",
           "ALF_Table_B_1",
           "ALF_chaise_1_Ble",
           "ALF_chaise_2_Bla",
           "ALF_chaise_2_Ble",
           "ALF_chaise_2_N",
           "Alf_stock_1",
           "Alf_stock_2",
           "BloodSplatter_01_Small_Old_F",
           "C_ALF_Polo_PM_1",
           "C_ALF_Tommy",
           "C_Man_casual_9_F",
           "C_Man_formal_1_F_tanoan",
           "C_Man_formal_3_F",
           "C_Man_formal_4_F_tanoan",
           "Campfire_burning_F",
           "GalleryFrame_02_large_rectangle_F",
           "HC_Logic",
           "LayFlatHose_01_Roll_F",
           "Land_ALF_Coco",
           "Land_ALF_IRM",
           "Land_ALF_Pierre_dia",
           "Land_ALF_Safe_2",
           "Land_ALF_bbq",
           "Land_Billboard_F",
           "Land_Laptop_Intel_01_F",
           "Land_PCSet_Intel_02_F",
           "Land_PaperBox_01_small_open_brown_F",
           "Land_Photoframe_02_F",
           "Land_PicnicTable_01_F",
           "Land_Pot_02_F",
           "Land_PortableSpeakers_01_F",
           "Land_RaiStone_01_F",
           "Land_Rug_01_F",
           "Land_Sack_F",
           "Land_i_Shed_Ind_F",
           "MRP_BigSign4",
           "MRP_Borne_recharge_oxygene",
           "MRP_Meuble_Banc_tribunal",
           "MRP_flag_France_small",
           "MRP_meuble_PetiteTable_1",
           "V_ALF_300SL_MRPV2",
           "V_ALF_MeganeRS",
           "V_ALF_Sprinter_22_Benne_MRPV2",
           "land_MRP_MEUBLE_COFFRE_casier_2",
           "land_MRP_MEUBLE_COFFRE_casier_3",
           "land_MRP_MEUBLE_bureau_equip_1",
           "land_MRP_MEUBLE_bureau_equip_2",
           "land_MRP_MEUBLE_frigo_smart",
           "land_MRP_meuble_CoffreFort",
           "land_MRP_meuble_Fauteuil_3",
           "land_MRP_meuble_bureau_1",
           "land_MRP_meuble_bureau_2",
           "land_MRP_meuble_canape_11",
           "land_MRP_meuble_canape_4",
           "land_MRP_meuble_table_2_1",
           "land_MRP_meuble_table_3_2",
           "land_MRP_meuble_table_3_3",
           "land_statue_justice",
           "plp_bo_Flatscreen_Stc",
           "plp_up_09_YlwSmall",
           "plp_up_10_CycasBig",
           "plp_up_11_PritchardiaSmll",
           "plp_up_TrellisFenceLightCrossModule",
           "plp_up_TrellisFenceLightArchHigh",
           "plp_upm_SimpleTableMedWht",
           "RuggedTerminal_01_communications_F",
           "Land_ALF_Concentrateur",
           "Land_plp_up_TrellisFenceLightArchHigh",
           "land_MRP_meuble_table_basse_3",
           "AL_dirtyblue_jacket_supregrey_jumper_grey_jeans_timbs_F",
           "land_MRP_meuble_Fauteuil_4",
           "Weapon_SMG_05_F",
           "Weapon_hgun_PDW2000_F",
           "Item_SecretDocuments",
           "land_MRP_meuble_bureau_3",
           "Weapon_hgun_Pistol_heavy_02_F",
           "ALF_3310_Object",
           "Land_PCSet_01_screen_F",
           "Land_GymRack_03_F",
           "Land_GymRack_02_F",
           "Land_GymRack_01_F",
           "Land_GymBench_01_F",
           "land_MRP_meuble_Fauteuil_2",
           "land_MRP_meuble_canape_12",
           "land_MRP_meuble_canape_10",
           "land_MRP_meuble_Chaise_5",
           "ShootingMat_01_Olive_F",
           "land_MRP_meuble_table_3",
           "MRP_Sign_01",
           "Weapon_R3F_Famas_F1",
           "Weapon_R3F_MP5A5",
           "Item_optic_Arco_blk_F",
           "Land_ALF_Gend",
           "Item_acc_flashlight_pistol",
           "Weapon_hgun_P07_blk_F",
           "ALF_chaise_1_Bla",
           "c_volcano_stones",
           "land_MRP_meuble_table_basse_3",
           "GroundWeaponHolder_Scripted",
           "Land_ALF_Pierre_or",
           "Land_SatelliteAntenna_01_F",
           "Land_HelipadCivil_F",
           "babe_helper",
           "land_MRP_meuble_bureau_4",
           "Land_ALF_Poste",
           "Land_mrp_porte_dep",
           "VEH_MRP_Audi_RS3_2022",
           "VEH_MRP_BMW_750_Li_2020",
           "Item_SecretFiles",
           "MRP_Pompier_03_F",
           "Land_Bench_02_F",
           "plp_bo_WoodenTrashcan_Mvl",
           "Land_tailleuse_2",
           "Land_fonte_2",
           "TRANSFO_workbench_cuivre",
           "Land_fonte_3",
           "plp_up_Pickaxe",
           "plp_up_Pickaxe_L",
           "plp_bo_BeachBagFlatRed_Use",
           "plp_up_WoodBucketLgt",
           "plp_up_WoodBucketDrk",
           "plp_up_WateringCanMetal",
           "plp_up_WateringCanEnamel",
           "plp_up_WashPanPlasticGreenSmall",
           "plp_up_GardenArmchairDrk",
           "Land_tailleuse",
           "land_MRP_meuble_Chaise_11",
           "land_MRP_meuble_canape_1",
           "Intel_File2_F",
           "c_spong_tube_yellow3",
           "GalleryFrame_01_large_v2_F",
           "GalleryFrame_02_F",
           "V_ALF_208T16_White",
           "Sechoir",
           "V_ALF_X5_MRPV2",
           "ALF_Jetski_MRPV2",
           "V_ALF_Speeder_MRPV2",
           "ALF_Wedding_Table",
           "Land_Icebox_F",
           "Land_CashDesk_F",
           "Land_ShelvesWooden_F",
           "Land_BottlePlastic_V2_F",
           "Land_PowderedMilk_F",
           "Land_Pumpkin_01_F",
           "Land_Can_V1_F",
           "Land_CerealsBox_F",
           "Land_FoodContainer_01_White_F",
           "ALF_Poulet_Crue",
           "ALF_CotePorc_Crue",
           "ALF_Bacon_Crue",
           "Pressoir",
           "TRANSFO_MRP_Embouteillage",
           "MRP_Conditionnement",
           "AL_dark_jacket_supreblack_jumper_grey_jeans_timbs_F",
           "Big_barrel",
           "MRPV2_Machine_Sous",
           "ALF_Projecteur_2_court",
           "ALF_Projecteur5",
           "Land_AncientStatue_01_F",
           "land_MRP_meuble_table_2",
           "land_MRP_meuble_canape_8",
           "Item_ItemWatch",
           "Xnooz_AppareilPhoto_zeus",
           "Item_Keys",
           "Item_FileTopSecret",
           "Item_Files",
           "Item_Laptop_Unfolded",
           "Item_Money_stack",
           "GalleryFrame_02_square_F",
           "Land_PaperBox_open_full_F",
           "ALF_Frigo_Basique",
           "ALF_Projecteur4",
           "ALF_Projecteur3",
           "ALF_CaveVin",
           "plp_up_GunViseMtlPistol",
           "C_Man_Fisherman_01_F",
           "C_Scooter_Transport_01_F",
           "Land_Shoot_House_Panels_Windows_F",
           "V_ALF_Chiron",
           "Land_Laptop_Intel_Oldman_F",
           "plp_up_BeerTableSnd",
           "plp_up_BeerBenchSnd",
           "Land_GarbageBin_02_F",
           "Land_model_1",
           "Land_ALF_Plante_W",
           "plp_up_BeerBenchSnd_B",
           "ALF_TableMeth",
           "Land_ALF_Pierre",
           "ALF_LaboMeth",
           "plp_up_AirCompressorZRed",
           "plp_up_AirCompressorBlue",
           "Land_Shed_13_F",
           "LayFlatHose_01_SBend_F",
           "LayFlatHose_01_StraightShort_F",
           "LayFlatHose_01_CurveShort_F",
           "LayFlatHose_01_Corner_F",
           "ALF_SlotMachine",
           "ALF_TableBlackJack",
           "Land_dp_smallFactory_F",
           "V_ALF_Kx_MRPV2",
           "HeadlessClient_F",
           "Sign_Sphere10cm_F",
           "Land_FlowerPot_01_Flower_F",
           "Land_PCSet_01_case_F",
           "Land_PCSet_01_mouse_F",
           "Land_PCSet_01_keyboard_F",
           "land_MRP_MEUBLE_MeubleBureau",
           "Land_PCSet_01_mousepad_F",
           "Land_WaterBottle_01_full_F",
           "MRP_Sign_03",
           "Land_TacticalBacon_F",
           "WaterSpill_01_Small_New_F",
           "ContainmentArea_03_black_F",
           "plp_up_WashPanPlasticWhiteSmall",
           "plp_up_WashPanPlasticBlueBig",
           "land_MRP_meuble_bureau_6",
           "Logic"

        ];

        while {true} do {

            {
                private _t = typeOf _x;

                if !(_x in _known) then {
                    _known pushBack _x;

                    // IGNORE LES OBJETS WHITELISTÉS
                    if !(_t in _spawnWhitelist) then {
                        [
                            format["OBJET SPAWN : %1", _t],
                            name player,
                            getPlayerUID player
                        ] call AC_Log;
                    };
                };

            } forEach (allMissionObjects "All");

            // OPTIMISE: 30s au lieu de 3s - allMissionObjects sur 5000-20000 objets est tres couteux
            // Un scan toutes les 30s est suffisant pour detecter les cheats
            sleep 30;
        };
    };


    // ---------------------------------------
    // 7. GODMODE
    // ---------------------------------------
    player addEventHandler ["HandleDamage", {
        params ["_unit","_sel","_dmg","_src"];

        if (_dmg < 0) then {
            [
                format["GODMODE détecté : DMG=%1", _dmg],
                name player,
                getPlayerUID player
            ] call AC_Log;
        };

        false
    }];

    ["AntiCheat client actif", _name, _uid] call AC_Log;
};
