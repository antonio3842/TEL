/*
	File: fn_biePoserPc.sqf
	Author: ALF TEAM
*/
params [
	["_object",objNull,[objNull]],
	["_unit",objNull,[objNull]]
];
if (isNull _object || {isNull _unit}) exitWith {};

if ((playableUnits findIf { (_x getVariable ["b_18", false]) || (_x getVariable ["MRP_Bie_EnService", false]) }) == -1) exitWith {
    ["ENEDIS","Impossible d'attaquer le transformateur.","success"] remoteExec ["ALF_fnc_doMsg",_unit];
};

if !((_object animationSourcePhase "pc_source") isEqualTo 0) exitWith {};

["ALF_Pc",false] remoteExec ["ALF_fnc_handleItem",_unit];

_object animateSource ["pc_source",1,true];

private _ville_Proche = text ((nearestLocations [position _object, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1000]) # 0);

["ENEDIS","Hack du trasnformateur en cours, restez proche du PC","success"] remoteExec ["ALF_fnc_doMsg",_unit];

private _pos = getPos _unit;
playSound3D ["ALF_Client2\sounds\banque_pc_start.ogg", _object, false, (_object modelToWorld (_object selectionPosition "action_pc")), 5, 1, 100];
uiSleep 50;

if (_pos distance _unit > 15) exitWith {["ENEDIS","Vous êtes partie trop loin du PC","warning"] remoteExec ["ALF_fnc_doMsg",_unit];["ALF_Pc",true] remoteExec ["ALF_fnc_handleItem",_unit];_object animateSource ["pc_source",0,true];};
_object setObjectTextureGlobal [0, "ALF_Batiments\ALF_object\data\computer_388888.paa"];
playSound3D ["ALF_Client2\sounds\banque_pc_bip.ogg", _object, false, (_object modelToWorld (_object selectionPosition "action_pc")), 5, 1, 100];
uiSleep 50;

_random = random 100;

if (_random > 60) then {
    ["ENEDIS",format["Le transformateur de %1 est en train d'être hacké !",_ville_Proche]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];
	private _msg = format ["Le transformateur de %1 est en train d'être hacké !",_ville_Proche];
	["ENEDIS", _msg, "warning"] remoteExec [
		"ALF_fnc_doMsg",
		(allPlayers select { _x getVariable ['ENEDIS', false] })
	];
};

_object setObjectTextureGlobal [0, "ALF_Batiments\ALF_object\data\computer_308888.paa"];
playSound3D ["ALF_Client2\sounds\banque_pc_bip.ogg", _object, false, (_object modelToWorld (_object selectionPosition "action_pc")), 5, 1, 100];
uiSleep 50;

if (_pos distance _unit > 15) exitWith {["ENEDIS","Vous êtes partie trop loin du PC","warning"] remoteExec ["ALF_fnc_doMsg",_unit];["ALF_Pc",true] remoteExec ["ALF_fnc_handleItem",_unit];_object animateSource ["pc_source",0,true];};
_object setObjectTextureGlobal [0, "ALF_Batiments\ALF_object\data\computer_300888.paa"];
playSound3D ["ALF_Client2\sounds\banque_pc_bip.ogg", _object, false, (_object modelToWorld (_object selectionPosition "action_pc")), 5, 1, 100];
uiSleep 50;

_object setObjectTextureGlobal [0, "ALF_Batiments\ALF_object\data\computer_300688.paa"];
playSound3D ["ALF_Client2\sounds\banque_pc_bip.ogg", _object, false, (_object modelToWorld (_object selectionPosition "action_pc")), 5, 1, 100];
uiSleep 50;

if (_pos distance _unit > 15) exitWith {["ENEDIS","Vous êtes partie trop loin du PC","warning"] remoteExec ["ALF_fnc_doMsg",_unit];["ALF_Pc",true] remoteExec ["ALF_fnc_handleItem",_unit];_object animateSource ["pc_source",0,true];};
_object setObjectTextureGlobal [0, "ALF_Batiments\ALF_object\data\computer_300618.paa"];
playSound3D ["ALF_Client2\sounds\banque_pc_bip.ogg", _object, false, (_object modelToWorld (_object selectionPosition "action_pc")), 5, 1, 100];
uiSleep 45;

if (_pos distance _unit > 15) exitWith {["ENEDIS","Vous êtes partie trop loin du PC","warning"] remoteExec ["ALF_fnc_doMsg",_unit];["ALF_Pc",true] remoteExec ["ALF_fnc_handleItem",_unit];_object animateSource ["pc_source",0,true];};
playSound3D ["ALF_Client2\sounds\banque_pc_end.ogg", _object, false, (_object modelToWorld (_object selectionPosition "action_pc")), 5, 1, 100];
uiSleep 5;

_object setObjectTextureGlobal [0, "ALF_Batiments\ALF_object\data\computer_300614.paa"];
playSound3D ["ALF_Client2\sounds\banque_bigporte.ogg", _object, false, (_object modelToWorld (_object selectionPosition "action_pc")), 5, 1, 100];

["ENEDIS","Attaque réussite, courant couper dans le secteur","danger"] remoteExec ["ALF_fnc_doMsg",_unit];

_object animateSource ["disable_source",1,true];
_object setVariable ["broken",true,true];

_random = random 100;

if (_random > 50) then {
    ["ENEDIS",format["Le transformateur de %1 vient d'être déconnecté",_ville_Proche]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];
	["ENEDIS",format["Une coupure de courant impacte actuelement le transformateur de %1. Les équipes d'Enedis vont leur maximum pour rétablir le réseau",_ville_Proche]] remoteExec ["ALF_fnc_doBfmO",playableUnits];
};
private _msg = format ["Le transformateur de %1 vient d'être déconnecté",_ville_Proche];
["ENEDIS", _msg, "warning"] remoteExec [
    "ALF_fnc_doMsg",
    (allPlayers select { _x getVariable ['MRP_Bie_EnService', false] })
];

//uiSleep 300;
uisleep 60;
_object setVariable ["broken",false,true];


private _dice = random(100);
private _adn = _unit getVariable "adnface" select 0;
if(_dice > 40 ) then {
private  _data = _object getVariable ["ilyadeladn",[]];
	if(count _data isEqualTo 0) then {
		_object setVariable["ilyadeladn",[_adn],true];
	} else {
		_data pushBack _adn;
		_object setVariable["ilyadeladn",_data,true];
	};
};