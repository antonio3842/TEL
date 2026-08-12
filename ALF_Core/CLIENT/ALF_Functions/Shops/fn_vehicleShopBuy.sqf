// Fichier : fn_vehicleShopBuy.sqf
// Auteur : Bryan "Tonic" Boardwine
// Modifié par : NorX Aengell & ARMA 3 Script GPT
// Fonction : ALF_fnc_vehicleShopBuy
// Description : Procédure d'achat de véhicules.

#include "\ALF_Client\script_macros.hpp"

if((time - life_action_delay) < 0.5) exitWith {["INFO", "Vous appuyez trop vite.", "warning"] spawn ALF_fnc_doMsg;};
life_action_delay = time;

private _exit = false;
private _className = lbData[2302,(lbCurSel 2302)];
private _vIndex = lbValue[2302,(lbCurSel 2302)];
private _classNameLife = _className;
private _vehicleList = ["ARRAY", ["CarShops", SEL(life_veh_shop,0), "vehicles"]] call ALFTools_Client_Config_fnc_getConfig;
private _licenses = ["STRING", [CONFIG_LIFE_VEHICLES, _classNameLife, "licenses"]] call ALFTools_Client_Config_fnc_getConfig;
private _purchasePrice = ["NUMBER", [CONFIG_LIFE_VEHICLES, _classNameLife, "achat"]] call ALFTools_Client_Config_fnc_getConfig;



if !(_licenses isEqualTo "") then 
{
	private _varnameConfig = ["STRING", ["Licenses", _licenses, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
	private _licenceConfigVal = missionNamespace getVariable [format["license_%1",_varnameConfig], false];
	if !(_licenceConfigVal) then {_exit = true;};
};
if(_exit) exitWith {["INFO", "Vous n'avez pas le permis requis.", "warning"] spawn ALF_fnc_doMsg; closeDialog 0;};
if(_purchasePrice < 0) exitWith {closeDialog 0;}; //Bad price entry

if(_purchasePrice > life_cash) then 
{
	private _handle = [_purchasePrice,false] call ALF_fnc_handleCB;
	if(_handle) exitWith {closeDialog 0; _exit = true;};
	[name player,getPlayerUID player,"VEHICULE",format["A acheté %1 pour %2€ par carte.",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call ALF_fnc_numberText]] remoteExec ["ALF_Server_fnc_logIt",2];
} else 
{
	life_cash = life_cash - _purchasePrice;
	[0] call SOCK_fnc_updatePartial;
	[name player,getPlayerUID player,"VEHICULE",format["A acheté %1 pour %2€ en espèce | Espèce apres achat : %3€.",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call ALF_fnc_numberText, life_cash]] remoteExec ["ALF_Server_fnc_logIt",2];
};
if(_exit) exitWith {closeDialog 0;};
closeDialog 0;

// Détecter le secteur selon le shop pour le spawn
private _shopName = life_veh_shop # 0;
private _magasinSpawn = _shopName;
if (_shopName isEqualTo "b_13") then {
	_magasinSpawn = "Secteur13_Garage";
} else {
	if (_shopName isEqualTo "b_23") then {
		_magasinSpawn = "Secteur23_Garage";
	};
};

private _vehicle = [_className,_magasinSpawn,player] call MRPV2_fnc_Vehicule_Creation;
if (isNull _vehicle OR {isNil "_vehicle"}) exitWith {
	["INFO", "Erreur lors de la commande du véhicule.", "warning"] spawn ALF_fnc_doMsg; 
	closeDialog 0;
};

// Attendre que le véhicule soit complètement créé et synchronisé
waitUntil {sleep 0.1; !isNil "_vehicle" AND {!isNull _vehicle} AND {alive _vehicle}};

["INFO", format["Merci de votre achat. Détail de votre commande : %1 pour %2€",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call ALF_fnc_numberText], "success"] spawn ALF_fnc_doMsg;

private _color = "";
private _textureC = ["NUMBER", ["LifeCfgVehicles", _className, "textures"]] call ALFTools_Client_Config_fnc_getConfig;
if (_textureC in [1,2]) then {_color = lbData[2304,(lbCurSel 2304)];};

if (isNull _vehicle) exitWith {["INFO", "Erreur : véhicule invalide.", "warning"] spawn ALF_fnc_doMsg;};

_vehicle lock 2;
if (_color != "") then {_vehicle setObjectTextureGlobal [0,_color];};

[_vehicle] call ALF_fnc_clearVehicleAmmo;
_vehicle addMagazineCargoGlobal ["ALF_Roue",2];
_vehicle disableTIEquipment true;
_vehicle animateSource ["assu", 1, true];
_vehicle animateSource ["tracker", 1, true];

if(_className in ["V_ALF_Megane_G_Gendarmerie","V_ALF_Berlingo_Gendarmerie","V_ALF_Subaru_Gendarmerie","V_ALF_GIGN","V_ALF_Titan_Gendarmerie","V_ALF_DV15_Gendarmerie","V_ALF_Vito_Gendarmerie","V_ALF_Berlingo2019G","ALF_Peugeot_3008_2021_GN","ALF_Peugeot_308_2022_GN","ALF_Peugeot_5008_2021_GN"]) then 
{
	_vehicle setVariable ["TF_RadioType", "alf_megaphone", true];
	{_vehicle setHit[_x,1];} forEach ["lightg01_h","lightg02_h","lightg03_h","lightg04_h","lightg05_h","lightg06_h","lightg07_h","lightg08_h"];
};

if(_vehicle isKindOf "Air") then 
{
	_vehicle setVariable ["TF_RadioType", "alf_radioheli", true];
	private _freq = random[1000, 5000, 9999];
	_vehicle setVariable ["helicofreq", _freq, true];
};

// Vérifier si c'est un achat d'entreprise (b_13 ou b_23)
private _shopName = life_veh_shop # 0;
private _isBusinessPurchase = _shopName in ["b_13","b_23"];
private _siret = "";

if (_isBusinessPurchase) then {
	_siret = player getVariable ["isEmployed",""];
	if (_siret isEqualTo "") exitWith {
		["INFO", "Vous devez être employé dans une entreprise pour acheter ce véhicule.", "warning"] spawn ALF_fnc_doMsg;
		deleteVehicle _vehicle;
	};
	
	// Récupérer le nom de l'entreprise
	private _batiment = nearestObjects [player, ["Land_ALF_Entreprise"], 50] select {
		((_x getVariable ["business",["","",""]]) select 2) isEqualTo _siret
	};
	
	private _nomEntreprise = "";
	if (count _batiment > 0) then {
		private _var = (_batiment # 0) getVariable ["business",[]];
		if (count _var > 0) then {
			_nomEntreprise = _var # 0;
		};
	};
	
	// Configuration comme véhicule d'entreprise
	// Pour que les clés soient marquées [PRET], vehicle_info_owners # 1 ne doit pas être égal à getPlayerUID player
	// On met le nom de l'entreprise et le SIRET au lieu du joueur
	_vehicle setVariable["vehicle_info_owners",[_nomEntreprise,_siret],true];
	_vehicle setVariable ["business_veh",[_siret],true];
	
	// Récupérer les membres de l'entreprise pour les clés
	private _batiment = nearestObjects [player, ["Land_ALF_Entreprise"], 50] select {
		((_x getVariable ["business",["","",""]]) select 2) isEqualTo _siret
	};
	
	private _membres = [];
	if (count _batiment > 0) then {
		_membres = (_batiment # 0) getVariable ["business",[]] select 5;
		if (isNil "_membres") then {_membres = [];};
	};
	
	// Ajouter les clés pour tous les membres de l'entreprise
	private _um = [];
	{_um pushBack (_x # 1);} forEach _membres;
	[_vehicle] remoteExecCall ["ALF_fnc_addVehicle2Chain",(playableUnits select {(getPlayerUID _x) in _um})];
	
	// Ajouter aux clés d'entreprise
	private _arr = missionNamespace getVariable [format["%1_KEYSB",_siret],[]];
	_arr pushBack _vehicle;
	_arr = _arr - [objNull];
	missionNamespace setVariable[format["%1_KEYSB",_siret],_arr,true];
	
	// Compter les véhicules proches pour le spawn (exclure le véhicule lui-même)
	private _bbox = boundingBoxreal [_vehicle,"firegeometry"];
	private _taille_X = abs (_bbox # 0 # 2);
	private _taille_Y = abs (_bbox # 1 # 2);
	private _rayon_Detection = _taille_X + _taille_Y;
	private _objets_Proches = (getPosATL _vehicle) nearEntities [["Car","Air","Tank","Ship"],_rayon_Detection];
	_objets_Proches = _objets_Proches - [_vehicle]; // Exclure le véhicule lui-même
	
	// S'assurer que le véhicule est bien synchronisé avec le serveur
	_vehicle setVariable ["business_veh",[_siret],true];
	
	// Utiliser la fonction d'entreprise (passer le shop name pour déterminer id_garage)
	[(getPlayerUID player),_vehicle,_siret,player,count _objets_Proches,_shopName] remoteExec ["ALF_Server_fnc_vehicleCreateBusiness",2];
} else {
	// Achat personnel normal
	_vehicle setVariable["vehicle_info_owners",["",getPlayerUID player],true];
	life_vehicles pushBack _vehicle;
	
	// Détecter le secteur selon le shop
	private _secteur = 0;
	if (_shopName isEqualTo "b_13") then {
		_secteur = 13;
	} else {
		if (_shopName isEqualTo "b_23") then {
			_secteur = 23;
		};
	};
	
	[(getPlayerUID player),_vehicle,player,_color,_secteur] remoteExec ["ALF_Server_fnc_vehicleCreate",2];
};

true