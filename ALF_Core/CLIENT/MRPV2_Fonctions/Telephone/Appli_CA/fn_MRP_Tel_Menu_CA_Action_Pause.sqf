// MRPV2_fnc_MRP_Tel_Menu_CA_Action_Pause = {
private _control = param [0,controlNull];

_control ctrlenable false;
playsound "MRP_Telephone_Touche_Appli";

private _numero = _control getvariable ["_numero",""];
systemchat format ["[DEBUG Action Pause CA] _numero = %1",_numero];
private _CG_Options = _control getVariable ["_CG_Options",controlNull];

playsound "MRP_Telephone_Touche_Appli";
player setvariable ["MRP_Appel_Etat","Pause appel CA"];

private _ctrlButton_Arret = _CG_Options getvariable ["_ctrlButton_Arret",controlNull];

[_ctrlButton_Arret,_numero] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Pause_Effet_Cadre;
[_numero] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Pause_Variables;

TRUE
// };