/*
	File: fn_distrib_restockClose.sqf
	Ferme le menu réappro (Échap ou appel manuel).
*/
uiNamespace setVariable ["MRP_Distrib_RestockOpen", false];
uiNamespace setVariable ["MRP_Distrib_RestockMachine", nil];
uiNamespace setVariable ["MRP_Distrib_RestockFocus", nil];
uiNamespace setVariable ["MRP_Distrib_RestockGroup", controlNull];
uiNamespace setVariable ["MRP_Distrib_RestockButtons", createHashMap];
uiNamespace setVariable ["MRP_Distrib_RestockLayout", nil];

closeDialog 0;
