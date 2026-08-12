params [
    ["_QTE",[],[[]]]
];

if (_QTE isEqualTo []) exitWith {};

private _barW = 0.5;
private _barH = 0.04;
private _barX = safeZoneX + (safeZoneW - _barW) / 2;
private _barY = safeZoneY + (safeZoneH - _barH) / 2;


private _imgSize = 0.15; // Taille de l'icône (ajustable)
private _spacing = 0.01; // Espace entre les icônes
private _totalWidth = (count _QTE * _imgSize) + ((count _QTE - 1) * _spacing);
private _startX = _barX + (_barW - _totalWidth) / 2;
// On place les images juste en dessous de la barre (Y de la barre + sa hauteur + petit gap)
private _startY = _barY + _barH + 0.01;
private _startY = _barY + _barH + 0.01;


_display = findDisplay 46;
private _idc = 20000;

_ctrlSave = [];
{
    _img = _display ctrlCreate ["RscPictureKeepAspect",_idc];
    _ctrlSave pushBack _img;
    _idc = _idc + 1;

    private _currentX = _startX + (_forEachIndex * (_imgSize + _spacing));

    _img ctrlSetText (_x select 1);

    _img ctrlSetPosition [_currentX, _startY, _imgSize, _imgSize];
    _img ctrlCommit 0;
} forEach _QTE;

uiNamespace setVariable ["ALF_QTE_Images",_ctrlSave];