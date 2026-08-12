// CLIENT_fnc_MRP_Tel_Menu_Annuaire_Crea_Marqueur = {
private _liste_Pos = param [0,[]];
private _nom = param [1,""];


private _liste_Marqueur = [];


	private _pos = _liste_Pos;
	private _nom_Marqueur_Base = "_USER_DEFINED MRP_ANN_" + _nom;

		private _nom_Marqueur = _nom_Marqueur_Base;
		private _marqueur = createMarkerLocal [_nom_Marqueur,_pos];

		if (_marqueur isnotequalto "") then
		{
			_liste_Marqueur pushback _marqueur;
			_marqueur setMarkerShapeLocal "ICON";
			_marqueur setMarkerTypeLocal "Mil_dot";
			_marqueur setMarkerColorLocal "ColorOrange";
			_marqueur setMarkerTextLocal _nom;
		};


if (_liste_Marqueur isequalto []) exitwith {};

[{params ["_liste_Marqueur"];{deleteMarkerlocal _x;} foreach _liste_Marqueur;},[_liste_Marqueur],300] call CBA_fnc_waitAndExecute;

["Marqueurs",format ["<t color='#ffffff' align='center'>Emplacement (%1) placé pendant 5min</t>",_nom],"info"] spawn ALF_fnc_doMsg;

TRUE
// };