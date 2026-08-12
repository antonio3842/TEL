/* Copyright 2023 - Association Get Your Path. All rights reserved */
disableSerialization;

private _list = _this select 0;
private _index = _this select 1;

private _data = _list lbData _index;
if ((_data isEqualTo "") || (_data isEqualTo "NULL")) exitWith {};
_data = call compile format ["%1",_data];

private _display = findDisplay 4510;

private _insertTime = (_data select 10);
private _expirationTime = (_data select 9);
private _date = ((_insertTime select [9,2]) + "/" + (_insertTime select [6,2]) + "/" + (_insertTime select [1,4]));

_expiration = "";
_dateYear = (_expirationTime select [1,4]);

if ((parseNumber _dateYear) >= 2035) then {
    _expiration = "Jamais";
} else {
    _expiration = ((_expirationTime select [9,2]) + "/" + (_expirationTime select [6,2]) + "/" + _dateYear);
};

{
    (_display displayCtrl _x) ctrlShow true;
} forEach [1000,1001,4520,4521,4523,4525];

_documentCopy = "";
if ((_data select 8) != 0) then {
    _documentCopy = format [" (copie du document #%1)",(_data select 8)];
};

(_display displayCtrl 4521) ctrlSetStructuredText parseText format ["<t color='#FFBD0E'>Document n° :</t> #%1%2",(_data select 0),_documentCopy];
(_display displayCtrl 4523) ctrlSetStructuredText parseText format ["<t color='#FFBD0E'>Expéditeur :</t> %1",(_data select 3)];
(_display displayCtrl 4525) ctrlSetStructuredText parseText format ["<t color='#FFBD0E'>Destinataire :</t> %1",(_data select 4)];
(_display displayCtrl 1000) ctrlSetStructuredText parseText format ["<t color='#FFBD0E'>Date d'émission :</t> %1",_date];
(_display displayCtrl 1001) ctrlSetStructuredText parseText format ["<t color='#FFBD0E'>Date d'expiration :</t> %2",_expiration];

private _textstr = (_data select 6);
private _count = count _textstr;

if (_count > 256) then {
    (_display displayCtrl 4520) ctrlSetStructuredText parseText format ["%1...",(_textstr select [0,256])];
} else {
    (_display displayCtrl 4520) ctrlSetStructuredText parseText _textstr;
};
