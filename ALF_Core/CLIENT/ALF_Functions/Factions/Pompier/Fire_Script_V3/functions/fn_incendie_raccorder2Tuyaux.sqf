_raccord1 = byscream_demi_raccord_hand;
_raccord2 = (nearestObjects [player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"],2]) select 0;

if (_raccord2 isEqualTo _raccord1) then {
	_raccord2 = (nearestObjects [player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"],2]) select 1;
};


if (typeOf _raccord1 != typeOf _raccord2) exitWith {
	hint "Les demi-raccords ne sont pas les mêmes !";
};

byscream_demi_raccord_hand = objNull;

_demi_raccord_memory_1 = _raccord1 selectionPosition "demi_raccord_memory";
_demi_raccord_memory_2 = _raccord2 selectionPosition "demi_raccord_memory";
_raccord1 attachTo [_raccord2,[-(_demi_raccord_memory_2 select 2),(_demi_raccord_memory_1 select 1) + (_demi_raccord_memory_2 select 1),(_demi_raccord_memory_2 select 2)]];   
_raccord1 setVectorDirAndUp [[0,-1,0], [1,0,0]];
_raccord1 setVariable ["connectedTo", _raccord2, true];
_raccord2 setVariable ["connectedTo", _raccord1, true];