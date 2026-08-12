/*
if (!dialog) then { createDialog "interactionSystem"; };

private _affichage = findDisplay 25799;
private _liste_Boutons = [];

// for "_i" from 0 to 11 do 
// {
//     private _bouton = _affichage displayCtrl (25802 + _i);
//     _bouton ctrlShow FALSE;
//     _liste_Boutons pushBack _bouton;
// };

if (isSimpleObject cursorobject) then 
{
	private _bouton_1 = _liste_Boutons # 0;
	_bouton_1 ctrlShow TRUE;
	_bouton_1 ctrlSetText "Prendre le fauteuil roulant";
	_bouton_1 ctrlAddEventHandler ["buttonClick", 
	{
		closeDialog 2;
		[cursorobject] call ALF_fnc_createWheelchair;
	}];
} else 
{
	private _bouton_1 = _liste_Boutons # 0;
	_bouton_1 ctrlShow TRUE;
	_bouton_1 ctrlSetText "Ranger le fauteuil roulant";
	_bouton_1 ctrlAddEventHandler ["buttonClick", 
	{
		closeDialog 2;

		private _fauteuil_Est_Vide = crew vehicle player isequalto [];
		if (_fauteuil_Est_Vide) exitwith
		{
			["INFO", "Le fauteuil doit être vide pour le ranger.","warning"] spawn ALF_fnc_doMsg;
		};

		private _est_Proche_Fauteuil_Base = allSimpleObjects ["ALF_WheelChair_P"] select {_x distance2d cursorObject < 5};
		if (_est_Proche_Fauteuil_Base isEqualTo []) then 
		{
			["INFO", "Vous devez être proche de l'endroit où vous l'avez pris pour le ranger.","warning"] spawn ALF_fnc_doMsg;
		} else 
		{
			deletevehicle cursorobject;
			["INFO", "Vous avez rangé le fauteuil.","success"] spawn ALF_fnc_doMsg;
		};
	}];

	private _bouton_2 = _liste_Boutons # 1;
	_bouton_2 ctrlShow TRUE;
	_bouton_2 ctrlSetText "Se mettre dans le fauteuil roulant";
	_bouton_2 ctrlAddEventHandler ["buttonClick", 
	{	
		closeDialog 2;

		private _veh = cursorobject;
		alive _veh && {(vehicle player) isEqualTo player} && {(locked _veh) <= 1} && {({!((typeOf _x) in ["ALF_Iphone_Object","ALF_3310_Object",""])} count (attachedObjects player)) isEqualTo 0} && {!(_veh in (missionNamespace getVariable ["VehiculeImmobiliser",[]]))} then 
		{
			player action ["getInCargo", _veh];
		} else 
		{
			["INFO", "Vous ne pouvez pas vous asseoir dans ce fauteuil.","warning"] spawn ALF_fnc_doMsg;
		};
	}];

	[] call 
	{
		private _cond_Deplacer =
		(
			count (attachedObjects player select {"alf_weelchair" in str _x}) isEqualTo 0 AND 
			{speed (vehicle player) isEqualTo 0 AND 
			{!(player in crew cursorobject) AND 
			{isNull attachedTo cursorobject AND 
			{life_medicLevel > 0}}}}
		);

		if (_cond_Deplacer) exitwith 
		{
			private _bouton_3 = _liste_Boutons # 2;
			_bouton_3 ctrlShow TRUE;
			_bouton_3 ctrlSetText "Déplacer le fauteuil roulant";
			_bouton_3 ctrlAddEventHandler ["buttonClick", 
			{	
				closeDialog 2;

				this attachTo [player, [0,0.8,1.3]]; 
				this setDir 180;

				["INFO", "Vous avez pris le fauteuil roulant pour le déplacer.","success"] spawn ALF_fnc_doMsg;
			}];
		};

		private _cond_Lacher =
		(
			count (attachedObjects player select {"alf_weelchair" in str _x}) isNotEqualTo 0 AND 
			{speed (vehicle player) isEqualTo 0 AND 
			{!(player in crew cursorobject) AND 
			{isNull attachedTo cursorobject}}}
		);

		if (_cond_Lacher) then 
		{
			private _bouton_3 = _liste_Boutons # 2;
			_bouton_3 ctrlShow TRUE;
			_bouton_3 ctrlSetText "Déplacer le fauteuil roulant";
			_bouton_3 ctrlAddEventHandler ["buttonClick", 
			{	
				closeDialog 2;
				{detach _x;} forEach (attachedObjects player select {"alf_weelchair" in str _x});

				["INFO", "Vous avez lacher le fauteuil roulant.","success"] spawn ALF_fnc_doMsg;
			}];
		};
	};

	private _cond_Sortir_Patient =
	(
		count (crew cursorobject) > 0 AND 
		{life_medicLevel > 0 AND 
		{!(player in crew cursorobject)}}
	);

	if (_cond_Sortir_Patient) then 
	{
		private _bouton_4 = _liste_Boutons # 3;
		_bouton_4 ctrlShow TRUE;
		_bouton_4 ctrlSetText "Sortir le patient du fauteuil roulant";
		_bouton_4 ctrlAddEventHandler ["buttonClick", 
		{	
			closeDialog 2;
			{moveout _x;} forEach crew cursorObject;

			["INFO", "Vous avez sortis le patient du fauteuil roulant.","success"] spawn ALF_fnc_doMsg;
		}];
	};

	private _cond_Transfert_Scanner =
	(
		count (crew this) > 0 AND
		{life_medicLevel > 0 AND 
		{!(player in crew this)}}
	);

	if (_cond_Transfert_Scanner) then 
	{
		private _bouton_5 = _liste_Boutons # 4;
		_bouton_5 ctrlShow TRUE;
		_bouton_5 ctrlSetText "Transférer le patient sur le scanner";
		_bouton_5 ctrlAddEventHandler ["buttonClick", 
		{	
			closeDialog 2;
			[cursorObject] call ALF_fnc_transfertScanner;

			["INFO", "Vous avez transféré le patient sur le scanner.","success"] spawn ALF_fnc_doMsg;
		}];
	};
};
*/


// MRPV2_fnc_Interaction_Fauteuil_Roulant = {
private _obj = param [0,objnull];

if (gestureState player isEqualTo "<none>" OR {_obj distance player > 3}) exitWith {};

life_pInact_curObject = _obj;

private _liste_Actions = createhashmap;
private _liste_Sous_Actions = [];

if (isSimpleObject cursorobject) then 
{
	// Action Prendre le fauteuil roulant
	private _texte = "Prendre le fauteuil roulant";
	private _texte_tooltype = "Prendre le fauteuil roulant";
	private _action = 
	{
		closeDialog 0;
		[cursorobject] call ALF_fnc_createWheelchair;
	};
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
} else 
{
	// Action Ranger le fauteuil roulant
	private _texte1 = "Ranger le fauteuil roulant";
	private _texte_tooltype1 = "Ranger le fauteuil roulant";
	private _action1 = 
	{
		closeDialog 0;
		private _fauteuil_Est_Vide = crew vehicle player isequalto [];
		if (_fauteuil_Est_Vide) exitwith
		{
			["INFO", "Le fauteuil doit être vide pour le ranger.","warning"] spawn ALF_fnc_doMsg;
		};

		private _est_Proche_Fauteuil_Base = allSimpleObjects ["ALF_WheelChair_P"] select {_x distance2d cursorObject < 5};
		if (_est_Proche_Fauteuil_Base isEqualTo []) then 
		{
			["INFO", "Vous devez être proche de l'endroit où vous l'avez pris pour le ranger.","warning"] spawn ALF_fnc_doMsg;
		} else 
		{
			deletevehicle cursorobject;
			["INFO", "Vous avez rangé le fauteuil.","success"] spawn ALF_fnc_doMsg;
		};
	};
	_liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];

	// Action Se mettre dans le fauteuil roulant
	private _texte2 = "Se mettre dans le fauteuil roulant";
	private _texte_tooltype2 = "S'asseoir dans le fauteuil roulant";
	private _action2 = 
	{	
		closeDialog 0;
		private _veh = cursorobject;
		if (alive _veh && {(vehicle player) isEqualTo player} && {(locked _veh) <= 1} && {({!((typeOf _x) in ["ALF_Iphone_Object","ALF_3310_Object",""])} count (attachedObjects player)) isEqualTo 0} && {!(_veh in (missionNamespace getVariable ["VehiculeImmobiliser",[]]))}) then 
		{
			player action ["getInCargo", _veh];
		} else 
		{
			["INFO", "Vous ne pouvez pas vous asseoir dans ce fauteuil.","warning"] spawn ALF_fnc_doMsg;
		};
	};
	_liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];

	// Action Déplacer le fauteuil roulant
	private _cond_Deplacer =
	(
		count (attachedObjects player select {"alf_weelchair" in str _x}) isEqualTo 0 AND 
		{speed (vehicle player) isEqualTo 0 AND 
		{!(player in crew cursorobject) AND 
		{isNull attachedTo cursorobject AND 
		{life_medicLevel > 0}}}}
	);

	if (_cond_Deplacer) then 
	{
		private _texte3 = "Déplacer le fauteuil roulant";
		private _texte_tooltype3 = "Déplacer le fauteuil roulant";
		private _action3 = 
		{	
			closeDialog 0;
			cursorobject attachTo [player, [0,0.8,1.3]]; 
			cursorobject setDir 180;
			["INFO", "Vous avez pris le fauteuil roulant pour le déplacer.","success"] spawn ALF_fnc_doMsg;
		};
		_liste_Sous_Actions pushback [_texte3,_texte_tooltype3,_action3];
	};

	// Action Lâcher le fauteuil roulant
	private _cond_Lacher =
	(
		count (attachedObjects player select {"alf_weelchair" in str _x}) isNotEqualTo 0 AND 
		{speed (vehicle player) isEqualTo 0 AND 
		{!(player in crew cursorobject) AND 
		{isNull attachedTo cursorobject}}}
	);

	if (_cond_Lacher) then 
	{
		private _texte3 = "Lâcher le fauteuil roulant";
		private _texte_tooltype3 = "Lâcher le fauteuil roulant";
		private _action3 = 
		{	
			closeDialog 0;
			{detach _x;} forEach (attachedObjects player select {"alf_weelchair" in str _x});
			["INFO", "Vous avez lacher le fauteuil roulant.","success"] spawn ALF_fnc_doMsg;
		};
		_liste_Sous_Actions pushback [_texte3,_texte_tooltype3,_action3];
	};

	// Action Sortir le patient du fauteuil roulant
	private _cond_Sortir_Patient =
	(
		count (crew cursorobject) > 0 AND 
		{life_medicLevel > 0 AND 
		{!(player in crew cursorobject)}}
	);

	if (_cond_Sortir_Patient) then 
	{
		private _texte4 = "Sortir le patient du fauteuil roulant";
		private _texte_tooltype4 = "Sortir le patient du fauteuil roulant";
		private _action4 = 
		{	
			closeDialog 0;
			{moveout _x;} forEach crew cursorObject;
			["INFO", "Vous avez sortis le patient du fauteuil roulant.","success"] spawn ALF_fnc_doMsg;
		};
		_liste_Sous_Actions pushback [_texte4,_texte_tooltype4,_action4];
	};

	// Action Transférer le patient sur le scanner
	private _cond_Transfert_Scanner =
	(
		count (crew cursorobject) > 0 AND
		{life_medicLevel > 0 AND 
		{!(player in crew cursorobject)}}
	);

	if (_cond_Transfert_Scanner) then 
	{
		private _texte5 = "Transférer le patient sur le scanner";
		private _texte_tooltype5 = "Transférer le patient sur le scanner";
		private _action5 = 
		{	
			closeDialog 0;
			[cursorObject] call ALF_fnc_transfertScanner;
			["INFO", "Vous avez transféré le patient sur le scanner.","success"] spawn ALF_fnc_doMsg;
		};
		_liste_Sous_Actions pushback [_texte5,_texte_tooltype5,_action5];
	};
};

if (_liste_Sous_Actions isequalto []) exitwith {};
_liste_Actions set ["",_liste_Sous_Actions];
[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
// };

