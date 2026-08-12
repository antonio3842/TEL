// ALF_fnc_setiPhoneBackGround = {
disableSerialization;
private _display = findDisplay 56400;
private _bg = _display displayCtrl 564001;
_bg ctrlShow true;

private _fond_Ecran = profileNamespace getVariable ["iPhone_Background",0];
_bg ctrlSetText format ["\ALF_Client2\textures\iPhone\ALF_fond_%1.paa",_fond_Ecran + 1];
// };