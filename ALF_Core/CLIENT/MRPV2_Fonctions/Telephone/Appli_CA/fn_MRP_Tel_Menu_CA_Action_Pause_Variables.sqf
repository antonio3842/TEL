// MRPV2_fnc_MRP_Tel_Menu_CA_Action_Pause_Variables = {
private _numero = param [0,""];

private _joueur_Appellant = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (_numero)}) # 0;

_joueur_Appellant setvariable ["MRP_Tel_CA_Info_Appelant",[]];
[_joueur_Appellant,"MRP_Tel_CA_Info_Appelant"] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_syncSingleVar",_joueur_Appellant];


[{params ["_joueur_Appellant"];
	_joueur_Appellant getvariable ["MRP_Tel_CA_Info_Appelant",[]] isnotequalto []
},
{params ["_joueur_Appellant","_numero"];
	private _info_Appel_CA_Appelant = _joueur_Appellant getvariable ["MRP_Tel_CA_Info_Appelant",[]];
	private _liste_id_Appelants = _info_Appel_CA_Appelant # 3;
	private _service = _info_Appel_CA_Appelant # 5;
	
	private _service_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
	if (_service_Joueur isequalto "ENT") then {_service_Joueur = "Centre Appel"};

/*
	private _siret = _info_Appel_CA_Appelant # 5;
	private _building = objNull;
	{
	  // Rechercher sur le bâtiment principal (Land_ALF_Entreprise) ou les concessionnaires (Land_MRP_Concessionnaire)
	  if (((_x getVariable ["business",["","",""]]) select 2) isEqualTo _siret) exitWith {
			_building = _x;
		};
	} forEach ALF_allBusinesss;

	if (isNull _building) exitWith {};

	private _var = _building getVariable ["business",[]];
	private _name = _var select 1;
	_groupe = ((groups civilian) select {groupId _x isEqualto _name}) # 0;
	_liste_Unites_En_Service = (units _groupe);
*/

	_liste_Unites_En_Service = (units group player);

	systemchat format ["[Debu pause var] _liste_Unites_En_Service = %1",_liste_Unites_En_Service];

	if (count _liste_id_Appelants isequalto 2) then
	{
		[_service_Joueur] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Action_Repondeur",_joueur_Appellant];
		[_numero,"Pause civil simple",clientowner] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_joueur_Appellant];
		[_numero,"Pause opé simple",clientowner] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_liste_Unites_En_Service];
	} else
	{
		[_numero,"Pause civil multi",clientowner] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_joueur_Appellant];
		[_numero,"Pause opé multi",clientowner,_service] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_liste_Unites_En_Service];
	};

	// player setvariable ["MRP_Appel_Etat","Pause appel CA"];

	[] call MRPV2_fnc_MRP_Tel_Divers_Fin_Appel_TFAR;
	
	TRUE
},[_joueur_Appellant,_numero],5] call CBA_fnc_waitUntilAndExecute;
// };