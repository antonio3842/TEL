_raccord = player getVariable ["connectedTo", objNull];
_raccord setVariable ["connectedTo", objNull, true];
player setVariable ["connectedTo", objNull, true];
detach _raccord;

_pos = getPos _raccord;
_raccord setPos [_pos select 0, _pos select 1, 0];
//_raccord setVectorUp [0,0,0];
hint "Tuyau déraccordé de la LDV 500";