params [["_veh", objNull, [objNull]]];
if (isNull _veh) exitWith {};

[] call MRPV2_fnc_SOS_Depanneur_Arreter;

private _nom_Marqueur = format ["MRPV2_DEPANNEUR_DEMANDE_%1", getPlayerUID player];
private _posInit = getPosATL _veh;
private _targets = (allPlayers select { _x getVariable ["b_Depanneur", false] });
_targets pushBackUnique player;

[TRUE, _nom_Marqueur, _posInit, "ICON", [1.3, 1.3], "ColorRed", "SOS Dépanneur", "hd_destroy"] remoteExec ["MRPV2_fnc_Marqueur_Gestion", _targets];

private _handle = [_veh, _nom_Marqueur, _posInit, _targets] spawn {
	params ["_veh", "_nom", "_posInit", "_targets"];
	private _seuil = 3;

	waitUntil {
		sleep 1;
		isNull _veh
		|| { (getPosATL _veh distance _posInit) > _seuil }
		|| { !(_nom in allMapMarkers) }
	};

	if (_nom in allMapMarkers) then {
		[FALSE, _nom] remoteExec ["MRPV2_fnc_Marqueur_Gestion", _targets];
	};

	player setVariable ["MRPV2_SOS_DEP_Monitor", scriptNull];
};

player setVariable ["MRPV2_SOS_DEP_Monitor", _handle];
