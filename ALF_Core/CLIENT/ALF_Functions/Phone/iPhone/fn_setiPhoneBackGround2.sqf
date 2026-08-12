// ALF_fnc_setiPhoneBackGround2 = {
private "_background";

private _id_Fond_Ecran = profileNamespace getVariable ["iPhone_Background",0];
_id_Fond_Ecran = _id_Fond_Ecran + 1;
if (_id_Fond_Ecran > 16) then {_id_Fond_Ecran = 0;};

profileNamespace setVariable ["iPhone_Background",_id_Fond_Ecran];
saveProfileNamespace;

if !(isNull (findDisplay 56400)) then 
{
	uiNamespace setVariable ['iphonemenu',5];
	[] call ALF_fnc_menuiPhone;
};
// };