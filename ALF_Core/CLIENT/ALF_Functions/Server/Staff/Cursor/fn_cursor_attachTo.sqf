params[["_veh",objNull,[objNull]]];
if(isNull _veh) then {_veh = cursorObject;};
if(isNull _veh) exitWith {};
_veh attachTo [player];
attachKeyDown =
{
    private _key = (_this#0)#1;
    private _str = _this#1;
    private _veh = objNull;
    {
        if (str _x isEqualTo _str) exitwith {_veh = _x;};
    } foreach (nearestObjects [player, [], 20]);

    private _VecNormal = [0,0,1];
    private _dir = _veh getVariable["AdminAttached_Dir",0];
    private _height = _veh getVariable["AdminAttached_Height",0];
    private _relPosition = player worldToModel ASLToAGL getPosASL _veh;
    private _return = false;
    switch _key do
    {
        case 201: {
            _height = _height + 1;
            _veh setVariable["AdminAttached_Height",_height];

            _return = true;
        };
        case 209: {
            _height = _height - 1;
            _veh setVariable["AdminAttached_Height",_height];
            _return = true;
        };
        case 199: {
            _dir = _dir + -4;
            if(_dir >= 360) then {_dir = _dir - 360;};
            if(_dir < 0) then {_dir = _dir + 360;};
            _veh setVariable["AdminAttached_Dir",_dir];
            _return = true;
        };
        case 207: {
            _dir = _dir + 4;
            if(_dir >= 360) then {_dir = _dir - 360;};
            if(_dir < 0) then {_dir = _dir + 360;};
            _veh setVariable["AdminAttached_Dir",_dir];
            _return = true;
        };
    };
    if(_return) then {
        _veh attachTo [player, [_relPosition#0,_relPosition#1,_height]];
        _VecDir = [-cos _dir, sin _dir, 0] vectorCrossProduct _VecNormal;
        _veh setVectorDirAndUp [_VecDir, _VecNormal];
    };
    _return;
};
waituntil {!isNull findDisplay 46};
private _attachKeyDown = (findDisplay 46) DisplayAddEventHandler ["keydown",format["[_this,'%1'] call attachKeyDown",_veh]];
waitUntil {!(_veh IN (attachedObjects player)) || (isNull _veh)};
(findDisplay 46) displayremoveeventhandler ["keydown",_attachKeyDown];
