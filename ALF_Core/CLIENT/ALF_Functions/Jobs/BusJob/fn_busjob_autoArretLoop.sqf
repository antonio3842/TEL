/*
    Fichier : fn_busjob_autoArretLoop.sqf
    Desc    : Validation automatique a l'arret — 3s immobile (compteur relance si reprise de route)
*/

params [["_bus", objNull, [objNull]]];

private _distArret = missionNamespace getVariable ["MRP_BusJob_ArretDist", 25];
private _distTol = missionNamespace getVariable ["MRP_BusJob_ArretDistTol", 3];
private _maxDist = _distArret + _distTol;
private _stopSpeed = 1.5;
private _waitSec = 3;

while {MRP_BusJob_EnService && {alive player}} do {
    uiSleep 0.2;

    if (!MRP_BusJob_EnService) exitWith {};
    if (MRP_BusJob_ValidationLock) then { continue };
    if (MRP_BusJob_ArretActuel >= count MRP_BusJob_Arrets) exitWith {};
    if (isNull _bus || {!alive _bus}) exitWith {};

    if (vehicle player != _bus) then {
        hintSilent "";
        continue;
    };

    if (!((driver vehicle player) isEqualTo player)) then {
        hintSilent "";
        continue;
    };

    private _arretData = MRP_BusJob_Arrets select MRP_BusJob_ArretActuel;
    private _pos = _arretData select 0;
    private _num = if (isNil "MRP_BusJob_ArretAffiche") then { MRP_BusJob_ArretActuel + 1 } else { MRP_BusJob_ArretAffiche };

    if (player distance _pos > _maxDist) then {
        hintSilent "";
        continue;
    };

    if (vectorMagnitude velocity _bus > _stopSpeed) then {
        hintSilent parseText format [
            "<t size='1.1' color='#F5C842'>BUS MRP</t><br/><t color='#FFFFFF'>Veuillez arreter le bus — Arret %1</t>",
            _num
        ];
        continue;
    };

    private _t0 = time;
    private _ready = false;

    while {MRP_BusJob_EnService && {!_ready}} do {
        uiSleep 0.1;

        if (!MRP_BusJob_EnService) exitWith {};
        if (isNull _bus || {!alive _bus}) exitWith {};
        if (vehicle player != _bus) exitWith {};
        if (!((driver vehicle player) isEqualTo player)) exitWith {};
        if (player distance _pos > _maxDist) exitWith {};
        if (MRP_BusJob_ArretActuel >= count MRP_BusJob_Arrets) exitWith {};

        private _speed = vectorMagnitude velocity _bus;

        if (_speed > _stopSpeed) then {
            _t0 = time;
            hintSilent parseText format [
                "<t size='1.1' color='#F5C842'>BUS MRP</t><br/><t color='#FFFFFF'>Veuillez arreter le bus — Arret %1</t>",
                _num
            ];
            continue;
        };

        private _elapsed = time - _t0;
        private _rest = _waitSec - _elapsed;
        if (_rest < 0) then { _rest = 0; };

        hintSilent parseText format [
            "<t size='1.1' color='#F5C842'>BUS MRP</t><br/><t color='#28FF66'>Arret %1</t><br/><t color='#FFFFFF'>Attente client... %2 s</t>",
            _num, ceil _rest
        ];

        if (_elapsed >= _waitSec) then {
            _ready = true;
        };
    };

    hintSilent "";

    if (!_ready) then { continue };

    if (!MRP_BusJob_EnService) exitWith {};
    if (vehicle player != _bus) then { continue };
    if (!((driver vehicle player) isEqualTo player)) then { continue };
    if (player distance _pos > _maxDist) then { continue };
    if (vectorMagnitude velocity _bus > _stopSpeed) then { continue };

    MRP_BusJob_ValidationLock = true;
    [] call ALF_fnc_busjob_validerArret;
    MRP_BusJob_ValidationLock = false;
    uiSleep 1;
};

hintSilent "";
