params ["_control", "_scroll"];

if (_scroll > 0) then {
	if ((ctrlPosition (ALF_Twitter_Controls#0))#1 > 0) exitWith {};
	// Go Up
	{
		_x ctrlSetPositionY ((ctrlPosition _x)#1 + 0.05);
		_x ctrlCommit 0;
	} forEach ALF_Twitter_Controls;
} else {
	private _display = findDisplay 20843;
	private _bodyCtrl = _display displayCtrl 16199;
	private _lastCtrlPos = ctrlPosition (ALF_Twitter_Controls#((count ALF_Twitter_Controls) - 1));
	if (_lastCtrlPos#1 < ((ctrlPosition _bodyCtrl)#3 - (_lastCtrlPos#3) * 0.85)) exitWith {};
	// Go Down
	{
		_x ctrlSetPositionY ((ctrlPosition _x)#1 - 0.05);
		_x ctrlCommit 0;
	} forEach ALF_Twitter_Controls;
}