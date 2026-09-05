// MRPV2_fnc_MRP_Tel_Menu_FPR_Action_Ajouter = {
private _champ_Nom = uiNamespace getVariable ["MRP_Tel_FPR_Ajout_Champ_Nom",controlNull];
private _champ_Motif = uiNamespace getVariable ["MRP_Tel_FPR_Ajout_Champ_Motif",controlNull];

private _nom = trim ctrlText _champ_Nom;
private _motif = trim ctrlText _champ_Motif;

if (_nom in ["","Nom de la personne"]) exitwith {hint "Le nom est vide."};
if (_motif in ["","Motif de la recherche"]) exitwith {hint "Le motif est vide."};

if (count (toArray _nom) > 30) exitwith {hint "Le nom fait 30 caractères max."};
if (count (toArray _motif) > 300) exitwith {hint "Le motif fait 300 caractères max."};

private _autorises_Nom = toArray "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ";
private _autorises_Motif = toArray "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.,'-/[]éà€!?;:êè)(=+&<>*$ ";

if (((toArray _nom) select {!(_x in _autorises_Nom)}) isnotequalto []) exitwith {hint "Nom incorrect."};
if (((toArray _motif) select {!(_x in _autorises_Motif)}) isnotequalto []) exitwith {hint "Motif incorrect."};

[_nom,_motif,player] remoteExecCall ["ALF_Server_fnc_addFipSony",2];

[] spawn
{
	sleep 0.2;
	[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
	[] call MRPV2_fnc_MRP_Tel_Menu_FPR_Crea;
};

TRUE
// };
