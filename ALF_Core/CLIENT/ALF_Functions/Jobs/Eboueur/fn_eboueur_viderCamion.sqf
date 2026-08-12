/*
    File: fn_eboueur_viderCamion.sqf
    Author: MRP
    Description: Vide le camion à la déchetterie
*/

if (!alive player) exitWith {};

if (!(player getVariable ["MRP_Eboueur_EnService", false])) exitWith {
    ["Éboueur", "Vous n'êtes pas en service!", "danger"] spawn ALF_fnc_doMsg;
};

private _camion = player getVariable ["MRP_Eboueur_Camion", objNull];

if (isNull _camion) exitWith {
    ["Éboueur", "Camion introuvable!", "danger"] spawn ALF_fnc_doMsg;
};

if (player distance _camion > 15) exitWith {
    ["Éboueur", "Camion trop loin!", "danger"] spawn ALF_fnc_doMsg;
};

// Récupération du nombre d'ordures (variable système)
private _nbOrdures = _camion getVariable ["MRP_Eboueur_NbOrdures", 0];

// Vérification des items dans le coffre (backup check)
private _itemsCoffre = getMagazineCargo _camion;
private _orduresDansCoffre = 0;
private _autresItemsDansCoffre = 0;

if (count _itemsCoffre > 0) then {
    private _items = _itemsCoffre select 0;
    private _quantites = _itemsCoffre select 1;
    
    {
        if (_x isEqualTo "MRP_Ordure") then {
            _orduresDansCoffre = _orduresDansCoffre + (_quantites select _forEachIndex);
        } else {
            _autresItemsDansCoffre = _autresItemsDansCoffre + (_quantites select _forEachIndex);
        };
    } forEach _items;
};

// Vérifier aussi magazines, armes, sacs
private _magsCoffre = getMagazineCargo _camion;
private _weaponsCoffre = getWeaponCargo _camion;
private _backpacksCoffre = getBackpackCargo _camion;

if (count (_magsCoffre select 0) > 0) then {
    private _quantites = _magsCoffre select 1;
    {_autresItemsDansCoffre = _autresItemsDansCoffre + _x} forEach _quantites;
};

if (count (_weaponsCoffre select 0) > 0) then {
    private _quantites = _weaponsCoffre select 1;
    {_autresItemsDansCoffre = _autresItemsDansCoffre + _x} forEach _quantites;
};

if (count (_backpacksCoffre select 0) > 0) then {
    private _quantites = _backpacksCoffre select 1;
    {_autresItemsDansCoffre = _autresItemsDansCoffre + _x} forEach _quantites;
};

// Vérifier si le camion est vraiment vide
if (_nbOrdures isEqualTo 0 && _orduresDansCoffre isEqualTo 0 && _autresItemsDansCoffre isEqualTo 0) exitWith {
    ["Éboueur", "Camion vide!", "warning"] spawn ALF_fnc_doMsg;
};

if (_camion getVariable ["MRP_Eboueur_VidageEnCours", false]) exitWith {
    ["Éboueur", "Vidage déjà en cours!", "warning"] spawn ALF_fnc_doMsg;
};

// Calculer le salaire (uniquement pour les ordures)
private _orduresTotales = _nbOrdures max _orduresDansCoffre;
private _salaire = _orduresTotales * 300;
private _playerZone = player getVariable ["MRP_Eboueur_Zone", ""];
private _uid = player getVariable ["MRP_Eboueur_Collegue", ""];

private _collegues = count (allPlayers select {
    isPlayer _x &&
    {_x getVariable ["MRP_Eboueur_EnService", false]} &&
    {(_x getVariable ["MRP_Eboueur_Collegue", ""]) isEqualTo _uid} &&
    {_x distance player < 50}
});

if (_collegues >= 3) then {
    _salaire = _orduresTotales * 250;
};

_camion setVariable ["MRP_Eboueur_VidageEnCours", true, true];

_camion lock 2;



{
	if (isPlayer _x && {_x getVariable ["MRP_Eboueur_EnService", false]}) then {
		["Éboueur", "Restez proche de vos collègues le temps du vidage.", "info"] remoteExec ["ALF_fnc_doMsg", _x];
	};
} forEach (allPlayers select {_x distance player < 50});


[_camion, _orduresTotales, _salaire, _autresItemsDansCoffre] spawn {
    params ["_camion", "_nbOrdures", "_salaire", "_autresItems"];
	private _uid = player getVariable ["MRP_Eboueur_Collegue", ""];
	
	_posav = getpos _camion;
    // ANIMATION COMPLÈTE: 20 sec ouverture + 20 sec fermeture = 40 sec total
    // NOTE: Plus la valeur de vitesse est BASSE, plus l'animation est LENTE
    
    // === PHASE 1: OUVERTURE (20 secondes) ===
    // Vitesse = 20 / 20 = 1 (pour parcourir 20 unités en 20 secondes)
    _camion animateSource ["vidage_camion_source", 20, 1];
    uiSleep 20.5;
    
    // === PAUSE AU SOMMET (2 secondes) ===
    // C'est ICI que le camion se vide (pendant que la benne est levée)
    
    // VIDER TOUT LE CONTENU DU CAMION
    clearItemCargoGlobal _camion;
    clearMagazineCargoGlobal _camion;
    clearWeaponCargoGlobal _camion;
    clearBackpackCargoGlobal _camion;
    
    // Reset variable ordures
    _camion setVariable ["MRP_Eboueur_NbOrdures", 0, true];
    
    // Reset jauge visuelle
    _camion animateSource ["ordure_10_source", 0];
    _camion animateSource ["ordure_50_source", 0];
    _camion animateSource ["ordure_100_source", 0];
    
    // Pause pour voir la benne levée
    uiSleep 2;
    
    // === PHASE 2: FERMETURE (20 secondes) ===
    // Vitesse = 20 / 20 = 1 (pour parcourir 20 unités en 20 secondes)
    _camion animateSource ["vidage_camion_source", 0, 1];
    uiSleep 20.5;
    
    _camion lock 0;
    _camion setVariable ["MRP_Eboueur_VidageEnCours", false, true];


	_posap = getpos _camion;
	
	if !(_posap isEqualTo _posav) exitWith {
		_camion animateSource ["ordure_100_source", 1];
		_camion setVariable ["MRP_Eboueur_NbOrdures", _nbOrdures, true];
		["Éboueur", "Le camion a bougé, annulation du vidage", "warning"] spawn ALF_fnc_doMsg;
	};	

	
	if (_nbOrdures >= 50) then {
		private _playerZone = player getVariable ["MRP_Eboueur_Zone", ""];
		["Éboueur", "Tournée terminé, voici votre nouvelle tournée", "success"] spawn ALF_fnc_doMsg;
		private _EboueurZoneList = missionNamespace getVariable ["MRP_Eboueur_ZoneDispo", []];
		private _EboueurZoneTourne = selectRandom _EboueurZoneList;

		while {_EboueurZoneTourne == _playerZone} do {
			_EboueurZoneTourne = selectRandom _EboueurZoneList;
		};		
		
		player setVariable ["MRP_Eboueur_Zone", _EboueurZoneTourne, true];
		private _ville = "";

		switch (_EboueurZoneTourne) do {
			case "AU" : {_ville = "L'Autoroute"};
			case "VA" : {_ville = "Le Vauclin"};
			case "FR" : {_ville = "Le François"};
			case "TR" : {_ville = "Trinité"};
			case "LO" : {_ville = "Le Lorrain"};
			case "MA" : {_ville = "Grand'Rivière"};
			case "ST" : {_ville = "Saint Pierre"};
			case "FD" : {_ville = "Fort-De-France"};
			case "AN" : {_ville = "Les Ansles D'Arlet"};
			case "MR" : {_ville = "Le Marin"};
		};

		{
			if (isPlayer _x && {_x getVariable ["MRP_Eboueur_EnService", false]} && {(_x getVariable ["MRP_Eboueur_Collegue", ""]) isEqualTo _uid}) then {
				_x setVariable ["MRP_Eboueur_Zone", _EboueurZoneTourne, true];
				["Éboueur", "Regarder avec votre collègue la nouvelle mission.", "success"] remoteExec ["ALF_fnc_doMsg", _x];
				[_salaire] remoteExec ["ALF_fnc_eboueur_payerJoueur", _x];
			};
		} forEach (allPlayers select {_x distance player < 50});

		private _msg = format ["Voici votre nouveau secteur : %1 (Position indiqué sur votre GPS)", _ville];
		["Éboueur", _msg, "success"] spawn ALF_fnc_doMsg;
	} else {
		["Éboueur", "Vous devez vider 50 sacs afin d'avoir une nouvelle tournée", "waring"] spawn ALF_fnc_doMsg;
	};
};

