// MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler = {
private _numero = param [0,""];


private _intituler_Identifiant = _numero;

if (_numero isequalto "Numéro masqué") exitwith {_intituler_Identifiant};

_intituler_Identifiant = _numero regexreplace [" ",""];

private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
private _info_Service = (_liste_Entreprise select {(_x getOrDefault ["PHONE",""]) isequalto _intituler_Identifiant});
private _numero_Est_Service = _info_Service isnotequalto [];

if (_numero_Est_Service) then
{
	_intituler_Identifiant = (_info_Service # 0) getOrDefault ["NAME",""];	
} else
{
	private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
	private _info_Contact = _liste_Contact getOrDefault [_intituler_Identifiant,[]];

	if (_info_Contact isEqualTo []) then
	{
		if (count _numero >= 3) then
		{
			_intituler_Identifiant = _intituler_Identifiant insert [2, " "];
		};

		if (count _numero >= 5) then
		{
			_intituler_Identifiant = _intituler_Identifiant insert [5, " "];
		};

		if (count _numero >= 7) then
		{
			_intituler_Identifiant = _intituler_Identifiant insert [8, " "];
		};

		if (count _numero >= 9) then
		{
			_intituler_Identifiant = _intituler_Identifiant insert [11, " "];
		};
	} else
	{
		private _prenom = _info_Contact # 0;
		private _nom = _info_Contact # 1;

		if (_prenom isEqualTo "" AND {_nom isEqualTo ""}) exitwith
		{
			if (count _numero >= 3) then
			{
				_intituler_Identifiant = _intituler_Identifiant insert [2, " "];
			};

			if (count _numero >= 5) then
			{
				_intituler_Identifiant = _intituler_Identifiant insert [5, " "];
			};

			if (count _numero >= 7) then
			{
				_intituler_Identifiant = _intituler_Identifiant insert [8, " "];
			};

			if (count _numero >= 9) then
			{
				_intituler_Identifiant = _intituler_Identifiant insert [11, " "];
			};
		};
		if (_prenom isNotEqualTo "" AND {_nom isNotEqualTo ""}) exitwith 
		{
			_intituler_Identifiant = _prenom + " " +_nom;
			MRP_Telephone_Gestion_Numero_Interne = _numero;
		};
		if (_prenom isEqualTo "") exitwith {_intituler_Identifiant = _nom};
		if (_nom isEqualTo "") then {_intituler_Identifiant = _prenom;};
	};
};

_intituler_Identifiant
// };