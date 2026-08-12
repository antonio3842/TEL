/*
    File: fn_BusinessstoreVehicle.sqf
    Author: Nanou
*/
/*
private _owner = _this select 0;
private _vehicle = objNull;
_nearVehicles = (position player) nearEntities [["Car","Air","Ship"],130];
if !(count _nearVehicles isEqualTo 0) then {
    {
        private _vehData = _x getVariable ["business_veh",[]];
        if(count _vehData  > 0) exitWith {
            _vehicle = _x;
        };
    } forEach _nearVehicles;
};

if(isNull _vehicle) exitWith {["INFO","Aucun véhicule d'entreprise.","warning"] spawn ALF_fnc_doMsg;};
if(!alive _vehicle) exitWith {["INFO","Le véhicule est mort.","warning"] spawn ALF_fnc_doMsg;};

[_vehicle,player] remoteExec ["ALF_Server_fnc_vehicleStoreBusiness",2];
*/


//ALF_fnc_BusinessStoreVehicle = {

private _owner = _this select 0;


private _blacklistedItems = [
    "ALF_C4",//illegale
    "ALF_Pc",
    "ALF_Badge_b",
    "ALF_Lockpick",
    "ALF_Lockpick2",
    "ALF_ZipTies",
    "ALF_Utility_Box_2_boite",
    "ALF_Headbag",
    "ALF_PortableLight_double",
    "ALF_PortableLight_single",
    "ALF_BagFence_Round",
    "ALF_BagFence_Long",
    "KA_MCU",
    "ALF_Perceuse_GDM_M",
    "KA_Glock_18_Single",
    "KA_17Rnd_9x19_Mag",
    "AEK_919K",
    "20Rnd_9x18_Mag",
    "ALF_W_AKS",
    "ALF_30Rnd_545x39_Mag_Tracer_F",
    "hlc_smg_mp5k",
    "hlc_30Rnd_9x19_B_MP5",
    "hgun_PDW2000_F",
    "30Rnd_9x21_Mag",
    "KICKASS_Sawed_Off_Shotgun",
    "KICKASS_2Rnd_Sawed_Off_Shotgun_Pellets",
    "KA_RO991",
    "KA_32Rnd_9x19_FMJ_Mag",
    "ALF_Pseudoephedrine",
    "Table_weed_boite",
    "ALF_Plante_W_2_Boite",
    "ALF_Cocaine_U",
    "ALF_Coco_boite",
    "ALF_cle_1",
    "RH_fn57",
    "RH_20Rnd_57x28_FN",
    "KA_Glock_18",
    "KA_Glock_17_Single",
    "Desert_Eagle",
    "7Rnd_50_AE",
    "ALF_RH_tec9",
    "ALF_RH_32Rnd_9x19_tec",
    "KA_MP7_Rifle_Black_20Rnd",
    "KA_MP7_Rifle_Green_20Rnd",
    "KA_20Rnd_46x30_FMJ",
    "KA_MP7_Rifle_Black_40Rnd",
    "KA_MP7_Rifle_Green_40Rnd",
    "KA_40Rnd_46x30_FMJ",
    "ALF_KA_PP19_MTK83",
    "ALF_KA_64Rnd_9x18_PMM_FMJ_Mag",
    "ALF_SMG_01_F",
    "ALF_30Rnd_45ACP_Mag_SMG_01",
    "Mossberg_590",
    "8Rnd_Mossberg_590_Pellets",
    "KA_SPAS12",
    "8Rnd_SPAS12_buck",
    "ALF_SMG_01_F",
    "ALF_30Rnd_45ACP_Mag_SMG_01",
    "arifle_AKS_F",
    "30Rnd_545x39_Mag_F",
    "KA_SG_552_Black",
    "KA_SIG_30rnd_Mk318_SOST_mag",
    "KA_M4A1_F",
    "KA_Original_Sight_Carry_Handle",
    "KA_Original_Sight_Flip_Up_Sight",
    "KA_30Rnd_556x45_M855",
    "Hand_Guard_Rail",
    "Hand_Guard_Rail_Covers",
    "Hand_Guard_Rail_Flashlight_Black",
    "Round_Hand_Guard",
    "103_Inches_Barrel",
    "103_Inches_Barrel_Flash_Hider",
    "145_Inches_Barrel",
    "145_Inches_Barrel_Bayonet",
    "145_Inches_Barrel_Flash_Hider",
    "ATG_Grip_MOE_Grip_MOE_Stock_Black",
    "ATG_Grip_Original_Grip_Lightweight_Stock",
    "ATG_Grip_Original_Grip_Original_Stock",
    "MOE_Grip_MOE_Stock_Black",
    "MOE_Stock_Lightweight_Stock_Black",
    "MVG_Grip_MOE_Grip_MOE_Stock_Black",
    "Original_Grip_M16_Stock",
    "Original_Grip_Original_Stock",
    "Vertical_Grip_MOE_Grip_MOE_Stock_Black",
    "Vertical_Grip_Original_Grip_Original_Stock",
    //legal
    "MRP_Sushi_Thon",
    "MRP_Sushi_Saumon",
    //  Agriculture
    "ALF_Mais",
    "ALF_Mais_Traitement",
    "ALF_Banane",
    "ALF_Peche",
    "ALF_Raisin",
    "ALF_Fraise",
    "ALF_Champignon",
    "ALF_Truffe",
    // Jus & transformation fruits
    "ALF_Confiture_Pomme",
    "ALF_Confiture_Fraise",
    "ALF_Jus_Pomme",
    "ALF_Jus_Fraise",
    "ALF_Jus_Raisin",
    //  Bois & dérivés
    "ALF_Buche",
    "ALF_Planche_B",
    //  Pierres & métaux
    "ALF_pierre_small",
    "ALF_Cuivre",
    "ALF_Fer",
    "ALF_Bronze",
    "ALF_Argent",
    "ALF_Or",
    // Pierres précieuses
    "ALF_diamant_taille",
    "ALF_diamant_precieux",
    "ALF_saphir_taille",
    //  Poissons & mer
    "ALF_Maquereau_Crue_M",
    "ALF_Maquereau_Cuit_M",
    "ALF_Sardine",
    "ALF_Barbeau",
    "ALF_Thon",
    "ALF_Saumon",
    "ALF_Brochet",
    "ALF_Anguille",
    "ALF_Huitre",
    "Carapace_Tortue",
    "Viande_Tortue",
    "ALF_Squale",
    //  Boucherie
    "MRP_Blanc_Poulet",
    "MRP_Cote_agneau",
    "MRP_viande_lapin",
    //  Alcool & produits fermentés
    "ALF_Whisky",
    "ALF_XxX",
    "ALF_Vin",
    "ALF_Pinot",
    "carton_rhum",
    "bouteille_rhum",
    //  Pétrole & dérivés
    "ALF_Barile_P_F",
    "ALF_Barile_Station",
    "ALF_Caoutchou",
    // Tabac
    "murshun_cigs_cig0",
    "ALF_Tabac_Seche",
    //  Objets exportation
    "MRP_Palette",
    "MRP_Linteau_x6",
    "MRP_Carton_Compote",
    "sable",
    "Verre_plat",
    "MRP_IPN_x6",
    // Drogues & illégal
    "ALF_Weed",
    "ALF_Weed_2",
    "ALF_Weed_3",
    "ALF_Weed_P",
    "ALF_Weed_P_2",
    "ALF_Weed_P_3",
    "ALF_Relique_1",
    "ALF_Relique_2",
    "ALF_Relique_3",
    "ALF_Cupidon",
    "ALF_Cocaine",
    "ALF_Cocaine_2",
    "ALF_Meth50",
    "ALF_Meth90",
    //Matiere premiere
    "ALF_Pierre_cui_small",
    "ALF_pierre_fer_small",
    "ALF_Pepite_Or",
    "ALF_saphir_small",
    "ALF_pierre_dia_small",
    "ALF_pierre_small"
];

private _vehicle = objNull;
private _nearVehicles = (position player) nearEntities [["Car","Air","Ship"],130];

_nearVehicles = _nearVehicles apply { [_x, player distance _x] };
_nearVehicles sort true;
_nearVehicles = _nearVehicles apply { _x select 0 };

{
    private _vehData = _x getVariable ["business_veh",[]];
    if (count _vehData > 0) exitWith { _vehicle = _x; };
} forEach _nearVehicles;

if (isNull _vehicle) exitWith {
    ["INFO","Aucun véhicule d'entreprise à proximité.","warning"] spawn ALF_fnc_doMsg;
};

if (!alive _vehicle) exitWith {
    ["INFO","Le véhicule est détruit.","warning"] spawn ALF_fnc_doMsg;
};

private _items      = getItemCargo _vehicle;
private _mags       = getMagazineCargo _vehicle;
private _weapons    = getWeaponCargo _vehicle;
private _containers = getBackpackCargo _vehicle;

private _cargoClassnames =
    (_items select 0) +
    (_mags select 0) +
    (_weapons select 0) +
    (_containers select 0);

private _excludedUniforms  = [];
private _excludedVests     = ["V_Safety_yellow_F", "V_Safety_orange_F"];
private _excludedBackpacks = ["B_parachute"];

private _isUniform = {
    params ["_class"];
    (getNumber (configFile >> "CfgWeapons" >> _class >> "ItemInfo" >> "type")) == 801
    && !(_class in _excludedUniforms)
};

private _isVest = {
    params ["_class"];
    (getNumber (configFile >> "CfgWeapons" >> _class >> "ItemInfo" >> "type")) == 701
    && !(_class in _excludedVests)
};

private _isBackpack = {
    params ["_class"];
    (
        (getText (configFile >> "CfgVehicles" >> _class >> "vehicleClass")) == "Backpacks"
        || { _class isKindOf "Bag_Base" }
    )
    && !(_class in _excludedBackpacks)
};

private _sacsInside   = _cargoClassnames select { [_x] call _isBackpack };
private _tenuesInside = _cargoClassnames select { [_x] call _isUniform  };
private _giletsInside = _cargoClassnames select { [_x] call _isVest     };


private _canStore = true;

if (_sacsInside isNotEqualTo [] && _canStore) then {
    ["INFO","Impossible de ranger : un sac est présent dans le coffre.","warning"] spawn ALF_fnc_doMsg;
    _canStore = false;
};

if (_tenuesInside isNotEqualTo [] && _canStore) then {
    ["INFO","Impossible de ranger : une tenue est présente dans le coffre.","warning"] spawn ALF_fnc_doMsg;
    _canStore = false;
};

if (_giletsInside isNotEqualTo [] && _canStore) then {
    ["INFO","Impossible de ranger : un gilet est présent dans le coffre.","warning"] spawn ALF_fnc_doMsg;
    _canStore = false;
};

if (_canStore) then {
    private _forbidden = _cargoClassnames select { _x in _blacklistedItems };
    if (_forbidden isNotEqualTo []) then {
        ["INFO","Impossible de ranger : ce véhicule contient des objets interdits.","warning"] spawn ALF_fnc_doMsg;
        _canStore = false;
    };
};

if (!_canStore) exitWith {};


[_vehicle, player] remoteExec ["ALF_Server_fnc_vehicleStoreBusiness", 2];
["INFO","Véhicule d'entreprise rangé avec succès.","success"] spawn ALF_fnc_doMsg;

//};
