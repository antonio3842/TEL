// MA_fnc_finFumee.sqf
// Exécuté côté client

player setVariable ["MA_inGasCloud", false];

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 10;
resetCamShake;