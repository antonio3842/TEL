// MRPV2_fnc_Vehicule_Fourriere_Sortir = {
private["_vehicle"];
disableSerialization;

if (lbCurSel 2802 isEqualTo -1) exitWith {hint localize "STR_Global_NoSelection"};

if (parsenumber MRPV2_Nombre_Temps_Restant_Fourriere > 0) exitWith 
{
	private _temps_Restant = numberToDate [systemTimeutc # 0,parsenumber MRPV2_Nombre_Temps_Restant_Fourriere];

	private _heures = 0;
	private _minutes = 0;

	if (_temps_Restant # 2 > 1) then 
	{
		_heures = _temps_Restant # 3 + (((_temps_Restant # 2)-1) * 24);
	} else 
	{
		_heures = _temps_Restant # 3;
	};
	
	_minutes = _temps_Restant # 4;
	
	["FOURRIERE",format ["Votre véhicule a encore %1h%2m d'immobilisation.",_heures,_minutes], "warning"] spawn ALF_fnc_doMsg;
	MRPV2_Nombre_Temps_Restant_Fourriere = nil;
};

private _ligne_Sortis_Fourriere = (("MRP_ligneparking_reserve" allObjects 0) select {player distance _x < 50}) # 0;
if (isnil {_ligne_Sortis_Fourriere}) exitwith {["FOURRIERE", "La zone de sortie de la fourrière n'est pas disponible.", "warning"] spawn ALF_fnc_doMsg;};

private _objets_Proches = _ligne_Sortis_Fourriere nearEntities [["Car","air","tank"],15] isnotequalto [];
if (_objets_Proches) exitWith {["INFO", "Un véhicule gène le point de sortie de la fourrière.", "warning"] spawn ALF_fnc_doMsg;};

private _prix_Sortie = ["NUMBER",["LifeCfgVehicles", MRPV2_ClassName_Fourr,"sortie"]] call ALFTools_Client_Config_fnc_getConfig;
private _quitter = false;

[] call 
{
	private _quitter_handle = false;
	if(_prix_Sortie <= life_cash) exitWith {life_cash = life_cash - _prix_Sortie;};

	private _handle = [_prix_Sortie,false] call ALF_fnc_handleCB;

	if (_handle) exitWith {_quitter = true;};
	if !(_handle) exitWith {_quitter_handle = true;};
	if (_quitter_handle) exitWith {};

	["FOURRIERE", "Vous n'avez pas assez d'argent sur vous ou votre compte pour récupérer votre véhicule.", "warning"] spawn ALF_fnc_doMsg;
	_quitter = true;
};
if (_quitter) exitWith {};

private _vehicle = [MRPV2_ClassName_Fourr,"Fourrière",player,MRPV2_Plaque_Fourr] call MRPV2_fnc_Vehicule_Creation;
if (isnull _vehicle) exitWith 
{
	["INFO", "Un véhicule gène le point de sortie.", "warning"] spawn ALF_fnc_doMsg; 
	closeDialog 0;
};

["FOURRIERE", "Votre véhicule est disponible sur la place de parking à l'intérieur de la fourrière.", "success"] spawn ALF_fnc_doMsg;

[] spawn 
{
	private _portail = (nearestTerrainObjects [player, [], 200] select {"land_MRP_Portail_2_OPEN" isequalto typeof _x}) # 0;
	_portail animate ["door",1];

	private _fourriere = (nearestTerrainObjects [player, [], 200] select {"Land_FuelStation_01_shop_F" isequalto typeof _x}) # 0;

	waitUntil 
	{
		sleep 360; 
		
		private _liste_Joueurs = allplayers select {_x distance _portail < 50};
		if (_liste_Joueurs isequalto []) exitwith 
		{
			_portail animate ["door",0];
			[_fourriere,1,0] spawn BIS_fnc_Door;
			[_fourriere,2,0] spawn BIS_fnc_Door;
			[_fourriere,3,0] spawn BIS_fnc_Door;
			TRUE
		};

		FALSE
	};
};

MRPV2_Nombre_Temps_Restant_Fourriere = nil;
MRPV2_ClassName_Fourr = nil;
MRPV2_Plaque_Fourr = nil;
[0] call SOCK_fnc_updatePartial;
closeDialog 0;
// };