// MRPV2_fnc_MRP_Tel_Menu_Taxi_Action_Appeler = {

if (player getVariable ["MRP_Appel_Etat", ""] in [
	"Appel en cours",
	"Tentative appel expéditeur",
	"Tentative appel destinataire",
	"Appel CA en cours"
]) exitWith {
	["Téléphone", "Vous êtes déjà en communication.", "warning"] spawn ALF_fnc_doMsg;
};

private _config_Tel = profileNamespace getVariable ["MRP_Telephone_Configuration", []];
if (_config_Tel param [0, false]) exitWith {
	["Téléphone", "Désactivez le mode avion pour appeler un taxi.", "warning"] spawn ALF_fnc_doMsg;
};

private _lists = [] call ALF_fnc_iPhoneTaxiFetchLists;
private _appelables = (_lists # 1) select {
	private _u = _x # 0;
	(_x # 1) != "" &&
	{
		(assignedItems _u select { "MRP_Item_Iphone_12" in _x || { "MRP_Item_Neogend" in _x } }) isNotEqualTo []
	}
};

if (_appelables isEqualTo []) exitWith {
	["TAXI", "Aucun chauffeur taxi disponible pour le moment.", "warning"] spawn ALF_fnc_doMsg;
	[] call MRPV2_fnc_MRP_Tel_Menu_Taxi_Gestion_Statut;
};

private _nearest = [_appelables, player] call ALF_fnc_taxiPickNearest;
private _pick = _nearest # 0;
if (!(_pick isEqualType []) || { count _pick < 2 }) exitWith {
	["TAXI", "Chauffeur introuvable.", "warning"] spawn ALF_fnc_doMsg;
};

private _chauffeur = _pick # 0;
private _numero = (_pick # 1) regexReplace [" ", ""];

MRP_Telephone_Gestion_Numero_Interne = _numero;
MRP_Telephone_Numero_Appel = _numero;

[player] remoteExec ["ALF_fnc_taxi_notifyIncomingCall", _chauffeur];

[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Exped_Crea;
[player] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Etat_Joueur_En_Appel;
[] spawn MRPV2_fnc_MRP_Tel_Menu_Appel_Tentative_Expediteur;

TRUE
// };
