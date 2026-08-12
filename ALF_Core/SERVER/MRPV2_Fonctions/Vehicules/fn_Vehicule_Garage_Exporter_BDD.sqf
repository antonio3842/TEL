// MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD = {
private _type_Garage = param [0,""];
private _type_Veh = param [1,""];
private _joueur = param [2,objnull];
private _secteur = param [3,0,[0]];

private _requete = "";
if (_type_Garage isequalto "vehicles") then 
{
	if (_secteur in [13,23,33,34]) then {
		_requete = format ["SELECT id, classname, alive, active, plate, position, fuel, insure, insurecount, lockveh, locktime, damage, id_garage FROM %1 WHERE alive='1' AND active='0' AND type='%2' AND pid='%3' AND id_garage='%4'",_type_Garage,_type_Veh,getPlayerUID _joueur,_secteur];
	} else {
		_requete = format ["SELECT id, classname, alive, active, plate, position, fuel, insure, insurecount, lockveh, locktime, damage, id_garage FROM %1 WHERE alive='1' AND active='0' AND type='%2' AND pid='%3' AND (id_garage='0' OR id_garage IS NULL)",_type_Garage,_type_Veh,getPlayerUID _joueur];
	};
} else 
{
	_requete = format ["SELECT id, classname, alive, active, plate, position, fuel, lockveh, locktime, damage FROM %1 WHERE alive='1' AND active='0' AND type='%2'",_type_Garage,_type_Veh];
};

private _resultat = [_requete,2,true] call ALF_Server_fnc_asyncCall;
if (_resultat isEqualType "") exitWith {};

if (_type_Garage isequalto "vehicles") then 
{
	private _vehs_Non_Fourriere = _resultat select {(_x # 9) isEqualTo 0};
	private _vehs_Fourriere = _resultat select {(_x # 9) isEqualTo 1};
	[_vehs_Non_Fourriere,_vehs_Fourriere] remoteExec ["MRPV2_fnc_Vehicule_Garage_Liste",_joueur];
} else
{
	private _vehs_Non_Fourriere = _resultat select {(_x # 7) isEqualTo 0};
	private _vehs_Fourriere = _resultat select {(_x # 7) isEqualTo 1};
	[_vehs_Non_Fourriere,_vehs_Fourriere] remoteExec ["ALF_fnc_impoundMenuCopSP",_joueur];
};
// };