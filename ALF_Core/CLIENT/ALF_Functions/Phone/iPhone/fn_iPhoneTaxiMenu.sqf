/*
	File: fn_iPhoneTaxiMenu.sqf
	Menu Taxi iPhone (style Contacts + bouton bas blanc/noir).
*/
disableSerialization;

private _display = findDisplay 56400;
if (isNull _display) exitWith {};

if (!isNil "ALF_fnc_iPhoneTaxiEnsureControls") then {
	[_display, true] call ALF_fnc_iPhoneTaxiEnsureControls;
};

private _statut = _display displayCtrl 682571;
private _callLabel = _display displayCtrl 682572;
private _callShadow = _display displayCtrl 682574;
if (isNull _statut) exitWith {};

if (!isNull _callShadow) then { _callShadow ctrlShow false; };

private _lists = [] call ALF_fnc_iPhoneTaxiFetchLists;
private _enLigneData = _lists # 0;
private _appelablesData = (_lists # 1) select { (_x # 1) != "" };

private _nombreLigne = count _enLigneData;
private _nombreAppel = count _appelablesData;
private _moiEnService = player getVariable ["MRP_Taxi_EnService", false];
private _peutAppeler = !_moiEnService && { _nombreAppel > 0 };

if (_moiEnService && { _nombreLigne isEqualTo 0 }) then {
	_nombreLigne = 1;
};

private _texteProche = "";
if (!_moiEnService && { _nombreAppel > 0 }) then {
	private _nearest = [_appelablesData, player] call ALF_fnc_taxiPickNearest;
	private _pick = _nearest # 0;
	private _dist = _nearest # 1;
	if (_pick isEqualType [] && { count _pick >= 1 }) then {
		private _u = _pick # 0;
		private _nom = _pick param [2, ""];
		if (_nom isEqualTo "") then { _nom = name _u; };
		private _distTxt = [_dist] call ALF_fnc_taxiFormatDistance;
		_texteProche = format [
			"<br/><br/>" +
			"<t align='center' shadow='0' size='0.9' color='#999999' font='HelveticaLTLight'>CHAUFFEUR LE PLUS PROCHE</t><br/>" +
			"<t align='center' shadow='0' size='1.35' color='#FFFFFF' font='HelveticaLTLight'>%1</t><br/><br/>" +
			"<t align='center' shadow='0' size='1.05' color='#B8E6C8' font='HelveticaLTLight'>À %2 de vous</t>",
			_nom,
			_distTxt
		];
	};
};

private _texte = if (_nombreLigne > 0) then {
	if (_moiEnService && { _nombreAppel isEqualTo 0 }) then {
		format [
			"<t align='center' shadow='0' size='1.5' color='#FFFFFF' font='HelveticaLTLight'>Taxi en ligne : %1</t><br/><t align='center' shadow='0' size='1.1' color='#CCCCCC' font='HelveticaLTLight'>Vous êtes en service</t><br/><t align='center' shadow='0' size='1' color='#AAAAAA' font='HelveticaLTLight'>Appel impossible — vous êtes taxi</t>",
			_nombreLigne
		]
	} else {
		format [
			"<t align='center' shadow='0' size='1.5' color='#FFFFFF' font='HelveticaLTLight'>Taxi en ligne : %1</t>%2",
			_nombreLigne,
			_texteProche
		]
	};
} else {
	"<t align='center' shadow='0' size='1.4' color='#FF6666' font='HelveticaLTLight'>Aucun taxi en ligne</t>"
};

_statut ctrlSetStructuredText parseText _texte;
_statut ctrlShow true;

if (!isNull _callLabel) then {
	_callLabel ctrlShow true;
	_callLabel ctrlSetText "APPELER UN TAXI";
	if (_peutAppeler) then {
		_callLabel ctrlSetTextColor [0, 0, 0, 1];
		_callLabel ctrlSetBackgroundColor [1, 1, 1, 1];
	} else {
		_callLabel ctrlSetTextColor [0.45, 0.45, 0.45, 1];
		_callLabel ctrlSetBackgroundColor [0.92, 0.92, 0.92, 1];
	};
};

private _callHit = _display displayCtrl 682575;
if (!isNull _callHit) then {
	_callHit ctrlEnable _peutAppeler;
	_callHit ctrlShow true;
};

TRUE
