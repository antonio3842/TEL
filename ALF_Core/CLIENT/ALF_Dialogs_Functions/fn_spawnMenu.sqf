
if (ALF_Prison) exitWith {[] spawn ALF_fnc_respawned;};

tmp_pending_respawn = nil;
[] spawn ALF_fnc_respawned;

if (vehicle player isNotEqualTo player) then {moveOut player;};

private _litsHopital = nearestObjects [player, ["Land_ALF_H_bed"], 40000];
private _litLibre = if (_litsHopital isEqualTo []) then {objNull} else {_litsHopital # 0};

if !(isNull _litLibre) then {
	player setPosATL (_litLibre modelToWorld (_litLibre selectionPosition "pos_cargo"));
	player setDir ((getDir _litLibre) - 180);
	[player, "passenger_injured_medevac_truck01"] remoteExecCall ["ALF_fnc_switchMove",0];
} else {
	private _respawnCivil = getMarkerPos "respawn_civilian";
	if !(_respawnCivil isEqualTo [0,0,0]) then {
		player setPosATL _respawnCivil;
	};
};

0 cutText["","PLAIN"]; 
0 cutFadeOut 9999999;
cutText ["","BLACK in",8];
