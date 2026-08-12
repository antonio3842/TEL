// MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation = {
private _liste_Actions = param [0,createhashmap];


private _MRPV2_Interface_Base = uiNamespace getVariable ["MRPV2_Interface_Diverse",controlnull];
private _ctrlGroup_Menu_Inter = uinamespace getVariable ["_ctrlGroup_Menu_Inter",controlnull];

private _pos_Debut_Btn_Action_X = 0.8;
if (count _liste_Actions < 10) then {_pos_Debut_Btn_Action_X = 1;};

private _ecart_Pos_Btn_Action_X = 0.45;

private _pos_Debut_Btn_Action_Y = 0.74;
private _ecart_Pos_Btn_Action_Y = 0.06;

private _longueur_Btn = 0.41;
private _hauteur_Btn = 0.045;

private _num_Colonne = 0;
private _liste_Bouton_Inter = [];

private _menu_Choisis = uinamespace getVariable ["MRPV2_Menu_Inter_Menu_Choisis",0];

{
	private _texte = _x # 0;
	private _texte_tooltype = _x # 1;
	private _action = _x # 2;
	private _num_Btn = _foreachindex;

	if (_foreachindex > 8) then 
	{
		_num_Btn = _foreachindex - 9;
		_num_Colonne = 1;
	};

	private _ctrlButton = _MRPV2_Interface_Base ctrlCreate ["Life_RscButtonMenu",-1,_ctrlGroup_Menu_Inter];
	_liste_Bouton_Inter pushback _ctrlButton;
	_ctrlButton ctrlSetPosition [_pos_Debut_Btn_Action_X + (_num_Colonne * _ecart_Pos_Btn_Action_X),_pos_Debut_Btn_Action_Y + (_num_Btn * _ecart_Pos_Btn_Action_Y),_longueur_Btn,_hauteur_Btn];
	_ctrlButton ctrlSetBackgroundColor [0.17,0.22,0.3,1];
	_ctrlButton ctrlSetStructuredText parseText format ["<t size='1' align='center'>%1</t>",_texte];
	_ctrlButton ctrlsettooltip _texte_tooltype;
	_ctrlButton ctrlsetfade 1;
	_ctrlButton ctrlCommit 0;

	[_ctrlButton,_foreachindex] spawn 
	{params ["_ctrl","_foreachindex"];
		sleep 0.2;
		_ctrl ctrlsetfade 0;
		_ctrl ctrlcommit 0.2 * _foreachindex;
	};

	_ctrlButton ctrlAddEventHandler ["ButtonClick",_action];

	_ctrlButton ctrlAddEventHandler ["MouseEnter",
	{params ["_ctrl"];
		_ctrl ctrlSetBackgroundColor [0.98,0.49,0.16,1];
	}];

	_ctrlButton ctrlAddEventHandler ["MouseExit",
	{params ["_ctrl"];
		_ctrl ctrlSetBackgroundColor [0.17,0.22,0.3,1];
	}];
} foreach _liste_Actions;

uinamespace setVariable ["_liste_Bouton_Inter",_liste_Bouton_Inter];
// };