private _control = param [0,controlnull];


private _liste_Ctrl_Baril = MRPV2_Petrole_Liste_Baril_Vide_Interface # 0;
private _ctrl_Niveau_Petrole = uinamespace getVariable ["_ctrl_Niveau_Petrole",controlnull];
private _pos_Carbu = ctrlPosition _ctrl_Niveau_Petrole;

_ctrl_Niveau_Petrole ctrlSetPositionY (_pos_Carbu # 1) - 0.13 max 0.383;
_ctrl_Niveau_Petrole ctrlSetPositionH (_pos_Carbu # 3) + 0.13;
_ctrl_Niveau_Petrole ctrlCommit 0.6;

private _id_Son = playSoundUI ["a3\sounds_f\sfx\ui\vehicles\vehicle_refuel.wss",1,0.7,false,1.5]; 

private _MRPV2_Petrole_Baril_Bouton_Tas_Gauche = uiNamespace getVariable ["MRPV2_Petrole_Baril_Bouton_Tas_Gauche",controlnull];
ctrlSetFocus _MRPV2_Petrole_Baril_Bouton_Tas_Gauche;

private _ctrl_Poignet_Pivot = uinamespace getVariable ["MRPV2_Petrole_Baril_Ctrl_Poignet_Pivot",controlnull];
_ctrl_Poignet_Pivot ctrlSetAngle [40,0.5,0.5,false];
_ctrl_Poignet_Pivot ctrlCommit 0.5;

private _MRPV2_Petrole_Baril_Bouton_Tas_Gauche = uiNamespace getVariable ["MRPV2_Petrole_Baril_Bouton_Tas_Gauche",controlnull];
ctrlSetFocus _MRPV2_Petrole_Baril_Bouton_Tas_Gauche;

private _pos_ctrl = ctrlPosition _ctrl_Poignet_Pivot;
_pos_ctrl set [0,(_pos_ctrl # 0) - 0.03];
_ctrl_Poignet_Pivot ctrlSetPosition _pos_ctrl;
_ctrl_Poignet_Pivot ctrlCommit 0.5;

private _MRPV2_Petrole_Baril_Bouton_Tas_Gauche = uiNamespace getVariable ["MRPV2_Petrole_Baril_Bouton_Tas_Gauche",controlnull];
ctrlSetFocus _MRPV2_Petrole_Baril_Bouton_Tas_Gauche;

private _ctrl_Piston_Vertical = uinamespace getVariable ["MRPV2_Petrole_Baril_Ctrl_Piston_Vertical",controlnull];
private _pos_ctrl_Piston_Vertical = ctrlPosition _ctrl_Piston_Vertical;

_pos_ctrl_Piston_Vertical set [1,(_pos_ctrl_Piston_Vertical # 1) + 0.11];
_ctrl_Piston_Vertical ctrlSetPosition _pos_ctrl_Piston_Vertical;
_ctrl_Piston_Vertical ctrlCommit 0.5;

private _MRPV2_Petrole_Baril_Bouton_Tas_Gauche = uiNamespace getVariable ["MRPV2_Petrole_Baril_Bouton_Tas_Gauche",controlnull];
ctrlSetFocus _MRPV2_Petrole_Baril_Bouton_Tas_Gauche;

// Retour a position initiale
[_control,_pos_ctrl,_pos_Carbu,_ctrl_Piston_Vertical,_pos_ctrl_Piston_Vertical,_ctrl_Poignet_Pivot] spawn 
{params ["_control","_pos_ctrl","_pos_Carbu","_ctrl_Piston_Vertical","_pos_ctrl_Piston_Vertical","_ctrl_Poignet_Pivot","_ctrl_Niveau_Petrole"];
	sleep 0.6;

	_ctrl_Poignet_Pivot ctrlSetAngle [0,0.5,0.5,false];
	_ctrl_Poignet_Pivot ctrlCommit 0.5;
	_pos_ctrl set [0,(_pos_ctrl # 0) + 0.03];
	_ctrl_Poignet_Pivot ctrlSetPosition _pos_ctrl;
	_ctrl_Poignet_Pivot ctrlCommit 0.5;

	_pos_ctrl_Piston_Vertical set [1,(_pos_ctrl_Piston_Vertical # 1) - 0.11];			
	_ctrl_Piston_Vertical ctrlSetPosition _pos_ctrl_Piston_Vertical;
	_ctrl_Piston_Vertical ctrlCommit 0.5;

	private _MRPV2_Petrole_Baril_Bouton_Tas_Gauche = uiNamespace getVariable ["MRPV2_Petrole_Baril_Bouton_Tas_Gauche",controlnull];
	ctrlSetFocus _MRPV2_Petrole_Baril_Bouton_Tas_Gauche;

	sleep 0.6;

	_control ctrlenable TRUE;
	player setvariable ["MRPV2_Petrole_Pompe","Pompe abaissé"];

	if ((_pos_Carbu # 3) >= 0.5) then
	{
		["PETROLE", "Votre baril est rempli.", "success"] spawn ALF_fnc_doMsg;
		player removemagazine "ALF_Barile_P_E";
		player addMagazine "ALF_Barile_P_F";
		player setvariable ["MRPV2_Petrole_Baril","Baril plein"];
		player setvariable ["MRPV2_Petrole_Pompe","Pompe abaissé"];
	};
};