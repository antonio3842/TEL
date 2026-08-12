// MRPV2_fnc_Vehicule_Garage_Liste = {
disableSerialization;
private _vehs_Non_Fourriere = param [0,[]];
private _vehs_Fourriere = param [1,[]];


ctrlShow[2804,false];
ctrlShow[2830,false];
waitUntil {sleep 0.2; !isNull (findDisplay 2800)};

private _d = findDisplay 2800;
private _btnassu = _d displayCtrl 97480;
private _btnassupro = _d displayCtrl 97481;
private _btntransfert = _d displayCtrl 97484;
private _btnsortir = _d displayCtrl 97482;
private _btnvendre = _d displayCtrl 97483;
_btnassu ctrlShow false;
_btnassupro ctrlShow false;
_btntransfert ctrlShow false;
_btnsortir ctrlShow false;
_btnvendre ctrlShow false;

if (_vehs_Non_Fourriere isEqualTo [] AND {_vehs_Fourriere isEqualTo []}) exitWith {ctrlSetText[2811,localize "STR_Garage_NoVehicles"];};

private _control = ((findDisplay 2800) displayCtrl 2802);
lbClear _control;

{
	private _id = _x # 0;
	private _classeName = _x # 1;
	private _alive = _x # 2;
	private _active = _x # 3;
	private _plaque = _x # 4;
	private _pos = _x # 5;
	private _fuel = _x # 6;
	private _type_Assurance = _x # 7;
	private _nb_Sinistre = _x # 8;
	private _en_Fourriere = _x # 9;
	private _tp_Fourriere = _x # 10;
	private _degats = _x # 11;
	private _vehicleInfo = [_classeName] call ALF_fnc_fetchVehInfo;

	private _img = _vehicleInfo # 2;
	private _kyle_cars_truc = _vehicleInfo # 3;
	_control lbAdd _kyle_cars_truc;
	_control lbSetData [(lbSize _control)-1,(str([_classeName,_alive,_active,_plaque,_pos,_fuel,_type_Assurance,_nb_Sinistre,_en_Fourriere,_tp_Fourriere,_degats]))];
	_control lbSetPicture [(lbSize _control)-1,_img];
	_control lbSetValue [(lbSize _control)-1,_id];
} forEach _vehs_Non_Fourriere;
lbSort _control;

ctrlShow[2810,false];
ctrlShow[2811,false];
ctrlShow[97480,false];

if (_vehs_Fourriere isEqualTo []) exitWith {};

_index = _control lbAdd "";
_control lbSetData [_index,"affichage"];
_index = _control lbAdd toupper "\\\\\\\\fourrière\\\\\\\\\\";
_control lbSetData [_index,"affichage"];
_index = _control lbAdd "";
_control lbSetData [_index,"affichage"];

_vehs_Fourriere = [_vehs_Fourriere,[],{([_x # 1] call ALF_fnc_fetchVehInfo) # 3},"ASCEND"] call BIS_fnc_sortBy;

{
	private _id = _x # 0;
	private _classeName = _x # 1;
	private _alive = _x # 2;
	private _active = _x # 3;
	private _plaque = _x # 4;
	private _pos = _x # 5;
	private _fuel = _x # 6;
	private _type_Assurance = _x # 7;
	private _nb_Sinistre = _x # 8;
	private _en_Fourriere = _x # 9;
	private _tp_Fourriere = _x # 10;
	private _degats = _x # 11;
	private _vehicleInfo = [_classeName] call ALF_fnc_fetchVehInfo;

	private _img = _vehicleInfo # 2;
	private _kyle_cars_truc = _vehicleInfo # 3;
	_control lbAdd _kyle_cars_truc;
	_control lbSetData [(lbSize _control)-1,(str([_classeName,_alive,_active,_plaque,_pos,_fuel,_type_Assurance,_nb_Sinistre,_en_Fourriere,_tp_Fourriere,_degats]))];
	_control lbSetPicture [(lbSize _control)-1,_img];
	_control lbSetValue [(lbSize _control)-1,_id];
} forEach _vehs_Fourriere;
// };