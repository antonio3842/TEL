/* Copyright 2023 - Association Get Your Path. All rights reserved */
private ["_display","_texturePath","_tmp","_setOption"];
disableSerialization;
_display = findDisplay 4510;

_texturePath = ["STRING", ["Documents", "textures_base_path"]] call ALFTools_Client_Config_fnc_getConfig;
(_display displayCtrl 4511) ctrlSetText (format ["%1\menu.paa",_texturePath]);

(_display displayCtrl 4515) lbSetCurSel -1;

(_display displayCtrl 4512) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='1.2' color='#ffffff'>Nouveau</t>";
(_display displayCtrl 4513) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='1.2' color='#ffffff'>Reçus</t>";
(_display displayCtrl 4514) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='1.2' color='#ffffff'>Envoyés</t>";
(_display displayCtrl 4516) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='1.2' color='#ffffff'>Afficher</t>";

(_display displayCtrl 4524) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='1.2' color='#ffffff'>Montrer</t>";
(_display displayCtrl 4529) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='1.2' color='#ffffff'>Copier</t>";
(_display displayCtrl 1002) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='1.2' color='#ffffff'>Supprimer</t>";
(_display displayCtrl 4530) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='2.5' color='#ffffff'>Gestion des documents</t>";

_tmp = player getVariable ["documents_temporary",[]];

if ((count _tmp) > 0) then {
    {
        (_display displayCtrl _x) ctrlShow true;
    } forEach [4517,4531,4532];

    _setOption = format ["%1\enveloppe.paa",_texturePath];
    (_display displayCtrl 4531) ctrlSetText _setOption;  
} else {
    {
        (_display displayCtrl _x) ctrlShow false;
    } forEach [4517,4531,4532];
};

[(getPlayerUID player)] remoteExec ["ALF_fnc_getDocuments",2];
