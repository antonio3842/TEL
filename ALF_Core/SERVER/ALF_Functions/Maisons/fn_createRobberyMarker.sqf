/*
	File: fn_createRobberyMarker.sqf
	Description: Crée un marqueur de cambriolage et l'envoie uniquement aux gendarmes
*/

params[
	["_markerCenter", [0,0,0], [[]]],
	["_radius", 250, [0]]
];

if (_markerCenter isEqualTo [0,0,0]) exitWith {};

// Génère un nom unique pour le marqueur
private _mkrName = format ["Cambriolage_%1", floor diag_tickTime];

// Préparer les informations du marqueur
private _markerInfo = [
	_mkrName,                    // 0: nom
	"Cambriolage en cours",      // 1: texte
	_markerCenter,               // 2: position
	0,                           // 3: direction
	[_radius, _radius],          // 4: taille
	"",                          // 5: type
	"ELLIPSE",                   // 6: forme
	"SolidBorder",               // 7: brush
	"ColorRed",                  // 8: couleur
	0.5                          // 9: alpha
];

// Envoyer à tous les joueurs - filtrage côté client pour fiabilité
// (life_coplevel et life_gendarme_service ne sont pas synchronisés côté serveur)
private _allPlayers = playableUnits;
if (_allPlayers isNotEqualTo []) then {
	[_markerInfo] remoteExec ["ALF_fnc_createRobberyMarkerClient", _allPlayers];
	
	// Programmer la suppression après 5 minutes (300 secondes)
	[_mkrName, _allPlayers] spawn {
		params ["_markerName", "_players"];
		sleep 300; // sleep côté serveur
		[_markerName] remoteExec ["deleteMarkerLocal", _players];
	};
};

