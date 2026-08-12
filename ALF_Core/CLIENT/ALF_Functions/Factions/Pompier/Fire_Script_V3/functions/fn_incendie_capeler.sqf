if ((player getVariable["byscream_incendie_bar",300]) == 0) exitWith {
	hint "Vous n'avez plus assez d'air dans la bouteille !";
};

"ByScream_Incendie_V3_ARI" cutRsc ["ByScream_Incendie_V3_ARI", "PLAIN", -1, false];

_masque = (["STRING", ["ByScream_Incendie_V3","ARI_mask_set"]] call ALFTools_Client_Config_fnc_getConfig);
player addGoggles _masque;
_display = uiNamespace getVariable ["ByScream_Incendie_V3_ARI", displayNull];

_ctrlImage = _display displayCtrl 1000;

_max_degree = 268;
_bar = player getVariable["byscream_incendie_bar",300];

_son = createSoundSource ["byscream_son_ari", getPos player, [], 0];
_son attachTo [player,[0,0,0]];
player setVariable ["byscream_son_ari",_son,true];

_exit = false;


_ari_allowed = ["ARRAY", ["ByScream_Incendie_V3","ARI"]] call ALFTools_Client_Config_fnc_getConfig;
_time_ari = 18*60;
{
    if ((_x select 0) isEqualTo (backpack player)) exitWith {
        _time_ari = call compile (_x select 1);
    };
} forEach _ari_allowed;
_time_ari = _time_ari/10;

while {(_son isNotEqualTo objNull) && !_exit} do {
    _bar = _bar - (300/_time_ari);
    if (_bar < 0) then {_bar = 0; _exit=true;[] spawn ALF_fnc_incendie_decapeler;};
	if ((goggles player isNotEqualTo _masque) || !(backpack player in ((["ARRAY", ["ByScream_Incendie_V3","ARI"]] call ALFTools_Client_Config_fnc_getConfig) apply {_x select 0}))) then {_exit = true; [] spawn ALF_fnc_incendie_decapeler;};
    player setVariable ["byscream_incendie_bar",_bar,true];
    _ctrlImage ctrlSetAngle [268*(_bar/300), 0.512, 0.209, true];
    uiSleep 10;
};
