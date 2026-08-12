/*
	File: fn_iPhoneTaxiCall.sqf
	Appeler le chauffeur taxi le plus proche — même flux que fn_iPhoneCallCustom.
*/

private _taxiAppOuverte = (
	(uiNamespace getVariable ["iphonemenu", -1]) isEqualTo 11
	|| { !isNull (findDisplay 20520) && { (uiNamespace getVariable ["sonypm", -1]) isEqualTo 14 } }
	|| { !isNull (findDisplay 38999) && { (uiNamespace getVariable ["sonyp", -1]) isEqualTo 14 } }
	|| { !isNull (findDisplay 32999) && { (uiNamespace getVariable ["sony", -1]) isEqualTo 19 } }
);
if (!_taxiAppOuverte) exitWith {};

private _etats_Occupe = [
	"Appel en cours",
	"Tentative appel expéditeur",
	"Tentative appel destinataire",
	"Appel CA en cours"
];

if (player getVariable ["MRP_Taxi_EnService", false]) exitWith {
	["TAXI", "Vous êtes actuellement taxi, appel impossible.", "warning"] spawn ALF_fnc_doMsg;
};

if (player getVariable ["MRP_Appel_Etat", ""] in _etats_Occupe) exitWith {
	["Téléphone", "Vous êtes déjà en communication.", "warning"] spawn ALF_fnc_doMsg;
};

if (ALF_Phone_Number isEqualTo "") exitWith {
	["TAXI", "Votre numéro de téléphone n'est pas disponible.", "warning"] spawn ALF_fnc_doMsg;
};

if !(currentWeapon player isEqualTo "") exitWith {
	["Téléphone", "Vous avez les mains encombrées.", "danger", false] spawn ALF_fnc_doMsg;
};

if ((ALF_Forfait isEqualTo 0) && {!((ALF_Phone_Number in ["17", "18", "21"]))}) exitWith {
	hint "Votre forfait est épuisé.";
};

["TAXI", "Nous recherchons le chauffeur taxi le plus proche de votre position...", "info"] spawn ALF_fnc_doMsg;

private _appelables = (([] call ALF_fnc_iPhoneTaxiFetchLists) # 1) select { (_x param [1, ""]) != "" };

if (_appelables isEqualTo []) exitWith {
	["TAXI", "Aucun chauffeur taxi disponible pour le moment.", "warning"] spawn ALF_fnc_doMsg;
	if (!isNull (findDisplay 20520) || {!isNull (findDisplay 38999)} || {!isNull (findDisplay 32999)}) then {
		[] call ALF_fnc_SonyTaxiRefreshMenu;
	} else {
		[] call ALF_fnc_iPhoneTaxiMenu;
	};
};

private _nearest = [_appelables, player] call ALF_fnc_taxiPickNearest;
private _pick = _nearest # 0;
private _distance = _nearest # 1;

_pick params [["_chauffeur", objNull], ["_numero", ""], ["_nomChauffeur", ""]];

if (isNull _chauffeur || { _numero isEqualTo "" }) exitWith {
	["TAXI", "Numéro du chauffeur introuvable.", "warning"] spawn ALF_fnc_doMsg;
};

if (_nomChauffeur isEqualTo "") then {
	_nomChauffeur = name _chauffeur;
};

if (_numero isEqualTo ALF_Phone_Number) exitWith {
	["TAXI", "Impossible de vous appeler vous-même.", "warning"] spawn ALF_fnc_doMsg;
};

private _distTxt = [_distance] call ALF_fnc_taxiFormatDistance;

[
	"TAXI",
	format [
		"Appel du taxi le plus proche<br/>%1 — %2 · N° %3",
		_nomChauffeur,
		_distTxt,
		_numero
	],
	"info"
] spawn ALF_fnc_doMsg;

[player] remoteExec ["ALF_fnc_taxi_notifyIncomingCall", _chauffeur];

player playActionNow "ALF_Tel";

if !(isNull ALF_PhoneObject) then {
	[] spawn {
		uiSleep 0.3;
		if (vehicle player isEqualTo player) then {
			ALF_PhoneObject attachTo [player, [0.02, 0.01, 0.15], "RightHandMiddle1"];
			ALF_PhoneObject setVectorDirAndUp [[-0.21017, 0.265195, -0.94101], [-0.949623, 0.173499, 0.260989]];
		} else {
			ALF_PhoneObject attachTo [
				(vehicle player),
				((vehicle player) worldToModel (player modelToWorldVisual ((player selectionPosition "RightHandMiddle1") vectorAdd [0.02, 0.01, 0.15])))
			];
			ALF_PhoneObject setVectorDirAndUp [[-0.21017, 0.265195, -0.94101], [-0.949623, 0.173499, 0.260989]];
		};
	};
};

ALF_Phone_tryCall = true;

if (life_radio_connected) then {
	[(call TFAR_fnc_activeSwRadio), 1, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
};

ALF_Phone_CallNumber = _numero;

[ALF_Phone_Anonyme, ALF_Phone_Number, _numero, player, _chauffeur] remoteExec ["ALF_Server_fnc_callSystem", 2];

private _hour = date select 3;
private _min = date select 4;
if (_min >= 0 && _min <= 9) then { _min = format ["0%1", _min]; };
ALF_Phone_Historique pushBack [format ["%1:%2", _hour, _min], false, 0, _numero];

player setVariable ["tf_unable_to_use_radio", true];

if !(isNull (findDisplay 56400)) then {
	uiNamespace setVariable ["iphonemenu", 0];
	[] call ALF_fnc_menuiPhone;
};

if !(isNull (findDisplay 20520)) then {
	uiNamespace setVariable ["sonypm", 0];
	[] call ALF_fnc_menuSonyPM;
};

if !(isNull (findDisplay 38999)) then {
	uiNamespace setVariable ["sonyp", 0];
	[] call ALF_fnc_menuSonyP;
};

if !(isNull (findDisplay 32999)) then {
	uiNamespace setVariable ["sony", 0];
	[] call ALF_fnc_menuSony;
};

private _myRadio = call TFAR_fnc_activeSwRadio;

for "_i" from 0 to 5 step 1 do {
	if !(ALF_Phone_tryCall) exitWith {};
	if !(life_is_alive) exitWith {};

	private _radios = player call TFAR_fnc_radiosList;
	if (count _radios < 1) exitWith {};
	if !([(call TFAR_fnc_activeSwRadio), _myRadio] call TFAR_fnc_isSameRadio) exitWith {};
	if ((("alf_iphone" in _myRadio) || {("alf_3310" in _myRadio)}) && {!(currentWeapon player isEqualTo "")}) exitWith {};

	playSound "phone_call";
	sleep 5;
};

if (ALF_Phone_tryCall) then { [] call ALF_fnc_resetcall; };
