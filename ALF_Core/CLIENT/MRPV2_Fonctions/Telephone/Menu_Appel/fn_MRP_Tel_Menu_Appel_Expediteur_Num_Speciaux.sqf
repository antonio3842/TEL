// MRPV2_fnc_MRP_Tel_Menu_Appel_Expediteur_Num_Speciaux = {
sleep 2;

0 spawn MRPV2_fnc_MRP_Tel_Menu_Annuaire_Call_API;

// On fait un appel API et on attend la liste d'entreprise
[{
	!isnil {MRP_Telephone_Annuaire}
},
{
	
	
	profilenamespace setvariable ["MRP_Tel_Liste_Entreprise",MRP_Telephone_Annuaire];
	MRP_Telephone_Annuaire = nil;
		
	private _liste_Annuaire = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
	private _info_Ent = ((_liste_Annuaire select {_x get "PHONE" isequalto MRP_Telephone_Numero_Appel}) # 0);
/*
	private _est_fermer = _info_Ent get "OPEN";
	if (_est_fermer isequalto 0) exitwith {};
*/
	private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
	if (_MRP_Appel_Etat in ["Arret tentative",""]) exitwith {};


	player setvariable ["MRP_Appel_Etat","Appel en cours",true];
	private _service_Appeler = "Centre Appel";

	private _name = "";

	private _service_Gendarmerie = MRP_Liste_Numeros_Services get "Gendarmerie";
	private _service_Pompier = MRP_Liste_Numeros_Services get "Pompier";
	private _service_policemunicipale = MRP_Liste_Numeros_Services get "policemunicipale";

	if (MRP_Telephone_Numero_Appel isEqualTo (_service_Gendarmerie # 0)) then {_service_Appeler = _service_Gendarmerie # 1;_name = "Gendarmerie";};
	if (MRP_Telephone_Numero_Appel isEqualTo (_service_Pompier # 0)) then {_service_Appeler = _service_Pompier # 1;_name = "Pompiers";};
	if (MRP_Telephone_Numero_Appel isEqualTo (_service_policemunicipale # 0)) then {_service_Appeler = _service_policemunicipale # 1;_name = "policemunicipale";};

	if (_MRP_Appel_Etat isEqualTo "Arret tentative") exitwith {};

	[] call MRPV2_fnc_MRP_Tel_Menu_Appel_En_Cours_Crea;

	[1] call MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo;
	[] call MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel;

	private _numero_Appelant_CA = player getvariable ["phoneNumber",""];
	[_numero_Appelant_CA] call MRPV2_fnc_MRP_Tel_Divers_Debut_Appel_TFAR;

	[_service_Appeler] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Repondeur;

	private _id_Entreprise = _info_Ent get "CID";
	[_numero_Appelant_CA,"Appel civil",clientowner,_id_Entreprise] call MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat;

if (_name == "") then {

	private _siret = _info_Ent get "CID";
	private _building = objNull;
	
	
	{
	  // Rechercher sur le bâtiment principal (Land_ALF_Entreprise) ou les concessionnaires (Land_MRP_Concessionnaire)
	  if (((_x getVariable ["business",["","",""]]) select 2) isEqualTo _siret) exitWith {
			_building = _x;
		};
	} forEach ALF_allBusinesss;

	if (isNull _building) exitWith {};

	private _var = _building getVariable ["business",[]];
		_name = _var select 1;

	};

	_groupe = ((groups civilian) select {groupId _x isEqualto _name}) # 0;
	_liste_Unites_En_Service = (units _groupe);
	
	[_numero_Appelant_CA,"Appel civil maj opé",clientowner,_id_Entreprise] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_liste_Unites_En_Service - [player]];
},[],3,{}] call CBA_fnc_waitUntilAndExecute;

TRUE
// };