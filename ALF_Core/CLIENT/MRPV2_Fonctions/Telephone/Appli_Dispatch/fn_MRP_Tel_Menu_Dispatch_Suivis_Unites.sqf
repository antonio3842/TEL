// MRPV2_fnc_MRP_Tel_Menu_Dispatch_Suivis_Unites = {
private _ent = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
MRP_Dispatch_Liste_Suivis = [];

[
	{params ["_args", "_pfID"];
		_args params ["_ent"];								

		if (isnil {MRP_Dispatch_Liste_Suivis}) exitwith {[_pfID] call CBA_fnc_removePerFrameHandler;};

		private _liste_Collegues = allplayers select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT) isEquaLTo _ent};
		{
			private _unite = _x;
			private _nom_Marqueur = "MRP_Suivis_Dispatch_" + getPlayerID _unite;
			private _marqueur = (allMapMarkers select {_x isequalto _nom_Marqueur}) # 0;

			if (isnil {_marqueur}) then
			{
				_marqueur = createMarkerLocal [_nom_Marqueur,getpos _unite];
				_marqueur setMarkerShapeLocal "ICON";
				_marqueur setMarkerTypeLocal "hd_dot_noShadow";
				_marqueur setMarkerTextLocal (name _unite);

				if (_ent isEqualto "GN") then {_marqueur setMarkerColorLocal "ColorBlue";};
				if (_ent isEqualto "SP") then {_marqueur setMarkerColorLocal "ColorRed";};

				MRP_Dispatch_Liste_Suivis pushback _marqueur;
			} else
			{
				_marqueur setMarkerPosLocal (getpos _unite);
			};									
		} forEach _liste_Collegues;

		// Si joueur déco ou mort on suppr le marqueur
		{
			private _marqueur = _x;
			private _id = _marqueur regexReplace ["MRP_Suivis_Dispatch_",""];
			private _liste_joueur = allPlayers select {getPlayerID _x isequalto _id};
			private _joueur_Plus_La = _liste_joueur isEquaLTo [];
			private _joueur_Plus_En_Service = _liste_joueur select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT) isEquaLTo _ent} isEquaLTo [];

			if (_joueur_Plus_La OR {_joueur_Plus_En_Service}) then {deleteMarker _marqueur;};
		} foreach MRP_Dispatch_Liste_Suivis;

		MRP_Dispatch_Liste_Suivis = MRP_Dispatch_Liste_Suivis select {markerpos _x isNotEqualto [0,0,0]};
	},
	2,
	[_ent]
] call CBA_fnc_addPerFrameHandler;

TRUE
// };