// Fichier : fn_Littrage_Citerne_Vers_Client.sqf
// Auteurs : NorX Aengell & ARMA 3 Script GPT
// Fonction : MRPV2_Server_fnc_Littrage_Citerne_Vers_Client
// Description : Récupère les informations des citernes des stations-service et les assigne au joueur.
// MRPV2_Server_fnc_Littrage_Citerne_Vers_Client = {

private _joueur = param [0, objNull];  
private _id_Joueur = param [1, 0];  


private _citerne = nearestObject [_joueur,"plp_up_PropaneTankA"];
private _pos_Citerne = getpos _citerne;
private _resultat_Requete = ["SELECT pos,litre FROM station", 2, true] call ALF_Server_fnc_asyncCall;

if (_resultat_Requete isEqualTo []) then 
{
    [_citerne,_joueur] call MRPV2_Server_fnc_Littrage_Creation_Citerne_BDD;    
} else
{
    private _citerne_BDD_Proche = _resultat_Requete select {_pos_Citerne distance (parseSimpleArray (_x # 0)) < 100};

    if (_citerne_BDD_Proche isequalto []) then
    {    
        [_citerne,_joueur] call MRPV2_Server_fnc_Littrage_Creation_Citerne_BDD;
    } else 
    {
        _joueur setVariable ["MRPV2_Station_Citerne_Littrage", _resultat_Requete, _id_Joueur];  
        _joueur setVariable ["MRPV2_Station_Citerne_Littrage", nil];
    };
};
// };