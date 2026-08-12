private _uid = param [0,""];
private _batiment = param [1,objNull];
private _name = param [2,""];
private _pos = param [3,[0,0,0]];
private _type = param [4,""];
private _siret = param [5,""];

if (isNull _batiment) then 
{
	_batiment = (nearestTerrainObjects [_pos, [], 15] select {_type in str _x}) # 0;
};
if (isnil {_batiment}) exitwith {};

// Récupérer les informations complètes de l'entreprise depuis la base de données
private _query = format["SELECT owner, name, siret, capital, secteur, membres, level, type_Bat FROM business WHERE siret='%1' AND active='1' AND name NOT LIKE 'Hangar de%%' ORDER BY id ASC LIMIT 1",_siret];
private _businessResult = [_query,2] call ALF_Server_fnc_asyncCall;

if (!(_businessResult isEqualType []) || {count _businessResult == 0}) exitWith {
	_batiment setVariable ["mobiliers",[]];
};

// extDB3 peut retourner soit un tableau direct soit un tableau de tableaux selon la configuration
// Vérifier le format et extraire les données correctement
private _businessData = if ((_businessResult select 0) isEqualType []) then {
	// Format : [["owner", "name", ...]]
	_businessResult select 0
} else {
	// Format : ["owner", "name", ...]
	_businessResult
};

if (count _businessData >= 8) then {
	private _owner = _businessData # 0;
	private _nameBiz = _businessData # 1;
	private _siretBiz = _businessData # 2;
	private _capital = _businessData # 3;
	private _secteur = _businessData # 4;
	private _membres = _businessData # 5;
	private _level = _businessData # 6;
	private _type_Bat = _businessData # 7;
	
	// Insérer le hangar dans la table business avec le même SIRET pour le lier à l'entreprise
	// On utilise le même owner, siret, secteur, membres, level mais avec un nom spécifique "Hangar de [nom entreprise]" et capital à 0
	// Formater la position comme une string de tableau pour la base de données (même format que dans fn_createBusiness)
	private _posStr = str _pos;
	
	// Créer le nom du hangar : "Hangar de [nom entreprise]"
	private _hangarName = format["Hangar de %1", _nameBiz];
	// Échapper les apostrophes dans le nom pour éviter les erreurs SQL
	private _charArray = toArray _hangarName;
	private _escapedArray = [];
	{
		if (_x == 39) then { // 39 = code ASCII de l'apostrophe '
			_escapedArray pushBack 39;
			_escapedArray pushBack 39;
		} else {
			_escapedArray pushBack _x;
		};
	} forEach _charArray;
	_hangarName = toString _escapedArray;
	
	// Le capital du hangar est à 0 par défaut (c'est un hangar, pas le bâtiment entreprise principal)
	private _hangarCapital = 0;
	
	// Log pour déboguer
	
	_query = format["INSERT INTO business (owner, pos, name, siret, capital, secteur, membres, level, active, Type_Bat) VALUES ('%1','%2','%3','%4','%5','%6','%7','%8','1','%9')",_owner,_posStr,str _hangarName,_siretBiz,_hangarCapital,_secteur,_membres,_level,_type];
	[_query,1] call ALF_Server_fnc_asyncCall;
	
	uiSleep 0.3;
	
	// Récupérer l'ID du hangar dans la table business
	_query = format["SELECT id FROM business WHERE pos='%1' AND siret='%2' AND active='1'",_posStr,_siretBiz];
	private _businessIdResult = [_query,2] call ALF_Server_fnc_asyncCall;
	
	private _businessId = 0;
	if (!(_businessIdResult isEqualType []) || {count _businessIdResult == 0}) then {
		_businessId = 0;
	} else {
		private _businessIdRow = if ((_businessIdResult select 0) isEqualType []) then {
			_businessIdResult select 0
		} else {
			_businessIdResult
		};
		private _idValue = _businessIdRow select 0;
		_businessId = if (_idValue isEqualType 0) then { _idValue } else { parseNumber _idValue };
	};
	
	// Compter les véhicules de l'entreprise
	private _countVehResult = [format["SELECT COUNT(*) FROM vehicles WHERE type='%1' AND pid='%2'",_siretBiz,_owner],2] call ALF_Server_fnc_asyncCall;
	private _countVeh = 0;
	if (!(_countVehResult isEqualType []) || {count _countVehResult == 0}) then {
		_countVeh = 0;
	} else {
		private _countVehRow = if ((_countVehResult select 0) isEqualType []) then {
			_countVehResult select 0
		} else {
			_countVehResult
		};
		private _countValue = _countVehRow select 0;
		_countVeh = if (_countValue isEqualType 0) then { _countValue } else { parseNumber _countValue };
	};
	
	// Récupérer le nom du propriétaire
	private _nameownerquery = format["SELECT name FROM players WHERE playerid = '%1'",_owner];
	private _nameownerResult = [_nameownerquery,2] call ALF_Server_fnc_asyncCall;
	private _nameowner = "";
	if (!(_nameownerResult isEqualType []) || {count _nameownerResult == 0}) then {
		_nameowner = "Moi";
	} else {
		private _nameownerRow = if ((_nameownerResult select 0) isEqualType []) then {
			_nameownerResult select 0
		} else {
			_nameownerResult
		};
		_nameowner = _nameownerRow select 0;
		if (_nameowner isEqualTo "") then {_nameowner = "Moi";};
	};
	
	// Créer le tableau business avec les informations du hangar (nom "Hangar de [entreprise]" et capital à 0)
	private _hangarNameForVar = format["Hangar de %1", _nameBiz];
	private _data = [_owner,_hangarNameForVar,_siretBiz,_hangarCapital,_secteur,_membres,_level,_countVeh,_nameowner,_type];
	
	// Lier le hangar à l'entreprise
	_batiment setVariable ["business", _data, true];
	_batiment setVariable ["business_id",_businessId];
	_batiment setVariable ["house_owner",[_uid,_name], true];
	_batiment setVariable ["mobiliers",[]];
} else {
	_batiment setVariable ["mobiliers",[]];
};