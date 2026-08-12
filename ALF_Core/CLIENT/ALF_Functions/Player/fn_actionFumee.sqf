// ALF_fnc_actionFumee.sqf
// Exécuté côté client du joueur affecté

params [["_unit", objNull],["_mode", 0]];

if (isNull _unit || {_unit != player}) exitWith {};

// --- Liste des masques à gaz protecteurs ---
private _gasMasks = [
    "KA_MCU"
];

private _hasMask = (headgear player) in _gasMasks || {(goggles player) in _gasMasks};
if (_hasMask) exitWith {};

if (player getVariable ["MA_inGasCloud", false]) exitWith {};
player setVariable ["MA_inGasCloud", true];


[] spawn {
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [7];
	"dynamicBlur" ppEffectCommit 2;
	enableCamShake true;

	for "_i" from 1 to 3 do {
		if (random 1 < 0.4) then {
			playSound3D ["MRP_Incendie\sounds\tousser.ogg", player, false, getPosASL player, 3, 1, 10];
		};
		sleep 3;
	};

	player setVariable ["MA_inGasCloud", false];
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 7;
	resetCamShake;
};