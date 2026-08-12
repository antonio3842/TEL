private _numero_Non_Valide = FALSE;

private _nombre_Trimmer = MRP_Telephone_Gestion_Numero_Interne trim ["#31#",0];
private _nombre_Trimmer_Sans_Espace = _nombre_Trimmer regexReplace [" ",""];
private _nombre_Chiffre = count (_nombre_Trimmer_Sans_Espace splitstring "");

private _pas_Le_Bon_Nombre_De_Numero = _nombre_Chiffre isNotEqualTo 10;
private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
private _pas_un_Numero_Speciale = !(MRP_Telephone_Gestion_Numero_Interne in str _liste_Entreprise);

if (_pas_Le_Bon_Nombre_De_Numero AND {_pas_un_Numero_Speciale}) then
{
	_numero_Non_Valide = TRUE;
};

_numero_Non_Valide