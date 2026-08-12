
/*
// ALF_fnc_interactions_player_to_house = {
private _batiment = param [0,objNull,[objNull]];


[
	_batiment,
	[
		[
			"ACHETER LE BIEN",
			"[life_pInact_curObject] spawn ALF_fnc_buyHouse;",
			"(count(ALF_House_Data # 0) isEqualTo 0) AND 
			{[typeOf life_pInact_curObject] call ALF_fnc_houseConfig isNotequalto [] AND
			{life_pInact_curObject getVariable ['business',[]] isequalto [] AND 
			{((allMapMarkers select {'MRPV2_Zone_Inachetable' in _x}) select {player inArea _x}) isequalto []}}}"
		],		
		[
			"BIEN VENDU",
			"", 
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{((ALF_House_Data # 0) # 0) isNotEqualTo (getPlayerUID player)}"
		],		
		[
			"VENDRE LE BIEN",
			"[life_pInact_curObject] spawn ALF_fnc_sellHouse;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{((ALF_House_Data # 0) # 0) isEqualTo (getPlayerUID player)}"
		],
		[
			"PLACER LE BARIL",
			"[life_pInact_curObject,player] remoteExecCall ['ALF_Server_fnc_poserBaril',2];",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{((ALF_House_Data # 0) # 0) isEqualTo (getPlayerUID player) AND 
			{(typeOf life_pInact_curObject) in ['Land_ALF_Caravane'] AND 
			{'ALF_Barrel_boite' in (magazines player)}}}"
		],			
		[
			"ALLUMER LES LUMIÈRES",
			"[life_pInact_curObject] call ALF_fnc_lightHouseAction;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{[life_pInact_curObject, true] call ALF_fnc_hasEnergy AND 
			{life_pInact_curObject in life_vehicles AND 
			{isNull (life_pInact_curObject getVariable ['lightSource',objNull])}}}"
		],
		[
			"ÉTEINDRE LES LUMIÈRES",
			"[life_pInact_curObject] call ALF_fnc_lightHouseAction;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_pInact_curObject in life_vehicles AND 
			{!(isNull (life_pInact_curObject getVariable ['lightSource',objNull]))}}"
		],		
		[
			"BOITE AUX LETTRES",
			"[life_pInact_curObject] call ALF_fnc_menuMailbox;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_pInact_curObject in life_vehicles}"
		],		
		[
			"ACCÉDER AU GARAGE",
			"
				['vehicles','Car',player] remoteExecCall ['MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD', 2];
				createDialog 'Life_impound_menu'; 
				disableSerialization; 
				ctrlSetText[2802,'Chargement...'];
			",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{life_pInact_curObject in life_vehicles AND 
				{[['ALF_GARAGES', (typeOf life_pInact_curObject)]] call ALFTools_Client_Config_fnc_isClass}}
			"
		],
		[
			"RANGER LE VÉHICULE PROCHE",
			"['Car','Civil'] call MRPV2_fnc_Vehicule_Garage_Ranger;",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{life_pInact_curObject in life_vehicles AND 
				{[['ALF_GARAGES', (typeOf life_pInact_curObject)]] call ALFTools_Client_Config_fnc_isClass}}
			"
		],		
		[
			"INSTALLER UNE SORNNETTE",
			"[life_pInact_curObject,player] remoteExecCall ['ALF_Server_fnc_sonnetteHouse',2];",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{((ALF_House_Data # 0) # 0) isEqualTo (getPlayerUID player) AND 
				{'ALF_Sonnette4G' in (magazines player) AND 
				{(ALF_House_Data # 1) isEqualTo 0}}}
			"
		],
		[
			"SONNER",
			"if (isNull life_pInact_curObject) exitWith {}; [life_pInact_curObject] remoteExecCall ['ALF_Server_fnc_playSonnetteHouse',2];",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{((ALF_House_Data # 0) # 0) isNotEqualTo (getPlayerUID player) AND 
				{(ALF_House_Data # 1) isEqualTo 1}}
			"
		],		
		[
			"[G] VÉRIFIER LE PROPRIO",
			"[] call ALF_fnc_copHouseOwner;",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{life_gendarme_service}
			"
		],
		[
			"[A] VÉRIFIER LE PROPRIO",
			"[] call ALF_fnc_copHouseOwner;",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{ALF_AdminLevel > 2 AND 
				{!life_gendarme_service}}
			"
		],
		[
			"[P] ENFONCER LA PORTE",
			"[life_pInact_curObject,0] spawn ALF_fnc_copBreakDoor;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_pompier_service}"
		],
		[
			"[G] ENFONCER LA PORTE",
			"[life_pInact_curObject,0] spawn ALF_fnc_copBreakDoor;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_gendarme_service}"
		],
		[
			"[G] VERROUILLER LE BÂTIMENT",
			"[life_pInact_curObject] spawn ALF_fnc_lockupHouse;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_gendarme_service}"
		],
		[
			"DÉVERROUILLER LE BÂTIMENT",
			"life_pInact_curObject setVariable ['ALF_PorteFermer',FALSE,TRUE];",
			"life_pInact_curObject getVariable ['ALF_PorteFermer',FALSE] AND 
		    {life_pInact_curObject in life_vehicles}"
		],
		[
			"VERROUILLER LE BÂTIMENT",
			"life_pInact_curObject setVariable ['ALF_PorteFermer',TRUE,TRUE];",
			"!(life_pInact_curObject getVariable ['ALF_PorteFermer',FALSE]) AND 
		    {life_pInact_curObject in life_vehicles}"
		],
		[
			"[A] DÉVERROUILLER LE BÂTIMENT",
			"life_pInact_curObject setVariable ['ALF_PorteFermer',FALSE,TRUE];",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_pInact_curObject getVariable ['ALF_PorteFermer',FALSE] AND 
			{ALF_AdminLevel > 2}}"
		],
		[
			"[A] VERROUILLER LE BÂTIMENT",
			"life_pInact_curObject setVariable ['ALF_PorteFermer',TRUE,TRUE];",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{!(life_pInact_curObject getVariable ['ALF_PorteFermer',FALSE]) AND 
			{ALF_AdminLevel > 2 AND 
			{[(typeOf life_pInact_curObject)] call ALF_fnc_houseConfig isNotequalto []}}}"
		],
		[
			toupper "Déposer le colis",
			"['returnColis'] spawn ALF_fnc_laposte_fonctions;",
			"life_pInact_curObject getVariable ['LaPoste_Colis',''] isequalto (getplayeruid player) AND 
			{'door' in tolower str ((lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,4],player,objnull,true,1,'GEOM','NONE']) # 0 # 4)}"
		]
	],
	false,
	true,
	true,
	true
] spawn ALF_fnc_interactions_create;
// };
*/

// ALF_fnc_interactions_player_to_house = {
private _batiment = param [0,objNull,[objNull]];

//systemChat format ["[DEBUG] interactions_player_to_house: typeOf = %1", typeof _batiment];

[
	_batiment,
	[
		[
			"ACHETER LE BIEN",
			"[life_pInact_curObject] spawn ALF_fnc_buyHouse;",
			"((count(ALF_House_Data) > 0 AND {count(ALF_House_Data # 0) isEqualTo 0}) OR {count(ALF_House_Data) isEqualTo 0}) AND 
			{[typeOf life_pInact_curObject] call ALF_fnc_houseConfig isNotequalto [] AND
			{life_pInact_curObject getVariable ['business',[]] isequalto [] AND 
			{((allMapMarkers select {'MRPV2_Zone_Inachetable' in _x}) select {player inArea _x}) isequalto []}}}"
		],
		[
			"ACHETER LE HANGAR ENTREPRISE",
			"[life_pInact_curObject] spawn ALF_fnc_buyHouseBusiness;",
			"((count(ALF_House_Data) > 0 AND {count(ALF_House_Data # 0) isEqualTo 0}) OR {count(ALF_House_Data) isEqualTo 0}) AND 
			{(typeOf life_pInact_curObject) in ['Land_i_Shed_Ind_F','Land_SM_01_shed_F','Land_Hangar2','Land_entreprise1'] AND
			{(count(life_pInact_curObject getVariable ['business',[]])) isEqualTo 0 AND
			{((player getVariable ['isEmployed','']) isNotEqualTo '') AND
			{count(nearestObjects [life_pInact_curObject, ['Land_ALF_Entreprise'], 150] select {
				private _varBiz = _x getVariable ['business',[]];
				(count _varBiz >= 3) AND {
					((_varBiz select 2) isEqualTo (player getVariable ['isEmployed',''])) AND
					{((_varBiz select 0) isEqualTo (getPlayerUID player))}
				}
			}) > 0}}}}"
		],		
		[
			"BIEN VENDU",
			"", 
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{((ALF_House_Data # 0) # 0) isNotEqualTo (getPlayerUID player)}"
		],		
		[
			"VENDRE LE BIEN",
			"[life_pInact_curObject] spawn ALF_fnc_sellHouse;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{((ALF_House_Data # 0) # 0) isEqualTo (getPlayerUID player)}"
		],
		[
			"PLACER LE BARIL",
			"[life_pInact_curObject,player] remoteExecCall ['ALF_Server_fnc_poserBaril',2];",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{((ALF_House_Data # 0) # 0) isEqualTo (getPlayerUID player) AND 
			{(typeOf life_pInact_curObject) in ['Land_ALF_Caravane'] AND 
			{'ALF_Barrel_boite' in (magazines player)}}}"
		],			
		[
			"ALLUMER LES LUMIÈRES",
			"[life_pInact_curObject] call ALF_fnc_lightHouseAction;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{[life_pInact_curObject, true] call ALF_fnc_hasEnergy AND 
			{life_pInact_curObject in life_vehicles AND 
			{isNull (life_pInact_curObject getVariable ['lightSource',objNull])}}}"
		],
		[
			"ÉTEINDRE LES LUMIÈRES",
			"[life_pInact_curObject] call ALF_fnc_lightHouseAction;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_pInact_curObject in life_vehicles AND 
			{!(isNull (life_pInact_curObject getVariable ['lightSource',objNull]))}}"
		],		
		[
			"BOITE AUX LETTRES",
			"[life_pInact_curObject] call ALF_fnc_menuMailbox;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_pInact_curObject in life_vehicles}"
		],		
		[
			"ACCÉDER AU GARAGE",
			"
				['vehicles','Car',player] remoteExecCall ['MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD', 2];
				createDialog 'Life_impound_menu'; 
				disableSerialization; 
				ctrlSetText[2802,'Chargement...'];
			",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{life_pInact_curObject in life_vehicles AND 
				{[['ALF_GARAGES', (typeOf life_pInact_curObject)]] call ALFTools_Client_Config_fnc_isClass}}
			"
		],
		[
			"RANGER LE VÉHICULE PROCHE",
			"['Car','Civil'] call MRPV2_fnc_Vehicule_Garage_Ranger;",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{life_pInact_curObject in life_vehicles AND 
				{[['ALF_GARAGES', (typeOf life_pInact_curObject)]] call ALFTools_Client_Config_fnc_isClass}}
			"
		],		
		[
			"INSTALLER UNE SORNNETTE",
			"[life_pInact_curObject,player] remoteExecCall ['ALF_Server_fnc_sonnetteHouse',2];",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{((ALF_House_Data # 0) # 0) isEqualTo (getPlayerUID player) AND 
				{'ALF_Sonnette4G' in (magazines player) AND 
				{(ALF_House_Data # 1) isEqualTo 0}}}
			"
		],
		[
			"SONNER",
			"if (isNull life_pInact_curObject) exitWith {}; [life_pInact_curObject] remoteExecCall ['ALF_Server_fnc_playSonnetteHouse',2];",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{((ALF_House_Data # 0) # 0) isNotEqualTo (getPlayerUID player) AND 
				{(ALF_House_Data # 1) isEqualTo 1}}
			"
		],		
		[
			"[G] VÉRIFIER LE PROPRIO",
			"[] call ALF_fnc_copHouseOwner;",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{life_gendarme_service}
			"
		],
		[
			"[A] VÉRIFIER LE PROPRIO",
			"[] call ALF_fnc_copHouseOwner;",
			"
				(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
				{ALF_AdminLevel > 2 AND 
				{!life_gendarme_service}}
			"
		],
		[
			"[P] ENFONCER LA PORTE",
			"[life_pInact_curObject,0] spawn ALF_fnc_copBreakDoor;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_pompier_service}"
		],
		[
			"[G] ENFONCER LA PORTE",
			"[life_pInact_curObject,0] spawn ALF_fnc_copBreakDoor;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_gendarme_service}"
		],
		[
			"[G] VERROUILLER LE BÂTIMENT",
			"[life_pInact_curObject] spawn ALF_fnc_lockupHouse;",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_gendarme_service}"
		],
		[
			"DÉVERROUILLER LE BÂTIMENT",
			"life_pInact_curObject setVariable ['ALF_PorteFermer',FALSE,TRUE];",
			"life_pInact_curObject getVariable ['ALF_PorteFermer',FALSE] AND 
		    {life_pInact_curObject in life_vehicles}"
		],
		[
			"VERROUILLER LE BÂTIMENT",
			"life_pInact_curObject setVariable ['ALF_PorteFermer',TRUE,TRUE];",
			"!(life_pInact_curObject getVariable ['ALF_PorteFermer',FALSE]) AND 
		    {life_pInact_curObject in life_vehicles}"
		],
		[
			"[A] DÉVERROUILLER LE BÂTIMENT",
			"life_pInact_curObject setVariable ['ALF_PorteFermer',FALSE,TRUE];",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{life_pInact_curObject getVariable ['ALF_PorteFermer',FALSE] AND 
			{ALF_AdminLevel > 2}}"
		],
		[
			"[A] VERROUILLER LE BÂTIMENT",
			"life_pInact_curObject setVariable ['ALF_PorteFermer',TRUE,TRUE];",
			"(count(ALF_House_Data # 0) isNotEqualTo 0) AND 
			{!(life_pInact_curObject getVariable ['ALF_PorteFermer',FALSE]) AND 
			{ALF_AdminLevel > 2 AND 
			{[(typeOf life_pInact_curObject)] call ALF_fnc_houseConfig isNotequalto []}}}"
		],
		[
			toupper "Déposer le colis",
			"['returnColis'] spawn ALF_fnc_laposte_fonctions;",
			"life_pInact_curObject getVariable ['LaPoste_Colis',''] isequalto (getplayeruid player) AND 
			{'door' in tolower str ((lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,4],player,objnull,true,1,'GEOM','NONE']) # 0 # 4)}"
		]
	],
	false,
	true,
	true,
	true
] spawn ALF_fnc_interactions_create;
// };