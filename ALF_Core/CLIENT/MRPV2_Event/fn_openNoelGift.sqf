/*
    Fichier : core\noel\fn_openNoelGift.sqf
    100% CLIENT
    Récompenses = ITEMS + CASH uniquement
*/


params ["_giftItem"];
if (_giftItem isEqualTo "") exitWith {};

// =============================
// ✅ CONFIG LISTE DES RÉCOMPENSES
// =============================
// FORMAT : ["TYPE","VALEUR",POIDS]

private _lootTable = [
    // ===== ITEMS =====
    ["ITEM", "bouteille_rhum", 20],
    ["ITEM", "ALF_Weed_3", 10],
    ["ITEM", "ALF_Cocaine_2", 10],
    ["ITEM", "ALF_diamant_taille", 20],
    ["ITEM", "ALF_saphir_taille", 20],
    ["ITEM", "ALF_Squale", 10],
    ["ITEM", "Viande_Tortue", 10],
    ["ITEM", "ALF_Whisky", 20],
    ["ITEM", "ALF_Vin", 20],
    ["ITEM", "ALF_Pinot", 20],
    ["ITEM", "KA_Glock_18_Single", 5],
    ["ITEM", "KA_17Rnd_9x19_Mag", 5],
    ["ITEM", "KA_Glock_17_Single", 5],
    ["ITEM", "KA_17Rnd_9x19_Mag", 5],
    ["ITEM", "ALF_snickers", 25],
    ["ITEM", "ALF_Bonbon", 25],
    ["ITEM", "ALF_WaterB_P", 25],
    ["ITEM", "ALF_Expresso", 25],
    ["ITEM", "MRP_Item_O2_plug", 25],
    ["ITEM", "Poppers", 25],
    ["ITEM", "Wojda_dor", 10],
    ["ITEM", "MRP_Item_O2_Lulu", 25],

    // ===== CASH =====
    ["CASH", 10000, 20],
    ["CASH", 25000, 10],
    ["CASH", 100000, 5]
];

// =============================
// ✅ TIRAGE ALÉATOIRE PONDÉRÉ
// =============================

private _total = 0;
{ _total = _total + (_x select 2); } forEach _lootTable;

private _rand = random _total;
private _current = 0;
private _reward = [];

{
    _current = _current + (_x select 2);
    if (_rand <= _current) exitWith { _reward = _x; };
} forEach _lootTable;

if (_reward isEqualTo []) exitWith {
    ["INFO","Erreur récompense cadeau.","danger"] spawn ALF_fnc_doMsg;
};

// =============================
// ✅ SUPPRESSION DU CADEAU
// =============================

if !(player removeItem _giftItem) exitWith {
    ["INFO","Impossible d'ouvrir le cadeau.","warning"] spawn ALF_fnc_doMsg;
};

// =============================
// ✅ ATTRIBUTION RÉCOMPENSE
// =============================

private _type  = _reward select 0;
private _value = _reward select 1;

switch (_type) do {

    // ================= ITEM =================
    case "ITEM": {
        if (player canAdd _value) then {
            player addItem _value;
            ["INFO", format ["🎁 Tu as reçu : %1", _value], "success"] spawn ALF_fnc_doMsg;
        } else {
            player addItem _giftItem; // on rend le cadeau
            ["INFO","🎒 Inventaire plein !","warning"] spawn ALF_fnc_doMsg;
        };
    };

    // ================= CASH =================
    case "CASH": {
        life_cash = life_cash + _value;
        ["INFO", format ["💶 Tu as reçu %1 €", _value], "success"] spawn ALF_fnc_doMsg;
    };
};

