// ALF_fnc_keyGivetime = {
disableSerialization;
private _dialog = findDisplay 123450;
private _list = _dialog displayCtrl 123457;

private _sel = lbCurSel _list;
if((_list lbData _sel) isEqualTo "") exitWith {hint localize "STR_NOTF_didNotSelectVehicle";};
private _vehicle = _list lbData _sel;
_vehicle = life_vehicles select parseNumber(_vehicle);

private _unit = cursorObject;
if(isNil "_unit") exitWith {};
if(isNull _unit) exitWith {};
if(_unit isEqualTo player) exitWith {};
if!(_unit isKindOf "Man") exitWith {};
if(!isPlayer _unit) exitWith {};
if(!alive _unit) exitWith {};

private _num = ctrlText 123496;
if(_num isEqualTo "") exitWith {[] spawn ALF_fnc_keyGiveDef;};
if !([_num] call TON_fnc_isnumber) exitWith {["INFO","Erreur dans le nombre de jour.","success"] spawn ALF_fnc_doMsg;};
_num = parseNumber(_num);
if(_num < 1 OR {_num > 30}) exitWith {["INFO","Le nombre de jour doit etre entre 1 et 30.","success"] spawn ALF_fnc_doMsg;};

private _uid = getPlayerUID _unit;
private _canGive = false;

if (_vehicle isKindOf "House") exitWith {
	[1,_vehicle,_num,_unit,player] remoteExec ["ALF_Server_fnc_keyGiveTime",2];
};

[] call {
    private _uid_Proprio = (_vehicle getVariable ["vehicle_info_owners", ["",""]]) # 1;
    _est_Proprio = (getPlayerUID player) isEqualTo _uid_Proprio;
    if (_est_Proprio) exitwith { _canGive = true; };

    private _owners = (_vehicle getVariable ["vehicle_info_owners",["",""]]) # 0;
    private _veh_Service = (_owners) in ["Gendarmerie","Pompiers","policemunicipale","Service Pénitencier"];
    private _joueur_Dun_Service = (life_coplevel != 0) OR { (life_mediclevel != 0) OR { (life_penit != 0) }};
    if (_veh_Service && { _joueur_Dun_Service }) exitWith { _canGive = false; };

    private _est_Employer_Du_Veh = ((player getVariable ["isEmployed",""]) isEqualTo ((_vehicle getVariable ["business_veh",[""]]) # 0));
    if (_est_Employer_Du_Veh) then { _canGive = true; };
};

if (_canGive) then {
	[0,_vehicle,_num,_unit,player] remoteExec ["ALF_Server_fnc_keyGiveTime",2];
} else {
	["INFO", "Tu n'es pas autorisé à prêter les clés de ce véhicule.", "warning"] spawn ALF_fnc_doMsg;
};
