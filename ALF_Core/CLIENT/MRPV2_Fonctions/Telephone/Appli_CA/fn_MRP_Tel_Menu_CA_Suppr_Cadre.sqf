private _numero = param [0,""];


private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",controlNull];
if (_ctrl_Liste_Controle_Canaux isEquaLTo controlNull) exitwith {};

private _ctrl_A_Supprimer = ((allControls _ctrl_Liste_Controle_Canaux) select {ctrlClassName _x isEqualTo "RscControlsGroupNoScrollbars" AND {ctrltooltip _x isEqualTo _numero}}) # 0;
if (isnil {_ctrl_A_Supprimer}) exitwith {};

[_numero,_ctrl_Liste_Controle_Canaux,_ctrl_A_Supprimer] call MRPV2_fnc_MRP_Tel_Menu_CA_Deplac_Cadre;

[_ctrl_A_Supprimer] spawn
{params ["_ctrl_A_Supprimer"];
	_ctrl_A_Supprimer ctrlenable FALSE;
	_ctrl_A_Supprimer ctrlsetfade 1;
	private _pos_ctrl = ctrlPosition _ctrl_A_Supprimer;
	_pos_ctrl set [0,0.5];
	_ctrl_A_Supprimer ctrlSetPosition _pos_ctrl;
	_ctrl_A_Supprimer ctrlCommit 0.3;

	sleep 0.3;

	ctrldelete _ctrl_A_Supprimer;
};

[] call MRPV2_fnc_MRP_Tel_Menu_CA_Deplac_Cadre;

TRUE