/*
	[_secteur, _montant] call ALF_Server_fnc_addCapitalBySecteur;
	Récupère le siret via le secteur puis ajoute au capital.
	Fonctionne pour TOUS les types de bâtiments (entreprises, casinos, etc.)
*/

params ["_secteur","_montant"];

if (isNil "_secteur" || {isNil "_montant"}) exitWith {};

if !(_montant isEqualType 0) then {
	_montant = parseNumber (str _montant);
};
if (_montant <= 0) exitWith {};

private _result = [format ["SELECT siret,capital FROM business WHERE secteur='%1' AND active='1' AND name NOT LIKE 'Hangar de%%' ORDER BY id ASC LIMIT 1", _secteur], 2] call ALF_Server_fnc_asyncCall;

if (!(_result isEqualType []) || {count _result == 0}) exitWith {};

// asyncCall mode 2 (sans _multiarr) retourne un array plat : ["siret","capital"]
// Si nested (au cas où) : [["siret","capital"]] → on prend le premier élément
private _siret = "";
private _capitalStr = "0";

private _first = _result # 0;
if (_first isEqualType []) then {
	// Nested : [["siret","capital"]]
	_siret = _first # 0;
	if (count _first > 1) then {_capitalStr = str (_first # 1);};
} else {
	// Flat : ["siret","capital"]
	_siret = _first;
	if (count _result > 1) then {_capitalStr = str (_result # 1);};
};

if (_siret isEqualTo "") exitWith {};

private _capital = parseNumber _capitalStr;
private _new = _capital + _montant;
private _newStr = [_new] call ALF_Server_fnc_numberSafe;

[format ["UPDATE business SET capital='%1' WHERE siret='%2' AND active='1' AND name NOT LIKE 'Hangar de%%'", _newStr, _siret], 1] call ALF_Server_fnc_asyncCall;

// Synchroniser la variable "business" en jeu (visible immédiatement côté clients)
if !(isNil "ALF_allBusinesss") then {
	{
		if (!isNull _x) then {
			private _data = _x getVariable ["business", []];
			if ((_data isEqualType []) && {count _data > 3}) then {
				private _objSiret = _data # 2;
				private _objName = _data param [1, ""];
				private _isHangar = (_objName isEqualType "") && {(_objName find "Hangar de") isEqualTo 0};
				if ((_objSiret isEqualTo _siret) && {!_isHangar}) then {
					_data set [3, _new];
					_x setVariable ["business", _data, true];
				};
			};
		};
	} forEach ALF_allBusinesss;
};
