params [
	["_newPression",0,[0]]
];

if (_newPression == 0) exitWith {
	if (byscream_vehicle_pompe getVariable ["byscream_incendie_pression",0] >= 3) then {
		_son = byscream_vehicle_pompe getVariable ["byscream_incendie_pression_son",objNull];
		deleteVehicle _son;
		byscream_vehicle_pompe setVariable ["byscream_incendie_pression_son",nil,true];
		byscream_vehicle_pompe setVariable ["byscream_incendie_pression",0,true];
		((findDisplay 15651) displayCtrl 1002) ctrlSetText format["%1 bars",0];
	} else {
		_son = createSoundSource ["byscream_800rpm", position byscream_vehicle_pompe, [], 0];
		_son attachTo [byscream_vehicle_pompe];
		byscream_vehicle_pompe setVariable ["byscream_incendie_pression_son",_son,true];
		byscream_vehicle_pompe setVariable ["byscream_incendie_pression",3,true];
		((findDisplay 15651) displayCtrl 1002) ctrlSetText format["%1 bars",3];
	};
	
};

if (byscream_vehicle_pompe getVariable ["byscream_incendie_pression",0] == 0) exitWith {
	hint "La pompe n'est pas allumée !";
};

if ((_newPression == 1) && (byscream_vehicle_pompe getVariable ["byscream_incendie_pression",0] == 9)) exitWith {
	hint "La pression est au maximum !";
};
if ((_newPression == -1) && (byscream_vehicle_pompe getVariable ["byscream_incendie_pression",0] == 3)) exitWith {
	hint "La pression est au minimum !";
};

_pression = byscream_vehicle_pompe getVariable ["byscream_incendie_pression",0];
_new_pression = _pression + _newPression;
byscream_vehicle_pompe setVariable ["byscream_incendie_pression",_new_pression,true];
_son = byscream_vehicle_pompe getVariable ["byscream_incendie_pression_son",objNull];
deleteVehicle _son;
switch (_new_pression) do {
	case 3: {_son = createSoundSource ["byscream_800rpm", position byscream_vehicle_pompe, [], 0];};
	case 4: {_son = createSoundSource ["byscream_1000rpm", position byscream_vehicle_pompe, [], 0];};
	case 5: {_son = createSoundSource ["byscream_1200rpm", position byscream_vehicle_pompe, [], 0];};
	case 6: {_son = createSoundSource ["byscream_1500rpm", position byscream_vehicle_pompe, [], 0];};
	case 7: {_son = createSoundSource ["byscream_1700rpm", position byscream_vehicle_pompe, [], 0];};
	case 8: {_son = createSoundSource ["byscream_1900rpm", position byscream_vehicle_pompe, [], 0];};
	case 9: {_son = createSoundSource ["byscream_2100rpm", position byscream_vehicle_pompe, [], 0];};
	default {hint "Erreur"};
};
byscream_vehicle_pompe setVariable ["byscream_incendie_pression_son",_son,true];
_son attachTo [byscream_vehicle_pompe];
((findDisplay 15651) displayCtrl 1002) ctrlSetText format["%1 bars",_new_pression];