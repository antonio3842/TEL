#include "\ALF_Client\script_macros.hpp"
//ALF_fnc_copQuestionDealer = {



if (!dialog) then {
    createDialog "ALF_QBRICO_Dialog";
};
disableSerialization;

private _display = findDisplay 12000;
if (isNull _display) exitWith {};

private _list = _display displayCtrl 12001;
lbClear _list;


private _dealer = uiNamespace getVariable ["current_dealer", objNull];

if (isNull _dealer) exitWith {
    _list lbAdd "Je... je ne sais plus qui c’était, je le jure !";
};


private _stress = _dealer getVariable ["stress_level", -1];
private _last   = _dealer getVariable ["stress_last_update", 0];
private _now    = time;
private _step   = 13 * 60;


if (_stress < 0) then {

    _stress = floor (random 5);

    _dealer setVariable ["stress_level", _stress, true];
    _dealer setVariable ["stress_last_update", _now, true];

} else {

    private _elapsed = _now - _last;

    if (_elapsed >= _step && _stress > 0) then {

        private _levelsDown = floor (_elapsed / _step);
        private _newStress = _stress - _levelsDown;

        if (_newStress < 0) then { _newStress = 0 };

        _stress = _newStress;
        _dealer setVariable ["stress_level", _stress, true];
        _dealer setVariable ["stress_last_update", _now, true];
    };

    if (_stress == 0 && (_now - _last) >= _step) then {

        _dealer setVariable ["stress_level", -1, true];
        _dealer setVariable ["stress_last_update", _now, true];

        _stress = floor (random 5);

        _dealer setVariable ["stress_level", _stress, true];
    };
};



private _var = _dealer getVariable ["info", []];

if (_var isEqualTo [] || {count _var isEqualTo 0}) then {
    _list lbAdd "Je n'ai rien à vous dire, je le jure.";
} else {


    switch (_stress) do {
        case 0: {
            {
                private _heure = _x select 0;
                private _item  = _x select 1;
                private _adn   = _x select 2;

                _list lbAdd format [
                    "%1 — %2 — ADN complet : %3",
                    _heure, _item, _adn
                ];
            } forEach _var;
        };


        case 1: {
            {
                private _heure = _x select 0;
                private _item  = _x select 1;
                private _adn   = _x select 2;

                private _adnMasked = (_adn select [0,5]) + "***";

                _list lbAdd format [
                    "%1 — %2 — ADN partiel : %3",
                    _heure, _item, _adnMasked
                ];
            } forEach _var;
        };


        case 2: {
            {
                private _heure = _x select 0;
                private _item  = _x select 1;

                _list lbAdd format[
                    "%1 — %2...",
                    _heure, _item
                ];
            } forEach _var;
        };

        case 3: {
            {
                private _heure = _x select 0;

                _list lbAdd format[
                    "%1 — un type bizarre… j’sais plus...",
                    _heure
                ];
            } forEach _var;
        };

        case 4: {
            _list lbAdd "Je… je sais plus… je panique… je veux un avocat...";
        };
    };


    _list lbAdd "C'est tout ce dont je me rappelle...";
};



//};