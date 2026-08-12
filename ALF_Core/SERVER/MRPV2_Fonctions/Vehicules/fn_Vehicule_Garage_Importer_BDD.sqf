// MRPV2_Server_fnc_Vehicule_Garage_Importer_BDD = {
private _joueur = param [0,objnull];
private _type_Garage = param [1,""];
private _plaque = param [2,""];

if (_plaque isEqualTo "") exitWith {["GARAGE","Votre véhicule a un problème de plaque.","danger"] remoteExec ["ALF_fnc_doMsg",_joueur];};

private _query = format ["UPDATE %1 SET position='%2' WHERE plate='%3'",_type_Garage,[getposatl _joueur,0],_plaque];
[_query,1] call ALF_Server_fnc_asyncCall;

["GARAGE","Votre véhicule a été importé dans ce garage.","success"] remoteExec ["ALF_fnc_doMsg",_joueur];
// };