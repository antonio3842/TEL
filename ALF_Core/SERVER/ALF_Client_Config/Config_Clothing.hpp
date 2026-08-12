/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.




*    ARRAY FORMAT:
*        0: STRING (Classname)
*        1: STRING (Display Name, leave as "" for default)
*        2: SCALAR (Price)
*        4: ARRAY (This is for limiting items to certain things)
*            0: Variable to read from
*            1: Variable Value Type (SCALAR / BOOL / EQUAL)
*            2: What to compare to (-1 = Check Disabled)
*/

class Clothing {

    ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"title", "STRING"},
            {"license", "STRING"},
            {"uniforms", "ARRAY"},
            {"headgear", "ARRAY"},
            {"hmd", "ARRAY"},
            {"goggles", "ARRAY"},
            {"vests", "ARRAY"},
            {"backpacks", "ARRAY"}
        }}
    };

    //////////////////////////////// ENTREPRISES //////////////////////////////////
    class b_0 {
        title = "Magasin 0";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    class b_1 {
        title = "Magasin 1";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_2 {
        title = "Magasin 2";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },            
            { "TRYK_U_B_BLK_Tshirt", "Costume", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },            
            { "ALF_Angel_Casque", "Casque", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },            
            { "ALF_Angel_Vest2", "Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },            
            { "ALF_Bag_s", "Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_3 {
        title = "Magasin 3";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_HunterBody_grn", "", 70, { "", "", -1 }, "" },
            { "ALF_WorkerCoveralls", "", 50, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 25, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_eyeProtectors_F", "", 10, { "", "", -1 }, "" },
            { "TRYK_US_ESS_Glasses", "", 10, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "ALF_Carryall_cbr", "", 70, { "", "", -1 }, "" }
        };
    };
   class b_4 {
        title = "Magasin Dépanneur";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_DEP_1", "", 149, { "", "", -1 }, "" },
            { "ALF_DEP_1", "", 149, { "", "", -1 }, "" },
            { "ALF_DEP_2", "", 149, { "", "", -1 }, "" },
            { "ALF_T_DEP_1", "", 149, { "", "", -1 }, "" },
            { "ALF_T_DEP_2", "", 149, { "", "", -1 }, "" },
            { "ALF_Polo_DEP_1", "", 149, { "", "", -1 }, "" },
            { "U_MRPV2_DP_Polo_HDM", "", 149, { "", "", -1 }, "" },
            { "U_MRPV2_DP_Horizon_depannage", "", 149, { "", "", -1 }, "" },
            { "ALF_Polo_DEP_2", "", 149, { "", "", -1 }, "" },
            // GRG
            { "U_MRPV2_DP_polo_GRG", "", 149, { "", "", -1 }, "" },
            { "U_MRPV2_DP_GRG", "", 149, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 0, { "", "", -1 }, "" },
            // GRG
            { "H_MRPV2_Cap_GRG", "", 0, { "", "", -1 }, "" },
            // HDM
            { "H_MRPV2_Cap_HDM", "", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_Safety_yellow_F", "", 50, { "", "", -1 }, "" },
            { "V_LegStrapBag_black_F", "", 50, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "B_Messenger_Gray_F", "", 0, { "", "", -1 }, "" }
        };
    };
    class b_5 {
        title = "Magasin 5";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_Safety_yellow_F", "", 50, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_6 {
        title = "Magasin 6";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "U_ALF_BIEM", "", 79, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "capb_secu", "", 29, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            //{ "ALF_Brassard_Secu", "", 29, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "ALF_Holster_AP2", "", 50, { "", "", -1 }, "" },
            { "ALF_Holster_Noir", "", 50, { "", "", -1 }, "" },
            { "ALF_Holster", "", 50, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_7 {
        title = "Magasin 7";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "TRYK_NOMIC_TAC_EARMUFF_Gs", "Casque Anti-bruit", 50, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_8 {
        title = "Magasin 8";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "U_C_Journalist", "", 52, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "H_Cap_press", "", 20, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_9 {
        title = "Magasin 9";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" }
            //{ "HITMAN_47_KS_1", "", 26000, { "", "", -1 }, "" },
            //{ "HITMAN_47_KS_2", "", 25000, { "", "", -1 }, "" },
            //{ "HITMAN_47_KS_3", "", 22000, { "", "", -1 }, "" },
            //{ "HITMAN_47_KS_4", "", 8000, { "", "", -1 }, "" },
            //{ "HITMAN_47_KS_5", "", 30000, { "", "", -1 }, "" },
            //{ "HITMAN_47_KS_6", "", 28400, { "", "", -1 }, "" },
            //{ "HITMAN_47_KS_7", "", 20000, { "", "", -1 }, "" },
            //{ "HITMAN_47_KS_8", "", 30000, { "", "", -1 }, "" },
            //{ "HITMAN_47_KS_9", "", 30000, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_10 {
        title = "Magasin 10";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_WorkerCoveralls", "", 50, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 25, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_eyeProtectors_F", "", 10, { "", "", -1 }, "" },
            { "TRYK_US_ESS_Glasses", "", 10, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_11 {
        title = "Magasin 11";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Taxi", "", 500, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_12 {
        title = "Magasin 12";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_WorkerCoveralls", "", 50, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 25, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_eyeProtectors_F", "", 10, { "", "", -1 }, "" },
            { "TRYK_US_ESS_Glasses", "", 10, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    // Prefecture
    class b_13 {
        title = "Vetements Prefecture";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "MRP_FormalChemise_4_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalChemise_9_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_13A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_12A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_11A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_10A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_9A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_8A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_7A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_6A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_5A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_4A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_3A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_2A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_1A_camo", "", 50, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_blue_F", "", 50, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_gray_F", "", 50, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_khaki_F", "", 50, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_black_F", "", 50, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_white_F", "", 50, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_violet_F", "", 50, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_green_F", "", 50, { "", "", -1 }, "" },
            { "SPrefet_Parade", "", 50, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 50, { "", "", -1 }, "" },
            { "Casquette_Prefet", "", 50, { "", "", -1 }, "" }            
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "MRP_Carte_Pref", "", 5, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    class b_14 {
        title = "Magasin 14";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "U_MRPV2_Polo_D_Diamond", "", 50, { "", "", -1 }, "" },
            { "U_MRPV2_Uniform_D_Diamond", "", 50, { "", "", -1 }, "" },
            { "ALF_WorkerCoveralls", "", 50, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 25, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_eyeProtectors_F", "", 10, { "", "", -1 }, "" },
            { "TRYK_US_ESS_Glasses", "", 10, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_15 {
        title = "Magasin 15";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "U_B_PilotCoveralls", "Tenue de pilote", 195, { "", "", -1 }, "" },
            { "U_MRPV2_Polo_CMFA", "", 195, { "", "", -1 }, "" },
            { "U_MRPV2_Pilote_CMFA", "", 195, { "", "", -1 }, "" },
            { "ALF_Taxi", "", 500, { "", "", -1 }, "" },
            { "TRYK_U_B_PCUHsW9", "", 0, { "", "", -1 }, "" }

        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_H_Helmet_Skate", "", 0, { "", "", -1 }, "" },
            { "ALF_H_PilotHelmetHeli_B", "", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "TRYK_US_ESS_Glasses_NV", "", 0, { "", "", -1 }, "" },
            { "TRYK_TAC_EARMUFF", "", 0, { "", "", -1 }, "" },
            { "NVGoggles_OPFOR ", "", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_Safety_blue_F", "", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "MRP_B_Parachute", "Parachute", 120, { "", "", -1 }, "" },
            { "ALF_AssaultPack_khk", "", 0, { "", "", -1 }, "" },
            { "ALF_AssaultPack_rgr", "", 0, { "", "", -1 }, "" },
            { "ALF_AssaultPack_sgg", "", 0, { "", "", -1 }, "" },
            { "ALF_AssaultPack_blk", "", 0, { "", "", -1 }, "" },
            { "ALF_AssaultPack_cbr", "", 0, { "", "", -1 }, "" },
            { "B_LegStrapBag_black_F", "", 0, { "", "", -1 }, "" },
            { "MRP_B_Parachute", "", 0, { "", "", -1 }, "" }
            // { "ALF_FieldPack_blk", "", 0, { "", "", -1 }, "" },
            // { "ALF_FieldPack_ocamo", "", 0, { "", "", -1 }, "" },
            // { "ALF_FieldPack_oucamo", "", 0, { "", "", -1 }, "" },
            // { "ALF_TacticalPack_oli", "", 0, { "", "", -1 }, "" },
            // { "ALF_OutdoorPack_blk", "", 0, { "", "", -1 }, "" },
            // { "ALF_Kitbag_sgg", "", 0, { "", "", -1 }, "" },
            // { "ALF_Kitbag_cbr", "", 0, { "", "", -1 }, "" },
            // { "ALF_Bergen_sgg", "", 0, { "", "", -1 }, "" },
            // { "ALF_Bergen_rgr", "", 0, { "", "", -1 }, "" },
            // { "ALF_Bergen_blk", "", 0, { "", "", -1 }, "" }
            //{ "ALF_Carryall_ocamo", "", 0, { "", "", -1 }, "" },
            //{ "ALF_Carryall_oli", "", 0, { "", "", -1 }, "" },
            //{ "ALF_Carryall_khk", "", 0, { "", "", -1 }, "" },
            //{ "ALF_Carryall_cbr", "", 0, { "", "", -1 }, "" }
        };
    };
    class b_16 {
        title = "Magasin 16";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "U_C_Driver_1", "", 149, { "", "", -1 }, "" },
            { "U_C_Driver_2", "", 149, { "", "", -1 }, "" },
            { "U_C_Driver_3", "", 149, { "", "", -1 }, "" },
            { "U_C_Driver_4", "", 149, { "", "", -1 }, "" },
            { "U_C_Driver_1_black", "", 149, { "", "", -1 }, "" },
            { "U_C_Driver_1_blue", "", 149, { "", "", -1 }, "" },
            { "U_C_Driver_1_green", "", 149, { "", "", -1 }, "" },
            { "U_C_Driver_1_red", "", 149, { "", "", -1 }, "" },
            { "U_C_Driver_1_white", "", 149, { "", "", -1 }, "" },
            { "U_C_Driver_1_yellow", "", 149, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_1", "", 70, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_2", "", 70, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_3", "", 70, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_4", "", 70, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_1_black", "", 70, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_2_blue", "", 70, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_3_green", "", 70, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_4_red", "", 70, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_4_white", "", 70, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_4_yellow", "", 70, { "", "", -1 }, "" },
            { "V_ALF_CasqueCourse_4_orange", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_Noir", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_Blanc", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_Bleu", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_Jaune", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_Orange", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_RougeFonce", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_Vert", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_Violet", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Noir", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Blanc", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Bleu", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Jaune", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Orange", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_RougeFonce", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Vert", "", 70, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Violet", "", 70, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_17 {
        title = "Magasin 17";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_WorkerCoveralls", "", 50, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 25, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_eyeProtectors_F", "", 10, { "", "", -1 }, "" },
            { "TRYK_US_ESS_Glasses", "", 10, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    // DIR
    class b_18 {
        title = "Magasin DIR";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
			{ "DIR_Polo", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_DIR", "", 0, { "", "", -1 }, "" },
            { "Vallies_Tenue_DIR_1", "", 0, { "", "", -1 }, "" },
            { "Vallies_Tenue_DIR_2", "", 0, { "", "", -1 }, "" },
            { "ALF_Lacoste2020", "", 570, { "", "", -1 }, "" },
            { "ALF_Tshirt_QLF", "", 65, { "", "", -1 }, "" },
            { "ALF_CHAW3_D6", "", 50, { "", "", -1 }, "meuf" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
			{ "casquette_dir", "", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 0, { "", "", -1 }, "" },
            { "ALF_H_Moto_Orange", "", 80, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_eyeProtectors_F", "", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
			{ "V_safety_DIRo_F", "", 0, { "", "", -1 }, "" },
            { "V_Safety_yellow_F", "", 0, { "", "", -1 }, "" },
            { "V_Safety_orange_F", "", 0, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Black", "", 360, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
			{ "sac_dir", "", 0, { "", "", -1 }, "" },
            { "ALF_Bergen_rgr", "", 0, { "", "", -1 }, "" },
            { "ALF_Bergen_blk", "", 0, { "", "", -1 }, "" },
            { "TRYK_B_Carryall_blk", "", 0, { "", "", -1 }, "" }
        };
    };
    class b_19 {
        title = "Magasin BIE";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "U_ALF_BIE", "", 149, { "", "", -1 }, "" }
        };
        headgear[] = {
			{ "ALF_Chantier", "", 0, { "", "", -1 }, "" },
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
			{ "V_Safety_yellow_F", "", 0, { "", "", -1 }, "" },
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_20 {
        title = "Magasin 20";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_21 {
        title = "Magasin 21";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_WorkerCoveralls", "", 50, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 25, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_eyeProtectors_F", "", 10, { "", "", -1 }, "" },
            { "TRYK_US_ESS_Glasses", "", 10, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_22 {
        title = "Magasin 22";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "TRYK_U_B_PCUHsW9", "", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Style2", "", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "TRYK_Shemagh_G", "", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_Safety_blue_F", "", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "ALF_AssaultPack_khk", "", 0, { "", "", -1 }, "" },
            { "ALF_AssaultPack_rgr", "", 0, { "", "", -1 }, "" },
            { "ALF_AssaultPack_sgg", "", 0, { "", "", -1 }, "" },
            { "ALF_AssaultPack_blk", "", 0, { "", "", -1 }, "" },
            { "ALF_AssaultPack_cbr", "", 0, { "", "", -1 }, "" },
            { "ALF_FieldPack_blk", "", 0, { "", "", -1 }, "" },
            { "ALF_FieldPack_ocamo", "", 0, { "", "", -1 }, "" },
            { "ALF_FieldPack_oucamo", "", 0, { "", "", -1 }, "" },
            { "ALF_TacticalPack_oli", "", 0, { "", "", -1 }, "" },
            { "ALF_OutdoorPack_blk", "", 0, { "", "", -1 }, "" },
            { "ALF_Kitbag_sgg", "", 0, { "", "", -1 }, "" },
            { "ALF_Kitbag_cbr", "", 0, { "", "", -1 }, "" },
            { "ALF_Bergen_sgg", "", 0, { "", "", -1 }, "" },
            { "ALF_Bergen_rgr", "", 0, { "", "", -1 }, "" },
            { "ALF_Bergen_blk", "", 0, { "", "", -1 }, "" }
            //{ "ALF_Carryall_ocamo", "", 0, { "", "", -1 }, "" },
            //{ "ALF_Carryall_oli", "", 0, { "", "", -1 }, "" },
            //{ "ALF_Carryall_khk", "", 0, { "", "", -1 }, "" },
            //{ "ALF_Carryall_cbr", "", 0, { "", "", -1 }, "" }
        };
    };

    // Tribunal
    class b_23 {
        title = "Vetements Tribunal";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            // Costume Tribunal
            { "Tribunal_Luxe_1", "", 50, { "", "", -1 }, "" },
            { "Tribunal_Luxe_2", "", 50, { "", "", -1 }, "" },
            // Chemise Tribunal
            { "MRP_FormalChemise_5_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalChemise_10_camo", "", 50, { "", "", -1 }, "" },
            // Costume
            { "MRP_FormalSuit_13A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_12A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_11A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_10A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_9A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_8A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_7A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_6A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_5A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_4A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_3A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_2A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_FormalSuit_1A_camo", "", 50, { "", "", -1 }, "" },
            { "MRP_Robe", "", 50, { "", "", -1 }, "" },
            { "MRP_Robe2", "", 50, { "", "", -1 }, "" },
            { "MRP_Robe3", "", 50, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
            
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "MRP_Carte_Trib", "", 5, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    class b_24 {
        title = "Magasin 24";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_WorkerCoveralls", "", 50, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 25, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_eyeProtectors_F", "", 10, { "", "", -1 }, "" },
            { "TRYK_US_ESS_Glasses", "", 10, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_25 {
        title = "Magasin 25";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_29 {
        title = "Magasin 29";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_WorkerCoveralls", "", 50, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Chantier", "", 25, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_eyeProtectors_F", "", 10, { "", "", -1 }, "" },
            { "TRYK_US_ESS_Glasses", "", 10, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class b_32 {
        title = "Magasin 32";
        license = "";
        uniforms[] = {            
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "EF_suit_8", "", 500, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    class b_33 {
        title = "Magasin 34";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "U_MRPV2_Polo_Tropic_Auto", "", 249, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_B_Diving", "", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_RebreatherB_mrp", "", 75, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    
    class b_34 {
        title = "Magasin 34";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Wetsuit", "", 249, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_B_Diving", "", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_RebreatherB_mrp", "", 75, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    class b_35 {
        title = "Magasin 35";
        license = "";
        uniforms[] = {            
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "EF_FEM_3_9_BK2", "", 500, { "", "", -1 }, "" },
            { "EF_suit_8", "", 500, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Noir", "", 20, { "", "", -1 }, "" }
        };
    };

    class metal {
        title = "Magasin Metal";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Angel_Casque", "", 69, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_Bandanna_aviator", "", 25, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "ALF_Angel_Vest", "", 110, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    class farce {
        title = "Farce et Attrape";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "UR_Pig", "Masque Cochon 1", 205, { "", "", -1 }, "" },
            { "UR_Pig_Bloody", "Masque Cochon 2", 205, { "", "", -1 }, "" },
            { "UR_Cat_Gray", "Masque Chat", 205, { "", "", -1 }, "" },
            { "UR_monkey", "Masque de singe", 205, { "", "", -1 }, "" },
            { "UR_monkey_grey", "Masque de singe 2", 205, { "", "", -1 }, "" },
            { "UR_monkey_darkbrown", "Masque de singe 3", 205, { "", "", -1 }, "" },
            { "UR_monkey_lightbrown", "Masque de singe 4", 205, { "", "", -1 }, "" },
            { "UR_Owl", "Masque de chouette", 205, { "", "", -1 }, "" },
            { "UR_Hawk_Brown", "Masque Oiseau 1", 205, { "", "", -1 }, "" },
            { "UR_Hawk_White", "Masque Oiseau 2", 205, { "", "", -1 }, "" },
            { "UR_Fox", "Masque Renard", 205, { "", "", -1 }, "" },
            { "UR_Skull_Bone", "Masque Squelette", 310, { "", "", -1 }, "" },
            { "UR_Dino_Brown", "Masque Dinosaure", 310, { "", "", -1 }, "" },
            { "UR_Hockey_Mask_4_CIRCUIT", "Masque de fête", 310, { "", "", -1 }, "" },
            { "ALF_Masque", "Masque de clown", 310, { "", "", -1 }, "" },
            { "TRYK_H_wig", "Perruque", 92, { "", "", -1 }, "" },
            { "UR_Bag1", "Sac en papier 1", 92, { "", "", -1 }, "" },
            { "UR_Bag2", "Sac en papier 2", 92, { "", "", -1 }, "" },
            { "UR_Bag3", "Sac en papier 3", 92, { "", "", -1 }, "" },
            { "UR_Bag4", "Sac en papier 4", 92, { "", "", -1 }, "" },
            { "UR_Bag5", "Sac en papier 5", 92, { "", "", -1 }, "" },
            { "UR_Bag6", "Sac en papier 6", 92, { "", "", -1 }, "" },
            { "UR_Bag7", "Sac en papier 7", 92, { "", "", -1 }, "" },
            { "UR_Bag8", "Sac en papier 8", 92, { "", "", -1 }, "" },
            { "UR_Bag10", "Sac en papier 10", 92, { "", "", -1 }, "" },
            { "UR_Bag11", "Sac en papier 11", 92, { "", "", -1 }, "" },
            { "UR_Bag12", "Sac en papier 12", 92, { "", "", -1 }, "" },
            { "UR_Bag13", "Sac en papier 13", 92, { "", "", -1 }, "" },
            { "UR_Bag14", "Sac en papier 14", 92, { "", "", -1 }, "" },
            { "UR_Bag16", "Sac en papier 16", 92, { "", "", -1 }, "" },
            { "UR_Bag17", "Sac en papier 17", 92, { "", "", -1 }, "" },
            { "ALF_M_Halloween", "Casque effet special", 25, { "", "", -1 }, "" },
            { "ALF_Bonnet_Noel", "Bonnet de Noel", 25, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    class Abelus {
        title = "Magasin Abelus";
        license = "Abelus";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "TRYK_U_taki_G_BLK", "", 500, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    class golden_corp {
        title = "Les mecs sans skill :=)";
        license = "gc";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "TRYK_U_B_OD_BLK_2", "", 500, { "", "", -1 }, "" },
            { "TRYK_U_B_OD_BLK", "", 500, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "TRYK_H_Booniehat_JSDF", "", 50, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "UR_G_Balaclava_CodGhosts_03_Lsh","", 50, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    class eboueur {
        title = "Magasin Eboueur";
        license = "eboueur";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "U_ALF_Eboueur", "", 10, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

     class taxi {
        title = "Magasin Taxi";
        license = "taxi";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Taxi", "", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "H_Hat_brown", "", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
     };
	
    class enedis {
        title = "Magasin Enedis";
        license = "enedis";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "U_ALF_BIE", "", 149, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "sac_enedis", "", 300, { "", "", -1 }, "" }            
        };
    };
    
            


    class laposte {
        title = "Vestiaire La Poste";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Laposte", "", 10, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "ALF_Gilet_LaPoste", "", 10, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    //////////////////////////////// CIV //////////////////////////////////
    class plonge {
        title = "Magasin de plongé";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Wetsuit", "", 350, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_Diving", "", 200, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_RebreatherB_mrp", "", 500, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "sac_plongeur", "", 200, { "", "", -1 }, "" }
        };
    };
    // class plongep {
    //     title = "Magasin de plongé";
    //     license = "";
    //     uniforms[] = {
    //         { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
    //         { "ALF_Wetsuit_P", "", 75, { "", "", -1 }, "" }
    //     };
    //     headgear[] = {
    //         { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
    //     };
    //     goggles[] = {
    //         { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
    //     };
    //     vests[] = {
    //         { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
    //         { "ALF_V_P_Rebreather", "", 75, { "", "", -1 }, "" }
    //     };
    //     backpacks[] = {
    //         { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
    //     };
    // };
    class plongeg {
        title = "Magasin de plongé";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Wetsuit_G", "", 75, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_B_Diving", "lunette ", 5, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_RebreatherB_mrp", "", 75, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };

    class Bruce {
        title = "STR_Shops_C_Bruce";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Poloshirt_stripped", "", 15, { "", "", -1 }, "" },
            { "ALF_Poloshirt_redwhite", "", 15, { "", "", -1 }, "" },
            { "ALF_Poloshirt_salmon", "", 15, { "", "", -1 }, "" },
            { "ALF_Poloshirt_blue", "", 15, { "", "", -1 }, "" },
            { "ALF_Poor_2", "", 15, { "", "", -1 }, "" },
            { "ALF_Poloshirt_burgundy", "", 15, { "", "", -1 }, "" },
            { "ALF_Poloshirt_tricolour", "", 15, { "", "", -1 }, "" },
            { "U_BG_Guerilla2_1", "", 60, { "", "", -1 }, "" },
            { "U_BG_Guerilla2_2", "", 60, { "", "", -1 }, "" },
            { "U_BG_Guerilla2_3", "", 60, { "", "", -1 }, "" },
            { "U_OrestesBody", "", 60, { "", "", -1 }, "" },
            { "U_Marshal", "", 60, { "", "", -1 }, "" },
            { "ALF_WorkerCoveralls", "", 40, { "", "", -1 }, "" },
            { "ALF_Maillot_FFF", "", 95, { "", "", -1 }, "" },
            { "ALF_Maillot_Psg", "", 135, { "", "", -1 }, "" },
            { "ALF_Maillot_OM", "", 135, { "", "", -1 }, "" },
            { "ALF_Maillot_OL", "", 135, { "", "", -1 }, "" },
            { "ALF_Maillot_Lakers", "", 95, { "", "", -1 }, "" },
            { "ALF_Nike1", "", 70, { "", "", -1 }, "" },
            { "ALF_Nike2", "", 70, { "", "", -1 }, "" },
            { "ALF_Nike3", "", 70, { "", "", -1 }, "" },
            { "ALF_Nike4", "", 70, { "", "", -1 }, "" },
            { "ALF_Nike5", "", 70, { "", "", -1 }, "" },
            { "ALF_Elvis", "", 70, { "", "", -1 }, "" },
            { "ALF_JEM", "", 50, { "", "", -1 }, "" },
            { "ALF_Obey", "", 50, { "", "", -1 }, "" },
            { "ALF_KFC", "", 60, { "", "", -1 }, "" },
            { "ALF_Checker", "", 50, { "", "", -1 }, "" },
            { "ALF_NikosAgedBody", "", 60, { "", "", -1 }, "" },            
            { "ALF_Ralph_VB", "", 70, { "", "", -1 }, "" },
            { "ALF_Ralph_BJ", "", 70, { "", "", -1 }, "" },
            { "ALF_Ralph_A", "", 70, { "", "", -1 }, "" },
            { "ALF_Ralph_R", "", 70, { "", "", -1 }, "" },
            { "ALF_Ralph_B", "", 70, { "", "", -1 }, "" },
            { "ALF_LV", "", 170, { "", "", -1 }, "" },
            { "ALF_Lacoste_B", "", 70, { "", "", -1 }, "" },
            { "ALF_Lacoste_BF", "", 70, { "", "", -1 }, "" },
            { "ALF_Lacoste_BC", "", 70, { "", "", -1 }, "" },
            { "ALF_Lacoste_BL", "", 70, { "", "", -1 }, "" },
            { "ALF_Lacoste_RS", "", 70, { "", "", -1 }, "" },
            { "ALF_Lacoste_R", "", 70, { "", "", -1 }, "" },
            { "ALF_Lacoste_S", "", 70, { "", "", -1 }, "" },
            { "ALF_Lacoste_VC", "", 70, { "", "", -1 }, "" },
            { "ALF_Lacoste_VF", "", 70, { "", "", -1 }, "" },
            { "ALF_Ralph_VB", "", 70, { "", "", -1 }, "" },
            { "ALF_Ralph_BJ", "", 70, { "", "", -1 }, "" },
            { "ALF_Ralph_A", "", 70, { "", "", -1 }, "" },
            { "ALF_Ralph_R", "", 70, { "", "", -1 }, "" },
            { "ALF_Ralph_B", "", 70, { "", "", -1 }, "" },
            { "EF_MX1", "Chemise fleur", 70, { "", "", -1 }, "" },  
            { "U_ALF_TenueTshirt_1", "", 60, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_2", "", 60, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_3", "", 60, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_4", "", 60, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_5", "", 60, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_6", "", 60, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_7", "", 60, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_8", "", 60, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_9", "", 60, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_10", "", 60, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_11", "", 60, { "", "", -1 }, "" },         
            { "ALF_Chicago_Bulls", "", 65, { "", "", -1 }, "" },
            { "ALF_Jack_C", "", 65, { "", "", -1 }, "" },
            { "ALF_Coq_S", "", 65, { "", "", -1 }, "" },
            { "ALF_Adidas_Charo", "", 65, { "", "", -1 }, "" },
            { "ALF_Nike_Outer_Space", "", 65, { "", "", -1 }, "" },
            { "ALF_Nike_Tokyo_Landry", "", 65, { "", "", -1 }, "" },
            { "ALF_Herbivore", "", 65, { "", "", -1 }, "" },
            { "ALF_Nike_Tricolore", "", 65, { "", "", -1 }, "" },
            { "ALF_Bullshit", "", 65, { "", "", -1 }, "" },
            { "ALF_Alcool", "", 65, { "", "", -1 }, "" },
            { "ALF_Reveil", "", 65, { "", "", -1 }, "" },
            { "ALF_Thug_Swag", "", 65, { "", "", -1 }, "" },
            { "ALF_Champion", "", 65, { "", "", -1 }, "" },
            { "ALF_Elesse_Blanc", "", 170, { "", "", -1 }, "" },
            { "ALF_Elesse_Bleu", "", 170, { "", "", -1 }, "" },
            { "ALF_Lacoste2020", "", 570, { "", "", -1 }, "" },
            { "ALF_Jogging_Gucci", "", 680, { "", "", -1 }, "" },
            { "ALF_Tommy", "", 65, { "", "", -1 }, "" },
            { "ALF_Fila", "", 65, { "", "", -1 }, "" },
            { "ALF_CHAW3_D", "", 65, { "", "", -1 }, "" },
            { "ALF_Tshirt_OrPlatine", "", 65, { "", "", -1 }, "" },
            { "ALF_Tshirt_QLF", "", 65, { "", "", -1 }, "" },
            { "ALF_Tshirt_Supreme", "", 65, { "", "", -1 }, "" },
            { "ALF_supreme_camo", "", 65, { "", "", -1 }, "" },         
            { "TRYK_U_denim_hood_blk", "Tenue homme 1", 60, { "", "", -1 }, "" },
            { "TRYK_U_denim_hood_nc", "Tenue homme 2", 60, { "", "", -1 }, "" },
            { "TRYK_U_denim_jersey_blk", "Tenue homme 3", 60, { "", "", -1 }, "" },
            { "TRYK_U_denim_jersey_blu", "Tenue homme 4", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_BK", "Tenue homme 5", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_BL", "Tenue homme 6", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_BWH", "Tenue homme 7", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_od", "Tenue homme 8", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_R", "Tenue homme 9", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_RED2", "Tenue homme 10", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_WH", "Tenue homme 11", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_WHB", "Tenue homme 12", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_ylb", "Tenue homme 13", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_od_Sleeve", "Tenue homme 14", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_ylb_Sleeve", "Tenue homme 15", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_BK_Sleeve", "Tenue homme 16", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_BL_Sleeve", "Tenue homme 17", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_BWH_Sleeve", "Tenue homme 18", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_R_Sleeve", "Tenue homme 19", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_RED2_Sleeve", "Tenue homme 20", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_WH_Sleeve", "Tenue homme 21", 60, { "", "", -1 }, "" },
            { "TRYK_shirts_DENIM_WHB_Sleeve", "Tenue homme 22", 60, { "", "", -1 }, "" },
            { "U_ALF_VestCostard_China", "", 500, { "", "", -1 }, "" },
            { "U_ALF_VestCostard_Brown", "", 500, { "", "", -1 }, "" },
            { "U_ALF_VestPull_Black", "", 350, { "", "", -1 }, "" },            
            { "U_ALF_TenueChemise_1", "", 300, { "", "", -1 }, "" },
            { "U_ALF_TenueChemise_2", "", 300, { "", "", -1 }, "" },
            { "U_ALF_TenueChemise_3", "", 300, { "", "", -1 }, "" },
            { "U_ALF_TenueChemise_4", "", 300, { "", "", -1 }, "" },
            { "U_ALF_TenueChemise_5", "", 300, { "", "", -1 }, "" },
            { "U_ALF_TenueMoto_1", "", 250, { "", "", -1 }, "" },
            { "U_ALF_TenueMoto_2", "", 250, { "", "", -1 }, "" },
            { "U_ALF_TenueMoto_3", "", 250, { "", "", -1 }, "" },
            { "U_ALF_TenueMoto_4", "", 250, { "", "", -1 }, "" },
            { "U_ALF_TenueMoto_5", "", 250, { "", "", -1 }, "" },
            { "U_ALF_TenueMoto_6", "", 250, { "", "", -1 }, "" },
            { "U_ALF_TenueMoto_7", "", 250, { "", "", -1 }, "" },
            { "U_ALF_TenueMoto_8", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_Adidas_blanc", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_Agent", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_blanc", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_CoeurMartinique_blanc", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_Levis", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_macron", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_nike", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_Adidas_bleu", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_chirac", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_bleu", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_tommy_bleu", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_UA", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_Batman", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_tommy_jaune", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_adidas_noir", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_brazzers", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_noir", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_defend", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_kaamelott", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_Lacoste", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_Martinique", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_Picole", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_rouge", "", 250, { "", "", -1 }, "" },
            { "MRP_Pants_lance", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_Adidas_blanc", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_Agent", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_blanc", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_Levis", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_macron", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_nike", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_Adidas_bleu", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_chirac", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_bleu", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_tommy_bleu", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_UA", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_Batman", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_tommy_jaune", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_adidas_noir", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_brazzers", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_noir", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_defend", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_kaamelott", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_Lacoste", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_Martinique", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_Picole", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_rouge", "", 250, { "", "", -1 }, "" },
            { "MRP_Short_lance", "", 250, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "V_ALF_Cap_QLF", "", 45, { "", "", -1 }, "" },
            { "ALF_Dreadlock", "", 85, { "", "", -1 }, "" },
            { "H_Cap_red", "", 10, { "", "", -1 }, "" },
            { "H_Cap_blu", "", 10, { "", "", -1 }, "" },
            { "H_Cap_oli", "", 10, { "", "", -1 }, "" },
            { "H_Cap_grn", "", 10, { "", "", -1 }, "" },
            { "H_Cap_tan", "", 10, { "", "", -1 }, "" },
            { "H_Cap_blk", "", 10, { "", "", -1 }, "" },
            { "capb_zeine_zoo", "", 10, { "", "", -1 }, "" },
            { "capb_zeine_zoo_w", "", 10, { "", "", -1 }, "" },
            { "capb_woodland", "", 10, { "", "", -1 }, "" },
            { "capb_yamaha", "", 10, { "", "", -1 }, "" },
            { "capb_nike_w", "", 10, { "", "", -1 }, "" },
            { "capb_rasta_adidas", "", 10, { "", "", -1 }, "" },
            { "capb_ralph", "", 100, { "", "", -1 }, "" },
            { "H_Cap_tan_specops_US", "", 10, { "", "", -1 }, "" },
            { "H_Cap_khaki_specops_UK", "", 10, { "", "", -1 }, "" },
            { "H_Cap_blk_ION", "", 10, { "", "", -1 }, "" },
            { "TRYK_R_CAP_BLK", "Casquette 1", 10, { "", "", -1 }, "" },
            { "TRYK_R_CAP_TAN", "Casquette 2", 10, { "", "", -1 }, "" },
            { "TRYK_R_CAP_OD_US", "Casquette 3", 10, { "", "", -1 }, "" },
            { "TRYK_H_headsetcap_Glasses", "Casquette 4", 20, { "", "", -1 }, "" },
            { "TRYK_H_headsetcap_blk_Glasses", "Casquette 5", 20, { "", "", -1 }, "" },
            { "TRYK_H_headsetcap_od_Glasses", "Casquette 6", 20, { "", "", -1 }, "" },
            { "ALF_style2", "", 45, { "", "", -1 }, "" },
            { "ALF_Bonnet", "", 20, { "", "", -1 }, "" },
            { "TRYK_H_woolhat", "Bonnet 1", 10, { "", "", -1 }, "" },
            { "TRYK_H_woolhat_br", "Bonnet 2", 10, { "", "", -1 }, "" },
            { "ALF_Chapeau_BF", "", 149, { "", "", -1 }, "" },
            { "H_StrawHat", "", 10, { "", "", -1 }, "" },
            { "H_StrawHat_dark", "", 10, { "", "", -1 }, "" },
            { "H_Hat_Safari_olive_F", "", 20, { "", "", -1 }, "" },
            { "H_Hat_Safari_sand_F", "", 20, { "", "", -1 }, "" },
            { "H_Hat_brown", "", 10, { "", "", -1 }, "" },
            { "H_Hat_grey", "", 10, { "", "", -1 }, "" },
            { "H_Hat_checker", "", 10, { "", "", -1 }, "" },
            { "H_Hat_tan", "", 10, { "", "", -1 }, "" },
            { "H_BandMask_blk", "", 10, { "", "", -1 }, "" },
            { "H_Bandanna_khk", "", 10, { "", "", -1 }, "" },
            { "H_Bandanna_cbr", "", 10, { "", "", -1 }, "" },
            { "H_Bandanna_sgg", "", 10, { "", "", -1 }, "" },
            { "H_Bandanna_surfer_grn", "", 10, { "", "", -1 }, "" },
            { "H_Bandanna_surfer_blk", "", 10, { "", "", -1 }, "" },
            { "H_Bandanna_sand", "", 10, { "", "", -1 }, "" },
            { "TRYK_H_Bandana_H", "Bandana", 10, { "", "", -1 }, "" },
            { "TRYK_H_pakol2", "Beret", 10, { "", "", -1 }, "" },           
            { "ALF_Chantier", "", 45, { "", "", -1 }, "" },
            { "ALF_Soudure", "", 45, { "", "", -1 }, "" },
            { "ALF_H_Helmet_Skate", "", 15, { "", "", -1 }, "" },
            { "ALF_Angel_Casque", "", 105, { "", "", -1 }, "" },
            { "ALF_Bike", "", 80, { "", "", -1 }, "" },
            { "ALF_H_Moto_Noir", "", 80, { "", "", -1 }, "" },
            { "ALF_H_Moto_Blanc", "", 80, { "", "", -1 }, "" },
            { "ALF_H_Moto_Bleu", "", 80, { "", "", -1 }, "" },
            { "ALF_H_Moto_Jaune", "", 80, { "", "", -1 }, "" },
            { "ALF_H_Moto_Orange", "", 80, { "", "", -1 }, "" },
            { "ALF_H_Moto_RougeFonce", "", 80, { "", "", -1 }, "" },
            { "ALF_H_Moto_Vert", "", 80, { "", "", -1 }, "" },
            { "ALF_H_Moto_Violet", "", 80, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Noir", "", 90, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Blanc", "", 90, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Bleu", "", 90, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Jaune", "", 90, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Orange", "", 90, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_RougeFonce", "", 90, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Vert", "", 90, { "", "", -1 }, "" },
            { "ALF_H_Moto_2_Violet", "", 90, { "", "", -1 }, "" },
            { "ALF_CasqueCross_Blanc", "", 85, { "", "", -1 }, "" },
            { "ALF_CasqueCross_222", "", 85, { "", "", -1 }, "" },
            { "ALF_CasqueCross_Black", "", 85, { "", "", -1 }, "" },
            { "ALF_CasqueCross_Blanc_Uni", "", 85, { "", "", -1 }, "" },
            { "ALF_CasqueCross_Bleu_Vert", "", 85, { "", "", -1 }, "" },
            { "ALF_CasqueCross_KTM", "", 85, { "", "", -1 }, "" },
            { "ALF_CasqueCross_Noir_Uni", "", 85, { "", "", -1 }, "" },
            { "ALF_CasqueCross_Orange", "", 85, { "", "", -1 }, "" },
            { "ALF_CasqueCross_RedBull", "", 85, { "", "", -1 }, "" },
            { "ALF_CasqueCross_RedBull_Bleu", "", 85, { "", "", -1 }, "" },
            { "ALF_CasqueCross_Vert", "", 85, { "", "", -1 }, "" },
            { "UR_Beerhat_Yellow", "", 70, { "", "", -1 }, "" },
            { "UR_Beerhat_Red2", "", 70, { "", "", -1 }, "" },
            { "UR_Beerhat_Red1", "", 70, { "", "", -1 }, "" },
            { "UR_Beerhat_Green2", "", 70, { "", "", -1 }, "" },
            { "UR_Beerhat_Green1", "", 70, { "", "", -1 }, "" },
            { "UR_Beerhat_Blue", "", 70, { "", "", -1 }, "" },
            { "H_TurbanO_blk", "", 10, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_Squares", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Blue", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackred", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Checkered", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackyellow", "", 5, { "", "", -1 }, "" },
            { "G_Sport_BlackWhite", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Black", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Red", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Green", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Red", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Checkered", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Greenblack", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackred", "", 5, { "", "", -1 }, "" },
            { "G_Spectacles", "", 5, { "", "", -1 }, "" },
            { "G_Spectacles_Tinted", "", 5, { "", "", -1 }, "" },
            { "G_Lowprofile", "", 5, { "", "", -1 }, "" },
            { "G_Combat", "", 50, { "", "", -1 }, "" },
            { "G_Aviator", "", 25, { "", "", -1 }, "" },
            { "G_eyeProtectors_F", "", 10, { "", "", -1 }, "" },
            { "G_eyeProtectors_Earpiece_F", "", 95, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_1", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_2", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_3", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_4", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_5", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_6", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_7", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_1", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_2", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_3", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_4", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_5", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_6", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_7", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_8", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_9", "", 1100, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Black", "", 360, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Multi", "", 350, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Violet", "", 390, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Vert", "", 380, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Rouge", "", 370, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Fleur", "", 850, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Weed", "", 1450, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_LV", "", 2400, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Vert", "", 3400, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Bleu", "", 3400, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "ALF_AssaultPack_khk", "", 30, { "", "", -1 }, "" },
            { "ALF_AssaultPack_rgr", "", 30, { "", "", -1 }, "" },
            { "ALF_AssaultPack_sgg", "", 30, { "", "", -1 }, "" },
            { "ALF_AssaultPack_blk", "", 30, { "", "", -1 }, "" },
            { "ALF_AssaultPack_cbr", "", 30, { "", "", -1 }, "" },
            { "ALF_FieldPack_blk", "", 40, { "", "", -1 }, "" },
            { "ALF_TacticalPack_oli", "", 50, { "", "", -1 }, "" },
            { "ALF_OutdoorPack_blk", "", 55, { "", "", -1 }, "" },
            { "ALF_Kitbag_sgg", "", 60, { "", "", -1 }, "" },
            { "ALF_Kitbag_cbr", "", 60, { "", "", -1 }, "" },
            { "ALF_Bergen_sgg", "", 65, { "", "", -1 }, "" },
            { "ALF_Bergen_rgr", "", 65, { "", "", -1 }, "" },
            { "ALF_Bergen_blk", "", 65, { "", "", -1 }, "" },
            { "ALF_Carryall_oli", "", 70, { "", "", -1 }, "" },
            { "ALF_Carryall_khk", "", 70, { "", "", -1 }, "" },
            { "ALF_Carryall_cbr", "", 70, { "", "", -1 }, "" }
        };
    };
    class premium 
    {
        title = "Le grand luxe";
        license = "";
        uniforms[] = 
        {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Jogging_Gucci", "", 980, { "", "", -1 }, "" },
            { "EF_Suit_1", "Costume", 10580, { "", "", -1 }, "" },
            { "EF_Suit_2", "Costume", 10600, { "", "", -1 }, "" },
            { "EF_Suit_7", "Costume", 10750, { "", "", -1 }, "" },
            { "EF_Suit_Y1", "Costume", 10580, { "", "", -1 }, "" },
            { "EF_Suit_Y2", "Costume", 10600, { "", "", -1 }, "" },
            { "EF_Suit_Y3", "Costume", 10750, { "", "", -1 }, "" },
            { "EF_Suit_Y4", "Costume", 10750, { "", "", -1 }, "" },
            { "EF_Suit_Y5", "Costume", 10750, { "", "", -1 }, "" },
            { "EF_Suit_Y6", "Costume", 10750, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_blue_F", "Costume", 10580, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_gray_F", "Costume", 10600, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_khaki_F", "Costume", 10750, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_black_F", "Costume", 10580, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_tshirt_gray_F", "Costume", 10600, { "", "", -1 }, "" },
            { "U_C_FormalSuit_01_tshirt_black_F", "Costume", 10750, { "", "", -1 }, "" },
            { "HITMAN_47_SUIT_3", "Costume", 10750, { "", "", -1 }, "" },
            { "ALF_CostumeGucci", "Costume", 10750, { "", "", -1 }, "" },
            { "HITMAN_47_SUIT_4", "Costume", 10750, { "", "", -1 }, "" },
            { "HITMAN_47_DIOR_1", "Costume", 10580, { "", "", -1 }, "" },
            { "HITMAN_47_DIOR_5", "Costume", 10600, { "", "", -1 }, "" },
            { "HITMAN_47_DIOR_3", "Costume", 10750, { "", "", -1 }, "" },
            { "HITMAN_47_KS_6", "Costume", 10580, { "", "", -1 }, "" },
            { "HITMAN_47_KS_2", "Costume", 10600, { "", "", -1 }, "" },
            { "HITMAN_47_KS_5", "Costume", 10750, { "", "", -1 }, "" },
            { "HITMAN_47_KS_8", "Costume", 10750, { "", "", -1 }, "" },
            { "HITMAN_47_KS_9", "Costume", 10750, { "", "", -1 }, "" },
            { "HITMAN_47_KS_3", "Costume", 10750, { "", "", -1 }, "" },
            { "HITMAN_47_KS_7", "Costume", 10750, { "", "", -1 }, "" },
            { "HITMAN_47_KS_4", "Costume", 10750, { "", "", -1 }, "" },
            { "HITMAN_47_KS_1", "Costume", 10750, { "", "", -1 }, "" },
            { "EF_FEM_3_9_BK2", "Tenue femme", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_BW2", "Tenue femme", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_GR2", "Tenue femme", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_BL2", "Tenue femme", 70, { "", "", -1 }, "meuf" }
        };
        headgear[] = 
        {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Viking", "", 145, { "", "", -1 }, "" },
            { "ALF_Beret_Bleu", "", 145, { "", "", -1 }, "" },
            { "ALF_Beret_Gris", "", 145, { "", "", -1 }, "" },
            { "ALF_Beret_Black", "", 145, { "", "", -1 }, "" },
            { "ALF_Beret_Orange", "", 145, { "", "", -1 }, "" },
            { "ALF_Beret_Rose", "", 145, { "", "", -1 }, "" },
            { "ALF_Beret_Vert", "", 145, { "", "", -1 }, "" },
            { "ALF_Beret_Violet", "", 145, { "", "", -1 }, "" },
            { "ALF_Beret_Rouge", "", 145, { "", "", -1 }, "" },
            { "ALF_Keffieh", "", 145, { "", "", -1 }, "" },
            { "ALF_Chapka", "", 145, { "", "", -1 }, "" },
            { "ALF_Angel_Casque", "", 69, { "", "", -1 }, "" }
        };
        goggles[] = 
        {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "ALF_Lunette_Ronde", "", 500, { "", "", -1 }, "" },
            { "ALF_Lunette_Ronde_Blanche", "", 500, { "", "", -1 }, "" },
            { "ALF_Lunette_Ronde_Rouge", "", 500, { "", "", -1 }, "" },
            { "ALF_Lunette_Ronde_Bleu", "", 500, { "", "", -1 }, "" },
            { "ALF_Lunette_LV", "", 1500, { "", "", -1 }, "" },
            { "ALF_Lunette_LV_Blanche", "", 1500, { "", "", -1 }, "" },
            { "ALF_Lunette_LV_Rouge", "", 1500, { "", "", -1 }, "" },
            { "ALF_Lunette_LV_Bleu", "", 1500, { "", "", -1 }, "" }
        };
        vests[] = 
        {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },            
            { "ALF_V_Sac_Cuir_Noir", "", 700, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Blanc", "", 700, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Rouge", "", 700, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Vert", "", 700, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Bleu", "", 700, { "", "", -1 }, "" }
        };
        backpacks[] = 
        {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "ALF_B_Guitar", "", 70, { "", "", -1 }, "" }
        };
    };
    class Women 
    {
        title = "Vêtement Femme";
        license = "";
        uniforms[] = 
        {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_CHAW3_D1", "", 50, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D2", "", 50, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D3", "", 50, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D4", "", 50, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D6", "", 50, { "", "", -1 }, "meuf" },
            { "U_ALF_TenueFemme_1", "", 60, { "", "", -1 }, "meuf" },
            { "U_ALF_TenueFemme_2", "", 60, { "", "", -1 }, "meuf" },
            { "U_ALF_TenueFemme_3", "", 60, { "", "", -1 }, "meuf" },
            { "U_ALF_TenueFemme_4", "", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_2U", "", 80, { "", "", -1 }, "meuf" },
            { "EF_FEM_2BK", "", 80, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2B", "Manteau noir et jeans 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2B2", "Manteau noir et jeans 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2B3", "Manteau noir et jeans 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2BL", "Manteau bleu et jeans 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2BL2", "Manteau bleu et jeans 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2BL3", "Manteau bleu et jeans 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2K", "Manteau kaki et jeans 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2K2", "Manteau kaki et jeans 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2K3", "Manteau kaki et jeans 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2R", "Manteau rouge et jeans 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2R2", "Manteau rouge et jeans 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2R3", "Manteau rouge et jeans 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2W", "Manteau blanc et jeans 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2W2", "Manteau blanc et jeans 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2W3", "Manteau blanc et jeans 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2B", "Sweet noir et jeans bleu", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2B2", "Sweet noir et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2B3", "Sweet noir et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2BL", "Sweet bleu et jeans bleu", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2BL2", "Sweet bleu et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2BL3", "Sweet bleu et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2OD", "Sweet olive et jeans bleu", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2OD2", "Sweet olive et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2OD3", "Sweet olive et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2SG", "Sweet bleu coincoin et jeans bleu", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2SG2", "Sweet bleu coincoin et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2SG3", "Sweet bleu coincoin et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2PP", "Sweet violet et jeans bleu", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2PP2", "Sweet violet et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2PP3", "Sweet violet et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBR", "Sweet PUNK rouge et jeans bleu", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBR2", "Sweet PUNK rouge et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBR3", "Sweet PUNK rouge et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBPS", "Sweet PUNK violet et jeans bleu", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBPS2", "Sweet PUNK violet et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBPS3", "Sweet PUNK violet et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBW", "Sweet PUNK blanc et jeans bleu", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBW2", "Sweet PUNK blanc et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBW3", "Sweet PUNK blanc et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPB", "Sweet PUNK noir et jeans bleu", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPB2", "Sweet PUNK noir et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPB3", "Sweet PUNK noir et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBL", "Sweet PUNK bleu et jeans bleu", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBL2", "Sweet PUNK bleu et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2LPBL3", "Sweet PUNK bleu et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4A", "Gilet noir et jeans bleu 1", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_4A2", "Gilet noir et jeans bleu 2", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_4A_2", "Gilet noir et jeans noir 1", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_4A2_2", "Gilet noir et jeans noir 2", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_4A_3", "Gilet noir et jeans marron 1", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_4A2_3", "Gilet noir et jeans marron 2", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_72ADR", "Chemise rouge et jeans noir", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_72ADR2", "Chemise rouge et jeans bleu", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_72ADR3", "Chemise rouge et jeans marron", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_77", "Chemise noir et jeans bleu", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_77R", "Chemise noir et jeans noir", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_77R2", "Chemise noir et jeans marron", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_73R", "Chemise rouge et jeans marron", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_73R2", "Chemise noir et jeans marron", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_74", "Chemise rouge et jeans bleu", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_74R", "Chemise rouge et jeans noir", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_72R", "Chemise moutarde et jeans noir", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_7", "Chemise blanche et jeans bleu", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_7R", "Chemise blanche et jeans noir", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_7R2", "Chemise blanche et jeans marron", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_BK", "Robe noir", 120, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_BK_BL", "Robe noir et bleu", 120, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_BK_K", "Robe noir et moutarde", 120, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_BK_W", "Robe noir et blanche", 120, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_BWK", "Robe marron et moutarde ", 120, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_R_BK", "Robe rouge et noir", 120, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_SG_W", "Robe kaki et blanc", 120, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_2", "Tenu avec jupe 1", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9B", "Manteau noir et jupe 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9B2", "Manteau noir et jupe 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9B3", "Manteau noir et jupe 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9BL", "Manteau bleu et jupe 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9BL2", "Manteau bleu et jupe 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9BL3", "Manteau bleu et jupe 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9K", "Manteau kaki et jupe 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9K2", "Manteau kaki et jupe 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9K3", "Manteau kaki et jupe 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9R", "Manteau rouge et jupe 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9R2", "Manteau rouge et jupe 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9R3", "Manteau rouge et jupe 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9V", "Manteau violet et jupe 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9V2", "Manteau violet et jupe 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9V3", "Manteau violet et jupe 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9W", "Manteau blanche et jupe 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9W2", "Manteau blanche et jupe 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9W3", "Manteau blanche et jupe 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_3B", "Sweet noir et jupe", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_3BL", "Sweet bleu et jupe", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_3OD", "Sweet kaki et jupe", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_3SG", "Sweet bleu et jupe", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_3PP", "Sweet violet et jupe", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_3_PUNK", "Sweet PUNK noir et rouge et jupe", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_3LPBPS", "Sweet PUNK violet et jupe", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_3LPBR", "Sweet PUNK rouge et jupe", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_3LPB", "Sweet PUNK noir et jupe", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_3LPBL", "Sweet PUNK bleu et jupe", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3A", "Gilet noir et jupe noir 1", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_3A2", "Gilet noir et jupe noir 2", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_3A_2", "Gilet noir et jupe rouge 1", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_3A2_2", "Gilet noir et jupe rouge 2", 60, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_BKBK", "Manteau noir et jupe 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_BKBK2", "Manteau noir et jupe 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_2BKBKW", "Manteau noir et jupe 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_2BKBKBC", "Manteau noir et jupe 4", 90, { "", "", -1 }, "meuf" },         
            { "EF_FEM_3_8_BWBK", "Manteau marron et jupe 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_2BWGRW", "Manteau marron et jupe 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_2BWBKBWH", "Manteau marron et jupe 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_GRGR", "Manteau cyan et jupe 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_GRBK", "Manteau cyan et jupe 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_2GRGRRC2", "Manteau cyan et jupe 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_2GRBKW", "Manteau cyan et jupe 4", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_2GRRDW", "Manteau cyan et jupe 5", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_RDBK", "Manteau rouge et jupe 1", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_RDRD", "Manteau rouge et jupe 2", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_2RDBKW", "Manteau rouge et jupe 3", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_8_2RDRDW", "Manteau rouge et jupe 4", 90, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_77", "Chemise noir et jupe", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_75R2", "Chemise viollette et jupe", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_76", "Chemise bleu et jupe", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_73", "Chemise rouge et jupe", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_7", "Chemise blanche et jupe", 50, { "", "", -1 }, "meuf" },
            { "TCGM_f_underwear", "Tenue femme ", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_Sport_1", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_Sport_2", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_Sport_3", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_Sport_4", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_Sport_5", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_SoldierParamilitary", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_SoldierParamilitary_RollUp", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_CombatUniform_M81_Bra", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_Soldier1_RollUp", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_Soldier_GEN", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_Wetsuit_B", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_Wetsuit_Gry_C", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_Wetsuit_Blu_C", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_WetsuitShort_B", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_WetsuitShort_B", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_WetsuitShort_Blu_C", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "TCGM_F_WetsuitShort_Gry_C", "Tenue femmee", 50, { "", "", -1 }, "meuf" },
            { "woman_4 ", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "woman_3", "Tenue femme", 50, { "", "", -1 }, "meuf" },
            { "woman_1", "Tenue femme", 50, { "", "", -1 }, "meuf" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "EF_FBNE_BK", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FBNE_BL", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FBNE_BR", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FBNE_R", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FBNE_V", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FBNE_W", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHcap_BK", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHcap_BL", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHcap_C", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHcap_CY", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHcap_MG", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHcap_P", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHcap_R", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHcap_SG", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHcap_PP", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHcap_W", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_USA", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_AE", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_IF", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_MNW", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_PM", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_O", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_R", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_Surf", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_TN", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_UK", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FCap_US", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHAT_BK", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHAT_BW", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHAT_CL", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FHAT_SG", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FPKL_BK", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FPKL_BL", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FPKL_CY", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FPKL_RD", "", 20, { "", "", -1 }, "meuf" },
            { "EF_FPKL_W", "", 20, { "", "", -1 }, "meuf" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_Lady_Blue", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FG1", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FG2", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_T", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_BK", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_BL", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_BW", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_C", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_G", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_O", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_P", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_R", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_V", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_W", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FSG_Y", "", 5, { "", "", -1 }, "meuf" },
            { "EF_ACC1", "", 100, { "", "", -1 }, "meuf" },
            { "EF_ACC2", "", 100, { "", "", -1 }, "meuf" },
            { "EF_ACC3", "", 100, { "", "", -1 }, "meuf" },
            { "EF_ACC4", "", 150, { "", "", -1 }, "meuf" },
            { "EF_FRG1", "", 5, { "", "", -1 }, "meuf" },
            { "EF_FRG2", "", 5, { "", "", -1 }, "meuf" },
            { "EF_SC_CF1_NV", "", 50, { "", "", -1 }, "meuf" },
            { "EF_SC_CYF1_NV", "", 50, { "", "", -1 }, "meuf" },
            { "EF_SC_MGF1_NV", "", 50, { "", "", -1 }, "meuf" },
            { "EF_SC_PF1_NV", "", 50, { "", "", -1 }, "meuf" },
            { "EF_SC_PPF1_NV", "", 50, { "", "", -1 }, "meuf" },
            { "EF_SC_WF1_NV", "", 50, { "", "", -1 }, "meuf" },
            { "EF_SC_CF2_NV", "", 50, { "", "", -1 }, "meuf" },
            { "EF_SC_MGF2_NV", "", 50, { "", "", -1 }, "meuf" },
            { "EF_SC_PF2_NV", "", 50, { "", "", -1 }, "meuf" },
            { "EF_SC_PPF2_NV", "", 50, { "", "", -1 }, "meuf" },
            { "EF_SC_WF2_NV", "", 50, { "", "", -1 }, "meuf" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_1", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_2", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_3", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_4", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_5", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_6", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_7", "", 900, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_1", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_2", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_3", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_4", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_5", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_6", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_7", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_8", "", 1100, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_9", "", 1100, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Black", "", 360, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Multi", "", 350, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Violet", "", 390, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Vert", "", 380, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Rouge", "", 370, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Fleur", "", 850, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_Weed", "", 1450, { "", "", -1 }, "" },
            { "ALF_V_Sacoche_LV", "", 2400, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Vert", "", 3400, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Bleu", "", 3400, { "", "", -1 }, "" }
        };
        backpacks[] = 
        {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "ALF_FieldPack_ocamo", "", 40, { "", "", -1 }, "" },
            { "ALF_FieldPack_oucamo", "", 40, { "", "", -1 }, "" },
            { "ALF_Carryall_ocamo", "", 80, { "", "", -1 }, "" },
            { "ALF_Carryall_oucamo", "", 80, { "", "", -1 }, "" }
        };
    };
    class Women_premium {
        title = "Le grand luxe Femme";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "EF_FEM_3_9_BK2", "Tailleur pantalon noir", 9700, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_BW2", "Tailleur pantalon marron", 9700, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_GR2", "Tailleur pantalon gris", 9700, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_BL2", "Tailleur pantalon bleu marine", 9700, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_BK", "Tailleur jupe noir", 9200, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_BW", "Tailleur jupe marron", 9200, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_GR", "Tailleur jupe gris", 9200, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_BL", "Tailleur jupe bleu marine", 9200, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2BKBK", "Tailleur noir et jupe", 2500, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2BWBK", "Tailleur marron et jupe", 2500, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2GRBK", "Tailleur gris et jupe", 2500, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2BLBK", "Tailleur bleu marine et jupe", 2500, { "", "", -1 }, "meuf" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "c", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Noir", "", 700, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Blanc", "", 700, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Rouge", "", 700, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Vert", "", 700, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Bleu", "", 700, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" }
        };
    };
    class Chasseur 
    {
        title = "Vêtement de Chasseur";
        license = "";
        uniforms[] = 
        {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_HunterBody_grn", "", 75, { "", "", -1 }, "" },
            { "U_I_G_resistanceLeader_F", "", 60, { "", "", -1 }, "" },
            { "U_BG_Guerilla2_1", "", 60, { "", "", -1 }, "" }
        };
        headgear[] = 
        {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = 
        {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = 
        {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = 
        {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "ALF_FieldPack_ocamo", "", 40, { "", "", -1 }, "" },
            { "ALF_FieldPack_oucamo", "", 40, { "", "", -1 }, "" },
            { "ALF_Carryall_ocamo", "", 80, { "", "", -1 }, "" },
            { "ALF_Carryall_oucamo", "", 80, { "", "", -1 }, "" }
        };
    };  
    //////////////////////////////// GENDARMERIE //////////////////////////////////
    class cop {
        title = "Gendarmerie";
        license = "cop";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Cyno", "", 5, { "", "", -1 }, "CYNO" },
            { "ALF_PMO_1", "", 5, { "", "", -1 }, "PMO" },
            // { "ALF_Wetsuit_G", "", 5, { "", "", -1 }, "" },
            { "ALF_G_Pilote", "", 5, { "", "", -1 }, "" },
            { "ALF_Camo_Dep", "", 5, { "", "", -1 }, "" },
            { "MRP_TenuePSIG", "", 15, { "", "", -1 }, "PSIG" },
            { "U_ALF_TenueMeth_GND", "", 15, { "", "", -1 }, "" },           


            { "MRP_TenuePSIG_ELG", "", 5, { "life_copLevel", "EQUAL", 1 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_GND", "", 5, { "life_copLevel", "EQUAL", 2 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_MDC", "", 5, { "life_copLevel", "EQUAL", 2 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_ADJ", "", 5, { "life_copLevel", "EQUAL", 4 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_ADC", "", 5, { "life_copLevel", "EQUAL", 5 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_MAJ", "", 5, { "life_copLevel", "EQUAL", 6 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_SLT", "", 5, { "life_copLevel", "EQUAL", 7 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_LTN", "", 5, { "life_copLevel", "EQUAL", 8 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_CNE", "", 5, { "life_copLevel", "EQUAL", 9 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_CMD", "", 5, { "life_copLevel", "EQUAL", 10 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_LCL", "", 5, { "life_copLevel", "EQUAL", 11 }, "PSIG_Sabre" },
            { "MRP_TenuePSIG_COL", "", 5, { "life_copLevel", "EQUAL", 12 }, "PSIG_Sabre" },


            //Polo
            { "PMO_Polo_ELG", "", 5, { "life_copLevel", "EQUAL", 1 }, "PMO" },
            { "PMO_Polo_GND", "", 5, { "life_copLevel", "EQUAL", 2 }, "PMO" },
            { "PMO_Polo_MDC", "", 5, { "life_copLevel", "EQUAL", 3 }, "PMO" },
            { "PMO_Polo_ADJ", "", 5, { "life_copLevel", "EQUAL", 4 }, "PMO" },
            { "PMO_Polo_ADC", "", 5, { "life_copLevel", "EQUAL", 5 }, "PMO" },
            { "PMO_Polo_MAJ", "", 5, { "life_copLevel", "EQUAL", 6 }, "PMO" },
            { "PMO_Polo_SLT", "", 5, { "life_copLevel", "EQUAL", 7 }, "PMO" },
            { "PMO_Polo_LTN", "", 5, { "life_copLevel", "EQUAL", 8 }, "PMO" },
            { "PMO_Polo_CNE", "", 5, { "life_copLevel", "EQUAL", 9 }, "PMO" },
            { "PMO_Polo_CMD", "", 5, { "life_copLevel", "EQUAL", 10 }, "PMO" },
            { "PMO_Polo_LCL", "", 5, { "life_copLevel", "EQUAL", 11 }, "PMO" },
            { "PMO_Polo_COL", "", 5, { "life_copLevel", "EQUAL", 12 }, "PMO" },


            { "PMO_LEGERE_ELG", "", 5, { "life_copLevel", "EQUAL", 1 }, "PMO" },
            { "PMO_LEGERE_GND", "", 5, { "life_copLevel", "EQUAL", 2 }, "PMO" },
            { "PMO_LEGERE_MDC", "", 5, { "life_copLevel", "EQUAL", 3 }, "PMO" },
            { "PMO_LEGERE_ADJ", "", 5, { "life_copLevel", "EQUAL", 4 }, "PMO" },
            { "PMO_LEGERE_ADC", "", 5, { "life_copLevel", "EQUAL", 5 }, "PMO" },
            { "PMO_LEGERE_MAJ", "", 5, { "life_copLevel", "EQUAL", 6 }, "PMO" },
            { "PMO_LEGERE_SLT", "", 5, { "life_copLevel", "EQUAL", 7 }, "PMO" },
            { "PMO_LEGERE_LTN", "", 5, { "life_copLevel", "EQUAL", 8 }, "PMO" },
            { "PMO_LEGERE_CNE", "", 5, { "life_copLevel", "EQUAL", 9 }, "PMO" },
            { "PMO_LEGERE_CMD", "", 5, { "life_copLevel", "EQUAL", 10 }, "PMO" },
            { "PMO_LEGERE_LCL", "", 5, { "life_copLevel", "EQUAL", 11 }, "PMO" },
            { "PMO_LEGERE_COL", "", 5, { "life_copLevel", "EQUAL", 12 }, "PMO" },

            //PMO
            { "MRP_VestePMO_ELG", "", 5, { "life_copLevel", "EQUAL", 1 }, "PMO" },
            { "MRP_VestePMO_GND", "", 5, { "life_copLevel", "EQUAL", 2 }, "PMO" },
            { "MRP_VestePMO_MDC", "", 5, { "life_copLevel", "EQUAL", 3 }, "PMO" },
            { "MRP_VestePMO_ADJ", "", 5, { "life_copLevel", "EQUAL", 4 }, "PMO" },
            { "MRP_VestePMO_ADC", "", 5, { "life_copLevel", "EQUAL", 5 }, "PMO" },
            { "MRP_VestePMO_MAJ", "", 5, { "life_copLevel", "EQUAL", 6 }, "PMO" },
            { "MRP_VestePMO_SLT", "", 5, { "life_copLevel", "EQUAL", 7 }, "PMO" },
            { "MRP_VestePMO_LTN", "", 5, { "life_copLevel", "EQUAL", 8 }, "PMO" },
            { "MRP_VestePMO_CNE", "", 5, { "life_copLevel", "EQUAL", 9 }, "PMO" },
            { "MRP_VestePMO_CMD", "", 5, { "life_copLevel", "EQUAL", 10 }, "PMO" },
            { "MRP_VestePMO_LCL", "", 5, { "life_copLevel", "EQUAL", 11 }, "PMO" },
            { "MRP_VestePMO_COL", "", 5, { "life_copLevel", "EQUAL", 12 }, "PMO" },
            //Softshell
            { "MRP_Softshell_GN_ELG", "", 5, { "life_copLevel", "EQUAL", 1 }, "" },
            { "MRP_Softshell_GN_GND", "", 5, { "life_copLevel", "EQUAL", 2 }, "" },
            { "MRP_Softshell_GN_MDC", "", 5, { "life_copLevel", "EQUAL", 3 }, "" },
            { "MRP_Softshell_GN_ADJ", "", 5, { "life_copLevel", "EQUAL", 4 }, "" },
            { "MRP_Softshell_GN_ADC", "", 5, { "life_copLevel", "EQUAL", 5 }, "" },
            { "MRP_Softshell_GN_MAJ", "", 5, { "life_copLevel", "EQUAL", 6 }, "" },
            { "MRP_Softshell_GN_SLT", "", 5, { "life_copLevel", "EQUAL", 7 }, "" },
            { "MRP_Softshell_GN_LTN", "", 5, { "life_copLevel", "EQUAL", 8 }, "" },
            { "MRP_Softshell_GN_CNE", "", 5, { "life_copLevel", "EQUAL", 9 }, "" },
            { "MRP_Softshell_GN_CMD", "", 5, { "life_copLevel", "EQUAL", 10 }, "" },
            { "MRP_Softshell_GN_LCL", "", 5, { "life_copLevel", "EQUAL", 11 }, "" },
            { "MRP_Softshell_GN_COL", "", 5, { "life_copLevel", "EQUAL", 12 }, "" },
            //Vareuse
            { "GD_Parade", "", 5, { "life_copLevel", "EQUAL", 2}, "" },
            { "GD_Parade_MDC", "", 5, { "life_copLevel", "EQUAL", 3}, "" },
            { "GD_Parade_ADJ", "", 5, { "life_copLevel", "EQUAL", 4}, "" },
            { "GD_Parade_ADC", "", 5, { "life_copLevel", "EQUAL", 5}, "" },
            { "GD_Parade_MAJ", "", 5, { "life_copLevel", "EQUAL", 6}, "" },
            { "GD_Parade_SLT", "", 5, { "life_copLevel", "EQUAL", 7}, "" },
            { "GD_Parade_LTN", "", 5, { "life_copLevel", "EQUAL", 8}, "" },
            { "GD_Parade_CNE", "", 5, { "life_copLevel", "EQUAL", 9}, "" },
            { "GD_Parade_CMD", "", 5, { "life_copLevel", "EQUAL", 10}, "" },
            { "GD_Parade_LCL", "", 5, { "life_copLevel", "EQUAL", 11}, "" },
            { "GD_Parade_COL", "", 5, { "life_copLevel", "EQUAL", 12}, "" },
            { "GM_Parade_ELG", "", 5, { "life_copLevel", "EQUAL", 1}, "" },
            { "GM_Parade_GND", "", 5, { "life_copLevel", "EQUAL", 2}, "" },
            { "GM_Parade_MDC", "", 5, { "life_copLevel", "EQUAL", 3}, "" },
            { "GM_Parade_ADJ", "", 5, { "life_copLevel", "EQUAL", 4}, "" },
            { "GM_Parade_ADC", "", 5, { "life_copLevel", "EQUAL", 5}, "" },
            { "GM_Parade_MAJ", "", 5, { "life_copLevel", "EQUAL", 6}, "" },
            { "GM_Parade_SLT", "", 5, { "life_copLevel", "EQUAL", 7}, "" },
            { "GM_Parade_LTN", "", 5, { "life_copLevel", "EQUAL", 8}, "" },
            { "GM_Parade_CNE", "", 5, { "life_copLevel", "EQUAL", 9}, "" },
            { "GM_Parade_CMD", "", 5, { "life_copLevel", "EQUAL", 10}, "" },
            { "GM_Parade_LCL", "", 5, { "life_copLevel", "EQUAL", 11}, "" },
            { "GM_Parade_COL", "", 5, { "life_copLevel", "EQUAL", 12}, "" },
            //Autre

            { "ALF_Elvis", "", 70, { "", "", -1 }, "" },
            { "ALF_JEM", "", 70, { "", "", -1 }, "" },
            { "ALF_Obey", "", 70, { "", "", -1 }, "" },
            { "ALF_KFC", "", 70, { "", "", -1 }, "" },
            { "ALF_Checker", "", 70, { "", "", -1 }, "" },
            { "ALF_Chicago_Bulls", "", 70, { "", "", -1 }, "" },
            { "ALF_Jack_C", "", 70, { "", "", -1 }, "" },
            { "ALF_Coq_S", "", 70, { "", "", -1 }, "" },
            { "ALF_Adidas_Charo", "", 70, { "", "", -1 }, "" },
            { "ALF_Nike_Outer_Space", "", 70, { "", "", -1 }, "" },
            { "ALF_Nike_Tokyo_Landry", "", 70, { "", "", -1 }, "" },
            { "ALF_Cocaine_Paris", "", 70, { "", "", -1 }, "" },
            { "ALF_Herbivore", "", 70, { "", "", -1 }, "" },
            { "ALF_Nike_Tricolore", "", 70, { "", "", -1 }, "" },
            { "ALF_Bullshit", "", 70, { "", "", -1 }, "" },
            { "ALF_Alcool", "", 70, { "", "", -1 }, "" },
            { "ALF_Reveil", "", 70, { "", "", -1 }, "" },
            { "ALF_CHAW3_D", "", 70, { "", "", -1 }, "" },
            { "ALF_CHAW3_D1", "", 70, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D2", "", 70, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D3", "", 70, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D4", "", 70, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D6", "", 70, { "", "", -1 }, "meuf" },
            { "TRYK_U_denim_hood_blk", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_denim_hood_nc", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_denim_jersey_blk", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_denim_jersey_blu", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_B_RED_T_BR", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_B_Denim_T_BK", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_B_Denim_T_WH", "", 70, { "", "", -1 }, "" },
            { "MRPV2_gd_polo", "", 70, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Casque_PMO", "", 15, { "", "", -1 }, "PMO" },
            { "V_ALF_Cap_PSIG", "", 15, { "", "", -1 }, "PSIG" },
            { "ALF_Casque_PSIGS", "", 39, { "", "", -1 }, "PSIG" },
            { "gign_helm", "", 39, { "", "", -1 }, "PSIG" },
            { "casque_GM_ouvert", "", 39, { "", "", -1 }, "PSIG" },
            { "ALF_Cap_GIGN_2", "", 39, { "", "", -1 }, "PSIG" },
            { "calot_gendarmerie_simple", "", 39, { "", "", -1 }, "" },
            { "ALF_H_PilotHelmetHeli_B", "", 39, { "", "", -1 }, "" },
            { "ALF_Calot", "", 10, { "", "", -1 }, "" },
            { "calot_gendarmerie_mobile", "", 10, { "", "", -1 }, "" },
            { "ALF_KepiGD", "", 5, { "life_copLevel", "EQUAL", 1 }, "" },
            { "ALF_KepiGD", "", 5, { "life_copLevel", "EQUAL", 2 }, "" },
            { "ALF_Kepi_MarechalDesLogisChef", "", 5, { "life_copLevel", "EQUAL", 3 }, "" },
            { "ALF_Kepi_Adjudant", "", 5, { "life_copLevel", "EQUAL", 4 }, "" },
            { "ALF_Kepi_AdjudantChef", "", 5, { "life_copLevel", "EQUAL", 5 }, "" },
            { "ALF_Kepi_Major", "", 5, { "life_copLevel", "EQUAL", 6 }, "" },
            { "ALF_Kepi_SousLieutenant", "", 5, { "life_copLevel", "EQUAL", 7 }, "" },
            { "ALF_Kepi_Lieutenant", "", 5, { "life_copLevel", "EQUAL", 8 }, "" },
            { "ALF_Kepi_Capitaine", "", 5, { "life_copLevel", "EQUAL", 9 }, "" },
            { "ALF_Kepi_Commandant", "", 5, { "life_copLevel", "EQUAL", 10 }, "" },
            { "ALF_Kepi_LieutenantColonel", "", 5, { "life_copLevel", "EQUAL", 11 }, "" },
            { "ALF_Kepi_Colonel", "", 5, { "life_copLevel", "EQUAL", 12 }, "" },
            { "GM_Kepi_OFF", "", 5, { "", "", -1 }, "" },
            { "GM_Kepi_SOF", "", 5, { "", "", -1 }, "" },
            //{ "MRPV2_Calot", "", 10, { "", "", -1 }, "" },
            { "MRPV2_bonnet_GN", "", 5, { "", "", -1 }, "" },
            { "MRPV2_casque_GN", "", 25, { "", "", -1 }, "PMO" },
            { "MRPV2_casque_GN_ferme", "", 25, { "", "", -1 }, "PMO" },
            { "MRPV2_TC_G3", "", 5, { "", "", -1 }, "" },
            { "MRPV2_TC_G3_ferme", "", 5, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "ALF_Brassard_GND", "", 5, { "", "", -1 }, "" },
            { "G_Squares", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Blue", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackred", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Checkered", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackyellow", "", 5, { "", "", -1 }, "" },
            { "G_Sport_BlackWhite", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Black", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Red", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Green", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Red", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Checkered", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Greenblack", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackred", "", 5, { "", "", -1 }, "" },
            { "G_Spectacles", "", 5, { "", "", -1 }, "" },
            { "G_Spectacles_Tinted", "", 5, { "", "", -1 }, "" },
            { "G_Lady_Blue", "", 5, { "", "", -1 }, "" },
            { "G_Lowprofile", "", 5, { "", "", -1 }, "" },
            { "G_Combat", "", 5, { "", "", -1 }, "" },
            { "G_Aviator", "", 5, { "", "", -1 }, "" },
            { "G_Lady_Mirror", "", 5, { "", "", -1 }, "" },
            { "G_Lady_Dark", "", 5, { "", "", -1 }, "" },
            { "G_Lady_Blue", "", 5, { "", "", -1 }, "" },
            { "MRP_Bodycam_VB400", "", 5, { "", "", -1 }, "" },
            { "G_Respirator_white_F", "", 5, { "", "", -1 }, "" },
            { "TdC_gm", "", 5, { "", "", -1 }, "PSIG" },
            { "KA_MCU", "", 5, { "", "", -1 }, "PSIG" },
            { "UR_G_Balaclava_ACU", "", 5, { "", "", -1 }, "PSIG" },
            { "ALF_G_Balaclava_blk", "", 5, { "", "", -1 }, "PSIG" },
            { "TRYK_kio_balaclava_BLK_ear", "", 5, { "", "", -1 }, "PSIG" },
            { "TRYK_kio_balaclava_ESS", "", 5, { "", "", -1 }, "PSIG" },
            { "TRYK_kio_balaclava_BLK", "", 5, { "", "", -1 }, "PSIG" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "ALF_V_GendarmerieI", "", 5, { "", "", -1 }, "" },
            //PsigS
            { "Veste_GM_Patrouille_ELG", "", 5, { "life_copLevel", "EQUAL", 1 }, "PSIG" },
            { "Veste_GM_Patrouille_GND", "", 5, { "life_copLevel", "EQUAL", 2 }, "PSIG" },
            { "Veste_GM_Patrouille_MDC", "", 5, { "life_copLevel", "EQUAL", 2 }, "PSIG" },
            { "Veste_GM_Patrouille_ADJ", "", 5, { "life_copLevel", "EQUAL", 4 }, "PSIG" },
            { "Veste_GM_Patrouille_ADC", "", 5, { "life_copLevel", "EQUAL", 5 }, "PSIG" },
            { "Veste_GM_Patrouille_MAJ", "", 5, { "life_copLevel", "EQUAL", 6 }, "PSIG" },
            { "Veste_GM_Patrouille_SLT", "", 5, { "life_copLevel", "EQUAL", 7 }, "PSIG" },
            { "Veste_GM_Patrouille_LTN", "", 5, { "life_copLevel", "EQUAL", 8 }, "PSIG" },
            { "Veste_GM_Patrouille_CNE", "", 5, { "life_copLevel", "EQUAL", 9 }, "PSIG" },
            { "Veste_GM_Patrouille_CMD", "", 5, { "life_copLevel", "EQUAL", 10 }, "PSIG" },
            { "Veste_GM_Patrouille_LCL", "", 5, { "life_copLevel", "EQUAL", 11 }, "PSIG" },
            { "Veste_GM_Patrouille_COL", "", 5, { "life_copLevel", "EQUAL", 12 }, "PSIG" },
            
            //Nego
            { "V_ALF_GiletNego_ADJ", "", 5, { "life_copLevel", "EQUAL", 4 }, "" },
            { "V_ALF_GiletNego_ADC", "", 5, { "life_copLevel", "EQUAL", 5 }, "" },
            { "V_ALF_GiletNego_MAJ", "", 5, { "life_copLevel", "EQUAL", 6 }, "" },
            { "V_ALF_GiletNego_SLT", "", 5, { "life_copLevel", "EQUAL", 7 }, "" },
            { "V_ALF_GiletNego_LTN", "", 5, { "life_copLevel", "EQUAL", 8 }, "" },
            { "V_ALF_GiletNego_CNE", "", 5, { "life_copLevel", "EQUAL", 9 }, "" },
            { "V_ALF_GiletNego_CDT", "", 5, { "life_copLevel", "EQUAL", 10 }, "" },
            { "V_ALF_GiletNego_LCL", "", 5, { "life_copLevel", "EQUAL", 11 }, "" },
            { "V_ALF_GiletNego_COL", "", 5, { "life_copLevel", "EQUAL", 12 }, "" },

            //Psig
            { "Gilet_Yakeda_PSIGSABRE_ELG", "", 5, { "life_copLevel", "EQUAL", 2 }, "PSIG_Sabre" },            
            { "Gilet_Yakeda_PSIGSABRE_GD", "", 5, { "life_copLevel", "EQUAL", 2 }, "PSIG_Sabre" },
            { "Gilet_Yakeda_PSIGSABRE_MDC", "", 5, { "life_copLevel", "EQUAL", 3 }, "PSIG_Sabre" },
            { "Gilet_Yakeda_PSIGSABRE_ADJ", "", 5, { "life_copLevel", "EQUAL", 4 }, "PSIG_Sabre" },
            { "Gilet_Yakeda_PSIGSABRE_ADC", "", 5, { "life_copLevel", "EQUAL", 5 }, "PSIG_Sabre" },
            { "Gilet_Yakeda_PSIGSABRE_MJR", "", 5, { "life_copLevel", "EQUAL", 6 }, "PSIG_Sabre" },
            { "Gilet_Yakeda_PSIGSABRE_SLT", "", 5, { "life_copLevel", "EQUAL", 7 }, "PSIG_Sabre" },
            { "Gilet_Yakeda_PSIGSABRE_LTN", "", 5, { "life_copLevel", "EQUAL", 8 }, "PSIG_Sabre" },
            { "Gilet_Yakeda_PSIGSABRE_CPT", "", 5, { "life_copLevel", "EQUAL", 9 }, "PSIG_Sabre" },
            { "Gilet_Yakeda_PSIGSABRE_CMD", "", 5, { "life_copLevel", "EQUAL", 10 }, "PSIG_Sabre" },
            { "Gilet_Yakeda_PSIGSABRE_LCL", "", 5, { "life_copLevel", "EQUAL", 11 }, "PSIG_Sabre" },
            { "Gilet_Yakeda_PSIGSABRE_COL", "", 5, { "life_copLevel", "EQUAL", 12 }, "PSIG_Sabre" },


            //SR
            //{ "V_ALF_GiletSR_MDC", "", 5, { "life_copLevel", "EQUAL", 3 }, "SR" },
            //{ "V_ALF_GiletSR_ADJ", "", 5, { "life_copLevel", "EQUAL", 4 }, "SR" },
            //{ "V_ALF_GiletSR_ADC", "", 5, { "life_copLevel", "EQUAL", 5 }, "SR" },
            //{ "V_ALF_GiletSR_MAJ", "", 5, { "life_copLevel", "EQUAL", 6 }, "SR" },
            //{ "V_ALF_GiletSR_SLT", "", 5, { "life_copLevel", "EQUAL", 7 }, "SR" },
            //{ "V_ALF_GiletSR_LTN", "", 5, { "life_copLevel", "EQUAL", 8 }, "SR" },
            //{ "V_ALF_GiletSR_CNE", "", 5, { "life_copLevel", "EQUAL", 9 }, "SR" },
            //{ "V_ALF_GiletSR_CDT", "", 5, { "life_copLevel", "EQUAL", 10 }, "SR" },
            //{ "V_ALF_GiletSR_LCL", "", 5, { "life_copLevel", "EQUAL", 11 }, "SR" },
            //{ "V_ALF_GiletSR_COL", "", 5, { "life_copLevel", "EQUAL", 12 }, "SR" },
            //Autre
            { "ALF_Holster", "", 5, { "life_copLevel", "EQUAL", 10 }, "" },
            { "ALF_Holster_Noir", "", 5, { "life_copLevel", "EQUAL", 10 }, "" },
            { "ALF_Holster_AP2", "", 5, { "life_copLevel", "EQUAL", 10 }, "" },
            { "ALF_Holster", "", 5, { "life_copLevel", "EQUAL", 11 }, "" },
            { "ALF_Holster_Noir", "", 5, { "life_copLevel", "EQUAL", 11 }, "" },
            { "ALF_Holster_AP2", "", 5, { "life_copLevel", "EQUAL", 11 }, "" },
            { "ALF_Holster", "", 5, { "life_copLevel", "EQUAL", 12 }, "" },
            { "ALF_Holster_Noir", "", 5, { "life_copLevel", "EQUAL", 12 }, "" },
            { "ALF_Holster_AP2", "", 5, { "life_copLevel", "EQUAL", 12 }, "" },
            { "V_RebreatherB_mrp", "", 75, { "", "", -1 }, "" },
            { "MRP_Ceinture", "", 75, { "", "", -1 }, "" },
            { "MRP_Ceinture2", "", 75, { "", "", -1 }, "" },
            { "MRPV2_dotation_2", "", 75, { "", "", -1 }, "" },
            { "MRPV2_timecop_2", "", 75, { "", "", -1 }, "" },
            { "MRPV2_timecop_3", "", 75, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            //{ "B_ALF_GDM_Inv", "", 50, { "", "", -1 }, "" },
            { "MRP_GM_Protec", "", 5, { "", "", -1 }, "PSIG" },
            { "ALF_AssaultPack_khk", "", 30, { "", "", -1 }, "" },
            { "ALF_AssaultPack_rgr", "", 30, { "", "", -1 }, "" },
            { "ALF_AssaultPack_sgg", "", 30, { "", "", -1 }, "" },
            { "ALF_AssaultPack_blk", "", 30, { "", "", -1 }, "" },
            { "ALF_AssaultPack_cbr", "", 30, { "", "", -1 }, "" },
            { "ALF_FieldPack_blk", "", 40, { "", "", -1 }, "" },
            { "ALF_FieldPack_ocamo", "", 40, { "", "", -1 }, "" },
            { "ALF_FieldPack_oucamo", "", 40, { "", "", -1 }, "" },
            { "ALF_TacticalPack_oli", "", 50, { "", "", -1 }, "" },
            { "ALF_OutdoorPack_blk", "", 55, { "", "", -1 }, "" },
            { "ALF_Kitbag_sgg", "", 60, { "", "", -1 }, "" },
            { "ALF_Kitbag_cbr", "", 60, { "", "", -1 }, "" },
            { "ALF_Bergen_sgg", "", 65, { "", "", -1 }, "" },
            { "ALF_Bergen_rgr", "", 65, { "", "", -1 }, "" },
            { "ALF_Bergen_blk", "", 65, { "", "", -1 }, "" },
            //{ "ALF_Carryall_ocamo", "", 70, { "", "", -1 }, "" },
            //{ "ALF_Carryall_oli", "", 70, { "", "", -1 }, "" },
            //{ "ALF_Carryall_khk", "", 70, { "", "", -1 }, "" },
            //{ "ALF_Carryall_cbr", "", 70, { "", "", -1 }, "" },
            { "MRPV2_sacInvisible", "", 70, { "", "", -1 }, "" },
            { "MRPV2_comoditex", "", 70, { "", "", -1 }, "" },
            { "MRPV2_gkpro", "", 70, { "", "", -1 }, "" },
            { "MRPV2_verseidag", "", 70, { "", "", -1 }, "" },
            { "MRPV2_ghv", "", 70, { "", "", -1 }, "" },
            { "MRPV2_thor", "", 70, { "", "", -1 }, "" },
            { "MRPV2_identif", "", 70, { "", "", -1 }, "" },
            { "MRPV2_identif_TIC", "", 70, { "", "", -1 }, "" },
            //bandeau
            { "GD_SacsBandes_Commandement", "", 70, { "", "", -1 }, "" },
            { "GD_SacsBandes_Cyno", "", 70, { "", "", -1 }, "" },
            { "GD_SacsBandes_Nautique", "", 70, { "", "", -1 }, "" },
            { "GD_SacsBandes_Nego", "", 70, { "", "", -1 }, "" },
            { "GD_SacsBandes_TIC", "", 70, { "", "", -1 }, "" }
        };
    };
    //////////////////////////////// PENIT //////////////////////////////////
    class prison {
        title = "Vetement Prison";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Poloshirt_stripped", "", 150, { "", "", -1 }, "" },
            { "ALF_Poloshirt_redwhite", "", 150, { "", "", -1 }, "" },
            { "ALF_Poloshirt_salmon", "", 150, { "", "", -1 }, "" },
            { "ALF_Poloshirt_blue", "", 150, { "", "", -1 }, "" },
            { "ALF_Poor_2", "", 150, { "", "", -1 }, "" },
            { "ALF_Poloshirt_burgundy", "", 150, { "", "", -1 }, "" },
            { "ALF_Poloshirt_tricolour", "", 150, { "", "", -1 }, "" },
            { "ALF_HunterBody_grn", "", 150, { "", "", -1 }, "" },
            { "ALF_WorkerCoveralls", "", 150, { "", "", -1 }, "" },
            { "ALF_Maillot_Psg", "", 150, { "", "", -1 }, "" },
            { "ALF_Maillot_Lakers", "", 150, { "", "", -1 }, "" },
            { "ALF_PriestBody", "", 150, { "", "", -1 }, "" },
            { "ALF_Elvis", "", 150, { "", "", -1 }, "" },
            { "ALF_JEM", "", 150, { "", "", -1 }, "" },
            { "ALF_Obey", "", 180, { "", "", -1 }, "" },
            { "ALF_KFC", "", 180, { "", "", -1 }, "" },
            { "ALF_Checker", "", 180, { "", "", -1 }, "" },
            { "ALF_Chicago_Bulls", "", 180, { "", "", -1 }, "" },
            { "ALF_Jack_C", "", 180, { "", "", -1 }, "" },
            { "ALF_Coq_S", "", 180, { "", "", -1 }, "" },
            { "ALF_Adidas_Charo", "", 180, { "", "", -1 }, "" },
            { "ALF_Nike_Outer_Space", "", 180, { "", "", -1 }, "" },
            { "ALF_Nike_Tokyo_Landry", "", 180, { "", "", -1 }, "" },
            { "ALF_Cocaine_Paris", "", 180, { "", "", -1 }, "" },
            { "ALF_Herbivore", "", 180, { "", "", -1 }, "" },
            { "ALF_Charo_Orange", "", 180, { "", "", -1 }, "" },
            { "ALF_Nike_Tricolore", "", 180, { "", "", -1 }, "" },
            { "ALF_Bullshit", "", 180, { "", "", -1 }, "" },
            { "ALF_Alcool", "", 280, { "", "", -1 }, "" },
            { "ALF_Reveil", "", 280, { "", "", -1 }, "" },
            { "ALF_Thug_Swag", "", 280, { "", "", -1 }, "" },
            { "ALF_Nike1", "", 350, { "", "", -1 }, "" },
            { "ALF_Nike2", "", 350, { "", "", -1 }, "" },
            { "ALF_Nike3", "", 350, { "", "", -1 }, "" },
            { "ALF_Nike4", "", 350, { "", "", -1 }, "" },
            { "ALF_Nike5", "", 350, { "", "", -1 }, "" },
            { "ALF_NikosAgedBody", "", 350, { "", "", -1 }, "" },
            { "ALF_Ralph_VB", "", 550, { "", "", -1 }, "" },
            { "ALF_Ralph_BJ", "", 550, { "", "", -1 }, "" },
            { "ALF_Ralph_A", "", 550, { "", "", -1 }, "" },
            { "ALF_Ralph_R", "", 550, { "", "", -1 }, "" },
            { "ALF_Ralph_B", "", 550, { "", "", -1 }, "" },
            { "ALF_LV", "", 850, { "", "", -1 }, "" },
            { "ALF_Lacoste_B", "", 650, { "", "", -1 }, "" },
            { "ALF_Lacoste_BF", "", 650, { "", "", -1 }, "" },
            { "ALF_Lacoste_BC", "", 650, { "", "", -1 }, "" },
            { "ALF_Lacoste_BL", "", 650, { "", "", -1 }, "" },
            { "ALF_Lacoste_RS", "", 650, { "", "", -1 }, "" },
            { "ALF_Lacoste_R", "", 650, { "", "", -1 }, "" },
            { "ALF_Lacoste_S", "", 650, { "", "", -1 }, "" },
            { "ALF_Lacoste_VC", "", 650, { "", "", -1 }, "" },
            { "ALF_Lacoste_VF", "", 650, { "", "", -1 }, "" },
            { "ALF_CHAW3_D", "", 950, { "", "", -1 }, "" },
            { "ALF_Elvis", "", 70, { "", "", -1 }, "" },
            { "ALF_JEM", "", 70, { "", "", -1 }, "" },
            { "ALF_Obey", "", 70, { "", "", -1 }, "" },
            { "ALF_KFC", "", 70, { "", "", -1 }, "" },
            { "ALF_Checker", "", 70, { "", "", -1 }, "" },
            { "ALF_Chicago_Bulls", "", 70, { "", "", -1 }, "" },
            { "ALF_Jack_C", "", 70, { "", "", -1 }, "" },
            { "ALF_Coq_S", "", 70, { "", "", -1 }, "" },
            { "ALF_Adidas_Charo", "", 70, { "", "", -1 }, "" },
            { "ALF_Nike_Outer_Space", "", 70, { "", "", -1 }, "" },
            { "ALF_Nike_Tokyo_Landry", "", 70, { "", "", -1 }, "" },
            { "ALF_Cocaine_Paris", "", 70, { "", "", -1 }, "" },
            { "ALF_Herbivore", "", 70, { "", "", -1 }, "" },
            { "ALF_Nike_Tricolore", "", 70, { "", "", -1 }, "" },
            { "ALF_Bullshit", "", 70, { "", "", -1 }, "" },
            { "ALF_Alcool", "", 70, { "", "", -1 }, "" },
            { "ALF_Reveil", "", 70, { "", "", -1 }, "" },
            { "ALF_CHAW3_D", "", 70, { "", "", -1 }, "" },
            { "ALF_CHAW3_D1", "", 70, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D2", "", 70, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D3", "", 70, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D4", "", 70, { "", "", -1 }, "meuf" },
            { "ALF_CHAW3_D6", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2R", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2R2", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2V", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2V2", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2W", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_2W2", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_BK", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_BK_BL", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_BK_K", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_BK_W", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_BWK", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_R_BK", "", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_10A_SG_W", "", 70, { "", "", -1 }, "meuf" },
            { "TRYK_U_denim_hood_blk", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_denim_hood_nc", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_denim_jersey_blk", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_denim_jersey_blu", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_B_RED_T_BR", "", 70, { "", "", -1 }, "" },
            { "TRYK_U_B_Denim_T_BK", "", 70, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_Squares", "", 65, { "", "", -1 }, "" },
            { "G_Shades_Blue", "", 65, { "", "", -1 }, "" },
            { "G_Sport_Blackred", "", 65, { "", "", -1 }, "" },
            { "G_Sport_Checkered", "", 65, { "", "", -1 }, "" },
            { "G_Sport_Blackyellow", "", 65, { "", "", -1 }, "" },
            { "G_Sport_BlackWhite", "", 65, { "", "", -1 }, "" },
            { "G_Shades_Black", "", 65, { "", "", -1 }, "" },
            { "G_Shades_Red", "", 65, { "", "", -1 }, "" },
            { "G_Shades_Green", "", 65, { "", "", -1 }, "" },
            { "G_Sport_Red", "", 65, { "", "", -1 }, "" },
            { "G_Sport_Greenblack", "", 65, { "", "", -1 }, "" },
            { "G_Spectacles", "", 65, { "", "", -1 }, "" },
            { "G_Spectacles_Tinted", "", 65, { "", "", -1 }, "" },
            { "G_Lady_Blue", "", 65, { "", "", -1 }, "" },
            { "G_Lowprofile", "", 65, { "", "", -1 }, "" },
            { "G_Combat", "", 65, { "", "", -1 }, "" },
            { "G_Aviator", "", 65, { "", "", -1 }, "" },
            { "G_Lady_Mirror", "", 65, { "", "", -1 }, "" },
            { "G_Lady_Dark", "", 65, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "MRPV2_sacInvisible", "", 0, { "", "", -1 }, "" }
        };
    };
    class policemunicipale {
        title = "Vêtement Police Municipale";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_Bri", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_Bri_chef", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_Bri_chef_Princ", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_CDP", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_CSCN", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_CSCS", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_Chef_Service_Stag", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_D", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_GP", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_GS", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_GT", "", 0, { "", "", -1 }, "" },
            { "Vallies_Polo_PM_SD", "", 0, { "", "", -1 }, "" },
            { "PM_Polo", "", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "Vallies_Casquette_PM_Bleu", "", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "PM_VestPB_GS", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_GT", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_GP", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_BR", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_BRC", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_BRP", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_CP", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_CSS", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_CSCN", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_CSCS", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_CSCE", "", 0, { "", "", -1 }, "" },
            { "PM_VestPB_DIR", "", 0, { "", "", -1 }, "" },
            { "GILET_HV_PM", "", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "MRPV2_sacInvisible", "", 0, { "", "", -1 }, "" }
        };
    };

    class prisonpro {
        title = "Vetement Penit";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            // Céremonie
            { "AP_Parade1", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Parade2", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Parade3", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Parade4", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Parade5", "", 5, { "life_penit", "", -1 }, "" },
            // Polo
            { "AP_Polo1", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo2", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo3", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo4", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo5", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo6", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo7", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo8", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo9", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo10", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo11", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_Polo12", "", 5, { "life_penit", "", -1 }, "" },

            { "ALF_Penit_Stagiaire", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Penit_Titulaire", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Penit_Principal", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Penit_Brigadier", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Penit_BrigadierPrincipal", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Penit_Major", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Penit_Lieutenant", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Penit_Capitaine", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Penit_Commandant", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Penit_Directeur", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Var_AP_1", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Var_AP_2", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Var_AP_3", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Var_AP_4", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_ERIS_1", "", 5, { "life_penit", "", 1 }, "ERIS" },
            { "ALF_PM_1", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Tenue_PM_2", "", 70, { "life_penit", "", -1 }, "" },
            { "ALF_Polo_PM_1 ", "", 70, { "life_penit", "", -1 }, "" },
            { "ALF_Polo_PM_2", "", 70, { "life_penit", "", -1 }, "" },
            { "ALF_Polo_PM_3", "", 70, { "life_penit", "", -1 }, "" },
            { "ALF_Polo_PM_4", "", 70, { "life_penit", "", -1 }, "" },
            { "ALF_Var_PM_1", "", 70, { "life_penit", "", -1 }, "" },
            { "ALF_Var_PM_2", "", 70, { "life_penit", "", -1 }, "" },
            { "ALF_Var_PM_3", "", 70, { "life_penit", "", -1 }, "" },
            { "ALF_Var_PM_4", "", 70, { "life_penit", "", -1 }, "" },
            { "ALF_Prisonnier_Jaune", "", 5, { "", "", -1 }, "" },
            { "ALF_Prisonnier_Orange", "", 5, { "", "", -1 }, "" },
            { "ALF_Prisonnier_Rouge", "", 5, { "", "", -1 }, "" },
            { "ALF_Prisonnier_Vert", "", 5, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_Cap_AP", "", 5, { "", "", -1 }, "" },
            { "ALF_Cap_AP_2", "Casquette (Lieutenant)", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Cap_AP_2", "Casquette (Capitaine)", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Cap_AP_2", "Casquette (Commandant)", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Cap_AP_2", "Casquette (Directeur)", 5, { "life_penit", "", -1 }, "" },
            { "gign_helm", "Casque ERIS", 5, { "", "", -1 }, "ERIS" },
            { "V_ALF_Cap_PM", "", 5, { "", "", -1 }, "" },
            { "ALF_Cap_PM_2", "Casquette Lieutenant", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Cap_PM_2", "Casquette Capitaine", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Cap_PM_2", "Casquette Commandant", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Cap_PM_2", "Casquette Directeur", 5, { "life_penit", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "ALF_G_Balaclava_blk", "", 5, { "", "", -1 }, "ERIS" },
            { "TRYK_kio_balaclava_BLK_ear", "", 5, { "", "", -1 }, "ERIS" },
            { "TRYK_kio_balaclava_ESS", "", 5, { "", "", -1 }, "ERIS" },
            { "TRYK_kio_balaclava_BLK", "", 5, { "", "", -1 }, "ERIS" },
            { "G_Squares", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Blue", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackred", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Checkered", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackyellow", "", 5, { "", "", -1 }, "" },
            { "G_Sport_BlackWhite", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Black", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Red", "", 5, { "", "", -1 }, "" },
            { "G_Shades_Green", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Red", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Checkered", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Greenblack", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackred", "", 5, { "", "", -1 }, "" },
            { "G_Spectacles", "", 5, { "", "", -1 }, "" },
            { "G_Spectacles_Tinted", "", 5, { "", "", -1 }, "" },
            { "G_Lady_Blue", "", 5, { "", "", -1 }, "" },
            { "G_Lowprofile", "", 5, { "", "", -1 }, "" },
            { "G_Combat", "", 5, { "", "", -1 }, "" },
            { "G_Aviator", "", 5, { "", "", -1 }, "" },
            { "G_Lady_Mirror", "", 5, { "", "", -1 }, "" },
            { "G_Lady_Dark", "", 5, { "", "", -1 }, "" },
            { "G_Lady_Blue", "", 5, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_ALF_Gilet_AP", "", 25, { "", "", -1 }, "" },
            { "ALF_ERIS_Leger_1", "", 25, { "", "", -1 }, "ERIS" },
            { "ALF_ERIS_Leger_2", "", 25, { "", "", -1 }, "ERIS" },
            { "ALF_ERIS_Leger_3", "", 25, { "", "", -1 }, "ERIS" },
            { "AP_GiletPB_ESU", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_SUS", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_SU", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_SUP", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_SUB", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_1SU", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_MAJ", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_LTN", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_CNE", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_CMD", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_SDI", "", 5, { "life_penit", "", -1 }, "" },
            { "AP_GiletPB_DIR", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_AP", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_Noir", "", 5, { "", "", -1 }, "" },
            { "ALF_Holster_AP2", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_AP3", "", 5, { "", "", -1 }, "" },
            { "ALF_Holster_AP", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_Noir", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_AP2", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_AP3", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_AP", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_Noir", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_AP2", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_AP3", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_AP", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_Noir", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_AP2", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Holster_AP3", "", 5, { "life_penit", "", -1 }, "" },
            { "ALF_Rangemaster_belt", "", 25, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "MRPV2_sacInvisible", "", 0, { "", "", -1 }, "" }
        };
    };

    //////////////////////////////// POMPIER //////////////////////////////////
    class med 
    {
        title = "Pompier";
        license = "med";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },

			//uniforme SP
            { "ALF_Pompier_U_1", "", 0, { "life_medicLevel", "EQUAL", 1 }, "" },
            { "ALF_Pompier_U_2", "", 0, { "life_medicLevel", "EQUAL", 2 }, "" },
            { "ALF_Pompier_U_3", "", 0, { "life_medicLevel", "EQUAL", 3 }, "" },
            { "ALF_Pompier_U_4", "", 0, { "life_medicLevel", "EQUAL", 4 }, "" },
            { "ALF_Pompier_U_5", "", 0, { "life_medicLevel", "EQUAL", 5 }, "" },
            { "ALF_Pompier_U_6", "", 0, { "life_medicLevel", "EQUAL", 6 }, "" },
            { "ALF_Pompier_U_7", "", 0, { "life_medicLevel", "EQUAL", 7 }, "" },
            { "ALF_Pompier_U_8", "", 0, { "life_medicLevel", "EQUAL", 8 }, "" },
            { "ALF_Pompier_U_9", "", 0, { "life_medicLevel", "EQUAL", 9 }, "" },
            { "ALF_Pompier_U_10", "", 0, { "life_medicLevel", "EQUAL", 10 }, "" },
            { "ALF_Pompier_U_11", "", 0, { "life_medicLevel", "EQUAL", 11 }, "" },
            { "ALF_Pompier_U_12", "", 0, { "life_medicLevel", "EQUAL", 12 }, "" },

            //Polo SP
            { "SP_Polo_2cl", "", 0, { "life_medicLevel", "EQUAL", 1 }, "" },
            { "SP_Polo_1cl", "", 0, { "life_medicLevel", "EQUAL", 2 }, "" },
            { "SP_Polo_cpl", "", 0, { "life_medicLevel", "EQUAL", 3 }, "" },
            { "SP_Polo_cch", "", 0, { "life_medicLevel", "EQUAL", 4 }, "" },
            { "SP_Polo_sgt", "", 0, { "life_medicLevel", "EQUAL", 5 }, "" },
            { "SP_Polo_sch", "", 0, { "life_medicLevel", "EQUAL", 6 }, "" },
            { "SP_Polo_adj", "", 0, { "life_medicLevel", "EQUAL", 7 }, "" },
            { "SP_Polo_adc", "", 0, { "life_medicLevel", "EQUAL", 8 }, "" },
            { "SP_Polo_ltn", "", 0, { "life_medicLevel", "EQUAL", 9 }, "" },
            { "SP_Polo_cne", "", 0, { "life_medicLevel", "EQUAL", 10 }, "" },
            { "SP_Polo_cmd", "", 0, { "life_medicLevel", "EQUAL", 11 }, "" },
            { "SP_Polo_lcl", "", 0, { "life_medicLevel", "EQUAL", 12 }, "" },
            { "SP_Polo_col", "", 0, { "life_medicLevel", "EQUAL", 12 }, "" },

            //Polo 3SM
            { "SP_Polo_isl", "", 0, { "life_medicLevel", "EQUAL", 5 }, "SAMU" },
            { "SP_Polo_ilt", "", 0, { "life_medicLevel", "EQUAL", 6 }, "SAMU" },
            { "SP_Polo_icn", "", 0, { "life_medicLevel", "EQUAL", 7 }, "SAMU" },
            { "SP_Polo_mas", "", 0, { "life_medicLevel", "EQUAL", 8 }, "SAMU" },
            { "SP_Polo_mlt", "", 0, { "life_medicLevel", "EQUAL", 9 }, "SAMU" },
            { "SP_Polo_mcn", "", 0, { "life_medicLevel", "EQUAL", 10 }, "SAMU" },
            { "SP_Polo_mcd", "", 0, { "life_medicLevel", "EQUAL", 11 }, "SAMU" },
            { "SP_Polo_mlc", "", 0, { "life_medicLevel", "EQUAL", 12 }, "SAMU" },
            { "SP_Polo_mcl", "", 0, { "life_medicLevel", "EQUAL", 13 }, "SAMU" },

            //Softshell
            { "MRP_Softshell_2CL", "", 0, { "life_medicLevel", "EQUAL", 1 }, "" },
            { "MRP_Softshell_1CL", "", 0, { "life_medicLevel", "EQUAL", 2 }, "" },
            { "MRP_Softshell_CPL", "", 0, { "life_medicLevel", "EQUAL", 3 }, "" },
            { "MRP_Softshell_CCH", "", 0, { "life_medicLevel", "EQUAL", 4 }, "" },
            { "MRP_Softshell_SGT", "", 0, { "life_medicLevel", "EQUAL", 5 }, "" },
            { "MRP_Softshell_SCH", "", 0, { "life_medicLevel", "EQUAL", 6 }, "" },
            { "MRP_Softshell_ADJ", "", 0, { "life_medicLevel", "EQUAL", 7 }, "" },
            { "MRP_Softshell_ADC", "", 0, { "life_medicLevel", "EQUAL", 8 }, "" },
            { "MRP_Softshell_LTN", "", 0, { "life_medicLevel", "EQUAL", 9 }, "" },
            { "MRP_Softshell_CNE", "", 0, { "life_medicLevel", "EQUAL", 10 }, "" },
            { "MRP_Softshell_CMD", "", 0, { "life_medicLevel", "EQUAL", 11 }, "" },
            { "MRP_Softshell_LCL", "", 0, { "life_medicLevel", "EQUAL", 12 }, "" },
            { "MRP_Softshell_COL", "", 0, { "life_medicLevel", "EQUAL", 12 }, "" },

			//Softshell 3SM
            { "MRP_Softshell_ISL", "", 0, { "life_medicLevel", "EQUAL", 5 }, "SAMU" },
            { "MRP_Softshell_ILT", "", 0, { "life_medicLevel", "EQUAL", 6 }, "SAMU" },
            { "MRP_Softshell_ICN", "", 0, { "life_medicLevel", "EQUAL", 7 }, "SAMU" },
            { "MRP_Softshell_MAS", "", 0, { "life_medicLevel", "EQUAL", 8 }, "SAMU" },
            { "MRP_Softshell_MLT", "", 0, { "life_medicLevel", "EQUAL", 9 }, "SAMU" },
            { "MRP_Softshell_MCN", "", 0, { "life_medicLevel", "EQUAL", 10 }, "SAMU" },
            { "MRP_Softshell_MCD", "", 0, { "life_medicLevel", "EQUAL", 11 }, "SAMU" },
            { "MRP_Softshell_MLC", "", 0, { "life_medicLevel", "EQUAL", 12 }, "SAMU" },
            { "MRP_Softshell_MCL", "", 0, { "life_medicLevel", "EQUAL", 13 }, "SAMU" },

            //F1 SP
			{ "Vallies_F1_2nd_Classe", "", 0, { "life_medicLevel", "EQUAL", 1 }, "" },
            { "Vallies_F1_1er_Classe", "", 0, { "life_medicLevel", "EQUAL", 2 }, "" },
            { "Vallies_F1_Caporal", "", 0, { "life_medicLevel", "EQUAL", 3 }, "" },
            { "Vallies_F1_Caporal_Chef", "", 0, { "life_medicLevel", "EQUAL", 4 }, "" },
            { "Vallies_F1_Sergent", "", 0, { "life_medicLevel", "EQUAL", 5 }, "" },
            { "Vallies_F1_Sergent_C", "", 0, { "life_medicLevel", "EQUAL", 6 }, "" },
            { "Vallies_F1_Adjudant", "", 0, { "life_medicLevel", "EQUAL", 7 }, "" },
            { "Vallies_F1_Adjudant_Chef", "", 0, { "life_medicLevel", "EQUAL", 8 }, "" },
            { "Vallies_F1_Lieutenant", "", 0, { "life_medicLevel", "EQUAL", 9 }, "" },
            { "Vallies_F1_Capitaine", "", 0, { "life_medicLevel", "EQUAL", 10 }, "" },
            { "Vallies_F1_Commandant", "", 0, { "life_medicLevel", "EQUAL", 11 }, "" },
            { "Vallies_F1_Lieutenant_Colonel", "", 0, { "life_medicLevel", "EQUAL", 12 }, "" },
			{ "Vallies_F1_Colonel", "", 0, { "life_medicLevel", "EQUAL", 13 }, "" },

			//F1 3SM
			{ "Vallies_F1_Infirmier", "", 0, { "life_medicLevel", "EQUAL", 5 }, "SAMU" },
			{ "Vallies_F1_Infirmier_Principal", "", 0, { "life_medicLevel", "EQUAL", 6 }, "SAMU" },
			{ "Vallies_F1_Infirmier_Chef", "", 0, { "life_medicLevel", "EQUAL", 7 }, "SAMU" },
			{ "Vallies_F1_MED_ASP", "", 0, { "life_medicLevel", "EQUAL", 8 }, "SAMU" },
			{ "Vallies_F1_LTN_3SM", "", 0, { "life_medicLevel", "EQUAL", 9 }, "SAMU" },
			{ "Vallies_F1_Capitaine_3SM", "", 0, { "life_medicLevel", "EQUAL", 10 }, "SAMU" },
			{ "Vallies_F1_Commandant_3SM", "", 0, { "life_medicLevel", "EQUAL", 11 }, "SAMU" },
			{ "Vallies_F1_Lieutenant_Colonel_3SM", "", 0, { "life_medicLevel", "EQUAL", 12 }, "SAMU" },
			{ "Vallies_F1_Colonel_3SM", "", 0, { "life_medicLevel", "EQUAL", 13 }, "SAMU" },

			//T-shirt SP
			{ "Vallies_T_Shirt_2cl", "", 0, { "life_medicLevel", "EQUAL", 1 }, "" },
            { "Vallies_T_Shirt_1cl", "", 0, { "life_medicLevel", "EQUAL", 2 }, "" },
            { "Vallies_T_Shirt_cpl", "", 0, { "life_medicLevel", "EQUAL", 3 }, "" },
            { "Vallies_T_Shirt_cch", "", 0, { "life_medicLevel", "EQUAL", 4 }, "" },
            { "Vallies_T_Shirt_sgt", "", 0, { "life_medicLevel", "EQUAL", 5 }, "" },
            { "Vallies_T_Shirt_sch", "", 0, { "life_medicLevel", "EQUAL", 6 }, "" },
            { "Vallies_T_Shirt_adj", "", 0, { "life_medicLevel", "EQUAL", 7 }, "" },
            { "Vallies_T_Shirt_adc", "", 0, { "life_medicLevel", "EQUAL", 8 }, "" },
            { "Vallies_T_Shirt_ltn", "", 0, { "life_medicLevel", "EQUAL", 9 }, "" },
            { "Vallies_T_Shirt_cpt", "", 0, { "life_medicLevel", "EQUAL", 10 }, "" },
            { "Vallies_T_Shirt_cmd", "", 0, { "life_medicLevel", "EQUAL", 11 }, "" },
            { "Vallies_T_Shirt_lcl", "", 0, { "life_medicLevel", "EQUAL", 12 }, "" },
			{ "Vallies_T_Shirt_col", "", 0, { "life_medicLevel", "EQUAL", 13 }, "" },

			//T-shirt 3SM
			{ "Vallies_T_Shirt_inf_", "", 0, { "life_medicLevel", "EQUAL", 5 }, "SAMU" },
			{ "Vallies_T_Shirt_inf_princ", "", 0, { "life_medicLevel", "EQUAL", 6 }, "SAMU" },
			{ "Vallies_T_Shirt_inf_chef", "", 0, { "life_medicLevel", "EQUAL", 7 }, "SAMU" },
			{ "Vallies_T_Shirt_med_asp", "", 0, { "life_medicLevel", "EQUAL", 8 }, "SAMU" },
			{ "Vallies_T_Shirt_ltn_3sm", "", 0, { "life_medicLevel", "EQUAL", 9 }, "SAMU" },
			{ "Vallies_T_Shirt_cpt_3sm", "", 0, { "life_medicLevel", "EQUAL", 10 }, "SAMU" },
			{ "Vallies_T_Shirt_cmd_3sm", "", 0, { "life_medicLevel", "EQUAL", 11 }, "SAMU" },
			{ "Vallies_T_Shirt_lcl_3sm", "", 0, { "life_medicLevel", "EQUAL", 12 }, "SAMU" },
			{ "Vallies_T_Shirt_col_3sm", "", 0, { "life_medicLevel", "EQUAL", 13 }, "SAMU" },

			//cérémonie
            { "SP_Parade_LTN", "", 0, { "life_medicLevel", "EQUAL", 9 }, "" },
            { "SP_Parade_CNE", "", 0, { "life_medicLevel", "EQUAL", 10 }, "" },
            { "SP_Parade_CMD", "", 0, { "life_medicLevel", "EQUAL", 11 }, "" },
            { "SP_Parade_COL", "", 0, { "life_medicLevel", "EQUAL", 13 }, "" },

            //Vareuse
            { "ALF_Var_2", "", 0, { "life_medicLevel", "EQUAL", 1 }, "" },
            { "ALF_Var_1", "", 0, { "life_medicLevel", "EQUAL", 2 }, "" },
            { "ALF_Var_Capo", "", 0, { "life_medicLevel", "EQUAL", 3 }, "" },
            { "ALF_Var_Capoc", "", 0, { "life_medicLevel", "EQUAL", 4 }, "" },
            { "ALF_Var_Serg", "", 0, { "life_medicLevel", "EQUAL", 5 }, "" },
            { "ALF_Var_Sergc", "", 0, { "life_medicLevel", "EQUAL", 6 }, "" },
            { "ALF_Var_adj", "", 0, { "life_medicLevel", "EQUAL", 7 }, "" },
            { "ALF_Var_Adjc", "", 0, { "life_medicLevel", "EQUAL", 8 }, "" },

			//spécialité
			{ "MRP_U_Pompier_03_F", "", 0, { "", "", -1 }, "" },
            { "byscream_incendie_v3_tenue_feu", "", 0, { "", "", -1 }, "" },
			{ "ALF_Wetsuit_P", "", 0, { "", "", -1 }, "" },
            { "ALF_G_Dragon", "", 0, { "", "", -1 }, "" },
			{ "U_ALF_TenueMeth_SP", "", 0, { "", "", -1 }, "" },

			//sport
			{ "ALF_Adidas_Charo_Pompier", "", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },

			//Incendie
			{ "mrp_casque_f1xf_releve_hdr", "", 0, { "life_medicLevel", "", -1 }, "" },
			{ "mrp_casque_f1xf_releve_soff", "", 0, { "life_medicLevel", "", -1 }, "" },
			{ "mrp_casque_f1xf_releve_off", "", 0, { "life_medicLevel", "", -1 }, "" },

			//spécialité
            { "ALF_Mask_Samu", "", 0, { "", "", -1 }, "SAMU" },
            { "ALF_H_PilotHelmetHeli_B", "", 0, { "", "", -1 }, "" },

            //kepi Officier
            { "SP_Kepi_OFF", "", 0, { "life_medicLevel", "SCALAR", 9 }, "" }
        };
        goggles[] = {
			{ "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },

			//Incendie
			{ "byscream_incendie_v3_cagoule", "", 0, { "", "", -1 }, "" },
			{ "Vallies_cagoule_sp", "", 0, { "", "", -1 }, "" },
			{ "MRP_Gants_Cuir_bleu", "", 0, { "", "", -1 }, "" },

            // Cérémonie
            { "MRP_Gants_Cuir_Blanc", "", 0, { "life_medicLevel", "SCALAR", 9 }, "" }, // n'existe pas

			//Plongeur
			{ "G_B_Diving", "", 0, { "", "", -1 }, "" },

			//Autre
			{ "G_Aviator", "", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },

			//Gilet haute visibilité
			{ "GHVSP_Commun", "", 0, { "", "", -1 }, "" },
			{ "GHVSP_Apprenant", "", 0, { "", "", -1 }, "" },
			{ "GHVSP_Formation", "", 0, { "", "", -1 }, "" },
			{ "GHVSP_Chef", "", 0, { "", "", -1 }, "" },
			{ "GHVSP_COS", "", 0, { "", "", -1 }, "" },
			{ "ALF_Gilet_Inf", "", 0, { "life_medicLevel", "", -1 }, "SAMU" },
			{ "ALF_Gillet_Med", "", 0, { "life_medicLevel", "", -1 }, "SAMU" },
			{ "ALF_Gillet_Med_Chef", "", 0, { "life_medicLevel", "", -1 }, "SAMU" },


			//Plongeur
			{ "V_RebreatherB_mrp", "", 0, { "", "", -1 }, "" },

			//GREX
			{ "Vallies_Gilet_GREX_SP", "", 0, { "", "", -1 }, "" },
			{ "Vallies_Gilet_GREX_Chef_D_Agres", "", 0, { "life_medicLevel", "", -1 }, "" },
			{ "Vallies_Gilet_GREX_COS", "", 0, { "life_medicLevel", "", -1 }, "" },
			{ "Vallies_Gilet_GREX_Officier", "", 0, { "life_medicLevel", "", -1 }, "" },
			{ "Vallies_Gilet_GREX_Infirmier", "", 0, { "life_medicLevel", "", -1 }, "SAMU" },
			{ "Vallies_Gilet_GREX_Medecin", "", 0, { "life_medicLevel", "", -1 }, "SAMU" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },

			//Secours à personnes
			{ "MRP_Sac_Reflex", "", 0, { "", "", -1 }, "" },
			{ "MRP_Dimatex", "", 0, { "", "", -1 }, "" },

			//Incendie
			{ "byscream_incendie_v3_ari", "", 0, { "", "", -1 }, "" },
			//Autre
			{ "MRPV2_sacInvisible", "", 70, { "", "", -1 }, "" }
        };
    };

    class SP_Civ {
        title = "Pompiers";
        license = "med";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "ALF_Adidas_Charo_Pompier", "", 0, { "", "", -1 }, "" },
            { "ALF_Chicago_Bulls", "", 70, { "", "", -1 }, "" },
            { "ALF_Coq_S", "", 70, { "", "", -1 }, "" },
            { "ALF_Adidas_Charo", "", 70, { "", "", -1 }, "" },
            { "ALF_Alcool", "", 70, { "", "", -1 }, "" },
            { "ALF_Reveil", "", 70, { "", "", -1 }, "" },
            { "ALF_CHAW3_D", "", 70, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_3", "", 70, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_4", "", 70, { "", "", -1 }, "" },
            { "U_ALF_TenueTshirt_7", "", 70, { "", "", -1 }, "" },
            { "ALF_CHAW3_D6", "", 50, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2B3", "Sweet noir et jeans marron", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2BL2", "Sweet bleu et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2OD2", "Sweet olive et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2SG2", "Sweet bleu coincoin et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_4_2PP2", "Sweet violet et jeans noir", 70, { "", "", -1 }, "meuf" },
            { "EF_FEM_3_9_BL2", "Tailleur pantalon bleu marine", 9700, { "", "", -1 }, "meuf" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_H_Moto_RougeFonce", "", 50, { "", "", -1 }, "" },
            { "EF_FHAT_BW", "", 5, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "G_Sport_Blackred", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackyellow", "", 5, { "", "", -1 }, "" },
            { "G_Sport_BlackWhite", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Red", "", 5, { "", "", -1 }, "" },
            { "G_Sport_Blackred", "", 5, { "", "", -1 }, "" },
            { "G_Spectacles", "", 5, { "", "", -1 }, "" },
            { "G_Spectacles_Tinted", "", 5, { "", "", -1 }, "" },
            { "G_Aviator", "", 5, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_NorthFace_3", "", 50, { "", "", -1 }, "" },
            { "V_ALF_Doudoune_Moncler_2", "", 50, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Vert", "", 3400, { "", "", -1 }, "" },
            { "ALF_V_Sac_Cuir_Bleu", "", 3400, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "ALF_Kitbag_cbr", "", 60, { "", "", -1 }, "" },
            { "ALF_OutdoorPack_blk", "", 55, { "", "", -1 }, "" },
            { "ALF_TacticalPack_oli", "", 60, { "", "", -1 }, "" },
            { "ALF_Bergen_blk", "", 65, { "", "", -1 }, "" },
            { "ALF_Carryall_cbr", "", 70, { "", "", -1 }, "" },
            { "EF_FBAG_BK", "Sac noir 1", 50, { "", "", -1 }, "meuf" },
            { "EF_FBAG_HB_BK", "Sac noir 2", 50, { "", "", -1 }, "meuf" },
            { "EF_FBAG_SL_BK", "Sac noir 3", 50, { "", "", -1 }, "meuf" },
            { "EF_FBAG_S_BK", "Sac noir 4", 50, { "", "", -1 }, "meuf" },
            { "EF_SQBAG_BK", "Sac noir 5", 500, { "", "", -1 }, "meuf" }
        };
    };

    //////////////////////////////// ILLEGAL //////////////////////////////////
    class guetteur {
        title = "Le guetteur";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" },
            { "U_ALF_TenueMeth_Blanc", "", 3000, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" },
            { "ALF_masque_g", "", 85, { "", "", -1 }, "" },
            { "ALF_masque_D", "", 45, { "", "", -1 }, "" },
            { "ALF_masque_h", "", 45, { "", "", -1 }, "" },
            { "UR_ShirtMask_01", "", 45, { "", "", -1 }, "" },
            { "UR_ShirtMask_02", "", 45, { "", "", -1 }, "" },
            { "UR_ShirtMask_03", "", 45, { "", "", -1 }, "" },
            { "UR_ShirtMask_04", "", 45, { "", "", -1 }, "" },
            { "UR_ShirtMask_05", "", 45, { "", "", -1 }, "" },
            { "UR_ShirtMask_06", "", 45, { "", "", -1 }, "" },
            { "UR_ShirtMask_07", "", 45, { "", "", -1 }, "" },
            { "UR_ShirtMask_08", "", 45, { "", "", -1 }, "" },
            { "UR_ShirtMask_09", "", 45, { "", "", -1 }, "" },
            { "UR_ShirtMask_10", "", 45, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" },
            { "ALF_G_Balaclava_blk", "", 5, { "", "", -1 }, "" },
            { "ALF_G_Bandanna_beast", "", 5, { "", "", -1 }, "" },
            { "ALF_G_Bandanna_blk", "", 5, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" },
            //{ "ALF_Holster_Noir", "", 1500, { "", "", -1 }, "" }

            //Bandoliere
            { "V_BandollierB_rgr", "", 3000, { "", "", -1 }, "" },         
            { "V_BandollierB_oli", "", 3000, { "", "", -1 }, "" },
            { "V_BandollierB_blk", "", 3000, { "", "", -1 }, "" },
            { "V_BandollierB_khk", "", 3000, { "", "", -1 }, "" },

            { "UR_Armor_Woodland", "", 6000, { "", "", -1 }, "" },
            { "UR_Armor_Grey", "", 6000, { "", "", -1 }, "" },
            { "UR_Armor_Desert", "", 6000, { "", "", -1 }, "" },
            { "UR_Armor_Black", "", 6000, { "", "", -1 }, "" },

            { "V_Chestrig_blk", "", 9000, { "", "", -1 }, "" },          
            { "V_Chestrig_khk", "", 9000, { "", "", -1 }, "" },
            { "ALF_Bag_s", "", 10000, { "", "", -1 }, "" }
            

        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },

           { "MRP_Sacoche_arriere", "", 5000, { "", "", -1 }, "" },
           { "TAC_BP_KAR_B", "", 5000, { "", "", -1 }, "" },
           { "B_LegStrapBag_coyote_F", "", 5000, { "", "", -1 }, "" }
        };
    };

    class aeroport_parachute {
        title = "Magasin de parachutes";
        license = "";
        uniforms[] = {
            { "NONE", "Retirer Uniforme", 0, { "", "", -1 }, "" }
        };
        headgear[] = {
            { "NONE", "Retirer Chapeau", 0, { "", "", -1 }, "" }
        };
        goggles[] = {
            { "NONE", "Retirer Lunettes", 0, { "", "", -1 }, "" }
        };
        vests[] = {
            { "NONE", "Retirer Veste", 0, { "", "", -1 }, "" }
        };
        backpacks[] = {
            { "NONE", "Retirer Sac", 0, { "", "", -1 }, "" },
            { "MRP_B_Parachute", "Parachute", 1000, { "", "", -1 }, "" }
        };
    };
};
