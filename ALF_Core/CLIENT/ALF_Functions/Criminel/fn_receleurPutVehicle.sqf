_vehicles = missionNamespace getVariable ["MRP_vehicle_to_search",[]];
_vcl = nearestObjects [player, _vehicles, 20];



if (count _vcl < 1) exitWith {
    ["Receleur", "Tu te fou de ma gueule ? Y a aucun véhicule à proximité !", "danger", false] spawn alf_fnc_doMsg;
};
_owner = ((_vcl select 0) getVariable "vehicle_info_owners") select 1;

if (_owner isEqualTo (getPlayerUID player)) exitWith {
    ["Receleur", "C'est ton véhicule réfléchi !", "danger", false] spawn alf_fnc_doMsg;
};

if (!(isNull ("550055" call BIS_fnc_getUnitByUID)) && {(("550055" call BIS_fnc_getUnitByUID) distance player) < 100}) exitWith {
    ["Receleur", "Le propriétaire est pas loin barre toi !", "danger", false] spawn alf_fnc_doMsg;
};

_prix_achat = (["NUMBER", ["LifeCfgVehicles", typeOf (_vcl select 0), "achat"]] call ALFTools_Client_Config_fnc_getConfig);
_prix_receleur = _prix_achat * 0.5;


[_vcl select 0,player,format["Merci gros, tiens %1 € !",_prix_receleur]] remoteExec ["ALF_Server_fnc_receleurSell",2];

life_cash = life_cash + _prix_receleur;
[0] call SOCK_fnc_updatePartial;


private _ownerID = _unit getVariable ["ALF_ownerID",-1];
if (isNull _vehicle) exitWith {};
[name player,getPlayerUID player,"VEHICULE",format["vient de donner au receleur %1 (appartient à %3) pour %2 €.", _classname,_prix_receleur,_owner]] remoteExec ["ALF_Server_fnc_logIt",2];
