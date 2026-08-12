params [
    ["_vehicle",objNull,[objNull]],
    ["_state",2,[0,false]]
];

if (isNull _vehicle) exitWith {};

_vehicle lock _state;

if (_state isequalto 0) then 
{
    [_vehicle,FALSE] remoteExec ["lockInventory",0];
} else 
{
    [_vehicle,TRUE] remoteExec ["lockInventory",0];
};