if (!(isnil {MRP_Telephone_Info_Dispatch}) AND {count MRP_Telephone_Info_Dispatch isNotEquaLTo 0}) then
{
	{
		private _texte = _y;

		private _liste_Collegues = (allplayers select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)isEquaLTo ([] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)}) - [player];
		if (_liste_Collegues isnotequalto []) then {[_texte,"deconnexion"] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue",_liste_Collegues];};
	} foreach MRP_Telephone_Info_Dispatch;

	player setvariable ["MRP_Telephone_Info_Dispatch",nil,TRUE];
	MRP_Telephone_Info_Dispatch = nil;

	[(call TFAR_fnc_ActiveSwRadio),0] call TFAR_fnc_setSwChannel;
	[(call TFAR_fnc_ActiveSwRadio),1,""] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_ActiveSwRadio),2,""] call TFAR_fnc_SetChannelFrequency;
	private _canal_Supp = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel;

	if (_canal_Supp isEqualTo 1) then {[(call TFAR_fnc_ActiveSwRadio),1] call TFAR_fnc_setAdditionalSwChannel;};
};

TRUE