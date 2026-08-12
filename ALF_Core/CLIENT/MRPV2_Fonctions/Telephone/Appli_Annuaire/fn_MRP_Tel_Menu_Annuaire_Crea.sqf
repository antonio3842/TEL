// MRPV2_fnc_MRP_Tel_Menu_Annuaire_Crea = {
disableserialization;
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Menu_Bloc_Note\Menu_Note_Vide_dxt5.paa";

private _ctrl_Titre = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
uiNamespace setvariable ["MRP_Tel_Menu_Annuaire",_ctrl_Titre];
_ctrl_Titre ctrlSetPosition [0.05,0.12,0.45,0.1];
_ctrl_Titre ctrlCommit 0;

_ctrl_Titre ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#000000' size='2' align='left'>%1</t>","Annuaire"];

// Champ recherche
_edit = _Telephone_Base ctrlCreate ["RscEdit",645,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.08,0.23,0.4,0.06];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetBackgroundColor [1,1,1,1];
_edit ctrlSetFontHeight 0.05;
_edit ctrlSetTextColor [0,0,0,1];
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["KeyDown",
{params ["_displayOrControl"];
	[_displayOrControl,30] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

_edit ctrlAddEventHandler ["KeyUp",
{params ["_displayOrControl"];
	[_displayOrControl,30] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;

	private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
	[_liste_Entreprise] call MRPV2_fnc_MRP_Tel_Menu_Annuaire_Gestion_Liste;
}];

[] spawn MRPV2_fnc_MRP_Tel_Menu_Annuaire_Call_API;

// On fait un appel API et on attend la liste d'entreprise
[{
	!isnil {MRP_Telephone_Annuaire}
},
{
	// rangement par ouvertes first après les 3 service publiques
	_serviceP = MRP_Telephone_Annuaire select [0,3];
	_toOrder = MRP_Telephone_Annuaire select [3,count MRP_Telephone_Annuaire];
		
	_ordered = [];
	{
		if (_x getOrDefault ["OPEN",true]) then {_ordered pushBack _x;};
		
	} forEach _toOrder;
	{
		if !(_x getOrDefault ["OPEN",false]) then {_ordered pushBack _x;};
		
	} forEach _toOrder;
	MRP_Telephone_Annuaire = _serviceP + _ordered;
	[MRP_Telephone_Annuaire] call MRPV2_fnc_MRP_Tel_Menu_Annuaire_Gestion_Liste;
	profilenamespace setvariable ["MRP_Tel_Liste_Entreprise",MRP_Telephone_Annuaire];
	MRP_Telephone_Annuaire = nil;
},[],3,{}] call CBA_fnc_waitUntilAndExecute;

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };