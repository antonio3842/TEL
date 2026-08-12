// ALF_fnc_buyHouseBusiness = {

_house = param [0,objNull,[objNull]];
private _uid = getPlayerUID player;

if (isNull _house) exitWith {};
if !(_house isKindOf "House_F") exitWith {};

// Vérifier si c'est un hangar
if !((typeOf _house) in ["Land_i_Shed_Ind_F","Land_SM_01_shed_F","Land_Hangar2","Land_entreprise1"]) exitWith {
	["ERREUR","Ce bâtiment n'est pas un hangar.","warning"] spawn ALF_fnc_doMsg;
};

// Vérifier si le hangar a déjà un propriétaire
if !(isNil {_house getVariable "house_owner"}) exitWith {
	["ERREUR","Ce hangar est déjà acheté.","warning"] spawn ALF_fnc_doMsg;
};

// Vérifier si le joueur est employé dans une entreprise
private _siret = player getVariable ["isEmployed",""];
if (_siret isEqualTo "") exitWith {
	["ERREUR","Vous devez être employé dans une entreprise pour acheter ce hangar.","warning"] spawn ALF_fnc_doMsg;
};

// Vérifier s'il y a un bâtiment entreprise à moins de 150m
private _batimentsEntreprise = nearestObjects [_house, ["Land_ALF_Entreprise"], 150];
private _batimentEntreprise = objNull;
{
	if (((_x getVariable ["business",["","",""]]) select 2) isEqualTo _siret) exitWith {
		_batimentEntreprise = _x;
	};
} forEach _batimentsEntreprise;

if (isNull _batimentEntreprise) exitWith {
	["ERREUR","Aucun bâtiment entreprise de votre entreprise trouvé à moins de 150m.","warning"] spawn ALF_fnc_doMsg;
};

// Récupérer les informations de l'entreprise
private _varBusiness = _batimentEntreprise getVariable ["business",[]];

if (count _varBusiness < 3) exitWith {
	["ERREUR","Erreur lors de la récupération des informations de l'entreprise.","warning"] spawn ALF_fnc_doMsg;
};

// Vérifier que le joueur est le patron (owner) de l'entreprise
private _owner = _varBusiness select 0;
if (_owner isNotEqualTo _uid) exitWith {
	["ERREUR","Vous devez être le patron de l'entreprise pour acheter ce hangar.","warning"] spawn ALF_fnc_doMsg;
};

private _capital = _varBusiness select 3;
private _nomEntreprise = _varBusiness select 1; // Correction : le nom est à l'index 1, pas 0

closeDialog 0;

// Récupérer la configuration du hangar
private _houseCfg = [(typeOf _house)] call ALF_fnc_houseConfig;
if(count _houseCfg isEqualTo 0) exitWith {};

// Vérifier que le capital est suffisant
if (_capital < (_houseCfg # 0)) exitWith {
	["ERREUR",format["Le capital de l'entreprise (%1€) est insuffisant pour acheter ce hangar (%2€).",[_capital] call ALF_fnc_numberText,[(_houseCfg # 0)] call ALF_fnc_numberText],"warning"] spawn ALF_fnc_doMsg;
};

private _action = 
[
	format["Voulez-vous acheter ce hangar pour %1€ et le lier à l'entreprise (SIRET: %2) ?",
	[(_houseCfg # 0)] call ALF_fnc_numberText,
	_siret],"Achat Hangar Entreprise","Acheter","Annuler"
] call BIS_fnc_guiMessage;

if(_action) then 
{
	// Retirer l'argent du capital de l'entreprise
	private _newCapital = _capital - (_houseCfg # 0);
	_varBusiness set[3,_newCapital];
	_batimentEntreprise setVariable ["business",_varBusiness,true];
	[_siret,_newCapital] remoteExec ["ALF_Server_fnc_capitalBusiness",2];

	// Appeler la fonction serveur pour ajouter le hangar et le lier à l'entreprise
	[_uid,_house,profileName,getposatl _house,typeof _house,_siret] remoteExec ["ALF_Server_fnc_addHouseBusiness",2];

	[name player,getPlayerUID player,"MAISON",format["A acheté un hangar pour l'entreprise (SIRET: %1) pour %2€ | POS : %3 | HANGAR : %4.",_siret,(_houseCfg # 0), getPos _house, typeOf _house]] remoteExec ["ALF_Server_fnc_logIt",2];

	_house setVariable ["uid",floor(random 99999)];

	// Définir immédiatement les variables localement pour éviter le délai de synchronisation
	// Le serveur fera le broadcast complet, mais le client local aura déjà les données
	_house setVariable ["house_owner", [_uid, profileName], true];
	_house setVariable ["business", [_uid, format["Hangar de %1", _nomEntreprise], _siret, 0], true];

	life_vehicles pushBack _house;
	private _marker = createMarkerLocal [format["house_%1",(_house getVariable "uid")],getPosATL _house];
	private _houseName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >>  "displayName");
	_marker setMarkerTextLocal format["%1 - %2",_houseName,_siret];
	_marker setMarkerColorLocal "ColorOrange";
	_marker setMarkerTypeLocal "loc_Lighthouse";

	_house setVariable ["ALF_PorteFermer",true,true];
	
	["SUCCÈS",format["Hangar acheté et lié à l'entreprise (SIRET: %1).",_siret],"success"] spawn ALF_fnc_doMsg;
};
// };