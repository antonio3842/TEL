// MRPV2_Server_fnc_Vehicule_Gestion_Dispo_Et_Ajout_BDD = {
private _className = param [0,""]; 
private _joueur = param [1,objnull]; 
private _type_Achat = param [2,"Civil"];
private _prix_Achat = param [3,0];
private _type_Veh = param [4,""];
private _isB33Enterprise = param [5,false,[false]];

private _plaque = [] call MRPV2_fnc_Vehicule_Creation_Plaque;

private _type_BDD = "";
[] call 
{
    if (_type_Achat isequalto "Civil Achat") exitwith {_type_BDD = "vehicles";};
    if (_type_Achat isequalto "GN Achat") exitwith {_type_BDD = "vehicles_cop";};
    if (_type_Achat isequalto "SP Achat") exitwith {_type_BDD = "vehicles_med";};
    if (_type_Achat isequalto "AP Achat") exitwith {_type_BDD = "vehicles_penit";};
};

private _requete = format ["SELECT plate FROM %1 WHERE plate='%2'",_type_BDD,_plaque];
private _resultat_Requete = [_requete,2] call ALF_Server_fnc_asyncCall;

if(_resultat_Requete isEqualTo []) then 
{
    private _requete = format["SELECT dispo FROM shop WHERE classname='%1'",_className];
    private _resultat_Requete = [_requete,2] call ALF_Server_fnc_asyncCall;
    if (_resultat_Requete isEqualTo []) exitWith {};

    private _dispo = _resultat_Requete # 0;
    if (typeName _dispo == "STRING") then {
        _dispo = parseNumber _dispo;
    };    

    if (!_isB33Enterprise) then {
        if(_dispo <= 0) exitWith {["INFO","Le véhicule n'est plus disponible.","danger"] remoteExec ["ALF_fnc_doMsg",_joueur];};
    };

    ["INFO", format
    [
        "Détail de votre commande : %1 pour %2 €.",
        getText(configFile >> "CfgVehicles" >> _className >> "displayName"),
        [_prix_Achat] call ALF_fnc_numberText
    ],"success"] remoteExec ["ALF_fnc_doMsg",_joueur];

    if (!_isB33Enterprise) then {
        private _nouvelle_Dispo = _dispo - 1;
        private _query = format["UPDATE shop SET dispo='%1' WHERE classname='%2'",_nouvelle_Dispo,_className];
        [_query,1] call ALF_Server_fnc_asyncCall;
    };		

    _query = format["INSERT INTO %1 (classname, type, plate, pid, position) VALUES ('%2','%3','%4','%5','%6')",_type_BDD,_className,_type_Veh,_plaque,getplayeruid _joueur,[getposatl _joueur,0]];

    [_query,1] call ALF_Server_fnc_asyncCall;

    [_className,_type_Achat,_joueur,_plaque] remoteExec ['MRPV2_fnc_Vehicule_Creation',_joueur];		
} else
{
    [] call MRPV2_Server_fnc_Vehicule_Gestion_Dispo_Et_Ajout_BDD;
}
// };