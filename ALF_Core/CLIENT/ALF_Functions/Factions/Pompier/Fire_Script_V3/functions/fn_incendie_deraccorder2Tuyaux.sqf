_raccord1 = (nearestObjects[player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"], 2]) select 0;
_raccord2 = _raccord1 getVariable ["connectedTo",objNull];

_raccord1 setVariable ["connectedTo", objNull, true];
_raccord2 setVariable ["connectedTo", objNull, true];
if ((attachedObjects _raccord1) isEqualTo []) then {
	detach _raccord1;
} else {
	detach _raccord2;
};

_pos1 = ASLToATL (_raccord1 modelToWorldWorld [0,-0.2,0]);
_pos2 = ASLToATL (_raccord2 modelToWorldWorld [0,-0.2,0]);

_raccord1 setPosATL _pos1;
_raccord2 setPosATL _pos2;