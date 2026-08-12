// Nom du fichier : fn_setupKeyBinding_Farming.sqf
// Raccourci plantation : Shift+G

["Martinique RP", "Planter_Graine", ["Planter", "Planter la graine du champ (maïs, tabac, canne à sucre)."],
{
	[] spawn ALF_fnc_planterGraineRaccourci;
	true
}, {}, [34, [true, false, false]]] call CBA_fnc_addKeybind;
