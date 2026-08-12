// ALF_fnc_escInterupt = {
private["_abortButton","_respawnButton","_fieldManual","_escSync"];
disableSerialization;
params [["_display",displayNull,[displayNull]]];

if (isNull _display) exitWith {};

_escSync = 
{
	private["_abortButton","_thread","_syncManager"];
	disableSerialization;

	_syncManager = 
	{
		disableSerialization;
		private["_abortButton","_timeStamp"];
		_abortButton = ((findDisplay 49) displayCtrl 104);

		private _temps = 10;
		if ("dev" in tolower str servername) then {_temps = 0;};
		_timeStamp = time + _temps;

		waitUntil 
		{
			_abortButton ctrlSetText format[localize "STR_NOTF_AbortESC",[(_timeStamp - time),"SS.MS"] call BIS_fnc_secondsToString];
			_abortButton ctrlCommit 0;
			round(_timeStamp - time) <= 0 OR isNull (findDisplay 49)
		};

		_abortButton ctrlSetText localize "STR_DISP_INT_ABORT";
		_abortButton ctrlCommit 0;
	};

	_abortButton = ((findDisplay 49) displayCtrl 104);

	_thread = [] spawn _syncManager;
	waitUntil{scriptDone _thread OR {isNull (findDisplay 49)}};
	_abortButton ctrlEnable true;
};

_abortButton = _display displayCtrl 104;
_abortButton buttonSetAction "if(life_session_completed) then {[] call SOCK_fnc_updateRequest;}; [player] remoteExec [""ALF_Server_fnc_cleanupRequest"",2];";
_respawnButton = _display displayCtrl 1010;
_fieldManual = _display displayCtrl 122;

_abortButton ctrlEnable false;
_respawnButton ctrlEnable false;
_respawnButton ctrlSetText "REBOOT : 3H|14H|19H";
_respawnButton ctrlCommit 0;
_fieldManual ctrlEnable false; 
_fieldManual ctrlSetText "MARTINIQUE-ROLEPLAY.FR";
_fieldManual ctrlCommit 0;

[] spawn _escSync;

// Sauvegarde automatique du gear quand ESC est presse (avant deconnexion potentielle)
if (!isNil "life_session_completed" && {life_session_completed}) then {
    [2] spawn SOCK_fnc_updatePartial;
};
// };