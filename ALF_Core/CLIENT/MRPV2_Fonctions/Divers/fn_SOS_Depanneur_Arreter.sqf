private _nom_Marqueur = format ["MRPV2_DEPANNEUR_DEMANDE_%1", getPlayerUID player];
private _targets = (allPlayers select { _x getVariable ["b_Depanneur", false] });
_targets pushBackUnique player;

private _monitor = player getVariable ["MRPV2_SOS_DEP_Monitor", scriptNull];
if (!scriptDone _monitor) then { terminate _monitor };
player setVariable ["MRPV2_SOS_DEP_Monitor", scriptNull];

if (_nom_Marqueur in allMapMarkers) then {
	[FALSE, _nom_Marqueur] remoteExec ["MRPV2_fnc_Marqueur_Gestion", _targets];
};
