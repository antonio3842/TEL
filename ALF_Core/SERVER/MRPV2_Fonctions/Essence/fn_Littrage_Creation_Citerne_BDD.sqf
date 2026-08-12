// Fichier : fn_Littrage_Creation_Citerne_BDD.sqf  
// Auteurs  : NorX Aengell & Sierra (IA)  
// Fonction : MRPV2_Server_fnc_Littrage_Creation_Citerne_BDD  
// Description : Crée une nouvelle citerne en base de données avec un litrage initial de 3000L.  
// MRPV2_Server_fnc_Littrage_Creation_Citerne_BDD = {

private _citerne = param [0, objNull];
private _joueur = param [1, objNull];


if (isNull _citerne) exitWith  
{
    ["CITERNE", "Aucune citerne valide n'a été trouvée.", "warning"] spawn ALF_fnc_doMsg;  
};  

private _pos_Citerne = getPosATL _citerne;
private _contenance_Citerne = 3000;
private _query = format  
[  
    "INSERT INTO station (pos, litre) VALUES ('%1','%2')",  
    _pos_Citerne,  
    _contenance_Citerne  
];  

[_query, 1] call ALF_Server_fnc_asyncCall;

_joueur setVariable ["MRPV2_Station_Citerne_Littrage",[[str _pos_Citerne,_contenance_Citerne]], owner _joueur];  
_joueur setVariable ["MRPV2_Station_Citerne_Littrage", nil];
// };