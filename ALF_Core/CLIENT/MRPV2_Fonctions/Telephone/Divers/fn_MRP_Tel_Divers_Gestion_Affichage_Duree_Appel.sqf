if (isnil {MRP_Telephone_Duree_Appel}) then {MRP_Telephone_Duree_Appel = 0;};

private _texte_Structurer = uiNamespace getVariable ["MRP_Telephone_Appel_En_Cours_Duree",controlNull];

if (MRP_Telephone_Duree_Appel < 60) exitwith
{
	private _duree_Mis_En_Forme = ([MRP_Telephone_Duree_Appel] apply {if (_x < 10) then {"0" + str _x} else {str _x}}) # 0;
	_texte_Structurer ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#ffffff' size='2' align='left'>     00:%1</t>",_duree_Mis_En_Forme];
};

if (MRP_Telephone_Duree_Appel >= 60 AND {MRP_Telephone_Duree_Appel < 3600}) exitwith
{
	private _minutes = ([floor (MRP_Telephone_Duree_Appel / 60)] apply {if (_x < 10) then {"0" + str _x} else {str _x}}) # 0;
	private _secondes = ([MRP_Telephone_Duree_Appel - (parsenumber(_minutes) * 60)] apply {if (_x < 10) then {"0" + str _x} else {str _x}}) # 0;

	_texte_Structurer ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#ffffff' size='2' align='left'>     %1:%2</t>",_minutes,_secondes];
};

if (MRP_Telephone_Duree_Appel >= 3600) then
{
	private _duree = MRP_Telephone_Duree_Appel;

	private _heure = ([floor (_duree / 3600)] apply {if (_x < 10) then {"0" + str _x} else {str _x}}) # 0;
	private _heure = ([floor (MRP_Telephone_Duree_Appel / 3600)] apply {if (_x < 10) then {"0" + str _x} else {str _x}}) # 0;
	_duree = _duree - (3600 * (parsenumber _heure));

	private _minutes = ([floor (_duree / 60)] apply {if (_x < 10) then {"0" + str _x} else {str _x}}) # 0;
	private _secondes = ([_duree - (parsenumber(_minutes) * 60)] apply {if (_x < 10) then {"0" + str _x} else {str _x}}) # 0;

	_texte_Structurer ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#ffffff' size='2' align='left'>  %1:%2:%3</t>",_heure,_minutes,_secondes];
};

TRUE