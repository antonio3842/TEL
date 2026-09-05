// MRPV2_fnc_MRP_Tel_Menu_TAJ_Action_Ajouter = {
private _champ_Nom = uiNamespace getVariable ["MRP_Tel_TAJ_Ajout_Champ_Nom",controlNull];
private _champ_Lieu = uiNamespace getVariable ["MRP_Tel_TAJ_Ajout_Champ_Lieu",controlNull];
private _champ_Date = uiNamespace getVariable ["MRP_Tel_TAJ_Ajout_Champ_Date",controlNull];
private _champ_Infra = uiNamespace getVariable ["MRP_Tel_TAJ_Ajout_Champ_Infra",controlNull];

private _nom = trim ctrlText _champ_Nom;
private _lieu = trim ctrlText _champ_Lieu;
private _date = trim ctrlText _champ_Date;
private _infra = trim ctrlText _champ_Infra;

if (_nom in ["","Nom de la personne"]) exitwith {hint "Le nom est vide."};
if (_lieu in ["","Lieu"]) exitwith {hint "Le lieu est vide."};
if (_date in ["","Date (ex: 12/08/2026)"]) exitwith {hint "La date est vide."};
if (_infra in ["","Détail de l'infraction"]) exitwith {hint "L'infraction est vide."};

if (count (toArray _nom) > 30) exitwith {hint "Le nom fait 30 caractères max."};
if (count (toArray _lieu) > 40) exitwith {hint "Le lieu fait 40 caractères max."};
if (count (toArray _date) > 20) exitwith {hint "La date fait 20 caractères max."};
if (count (toArray _infra) > 300) exitwith {hint "L'infraction fait 300 caractères max."};

private _autorises_Nom = toArray "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ";
private _autorises_Date = toArray "0123456789/H ";
private _autorises_Texte = toArray "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.,'-/[]éà€!?;:êè)(=+&<>*$ ";

if (((toArray _nom) select {!(_x in _autorises_Nom)}) isnotequalto []) exitwith {hint "Nom incorrect."};
if (((toArray _lieu) select {!(_x in _autorises_Nom)}) isnotequalto []) exitwith {hint "Lieu incorrect."};
if (((toArray _date) select {!(_x in _autorises_Date)}) isnotequalto []) exitwith {hint "Date incorrecte."};
if (((toArray _infra) select {!(_x in _autorises_Texte)}) isnotequalto []) exitwith {hint "Infraction incorrecte."};

private _mode = 0;
if (MRP_Tel_TAJ_Ajout_Mode isequalto "crime") then {_mode = 1;};

[_nom,_mode,_lieu,_date,_infra,player] remoteExecCall ["ALF_Server_fnc_createTajSony",2];

[] spawn
{
	sleep 0.2;
	[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
	[] call MRPV2_fnc_MRP_Tel_Menu_TAJ_Crea;
};

TRUE
// };
