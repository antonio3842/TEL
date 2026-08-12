private _displayOrControl = param [0,""];
private _nombre_Limite = param [1,0];


private _texte = ctrlText _displayOrControl;
private _nombre_Charactere_Texte = count (_texte splitstring "");

if (_nombre_Charactere_Texte >= _nombre_Limite) then
{
	_texte = _texte splitstring "";
	_texte resize _nombre_Limite;

	_displayOrControl ctrlSetText (_texte joinstring "");
};

TRUE