_raccord = (nearestObjects [player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"],2]) select 0;

_connected = _raccord getVariable ["connectedTo", objNull];
if !(_connected isEqualTo objNull) exitWith {
	hint "Le demi-raccord le plus proche est déjà raccordé à quelque chose !";
};
if (typeOf _raccord isNotEqualTo "byscream_demi_raccord45") exitWith {
	hint "Ce n'est pas le bon diamètre !";
};
hint "Tuyau raccordé à la LDV 500";
_raccord setVariable ["connectedTo", player, true];
player setVariable ["connectedTo", _raccord, true];
_raccord attachTo [player,[0.445,-0.15,-0.6165],"weapon",true];  
_raccord setVectorDirAndUp [[0,1,0], [1,0,0]];
_raccord lock false;

while {!isNull (player getVariable ["connectedTo", objNull])} do {
	_opposite = (player getVariable ["connectedTo", objNull]) getVariable "opposite";
	_longueur = ((player getVariable ["connectedTo", objNull]) getVariable ["longueur",20]);
	if ((player distance _opposite) > _longueur) then {
		hint "Vous ne pouvez pas aller si loin ! Veuillez redéployer un tuyau.";
		_dir = vectorNormalized ((getPos _opposite) vectorFromTo (getPos player));  // direction du joueur vers l'objet
        _newPos = (getPos _opposite) vectorAdd [(_dir select 0) * (_longueur-1), (_dir select 1) * (_longueur-1), 0];  // position exactement à 20 m
		_newPos set [2, (getPos player) select 2];
        player setPos _newPos;
	};
	sleep 0.1;
};