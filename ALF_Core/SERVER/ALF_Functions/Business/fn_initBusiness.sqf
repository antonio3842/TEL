// ALF_Server_fnc_initBusiness = {
private _count = (["SELECT COUNT(*) FROM business WHERE active='1'",2] call ALF_Server_fnc_asyncCall) # 0;
if !(isserver) exitwith {};
ALF_allBusinesss = [];

diag_log format["================================== ENTREPRISE LOADING (0/%1) ==================================", _count];

for [{_x=0},{_x<=_count},{_x=_x+10}] do 
{
	private _query = format["SELECT owner, pos, name, siret, capital, secteur, membres, level, type_Bat, tel FROM business WHERE active = '1' LIMIT %1,10",_x];
	diag_log format["ENTREPRISE : SELECT owner, pos, name, siret, capital, secteur, membres, level FROM business WHERE active = '1' LIMIT %1,10",_x];

	private _queryResult = [_query,2,true] call ALF_Server_fnc_asyncCall;

	if (count _queryResult isEqualTo 0) exitWith {diag_log format["ENTREPRISE EXIT 1 : %1", _x];};

	{
		private _owner = _x # 0;
		private _pos = parseSimpleArray (_x # 1);
		private _name = _x # 2;
		if (isNil "_name") then {_name = "";};
		if !(_name isEqualType "") then {_name = "";};
		private _siret = _x # 3;
		private _capital = _x # 4;
		private _secteur = _x # 5;
		private _membres = _x # 6;
		private _level = _x # 7;
		private _type_Bat = _x # 8;
		private _tel = _x # 9;
		private _open = false;

		private _countVeh = ([format["SELECT COUNT(*) FROM vehicles WHERE type='%1' AND pid='%2'",_siret,_owner],2] call ALF_Server_fnc_asyncCall) # 0;
		private _nameownerquery = format["SELECT name FROM players WHERE playerid = '%1'",_owner];
		private _nameowner = [_nameownerquery,2] call ALF_Server_fnc_asyncCall;

		private _data = [_owner,_name,_siret,_capital,_secteur,_membres,_level,_countVeh,[_nameowner # 0,"Moi"] select (_nameowner isEqualTo []),_type_Bat,_tel,_pos,_open];

		private _building = ((nearestTerrainObjects [_pos,["house","building"],50]) select {typeof _x isequalto _type_Bat}) # 0;

		if !(isnil {_building}) then
		{
			ALF_allBusinesss pushBack _building;
			_building setVariable ["business", _data, true];
			// Définir house_owner pour empêcher le rachat du bâtiment
			private _ownerNameRaw = if (_nameowner isEqualTo []) then {"Propriétaire"} else {_nameowner # 0};
			private _ownerName = if (_ownerNameRaw isEqualType []) then {_ownerNameRaw # 0} else {_ownerNameRaw};
			if !(_ownerName isEqualType "") then {_ownerName = "Propriétaire";};
			_building setVariable ["house_owner", [_owner, _ownerName], true];
			diag_log format["ENTREPRISE : %1 | %2", _building, _data];

			_name = _name splitstring "";

			{
				if (_x isnotequalto " ") then 
				{
					_building setObjectTextureGlobal [1 + _foreachindex,format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_x]];
				} else 
				{
					_building setObjectTextureGlobal [1 + _foreachindex,""];
				};
			} foreach _name;

			if (_level isEqualTo 1) then {_building animateSource ["level_source",1,true];};
			_building animateSource ["av_source",1,true];
			_building setVariable ["ALF_PorteFermer",true,true];

			// Nettoyer les mobiliers existants avant de charger les nouveaux (anti-duplication)
			private _existingMobiliers = _building getVariable ["mobiliers",[]];
			if (_existingMobiliers isNotEqualTo []) then {
				{
					if (!isNull _x) then {
						deleteVehicle _x;
					};
				} forEach _existingMobiliers;
			};
			_building setVariable ["mobiliers",[],true];

			// Récupérer l'ID de ce bâtiment spécifique dans la table business (pour filtrer les mobiliers)
			private _posString = _x # 1;
			private _businessIdQuery = format["SELECT id FROM business WHERE siret='%1' AND pos='%2' AND active='1'", _siret, _posString];
			private _businessIdResult = [_businessIdQuery, 2] call ALF_Server_fnc_asyncCall;
			private _businessId = -1;

			if (count _businessIdResult > 0) then {
				private _firstRow = _businessIdResult # 0;
				if (_firstRow isEqualType []) then {
					_businessId = parseNumber (_firstRow # 0);
				} else {
					if (_firstRow isEqualType 0) then {
						_businessId = _firstRow;
					} else {
						_businessId = parseNumber _firstRow;
					};
				};
			};

			// Filtrer les mobiliers par SIRET ET id_house pour éviter la duplication entre bâtiments
			private _mobiliers = [];
			if (_businessId >= 0) then {
				private _q2 = format["SELECT pid, pos, classname, gear, dir, id_house, code, id FROM mobiliers WHERE pid='%1' AND id_house='%2'", _siret, _businessId];
				_mobiliers = [_q2,2,true] call ALF_Server_fnc_asyncCall;
				diag_log format["ENTREPRISE MOBILIERS: siret=%1 businessId=%2 count=%3", _siret, _businessId, count _mobiliers];
			} else {
				diag_log format["ENTREPRISE WARNING: ID non trouvé pour siret=%1 pos=%2 - mobiliers non chargés", _siret, _posString];
			};

			if (_mobiliers isNotEqualTo []) then 
			{
				private "_vms";
				_vms = [];
				{
					private _pos = call compile format["%1",_x # 1];
					private _gear = [_x # 3] call ALF_Server_fnc_mresToArray;
					if (_gear isEqualType "") then {_gear = call compile format["%1", _gear];};

					// S'assurer que _gear est bien un array
					if !(_gear isEqualType []) then {
						_gear = [];
					};

					// /* -- Meta data update gear -- */
					// IMPORTANT: Nettoyer le gear au chargement pour éviter les doublons
					private _cleanedGear = [];
					{
						// Ignorer les entrées invalides
						if (_x isEqualType "") then {
							if (_x isEqualTo "") then {continue};
						};
						
						// Traiter les métadonnées
						private _newItemClass = [_x] call ALFTools_Server_MD_T_fnc_checkMetaData;
						if (_newItemClass isEqualTo "" || _newItemClass isEqualTo -1) then {
							continue; // Ignorer les items invalides
						};
						
						// Ajouter l'item traité (les répétitions sont normales pour plusieurs exemplaires)
						_cleanedGear pushBack _newItemClass;
					} forEach _gear;
					
					// Utiliser le gear nettoyé
					_gear = _cleanedGear;
					
					private _index = ALF_Mobiliers_Objects find (_x # 2);
					if (_index > -1) then 
					{
						private _data = ALF_Mobiliers_Objects_Data # _index;

						//EXEPTION POUR LA WEED et COCO HANGAR (CAUSE ANIMATION)
						private "_obj";
						if((_x # 2) in ["Land_ALF_Plante_W_2","Land_ALF_Coco"]) then 
						{
							_obj = (_x # 2) createVehicle [0,0,0];
							_obj allowDammage false;
							_obj enableDynamicSimulation true;
						} else 
						{
							_obj = createSimpleObject [_data,_pos];
						};
						
						if((_x # 2) isEqualTo "Land_ALF_Coco") then 
						{
							_obj setDir (getDir _building);
							_obj setPos (_building ModelToWorld [2.2168,2.05371,-1.83545])
						} else 
						{
							_obj setPosWorld (call compile format["%1",_x # 1]);
							_obj setDir (call compile format["%1",_x # 4]);
						};
						
						_obj setVariable ["mobilier_data",[(_x # 0),(_x # 7),(_x # 2),_building,(_x # 6),true]];
						_obj setVariable ["gear",_gear,true];

						_vms pushBack _obj;
					};
				} forEach _mobiliers;
				_building setVariable ["mobiliers",_vms,true];
			};
		};
	} forEach _queryResult;
};

publicVariable "ALF_allBusinesss";

diag_log format["================================== ENTREPRISE LOADED (%1/%1) ==================================", _count];
// }; [] call ALF_Server_fnc_initBusiness;