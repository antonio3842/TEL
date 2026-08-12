_vehicles = missionNamespace getVariable ["MRP_vehicle_to_search",[]];
if (count _vehicles == 0) exitWith {
    ["Receleur", "Excuse moi gros, on m'a déjà ramené tout ce dont j'avais besoin", "danger", false] spawn alf_fnc_doMsg;
};

_text = "";
  
{
    _text = _text + "- "+(getText(configFile >> "CfgVehicles" >> _x >> "DisplayName"))+"<br/>";
} forEach _vehicles;

["Receleur", "Ok écoute moi bien, regarde la liste à droite, retiens bien je te le dirais pas. Ramene moi un de ces véhicules", "success", false] spawn alf_fnc_doMsg;
hint parseText _text;