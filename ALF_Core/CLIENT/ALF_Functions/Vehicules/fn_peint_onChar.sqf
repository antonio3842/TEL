// ALF_fnc_peint_onChar = {
private _control = _this select 0;
private _code = _this select 1;
private _slider = _this select 2;

disableSerialization;

if (isNull _control || {isNull ALF_Peinture_NearestVehicle}) exitWith {};

private _text = toArray(ctrlText _control);
private _badChar = false;

{
	if (!(_x in toArray("0123456789."))) exitWith { _badChar = true; };
} forEach _text;

if (_badChar) exitWith {
	["Peinture", "Seuls les nombres sont autorisés (valeurs entre 0 et 255).", "danger", false] spawn ALF_fnc_doMsg;
};

private _value = parseNumber(ctrlText _control);
_value = (_value max 0) min 255;

private _sliderValue = _value / 255;

private _sliderIDC = switch (_slider) do {
	case "red": { 89771 };
	case "green": { 89772 };
	case "blue": { 89773 };
	default { -1 };
};

if (_sliderIDC isEqualTo -1) exitWith {};

private _display = ctrlParent _control;
private _sliderCtrl = _display displayCtrl _sliderIDC;
_sliderCtrl sliderSetPosition _sliderValue;

// ➕ Ajout de la logique d'index selon classname
private _classname = toLower (typeOf ALF_Peinture_NearestVehicle);
private _textureIndex = if ("_mrp_" in tolower (typeof ALF_Peinture_NearestVehicle)) then {11} else {0};

// Création de la texture ARGB
private _texture = format [
	"#(argb,8,8,3)color(%1,%2,%3,1.0,co)",
	sliderPosition 89771,
	sliderPosition 89772,
	sliderPosition 89773
];

ALF_Peinture_NearestVehicle setObjectTextureGlobal [_textureIndex, _texture];
ALF_Peinture_CurrentTexture = _texture;
// };