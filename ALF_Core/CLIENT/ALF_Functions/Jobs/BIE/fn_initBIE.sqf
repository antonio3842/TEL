/*
	Boucle qui check l'état des lamps pour les eteindres dans un rayon de 500m si plus de courant
*/

diag_log "INIT BIE OK";
while {true} do {
	[] spawn ALF_fnc_actionLamps;
	sleep 10;
};
