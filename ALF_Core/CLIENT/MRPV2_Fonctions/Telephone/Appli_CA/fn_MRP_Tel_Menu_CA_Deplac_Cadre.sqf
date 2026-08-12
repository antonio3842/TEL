private _numero = param [0,""];
private _ctrl_Liste_Controle_Canaux = param [1,controlNull];
private _ctrl_A_Supprimer = param [2,controlNull];


private _liste_Tous_Ctrl = (allControls _ctrl_Liste_Controle_Canaux) select {ctrlClassName _x isEqualTo "RscControlsGroupNoScrollbars" AND {ctrltooltip _x isNotEqualTo ""}};
private _liste_Ctrl_A_Remonter = (_liste_Tous_Ctrl select {ctrlfade _x isequalto 0}) - [_ctrl_A_Supprimer];
private _nombre_Cadre_Simuler = 0;

{
	private _ctrl = _x;
	private _controle_Ouvert = (ctrlposition _ctrl # 3) > 0.12;
	private _pos_Y_Attendu = 0.12 * _nombre_Cadre_Simuler;

	if (_controle_Ouvert) then
	{
		_nombre_Cadre_Simuler = _nombre_Cadre_Simuler + 2;
	};

	if (!_controle_Ouvert) then
	{
		_nombre_Cadre_Simuler = _nombre_Cadre_Simuler + 1;
	};

	if (_pos_Y_Attendu isequalto ((ctrlposition _ctrl) # 1)) then {continue};

	_ctrl ctrlSetPositionY _pos_Y_Attendu;
	_ctrl ctrlCommit 0.3;

	[{params ["_ctrl"];
		ctrlcommitted _ctrl
	},
	{params ["_ctrl","_pos_Y_Attendu","_numero","_ctrl_Liste_Controle_Canaux","_ctrl_A_Supprimer"];
		private _pos_Y = ctrlposition _ctrl # 1;

		if ((_pos_Y tofixed 2) isnotequalto (_pos_Y_Attendu tofixed 2)) then
		{
			[_numero,_ctrl_Liste_Controle_Canaux,objnull] call MRPV2_fnc_MRP_Tel_Menu_CA_Deplac_Cadre;
		};
	},[_ctrl,_pos_Y_Attendu,_numero,_ctrl_Liste_Controle_Canaux,_ctrl_A_Supprimer],3,{}] call CBA_fnc_waitUntilAndExecute;
} foreach _liste_Ctrl_A_Remonter;

TRUE