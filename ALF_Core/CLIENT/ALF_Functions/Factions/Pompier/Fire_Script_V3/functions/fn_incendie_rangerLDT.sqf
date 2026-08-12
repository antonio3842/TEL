player removeWeapon "ByScream_LDT";

_raccord1 = (player getVariable "connectedTo");
_raccord2 = (_raccord1 getVariable "opposite");
player setVariable ["connectedTo",objNull, true],
_rope = (ropes _raccord2) select 0;

ropeDestroy _rope;
deleteVehicle _raccord2;
deleteVehicle _raccord1;
byscream_ldt_hand = objNull;


cursorObject setVariable ["byscream_ldtprise",false,true];
cursorObject animateSource ["ldt_hide_source",0];