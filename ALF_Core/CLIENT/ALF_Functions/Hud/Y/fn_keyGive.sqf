//ALF_fnc_keyGive = {
private ["_dialog","_list","_plist","_sel","_vehicle","_owners","_index","_unit","_uid"];
disableSerialization;

_dialog = findDisplay 123450;
_list = _dialog displayCtrl 123457;

_sel = lbCurSel _list;
if ((_list lbData _sel) isEqualTo "") exitWith {hint localize "STR_NOTF_didNotSelectVehicle";};
_vehicle = _list lbData _sel;
_vehicle = life_vehicles select parseNumber(_vehicle);

_unit = cursorObject;
if (isNil {_unit} OR {isNull _unit}) exitWith {};
if (_unit isEqualTo player OR {!isPlayer _unit OR {!alive _unit}}) exitWith {};

private _je_Prete = false;
private _isHouse = _vehicle isKindOf "House_F" OR { _vehicle isKindOf "House" };

[] call {
    if (_isHouse) exitWith { _je_Prete = true; };

    private _uid_Proprio = (_vehicle getVariable ["vehicle_info_owners", ["",""]]) # 1;
    _est_Proprio = (getPlayerUID player) isEqualTo _uid_Proprio;
    if (_est_Proprio) exitwith { _je_Prete = true; };

    private _owners = (_vehicle getVariable ["vehicle_info_owners",["",""]]) # 0;
    private _veh_Service = (_owners) in ["Gendarmerie","Pompiers","policemunicipale","Service Pénitencier"];
    private _joueur_Dun_Service = (life_coplevel != 0) OR { (life_mediclevel != 0) OR { (life_penit != 0) }};
    if (_veh_Service && { _joueur_Dun_Service }) exitWith { _je_Prete = true; };

    private _est_Employer_Du_Veh = ((player getVariable ["isEmployed",""]) isEqualTo ((_vehicle getVariable ["business_veh",[""]]) # 0));
    if (_est_Employer_Du_Veh) then { _je_Prete = true; };
};

if (_je_Prete) then {
    private _name = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
    private _titre = if (_isHouse) then {"Clé (Maison)"} else {"Clé"};
    private _label = if (_isHouse) then {_name} else {getPlateNumber _vehicle};
    private _action = [format["Voulez-vous prêter les clés de %1 ?", _label], _titre, "OUI", "NON"] call BIS_fnc_guiMessage;
    if (!_action) exitWith {};
    ["INFO", format["Vous venez de prêter les clés de : %1", _name], "success"] spawn ALF_fnc_doMsg;
    [_vehicle,_unit] remoteExecCall ["TON_fnc_clientGetKey", _unit];
    ["INFO", format["On vous a prêté les clés de : %1", _name], "success"] remoteExec ["ALF_fnc_doMsg", _unit];
} else {
    ["INFO", "Vous n'êtes pas autorisé à prêter les clés de cet objet.", "warning"] spawn ALF_fnc_doMsg;
};

//};



