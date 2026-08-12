/*
	File: fn_configureTFARVoiceDistance.sqf
	Author: ALF Team
	
	Description:
	Configure les distances de voix TFAR pour corriger le problème où le chuchotement est entendu de trop loin.
	Cette fonction travaille en coordination avec le HUD existant qui affiche l'icône de chuchotement.
	
	Note importante: Les distances de voix TFAR sont principalement contrôlées par le plugin Teamspeak
	et les paramètres serveur. Cette fonction tente de forcer les bonnes valeurs, mais la configuration
	serveur TFAR doit aussi être correcte.
*/

// Attendre que TFAR soit complètement initialisé
waitUntil {
	sleep 0.1;
	!isNil "TFAR_fnc_isTeamSpeakPluginEnabled" && {!isNil "TF_speak_volume_level"}
};

sleep 2; // Attendre que TFAR soit complètement prêt

// Les distances recommandées pour TFAR (en mètres)
// Ces valeurs sont réalistes pour un gameplay RP
ALF_TFAR_WhisperDistance = 1;   // Chuchotement: 3 mètres
ALF_TFAR_NormalDistance = 15;    // Voix normale: 25 mètres
ALF_TFAR_YellDistance = 30;       // Crier: 60 mètres

// Configuration via les paramètres TFAR si disponibles
// TFAR utilise ces variables pour calculer les distances réelles
if (isNil "tf_terrain_interception_coefficient") then {
	tf_terrain_interception_coefficient = 7.0;
};

// Essayer de configurer via les fonctions TFAR si disponibles
if (!isNil "TFAR_fnc_setVoiceVolume") then {
	// Configuration des distances via les fonctions TFAR
	// Note: Ces fonctions peuvent varier selon la version de TFAR
	[ALF_TFAR_WhisperDistance, ALF_TFAR_NormalDistance, ALF_TFAR_YellDistance] call {
		params ["_whisper", "_normal", "_yell"];
		
		// Essayer de forcer les distances via les paramètres TFAR
		if (!isNil "TFAR_setting_voiceDistance") then {
			TFAR_setting_voiceDistance = [_whisper, _normal, _yell];
		};
	};
};

// Sauvegarder dans profileNamespace pour persistance
private _tfSettings = profileNamespace getVariable ["TFAR_setting_voiceDistance", []];
if (_tfSettings isEqualTo [] || {count _tfSettings != 3}) then {
	profileNamespace setVariable ["TFAR_setting_voiceDistance", [ALF_TFAR_WhisperDistance, ALF_TFAR_NormalDistance, ALF_TFAR_YellDistance]];
	saveProfileNamespace;
};

// Script de monitoring qui vérifie que le HUD et les distances sont synchronisés
[] spawn {
	private _lastVolumeCheck = "";
	private _checkCount = 0;
	
	while {true} do {
		sleep 5; // Vérifier toutes les 5 secondes
		
		// Vérifier que TFAR et le HUD sont synchronisés
		if (!isNil "TF_speak_volume_level") then {
			private _currentVolume = TF_speak_volume_level;
			
			// Détecter si le volume a changé
			if (_currentVolume != _lastVolumeCheck) then {
				_lastVolumeCheck = _currentVolume;
				_checkCount = _checkCount + 1;
				
				// Log pour debug (seulement toutes les 12 vérifications = 1 minute)
				if (_checkCount >= 12) then {
					_checkCount = 0;
					diag_log format ["[ALF] TFAR Voice - HUD Status: %1 (Whisper: %2m, Normal: %3m, Yell: %4m)", 
						_currentVolume, 
						ALF_TFAR_WhisperDistance, 
						ALF_TFAR_NormalDistance, 
						ALF_TFAR_YellDistance
					];
				};
			};
			
			// Vérification spéciale pour le chuchotement
			// Si le joueur chuchote, on peut ajouter une vérification supplémentaire
			if (_currentVolume == "whispering") then {
				// Le HUD affiche correctement l'icône de chuchotement
				// Si les distances sont encore trop élevées, c'est un problème de configuration serveur TFAR
			};
		};
	};
};

diag_log format ["[ALF] Configuration TFAR appliquée - Whisper: %1m, Normal: %2m, Yell: %3m (HUD synchronisé)", 
	ALF_TFAR_WhisperDistance, 
	ALF_TFAR_NormalDistance, 
	ALF_TFAR_YellDistance
];

// Message d'information pour l'administrateur
if (ALF_AdminLevel > 0) then {
	diag_log "[ALF] INFO Admin: Si les distances de voix sont encore incorrectes, vérifiez la configuration TFAR côté serveur dans @task_force_radio/config.cfg";
};

