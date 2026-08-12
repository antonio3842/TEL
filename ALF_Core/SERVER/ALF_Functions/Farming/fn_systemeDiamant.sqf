// ALF_Server_fnc_systemeDiamant = {
params [
	["_unit",objNull,[objNull]],
	["_curTarget",objNull,[objNull]],
	["_itemB","",[""]],
	["_itemF","",[""]]
];
if(isNull _unit OR {isNull _curTarget}) exitWith {};

if(_curTarget getVariable["process",false]) exitWith {["Diamant", "La machine est déjà en marche.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

_curTarget setVariable ["process",true];

private _o = "groundweaponholder" createVehicle [0,0,0];

[] call 
{
	if (_itemB isequalto "ALF_Pierre_dia_small") exitWith {_o setPosATL (_curTarget modelToWorld [-0.1,-0.5,-0.7]);};
	if (_itemB isequalto "ALF_diamant_taille") then {_o setPosATL (_curTarget modelToWorld [-0.1,-0.5,-0.65]);};
};

_o addMagazineCargoGlobal [_itemB,1];
[_o,TRUE] remoteExec ["lockInventory",0];
_o enableSimulationGlobal TRUE;

waitUntil 
{
	uiSleep 0.3;
	!isNull _o AND {magazineCargo _o isNotEqualto []}
};

[_itemB,false] remoteExec ["ALF_fnc_handleItem",_unit];

playSound3D ["ALF_Client2\sounds\tail_bg.ogg",_curTarget, false,(_curTarget modelToWorld [-0.27,-0.4,-0.45]), 4, 1, 150];
_curTarget animate ['pik2',1,4];
_curTarget animate ['roue',1,4];

private _s = 0;
private _t = 0;
private _b = false;
for "_i" from 0 to 240 step 1 do 
{
	if(isNull _o OR {(count (magazineCargo _o)) < 1}) exitWith {_b = true;};
	_t = _t + 1;
	_s = _s + 1;

	if(_s isEqualTo 20) then 
	{
		_s = 0;
		playSound3D ["ALF_Client2\sounds\tail_wk.ogg",_curTarget, false,(_curTarget modelToWorld [-0.27,-0.4,-0.45]),4, 1, 150];
	};
	if(_t isEqualTo 50) then 
	{
		_curTarget animate ['pik2', 0];
		_curTarget animate ['roue', 0];
	};
	if(_t isEqualTo 90) then 
	{
		_curTarget animate ['pik2', 1];
		_curTarget animate ['roue', 1];
	};
	if(_t isEqualTo 150) then 
	{
		_curTarget animate ['pik2', 0];
		_curTarget animate ['roue', 0];
	};
	if(_t isEqualTo 190) then 
	{
		_curTarget animate ['pik2', 1];
		_curTarget animate ['roue', 1];
	};
	uiSleep 0.5;
};

_curTarget animate ['pik2',0,4];
_curTarget animate ['roue',0,4];
playSound3D ["ALF_Client2\sounds\tail_end.ogg",_curTarget, false,(_curTarget modelToWorld [-0.27,-0.4,-0.45]),4, 1, 150];

if (_b) exitWith 
{
	if !(isNull _o) then 
	{
		detach _o; 
		deleteVehicle _o;
	};

	uiSleep 10;
	_curTarget setVariable ["process",false];
};

detach _o; 
deleteVehicle _o;

private _o2 = "groundweaponholder" createVehicle [0,0,0];
_o2 setPosATL (_curTarget modelToWorld [-0.27,-0.4,-0.65]);
_o2 addMagazineCargoGlobal [_itemF,1];

_o2 enableDynamicSimulation true;

_curTarget setVariable ["process",false];

[1,2] remoteExec ["ALF_fnc_addXP",remoteExecutedOwner];
// };