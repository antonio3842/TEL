/*
MRPV2_fnc_Interaction_Scanner_IRM = {

    private _scanner = param [0, objNull];

    if (!dialog) then { createDialog "interactionSystem"; };

    private _affichage = findDisplay 25799;

    private _liste_Boutons = [];
    for "_i" from 0 to 11 do {
        private _bouton = _affichage displayCtrl (25802 + _i);
        _liste_Boutons pushBack _bouton;
    };

    private _hasBrancard  = false;
    private _hasComa      = false;
    private _scanDuration = 150;

    private _brancards = (nearestObjects [player, ["VEH_MRP_Brancard_Vsav", "ALF_Brancard_P"], 5]) select { crew _x isNotEqualTo [] };

    if ((count _brancards) > 0) then {
        _hasBrancard = true;

        {
            private _brancard = _x;
            private _patient  = (crew _brancard) # 0;

            if (!isNull _patient && { _patient getVariable ["onScanner", false] }) then {
                private _timeout = _patient getVariable ["scannerTimeout", 0];
                if (time < _timeout) exitWith {
                    ["INFO", "La personne que vous essayez de réanimer est déjà prise en charge par un autre scanner.", "warning"] spawn ALF_fnc_doMsg;
                };
                _patient setVariable ["onScanner", false, true];
                _patient setVariable ["scannerTimeout", nil, true];
            };

            private _bouton = (_liste_Boutons select { !ctrlShown _x }) # 0;
            _bouton ctrlShow true;
            _bouton ctrlSetText format ["Transférer patient pour soin (#%1)", _forEachIndex + 1];
            _bouton setVariable ["_brancard", _brancard];
            _bouton setVariable ["_scanner",  _scanner];

            _bouton ctrlAddEventHandler ["buttonClick", {
                params ["_control"];
                closeDialog 2;

                private _brancard = _control getVariable ["_brancard", objNull];
                private _scanner  = _control getVariable ["_scanner",  objNull];

                if (isNull _brancard || { crew _brancard isEqualTo [] }) exitWith {
                    ["INFO", "Le brancard ne contient plus de patient.", "danger"] spawn ALF_fnc_doMsg;
                };

                if (_scanner getVariable ["wip", false]) exitWith {
                    ["INFO", "Un patient est déjà sur le scanner.", "warning"] spawn ALF_fnc_doMsg;
                };

                private _patient = (crew _brancard) # 0;
                if (isNull _patient) exitWith {
                    ["INFO", "Le brancard ne contient plus de patient.", "danger"] spawn ALF_fnc_doMsg;
                };

                if (_patient getVariable ["onScanner", false]) exitWith {
                    ["INFO", "Le patient est déjà en cours de scanner.", "danger"] spawn ALF_fnc_doMsg;
                };

                _patient setVariable ["onScanner", true, true];
                _patient setVariable ["scannerTimeout", time + 150, true];

                [player, _patient] remoteExec ["ALF_fnc_scannerSystem", _patient];
            }];

        } forEach (_brancards select [0, 2]);
    };

    private _groupe_SP = units ((groups civilian select { "Pompiers" in groupId _x }) # 0);
    if (isNil "_groupe_SP") then { _groupe_SP = []; };

    private _comaPlayers = (nearestObjects [_scanner, ["Man"], 5]) select {
        lifestate _x isEqualTo "INCAPACITATED"
    };

    if ((count _comaPlayers) > 0) then {
        private _patient = _comaPlayers # 0;

        if (_patient getVariable ["onScanner", false]) then {
            private _timeout = _patient getVariable ["scannerTimeout", 0];
            if (time < _timeout) exitWith {
                ["INFO", "La personne que vous essayez de réanimer est déjà prise en charge par un autre scanner.", "warning"] spawn ALF_fnc_doMsg;
            };
            _patient setVariable ["onScanner", false, true];
            _patient setVariable ["scannerTimeout", nil, true];
        };

        _hasComa = true;
        private _hasMedecin = ((count _groupe_SP) > 0);

        private _bouton = (_liste_Boutons select { !ctrlShown _x }) # 0;
        _bouton ctrlShow true;
        _bouton ctrlSetText "Scanner un blessé inconscient";
        _bouton setVariable ["_patient", _patient];
        _bouton setVariable ["_scanner", _scanner];

        if (_hasMedecin) then {
            if (player in _groupe_SP) then {
                _bouton ctrlEnable true;
                _bouton ctrlAddEventHandler ["buttonClick", {
                    params ["_control"];
                    closeDialog 2;

                    private _scanner = _control getVariable ["_scanner", objNull];
                    private _patient = _control getVariable ["_patient", objNull];

                    if (isNull _patient || { lifestate _patient != "INCAPACITATED" }) exitWith {
                        ["INFO", "Le blessé n'est plus inconscient.", "danger"] spawn ALF_fnc_doMsg;
                    };

                    if (_scanner getVariable ["wip", false]) exitWith {
                        ["INFO", "Un patient est déjà sur le scanner.", "warning"] spawn ALF_fnc_doMsg;
                    };

                    if (_patient getVariable ["onScanner", false]) exitWith {
                        ["INFO", "Le patient est déjà en cours de scanner.", "danger"] spawn ALF_fnc_doMsg;
                    };

                    _patient setVariable ["onScanner", true, true];
                    _patient setVariable ["scannerTimeout", time + 150, true];

                    [player, _patient] remoteExec ["ALF_fnc_scannerSystem", _patient];
                }];
            } else {
                _bouton ctrlEnable true;
                _bouton ctrlAddEventHandler ["buttonClick", {
                    params ["_control"];
                    closeDialog 2;

                    ["INFO", "Un secouriste est en service. Veuillez contacter les pompiers pour utiliser l'IRM.", "warning"] spawn ALF_fnc_doMsg;
                    [format["Une personne tente d'utiliser le scanner sans pompier.", name player], "Départ VSAV CH FDF (Scanner)!"] remoteExecCall ["ALF_Server_fnc_doMedCall", 2];
                }];
            };
        } else {
            _bouton ctrlEnable true;
            _bouton ctrlAddEventHandler ["buttonClick", {
                params ["_control"];
                closeDialog 2;

                private _scanner = _control getVariable ["_scanner", objNull];
                private _patient = _control getVariable ["_patient", objNull];

                if (isNull _patient || { lifestate _patient != "INCAPACITATED" }) exitWith {
                    ["INFO", "Le blessé n'est plus inconscient.", "danger"] spawn ALF_fnc_doMsg;
                };

                if (_scanner getVariable ["wip", false]) exitWith {
                    ["INFO", "Un patient est déjà sur le scanner.", "warning"] spawn ALF_fnc_doMsg;
                };

                if (_patient getVariable ["onScanner", false]) exitWith {
                    ["INFO", "Le patient est déjà en cours de scanner.", "danger"] spawn ALF_fnc_doMsg;
                };

                _patient setVariable ["onScanner", true, true];
                _patient setVariable ["scannerTimeout", time + 150, true];

                [player, _patient] remoteExec ["ALF_fnc_scannerSystem", _patient];
            }];
        };
    };

    if (_hasBrancard && _hasComa) then {

        {
            if (ctrlShown _x && { ctrlText _x == "Scanner un blessé inconscient" }) then {
                _x ctrlEnable false;
            };
        } forEach _liste_Boutons;
    };

    if ((_liste_Boutons select { ctrlShown _x }) isEqualTo []) then {
        closeDialog 2;
    };
};
*/



// MRPV2_fnc_Interaction_Scanner_IRM = {
private _scanner = param [0, objNull];

if (gestureState player isEqualTo "<none>" OR {_scanner distance player > 3}) exitWith {};

if ((nearestObjects [player, ["Man"], 25]) findIf { str _x isEqualTo "MRPV2_PNJ_SP_Veto" } > -1) exitWith {
	["Vétérinaire", "Le scanner est réservé aux animaux, aller voir le vétérinaire pour plus d'informations.", "warning"] spawn ALF_fnc_doMsg;
};

life_pInact_curObject = _scanner;

private _liste_Actions = createhashmap;
private _liste_Sous_Actions = [];

private _hasBrancard = false;
private _hasComa = false;
private _scanDuration = 150;

// Vérifier les brancards proches
private _brancards = (nearestObjects [player, ["VEH_MRP_Brancard_Vsav", "ALF_Brancard_P", "Brancardlu"], 8]) select { crew _x isNotEqualTo [] };

if ((count _brancards) > 0) then 
{
    _hasBrancard = true;

    {
        private _brancard = _x;
        private _patient = (crew _brancard) # 0;

        //if (!isNull _patient && { _patient getVariable ["onScanner", false] }) then 
        //{
        //    private _timeout = _patient getVariable ["scannerTimeout", 0];
        //    if (time < _timeout) exitWith 
        //    {
        //        ["INFO", "La personne que vous essayez de réanimer est déjà prise en charge par un autre scanner.", "warning"] spawn ALF_fnc_doMsg;
        //    };
        //    _patient setVariable ["onScanner", false, true];
        //    _patient setVariable ["scannerTimeout", nil, true];
        //};

        private _texte = format ["Transférer patient pour soin (#%1)", _forEachIndex + 1];
        private _texte_tooltype = "Transférer le patient du brancard vers le scanner";
        private _action = compile format ["
            closeDialog 0;
            private _scanner = life_pInact_curObject;
            private _brancard = objectFromNetId '%1';

            if (isNull _brancard || { crew _brancard isEqualTo [] }) exitWith
            {
                ['INFO', 'Le brancard ne contient plus de patient.', 'danger'] spawn ALF_fnc_doMsg;
            };

            if (_scanner getVariable ['wip', false]) exitWith
            {
                ['INFO', 'Un patient est déjà sur le scanner.', 'warning'] spawn ALF_fnc_doMsg;
            };

            private _patient = (crew _brancard) # 0;
            if (isNull _patient) exitWith
            {
                ['INFO', 'Le brancard ne contient plus de patient.', 'danger'] spawn ALF_fnc_doMsg;
            };

            if (_patient getVariable ['onScanner', false]) exitWith
            {
                ['INFO', 'Le patient est déjà en cours de scanner.', 'danger'] spawn ALF_fnc_doMsg;
            };

            _patient setVariable ['onScanner', true, true];
            _patient setVariable ['scannerTimeout', time + 150, true];

            [player, _patient] remoteExec ['ALF_fnc_scannerSystem', _patient];
        ", netId _brancard];
        
        _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];

    } forEach (_brancards select [0, 2]);
};

// Vérifier les patients inconscients proches
private _groupe_SP = units ((groups civilian select { "Pompiers" in groupId _x }) # 0);
if (isNil "_groupe_SP") then { _groupe_SP = []; };

private _comaPlayers = (nearestObjects [_scanner, ["Man"], 5]) select {
    lifestate _x isEqualTo "INCAPACITATED"
};

if ((count _comaPlayers) > 0) then 
{
    private _patient = _comaPlayers # 0;

    if (_patient getVariable ["onScanner", false]) then 
    {
        private _timeout = _patient getVariable ["scannerTimeout", 0];
        if (time < _timeout) exitWith 
        {
            ["INFO", "La personne que vous essayez de réanimer est déjà prise en charge par un autre scanner.", "warning"] spawn ALF_fnc_doMsg;
        };
        _patient setVariable ["onScanner", false, true];
        _patient setVariable ["scannerTimeout", nil, true];
    };

    _hasComa = true;
    private _hasMedecin = ((count _groupe_SP) > 0);

    private _texte = "Scanner un blessé inconscient";
    private _texte_tooltype = "Scanner un blessé inconscient";
    
    if (_hasMedecin) then 
    {
        if (player in _groupe_SP) then 
        {
            // Pompier - peut scanner
            private _action = compile format ["
                closeDialog 0;
                private _scanner = life_pInact_curObject;
                private _patient = %1;

                if (isNull _patient || { lifestate _patient != 'INCAPACITATED' }) exitWith 
                {
                    ['INFO', 'Le blessé n''est plus inconscient.', 'danger'] spawn ALF_fnc_doMsg;
                };

                if (_scanner getVariable ['wip', false]) exitWith 
                {
                    ['INFO', 'Un patient est déjà sur le scanner.', 'warning'] spawn ALF_fnc_doMsg;
                };

                if (_patient getVariable ['onScanner', false]) exitWith 
                {
                    ['INFO', 'Le patient est déjà en cours de scanner.', 'danger'] spawn ALF_fnc_doMsg;
                };

                _patient setVariable ['onScanner', true, true];
                _patient setVariable ['scannerTimeout', time + 150, true];

                [player, _patient] remoteExec ['ALF_fnc_scannerSystem', _patient];
            ", _patient];
            _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
        } else 
        {
            // Non pompier mais pompiers en service
            private _action = 
            {
                closeDialog 0;
                ["INFO", "Un secouriste est en service. Veuillez contacter les pompiers pour utiliser l'IRM.", "warning"] spawn ALF_fnc_doMsg;
                [format["Une personne tente d'utiliser le scanner sans pompier.", name player], "Départ VSAV (Scanner)!"] remoteExecCall ["ALF_Server_fnc_doMedCall", 2];
            };
            _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
        };
    } else 
    {
        // Pas de pompiers en service - peut scanner
        private _action = compile format ["
            closeDialog 0;
            private _scanner = life_pInact_curObject;
            private _patient = %1;

            if (isNull _patient || { lifestate _patient != 'INCAPACITATED' }) exitWith 
            {
                ['INFO', 'Le blessé n''est plus inconscient.', 'danger'] spawn ALF_fnc_doMsg;
            };

            if (_scanner getVariable ['wip', false]) exitWith 
            {
                ['INFO', 'Un patient est déjà sur le scanner.', 'warning'] spawn ALF_fnc_doMsg;
            };

            if (_patient getVariable ['onScanner', false]) exitWith 
            {
                ['INFO', 'Le patient est déjà en cours de scanner.', 'danger'] spawn ALF_fnc_doMsg;
            };

            _patient setVariable ['onScanner', true, true];
            _patient setVariable ['scannerTimeout', time + 150, true];

            [player, _patient] remoteExec ['ALF_fnc_scannerSystem', _patient];
        ", _patient];
        _liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
    };
};

if (_liste_Sous_Actions isequalto []) exitwith {};
_liste_Actions set ["",_liste_Sous_Actions];
[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
// };
