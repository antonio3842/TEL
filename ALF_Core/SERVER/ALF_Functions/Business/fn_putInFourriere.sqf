// ALF_Server_fnc_putInFourriere = {
private _veh = param [0,objnull];
private _joueur = param [1,objnull];
private _duree = param [2,0];


private _plaque = getPlateNumber _veh;
private _damage = getAllHitPointsDamage _veh # 2;
private _fuel = fuel _veh;

{
	detach _x;
	deleteVehicle _x;
} forEach (attachedObjects _veh);

private _inventaire = [_veh] call MRPV2_Server_fnc_Vehicule_Inventaire_Sauvegarde;

private _systemTimeUTC_Format = systemTimeutc;
_systemTimeUTC_Format resize 5;

private _systemTimeUTC_Format_Fourriere = [];
_systemTimeUTC_Format_Fourriere = _systemTimeUTC_Format;
_systemTimeUTC_Format_Fourriere set [3,(_systemTimeUTC_Format_Fourriere # 3) + _duree];

private _requete = format["UPDATE vehicles SET active='0', fuel='%1', damage='%2', gear='%3', lockveh='1', locktime='%4' WHERE plate='%5'",_fuel,_damage,_inventaire,_systemTimeUTC_Format_Fourriere,_plaque];

[_requete,1] call ALF_Server_fnc_asyncCall;
["INFO",format ["Le véhicule (%1) vient d'être mis en fourrière.",_plaque],"success"] remoteExec ["ALF_fnc_doMsg",_joueur];

deleteVehicle _veh;
// };