// MRPV2_fnc_MRP_Tel_Menu_CA_Action_Appel_Effet_Cadre = {
private _control = param [0,controlNull];
private _numero = param [1,""];

private _CG_Options = _control getVariable ["_CG_Options",controlNull];
private _Rscframe = _control getvariable ["_Rscframe",controlNull];
_Rscframe ctrlsettextcolor [0,1,0,1];

_control ctrlenable false;
_control ctrlsetfade 0.7;
_control ctrlCommit 0.3;

private _ctrlButton_Pause = _CG_Options getVariable ["_ctrlButton_Pause",controlNull];
_ctrlButton_Pause ctrlenable true;
_ctrlButton_Pause ctrlsetfade 0;
_ctrlButton_Pause ctrlCommit 0.3;
_ctrlButton_Pause ctrlsettextcolor [0.9,0.9,0.9,1];

private _ctrlButton_Arret = _CG_Options getVariable ["_ctrlButton_Arret",controlNull];
_ctrlButton_Arret ctrlenable true;
_ctrlButton_Arret ctrlsetfade 0;
_ctrlButton_Arret ctrlCommit 0.3;
_ctrlButton_Arret ctrlsettextcolor [0.9,0.9,0.9,1];

private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",controlNull];

private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
private _numero_Enregistrer = (_tel_CA_Info_Ope get "Mon appel") # 0;

// Changement de couleur de l'ancien cadre
if (!isnil {_numero_Enregistrer} AND {_numero isNotEqualTo _numero_Enregistrer}) then
{
	private _ancien_Control_Appel = ((allControls _ctrl_Liste_Controle_Canaux) select {ctrlClassName _x isNotEqualTo "RscControlsGroupNoScrollbars" AND {ctrltooltip _x isEqualTo _numero_Enregistrer}}) # 0;
	_ancien_Control_Appel ctrlsettextcolor [0.9,0.38,0.16,1];
	(_tel_CA_Info_Ope get _numero_Enregistrer) set [1,"Pause"];
};

// Changement de couleur des cadres des autres opérateurs
private _liste_Unites_En_Service = (allplayers select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT) isEquaLTo ([] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)});
[_numero,"Appel"] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Couleur_Cadre",_liste_Unites_En_Service];

private _liste_Tous_Ctrl = (allControls _ctrl_Liste_Controle_Canaux) select {ctrlClassName _x isEqualTo "RscControlsGroupNoScrollbars" AND {ctrltooltip _x isNotEqualTo ""}};
private _CG_CORG_Appel_En_Cours = (_liste_Tous_Ctrl select {(ctrltooltip _x ) isEqualTo _numero_Enregistrer}) # 0;
private _ctrlButton_Accepter_Icone = _CG_CORG_Appel_En_Cours getVariable ["_ctrlButton_Accepter_Icone",controlNull];

// Suppression de l'icone de pause si ancienne converse en pause
if (_ctrlButton_Accepter_Icone isNotEquaLTo controlNull) then
{
	_ctrlButton_Accepter_Icone ctrlSetFade 1;
	_ctrlButton_Accepter_Icone ctrlCommit 0.3;
	[_ctrlButton_Accepter_Icone] spawn {params ["_ctrlButton_Accepter_Icone"]; uisleep 0.3; ctrlDelete _ctrlButton_Accepter_Icone;};
};

TRUE
// };