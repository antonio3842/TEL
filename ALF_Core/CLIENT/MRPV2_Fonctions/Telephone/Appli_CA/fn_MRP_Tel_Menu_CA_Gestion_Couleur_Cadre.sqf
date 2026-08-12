private _numero = param [0,""];
private _type = param [1,""];


private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",controlNull];
if (_ctrl_Liste_Controle_Canaux isequalto controlNull) exitwith {};

private _ctrl_Frame = ((allControls _ctrl_Liste_Controle_Canaux) select {ctrlClassName _x isequalto "RscFrame" AND {ctrltooltip _x isequalto _numero}}) # 0;

if (_type isequalto "Appel") then {_ctrl_Frame ctrlsettextcolor [0,1,0,1];};
if (_type isequalto "Pause") then {_ctrl_Frame ctrlsettextcolor [0.9,0.38,0.16,1];};
if (_type isequalto "Arret") then {_ctrl_Frame ctrlSetTextcolor [1,0,0,1];};

TRUE