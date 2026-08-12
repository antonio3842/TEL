// MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr = {
private _liste_Bouton_Inter = (uinamespace getVariable ["_liste_Bouton_Inter",[]]) select {!isnull _x};
private _liste_Ctrl_Suppr = [];

for "_i" from 0 to (count _liste_Bouton_Inter - 1) do 
{
	private _ctrl_Choisis = selectRandom (_liste_Bouton_Inter select {!(_x in _liste_Ctrl_Suppr)});
	_liste_Ctrl_Suppr pushback _ctrl_Choisis;

	_ctrl_Choisis ctrlEnable false;
	_ctrl_Choisis ctrlSetTooltip "";

	[_ctrl_Choisis] spawn 
	{params ["_ctrl"];
		_ctrl ctrlsetfade 0.5 + random 0.5;
		_ctrl ctrlcommit 0.1;
		sleep 0.1;

		_ctrl ctrlsetfade 0.6 + random 0.4;
		_ctrl ctrlcommit 0.1;
		sleep 0.1;

		_ctrl ctrlsetfade 0.7 + random 0.3;
		_ctrl ctrlcommit 0.1;
		sleep 0.1;

		_ctrl ctrlsetfade 0.8 + random 0.2;
		_ctrl ctrlcommit 0.1;
		sleep 0.1;

		_ctrl ctrlsetfade 0.9 + random 0.1;
		_ctrl ctrlcommit 0.1;
		sleep 0.1;

		_ctrl ctrlsetfade 1;
		private _ale = random 0.5;
		_ctrl ctrlcommit _ale;

		sleep _ale;

		ctrlDelete _ctrl;
	};
};

uinamespace setVariable ["_liste_Bouton_Inter",nil];
// };