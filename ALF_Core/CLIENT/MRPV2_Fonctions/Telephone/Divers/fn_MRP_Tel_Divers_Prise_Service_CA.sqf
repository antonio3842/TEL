// MRPV2_fnc_MRP_Tel_Divers_Prise_Service_CA = {
private _service_Pris = param [0,FALSE];


if (_service_Pris) then
{
	[{
		b_enService || life_gendarme_service  ||  life_pompier_service || life_penit_service
	},
	{
		private _mon_Ent = player getVariable ["isEmployed",""];
		
		if (_mon_Ent isequalto "") then {
			if (life_gendarme_service) then 
			{
			_mon_Ent = "1";
			};
			if (life_pompier_service) then 
			{
			_mon_Ent = "2";
			};
			if (life_penit_service) then 
			{
			_mon_Ent = "3";
			};
		};
		
		if (_mon_Ent isequalto -1) exitwith {};

		private _liste_Joueurs_Appel_Mon_Ent = allPlayers select 
		{
			_x getvariable ["MRP_Tel_CA_Info_Appelant",[]] isnotequalto [] AND
			{((_x getvariable ["MRP_Tel_CA_Info_Appelant",[]]) # 5) isequalto _mon_Ent}
		};

		{
			private _joueur = _x;
			_joueur setvariable ["MRP_Tel_CA_Info_Appelant",nil];
			[_joueur,"MRP_Tel_CA_Info_Appelant"] remoteExec ["mrpv2_fnc_MRP_Tel_Divers_syncsinglevar",_joueur];

			[{params ["_joueur"];
				(_joueur getvariable ["MRP_Tel_CA_Info_Appelant",[]]) isnotequalto []
			},
			{params ["_joueur"];
				private _info_Appel = _joueur getvariable ["MRP_Tel_CA_Info_Appelant",[]];
				private _numero = _info_Appel # 0;

				private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
				_tel_CA_Info_Ope set [_numero,[_info_Appel # 1,_info_Appel # 2,_info_Appel # 3,_info_Appel # 4,_info_Appel # 6]];
				player setvariable ["MRP_Tel_CA_Info_Operateur",_tel_CA_Info_Ope];
			},[_joueur],5,{}] call CBA_fnc_waitUntilAndExecute;
		} foreach _liste_Joueurs_Appel_Mon_Ent;
	},[],5,{}] call CBA_fnc_waitUntilAndExecute;
} else
{
	private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
	if (_MRP_Appel_Etat in ["Appel CA en cours"]) then
	{
		private _mon_Ent = player getVariable ["isEmployed",""];
		
		if (_mon_Ent isequalto "") then {
			if (life_gendarme_service) then 
			{
			_mon_Ent = "1";
			};
			if (life_pompier_service) then 
			{
			_mon_Ent = "2";
			};
			if (life_penit_service) then 
			{
			_mon_Ent = "3";
			};
		};
		
		if (_mon_Ent isequalto -1) then
		{
			private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
			private _numero_Enregistrer = (_tel_CA_Info_Ope get "Mon appel") # 0;

			[_numero_Enregistrer] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Pause_Variables;
		};

		player setvariable ["MRP_Appel_Etat",nil];
	};
	
	player setvariable ["MRP_Tel_CA_Info_Operateur",nil];

	// Suppr marqueur de suivis collègue
	{deleteMarkerLocal _x;} foreach MRP_Dispatch_Liste_Suivis;
	MRP_Dispatch_Liste_Suivis = nil;

	// Gestion sortis service, freq radio et raccourcis TFAR alors que dans Dispatch
	if !(isnil {MRP_Telephone_Info_Dispatch}) then
	{
		// sortis canal GLOBAL
		[(call TFAR_fnc_ActiveSwRadio),0] call TFAR_fnc_setSwChannel;
		[(call TFAR_fnc_ActiveSwRadio),2,""] call TFAR_fnc_SetChannelFrequency;

		private _canal_Supp = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel;

		if (_canal_Supp isEqualTo 1) then {[(call TFAR_fnc_ActiveSwRadio),1] call TFAR_fnc_setAdditionalSwChannel;};

		private _configuration_Raccourcis_TFAR = ["TFAR","SWTransmitAdditional"] call CBA_fnc_getKeybind;
		_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
		_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
		_configuration_Raccourcis_TFAR set [8,TRUE];

		_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;

		// Sortis canal unite
		[(call TFAR_fnc_ActiveSwRadio),0] call TFAR_fnc_setSwChannel;
		[(call TFAR_fnc_ActiveSwRadio),1,""] call TFAR_fnc_SetChannelFrequency;

		private _configuration_Raccourcis_TFAR = ["TFAR","SWTransmit"] call CBA_fnc_getKeybind;
		_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
		_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
		_configuration_Raccourcis_TFAR set [8,TRUE];

		_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;


		MRP_Telephone_Info_Dispatch = nil;
	};
};

TRUE
// };