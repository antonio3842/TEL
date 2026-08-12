private _control = param [0,controlNull];

playsound "MRP_Telephone_Touche_Appli";
private _numero = _control getvariable ["_numero",""];


[_control,_numero] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Appel_Effet_Cadre;
[_control,_numero] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Appel_Variables;

TRUE