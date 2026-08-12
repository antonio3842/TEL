/*
	File: fn_distrib_restockCalcLayout.sqf
	Calcule positions boutons réappro alignés sur le fond Menu_Inter_V2.
	Retourne [_posBtnX, _posBtnY, _longueurBtn, _hauteurBtn, _ecartBtnY, _ecartColX, _colCount]
*/
private _posFond = [0.78, 0.4, 0.9, 1.2];
private _hauteurBtn = 0.045;
private _ecartBtnY = 0.06;
private _rowsPerCol = 9;

private _items = [] call ALF_fnc_distrib_getShopItems;
private _itemCount = count _items;

private _colCount = if (_itemCount > 18) then {
	3
} else {
	if (_itemCount > 9) then { 2 } else { 1 }
};

private _longueurBtn = if (_colCount >= 3) then { 0.26 } else { 0.41 };
private _ecartColX = if (_colCount >= 3) then { 0.32 } else { 0.45 };

private _maxRows = if (_colCount == 1) then { _itemCount max 1 } else { _rowsPerCol };
private _blockH = (_maxRows * _hauteurBtn) + (((_maxRows - 1) max 0) * _ecartBtnY);
private _titleMargin = 0.22;
private _posBtnY = (_posFond select 1) + _titleMargin + (((_posFond select 3) - _titleMargin - _blockH) / 2);
_posBtnY = _posBtnY + 0.04;

private _totalW = (_longueurBtn * _colCount) + (_ecartColX * (_colCount - 1));
private _posBtnX = if (_colCount == 1) then {
	if (_itemCount < 10) then { 1 } else { 0.8 }
} else {
	(_posFond select 0) + (((_posFond select 2) - _totalW) / 2)
};

if (_colCount == 1 && {_itemCount > 0}) then {
	_posBtnX = (_posFond select 0) + (((_posFond select 2) - _longueurBtn) / 2);
};

[_posBtnX, _posBtnY, _longueurBtn, _hauteurBtn, _ecartBtnY, _ecartColX, _colCount]
