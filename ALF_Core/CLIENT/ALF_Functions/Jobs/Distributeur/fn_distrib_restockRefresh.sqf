/*
	File: fn_distrib_restockRefresh.sqf
	Met à jour les boutons du menu réappro sans fermer le dialogue.
*/
disableSerialization;

private _machine = uiNamespace getVariable ["MRP_Distrib_RestockMachine", objNull];
if (isNull _machine) exitWith {};

private _display = uiNamespace getVariable ["MRPV2_Interface_Diverse", controlNull];
private _parent = uiNamespace getVariable ["MRP_Distrib_RestockGroup", controlNull];

if (isNull _display || {isNull _parent}) exitWith {};

private _layout = uiNamespace getVariable ["MRP_Distrib_RestockLayout", []];
if (count _layout < 7) then {
	_layout = call ALF_fnc_distrib_restockCalcLayout;
	uiNamespace setVariable ["MRP_Distrib_RestockLayout", _layout];
};

_layout params [
	"_posBtnX", "_posBtnY", "_longueurBtn", "_hauteurBtn", "_ecartBtnY", "_ecartColX", "_colCount"
];

private _maxStock = call ALF_fnc_distrib_getStockMax;
private _focusItem = uiNamespace getVariable ["MRP_Distrib_RestockFocus", ""];
private _btnMap = uiNamespace getVariable ["MRP_Distrib_RestockButtons", createHashMap];
if (_btnMap isEqualType []) then { _btnMap = createHashMap; };

private _stock = [_machine] call ALF_fnc_distrib_stockEnsure;
private _items = [] call ALF_fnc_distrib_getShopItems;

{
	_x params ["_className", "_label"];
	private _qty = _stock getOrDefault [_className, 0];
	private _hasItem = ([_className] call ALF_fnc_distrib_countPlayerItem) > 0;
	private _btn = _btnMap getOrDefault [_className, controlNull];

	private _col = floor (_forEachIndex / 9);
	private _row = _forEachIndex mod 9;

	private _posX = _posBtnX + (_col * _ecartColX);
	private _posY = _posBtnY + (_row * _ecartBtnY);

	if (isNull _btn) then {
		_btn = _display ctrlCreate ["Life_RscButtonMenu", -1, _parent];
		_btn setVariable ["MRP_Distrib_RestockItem", _className];

		_btn ctrlAddEventHandler ["ButtonClick", compile format [
			"uiNamespace setVariable ['MRP_Distrib_RestockFocus', '%1']; ['%1','%2'] call ALF_fnc_distrib_restockOnPlus;",
			_className, _label
		]];

		_btn ctrlAddEventHandler ["MouseEnter", {
			params ["_ctrl"];
			if (ctrlEnabled _ctrl) then {
				_ctrl ctrlSetBackgroundColor [0.98, 0.49, 0.16, 1];
			};
		}];

		_btn ctrlAddEventHandler ["MouseExit", {
			params ["_ctrl"];
			private _focus = uiNamespace getVariable ["MRP_Distrib_RestockFocus", ""];
			if ((_ctrl getVariable ["MRP_Distrib_RestockItem", ""]) isEqualTo _focus) exitWith {
				_ctrl ctrlSetBackgroundColor [0.98, 0.49, 0.16, 1];
			};
			if (ctrlEnabled _ctrl) then {
				_ctrl ctrlSetBackgroundColor [0.17, 0.22, 0.3, 1];
			} else {
				_ctrl ctrlSetBackgroundColor [0.22, 0.22, 0.22, 0.85];
			};
		}];

		_btnMap set [_className, _btn];
	};

	_btn ctrlSetPosition [_posX, _posY, _longueurBtn, _hauteurBtn];

	private _shortLabel = _label;
	private _labelMax = if (_longueurBtn < 0.3) then { 12 } else { 18 };
	if (count _shortLabel > _labelMax) then {
		_shortLabel = (_shortLabel select [0, _labelMax - 2]) + "..";
	};

	if (_qty >= _maxStock) then {
		_btn ctrlSetStructuredText parseText format [
			"<t size='0.9' align='center' color='#888888'>%1  %2/%3</t>",
			_shortLabel, _qty, _maxStock
		];
		_btn ctrlSetBackgroundColor [0.22, 0.22, 0.22, 0.85];
		_btn ctrlEnable false;
	} else {
		if (_hasItem) then {
			_btn ctrlSetStructuredText parseText format [
				"<t size='0.9' align='center'>%1  %2/%3  [+]</t>",
				_shortLabel, _qty, _maxStock
			];
			_btn ctrlSetBackgroundColor [0.17, 0.22, 0.3, 1];
			_btn ctrlEnable true;
			_btn ctrlSetTooltip format ["Ajouter 1 %1 (+%2€)", _label, [_className] call ALF_fnc_distrib_getRestockPay];
		} else {
			_btn ctrlSetStructuredText parseText format [
				"<t size='0.9' align='center' color='#888888'>%1  %2/%3</t>",
				_shortLabel, _qty, _maxStock
			];
			_btn ctrlSetBackgroundColor [0.22, 0.22, 0.22, 0.85];
			_btn ctrlEnable true;
			_btn ctrlSetTooltip format ["Vous n'avez pas de %1 dans votre inventaire", _label];
		};
	};

	if (_className isEqualTo _focusItem) then {
		_btn ctrlSetBackgroundColor [0.98, 0.49, 0.16, 1];
	};

	_btn ctrlCommit 0;
} forEach _items;

uiNamespace setVariable ["MRP_Distrib_RestockButtons", _btnMap];
