/*
    Fichier : fn_busjob_stopAutoArret.sqf
    Desc    : Arrete la boucle de validation automatique des arrets
*/

if (!isNil "MRP_BusJob_AutoHandle") then {
    if (!scriptDone MRP_BusJob_AutoHandle) then {
        terminate MRP_BusJob_AutoHandle;
    };
};
MRP_BusJob_AutoHandle = scriptNull;
MRP_BusJob_ValidationLock = false;
hintSilent "";
