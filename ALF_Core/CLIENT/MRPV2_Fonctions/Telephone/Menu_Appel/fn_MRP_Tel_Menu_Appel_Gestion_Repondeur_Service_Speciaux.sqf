// MRPV2_fnc_MRP_Tel_Menu_Appel_Gestion_Repondeur_Service_Speciaux = {
private _son_Repondeur = param [0,""];


private _source_son_Repondeur = objnull;

if (isnil {MRP_Telephone_Liste_Sons_Repondeur}) then {MRP_Telephone_Liste_Sons_Repondeur = [];};

if (isnil {MRP_Telephone}) then
{
	if (isnil {MRP_Telephone_Source_Son}) then {[player] call MRPV2_fnc_MRP_Tel_Divers_Crea_Son;};

	_source_son_Repondeur = MRP_Telephone_Source_Son say3D _son_Repondeur;
} else
{
	_source_son_Repondeur = MRP_Telephone say3D _son_Repondeur;	
};

MRP_Telephone_Liste_Sons_Repondeur pushback _source_son_Repondeur;

[{params ["_source_son_Repondeur"];
	(isnull _source_son_Repondeur OR {isnil {MRP_Telephone_Liste_Sons_Repondeur}})
},
{params ["_source_son_Repondeur","_son_Repondeur"];
	if (isnil {MRP_Telephone_Liste_Sons_Repondeur}) exitwith {};

	[_son_Repondeur] spawn
	{params ["_son_Repondeur"];
		sleep 5;

		if (isnil {MRP_Telephone_Liste_Sons_Repondeur}) exitwith {};

		MRP_Telephone_Liste_Sons_Repondeur = MRP_Telephone_Liste_Sons_Repondeur select {!isnull _x};

		[_son_Repondeur] call MRPV2_fnc_MRP_Tel_Menu_Appel_Gestion_Repondeur_Service_Speciaux;
	};
},[_source_son_Repondeur,_son_Repondeur]] call CBA_fnc_waitUntilAndExecute;

TRUE
// };