// MRPV2_fnc_MRP_Tel_Menu_TAJ_Action_Supprimer = {
if (isnil {MRP_Tel_TAJ_Selection_Courante}) exitwith {hint "Il faut sélectionner une fiche."};

private _selection = MRP_Tel_TAJ_Selection_Courante;
private _lieu = _selection select 0;
private _infra = _selection select 1;
private _date = _selection select 2;

[_lieu,_infra,_date,player] remoteExec ["ALF_Server_fnc_deleteTajSony",2];

MRP_Tel_TAJ_Selection_Courante = nil;

// Le serveur existant ne renvoie pas de liste rafraîchie après suppression :
// on relance simplement la même recherche pour resynchroniser l'affichage.
[] spawn
{
	sleep 0.5;
	[] call MRPV2_fnc_MRP_Tel_Menu_TAJ_Action_Rechercher;
};

TRUE
// };
