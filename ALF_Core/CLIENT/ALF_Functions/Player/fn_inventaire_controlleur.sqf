while {true} do {
	waituntil {!(isnull (finddisplay 602))};
	{
		((findDisplay 602) displayCtrl _x) ctrlSetEventHandler ["LBDblClick", "[_this, player] spawn ALF_fnc_inventaire"];
	} count [633, 638, 619];
	waituntil {isnull (finddisplay 602)};
	if !(isNull(uiNamespace getVariable['ALF_inventory_display',displayNull])) then {
		(uiNamespace getVariable['ALF_inventory_display',displayNull]) closeDisplay 1;
	};
};