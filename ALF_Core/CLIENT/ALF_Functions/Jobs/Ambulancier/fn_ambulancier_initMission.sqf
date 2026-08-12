if (!alive player) exitWith {};
_type = param[0,""];


private _camion = player getVariable ["MRP_Ambulancier_Camion", objNull];

if (isNull _camion) exitWith {
    ["Ambulancier", "Camion introuvable!", "danger"] spawn ALF_fnc_doMsg;
};

if (player distance _camion > 20) exitWith {
    ["Ambulancier", "Camion trop loin!", "danger"] spawn ALF_fnc_doMsg;
};
_camion setVariable ["MRP_Ambulancier", true, true];
// Initialisation variables
MRP_AmbulancierEnCours = true;

_organes = ["Foie", "Rein", "Coeur", "Poumon", "Pied"];
_organe = selectRandom _organes;

_msg = "";
if (_type isEqualTo "MRPV2_PNJ_Emploi_Ambulancier_1") then {
  _msg = format ["Vous devez amener un %1 à l'hôpital de La trinité", _organe];
  MRP_Ambulancier_Destination = "MRPV2_PNJ_Emploi_Ambulancier_2";
} else {
   _msg = format ["Vous devez amener un %1 à l'hôpital de Fort de France", _organe];
   MRP_Ambulancier_Destination = "MRPV2_PNJ_Emploi_Ambulancier_1";
};
["Ambulancier", _msg, "success"] spawn ALF_fnc_doMsg;

["Ambulancier", "Amenez l'organe.", "success"] spawn ALF_fnc_doMsg;