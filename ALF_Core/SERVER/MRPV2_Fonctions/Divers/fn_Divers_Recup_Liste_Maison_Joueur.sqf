// MRPV2_Server_fnc_Divers_Recup_Liste_Maison_Joueur = {
private _joueur = param [0,objnull];


private _liste_Pos_Maison = missionNameSpace getvariable [format ["houses_%1",getPlayerUID _joueur],[]];
[_liste_Pos_Maison] remoteExec ['ALF_fnc_initHouses',_joueur];
// };