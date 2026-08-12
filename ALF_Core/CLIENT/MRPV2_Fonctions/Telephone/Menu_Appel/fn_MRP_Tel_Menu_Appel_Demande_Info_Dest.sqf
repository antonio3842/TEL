// MRPV2_fnc_MRP_Tel_Menu_Appel_Demande_Info_Dest = {
private _expediteur = param [0,Objnull];
private _numero_Expediteur = param [1,""];
private _numero_Masquer = param [2,FALSE];

MRP_Telephone_Numero_Appel = _numero_Expediteur;
_expediteur setVariable ["MRP_Telephone_Numero_Cacher",_numero_Masquer];

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap] getordefault [MRP_Telephone_Numero_Appel,[]];
private _expediteur_Est_Bloquer = FALSE;

if (_liste_Contact isnotequalto []) then {_expediteur_Est_Bloquer = [_liste_Contact # 5,FALSE] select (_liste_Contact isequalto [])};

_expediteur setVariable ["MRP_Telephone_Expediteur_Est_Bloquer",_expediteur_Est_Bloquer,remoteExecutedOwner];

TRUE
// };