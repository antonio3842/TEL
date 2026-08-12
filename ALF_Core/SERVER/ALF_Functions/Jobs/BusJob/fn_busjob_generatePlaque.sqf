/*
    Server — generation plaque bus de service (fallback si MRPV2 client indisponible).
*/
private _plaque = "";
if (!isNil "MRPV2_fnc_Vehicule_Creation_Plaque") then {
    _plaque = [] call MRPV2_fnc_Vehicule_Creation_Plaque;
};

if (!(_plaque isEqualType "") || {_plaque isEqualTo ""}) then {
    private _lettres = ["A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","V"];
    private _chiffres = ["0","1","2","3","4","5","6","7","8","9"];
    _plaque = [
        selectRandom _lettres, selectRandom _lettres, "-",
        selectRandom _chiffres, selectRandom _chiffres, selectRandom _chiffres, "-",
        selectRandom _lettres, selectRandom _lettres
    ] joinString "";
};

_plaque
