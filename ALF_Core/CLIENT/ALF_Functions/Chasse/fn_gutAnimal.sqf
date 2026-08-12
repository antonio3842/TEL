#include "\ALF_Client\script_macros.hpp"
/*
    File: fn_gutAnimal.sqf
    Adapt ALF: donne uniquement des items réels (magazines) selon l’animal
    → 2 items : ALF_diamant_taille et ALF_diamant, quantités paramétrables
*/
private ["_animalCorpse","_upp","_ui","_progress","_pgText","_cP","_displayName","_loot"];
_animalCorpse = param [0,objNull,[objNull]];
if (isNull _animalCorpse) exitWith {};

life_interrupted = false;
if (player distance _animalCorpse > 3.5) exitWith {};
life_action_inUse = true;

// --------------------------------------------------------------------
// Mapping animal → magazines réels + quantités (éditer ici)
// --------------------------------------------------------------------
switch (typeOf _animalCorpse) do {
    case "Hen_random_F":   { _displayName = localize "STR_ANIM_chicken"; _loot = [["peau_mouton",1],["MRP_Blanc_Poulet",1]]; };
    case "Cock_random_F":  { _displayName = localize "STR_ANIM_Rooster"; _loot = [["peau_mouton",1],["MRP_Blanc_Poulet",1]]; };
    case "Goat_random_F":  { _displayName = localize "STR_ANIM_Goat";    _loot = [["peau_mouton",1],["MRP_Cote_agneau",2]]; };
    case "Sheep_random_F": { _displayName = localize "STR_ANIM_Sheep";   _loot = [["peau_mouton",1],["MRP_Cote_agneau",1]]; };
    case "Rabbit_F":       { _displayName = localize "STR_ANIM_Rabbit";  _loot = [["peau_lapin",1],["MRP_viande_lapin",0]]; };
    default { _displayName = ""; _loot = []; };
};
if (_displayName isEqualTo "" || {count _loot isEqualTo 0}) exitWith { life_action_inUse = false; };

// --------------------------------------------------------------------
// Barre de progression
// --------------------------------------------------------------------
_upp = format[localize "STR_NOTF_Gutting", _displayName];
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = GVAR_UINS "life_progress";
_progress = _ui displayCtrl 38201;
_pgText   = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;

for "_i" from 0 to 1 step 0 do {
    if (animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
        player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
        player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
    };
    uiSleep 0.15;
    _cP = _cP + 0.01;
    _progress progressSetPosition _cP;
    _pgText ctrlSetText format["%3 (%1%2)...", round(_cP * 100), "%", _upp];
    if (_cP >= 1) exitWith {};
    if (!alive player) exitWith {};
    if (isNull _animalCorpse) exitWith {};
    if (player != vehicle player) exitWith {};
    if (life_interrupted) exitWith {};
};

life_action_inUse = false;
5 cutText ["","PLAIN"];
player playActionNow "stop";

if (isNull _animalCorpse) exitWith { life_action_inUse = false; };
if (life_interrupted) exitWith { life_interrupted = false; titleText [localize "STR_NOTF_ActionCancel","PLAIN"]; life_action_inUse = false; };
if (player != vehicle player) exitWith { titleText [localize "STR_NOTF_ActionInVehicle","PLAIN"]; };

// --------------------------------------------------------------------
// Ajout des magazines (2 items + quantités)
// --------------------------------------------------------------------
private _dropped = [];
private _holder = objNull;

{
    private _class = _x#0;
    private _qty   = _x#1 max 0;
    if (_qty <= 0) then {continue};

    private _added = 0;
    for "_i" from 1 to _qty do {
        if (player canAdd _class) then {
            player addMagazine _class;
            _added = _added + 1;
        } else {
            if (isNull _holder) then {
                private _pos = player modelToWorld [0,1,0];
                _holder = createVehicle ["GroundWeaponHolder_Scripted", _pos, [], 0, "CAN_COLLIDE"];
            };
            _holder addMagazineCargoGlobal [_class,1];
            _dropped pushBack _class;
        };
    };

    if (_added > 0) then {
        systemChat format ["Vous avez reçu %1× %2.", _added, _class];
    };
} forEach _loot;

if (!isNull _holder) then {
    // petit regroupement par classe pour un feedback lisible
    private _byClass = [];
    {
        private _idx = _byClass findIf { (_x#0) isEqualTo _x };
        if (_idx < 0) then { _byClass pushBack [_x,1]; } else { _byClass set [_idx, [(_byClass#_idx)#0, ((_byClass#_idx)#1)+1]]; };
    } forEach _dropped;

    {
        hintSilent format ["Inventaire plein : %1× %2 déposés au sol.", _x#1, _x#0];
        uiSleep 0.6;
    } forEach _byClass;
};

deleteVehicle _animalCorpse;
titleText [format[(localize "STR_NOTF_Guttingfinish"), _displayName], "PLAIN"];
