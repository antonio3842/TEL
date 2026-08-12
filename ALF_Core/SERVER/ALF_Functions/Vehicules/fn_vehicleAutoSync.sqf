/*
	Copyright 2023

	Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

	Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

	More information at kainnon@getyourpath.fr

	All rights reserved.
	______________________________________________________________________

	File: fn_vehicleAutoSync.sqf
	Author: ALF Team
*/

diag_log "isequalto= VEHICLE AUTOSAVE SUCCESS isequalto=";

{
    private _veh = _x;

    if (alive _veh) then 
	{
        if (_veh getVariable ["MRP_TaxiNoPersistence", false]) exitWith {};
        if (_veh getVariable ["MRP_DistribNoPersistence", false]) exitWith {};

        private _dbInfo = _veh getVariable ["dbInfo", []];

        if (count _dbInfo > 0) then 
		{
            private _uid = _dbInfo select 0;
            private _plate = _dbInfo select 1;

            private _vehBusiness = _veh getVariable ["business_veh", []];
            private _fuel = fuel _veh;
            private _dir = getDir _veh;
            private _pos = getPosATL _veh;

            // Gestion de la position et direction
            if (!(_pos isEqualType [] AND {count _pos isequalto 3})) then 
			{
                diag_log "WARNING: Invalid position data. Using default.";
                _pos = [0, 0, 1];
            };
            if !(_dir isEqualType 0) then 
			{
                diag_log "WARNING: Invalid direction data. Using default.";
                _dir = 0;
            };

            private _position = [_pos, _dir];
            private _position2 = [round(_pos select 0), round(_pos select 1), round(_pos select 2)];

            // Gestion des dommages
            private _damage = [];
            if (getAllHitPointsDamage _veh isNotequalto []) then {_damage = (getAllHitPointsDamage _veh) # 2;};
            
            // Inventaire du véhicule
			private _inventaire = [_veh] call MRPV2_Server_fnc_Vehicule_Inventaire_Sauvegarde;
            private _inHome = 0;

            // Vérification si le véhicule est à la maison
            if (_veh isKindOf "Car") then 
			{
                if (_inHome isequalto 0 AND {count _vehBusiness > 0}) then 
				{
                    private _business = nearestObjects [_pos, ["Land_ALF_Entreprise"], 30];
                    if (count _business > 0) then 
					{
                        {
                            private _var = _x getVariable ["business", []];
                            if (count _var > 0) then 
							{
                                private _siretstr = _var select 2;
                                if (_siretstr isEqualTo (_vehBusiness select 0)) then {_inHome = 1;};
                            };
                        } forEach _business;
                    };
                };
            } else 
			{
                if (_veh isKindOf "Air") then 
				{
                    private _helipad = nearestObject [position _veh, "Land_Helipad"];
                    if (_veh distance _helipad < 10) then {_inHome = 1;};
                } else 
				{
                    if (_veh isKindOf "Ship") then 
					{
                        private _dock = nearestObject [position _veh, "Land_PierWooden_01_dock_F"];
                        if (_veh distance _dock < 10) then {_inHome = 1;};
                    };
                };
            };

            // Prépare la requête SQL pour sauvegarder les données
            private _query = "";
            switch (_veh getVariable ["vehicle_info_owners",["",""]] # 1) do 
			{
                case "Gendarmerie": 
				{
                    _query = format 
					[
                        "UPDATE vehicles_cop SET fuel='%1', position='%2', pos_save='%3', damage='%4', isInHome='%5', gear='%6' WHERE plate='%7'",
                        _fuel, _position, _position2, _damage, _inHome, _inventaire, _plate
                    ];
                };
                case "Pompiers": 
				{
                    _query = format 
					[
                        "UPDATE vehicles_med SET fuel='%1', position='%2', pos_save='%3', damage='%4', isInHome='%5', gear='%6' WHERE plate='%7'",
                        _fuel, _position, _position2, _damage, _inHome, _inventaire, _plate
                    ];
                };
                case "policemunicipale": 
				{
                    _query = format 
					[
                        "UPDATE vehicles_penit SET fuel='%1', position='%2', pos_save='%3', damage='%4', isInHome='%5', gear='%6' WHERE plate='%7'",
                        _fuel, _position, _position2, _damage, _inHome, _inventaire, _plate
                    ];
                };
                default 
				{
                    _query = format 
					[
                        "UPDATE vehicles SET fuel='%1', position='%2', pos_save='%3', damage='%4', isInHome='%5', gear='%6' WHERE pid='%7' AND plate='%8'",
                        _fuel, _position, _position2, _damage, _inHome, _inventaire, _uid, _plate
                    ];
                };
            };

            diag_log format ["QUERY TO EXECUTE: %1", _query];

            private _result = [_query, 1] call ALF_Server_fnc_asyncCall;
            if (isNil "_result" OR {_result isEqualTo "any"}) then 
			{
                diag_log "WARNING: Query did not return a valid result.";
                _result = "undefined";
            };

            // Exécute la requête SQL
            [_query, 1] call ALF_Server_fnc_asyncCall;
			diag_log format ["QUERY RESULT: %1", _result];
        };
    };
} forEach (entities [["Car", "Air", "Ship"], [], false, true]);

diag_log "isequalto= VEHICLE AUTOSAVE SUCCESS isequalto=";
