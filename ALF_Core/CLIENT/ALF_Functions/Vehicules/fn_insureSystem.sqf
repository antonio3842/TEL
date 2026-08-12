// ALF_fnc_insureSystem = {
disableSerialization;
if(lbCurSel 2802 isEqualTo -1) exitWith {hint localize "STR_Global_No#ion"};
private _vehicle = lbData[2802,(lbCurSel 2802)];
private _data = parseSimpleArray _vehicle;
_vehicle = (call compile format["%1",_vehicle]) # 0;
private _vid = lbValue[2802,(lbCurSel 2802)];
private _pid = getPlayerUID player;
if(isNil "_vehicle") exitWith {hint localize "STR_Garage_#ion_Error"};
if (_data isEqualTo []) exitWith {["INFO","Erreur lors de la demande d'assurance du véhicule.","warning"] spawn ALF_fnc_doMsg;};

private _insurecount = _data # 5;

private "_p";
if (_insurecount isEqualTo 0) then 
{
	_p = ["NUMBER", ["LifeCfgVehicles", _vehicle, "assurance"]] call ALFTools_Client_Config_fnc_getConfig;
} else 
{
	private _assurenceC = ["NUMBER", ["LifeCfgVehicles", _vehicle, "assurance"]] call ALFTools_Client_Config_fnc_getConfig;
	_p = _assurenceC * (_insurecount + 1);
};

_p = floor _p;

private _exit = false;
private _m = _this # 0;
switch (_m) do 
{
	case 0 : 
	{
		life_axacount = life_axacount - 1;
		[0,_vid,_pid,player] remoteExecCall ["ALF_Server_fnc_insureVehicles",2];
		[name player,_pid,"ASSURANCE",format["A résilié l'assurance de son véhicule personnel numéro # %1.",_vid]] remoteExec ["ALF_Server_fnc_logIt",2];
	};
	case 1 : 
	{
		private _action = [format["Etes-vous sur de vouloir assurer ce véhicule ? Frais d'assurance : %1 €.",_p],"MACIF","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};

		if(_p > life_cash) then {
		private _handle = [_p,false] call ALF_fnc_handleCB;
		if(_handle) exitWith {_exit = true;};
		} else {
		life_cash = life_cash - _p;
		[0] call SOCK_fnc_updatePartial;
		};
		if(_exit) exitWith {};

		life_axacount = life_axacount + 1;
		[1,_vid,_pid,player] remoteExecCall ["ALF_Server_fnc_insureVehicles",2];
		[name player,_pid,"ASSURANCE",format["A assurer son véhicule perso. numéro #%1 pour %2 €.",_vid,_p]] remoteExec ["ALF_Server_fnc_logIt",2];
	};
	case 2 : 
	{
		life_axaprocount = life_axaprocount - 1;
		[2,_vid,_pid,player] remoteExecCall ["ALF_Server_fnc_insureVehicles",2];
		[name player,_pid,"ASSURANCE",format["A résilié l'assurance de son véhicule professionnel numéro # %1.",_vid]] remoteExec ["ALF_Server_fnc_logIt",2];
	};
	case 3 : 
	{
		private _assurenceC = ["NUMBER", ["LifeCfgVehicles", _vehicle, "assurance"]] call ALFTools_Client_Config_fnc_getConfig;
		_p = _assurenceC / 2;
		private _action = [format["Etes-vous sur de vouloir assurer votre véhicule professionnel ? Frais d'assurance : %1 €.",_p],"MACIF","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};

		if(_p > life_cash) then 
		{
			private _handle = [_p,false] call ALF_fnc_handleCB;
			if(_handle) exitWith {_exit = true;};
		} else 
		{
			life_cash = life_cash - _p;
			[0] call SOCK_fnc_updatePartial;
		};
		if(_exit) exitWith {};

		life_axaprocount = life_axaprocount + 1;
		[3,_vid,_pid,player] remoteExecCall ["ALF_Server_fnc_insureVehicles",2];
		[name player,_pid,"ASSURANCE",format["A assuré son véhicule professionnel numéro # %1 pour %2 €.",_vid,_p]] remoteExec ["ALF_Server_fnc_logIt",2];
	};
};
if(_exit) exitWith {};

[15] call SOCK_fnc_updatePartial;
[17] call SOCK_fnc_updatePartial;
closeDialog 0;
// };