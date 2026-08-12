params [
    ["_classname","",[""]]
];

if (_classname isEqualTo "") exitWith {};
if !([["ALF_CfgTraitements",_classname]] call ALFTools_Client_Config_fnc_isClass) exitWith {};

_allowedKey = (["ARRAY", ["ALF_CfgTraitements","keys"]] call ALFTools_Client_Config_fnc_getConfig);

life_action_inUse = true;
_itemRequired = (["ARRAY", ["ALF_CfgTraitements",_classname,"itemRequired"]] call ALFTools_Client_Config_fnc_getConfig);
_itemGiven = (["ARRAY", ["ALF_CfgTraitements",_classname,"itemGiven"]] call ALFTools_Client_Config_fnc_getConfig);
_duration = (["NUMBER", ["ALF_CfgTraitements",_classname,"duration"]] call ALFTools_Client_Config_fnc_getConfig);
_displayText = (["STRING", ["ALF_CfgTraitements",_classname,"displayText"]] call ALFTools_Client_Config_fnc_getConfig);

disableSerialization;

private _exit = false;
private _done = false;
//while {!_exit} do {
    private _items = items player;
    _items append (magazines player);
    {
        _requiredItemClass = _x select 0;
        _requiredItemNumber = _x select 1;
        _isMag = false;
        if (isClass(configFile >> "CfgMagazines" >> _requiredItemClass)) then {
            _isMag = true;
        };
        if (_isMag) then {
            if !(_requiredItemClass in _items) exitWith {
                _exit = true;
            };
            if (({(_x select 0) isEqualTo _requiredItemClass && {(_x select 1) >= _requiredItemNumber}} count magazinesAmmo player) isEqualTo 0) exitWith {
                if (({_x == _requiredItemClass} count _items) < _requiredItemNumber) exitWith {
			 		_exit = true;
			 	};
            };
        } else {
            if !(_requiredItemClass in _items) exitWith {
	 			_exit = true;
		 	};
		 	if (({_x == _requiredItemClass} count _items) < _requiredItemNumber) exitWith {
		 		_exit = true;
		 	};
        };

       
    } forEach _itemRequired;
     if (_exit) exitWith {
        if (_done) then {
            ["Traitement", "Traitement terminé.", "success", false] spawn ALF_fnc_doMsg;
        } else {
            ["Traitement", "Vous n'avez pas tous les composants.", "danger", false] spawn ALF_fnc_doMsg;
        };
    };

   
    _qteKeysOnly = [];
    _qteKeysWithImage = [];
    for "_i" from 0 to 4 do {
        _choice = selectRandom _allowedKey;
        _qteKeysWithImage pushBack _choice;
        _qteKeysOnly pushBack (_choice select 0);
    };

    uiNamespace setVariable ["ALF_QTE", _qteKeysOnly];
    life_is_processing = true;
    uiNamespace setVariable ["ALF_QTE_Failure", false];
    uiNamespace setVariable ["ALF_QTE_Success", false];
    uiNamespace setVariable ["ALF_QTE_Rank", 0];
    uiNamespace setVariable ["ALF_QTE_Process_Given_Up", true];
    uiNamespace setVariable ["ALF_Process_Done", false];

    [_qteKeysWithImage] call ALF_fnc_processImageManager;

    _evId = (findDisplay 46) displayAddEventHandler ["KeyDown","_this call ALF_fnc_processKeyManager;"];

    _script = [_duration, [], { uiNamespace setVariable ["ALF_Process_Given_Up", false]; uiNamespace setVariable ["ALF_Process_Done", true]; }, {if (uiNamespace setVariable ["ALF_Process_Given_Up", true]); uiNamespace setVariable ["ALF_Process_Done", true];}, _displayText] spawn ALF_fnc_processBar;
	waitUntil {uiNamespace getVariable ["ALF_Process_Done", false]};

    (findDisplay 46) displayRemoveEventHandler ["KeyDown", _evId];

    {
        ctrlDelete _x;
    } forEach (uiNamespace getVariable ["ALF_QTE_Images",[]]);

    life_is_processing = false;

    if (uiNamespace getVariable ["ALF_Process_Given_Up", true]) exitWith {};

    {
        _givenItemClass = _x select 0;
        _givenItemNumber = _x select 1;
        if !(player canAdd [_givenItemClass, _givenItemNumber]) exitWith {
            _exit = true;
        };
    } forEach _itemGiven;

    if (_exit) exitWith {
        ["Traitement", "Vous n'avez pas assez de place pour récupérer votre production.", "danger", false] spawn ALF_fnc_doMsg;
    };

    {
        _requiredItemClass = _x select 0;
        _requiredItemNumber = _x select 1;
        for "_i" from 1 to _requiredItemNumber do {
            [_requiredItemClass,false] spawn ALF_fnc_handleItem;
        };
    } forEach _itemRequired;

    {
        _givenItemClass = _x select 0;
        _givenItemNumber = _x select 1;
        for "_i" from 1 to _givenItemNumber do {
            player addItem _givenItemClass;
        }; 
    } forEach _itemGiven;

    _done = true;
    ["Traitement", "Traitement terminé.", "success", false] spawn ALF_fnc_doMsg;
    uiNamespace setVariable ["ALF_Process_Done", false];
//};

life_action_inUse = false;