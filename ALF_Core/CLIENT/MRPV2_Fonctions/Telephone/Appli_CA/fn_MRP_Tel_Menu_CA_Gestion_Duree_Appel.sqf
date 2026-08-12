[
	{params ["_args", "_pfID"];
		_args params ["_heure_Depart"];
		private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",controlNull];

		if (_ctrl_Liste_Controle_Canaux isequalto controlnull) exitwith {[_pfID] call CBA_fnc_removePerFrameHandler;};

		_temps_Rafraichissement = servertime + 1;
		private _liste_ctrl_Duree = (allControls _ctrl_Liste_Controle_Canaux) select {ctrlClassName _x isNotEqualTo "RscControlsGroupNoScrollbars" AND {"Durée" in ctrltooltip _x}};

		{
			private _ctrl = _x;

			private _duree_Enregistrer = (ctrltooltip _ctrl splitstring " ") # 1;
			private _duree_Appel = round (servertime - parsenumber _duree_Enregistrer);

			private _duree_Appel_Formatter = [_duree_Appel, "HH:MM:SS"] call BIS_fnc_secondsToString;

			_ctrl ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='left'>%1</t>",_duree_Appel_Formatter];
		} foreach _liste_ctrl_Duree;
	},
	1,
	[servertime]
] call CBA_fnc_addPerFrameHandler;

TRUE