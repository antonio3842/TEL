// MRPV2_fnc_MRP_Tel_Menu_Principal_Mail = {
private _nombre_Mail_Api = param [0,0];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

private _RscPicture = _Telephone_Base ctrlCreate ["RscPicture",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Arriere_Plan_Compteur_Mail",_RscPicture];
private _ctrl_Mail = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_Creation_Bouton_Mail",controlNull];
private _pos_Icone = ctrlposition _ctrl_Mail;
_RscPicture ctrlenable false;

_pos_Icone set [0,(_pos_Icone # 0) + 0.06];
_pos_Icone set [1,(_pos_Icone # 1) + 0.008];
_pos_Icone set [2,0.03];
_pos_Icone set [3,0.04];

_RscPicture ctrlSetPosition _pos_Icone;
_RscPicture ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_Nombre_Message.paa";
_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
_RscPicture ctrlCommit 0;

_ctrl_nombre_Nouveau_Mail = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Telephone_Menu_Principal_nombre_Nouveau_Mail",_ctrl_nombre_Nouveau_Mail];
_pos_Icone set [0,(_pos_Icone # 0) - 0.004];
_pos_Icone set [1,(_pos_Icone # 1) + 0.006];
_pos_Icone set [2,0.04];
_ctrl_nombre_Nouveau_Mail ctrlSetPosition _pos_Icone;
_ctrl_nombre_Nouveau_Mail ctrlCommit 0;

_ctrl_nombre_Nouveau_Mail ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#ffffff' shadow='0' size='0.7' align='center'>%1</t>",_nombre_Mail_Api];

_ctrl_Mail ctrlAddEventHandler ["MouseButtonDown",
{params ["_ctrl"];
	private _ctrl_Icone_Mail = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_Arriere_Plan_Compteur_Mail",controlNull];
	private _ctrl_nombre_Nouveau_Mail = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_nombre_Nouveau_Mail",controlNull];

	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	_telephone_Configuration set [12,[0,servertime + 300]];
	profileNamespace setVariable ["MRP_Telephone_Configuration",_telephone_Configuration];

	ctrldelete _ctrl_Icone_Mail;
	ctrldelete _ctrl_nombre_Nouveau_Mail;	
}];

TRUE
// };