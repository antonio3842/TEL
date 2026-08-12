/* Copyright 2023 - Association Get Your Path. All rights reserved */
if ((lbCurSel 4515) isEqualTo -1) exitWith {["Erreur",format["Vous devez sélectionner un document pour continuer !"],"warning"] spawn ALF_fnc_doMsg; false;};

private _data = lbData[4515,(lbCurSel 4515)];
if (_data isEqualTo "NULL") exitWith {["Erreur",format["Vous devez sélectionner un document pour continuer !"],"warning"] spawn ALF_fnc_doMsg; false;};

_data = call compile format["%1",_data];
player setVariable ["advanced_document_display",_data];

[] spawn ALF_fnc_displayDocument;
