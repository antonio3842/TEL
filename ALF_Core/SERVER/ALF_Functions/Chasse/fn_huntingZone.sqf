/*
	File: fn_huntingZone.sqf
	Author: NorX Aengell

	Description:
	Fais apparaitre des animaux quand un joueur est a +100m du rayon de la zone.
	Les suppriment quand plus aucun joueur est a -100m du rayon de la zone.
	Repopulations tous les X temps pour atteindre le nombre max d'animaux.
	Suppr les carcasses au fur et à mesure si plus de 20 carcasses.

*/

private _zone_Chasse = param [0,""];
private _animaux_Vivant_Max = param [10,30];
private _animaux_Mort_Max = param [2,20];
private _rayon_Entrer_Zone = param [3,100];
private _duree_Boucle = param [4,5];


[{params ["_args","_pfID"];
	_args params ["_zone_Chasse","_animaux_Vivant_Max","_animaux_Mort_Max","_rayon_Entrer_Zone"];

	private _pos_Marqueur_Zone = getMarkerPos _zone_Chasse;
	if(_pos_Marqueur_Zone isEqualTo [0,0,0]) exitWith {[_pfID] call CBA_fnc_removePerFrameHandler;};
	
	private _rayon = (getMarkerSize _zone_Chasse) select 0;
	private _dist_Detect_Joueur = _rayon + _rayon_Entrer_Zone;
	private _var_Joueurs_Proche = false;

	{
		if((_x distance _pos_Marqueur_Zone) < _dist_Detect_Joueur) exitWith {_var_Joueurs_Proche = true;}; 
		_var_Joueurs_Proche = false;
	} forEach playableUnits;	

	private _nom_Var = ("Chasse_Liste_Animaux_" + _zone_Chasse);
	private _liste_Animaux = missionnamespace getVariable [_nom_Var,[]];

	if (_var_Joueurs_Proche) then 
	{
		private _liste_animaux_En_Vie = _liste_Animaux select {alive _x};		
		private _nombre_Animaux_Repop = _animaux_Vivant_Max - count _liste_animaux_En_Vie;	
		private _liste_Classe_Animaux = ["Sheep_random_F","Goat_random_F","Hen_random_F","Cock_random_F"];

		for "_i" from 1 to _nombre_Animaux_Repop do 
		{
			private _classe = selectRandom _liste_Classe_Animaux;
			private _position = [((_pos_Marqueur_Zone # 0) - _rayon + random (_rayon * 2)), ((_pos_Marqueur_Zone # 1) - _rayon + random (_rayon * 2)),0];
			private _animal = createAgent [_classe,_position,[],0,"NONE"];
			_animal setDir (random 360);
			_liste_Animaux pushBack _animal;

			private _liste_Animaux_Mort = _liste_Animaux select {!alive _x};
			if (count _liste_Animaux_Mort >= _animaux_Mort_Max) then
			{
				deleteVehicle (_liste_Animaux_Mort # 0);
				_liste_Animaux = _liste_Animaux - [(_liste_Animaux_Mort # 0)];
			};
		};

		_liste_Animaux = _liste_Animaux select {!isnull _x};

		missionnamespace setVariable [_nom_Var,_liste_Animaux];
	} else
	{
		if !(isnil {_liste_Animaux}) then
		{
			{deleteVehicle _x;} forEach _liste_Animaux;
			missionnamespace setVariable [_nom_Var,nil];
		};		
	};
},_duree_Boucle,[_zone_Chasse,_animaux_Vivant_Max,_animaux_Mort_Max,_rayon_Entrer_Zone]
] call CBA_fnc_addPerFrameHandler;