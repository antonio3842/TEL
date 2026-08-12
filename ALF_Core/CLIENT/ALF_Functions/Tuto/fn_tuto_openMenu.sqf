/*
    Fichier : fn_tuto_openMenu.sqf
    Ouvre le guide tutoriel (dialog quasi plein ecran)
*/
if (!alive player) exitWith {};

if (!canSuspend) exitWith {
    [] spawn ALF_fnc_tuto_openMenu;
};

private _mrpDisp = uiNamespace getVariable ["MRPV2_Interface_Diverse", controlNull];
if (!isNull _mrpDisp) then {
    closeDialog 0;
    private _tLimite = time + 2;
    waitUntil {
        uiSleep 0.05;
        isNull (uiNamespace getVariable ["MRPV2_Interface_Diverse", controlNull]) || {time > _tLimite}
    };
    uiSleep 0.1;
};

private _oldMenu = findDisplay 9903;
if (!isNull _oldMenu) then {
    _oldMenu closeDisplay 1;
    uiSleep 0.1;
};

if (!createDialog "ALF_Tuto_Menu") then {
    ["Guide", "Menu tutoriel introuvable : recompilez la mission MRP_Martinique (alftuto.hpp).", "danger"] spawn ALF_fnc_doMsg;
};
