byscream_ldt_hand = cursorObject;
_vehicle = cursorObject;
_dirVehicle = direction _vehicle;
_positionVehicle = getPos _vehicle;

_vehicle setVariable ["byscream_ldtprise",true,true];

_arrayPosition = _vehicle selectionPosition (["STRING", ["ByScream_Incendie_V3","vehicles",typeOf _vehicle,"LDT","pos"]] call ALFTools_Client_Config_fnc_getConfig);
_longueur = ["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf _vehicle,"LDT","longueur"]] call ALFTools_Client_Config_fnc_getConfig;

player addWeapon "byscream_LDT";
 
player addPrimaryWeaponItem "byscream_LDV500_chargeur";

reload player;


_raccord1 = createVehicle ["byscream_demi_raccord_ldt", getPosATL player, [], 0, "CAN_COLLIDE"];
_raccord1 attachTo [player,[0.475,-0.06,-0.65],"weapon",true];  
//[_raccord1,true] remoteExec ["hideobject",0];
//hideObjectGlobal _raccord1;


_raccord2 = createVehicle ["byscream_demi_raccord_ldt", getPosATL player, [], 0, "CAN_COLLIDE"];
_raccord2 attachTo [_vehicle,_arrayPosition];
//[_raccord2,true] remoteExec ["hideobject",0];
//hideObjectGlobal _raccord2;

_rope_memory = _raccord2 selectionPosition "rope_memory";
_myRope = ropeCreate [_raccord2, _rope_memory, _raccord1, _rope_memory, _longueur,["", [0,0,-1]],["", [0,0,-1]],"ByScream_Tuyau22"];
player setVariable ["connectedTo", _raccord1,true];
_raccord2 setVariable ["connectedTo", _vehicle, true];
_raccord1 setVariable ["connectedTo", player, true];
_raccord1 setVariable ["opposite",_raccord2,true];
_raccord2 setVariable ["opposite",_raccord1,true];
_raccord1 setVariable ["longueur",_longueur,true];
_raccord2 setVariable ["longueur",_longueur,true];

_raccord1 lockInventory true;
_raccord2 lock true;
_raccord2 lockInventory true;

_vehicle animateSource ["ldt_hide_source",1];

while {!isNull (player getVariable ["connectedTo", objNull])} do {
	
	if ((player distance _raccord2) > _longueur) then {
		hint "Vous ne pouvez pas aller si loin ! Veuillez redéployer un tuyau.";
		_dir = vectorNormalized ((getPos _raccord2) vectorFromTo (getPos player));  // direction du joueur vers l'objet
        _newPos = (getPos _raccord2) vectorAdd [(_dir select 0) * (_longueur-1), (_dir select 1) * (_longueur-1), 0];  // position exactement à 20 m
		_newPos set [2, (getPos player) select 2];
        player setPos _newPos;
	};
	sleep 0.1;
};