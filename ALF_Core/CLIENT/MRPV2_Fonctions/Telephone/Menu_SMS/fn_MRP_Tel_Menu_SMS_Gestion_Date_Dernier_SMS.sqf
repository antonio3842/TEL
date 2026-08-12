private _telephone_Liste_SMS = profileNamespace getvariable ["MRP_Telephone_Liste_SMS",createhashmap];
private _liste_Dernier_SMS = [];
private _liste_Dernier_SMS_Trier = [];
private _liste_Derniere_Date_Trier = [];

{
	private _info_Contact = _y;
	private _info_Dernier_SMS = _info_Contact # ((count _info_Contact) - 1);
	private _dernier_SMS = _info_Dernier_SMS # 1;
	private _date = _info_Dernier_SMS # 2;

	_liste_Derniere_Date_Trier pushback _date;
	_liste_Dernier_SMS pushback [_date,_dernier_SMS,_x];
} foreach _telephone_Liste_SMS;

_liste_Derniere_Date_Trier sort FALSE;

{
	private _date = _x;

	{
		private _SMS = _x;

		if (_date isEqualTo (_SMS # 0)) exitwith
		{
			_liste_Dernier_SMS_Trier pushback _SMS;
		};
	} foreach _liste_Dernier_SMS;
} foreach _liste_Derniere_Date_Trier;

private _date_Dernier_SMS = _liste_Dernier_SMS_Trier # 0 # 0;

_date_Dernier_SMS