/* Copyright 2023 - Association Get Your Path. All rights reserved */
params [
    ["_type",-1,[0]],
    ["_createDialog",false,[false]]
];

private _sendername = name player;
if (_type isEqualTo -1) exitWith {};
disableSerialization;

if (_createDialog) then {
    createDialog "Documents_Documents";
};

_display = findDisplay 6510;

_array = player getVariable ["document_create",[]];

_curConfig = _array select 0;
_expiration = _array select 1;
_text = _array select 2;
_unit = _array select 3;

_namestr = (name player) splitString " ";
_str = (name _unit) splitString " ";

private _config = ["CLASS", ["Documents", "types_documents", _curConfig]] call ALFTools_Client_Config_fnc_getConfig;

_returnClass = [["Documents", "types_documents", _curConfig]] call ALFTools_Client_Config_fnc_isClass;
if !(_returnClass) exitWith {};

private _displayName = ["STRING", ["displayName"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _displayType = ["STRING", ["type"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _texture = ["STRING", ["texture"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _logo = ["STRING", ["logo"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _signature = ["STRING", ["signature"], _config] call ALFTools_Client_Config_fnc_getConfig;

private _texturePath = ["STRING", ["Documents", "textures_base_path"]] call ALFTools_Client_Config_fnc_getConfig;
(_display displayCtrl 6511) ctrlSetText (format ["%1\%2",_texturePath,_texture]);
(_display displayCtrl 6512) ctrlSetText (format ["%1\%2",_texturePath,_logo]);

(_display displayCtrl 6513) ctrlSetStructuredText parseText format ["<t align='center' color='#000000' size='2.5'>%1</t>",_displayName];
(_display displayCtrl 6514) ctrlSetStructuredText parseText format ["<t align='center' color='#797979'>%1</t>",_displayType];

(_display displayCtrl 6515) ctrlSetStructuredText parseText ("<t align='center' color='#ffffff' size='1.5'>INFORMATIONS</t>");

(_display displayCtrl 6516) ctrlSetStructuredText parseText format ["<t align='center' color='#000000'>Nom : </t><t color='#797979' align='center'>%1</t>",(_namestr select 1)];
(_display displayCtrl 6518) ctrlSetStructuredText parseText format ["<t align='center' color='#000000'>Prénom : </t><t color='#797979' align='center'>%1</t>",(_namestr select 0)];

(_display displayCtrl 6520) ctrlSetStructuredText parseText "<t align='center' color='#ffffff' size='1.5'>AUTORISE</t>";
(_display displayCtrl 6521) ctrlSetStructuredText parseText format ["<t align='center' color='#000000'>%1</t>",(_str select 1)];
(_display displayCtrl 6522) ctrlSetStructuredText parseText "<t align='center' color='#000000'>Nom :</t>";
(_display displayCtrl 6523) ctrlSetStructuredText parseText format ["<t align='center' color='#000000'>%1</t>",(_str select 0)];
(_display displayCtrl 6524) ctrlSetStructuredText parseText "<t align='center' color='#000000'>Prénom :</t>";

if (_expiration isEqualTo 0) then {
    (_display displayCtrl 6525) ctrlSetStructuredText parseText "<t align='center' color='#000000'>Jamais</t>";
} else {
    (_display displayCtrl 6525) ctrlSetStructuredText parseText format ["<t align='center' color='#000000'>%1 <t color='#000000'>jour(s)</t></t>",_expiration];
};

(_display displayCtrl 6526) ctrlSetStructuredText parseText "<t align='center' color='#000000'>Date d'expiration :</t>";
(_display displayCtrl 6527) ctrlSetStructuredText parseText format ["<t align='center' color='#000000'>%1</t>",_text];
(_display displayCtrl 6528) ctrlSetStructuredText parseText "<t align='center' color='#000000'>Informations complémentaires :</t>";
(_display displayCtrl 6529) ctrlSetStructuredText parseText "<t align='center' color='#ffffff' size='1.5'>TERMES ET SIGNATURE</t>";
(_display displayCtrl 6530) ctrlSetStructuredText parseText "<t color='#000000' size='1'>- Ce document, une fois signé, devient un document juridique officiel.<br/>- En signant ce document, vous êtes légalement lié à son contexte et acceptez toutes les conséquences juridiques qu'il peut générer.<br/>- Chaque copie de ce document, est égale en valeur dans son original. Soyez très prudent lorsque vous donnez des copies.<br/>- Assurez-vous de bien connaître le contenu de ce document avant de signer.<br/>- N'hésitez pas à demander l'aide d'un conseiller juridique avant de signer.</t>";

_control = _display displayCtrl 6527;
_myControlPos = ctrlPosition _control;

_control ctrlSetPosition [(_myControlPos select 0),(_myControlPos select 1),(_myControlPos select 2),(ctrlTextHeight _control)];
_control ctrlCommit 0;

switch (_type) do {
    case 0 : {
        {
            (_display displayCtrl _x) ctrlShow false;
        } forEach [1000,1001,1002];

        (_display displayCtrl 6531) buttonSetAction "[1] spawn ALF_fnc_createDocumentConfirm;";
        ["Information","Cliquez sur la case en bas à droite pour signer le document et l'envoyer.","success"] spawn ALF_fnc_doMsg;
    };

    case 1 : {
        (_display displayCtrl 6531) ctrlSetStructuredText parseText format ["<t align='center' color='#000000' size='2.5'>%1</t>",(name player)];

        {
            (_display displayCtrl _x) ctrlShow true;
        } forEach [1000,1001,1002];

        (_display displayCtrl 6532) ctrlSetText format ["%1\%2",_texturePath,_signature];
        (_display displayCtrl 1000) ctrlSetText format ["%1\bouton.paa",_texturePath];
        (_display displayCtrl 1001) ctrlSetStructuredText parseText "<t font='PuristaBold' align='center' size='1.2' color='#ffffff'>Envoyer</t>";
        (_display displayCtrl 1002) buttonSetAction "[2] spawn ALF_fnc_createDocumentConfirm;";
    };

    case 2 : {
        [_curConfig,(getPlayerUID player),(getPlayerUID _unit),_expiration,_text,(name _unit),(name player),(str playerSide)] remoteExec ["ALF_Server_fnc_insertDocument",2];
        closeDialog 0;

        ["Information",format["Vous avez envoyé le document à %1.",(name _unit)],"success"] spawn ALF_fnc_doMsg;
        ["Nouveau document",format["%1 vous a envoyé un document signé",_sendername],"success"] remoteExec ["ALF_fnc_doMsg",_unit];

        _documentsList = player getVariable ["documents_list",[]];
        _documentsList pushBackUnique (toLower _curConfig);
        player setVariable ["documents_list",_documentsList,true];
    };

    default {};
};
