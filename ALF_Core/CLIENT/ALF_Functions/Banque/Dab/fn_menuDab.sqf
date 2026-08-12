// ALF_fnc_menuDab = {
if !([player] call ALF_fnc_hasEnergy) exitWith {["Info", "Il n'y n'a pas d'électricité.", "danger"] spawn ALF_fnc_doMsg;};
if (!life_laactive && {!life_lbactive} && {!life_lcactive}) exitWith {["Distributeur", "Vous n'avez pas de compte bancaire.", "danger"] spawn ALF_fnc_doMsg;};
if (life_activecb isEqualTo 0) exitWith {["Distributeur", "Votre carte bancaire n'est lié à aucun compte.", "warning"] spawn ALF_fnc_doMsg;};

if(isnull findDisplay 10520) then {createDialog "ALF_DabMenu_Dialog";};
disableSerialization;

private _display = findDisplay 10520;
private _livreta = _display displayCtrl 10521;
private _livretb = _display displayCtrl 10522;
private _livretc = _display displayCtrl 10523;
private _solde = _display displayCtrl 10524;
private _cash = _display displayCtrl 10525;
private _edit = _display displayCtrl 10526;
private _btnretirer = _display displayCtrl 10527;
private _btndeposer = _display displayCtrl 10528;

switch (life_activecb) do {
case 1 : {
_livreta ctrlShow true;
_livretb ctrlShow false;
_livretc ctrlShow false;
_edit ctrlShow true;
_btnretirer ctrlShow true;
_btndeposer ctrlShow true;

_btnretirer buttonSetAction "[] spawn ALF_fnc_retirerDab;";
_btndeposer buttonSetAction "[] spawn ALF_fnc_deposerDab;";
};
case 2 : {
_livreta ctrlShow false;
_livretb ctrlShow true;
_livretc ctrlShow false;
_edit ctrlShow true;
_btnretirer ctrlShow true;
_btndeposer ctrlShow true;

_btnretirer buttonSetAction "[] spawn ALF_fnc_retirerDab;";
_btndeposer buttonSetAction "[] spawn ALF_fnc_deposerDab;";
};
case 3 : {
_livreta ctrlShow false;
_livretb ctrlShow false;
_livretc ctrlShow true;
_edit ctrlShow true;
_btnretirer ctrlShow true;
_btndeposer ctrlShow true;

_btnretirer buttonSetAction "[] spawn ALF_fnc_retirerDab;";
_btndeposer buttonSetAction "[] spawn ALF_fnc_deposerDab;";
};
};

[] call ALF_fnc_updateDab;

private _hour = date select 3;
private _min = date select 4;
if(_min >= 0 && _min <= 9) then {_min = format["0%1", _min];};
private _time = format["%1:%2",_hour,_min];

private _atmInput = if (count _this > 0) then {_this select 0} else {objNull};
private _atmNearest = (nearestObjects [player, ["Land_ALF_ATM"], 3]) param [0, objNull, [objNull]];
private _atm = if !(isNull _atmNearest) then {_atmNearest} else {_atmInput};
if (isNull _atm) exitWith {};
private _pAtm = getPosWorld _atm;
private _cameraKey = format [
	"%1_%2_%3_%4",
	toLower typeOf _atm,
	round ((_pAtm # 0) * 10),
	round ((_pAtm # 1) * 10),
	round ((_pAtm # 2) * 10)
];
private _nearPlayers = (position _atm) nearEntities [["Man"],15];
private _nearPlayersFace = [];
{
	private _g = goggles _x;
	private _h = headgear _x;
	if (_h in ["ALF_Casque_PMO","ALF_Bike","ALF_H_Moto_2_Violet","ALF_H_Moto_2_Vert","ALF_H_Moto_2_RougeFonce","ALF_H_Moto_2_Orange","ALF_H_Moto_2_Jaune","ALF_H_Moto_2_Bleu","ALF_H_Moto_2_Blanc","ALF_H_Moto_2_Noir","ALF_H_Moto_Violet","ALF_H_Moto_Vert","ALF_H_Moto_RougeFonce","ALF_H_Moto_Orange","ALF_H_Moto_Jaune","ALF_H_Moto_Bleu","ALF_H_Moto_Blanc","ALF_H_Moto_Noir"] OR {_g in ["ALF_G_Balaclava_blk","ALF_G_Bandanna_beast","ALF_G_Bandanna_blk"]}) then {
		_nearPlayersFace pushBack "Cagoule";
	} else {
		private _adn = _x getVariable ["adnface", ["Inconnu","Inconnu"]];
		_nearPlayersFace pushBack (_adn # 1);
	};
} forEach _nearPlayers;
if (_nearPlayersFace isEqualTo []) then {
	_nearPlayersFace pushBack "Inconnu";
};

[_atm,_time,_nearPlayersFace,_cameraKey] remoteExecCall ["ALF_Server_fnc_setCameraVar",2];
// };
