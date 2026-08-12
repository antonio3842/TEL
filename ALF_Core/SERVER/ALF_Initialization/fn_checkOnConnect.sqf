/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/

if !(isServer) exitWith {};
if (hasInterface) exitWith {};

private _v = params[["_player", objNull, [objNull]]];
if !(_v) exitWith {};

private _pID = getPlayerUID _player;

// if (isnil {ALF_serverReady} OR {!ALF_serverReady}) exitwith 
// {
// 	[_pID,'SERVEUR',"Le serveur est actuellement en préparation. Veuillez attendre quelques instants avant de vous connecter."] call ALFTools_Server_fnc_kick;
// };

if (ALF_isUnderMaintenance) exitwith 
{
	private _isAdmin = [_pID, 1] call ALFTools_Server_fnc_isAdmin;
	if !(_isAdmin) exitWith 
	{
		[_pID, 'SERVEUR', "Le serveur est actuellement en maintenance. Tenez-vous informé sur Discord pour tout changement."] call ALFTools_Server_fnc_kick;
	};
};

private _ret = [_pid] call ALFTools_Server_fnc_checkBan;

if (_ret#0) then 
{
	_ret params ["_isBan", "_reason", "_adminName", "_banDateString", "_endDateString"];

	[_pID,"SERVEUR", format["Et êtes bannis du serveur pour la raison suivante : '%1' | Par : '%2' | Date du bannissement : '%3' | Date de fin : '%4' | Si vous constatez un problème merci de contacter l'administration",_reason, _adminName, _banDateString, _endDateString]] call ALFTools_Server_fnc_kick;
	
	// MDP_Rcon = getText(configFile >> "Cfg_Server" >> "Serveur_Command_MDP");
	_MDP_Rcon = "MRPV2_Serv";
	_MDP_Rcon serverCommand format["#exec ban %1",str _pID];
};