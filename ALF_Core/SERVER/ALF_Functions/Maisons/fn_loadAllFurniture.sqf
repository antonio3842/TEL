/*
	File: fn_loadAllFurniture.sqf
	Description: Charge tous les meubles depuis la base de données pour toutes les maisons
*/
diag_log "[FURNITURE] Début du chargement de tous les meubles...";

// Vérifier que les variables de mobilier sont initialisées
if (isNil "ALF_Mobiliers_Objects" || isNil "ALF_Mobiliers_Objects_Data") then {
	diag_log "[FURNITURE] ERREUR: Variables ALF_Mobiliers_Objects non initialisées ! Attente de 5 secondes...";
	sleep 5;
	if (isNil "ALF_Mobiliers_Objects" || isNil "ALF_Mobiliers_Objects_Data") then {
		diag_log "[FURNITURE] ERREUR CRITIQUE: Variables toujours non initialisées après attente !";
	} else {
		diag_log "[FURNITURE] Variables initialisées après attente.";
	};
};

// Vérifier à nouveau avant de continuer
if (isNil "ALF_Mobiliers_Objects" || isNil "ALF_Mobiliers_Objects_Data") exitWith {
	diag_log "[FURNITURE] Impossible de continuer sans les variables de mobilier.";
};

diag_log format["[FURNITURE] Variables OK - %1 objets de mobilier disponibles", count ALF_Mobiliers_Objects];

// Récupérer toutes les maisons avec leur ID
private _houses = ["SELECT id, pid, pos, classname FROM houses",2,true] call ALF_Server_fnc_asyncCall;

if (_houses isEqualTo []) exitWith {
	diag_log "[FURNITURE] Aucune maison trouvée dans la base de données.";
};

diag_log format["[FURNITURE] %1 maisons trouvées, chargement des meubles...", count _houses];

private _totalFurniture = 0;

{
	private _id_house = _x # 0;
	private _uid = _x # 1;
	private _pos = call compile format["%1", _x # 2];
	private _classname = _x # 3;

	// Trouver la maison dans le monde
	private _house = objNull;
	if (_classname != "") then {
		_house = nearestObject [_pos, _classname];
	} else {
		_house = nearestObject [_pos, "House"];
	};

	if !(isNull _house) then {
		// Vérifier si la maison a des meubles
		private _count = ([format ["SELECT COUNT(*) FROM mobiliers WHERE pid='%1' AND id_house='%2'", _uid, _id_house],2] call ALF_Server_fnc_asyncCall) # 0;

		if (_count > 0) then {
			diag_log format["[FURNITURE] Maison ID %1 (%2) : %3 meubles à charger", _id_house, _uid, _count];
			// Charger les meubles par lots de 10
			for [{_i=0},{_i<_count},{_i=_i+10}] do {
				private _queryResult = [format["SELECT pos, classname, gear, dir, id, code FROM mobiliers WHERE pid='%2' AND id_house='%3' LIMIT %1,10", _i, _uid, _id_house],2,true] call ALF_Server_fnc_asyncCall;
				if (_queryResult isEqualTo []) exitWith {};

				{
					private _p = call compile format["%1", _x # 0];

					private _classname = _x # 1;
					private _index = ALF_Mobiliers_Objects find _classname;
					if (_index > -1) then {
						diag_log format["[FURNITURE] Création meuble: %1 à la position %2", _classname, _p];
						private _data = ALF_Mobiliers_Objects_Data # _index;
						private "_obj";

						if ((_x # 1) in ["Land_ALF_Plante_W_2","Land_ALF_Coco"]) then {
							_obj = (_x # 1) createVehicle [0,0,0];
							_obj allowDammage false;
							[_obj,true] remoteExecCall ["enableDynamicSimulation",2];
						} else {
							_obj = createSimpleObject [_data, _p];
						};

						_obj setPosWorld _p;
						_obj setDir (call compile format["%1",_x # 3]);
						_obj setVariable ["mobilier_data",[_uid,(_x # 4),(_x # 1),_house,(_x # 5),true]];
						// Protéger le meuble contre Objets_Carte_En_Objet_Simple
						_obj setVariable ["MRP_Unbreakable", true, true];

						private _gear = [_x # 2] call ALF_Server_fnc_mresToArray;
						if(_gear isEqualType "") then {_gear = call compile format["%1", _gear];};

						{
							if !(_x isEqualType []) then {continue};

							private _newItemClass = [_x] call ALFTools_Server_MD_T_fnc_checkMetaData;
							if (_newItemClass isEqualTo "") then {continue};
							if (_newItemClass isEqualTo -1) then {
								_gear set[_forEachIndex, ""];
								continue;
							};

							_gear set[_forEachIndex, _newItemClass];
						} forEach _gear;

						_obj setVariable ["gear",_gear,true];

						private _var = _house getVariable ["mobiliers",[]];
						_var pushBack _obj;
						_house setVariable ["mobiliers",_var];

						_totalFurniture = _totalFurniture + 1;
					} else {
						diag_log format["[FURNITURE] ERREUR: Classname %1 non trouvé dans ALF_Mobiliers_Objects", _classname];
					};
				} forEach _queryResult;
			};
		} else {
			diag_log format["[FURNITURE] Maison ID %1 (%2) : aucun meuble", _id_house, _uid];
		};
	} else {
		diag_log format["[FURNITURE] ERREUR: Maison non trouvée à la position %1 (ID: %2)", _pos, _id_house];
	};
} forEach _houses;

diag_log format["[FURNITURE] Chargement terminé : %1 meubles chargés.", _totalFurniture];