// MRPV2_fnc_MRP_Tel_Menu_Annuaire_Call_API = {

private _GN_Array = (groups civilian) select {groupId _x isEqualTo "Gendarmerie"};
private _SP_Array = (groups civilian) select {groupId _x isEqualTo "Pompiers"};
private _PM_Array = (groups civilian) select {groupId _x isEqualTo "policemunicipale"};

private _GN_En_Service = if (count _GN_Array > 0) then {_GN_Array # 0} else {grpNull};
private _SP_En_Service = if (count _SP_Array > 0) then {_SP_Array # 0} else {grpNull};
private _PM_En_Service = if (count _PM_Array > 0) then {_PM_Array # 0} else {grpNull};

_GNcount = if (!isNull _GN_En_Service) then {count (units _GN_En_Service)} else {0};
_SPcount = if (!isNull _SP_En_Service) then {count (units _SP_En_Service)} else {0};
_PMcount = if (!isNull _PM_En_Service) then {count (units _PM_En_Service)} else {0};
 
_gnOpen = false; 
_spOpen = false; 
_pmOpen = false; 
 
if (_GNcount != 0) then {_gnOpen = true;}; 
if (_SPcount != 0) then {_spOpen = true;}; 
if (_PMcount != 0) then {_pmOpen = true;};

_annuaire = [];
_GN = createHashMapFromArray [
        ["CID", "1"],
        ["POSS", [5576,4875,0]],
        ["PHONE", "17"],
        ["NAME", "Gendarmerie"],
        ["DESC", ""],
        ["OPEN", _gnOpen]
    ];
_SP = createHashMapFromArray [
        ["CID", "2"],
        ["POSS", [4396,7569,5]],
        ["PHONE", "18"],
        ["NAME", "Pompiers"],
        ["DESC", ""],
        ["OPEN", _spOpen]
    ];
_PM = createHashMapFromArray [
        ["CID", "3"],
        ["POSS", [3922,4474,5]],
        ["PHONE", "21"],
        ["NAME", "AP / PM"],
        ["DESC", ""],
        ["OPEN", _pmOpen]
    ];
_annuaire pushBack _GN;
_annuaire pushBack _SP;
_annuaire pushBack _PM;
{
	_info = _x getVariable ["business",[]];
	_name = _info # 1;
	if !(_name find "Hangar de" == 0) then {
		_entreprise = createHashMapFromArray [
				["CID", _info # 2],
				["POSS", _info # 11],
				["PHONE", _info # 10],
				["NAME", _info # 1],
				["DESC", ""],
				["OPEN", _info # 12]
			];
		_annuaire pushBack _entreprise;
	};
} forEach ALF_allBusinesss;

MRP_Telephone_Annuaire = _annuaire

// };