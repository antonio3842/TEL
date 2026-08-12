/*
	File: fn_cfghouseclassnameslock.sqf
	Description: Verrouille toutes les portes de toutes les maisons achetables (achetées ou non) au redémarrage, sauf les bâtiments publics
*/
if !(isServer) exitWith {};

diag_log "================================== LOCKING ALL BUYABLE HOUSES ==================================";

// Liste des classnames de bâtiments publics qui ne doivent pas être verrouillés
private _publicBuildings = [
	"Land_ALF_Comico2", 
	"Land_Caserne", 
	"Land_MilOffices_V1_F"
];

// ===============================
// ❌ ZONES D'EXCEPTION (HANGARS, ZONES PUBLIQUES)
// ===============================
// Format : [positionATL, rayon]
private _exceptionZones = [
    [[6327.45,4784.29, 0], 20]   // Hangar fonderie
    //[[11200.4, 9050.8, 0], 60],
    //[[15000.0, 12000.0, 0], 100]
];


// Trouver tous les bâtiments sur la map
private _centerPos = [worldSize / 2, worldSize / 2, 0];
private _allBuildings = nearestTerrainObjects [_centerPos, ["house", "building"], worldSize * sqrt 2 / 2, false, true];

private _countLocked = 0;

// Parcourir tous les bâtiments
{
	private _building = _x;
	private _buildingClassname = typeOf _building;

	// Vérifier si le bâtiment est dans une zone d'exception
	private _isInExceptionZone = false;
	{
		_x params ["_pos", "_radius"];
		if ((_building distance2D _pos) <= _radius) exitWith {
			_isInExceptionZone = true;
		};
	} forEach _exceptionZones;

	if (_isInExceptionZone) then {
		continue;
	};
	
	// Vérifier si c'est un bâtiment public
	if (_buildingClassname in _publicBuildings) then {
		continue;
	};
	
	// Ignorer les bâtiments déjà verrouillés
	if (_building getVariable ["ALF_PorteFermer", false]) then {
		continue;
	};
	
	// Vérifier si c'est une maison achetable (même logique que fn_houseConfig)
	private _isBuyableHouse = switch (true) do {
		case (_buildingClassname in ["Land_ALF_Caravane","Land_caravane"]): {true};
		case (_buildingClassname in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F","Land_Garage","Land_Garage2"]): {true};
		case (_buildingClassname in ["Land_House_Small_02_F"]): {true};
		case (_buildingClassname in ["Land_House_Small_01_F","Land_House_Small_03_F","Land_House_Small_06_F","Land_House_Small_04_F","Land_House_Small_05_F","Land_i_House_Small_01_b_brown_F","Land_i_House_Small_01_b_yellow_F","Land_i_House_Small_01_b_blue_F","Land_i_House_Small_01_b_pink_F","Land_i_House_Small_01_b_white_F","Land_i_House_Small_01_b_whiteblue_F"]): {true};
		case (_buildingClassname in ["Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_House_Big_01_F","MRP_Wooden_House_03_F"]): {true};
		case (_buildingClassname in ["Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F"]): {true};
		case (_buildingClassname in ["Land_i_House_Small_02_b_blue_F","Land_i_House_Small_02_b_brown_F","Land_i_House_Small_02_b_pink_F","Land_i_House_Small_02_b_white_F","Land_i_House_Small_02_b_whiteblue_F","Land_i_House_Small_02_b_yellow_F"]): {true};
		case (_buildingClassname in ["Land_i_House_Small_03_V1_F"]): {true};
		case (_buildingClassname in ["Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V3_F"]): {true};
		case (_buildingClassname in ["Land_Addon_04_F"]): {true};
		case (_buildingClassname in ["Land_ALF_AppartementDroite","Land_ALF_AppartementGauche"]): {true};
		case (_buildingClassname in ["Land_ALF_MaisonMetal","Land_ALF_MaisonMetal_Blanc","Land_ALF_MaisonMetal_Verte","Land_ALF_MaisonMetal_Rouge","Land_ALF_MaisonMetal_Grise"]): {true};
		case (_buildingClassname in ["Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_House_Big_02_F","Land_i_House_Big_02_b_blue_F","Land_i_House_Big_02_b_white_F","Land_i_House_Big_02_b_whiteblue_F","Land_i_House_Big_02_b_yellow_F","Land_i_House_Big_02_b_brown_F","Land_i_House_Big_02_b_pink_F"]): {true};
		case (_buildingClassname in ["Land_HouseA","Land_HouseB","Land_HouseC","Land_HouseD"]): {true};
		case (_buildingClassname in ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_House_Big_03_F","Land_House_Big_04_F","Land_i_House_Big_01_b_white_F","Land_i_House_Big_01_b_brown_F","Land_i_House_Big_01_b_blue_F","Land_i_House_Big_01_b_whiteblue_F","Land_i_House_Big_01_b_pink_F","Land_i_House_Big_01_b_yellow_F"]): {true};
		case (_buildingClassname in ["Land_Hotel_02_F"]): {true};
		case (_buildingClassname in ["Land_ALF_MaisonMitoyenne","Land_ALF_MaisonMitoyenne1","Land_Residence_A_1","Land_Residence_A_2","Land_Residence_A_3"]): {true};
		case (_buildingClassname in ["Land_ALF_MaisonModerne","Land_ALF_MaisonModerne_Blanc","Land_ALF_MaisonModerne_Verte","Land_ALF_MaisonModerne_Rouge","Land_ALF_MaisonModerne_Grise"]): {true};
		case (_buildingClassname in ["Land_entreprise1","Land_Hangar2","Land_Garage","Land_Garage2","Land_Residence_A_3","Land_Residence_A_2","Land_ALF_MaisonContemporaine"]): {true};
		case (_buildingClassname in ["ALF_MaisonParadise"]): {true};
		case (_buildingClassname in ["Land_ALF_Villa_F"]): {true};
		case (_buildingClassname in ["Land_i_Shed_Ind_F","Land_SM_01_shed_F","Land_Hangar2","Land_entreprise1"]): {true};
		case (_buildingClassname in ["Land_ALF_NightClub"]): {true};
		case (_buildingClassname in ["Land_MRP_mm_Luxury"]): {true};
		default {false};
	};
	
	if (!_isBuyableHouse) then {
		continue; // Ce n'est pas une maison achetable
	};
	
	// Vérifier si le bâtiment a des portes
	private _numberOfDoors = getNumber(configFile >> "CfgVehicles" >> _buildingClassname >> "numberOfDoors");
	if (_numberOfDoors > 0 && _numberOfDoors != -1) then {
		// Fermer toutes les portes
		for "_i" from 1 to _numberOfDoors do {
			_building animateSource [format ["Door_%1_sound_source",_i],0];
			_building animate [format ["Door_%1",_i],0];
		};
		
		// Définir la variable ALF_PorteFermer
		_building setVariable ["ALF_PorteFermer",true,true];
		_countLocked = _countLocked + 1;
		
		// Petit délai pour éviter de surcharger le serveur
		if (_countLocked % 100 == 0) then {
			sleep 0.1;
		};
	};
} forEach _allBuildings;

diag_log format["================================== ALL BUYABLE HOUSES LOCKED (%1 houses) ==================================", _countLocked];
