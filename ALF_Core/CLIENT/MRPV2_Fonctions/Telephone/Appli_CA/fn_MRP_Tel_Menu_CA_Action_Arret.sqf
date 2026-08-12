private _control = param [0,controlNull];

_control ctrlenable false;
playsound "MRP_Telephone_Touche_Appli";

private _numero = _control getvariable ["_numero",""];
private _info_Appel_CA = player getvariable ["MRP_Tel_CA_Info_Operateur",createHashMap] get _numero;
private _liste_id_Appelants = _info_Appel_CA # 2;
private _id_Appelant = _liste_id_Appelants # 0;

[_control,_id_Appelant,_liste_id_Appelants] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Arret_Effet_Cadre;
[_numero,_liste_id_Appelants] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Arret_Variables;

TRUE