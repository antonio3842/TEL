/*
	Véhicule taxi de service du joueur (conducteur).
*/
private _stored = player getVariable ["MRP_Taxi_Vehicle", objNull];
private _cur = vehicle player;
private _isDriver = { ((assignedVehicleRole player) select 0) isEqualTo "driver" };

if (
	!isNull _stored && {!isNull _cur} && { _cur isEqualTo _stored } &&
	{ call _isDriver } && { alive _stored }
) exitWith { _stored };

if (
	!isNull _cur && { _cur != player } &&
	{ _cur getVariable ["MRP_TaxiServiceVehicle", false] } &&
	{ call _isDriver } && { alive _cur }
) exitWith {
	if (isNull _stored || { !(_stored isEqualTo _cur) }) then {
		player setVariable ["MRP_Taxi_Vehicle", _cur, true];
	};
	_cur
};

objNull
