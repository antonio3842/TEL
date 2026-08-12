// MRPV2_fnc_MRP_Tel_Menu_CA_Action_Arret_Variables = {
private _numero = param [0,""];
private _liste_id_Appelants = param [1,[]];


private _id_Appelant = _liste_id_Appelants # 0;
private _liste_Unites_En_Service = (units group player);

[_numero,"Arret civil",clientowner] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",[_id_Appelant]];
[_numero,"Arret opé",clientowner] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_liste_id_Appelants];
[_numero,"Arret opé maj autre opé",clientowner] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_liste_Unites_En_Service];

TRUE
// };