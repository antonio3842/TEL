// ALF_fnc_copStoreVehicle = {

private _joueur = param [0,objnull];
private _veh = param [1,objnull];
if(isNull _veh OR {isNull _joueur}) exitWith {};

private _a = ["Etes-vous sur de vouloir mettre ce véhicule au garage ?","INFO","OUI","NON"] call BIS_fnc_guiMessage;
if !(_a) exitWith {};

[_joueur,_veh] remoteExec ["ALF_Server_fnc_copStoreVehicle",2];
// };