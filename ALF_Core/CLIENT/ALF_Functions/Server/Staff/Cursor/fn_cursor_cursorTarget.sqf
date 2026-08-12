("ALF_AdminCursor_Dialog" call BIS_fnc_rscLayer) cutRsc ["ALF_AdminCursor_Dialog", "PLAIN"];
ALF_CursorTargetEnabled = true;
((uiNamespace getVariable "ALF_AdminCursor_Dialog") displayCtrl 2414) ctrlSetStructuredText (parseText format["<t font='PuristaSemiBold' align='left' size='0.85'>Numpad 0: Conducteur<br/>Numpad 1: Attacher<br/>Numpad 2: Detacher<br/>Numpad 3: Fourrière<br/>Numpad 4: Supprimer<br/>Numpad 5: Passager<br/>Numpad 6: Ejecter passagers<br/>Numpad 7: Soigner<br/>Numpad 8: Réparer<br/>Numpad 9: Ravitailler essence</t>"]);

while {ALF_CursorTargetEnabled} do {
    uiSleep 0.1;
    private _cursText = "N/A";
    if (!(isNull cursorTarget)) then {
        _cursText = typeOf cursorTarget;
    };
    if ((typeOf cursorObject) isEqualTo "C_man_w_worker_F") then {
        _cursText = cursorObject;
    };
    if (isPlayer cursorTarget) then {
        _cursText = (driver cursorTarget) getVariable ["name",""];
    };
    if (_cursText isEqualTo "") then {
        _cursText = "N/A";
    };
    ((uiNamespace getVariable "ALF_AdminCursor_Dialog") displayCtrl 1000) ctrlSetStructuredText (parseText format["<t font='PuristaSemiBold' align='center' size='1'>Curseur: %1</t>",(_cursText)]);
};
("ALF_AdminCursor_Dialog" call BIS_fnc_rscLayer) cutFadeOut 1;
