private _MRPV2_Interface_Base = uiNamespace getVariable ["MRPV2_Interface_Diverse",controlnull];
private _ctrlGroup = uinamespace getVariable ["_ctrlGroup",controlnull];

private _ctrlGroup_Baril = _MRPV2_Interface_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_ctrlGroup];
_ctrlGroup_Baril ctrlSetPosition [0,safeZoneh * 0.7,safeZonew * 0.1,safeZoneh * 0.3];
_ctrlGroup_Baril ctrlSetBackgroundColor [1,0,0,0.9];
_ctrlGroup_Baril ctrlenable false;
_ctrlGroup_Baril ctrlCommit 0;

// Arriere plan baril
private _ctrl_Baril = _MRPV2_Interface_Base ctrlCreate ["Rscpicture",-1,_ctrlGroup_Baril];
_ctrl_Baril ctrlSetText "MRPV2_Farm_Petrole\Data\Baril_Vide.paa";
_ctrl_Baril ctrlSetPosition [0,0,safeZonew * 0.1,safeZoneh * 0.3];
_ctrl_Baril ctrlenable false;
_ctrl_Baril ctrlCommit 0;

playSoundUI ["MRPV2_Petrole_Baril_Vide",0.4,0.8 + random 0.4];

[_ctrlGroup_Baril,_ctrl_Baril]