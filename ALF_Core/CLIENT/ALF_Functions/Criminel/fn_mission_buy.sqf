params [
	["_mission", "", [""]]
];
if (_mission isEqualTo "") exitWith {};

private _config = ["CLASS",["ALF_MISSIONS", _mission]] call ALFTools_Client_Config_fnc_getConfig;
if !([["ALF_MISSIONS", _mission]] call ALFTools_Client_Config_fnc_isClass) exitWith {};

private _price = ["NUMBER",["prix"],_config] call ALFTools_Client_Config_fnc_getConfig;
if (life_cash < _price) exitWith {
	["ERREUR", format["Vous n'avez pas %1 € sur vous.",_price], "warning"] spawn ALF_fnc_doMsg;
};
if (_price > 0) then {
	life_cash = life_cash - _price;
	[0] call SOCK_fnc_updatePartial;
};
["CRIME","Connexion en cours ....","warning"] remoteExec ["ALF_fnc_doMsg",player];
uiSleep(5);
["CRIME","Conversion des fonds en bitcoins ....","warning"] remoteExec ["ALF_fnc_doMsg",player];
uiSleep(5);
["CRIME","Envoi des fonds au contact ....","warning"] remoteExec ["ALF_fnc_doMsg",player];
uiSleep(5);
["CRIME","Paiement réussi, le contact vous transmettra les infos dans 2 min.","success"] remoteExec ["ALF_fnc_doMsg",player];


uiSleep(120);
private _cPosition = ["ARRAY",["positions"],_config] call ALFTools_Client_Config_fnc_getConfig;
private _position = ([_cPosition] call CBA_fnc_shuffle) call BIS_fnc_selectRandom;

[1,ALF_Phone_Number,ALF_Phone_Number,format["La livraison arrivera en %1 dans 10 minutes environ.", mapGridPosition _position]] remoteExecCall ["ALF_Server_fnc_sendSmsPhone",2];
private _name = ["STRING",["name"],_config] call ALFTools_Client_Config_fnc_getConfig;
[format["/!\ ALERTE /!\ D'après nos informations, une %1 aurait été apperçue.",_name]] remoteExec ["ALF_fnc_doBfmCrime",(playableUnits select {alive _x})];
["/!\ ALERTE /!\",format["D'après nos informations, une %1 aurait été apperçue.",_name]]remoteExecCall ["ALF_Server_fnc_doCopCall",2];
[player, _mission, _position] remoteExec ["ALF_Server_fnc_mission", 2];