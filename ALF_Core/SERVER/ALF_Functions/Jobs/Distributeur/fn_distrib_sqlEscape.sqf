/*
	File: fn_distrib_sqlEscape.sqf
	Échappe les apostrophes pour requêtes MySQL.
*/
params [["_str", "", [""]]];

_str splitString "'" joinString "''"
