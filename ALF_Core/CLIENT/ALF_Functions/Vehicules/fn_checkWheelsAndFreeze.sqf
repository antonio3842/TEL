/*
File: fn_checkWheelsAndFreeze.sqf
Author: ALF Team
Description: Vérifie si une roue manque (damage = 1.0) et bloque le mouvement du véhicule
*/

private _vehicle = param [0, objNull, [objNull]];

if (isNull _vehicle) exitWith {};

// Vérifier si une boucle de vérification est déjà en cours pour ce véhicule
if (_vehicle getVariable ["ALF_WheelCheckRunning", false]) exitWith {};
_vehicle setVariable ["ALF_WheelCheckRunning", true, false];

// Fonction pour vérifier les roues (définie dans missionNamespace pour être accessible partout)
if (isNil "ALF_fnc_checkWheelsInternal") then {
	missionNamespace setVariable ["ALF_fnc_checkWheelsInternal", {
		private _veh = _this select 0;
		private _wheelHitPoints = [];
		
		// Vérifier le type de véhicule et définir les hitpoints de roues appropriés
		if (_veh isKindOf "Car") then {
			_wheelHitPoints = ["HitLFWheel", "HitLF2Wheel", "HitRFWheel", "HitRF2Wheel"];
		} else {
			if (_veh isKindOf "Truck") then {
				_wheelHitPoints = ["HitLFWheel", "HitLF2Wheel", "HitRFWheel", "HitRF2Wheel", "HitLMWheel", "HitLBWheel", "HitRMWheel", "HitRBWheel"];
			} else {
				if (_veh isKindOf "Motorcycle") then {
					_wheelHitPoints = ["HitLFWheel", "HitLF2Wheel"];
				} else {
					// Pour les autres types de véhicules, utiliser les roues standard
					_wheelHitPoints = ["HitLFWheel", "HitLF2Wheel", "HitRFWheel", "HitRF2Wheel", "HitLMWheel", "HitLBWheel", "HitRMWheel", "HitRBWheel", "HitFWheel", "HitBWheel"];
				};
			};
		};
		
		// Vérifier si au moins une roue manque complètement (damage = 1.0)
		private _hasMissingWheel = false;
		{
			private _damage = _veh getHitPointDamage _x;
			if (!isNil "_damage" && {_damage >= 1.0}) then {
				_hasMissingWheel = true;
			};
		} forEach _wheelHitPoints;
		
		_hasMissingWheel
	}];
};

// Ajouter un event handler pour empêcher le démarrage du moteur si une roue manque
private _ehId = _vehicle addEventHandler ["Engine", {
	private _veh = _this select 0;
	private _engineState = _this select 1;
	
	// Si le moteur essaie de démarrer, vérifier les roues
	if (_engineState) then {
		private _hasMissingWheel = [_veh] call ALF_fnc_checkWheelsInternal;
		if (_hasMissingWheel) then {
			_veh engineOn false;
			if (driver _veh isEqualTo player) then {
				// Vérifier le cooldown pour éviter le spam de notifications
				private _lastNotification = _veh getVariable ["ALF_WheelNotificationTime", 0];
				private _currentTime = time;
				
				// Afficher la notification seulement si plus de 5 secondes se sont écoulées depuis la dernière
				if ((_currentTime - _lastNotification) >= 5) then {
					["Véhicule", "Le véhicule ne peut pas démarrer : une roue manque", "danger"] spawn ALF_fnc_doMsg;
					_veh setVariable ["ALF_WheelNotificationTime", _currentTime, false];
				};
			};
		};
	};
}];

_vehicle setVariable ["ALF_WheelEngineEH", _ehId, false];

// Boucle de vérification continue
[_vehicle] spawn {
	private _vehicle = _this select 0;
	private _wasBlocked = false; // Suivre l'état précédent pour éviter les notifications répétées
	private _engineStopScheduled = false; // Suivre si l'arrêt du moteur est déjà programmé
	private _wheelMissingNotified = false; // Suivre si la notification de roue manquante a été affichée
	
	while {alive _vehicle && {player in crew _vehicle}} do {
		// Vérifier si une roue manque
		private _hasMissingWheel = [_vehicle] call ALF_fnc_checkWheelsInternal;
		
		// Si une roue manque, bloquer le mouvement du véhicule
		if (_hasMissingWheel) then {
			// Afficher la notification dès qu'une roue manque est détectée (une seule fois)
			if (!_wheelMissingNotified && {driver _vehicle isEqualTo player}) then {
				["Véhicule", "Le véhicule est endommagé : arrêtez-vous en sécurité", "warning"] spawn ALF_fnc_doMsg;
				_wheelMissingNotified = true;
			};
			
			// Programmer l'arrêt du moteur après un délai (seulement si pas déjà programmé)
			if (isEngineOn _vehicle && !_engineStopScheduled) then {
				_engineStopScheduled = true;
				// Arrêter le moteur après un délai et afficher une notification
				[_vehicle] spawn {
					private _veh = _this select 0;
					sleep 15.0; // Délai avant d'arrêter le moteur
					if (alive _veh && {isEngineOn _veh}) then {
						_veh engineOn false;
						if (driver _veh isEqualTo player) then {
							["Véhicule", "Le moteur s'est arrêté automatiquement pour votre sécurité", "warning"] spawn ALF_fnc_doMsg;
						};
					};
				};
			};
			
			// Bloquer le mouvement en mettant la vélocité à zéro
			//_vehicle setVelocity [0, 0, 0];
			
			// Empêcher l'accélération
			_vehicle setVariable ["ALF_WheelBlocked", true, true];
			_wasBlocked = true;
		} else {
			// Si toutes les roues sont OK, permettre le mouvement
			_vehicle setVariable ["ALF_WheelBlocked", false, true];
			_engineStopScheduled = false; // Réinitialiser le flag d'arrêt programmé
			_wheelMissingNotified = false; // Réinitialiser le flag de notification
			
			// Si le véhicule était bloqué et maintenant réparé, réinitialiser le cooldown de notification
			if (_wasBlocked) then {
				_vehicle setVariable ["ALF_WheelNotificationTime", 0, false];
				_wasBlocked = false;
			};
		};
		
		// Attendre un peu avant la prochaine vérification
		sleep 0.1;
	};
	
	// Nettoyer les event handlers et variables quand le joueur sort du véhicule
	private _ehId = _vehicle getVariable ["ALF_WheelEngineEH", -1];
	if (_ehId >= 0) then {
		_vehicle removeEventHandler ["Engine", _ehId];
		_vehicle setVariable ["ALF_WheelEngineEH", nil, false];
	};
	
	_vehicle setVariable ["ALF_WheelCheckRunning", false, false];
	_vehicle setVariable ["ALF_WheelBlocked", false, true];
};

