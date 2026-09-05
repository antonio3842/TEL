// MRPV2_fnc_MRP_Tel_Menu_FPR_Action_Supprimer = {
if (isnil {MRP_Tel_FPR_Selection_Courante}) exitwith {hint "Il faut sélectionner une fiche."};

private _est_OPJ = (missionNamespace getvariable ["life_copLevel",0]) >= 4;
if (!_est_OPJ) exitwith {hint "Tu n'es pas OPJ."};

private _selection = MRP_Tel_FPR_Selection_Courante;
private _nom = _selection select 0;
private _motif = _selection select 1;

[_motif,player] remoteExec ["ALF_Server_fnc_deleteFipSony",2];

["FPR",format ["%1 a retiré %2 du fichier des personnes recherchées.",name player,_nom]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];

MRP_Tel_FPR_Selection_Courante = nil;

// Le serveur renvoie déjà automatiquement la liste rafraîchie après suppression
// (ALF_fnc_update2FipSony), pas besoin de la redemander manuellement ici.

TRUE
// };
