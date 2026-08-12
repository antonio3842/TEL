byscream_demi_raccord_hand = objNull;
byscream_ldt_hand = objNull;
[
	player, 
	"Prendre la lance", 
	"", 
	"", 
	'count (nearestObjects [getPos player, ["byscream_ldv500_object"],1]) > 0', 
	"true",
	{ hint "Récupération de la lance..." }, 
	{ }, 
	{ 
		[] spawn {
		_lance = (nearestObjects [getPos player, ["byscream_ldv500_object"],2]) select 0;
		_raccord = _lance getVariable["connectedTo",objNull];
		if (isNull _raccord) exitWith  {};
		if (typeOf _lance isEqualTo "byscream_ldv500_object") then {
			player addWeapon "byscream_LDV500";
			player addPrimaryWeaponItem "byscream_LDV500_chargeur";
			_raccord attachTo [player,[0.445,-0.15,-0.6165],"weapon",true];  
			_raccord setVectorDirAndUp [[0,1,0], [1,0,0]];
		} else {
			player addWeapon "byscream_LDT";
			player addPrimaryWeaponItem "byscream_LDV500_chargeur";
			_raccord attachTo [player,[0.475,-0.06,-0.65],"weapon",true];  
			
		};
		_raccord lock false;
		
		player setVariable ["connectedTo", _raccord,true];

		if !(isNull (_lance getVariable ["LDT",objNull])) then {
			byscream_ldt_hand = _lance getVariable ["LDT",objNull];
		};

		deleteVehicle _lance;

		while {!isNull (player getVariable ["connectedTo", objNull])} do {
			_opposite = (player getVariable ["connectedTo", objNull]) getVariable "opposite";
			_longueur = ((player getVariable ["connectedTo", objNull]) getVariable ["longueur",20]);
			if ((player distance _opposite) > _longueur) then {
				hint "Vous ne pouvez pas aller si loin ! Veuillez redéployer un tuyau.";
				_dir = vectorNormalized ((getPos _opposite) vectorFromTo (getPos player));  // direction du joueur vers l'objet
				_newPos = (getPos _opposite) vectorAdd [(_dir select 0) * (_longueur-1), (_dir select 1) * (_longueur-1), 0];  // position exactement à 20 m
				_newPos set [2, (getPos player) select 2];
				player setPos _newPos;
			};
			sleep 0.1;
		};
		};
	}, 
	{ hint "Récupération annulée !" }, 
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Prendre la division", 
	"", 
	"", 
	'(isNull byscream_demi_raccord_hand) && count (nearestObjects [getPos player, ["byscream_division_simple_object"],1]) > 0', 
	"true",
	{ hint "Récupération de la division..." }, 
	{ }, 
	{ 
		_div = (nearestObjects [getPos player, ["byscream_division_simple_object"],2]) select 0;
		if !(isNull (_div getVariable ["connectedTo",objNull]) && (_div getVariable ["connectedTo_div",[objNull,objNull]]) isEqualTo [objNull,objNull]) exitWith {
			hint "La division est encore connectée à quelque chose !";
		};
		player addMagazine "byscream_division_simple";
		deleteVehicle _div;
	}, 
	{ hint "Récupération annulée !" }, 
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;

[
	player, 
	"Gérer la pompe du véhicule", 
	"", 
	"", 
	'(isNull byscream_demi_raccord_hand) && ([["ByScream_Incendie_V3","vehicles",typeOf cursorObject]] call ALFTools_Client_Config_fnc_isClass) && player distance cursorObject < 5', 
	"true",
	{ hint "Récupération de la lance..." }, 
	{ }, 
	{ 
		[] spawn {
			createDialog "ByScream_Incendie_V3_Pompe";
			byscream_vehicle_pompe = cursorObject;
			_reservoir_max = ["NUMBER", ["ByScream_Incendie_V3","vehicles",typeOf byscream_vehicle_pompe,"reservoir"]] call ALFTools_Client_Config_fnc_getConfig;
			while {!(isNull (findDisplay 15651))} do {
				_reservoir = byscream_vehicle_pompe getVariable ["byscream_incendie_reservoir",_reservoir_max];
				((findDisplay 15651) displayCtrl 1001) progressSetPosition (_reservoir/_reservoir_max);
				if ((byscream_vehicle_pompe getVariable ["byscream_incendie_pression",0]) == 0) then {
					((findDisplay 15651) displayCtrl 1002) ctrlSetText "0 bars";
				} else {
					((findDisplay 15651) displayCtrl 1002) ctrlSetText format["%1 bars",(byscream_vehicle_pompe getVariable ["byscream_incendie_pression",0]) + ((floor ((random 3) - 1))/10)];
				};
				uiSleep 2;
			};
		};
	}, 
	{ hint "Récupération annulée !" }, 
	[], 
	1, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;

[
	player, 
	"Ranger le tuyau le plus proche", 
	"", 
	"",
	'isNull byscream_demi_raccord_hand && !(currentWeapon player in ["ByScream_LDV500","ByScream_LDT"]) && {_near = (nearestObjects[player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"], 2]); (count _near > 0) && {((_near select 0) getVariable ["connectedTo",objNull]) isEqualTo objNull}}',
	"true",
	{ hint "Rangement en cours..." }, 
	{ }, 
	{ [] call ALF_fnc_incendie_rangerTuyau }, 
	{ hint "Rangement annulé !" }, 
	[], 
	10, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Prendre le demi-raccord le plus proche", 
	"", 
	"", 
	'isNull byscream_demi_raccord_hand && !(currentWeapon player in ["ByScream_LDV500","ByScream_LDT"]) && {_near = (nearestObjects[player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"], 2]); (count _near > 0) && {((_near select 0) getVariable ["connectedTo",objNull]) isEqualTo objNull}}', 
	"true",
	{ hint "Prise en main du demi-raccord..." }, 
	{ }, 
	{ [] spawn ALF_fnc_incendie_prendreTuyau }, 
	{ hint "Prise en main annulée !" }, 
	[], 
	1, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Poser le demi-raccord", 
	"", 
	"", 
	'!isNull byscream_demi_raccord_hand && (player isEqualTo vehicle player)', 
	"true",
	{ hint "Pose du demi-raccord..." }, 
	{ }, 
	{ [] call ALF_fnc_incendie_lacherTuyau }, 
	{ hint "Pose annulée !" }, 
	[], 
	1, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;

[
	player, 
	"Raccorder le tuyau", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {_near = (nearestObjects[player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"], 2]); (count _near > 1) && {(((_near select 0) getVariable ["connectedTo",objNull]) isEqualTo objNull)}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[] call ALF_fnc_incendie_raccorder2Tuyaux }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder les 2 tuyaux", 
	"", 
	"", 
	'
	(isNull byscream_demi_raccord_hand) && {_near = (nearestObjects[player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"], 2]); (count _near > 0) && {(typeOf ((_near select 0) getVariable ["connectedTo",objNull]) in ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"])}}
	', 
	"true", 
	{ hint "Déraccordement en cours..." }, 
	{ }, 
	{ [] call ALF_fnc_incendie_deraccorder2Tuyaux }, 
	{ hint "Déraccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;



[
	player, 
	"Raccorder la LDV 500 au tuyau le plus proche", 
	"", 
	"", 
	'(isNull byscream_demi_raccord_hand) && (isNull byscream_ldt_hand) && (currentWeapon player isEqualTo "ByScream_LDV500") && {_near = (nearestObjects[player, ["byscream_demi_raccord45","byscream_demi_raccord70","byscream_demi_raccord110"], 2]); (count _near > 0) && {(((_near select 0) getVariable ["connectedTo",objNull]) isEqualTo objNull)}}', 
	"true",
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{ [] spawn ALF_fnc_incendie_raccorderLDV }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le demi-raccord de la LDV", 
	"", 
	"", 
	'(isNull byscream_demi_raccord_hand) && (isNull byscream_ldt_hand) && (currentWeapon player isEqualTo "ByScream_LDV500") && !((player getVariable ["connectedTo", objNull]) isEqualTo objNull) && (player isEqualTo vehicle player) ', 
	"true",
	{ hint "Déraccordement en cours..." }, 
	{ }, 
	{ [] call ALF_fnc_incendie_deraccorderLDV }, 
	{ hint "Déraccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;


[
	player, 
	"Prendre la LDT", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && !(currentWeapon player in ["ByScream_LDV500","ByScream_LDT"]) && !(cursorObject getVariable ["byscream_ldtprise",false]) && isNull byscream_ldt_hand && !isNull cursorObject && player distance cursorObject < 5 && ([["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"LDT"]] call ALFTools_Client_Config_fnc_isClass) && (player isEqualTo vehicle player)', 
	"true",
	{ hint "Prise en main de la LDT en cours..." }, 
	{ }, 
	{ [] spawn ALF_fnc_incendie_sortirLDT }, 
	{ hint "Prise en main de la LDT annulée !" }, 
	[], 
	10, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;

[
	player, 
	"Ranger la LDT", 
	"", 
	"",
	'(byscream_ldt_hand isEqualTo cursorObject) && !isNull cursorObject && player distance cursorObject < 5 && ([["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"LDT"]] call ALFTools_Client_Config_fnc_isClass) && (player isEqualTo vehicle player)', 
	"true",
	{ hint "Rangement de la LDT en cours..." }, 
	{ }, 
	{ [] call ALF_fnc_incendie_rangerLDT }, 
	{ hint "Rangement de la LDT annulé !" }, 
	[], 
	10, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;


[
	player, 
	"Raccorder le tuyau à la vanne n°1", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && {count (["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) >= 1 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]]) select 0 isEqualTo objNull) && player distance cursorObject < 5}}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[1] spawn ALF_fnc_incendie_raccorderTuyauVehicule }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Raccorder le tuyau à la vanne n°2", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && {count (["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) >= 2 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]]) select 1 isEqualTo objNull) && player distance cursorObject < 5}}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[2] spawn ALF_fnc_incendie_raccorderTuyauVehicule }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Raccorder le tuyau à la vanne n°3", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && {count (["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) >= 3 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]]) select 2 isEqualTo objNull) && player distance cursorObject < 5}}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[3] spawn ALF_fnc_incendie_raccorderTuyauVehicule }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Raccorder le tuyau à la vanne n°4", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && {count (["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) >= 4 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]]) select 3 isEqualTo objNull) && player distance cursorObject < 5}}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[4] spawn ALF_fnc_incendie_raccorderTuyauVehicule }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Raccorder le tuyau à la vanne n°5", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && 
	{count (["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) >= 5 
	&& {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]]) select 4 isEqualTo objNull) && player distance cursorObject < 5}}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[5] spawn ALF_fnc_incendie_raccorderTuyauVehicule }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;

[
	player, 
	"Déraccorder le tuyau de la vanne n°1", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && {count (["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) >= 1 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]]) select 0 isNotEqualTo objNull) && player distance cursorObject < 5}}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [1] spawn ALF_fnc_incendie_deraccorderTuyauVehicule }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le tuyau de la vanne n°2", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && {count (["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) >= 2 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]]) select 1 isNotEqualTo objNull) && player distance cursorObject < 5}}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [2] spawn ALF_fnc_incendie_deraccorderTuyauVehicule }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le tuyau de la vanne n°3", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && {count (["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) >= 3 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]]) select 2 isNotEqualTo objNull) && player distance cursorObject < 5}}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [3] spawn ALF_fnc_incendie_deraccorderTuyauVehicule }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le tuyau de la vanne n°4", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && {count (["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) >= 4 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]]) select 3 isNotEqualTo objNull) && player distance cursorObject < 5}}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [4] spawn ALF_fnc_incendie_deraccorderTuyauVehicule }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le tuyau de la vanne n°5", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && {count (["ARRAY", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"vannes"]] call ALFTools_Client_Config_fnc_getConfig) >= 5 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull,objNull,objNull]]) select 4 isNotEqualTo objNull) && player distance cursorObject < 5}}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [5] spawn ALF_fnc_incendie_deraccorderTuyauVehicule }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;

[
	player,
	"Allumer la BSD",
	"",
	"",
	'isNil "byscream_bsl" && (backpack player in ((["ARRAY", ["ByScream_Incendie_V3","ARI"]] call ALFTools_Client_Config_fnc_getConfig) apply {_x select 0}))',
	"true",
	{},
	{},
	{[] spawn ALF_fnc_incendie_allumerBSL},
	{},
	[], 
	0.5, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player,
	"Éteindre la BSD",
	"",
	"",
	'!isNil "byscream_bsl"',
	"true",
	{},
	{},
	{[] spawn ALF_fnc_incendie_eteindreBSL},
	{},
	[], 
	1, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Changer la bouteille de son ARI", 
	"", 
	"", 
	'(backpack player in ((["ARRAY", ["ByScream_Incendie_V3","ARI"]] call ALFTools_Client_Config_fnc_getConfig) apply {_x select 0})) && (goggles player == (["STRING", ["ByScream_Incendie_V3","ARI_mask_unset"]] call ALFTools_Client_Config_fnc_getConfig)) && (isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "Car" && {(["NUMBER", ["ByScream_Incendie_V3","vehicles",typeOf cursorObject,"can_refuel_ari"]] call ALFTools_Client_Config_fnc_getConfig) == 1 && {player distance cursorObject < 5}}}', 
	"true", 
	{ hint "Changement en cours..." }, 
	{ }, 
	{player setVariable ["byscream_incendie_bar",300,true]; hint "Bouteille changée !"}, 
	{ hint "Changement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player,
	"Capeler",
	"",
	"",
	'(backpack player in ((["ARRAY", ["ByScream_Incendie_V3","ARI"]] call ALFTools_Client_Config_fnc_getConfig) apply {_x select 0})) && (goggles player == (["STRING", ["ByScream_Incendie_V3","ARI_mask_unset"]] call ALFTools_Client_Config_fnc_getConfig))',
	"true",
	{},
	{},
	{[] spawn ALF_fnc_incendie_capeler},
	{},
	[], 
	0.5, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player,
	"Décapeler",
	"",
	"",
	'(backpack player in ((["ARRAY", ["ByScream_Incendie_V3","ARI"]] call ALFTools_Client_Config_fnc_getConfig) apply {_x select 0})) && (goggles player == (["STRING", ["ByScream_Incendie_V3","ARI_mask_set"]] call ALFTools_Client_Config_fnc_getConfig))',
	"true",
	{},
	{},
	{[] spawn ALF_fnc_incendie_decapeler},
	{},
	[], 
	0.5, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;

[
	player,
	"Dérouler le tuyau de 20m/45mm",
	"",
	"",
	'(isNull byscream_demi_raccord_hand) && (player isEqualTo vehicle player) && [player, "byscream_tuyau20_45_simple"] call BIS_fnc_hasItem',
	"true",
	{},
	{},
	{[20,45] spawn ALF_fnc_incendie_deroulerTuyau},
	{ hint "Déroulement annulé !"},
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player,
	"Dérouler le tuyau de 40m/45mm",
	"",
	"",
	'(isNull byscream_demi_raccord_hand) && (player isEqualTo vehicle player) && [player, "byscream_tuyau40_45_simple"] call BIS_fnc_hasItem',
	"true",
	{},
	{},
	{[40,45] spawn ALF_fnc_incendie_deroulerTuyau},
	{ hint "Déroulement annulé !"},
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player,
	"Dérouler le tuyau de 20m/70mm",
	"",
	"",
	'(isNull byscream_demi_raccord_hand) && (player isEqualTo vehicle player) && [player, "byscream_tuyau20_70_simple"] call BIS_fnc_hasItem',
	"true",
	{},
	{},
	{[20,70] spawn ALF_fnc_incendie_deroulerTuyau},
	{ hint "Déroulement annulé !"},
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player,
	"Dérouler le tuyau de 40m/70mm",
	"",
	"",
	'(isNull byscream_demi_raccord_hand) && (player isEqualTo vehicle player) && [player, "byscream_tuyau40_70_simple"] call BIS_fnc_hasItem',
	"true",
	{},
	{},
	{[40,70] spawn ALF_fnc_incendie_deroulerTuyau},
	{ hint "Déroulement annulé !"},
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player,
	"Dérouler le tuyau de 10m/110mm",
	"",
	"",
	'(isNull byscream_demi_raccord_hand) && (player isEqualTo vehicle player) && [player, "byscream_tuyau10_110_simple"] call BIS_fnc_hasItem',
	"true",
	{},
	{},
	{[10,110] spawn ALF_fnc_incendie_deroulerTuyau},
	{ hint "Déroulement annulé !"},
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player,
	"Dérouler le tuyau de 20m/110mm",
	"",
	"",
	'(isNull byscream_demi_raccord_hand) && (player isEqualTo vehicle player) && [player, "byscream_tuyau20_110_simple"] call BIS_fnc_hasItem',
	"true",
	{},
	{},
	{[20,110] spawn ALF_fnc_incendie_deroulerTuyau},
	{ hint "Déroulement annulé !"},
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player,
	"Dérouler le tuyau de 40m/110mm",
	"",
	"",
	'(isNull byscream_demi_raccord_hand) && (player isEqualTo vehicle player) && [player, "byscream_tuyau40_110_simple"] call BIS_fnc_hasItem',
	"true",
	{},
	{},
	{[40,110] spawn ALF_fnc_incendie_deroulerTuyau},
	{ hint "Déroulement annulé !"},
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;



[
	player, 
	"Raccorder le tuyau à la vanne gauche de l'hydrant", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "byscream_borne_incendie" && (cursorObject animationSourcePhase "bouchon1") == 1 &&  {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull]]) select 0 isEqualTo objNull) && player distance cursorObject < 2}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[1] call ALF_fnc_incendie_raccorderTuyauHydrant }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Raccorder le tuyau à la vanne centrale de l'hydrant", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "byscream_borne_incendie" && (cursorObject animationSourcePhase "bouchon2") == 1 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull]]) select 1 isEqualTo objNull) && player distance cursorObject < 2}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[2] call ALF_fnc_incendie_raccorderTuyauHydrant }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Raccorder le tuyau à la vanne droite de l'hydrant", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "byscream_borne_incendie" && (cursorObject animationSourcePhase "bouchon3") == 1 && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull]]) select 2 isEqualTo objNull) && player distance cursorObject < 2}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[3] call ALF_fnc_incendie_raccorderTuyauHydrant }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le tuyau de la vanne gauche de l'hydrant", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "byscream_borne_incendie" && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull]]) select 0 isNotEqualTo objNull) && player distance cursorObject < 2}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [1] spawn ALF_fnc_incendie_deraccorderTuyauVehicule }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le tuyau de la vanne centrale de l'hydrant", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "byscream_borne_incendie" && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull]]) select 1 isNotEqualTo objNull) && player distance cursorObject < 2}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [2] spawn ALF_fnc_incendie_deraccorderTuyauVehicule }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le tuyau de la vanne droite de l'hydrant", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {cursorObject isKindOf "byscream_borne_incendie" && {((cursorObject getVariable ["connectedTo", [objNull,objNull,objNull]]) select 2 isNotEqualTo objNull) && player distance cursorObject < 2}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [3] spawn ALF_fnc_incendie_deraccorderTuyauVehicule }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;


[
	player, 
	"Raccorder le tuyau à la sortie gauche de la division", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {_near = (nearestObjects [getPos player, ["byscream_division_simple_object"],1]); count _near > 0 && {(((_near select 0) getVariable ["connectedTo_div", [objNull,objNull]]) select 0 isEqualTo objNull)}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[1] call ALF_fnc_incendie_raccorderTuyauDivision }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Raccorder le tuyau à la sortie droite de la division", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {_near = (nearestObjects [getPos player, ["byscream_division_simple_object"],1]); count _near > 0 && {(((_near select 0) getVariable ["connectedTo_div", [objNull,objNull]]) select 1 isEqualTo objNull)}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[2] call ALF_fnc_incendie_raccorderTuyauDivision }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Raccorder le tuyau à l'entrée de la division", 
	"", 
	"", 
	'!(isNull byscream_demi_raccord_hand) && {_near = (nearestObjects [getPos player, ["byscream_division_simple_object"],1]); count _near > 0 && {(((_near select 0) getVariable ["connectedTo", objNull]) isEqualTo objNull)}}', 
	"true", 
	{ hint "Raccordement en cours..." }, 
	{ }, 
	{[3] call ALF_fnc_incendie_raccorderTuyauDivision }, 
	{ hint "Raccordement annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le tuyau de la sortie gauche de la division", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {_near = (nearestObjects [getPos player, ["byscream_division_simple_object"],1]); count _near > 0 && {(((_near select 0) getVariable ["connectedTo_div", [objNull,objNull]]) select 0 isNotEqualTo objNull)}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [1] spawn ALF_fnc_incendie_deraccorderTuyauDivision }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le tuyau de la sortie droite de la division", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {_near = (nearestObjects [getPos player, ["byscream_division_simple_object"],1]); count _near > 0 && {(((_near select 0) getVariable ["connectedTo_div", [objNull,objNull]]) select 1 isNotEqualTo objNull)}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [2] spawn ALF_fnc_incendie_deraccorderTuyauDivision }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Déraccorder le tuyau de l'entrée de la division", 
	"", 
	"",
	'(isNull byscream_demi_raccord_hand) && {_near = (nearestObjects [getPos player, ["byscream_division_simple_object"],1]); count _near > 0 && {(((_near select 0) getVariable ["connectedTo", objNull]) isNotEqualTo objNull)}}', 
	"true",
	{ hint "Déraccorder en cours..." }, 
	{ }, 
	{ [3] spawn ALF_fnc_incendie_deraccorderTuyauDivision }, 
	{ hint "Déraccorder annulé !" }, 
	[], 
	4, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;

[
	player, 
	"Décharger les tuyaux du dévidoir", 
	"", 
	"", 
	'isNull byscream_demi_raccord_hand && !isNull cursorObject && player distance cursorObject < 5 && ([["ByScream_Incendie_V3","devidoirs",typeOf cursorObject]] call ALFTools_Client_Config_fnc_isClass) && (player isEqualTo vehicle player)', 
	"true",
	{ hint "Déchargement des tuyaux en cours..." },
	{ }, 
	{ [cursorObject] spawn ALF_fnc_incendie_deroulerDevidoir }, 
	{ hint "Déchargement annulé !" }, 
	[], 
	2, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;
[
	player, 
	"Remettre un tuyau dans le dévidoir", 
	"", 
	"",
	'!isNull cursorObject && player distance cursorObject < 5 && ([["ByScream_Incendie_V3","devidoirs",typeOf cursorObject]] call ALFTools_Client_Config_fnc_isClass) && (player isEqualTo vehicle player) && [player, "byscream_tuyau40_70_simple"] call BIS_fnc_hasItem',
	"true",
	{ hint "Chargement d'un tuyau dans le dévidoir en cours..." }, 
	{ }, 
	{
		_object = cursorObject;
		_tuyauIn = cursorObject getVariable ["tuyauxIn", ["NUMBER", ["ByScream_Incendie_V3","devidoirs",typeOf _object,"nb_tuyau"]] call ALFTools_Client_Config_fnc_getConfig];
		if (_tuyauIn >= ["NUMBER", ["ByScream_Incendie_V3","devidoirs",typeOf _object,"nb_tuyau"]] call ALFTools_Client_Config_fnc_getConfig) exitWith {
			hint "Le dévidoir est déjà rempli complètement !";
		};

		_tuyauIn = _tuyauIn + 1;
		hint format["Vous avez placé un tuyau de 40m dans le dévidoir ! Le dévidoir comporte désormais %1/200m",_tuyauIn*40];
		cursorObject setVariable ["tuyauxIn",_tuyauIn,true];
		player removeItem "byscream_tuyau40_70_simple";
	}, 
	{ hint "Chargement annulé !" }, 
	[], 
	10, 
	nil, 
	false, 
	false
] call BIS_fnc_holdActionAdd;