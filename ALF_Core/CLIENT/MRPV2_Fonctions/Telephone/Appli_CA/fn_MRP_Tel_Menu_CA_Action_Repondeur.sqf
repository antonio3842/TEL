// MRPV2_fnc_MRP_Tel_Menu_CA_Action_Repondeur = {
private _service = param [0,""];

private _voix_Repondeur = "";
private _musique_Repondeur = "";

[] call
{
	if (_service in ["GN",15]) exitwith
	{
		_voix_Repondeur = "MRP_Telephone_Repondeur_Voix_Gendarmerie";
		_musique_Repondeur = "MRP_Telephone_Repondeur_Musique_Gendarmerie";
	};

	if (_service in ["AP"]) exitwith
	{
		_voix_Repondeur = "MRP_Telephone_Repondeur_Voix_AP";
		_musique_Repondeur = "MRP_Telephone_Repondeur_Musique_AP";
	};

	if (_service in ["Centre Appel","DIR"]) exitwith
	{
		_voix_Repondeur = "MRP_Telephone_Repondeur_Voix_Entreprise";
		_musique_Repondeur = "MRP_Telephone_Repondeur_Musique_AP";
	};

	if (_service in ["SP",19]) then
	{
		_voix_Repondeur = "MRP_Telephone_Repondeur_Voix_Pompier";
		_musique_Repondeur = "MRP_Telephone_Repondeur_Musique_Pompier";
	};
};

[_voix_Repondeur] call MRPV2_fnc_MRP_Tel_Menu_Appel_Gestion_Repondeur_Service_Speciaux;
[_musique_Repondeur] call MRPV2_fnc_MRP_Tel_Menu_Appel_Gestion_Repondeur_Service_Speciaux;

TRUE
// };