/*
    [_siret, _montant] call ALF_Server_fnc_withdrawBusinessCapital
    Renvoie TRUE si ok
*/

//ALF_Server_fnc_withdrawBusinessCapital = {


params ["_siret","_montant"];

private _capital = [_siret] call ALF_Server_fnc_getBusinessCapital;

if (_capital < _montant) exitWith {false};

private _new = _capital - _montant;

// utilise ta fonction EXISTANTE :
[_siret, _new] call ALF_Server_fnc_capitalBusiness;

true

//};
