private _displayOrControl = param [0,controlNull];


ctrlTextSelection _displayOrControl params ["_start", "_length"];
private _cursorPos = _start + _length;
private _texte = ctrlText _displayOrControl splitstring "";

if (count _texte isEqualTo 0) then
{
	_texte pushback (toString[10]);
} else
{
	_texte insert [_cursorPos,[toString[10]]];
};

_displayOrControl ctrlSetText (_texte joinstring "");
_displayOrControl ctrlSetTextSelection [_start + 1,0];