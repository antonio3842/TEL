// MRPV2_Server_fnc_Admins_Actions = {
private _joueur = param [0,objnull];
private _action = param [1,""];
private _joueur_Admin = param [2,objnull];


private _MDP_Rcon = gettext (configFile >> "Cfg_Server" >> "Serveur_Command_MDP");

if (_action isEqualTo "Ejecter") exitwith 
{
	private _reponse = _MDP_Rcon serverCommand format ["#kick %1",getplayeruid _joueur];
	[name _joueur_Admin,getPlayerUID _joueur_Admin,"MODO",format ["A éjecté %1",name _joueur]] remoteExec ["ALF_Server_fnc_logIt",2];
	[name _joueur,getPlayerUID _joueur,"MODO",format ["A éjecté %1",name _joueur_Admin]] remoteExec ["ALF_Server_fnc_logIt",2];
};

if (_action isEqualTo "Bannir") then 
{
	_MDP_Rcon serverCommand format ["#exec ban %1",str (getplayeruid _joueur)];
	[name _joueur_Admin,getPlayerUID _joueur_Admin,"MODO",format ["A bannis %1",name _joueur]] remoteExec ["ALF_Server_fnc_logIt",2];
	[name _joueur,getPlayerUID _joueur,"MODO",format ["A bannis %1",name _joueur_Admin]] remoteExec ["ALF_Server_fnc_logIt",2];
};

// if (_action isEqualTo "Verrouiller") then
// {
// 	_MDP_Rcon serverCommand "#lock";
// };

// if (_action isEqualTo "Déverrouiller") then
// {
// 	_MDP_Rcon serverCommand "#unlock";
// };
// };