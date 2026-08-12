// MRPV2_fnc_MRP_Tel_Menu_Appel_Init_Variables = {
private _numero_Expediteur = param [0,""];
private _numero_Expediteur_Mode_Entreprise = param [1,""];
private _mode_Entreprise = param [2,""];


player setvariable ["MRP_Appel_Etat","Tentative appel destinataire"];

MRP_Telephone_Appel_Id_Expediteur = remoteexecutedowner;
MRP_Telephone_Appel_Id_Destinataire = clientowner;

if (_mode_Entreprise) then
{
	MRP_Telephone_Numero_Appel = _numero_Expediteur_Mode_Entreprise;
	MRP_Telephone_Gestion_Numero_Interne = _numero_Expediteur;
	MRP_Telephone_Appel_Numero_Expediteur = _numero_Expediteur;
} else
{
	MRP_Telephone_Numero_Appel = _numero_Expediteur;
	MRP_Telephone_Gestion_Numero_Interne = _numero_Expediteur;
	MRP_Telephone_Appel_Numero_Expediteur = _numero_Expediteur;
};

MRP_Telephone_Appel_Numero_Destinataire = player getvariable ["phoneNumber",""];

MRP_Telephone_Appel_Id_Destinataire publicvariableclient "MRP_Telephone_Appel_Numero_Expediteur";
MRP_Telephone_Appel_Id_Expediteur publicvariableclient "MRP_Telephone_Appel_Numero_Destinataire";
MRP_Telephone_Appel_Id_Expediteur publicvariableclient "MRP_Telephone_Appel_Id_Destinataire";

[player] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Etat_Joueur_En_Appel;

[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Desti_Crea;

TRUE
// };