_object = (nearestObjects [player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"],2]) select 0;


_demi_raccord_memory = _object selectionPosition "demi_raccord_memory";
_object attachTo [player,[0,-(_demi_raccord_memory select 1),0],"RightHandMiddle1"];
byscream_demi_raccord_hand = _object;

while {!isNull byscream_demi_raccord_hand} do {
	_opposite = byscream_demi_raccord_hand getVariable "opposite";
	_longueur = (byscream_demi_raccord_hand getVariable ["longueur",20]);
	if ((player distance _opposite) > _longueur) then {
		hint "Vous ne pouvez pas aller si loin ! Veuillez redéployer un tuyau.";
		_dir = vectorNormalized ((getPos _opposite) vectorFromTo (getPos player));  // direction du joueur vers l'objet
        _newPos = (getPos _opposite) vectorAdd [(_dir select 0) * (_longueur-1), (_dir select 1) * (_longueur-1), 0];  // position exactement à 20 m
		_newPos set [2, (getPos player) select 2];
        player setPos _newPos;
	};
	sleep 0.1;
};