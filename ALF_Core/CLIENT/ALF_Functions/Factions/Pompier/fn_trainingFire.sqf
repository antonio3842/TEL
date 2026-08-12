/*
	trainingFire
*/

/*
ALF_fnc_trainingFire = {

if(life_medicLevel < 5) exitWith {["INFO","Vous n'avez pas le grade pour demarrer un incendie d'entrainement.","warning"] spawn ALF_fnc_doMsg;};

private _h = nearestObjects [position player, ["Land_i_House_Big_01_V1_F"],5000];
private _hs = selectRandom _h;

if(_hs getVariable ["trainingfire",false]) exitWith {["INFO","Un incendie d'entrainement est deja en cours.","warning"] spawn ALF_fnc_doMsg;};
_hs setVariable ["trainingfire",true,true];

private _f1 = "test_EmptyObjectForFireBig" createVehicle [0,0,0];
_f1 setPosATL (_hs modelToWorld [-2,2,0.85]);
_f1 setVariable ["firealf",150,true];

private _f2 = "test_EmptyObjectForFireBig" createVehicle [0,0,0];
_f2 setPosATL (_hs modelToWorld [-4.5,-2.9,0.88]);
_f2 setVariable ["firealf",150,true];

private _f3 = "test_EmptyObjectForFireBig" createVehicle [0,0,0];
_f3 setPosATL (_hs modelToWorld [0,-5.5,-2.6]);
_f3 setVariable ["firealf",150,true];

private _f4 = "test_EmptyObjectForFireBig" createVehicle [0,0,0];
_f4 setPosATL (_hs modelToWorld [2.6,4.8,-2.6]);
_f4 setVariable ["firealf",150,true];

["ENTRAINEMENT","L'EXERCICE INCENDIE EST COMMENCE !!"] remoteExecCall ["ALF_Server_fnc_doMedCall",2];
};
*/


if (life_medicLevel < 5) exitWith {  
    ["INFO", "Vous n'avez pas le grade pour démarrer un incendie d'entraînement.", "warning"] spawn ALF_fnc_doMsg;  
};  
  
private _h = nearestObjects [position player, ["Land_i_House_Big_01_V1_F"], 5000];  
if (_h isEqualTo []) exitWith {  
    ["INFO", "Aucun bâtiment d'entraînement trouvé à proximité.", "warning"] spawn ALF_fnc_doMsg;  
};  
  
private _hs = selectRandom _h;  
  
if (_hs getVariable ["trainingfire", false]) exitWith {  
    ["INFO", "Un incendie d'entraînement est déjà en cours.", "warning"] spawn ALF_fnc_doMsg;  
};  
_hs setVariable ["trainingfire", true, true];    

private _fireData = [  
    [[-2, 2, 2.9], "Feu 1"],  
    [[-2.5, -2.9, 2.9], "Feu 2"],  
    [[0.5, -5.5, -2.6], "Feu 3"],  
    [[2.6, 4.8, -2.6], "Feu 4"]  
];  
  
{  
    private _posRel = _x#0;  
    private _id = _x#1;  
  
    private _fire = "test_EmptyObjectForFireBig" createVehicle [0, 0, 0];  
    _fire setPosATL (_hs modelToWorld _posRel);  
    _fire setVariable ["firealf", 150, true];  
    _fire setVariable ["fireID", _id];  
} forEach _fireData;  
  
private _markerName = format ["training_marker_%1", round(random 10000)];  
private _posMarker = getPosATL _hs;  
  
private _marker = createMarkerLocal [_markerName, _posMarker];  
_marker setMarkerColorLocal "ColorRed";  
_marker setMarkerTypeLocal "hd_warning";  
_marker setMarkerTextLocal "Entraînement incendie";  
_hs setVariable ["training_marker", _markerName];  
  
[_markerName] spawn {  
    params ["_m"];  
    sleep 600;  
    deleteMarkerLocal _m;  
};  
  
["ENTRAINEMENT", "L'EXERCICE INCENDIE EST COMMENCÉ !!"] remoteExecCall ["ALF_Server_fnc_doMedCall", 2];
