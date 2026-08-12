/*
    File: fn_staff_map_teleport.sqf
    Author: Matthew

    Description
    Function to teleport on the map.
*/

#include "\ALF_Client\script_macros.hpp"

/*
if(ALF_MapTeleportReady) then {
    private _display = findDisplay 98;
    private _control = _display displayCtrl 1016;
    _control ctrlSetTextColor [1,1,1,1];
    ALF_MapTeleportReady = false;
    onMapSingleClick "";
} else {
    closeDialog 0;
    ALF_MapTeleportReady = true;
    onMapSingleClick "_currentPos = getPosATL player;
    (vehicle player) setPosATL _pos;
    onMapSingleClick """";
    openMap false;
    ALF_MapTeleportReady = false;";
    openMap true;
    private _warning = findDisplay 46 ctrlCreate ["RscStructuredText", 9965];
    _warning ctrlSetPosition [0.4 * safezoneW + safezoneX,0.84 * safezoneH + safezoneY,0.2 * safezoneW,0.05 * safezoneH];
    _warning ctrlSetStructuredText parseText "<t color='#ff0000' size='1.5' align='center'>TP ACTIVÉ</t>";
    _warning ctrlCommit 0;
    waitUntil {sleep 1; !ALF_MapTeleportReady};
    ctrlDelete _warning;
};
*/


if (ALF_MapTeleportReady) then {
    private _display = findDisplay 98;
    private _control = _display displayCtrl 1016;
    _control ctrlSetTextColor [1,1,1,1];
    ALF_MapTeleportReady = false;
    onMapSingleClick "";
} else {
    closeDialog 0;
    ALF_MapTeleportReady = true;
    
    onMapSingleClick "
        private _currentPos = getPosATL player;
        (vehicle player) setPosATL _pos;

        [name player, getPlayerUID player, 'ADMIN', format[
            '%1 (%2) s''est téléporté via MapTeleport en %3',
            name player, getPlayerUID player, str _pos
        ]] remoteExec ['ALF_Server_fnc_logIt', 2];

        systemChat format ['[ADMIN LOG] TP effectué à %1.', str _pos];

        onMapSingleClick '''';
        openMap false;
        ALF_MapTeleportReady = false;
    ";

    openMap true;
    
    private _warning = findDisplay 46 ctrlCreate ["RscStructuredText", 9965];
    _warning ctrlSetPosition [
        0.4 * safezoneW + safezoneX,
        0.84 * safezoneH + safezoneY,
        0.2 * safezoneW,
        0.05 * safezoneH
    ];
    _warning ctrlSetStructuredText parseText "<t color='#ff0000' size='1.5' align='center'>TP ACTIVÉ</t>";
    _warning ctrlCommit 0;

    waitUntil { sleep 1; !ALF_MapTeleportReady };
    ctrlDelete _warning;
};
