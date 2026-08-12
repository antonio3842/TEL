// /*______________________________________
// |									 	|
// |		Autheur : Yoan Verquion      	|
// |		Pour : Arma3LifeFrance         	|
// |		Scripts : fn_braquageAgence.sqf |
// |______________________________________ */

// ALF_fnc_braquageAgence = {
if (isServer) exitWith {};
if !(hasInterface) exitWith {};

private _mec_Braquer = param [0,objnull];

private _groupe_GN = (groups civilian select {"Gendarmerie" in groupid _x}) # 0;

if (isnil {_groupe_GN}) exitwith 
{
	["Braquage", "Vous le sentez pas ce braquage, vaut mieux remettre ca à plus tard", "warning", false] spawn alf_fnc_doMsg;
};

if (count (units _groupe_GN) < 2) exitwith 
{
	["Braquage", "C'est pas le bon moment, vaut mieux remettre ca à plus tard", "warning", false] spawn alf_fnc_doMsg;
};

if !("ALF_Lockpick" in magazines player) exitWith 
{
	["Braquage", "Vous avez besoin d'un tournevis pour lancer le braquage !", "warning", false] spawn alf_fnc_doMsg;
};

if (_mec_Braquer getVariable ["ALF_alreadyBraq", false]) exitWith {["Braquage", "La caisse est vide !", "warning", false] spawn alf_fnc_doMsg;};

																														 

private _nb_Marqueur = count (allMapMarkers select {"MRPV2_GN_Braquage" in _x});
private _nom_Marqueur = format ["MRPV2_GN_Braquage_%1",str _mec_Braquer];
private _pos_Marqueur = position player;

_random = random 100;
_alerte = false;
if ([player] call ALF_fnc_hasEnergy) then {
	[TRUE,_nom_Marqueur,_pos_Marqueur,"ICON",[1.3, 1.3],"ColorRed","📍 Braquage","mil_warning"] remoteExec ['MRPV2_fnc_Marqueur_Gestion',units _groupe_GN];
	_alerte = true;
} else {
	if (_random >= 50) then {
		[TRUE,_nom_Marqueur,_pos_Marqueur,"ICON",[1.3, 1.3],"ColorRed","📍 Braquage","mil_warning"] remoteExec ['MRPV2_fnc_Marqueur_Gestion',units _groupe_GN];
		["Braquage","Des individus armés sont en train de réaliser un braquage !"] remoteExec ["ALF_fnc_doBfmO",playableUnits];
		_alerte = true;
	};
};


["ALF_Lockpick",false] call ALF_fnc_handleItem;

5 cutRsc ["life_progress","PLAIN"];
private _ui = uiNameSpace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["Braquage en cours (1%1)...","%"];
_progress progressSetPosition 0.01;

private _mec_Braquer = cursorobject;
[_mec_Braquer,"acts_jetsmarshallingstop_in"] remoteexec ["switchmove",0];
_mec_Braquer setVariable ["ALF_alreadyBraq",true,true];

private _batiment_proche = (nearestTerrainObjects [player, ["building","house"], 40]) # 0;
if (isnil {_batiment_proche}) then {_batiment_proche = player};

if (_alerte) then {private _alarme = playSound3D ["ALF_Client2\sounds\banque_alarm.ogg", player, false,position player, 5, 0.85, 300];};


private _cP = 0.01;
private _pos_Braqueur = getpos player;
private _quitter = false;
private _ville_Proche = text ((nearestLocations [position _mec_Braquer, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1000]) # 0);

for "_i" from 0 to 1 step 0 do
{
	sleep 1;
	_cP = _cP + 0.002;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["Braquage en cours (%1%2)...",round(_cP * 100),"%"];

	if (_cP >= 0.25 AND _cP <= 0.26 && _alerte) then 
	{
		["Braquage",format["On a aperçu les braqueurs près de %1 ! Prudence aux alentours !",_ville_Proche]] remoteExec ["ALF_fnc_doBfmO",playableUnits];
	};
	
	if (_alerte) then {
	if (soundParams _alarme isequalto []) then 
	{
		_alarme = playSound3D ["ALF_Client2\sounds\banque_alarm.ogg", _batiment_proche, false,position _batiment_proche, 5, 0.85, 300];
	};
	};

	if (player distance _pos_Braqueur >= 20) exitWith 
	{
		life_interrupted = true;
		deleteMarker _nom_Marqueur;
		_quitter = true;
	};
	if (_cP >= 1) exitWith {};
	if !(alive player) exitWith {};
	if (life_interrupted) exitWith {};

	if (currentWeapon player isequalto "") exitWith 
	{
		["Braquage", "Vous avec rangé votre arme, le braquage est annulé gros naze !", "warning", false] spawn alf_fnc_doMsg;
		sleep 10;
		if (_alerte) then {
		stopsound _alarme;
		deleteMarker _nom_Marqueur;
		};
		
		_quitter = true;	
	};

	if (life_istazed) exitWith 
	{
		life_interrupted = true;
		if (!isNil "ALF_Braquage_Marker") then 
		{
			deleteMarkerLocal (missionNamespace getVariable "ALF_Braquage_Marker");
			missionNamespace setVariable ["ALF_Braquage_Marker", nil];
		};
		if (life_istazed) then 
		{
			["Braquage", "Vous avez été neutralisé !", "warning", false] spawn alf_fnc_doMsg;
		};

		sleep 10;
		if (_alerte) then {
		stopsound _alarme;
		deleteMarker _nom_Marqueur;
		};
		_quitter = true;
	};	
};

5 cutText ["","PLAIN"];
[_mec_Braquer,""] remoteexec ["switchmove",0];

if (!alive player OR {_quitter OR {!isnull objectParent player OR {life_interrupted}}}) exitWith 
{
	life_interrupted = false; 
	titleText["Braquage annulée.","PLAIN"];

	sleep 10;
		if (_alerte) then {
		stopsound _alarme;
		deleteMarker _nom_Marqueur;
		};
};

// if () exitWith 
// {
// 	[_mec_Braquer,""] remoteexec ["switchmove",0];

// 	sleep 10;
// 	stopsound _alarme;
// 	deleteMarker _nom_Marqueur;
// };

// if (life_interrupted) exitWith 
// {
	
// 	[_mec_Braquer,""] remoteexec ["switchmove",0];	

// 	sleep 10;

// 	stopsound _alarme;
// 	deleteMarker _nom_Marqueur;
// };

_toAdd = round(random [150000, 170000, 200000]);
life_cash = life_cash + _toAdd;
_mec_Braquer setVariable ["ALF_braquageAmount", _toAdd, true];
["Braquage", format["Vous avez volé %1 €",_toAdd], "warning", false] spawn alf_fnc_doMsg;

sleep 20;
		if (_alerte) then {
		stopsound _alarme;
		deleteMarker _nom_Marqueur;
		};

[name player,getPlayerUID player,"BRAQUAGE",format["Braquage de %1 - Gains : %2 € | CASH : %3 €",_ville_Proche,_toAdd,life_cash]] remoteExec ["ALF_Server_fnc_logIt",2];
[0] spawn SOCK_fnc_updatePartial;
// };