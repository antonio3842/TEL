if (isnil {call TFAR_fnc_ActiveSwRadio}) exitwith {};

private _liste_Action_Appel_TFAR = ["SWTransmit","SWTransmitAdditional","LRTransmit","LRTransmitAdditional"];
private _liste_Action_Stereo_TFAR = ["SWStereoBoth","SWStereoLeft","SWStereoRight","LRStereoBoth","LRStereoLeft","LRStereoRight"];
private _liste_Action_Cannaux_TFAR = ["SWChannel1","SWChannel2","SWChannel3","SWChannel4","SWChannel5","SWChannel6","SWChannel7","SWChannel8"];
private _liste_Action_Menu_TFAR = ["OpenSWRadioMenu","OpenLRRadioMenu"];
private _liste_Action_Cycle_Radio = ["CycleSRRadiosNext","CycleSRRadiosPrev","CycleLRRadiosNext","CycleLRRadiosPrev","CycleSRRadioChannelNext","CycleSRRadioChannelPrev","CycleLRRadioChannelNext","CycleLRRadioChannelPrev"];
private _liste_Action_Final = (_liste_Action_Appel_TFAR + _liste_Action_Stereo_TFAR + _liste_Action_Cannaux_TFAR + _liste_Action_Menu_TFAR + _liste_Action_Cycle_Radio);

{
	private _raccourcis = _x;

	private _configuration_Raccourcis_TFAR = ["TFAR",_raccourcis] call CBA_fnc_getKeybind;
	_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
	_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
	_configuration_Raccourcis_TFAR set [8,TRUE];

	_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;
} foreach _liste_Action_Final;

if !(isnil {(call TFAR_fnc_ActiveSwRadio)}) then
{
	[(call TFAR_fnc_ActiveSwRadio),""] call TFAR_fnc_setSwFrequency;
};

TRUE