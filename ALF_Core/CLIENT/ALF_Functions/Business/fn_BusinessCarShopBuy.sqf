// ALF_fnc_businessCarShopBuy = {
params [["_param", false, [false]]];

if((time - life_action_delay) < 0.5) exitWith {
	["INFO", "Vous appuyez trop vite.", "warning"] spawn ALF_fnc_doMsg;
};
life_action_delay = time;

private _className = lbData[2302,(lbCurSel 2302)];
private _vIndex = lbValue[2302,(lbCurSel 2302)];
private _classNameLife = _className;
private _vehicleList = ["ARRAY", ["CarShops", (life_veh_shop # 0), "vehicles"]] call ALFTools_Client_Config_fnc_getConfig;
private _purchasePrice = ["NUMBER", ["LifeCfgVehicles",_classNameLife,"achat"]] call ALFTools_Client_Config_fnc_getConfig;
private _purchasePriceOriginal = _purchasePrice;

private _batimentEarly = objNull;
private _shouldReducePriceEarly = false;
if (!isNil "life_veh_shop" && {count life_veh_shop >= 4}) then {
	_batimentEarly = life_veh_shop # 3;
	if (!isNull _batimentEarly) then {
		private _bizDataEarly = _batimentEarly getVariable ["business", []];
		if (count _bizDataEarly >= 5) then {
			private _secteurEarly = _bizDataEarly # 4;
			if (typeName _secteurEarly == "STRING") then {
				_secteurEarly = parseNumber _secteurEarly;
			};
			if (_secteurEarly == 33) then {
				_shouldReducePriceEarly = true;
				_purchasePrice = _purchasePrice * 0.5;
			};
		};
	};
};

private _shopName = "";
if (!isNil "life_veh_shop" && {count life_veh_shop > 0}) then {
	_shopName = life_veh_shop # 0;
};

private _batiment = objNull;
if (!isNil "life_veh_shop" && {count life_veh_shop >= 4}) then {
	_batiment = life_veh_shop # 3;
	if (!isNull _batiment) then {
		private _bizData = _batiment getVariable ["business", []];
		if (count _bizData >= 5) then {
			private _secteur = _bizData # 4;
			if (typeName _secteur == "STRING") then {
				_secteur = parseNumber _secteur;
			};
			if (_secteur == 33) then {
				if (_shopName != "b_33") then {
					_shopName = "b_33";
				};
			};
		};
	};
};


private _shouldReducePrice = false;
if (_shopName isEqualTo "b_33") then {
	_shouldReducePrice = true;
} else {
	if (!isNull _batiment) then {
		private _bizDataPrice = _batiment getVariable ["business", []];
		if (count _bizDataPrice >= 5) then {
			private _secteurPrice = _bizDataPrice # 4;
			if (typeName _secteurPrice == "STRING") then {
				_secteurPrice = parseNumber _secteurPrice;
			};
			if (_secteurPrice == 33) then {
				_shouldReducePrice = true;
				_shopName = "b_33";
			};
		};
	};
};

if (_shouldReducePrice && !_shouldReducePriceEarly) then {
	_purchasePrice = _purchasePrice * 0.5;
};

if (isNull _batiment && !isNil "life_veh_shop" && {count life_veh_shop >= 4}) then {
	_batiment = life_veh_shop # 3;
};

if(isNull _batiment) exitWith {
	["INFO", "Erreur dans le systeme.", "warning"] spawn ALF_fnc_doMsg;
};

if(_purchasePrice < 0) exitWith {closeDialog 0;};

private _var = _batiment getVariable ["business",[]];
private _capitalstr = _var # 3;
private _siretstr = _var # 2;
private _membres = _var # 5;
private _levelstr = _var # 6;
private _vehnumber = _var # 7;

// if(_levelstr isEqualTo 0 AND {_vehnumber > 5}) exitWith {["INFO", "Il faut agrandir le batiment si vous voulez acheter un nouveau véhicule.", "warning"] spawn ALF_fnc_doMsg; closeDialog 0;};

if(_capitalstr < _purchasePrice) then {
	// Permettre de payer avec le compte personnel si le capital est insuffisant
	private _handle = [_purchasePrice,false] call ALF_fnc_handleCB;
	if(_handle) exitWith {
		closeDialog 0;
	};
	
	// Le paiement a été effectué, continuer avec l'achat
	[name player,getPlayerUID player,"ENTREPRISE",format["A acheté %1 pour %2€ par carte (capital insuffisant).",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call ALF_fnc_numberText]] remoteExec ["ALF_Server_fnc_logIt",2];
};

// S'assurer que le prix réduit est bien utilisé - FORCER la valeur
// Vérifier à nouveau si on doit réduire le prix (au cas où la détection n'a pas fonctionné)
if (!_shouldReducePrice && !_shouldReducePriceEarly) then {
	// Vérifier à nouveau via le secteur
	if (!isNull _batiment) then {
		private _bizDataFinal = _batiment getVariable ["business", []];
		if (count _bizDataFinal >= 5) then {
			private _secteurFinal = _bizDataFinal # 4;
			if (typeName _secteurFinal == "STRING") then {
				_secteurFinal = parseNumber _secteurFinal;
			};
			if (_secteurFinal == 33) then {
				_shouldReducePrice = true;
			};
		};
	};
};

if (_shouldReducePrice && !_shouldReducePriceEarly) then {
	private _finalPrice = _purchasePriceOriginal * 0.5;
	_purchasePrice = _finalPrice;
};

private _action = ["Etes-vous certain de vouloir acheter ce vehicule pour votre entreprise ?","Entreprise","OUI","NON"] call BIS_fnc_guiMessage;
if (!_action) exitWith {["INFO","Annulation..","warning"] spawn ALF_fnc_doMsg; closeDialog 0;};
closeDialog 0;

if(_capitalstr >= _purchasePrice) then {
	_capitalstr = _capitalstr - _purchasePrice;
};
_var set[3,_capitalstr];
_vehnumber = _vehnumber + 1;
_var set[7,_vehnumber];
_batiment setVariable ["business",_var,true];

[_siretstr,_capitalstr] remoteExec ["ALF_Server_fnc_capitalBusiness",2];

private _color = "";
private _textureC = ["NUMBER", ["LifeCfgVehicles", _className, "textures"]] call ALFTools_Client_Config_fnc_getConfig;
if (_textureC isEqualTo 1) then {_color = lbData[2304,(lbCurSel 2304)];};

["INFO", format["Merci d'avoir acheté chez nous. Détail de votre commande : %1 pour %2€",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call ALF_fnc_numberText], "success"] spawn ALF_fnc_doMsg;

// private _dir = life_veh_shop # 2;
private _vehicule = createVehicle [_className,[0,0,500 + random 500], [], 0, "NONE"];
waitUntil {sleep 0.3; !isNil {_vehicule} AND {!isNull _vehicule}}; 
_vehicule allowDamage false; 

/* === Air spawn → nearest helipad (client-side buy) === */
private _isAir = _className isKindOf "Air";
private _placedAlready = false;
if (_isAir) then {
    private _centerRef = if (!isNil "_batiment" && {!isNull _batiment}) then {_batiment} else {player};
    private _pads = nearestObjects [
        _centerRef,
        ["Land_HelipadCivil_F", "Land_HelipadSquare_F", "Land_HelipadEmpty_F"],
        500
    ];

    if ((count _pads) > 0) then {
        private _pad    = _pads # 0;
        private _padPos = getPosATL _pad;
        private _padDir = getDir _pad;

        private _safePos = _padPos;
        private _try = _padPos findEmptyPosition [0, 6, _className];
        if (!(_try isEqualTo [])) then { _safePos = _try };

        _vehicule setVelocityModelSpace [0,0,0];
        _vehicule setPosATL _safePos;
        _vehicule setDir _padDir;

        // Altitude correction for low landing gear
        private _bb = boundingBoxReal _vehicule;
        private _minZ = (_bb # 0) # 2;
        if (_minZ < 0) then {
            private _alt = (_safePos # 2) + (abs _minZ) + 0.02;
            _vehicule setPosATL [_safePos # 0, _safePos # 1, _alt];
        };
        _placedAlready = true;
    };
};
// _vehicule setPos _spawnPoint;
// _vehicule setVectorUp (surfaceNormal _spawnPoint);
// _vehicule setDir _dir;

private _bbox = boundingBoxreal [_vehicule,"firegeometry"];
private _taille_X = abs (_bbox # 0 # 2);
private _taille_Y = abs (_bbox # 1 # 2);
private _rayon_Detection = _taille_X + _taille_Y;

private _useB33Spawn = false;
private _pos_Garage = [0,0,0];
private _dir_Garage = 0;

// Vérifier aussi via le secteur du bâtiment si le shop name ne correspond pas
// ET vérifier que c'est bien un bâtiment concessionnaire
private _isB33BySecteur = false;
private _isConcessionnaire = false;
if (!isNull _batiment) then {
	// Vérifier que c'est bien un Land_MRP_Concessionnaire
	_isConcessionnaire = (typeOf _batiment == "Land_MRP_Concessionnaire");
	
	private _bizDataSpawn = _batiment getVariable ["business", []];
	if (count _bizDataSpawn >= 5) then {
		private _secteurSpawn = _bizDataSpawn # 4;
		if (typeName _secteurSpawn == "STRING") then {
			_secteurSpawn = parseNumber _secteurSpawn;
		};
		_isB33BySecteur = (_secteurSpawn == 33);
	};
};

if ((_shopName isEqualTo "b_33" || _isB33BySecteur) && _isConcessionnaire) then {
	if (_isB33BySecteur && _shopName != "b_33") then {
		_shopName = "b_33";
	};

	private _classNameLower = toLower _className;
	
	private _findActros = _classNameLower find "actros";
	private _findDaf = _classNameLower find "daf";
	private _findPremium = _classNameLower find "premium";
	
	private _isCamion = (_findActros >= 0) || (_findDaf >= 0) || (_findPremium >= 0);
	
	if (_isCamion) then {
		_pos_Garage = [6787.4,7356.6,-0.023983];
		_dir_Garage = 296.605;
		_useB33Spawn = true;
	} else {
		_pos_Garage = [6790.7,7355.51,0.00406933];
		_dir_Garage = 296.605;
		_useB33Spawn = true;
	};
};


if (!_useB33Spawn) then {
	private _pos_Garage_Externe = (_batiment getrelpos [18,-157]);
	_pos_Garage = (_batiment getrelpos [8,-70]);
	private _pos_Garage_Z = getposatl player # 2;

	if (_rayon_Detection > 4) then {_pos_Garage = _pos_Garage_Externe;};

	// Véhicules dont la taille n'est pas correctement détectée
	private _vehicules_Trop_Gros = [
		"VEH_Mercura_MRP_Man_TGS_Dep"
	];
	// Si le véhicule est dans le tableau, on force la position externe
	if (_className in _vehicules_Trop_Gros) then {_pos_Garage = _pos_Garage_Externe;};
	
	_dir_Garage = (getdir _batiment) + 180;
};

private _objets_Proches = _pos_Garage nearEntities [["Car","Air","Tank","Ship"],_rayon_Detection];

if ((_placedAlready) || (_objets_Proches isEqualTo [])) then {
	
	if (!(_isAir) && !(_placedAlready)) then {
		if (_useB33Spawn) then {
			_vehicule setPosATL _pos_Garage;
			_vehicule setDir _dir_Garage;
			_vehicule setVectorUp (surfaceNormal _pos_Garage);
		} else {
			private _pos_Garage_Z = getposatl player # 2;
			_vehicule setposatl (_pos_Garage vectorAdd [0,0,_pos_Garage_Z + 0.3]);
			_vehicule setVectorUp (surfaceNormal _pos_Garage);
			_vehicule setdir _dir_Garage;
		};
	};

	_vehicule lock 2;
	[_vehicule,TRUE] remoteExec ["lockInventory",0];
	[_vehicule] call ALF_fnc_clearVehicleAmmo;
	_vehicule addMagazineCargoGlobal ["ALF_Roue",2];
	_vehicule setVariable ["vehicle_info_owners",[name player,getPlayerUID player],true];
	_vehicule disableTIEquipment true;
	_vehicule animateSource ["assu", 1, true];
	_vehicule animateSource ["tracker", 1, true];
	
	_vehicule setVariable ["business_veh",[_siretstr],true];
	[_vehicule] spawn {params ["_vehicule"]; sleep 2; _vehicule allowDamage true;};

	if (_color isnotequalto "") then {_vehicule setObjectTextureGlobal [0,_color];};

	private _um = [];
	{
		_um pushBack (_x # 1);
	} forEach _membres;

	[_vehicule] remoteExecCall ["ALF_fnc_addVehicle2Chain",(playableUnits select {(getPlayerUID _x) in _um})];

	private _arr = missionNamespace getVariable [format["%1_KEYSB",_siretstr],[]];
	_arr pushBack _vehicule;
	_arr = _arr - [objNull];
	missionNamespace setVariable[format["%1_KEYSB",_siretstr],_arr,true];
} else 
{
	["INFO", "Un véhicule gène le point de sortie du garage.", "warning"] spawn ALF_fnc_doMsg;	
};

[(getPlayerUID player),_vehicule,_siretstr,player,[],count _objets_Proches] remoteExec ["ALF_Server_fnc_vehicleCreateBusiness",2];

[name player,getPlayerUID player,"ENTREPRISE",format["A acheté %1 pour %2€.",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_purchasePrice] call ALF_fnc_numberText]] remoteExec ["ALF_Server_fnc_logIt",2];

closeDialog 0;
// };