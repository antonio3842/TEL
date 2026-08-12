[
	{
		MRP_Telephone_Duree_Appel = MRP_Telephone_Duree_Appel + 1;

		private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
		if (_MRP_Appel_Etat isequalto "" OR {isnil {MRP_Telephone_Duree_Appel}}) exitwith
		{
			[_this # 1] call CBA_fnc_removePerFrameHandler;
			MRP_Telephone_Duree_Appel = nil;
		};

		[] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Affichage_Duree_Appel;
	},
	1,
	[]
] call CBA_fnc_addPerFrameHandler;

TRUE