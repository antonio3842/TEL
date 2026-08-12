private _displayOrControl = param [0,""];
private _key = param [1,""];


// Pour laisser le backspace tranquille
private _liste_Touches_Ignorer = [14,203,205,211,199,207];
if (_key in _liste_Touches_Ignorer) exitWith {};
private _pos_Curseur = (ctrlTextSelection _displayOrControl) # 0;

private _texte = toArray (ctrlText _displayOrControl);
private _nombre_Characteres_Texte = count _texte;

private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];

if (_nombre_Characteres_Texte > 2 AND {!("Fond_Radio_dxt5" in (ctrltext _Telephone_Fond))}) exitwith
{
	if (_nombre_Characteres_Texte > 2 AND {_texte # 2 isnotequalto 32}) then
	{
		_texte insert [2,[32]];
	};
	if (_nombre_Characteres_Texte > 4 AND {_texte # 5 isnotequalto 32}) then
	{
		_texte insert [5,[32]];
		_nombre_Characteres_Texte = _nombre_Characteres_Texte + 1;
		_pos_Curseur = _pos_Curseur + 1;
	};
	if (_nombre_Characteres_Texte > 7 AND {_texte # 8 isnotequalto 32}) then
	{
		_texte insert [8,[32]];
		_nombre_Characteres_Texte = _nombre_Characteres_Texte + 1;
		_pos_Curseur = _pos_Curseur + 1;
	};
	if (_nombre_Characteres_Texte > 10 AND {_texte #11 isnotequalto 32}) then
	{
		_texte insert [11,[32]];
		_nombre_Characteres_Texte = _nombre_Characteres_Texte + 1;
		_pos_Curseur = _pos_Curseur + 1;
	};


	_displayOrControl ctrlSetText tostring _texte;

	if (_pos_Curseur isequalto _nombre_Characteres_Texte) then
	{
		_displayOrControl ctrlSetTextSelection [_pos_Curseur + 1,0];
	};
};

_displayOrControl ctrlSetText tostring _texte;
_displayOrControl ctrlSetTextSelection [_nombre_Characteres_Texte,0];

TRUE