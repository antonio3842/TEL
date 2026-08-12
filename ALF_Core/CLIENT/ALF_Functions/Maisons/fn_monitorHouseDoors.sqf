/*
	File: fn_monitorHouseDoors.sqf
	Description: Intercepte l'ouverture des portes de maisons et affiche une notification si le joueur n'est pas proprietaire
	
	OPTIMISATION PERFORMANCE:
	- uiSleep passe de 0.1s a 0.5s (5x moins de charge CPU)
	- Suppression de tous les systemChat de debug
	- Code simplifie et optimise
*/
if (!hasInterface) exitWith {};

[] spawn {
	private _publicBuildings = ["Land_mrp_garage", "Land_mrp_gendarmerie_principale", "Land_MRP_Prefecture2"];
	
	while {true} do {
		uiSleep 0.5;  // OPTIMISE: 0.5s au lieu de 0.1s
		
		// Verifier seulement le batiment que le joueur regarde
		private _house = cursorObject;
		if (isNull _house) then {continue};
		if (!(_house isKindOf "House_F" || _house isKindOf "House")) then {continue};
		
		private _houseType = typeOf _house;
		
		// Ignorer les batiments publics
		if (_houseType in _publicBuildings) then {continue};
		
		// Verifier si la maison a un proprietaire
		private _houseOwner = _house getVariable ["house_owner", nil];
		if (isNil "_houseOwner" || {count _houseOwner == 0}) then {continue};
		
		// Verifier si le joueur est le proprietaire
		private _ownerUID = _houseOwner select 0;
		private _playerUID = getPlayerUID player;
		private _isOwner = (_ownerUID == _playerUID) || (_house in life_vehicles);
		
		// Si le joueur est proprietaire, ne pas verifier
		if (_isOwner) then {continue};
		
		// Si le joueur n'est pas proprietaire et que la porte est verrouillee
		private _porteFermer = _house getVariable ["ALF_PorteFermer", false];
		if (!_porteFermer) then {continue};
		
		// Verifier le nombre de portes
		private _numberOfDoors = getNumber(configFile >> "CfgVehicles" >> _houseType >> "numberOfDoors");
		if (_numberOfDoors <= 0 || _numberOfDoors == -1) then {continue};
		
		// Verifier chaque porte
		for "_i" from 1 to _numberOfDoors do {
			private _doorPos = _house selectionPosition format["Door_%1_trigger",_i];
			private _distance = player distance (_house modelToWorld _doorPos);
			
			if (_distance < 3) then {
				// Verifier si la porte commence a s'ouvrir
				private _doorPhase = _house animationSourcePhase format ["Door_%1_sound_source", _i];
				
				// Si la porte commence a s'ouvrir (phase > 0.01)
				if (_doorPhase > 0.01) then {
					// Bloquer l'ouverture immediatement
					_house animateSource [format ["Door_%1_sound_source", _i], 0];
					_house animate [format ["Door_%1", _i], 0];
					
					// Afficher la notification
					["INFO", "Cette maison ne vous appartient pas.", "warning"] spawn ALF_fnc_doMsg;
				};
			};
		};
	};
};
