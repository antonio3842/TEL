/*
	File: fn_houseConfig.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Check if buy house
*/
params [
	["_house","",[""]]
];
if(_house isEqualTo "") exitWith {[]};

switch (true) do {
	case (_house in ["Land_House_Small_02_F"]): {true};
	case (_house in ["Land_House_Small_01_F","Land_House_Small_03_F","Land_House_Small_06_F","Land_House_Small_04_F","Land_House_Small_05_F","Land_i_House_Small_01_b_brown_F"]): {true};
	case (_house in ["Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_House_Big_01_F"]): {true};
	case (_house in ["Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F"]): {true};
	case (_house in ["Land_i_House_Small_02_b_blue_F","Land_i_House_Small_02_b_brown_F","Land_i_House_Small_02_b_pink_F","Land_i_House_Small_02_b_white_F","Land_i_House_Small_02_b_whiteblue_F","Land_i_House_Small_02_b_yellow_F"]): {true};
	case (_house in ["Land_i_House_Small_03_V1_F"]): {true};
	case (_house in ["Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V3_F"]): {};
	//case (_house in ["Land_Addon_04_F"]): {true};
	case (_house in ["Land_ALF_MaisonMetal","Land_ALF_MaisonMetal_Blanc","Land_ALF_MaisonMetal_Verte","Land_ALF_MaisonMetal_Rouge","Land_ALF_MaisonMetal_Grise"]): {true};
	case (_house in ["Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_House_Big_02_F","Land_i_House_Big_02_b_blue_F","Land_i_House_Big_02_b_white_F","Land_i_House_Big_02_b_whiteblue_F","Land_i_House_Big_02_b_yellow_F","Land_i_House_Big_02_b_brown_F","Land_i_House_Big_02_b_pink_F"]): {true};
	//case (_house in ["Land_HouseA","Land_HouseB","Land_HouseC","Land_HouseD"]): {true};
	case (_house in ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_House_Big_03_F","Land_House_Big_04_F","Land_i_House_Big_01_b_white_F","Land_i_House_Big_01_b_brown_F","Land_i_House_Big_01_b_blue_F","Land_i_House_Big_01_b_whiteblue_F","Land_i_House_Big_01_b_pink_F","Land_i_House_Big_01_b_yellow_F"]): {true};
	//case (_house in ["Land_Hotel_02_F"]): {true};
	//case (_house in ["Land_ALF_MaisonMitoyenne","Land_ALF_MaisonMitoyenne1"]): {true};
	//case (_house in ["Land_ALF_MaisonModerne","Land_ALF_MaisonModerne_Blanc","Land_ALF_MaisonModerne_Verte","Land_ALF_MaisonModerne_Rouge","Land_ALF_MaisonModerne_Grise"]): {true};
	//case (_house in ["Land_ALF_MaisonContemporaine"]): {true};
	//case (_house in ["ALF_MaisonParadise"]): {true};
	//case (_house in ["Land_ALF_Villa_F"]): {true};
	//case (_house in ["Land_i_Shed_Ind_F"]): {true};
	//case (_house in ["Land_ALF_NightClub"]): {true};
	default {false};
};