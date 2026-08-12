// MRPV2_fnc_Vehicule_Fourriere_Entrer = {
private _joueur = param [0,objnull]; 
private _duree = param [1,0]; 


private _ligne_Entrer_Fourriere = (("MRP_ligneparking" allObjects 0) select {player distance _x < 50}) # 0;
if (isnil {_ligne_Entrer_Fourriere}) exitwith {["FOURRIERE", "La zone de mise en fourrière n'est pas disponible.", "warning"] spawn ALF_fnc_doMsg;};

private _veh_Proche = (nearestObjects [_ligne_Entrer_Fourriere,["Car","air","tank"],20]) # 0;
if (isnil {_veh_Proche}) exitwith {["FOURRIERE", "Aucun véhicule proche de la zone de la mise en fourrière.", "warning"] spawn ALF_fnc_doMsg;};

if !(alive _veh_Proche) exitwith {["FOURRIERE", "Impossible de mettre une épave à la fourrière.", "warning"] spawn ALF_fnc_doMsg;};

[_veh_Proche,player,_duree] remoteExec ["ALF_Server_fnc_putInFourriere",2];

	private _building = objNull;
	{
	  // Rechercher sur le bâtiment principal (Land_ALF_Entreprise) ou les concessionnaires (Land_MRP_Concessionnaire)
	  if (((_x getVariable ["business",["","",""]]) select 2) isEqualTo (player getVariable ["isEmployed",""]) && {typeOf _x in ["Land_ALF_Entreprise", "Land_MRP_Concessionnaire"]}) exitWith {
			_building = _x;
		};
	} forEach ALF_allBusinesss;

	if (isNull _building) exitWith {};

	private _var = _building getVariable ["business",[]];
	private _capitalstr = _var select 3;
	private _siretstr = _var select 2;

	// Convertir le capital en nombre si c'est une string
	if (typeName _capitalstr == "STRING") then {
		_capitalstr = parseNumber _capitalstr;
	};

	private _newvalue = floor(_capitalstr + 1000);
	_var set[3,_newvalue];

	_building setVariable ["business",_var,true];

	[_siretstr,_newvalue] remoteExec ["ALF_Server_fnc_capitalBusiness",2];
// };