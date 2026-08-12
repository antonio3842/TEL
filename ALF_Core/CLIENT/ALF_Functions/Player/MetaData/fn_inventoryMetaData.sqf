/*
 
Copyright 2023
 
Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.
 
Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
 
More information at kainnon@getyourpath.fr
 
All rights reserved.
 
*/
 
if (isServer) exitWith {};
if !(hasInterface) exitWith {};
 
disableSerialization;
 
waitUntil {!isNull (findDisplay 602)};
 
private _display = findDisplay 602;
private _groundContainer = _display displayCtrl 632;
private _soldierContainer = _display displayCtrl 640;
private _uniformContainer = _display displayCtrl 633;
private _vestContainer = _display displayCtrl 638;
private _backpackContainer = _display displayCtrl 619;
 
// Cache pour éviter les recalculs inutiles
private _lastSizes = createHashMap;
_lastSizes set [632, -1];
_lastSizes set [640, -1];
_lastSizes set [633, -1];
_lastSizes set [638, -1];
_lastSizes set [619, -1];
 
// Cache des noms d'affichage déjà calculés
private _displayNameCache = createHashMap;
 
/* -- Each elements in  each list -- */
private _updateContainer = {
	private _ctrlId = ctrlIDC _this;
	private _currentSize = lbSize _this;
	private _lastSize = _lastSizes getOrDefault [_ctrlId, -1];
	
	// Ne mettre à jour que si la taille a changé ou si c'est la première fois
	if (_currentSize != _lastSize) then {
		_lastSizes set [_ctrlId, _currentSize];
		
		for '_i' from 0 to (_currentSize - 1) do {
			private _lbData = (_this lbData _i);
			if (_lbData isEqualTo "") then {continue};
 
			// Vérifier le cache d'abord
			private _cachedName = _displayNameCache getOrDefault [_lbData, ""];
			if (_cachedName isNotEqualTo "") then {
				_this lbSetText [_i, _cachedName];
				continue;
			};
 
			/* -- Get from meta data array -- */
			private _allMetaData = (missionNamespace getVariable ["ALF_MetaData", createHashMap]);
			private _values = _allMetaData getOrDefault [_lbData, []];
 
			if (_values isEqualTo []) then {continue};
 
			private _returnClass = [["ALF_MetaData", _values#0]] call ALFTools_Client_Config_fnc_isClass;
			if !(_returnClass) then {continue};
			
			private _displayName = ["STRING", ["ALF_MetaData", _values#0, "displayName"]] call ALFTools_Client_Config_fnc_getConfig;
			private _aDisplayName = (_values#1 call compile _displayName);
 
			// Mettre en cache et appliquer
			_displayNameCache set [_lbData, _aDisplayName];
			_this lbSetText [_i, _aDisplayName];
		};
	};
};
 
// Système événementiel : mettre à jour uniquement quand nécessaire
// Utiliser un intervalle plus long (0.3s) et vérifier les changements
private _updateLoop = {
	private _display = findDisplay 602;
	if (isNull _display) exitWith {};
	
	_groundContainer call _updateContainer;
	_soldierContainer call _updateContainer;
	_uniformContainer call _updateContainer;
	_vestContainer call _updateContainer;
	_backpackContainer call _updateContainer;
};
 
// Boucle optimisée avec vérification de changement
while {!isNull (findDisplay 602)} do {
	call _updateLoop;
	sleep 0.3; // Intervalle augmenté de 0.1 à 0.3s (3x moins de CPU)
};