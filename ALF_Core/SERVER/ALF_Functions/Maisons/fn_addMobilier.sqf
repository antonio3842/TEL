/// ALF_Server_fnc_addMobilier = {
params [
    ["_uid", "", [""]],
    ["_mobilier", objNull, [objNull]],
    ["_house", objNull, [objNull]],
    ["_className", "", [""]],
    ["_pos", [], [[]]],
    ["_dir", 0, [0]],
    ["_activeMun", "", [""]]
];
if (isNull _mobilier OR {_uid isEqualTo "" OR {isNull _house OR {count(_pos) isEqualTo 0 OR {_className isEqualTo ""}}}}) exitWith {};

// Pour les appartements: si la maison reçue n'a pas de house_owner, chercher une maison proche appartenant au joueur
private _owner = (_house getVariable ["house_owner", []]);
private _business = (_house getVariable ["business", []]);
if (count _owner == 0 AND {count _business == 0}) then {
    private _nearHouses = nearestObjects [getPosATL _mobilier, ["House", "House_F"], 20];
    {
        private _houseOwner = _x getVariable ["house_owner", []];
        if (count _houseOwner > 0 AND {(_houseOwner # 0) isEqualTo _uid}) exitWith {
            _house = _x;
        };
    } forEach _nearHouses;
};

private _mobiliers = _house getVariable ["mobiliers", []];

// Vérification si le nombre de mobilier est atteint
private _exit = false;
if ((typeOf _house) in ["Land_ALF_Entreprise","Land_i_Shed_Ind_F","Land_SM_01_shed_F","Land_Hangar2","Land_entreprise1"]) then
{
    if (count(_mobiliers) >= 35) exitWith {_exit = true;};
} else
{
    private _houseCfg = [(typeOf _house)] call ALF_fnc_houseConfig;
    if (count(_mobiliers) >= (_houseCfg # 1)) exitWith { _exit = true; };
};
if (_exit) exitWith
{
    ["ERREUR", "Il y a déjà trop de mobilier", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
    deleteVehicle _mobilier;
    [_activeMun, true] remoteExec ["ALF_fnc_handleItem", remoteExecutedOwner];
};

// Vérification propriétaire
if ((typeOf _house) in ["Land_ALF_Entreprise","Land_i_Shed_Ind_F","Land_SM_01_shed_F","Land_Hangar2","Land_entreprise1"]) then
{
    private _owner = (_house getVariable ["business", [""]]) # 0;
    if (_uid isNotEqualTo _owner) then
    {
        private _owner = (_house getVariable ["house_owner", [""]]) # 0;
        if (_uid isNotEqualTo _owner) exitWith { _exit = true; };
    };
} else
{
    private _owner = (_house getVariable ["house_owner", [""]]) # 0;
    if (_uid isNotEqualTo _owner) exitWith { _exit = true; };
};
if (_exit) exitWith
{
    ["ERREUR", "Vous n'êtes pas le propriétaire.", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
    deleteVehicle _mobilier;
    [_activeMun, true] remoteExec ["ALF_fnc_handleItem", remoteExecutedOwner];
};

if (((getModelInfo _mobilier) # 1) in ["alf_batiments\alf_edf\alf_utility_box_8.p3d", "alf_batiments\alf_edf\alf_utility_box_3.p3d", "alf_batiments\alf_edf\alf_utility_box_2.p3d"] AND
    {{((getModelInfo _x) # 1) in ["alf_batiments\alf_edf\alf_utility_box_8.p3d", "alf_batiments\alf_edf\alf_utility_box_3.p3d", "alf_batiments\alf_edf\alf_utility_box_2.p3d"]} count _mobiliers > 0}) then
{
    _exit = true;
};
if (_exit) exitWith
{
    ["ERREUR", "Vous ne pouvez pas poser un compteur, car vous en avez déjà un.", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
    deleteVehicle _mobilier;
    [_activeMun, true] remoteExec ["ALF_fnc_handleItem", remoteExecutedOwner];
};


if (_activeMun isEqualTo "ALF_Coco_boite" AND {{((getModelInfo _x) # 1) in ["alf_batiments\alf_h_cocaine\alf_coco.p3d"]} count _mobiliers > 0}) then {_exit = true;};
if (_exit) exitWith
{
    ["ERREUR", "Vous avez déjà un atelier installé.", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
    deleteVehicle _mobilier;
    [_activeMun, true] remoteExec ["ALF_fnc_handleItem", remoteExecutedOwner];
};

_mobiliers pushBack _mobilier;
_house setVariable ["mobiliers", _mobiliers, true]; // Synchroniser avec tous les clients

private _pidToUse = "";

// Vérifier si le bâtiment est un vrai business (a une variable business avec siret)
private _isBusiness = false;
if ((typeOf _house) in ["Land_ALF_Entreprise","Land_i_Shed_Ind_F","Land_SM_01_shed_F","Land_Hangar2","Land_entreprise1"]) then
{
    private _businessVar = _house getVariable ["business", []];
    if (count _businessVar > 0 AND {(_businessVar # 2) isNotEqualTo ""}) then {
        _isBusiness = true;
    };
};

if (_isBusiness) then
{
   _pidToUse = (_house getVariable ["business", ["", "", ""]]) # 2;
    if (_pidToUse isEqualTo "") then {_pidToUse = _uid;};
} else
{
    _pidToUse = _uid;
};

private _idHouse = 0;
if (_isBusiness) then
{
    // Business : chercher dans la table business
    private _posHouse = getPosATL _house;
    private _posStr = format["[%1,%2,", _posHouse # 0, _posHouse # 1];
    private _query = format["SELECT id FROM business WHERE siret='%1' AND pos LIKE '%2%%' AND active='1'", _pidToUse, _posStr];
    private _result = [_query, 2] call ALF_Server_fnc_asyncCall;
    if (count _result > 0) then {
        private _firstRow = _result # 0;
        if (_firstRow isEqualType []) then {
            _idHouse = parseNumber (_firstRow # 0);
        } else {
            if (_firstRow isEqualType 0) then {
                _idHouse = _firstRow;
            } else {
                _idHouse = parseNumber _firstRow;
            };
        };
    };
} else
{
    // Maison ou hangar perso : chercher dans la table houses
    private _posHouse = getPosATL _house;
    private _query = format["SELECT id FROM houses WHERE pid='%1' AND pos='%2'", _pidToUse, _posHouse];
    private _result = [_query, 2] call ALF_Server_fnc_asyncCall;
    if (count _result > 0) then { _idHouse = _result # 0; };
};


[format[
    "INSERT INTO mobiliers (pid, classname, pos, gear, dir, code, id_house) VALUES('%1', '%2', '%3', '[]', '%4', '0000', '%5')",
    _pidToUse, _className, _pos, _dir, _idHouse
], 1] call ALF_Server_fnc_asyncCall;

uiSleep 0.3;

private _queryResult = [format["SELECT id, code FROM mobiliers WHERE pos='%1' AND pid='%2'", _pos, _pidToUse], 2] call ALF_Server_fnc_asyncCall;
_mobilier setVariable ["mobilier_data", [_pidToUse, (_queryResult # 0), _className, _house, "0000", false]];
_mobilier setVariable ["gear", [], true];
// };