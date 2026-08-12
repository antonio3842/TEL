// ALF_fnc_storeVehicle = {
private _joueur = param [0,objnull];
private _type_Veh = param [1,""];

private _vehs_Proches = [];
private _vehicule = objnull;

if(vehicle player != player) then 
{
	_vehicule = vehicle player;
} else 
{
	_vehs_Proches = nearestObjects [getPos _joueur, ["Car","Air","Ship"], 30] select {alive _x AND {((_x getVariable ["vehicle_info_owners",["",""]]) # 1) isequalto (getPlayerUID _joueur)}};
	if (count _vehs_Proches > 0) then {_vehicule = _vehs_Proches # 0;};
};
if (isNil {_vehicule}) exitWith {hint localize "STR_Garage_NoNPC"};
if (isNull _vehicule) exitWith {};
if !(alive _vehicule) exitWith {hint localize "STR_Garage_SQLError_Destroyed"};

if (((_vehicule getVariable ["vehicle_info_owners",["",""]]) # 0) in ["Gendarmerie","Pompiers","Eboueur","policemunicipale"]) exitWith 
{
	["Garage", "Vous ne pouvez pas rentrer votre véhicule de service ici.", "danger"] spawn ALF_fnc_doMsg;
};

if (_type_Veh isnotequalto "") then 
{
    if !(_vehicule isKindOf _type_Veh) exitWith {["Garage", "Ce garage ne permet pas de ranger ce type de véhicule.", "danger", false] spawn ALF_fnc_doMsg;};
};

if (isEngineOn _vehicule) exitWith 
{
    ["Garage", "Il est impossible de rentrer un véhicule qui a son moteur allumé.", "danger", false] spawn ALF_fnc_doMsg;
};

[_vehicule,_joueur,localize "STR_Garage_Store_Success"] remoteExec ["ALF_Server_fnc_vehicleStore",2];

life_garage_store = true;
// };