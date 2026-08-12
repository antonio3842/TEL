// MRPV2_fnc_MRP_Tel_Menu_SMS_Gestion_Nombre_SMS = {
private _action = param [0,""];
private _numero = param [1,""];


private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
private _liste_Nombre_Dernier_SMS = _telephone_Configuration # 7;
private _telephone_Liste_SMS = profileNamespace getvariable ["MRP_Telephone_Liste_SMS",createhashmap];

// code pour le menu principal
if (_action isequalto "Menu principal") exitwith
{
	private _nombre_SMS_Historique = 0;

	{
		_nombre_SMS_Historique = _nombre_SMS_Historique + _y;
	} foreach _liste_Nombre_Dernier_SMS;

	private _nombre_SMS_Liste = 0;

	{
		_nombre_SMS_Liste = _nombre_SMS_Liste + (count _y);
	} foreach _telephone_Liste_SMS;

	private _compteur_Nouveau_SMS = _nombre_SMS_Liste - _nombre_SMS_Historique max 0;
	_compteur_Nouveau_SMS
};

// code pour le menu SMS
if (_action isequalto "Menu SMS") exitwith
{
	private _nombre_SMS_Historique = (_liste_Nombre_Dernier_SMS getorDefault [_numero,0]);
	private _nombre_SMS_Liste = count (_telephone_Liste_SMS getorDefault [_numero,[]]);

	private _compteur_Nouveau_SMS = _nombre_SMS_Liste - _nombre_SMS_Historique max 0;
	_compteur_Nouveau_SMS
};

// Code dans le SMS pour mettre a jour l'historique
if (_action isequalto "SMS") exitwith
{
	private _nombre_SMS_Historique =  (_liste_Nombre_Dernier_SMS getorDefault [_numero,0]);
	private _nombre_SMS_Liste = count (_telephone_Liste_SMS getorDefault [_numero,[]]);

	if (_nombre_SMS_Historique isnotequalto _nombre_SMS_Liste) then
	{
		_liste_Nombre_Dernier_SMS set [_numero,_nombre_SMS_Liste];
	};

	profileNamespace setvariable ["MRP_Telephone_Configuration",_telephone_Configuration];
};

TRUE
// };