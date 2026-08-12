private _control = param [0,controlNull];
private _id_Appelant = param [1,0];
private _liste_id_Appelants = param [2,[]];


playsound "MRP_Telephone_Touche_Appli";
private _Rscframe = _control getvariable ["_Rscframe",controlNull];
_Rscframe ctrlSetTextcolor [1,0,0,1];

{
	[_numero,"Arret"] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Couleur_Cadre",_x];
	[_numero] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Suppr_Cadre",_x];
} foreach (_liste_id_Appelants - [_id_Appelant]);

TRUE