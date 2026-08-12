// ALF_fnc_immobiliserVehicle = {
private _veh = param [0,objnull];
private _action = param [1,""];


if (_action isequalto "Mettre") then
{
	private _vehicules = missionNamespace getVariable ["VehiculeImmobiliser",[]];
	_vehicules pushBack _veh;
	missionNamespace setVariable ["VehiculeImmobiliser",_vehicules,true];
	["Vehicule", "Ce véhicule est désormais immobilisé.", "success", false] spawn ALF_fnc_doMsg;

	if ("_MRP_" in typeof life_vInact_curTarget) then 
	{
		_veh animateSource ["sabot_source",1];
	} else
	{
		_veh animateSource ["sabot", 0];
	};
	[_veh,TRUE] remoteexec ["lockDriver",owner _veh,true];
	[_veh,TRUE] remoteExec ["lockInventory",0,true];

	private _position_Son_Sabot = getPosASL _veh;
	private _position_selection = _veh selectionposition "wheel_1_1_hide";
	private _volume_son = 1;

	if (_position_selection isnotequalto [0,0,0]) then
	{
		_position_Son_Sabot = _veh modelToWorld _position_selection;
		_volume_son = 2;
	};

	playSound3D ["A3\Sounds_F\air\sfx\SL_4hooksLock.wss",_veh,false,_position_Son_Sabot,_volume_son,1,100,1];
} else 
{
	_vehicules = missionNamespace getVariable ["VehiculeImmobiliser",[]];
	_vehicules = _vehicules - [_veh];
	missionNamespace setVariable ["VehiculeImmobiliser",_vehicules,true];
	["Vehicule", "Ce véhicule n'est désormais plus immobilisé.", "success", false] spawn ALF_fnc_doMsg;

	if ("_MRP_" in typeof life_vInact_curTarget) then 
	{
		_veh animateSource ["sabot_source",0];
	} else
	{
		_veh animateSource ["sabot", 1];
	};
	[_veh,FALSE] remoteexec ["lockDriver",owner _veh,true];
	[_veh,FALSE] remoteExec ["lockInventory",0,true];

	private _position_Son_Sabot = getPosASL _veh;
	private _position_selection = _veh selectionposition "wheel_1_1_hide";
	private _volume_son = 1;

	if (_position_selection isnotequalto [0,0,0]) then
	{
		_position_Son_Sabot = _veh modelToWorld _position_selection;
		_volume_son = 2;
	};

	playSound3D ["A3\Sounds_F\air\sfx\SL_4hooksUnlock.wss",_veh,false,_position_Son_Sabot,_volume_son,1,100,1];
};
// };