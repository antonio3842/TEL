// MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Cadre_Date = {
private _liste_Date = param [0,[]];


private _date = "";
private _annee = ([_liste_Date # 0] apply {if (_x < 10) then {"0" + str _x} else {str(_x)}}) # 0;
private _mois = ([(_liste_Date # 1)] apply {if (_x < 10) then {"0" + str _x} else {str(_x)}}) # 0;
private _jour = ([_liste_Date # 2] apply {if (_x < 10) then {"0" + str _x} else {str(_x)}}) # 0;
private _heure = ([_liste_Date # 3] apply {if (_x < 10) then {"0" + str _x} else {str(_x)}}) # 0;
private _minute = ([_liste_Date # 4] apply {if (_x < 10) then {"0" + str _x} else {str(_x)}}) # 0;

if (([_liste_Date # 0,_liste_Date # 1,_liste_Date # 2]) isEqualTo ([systemTimeUTC # 0,systemTimeUTC # 1,systemTimeUTC # 2])) then
{
	_date = 'Aujourd''hui';
} else
{
	private _mois_En_Mot = [_mois] call MRPV2_fnc_MRP_Tel_Divers_Conversion_Nombre_Mois_En_Mot;
	private _jour_En_Mot = [_annee,_mois,_jour] call MRPV2_fnc_MRP_Tel_Divers_Conversion_Nombre_Jour_En_Mot;

	if (_annee isEquaLTo str(systemTimeUTC # 0)) then
	{
		_date = _jour_En_Mot + " " + _jour + " " + _mois_En_Mot;
	} else
	{
		_date = _jour_En_Mot + " " + _jour + " " + _mois_En_Mot + " " + _annee;
	};
};

private _taille_Cadre_Messages_Simple = 0.07;
private _espacement_Verticale_Entre_Messages = 0.01;

_heure = parsenumber _heure;
if (_heure >= 24) then
{
	_heure = ([_heure - 24] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
} else
{
	_heure = ([_heure] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
};

private _horaire = _heure + ":" + _minute;
private _heure_Suivante_Differente = _horaire isNotEqualTo Heure_Enregistrer;

if (_heure_Suivante_Differente) then
{
	MRP_Position_Hauteur_Cadre = MRP_Position_Hauteur_Cadre + _espacement_Verticale_Entre_Messages;

	private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
	private _menu_SMS_Lecture_Conteneur_SMS = uiNamespace getVariable ["MRP_menu_SMS_Lecture_Conteneur_SMS",displayNull];

	private _texte_Date = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _menu_SMS_Lecture_Conteneur_SMS];
	_texte_Date ctrlSetPosition [0,MRP_Position_Hauteur_Cadre,0.49,_taille_Cadre_Messages_Simple];
	_texte_Date ctrlCommit 0;

	private _date_Suivante_Egale = _date isEqualTo Date_Enregistrer;

	if (_date_Suivante_Egale) then
	{
		_texte_Date ctrlSetStructuredText parsetext format ["<t color='#8b8b8f' shadow='0' size='0.7' align='center' valign='middle'>%1%2</t>",_horaire,""];
	} else
	{
		private _date = _date + " à " + _horaire;
		_texte_Date ctrlSetStructuredText parsetext format ["<t color='#8b8b8f' shadow='0' size='0.7' align='center'>%1</t>",_date];
	};

	MRP_Position_Hauteur_Cadre = MRP_Position_Hauteur_Cadre + (_espacement_Verticale_Entre_Messages * 4);
};

Heure_Enregistrer = _horaire;
Date_Enregistrer = _date;

TRUE
// };