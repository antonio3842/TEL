// ALF_fnc_setiPhoneRing = {
private _son = ASLToAGL [0,0,0] nearestObject "#soundonvehicle";
deleteVehicle _son;

private _sonnerie = profileNamespace getVariable ["iPhone_Ring",0];
_sonnerie = _sonnerie + 1;
if (_sonnerie > 4) then {_sonnerie = 0;};

playSound format ["iPhoneRing%1",_sonnerie+1];

profileNamespace setVariable ["iPhone_Ring",_sonnerie];
saveProfileNamespace;

if !(isNull (findDisplay 56400)) then 
{
	uiNamespace setVariable ['iphonemenu',5];
	[] call ALF_fnc_menuiPhone;
};
// };