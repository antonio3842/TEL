// MRPV2_fnc_Vehicule_Casse = {


private _veh_Proche = (nearestObjects [player,["Car","air","tank"],50]) # 0;
if (isnil {_veh_Proche}) exitwith {["CASSE", "Aucun véhicule proche de la zone de la casse.", "warning"] spawn ALF_fnc_doMsg;};

if !(alive _veh_Proche) then {
	[_veh_Proche,1,player] remoteExec ["ALF_Server_fnc_createEpaveVehicle",2];
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
} else {
	["CASSE", "Le vhéicule n'est pas une épave.", "warning"] spawn ALF_fnc_doMsg;
};

// };