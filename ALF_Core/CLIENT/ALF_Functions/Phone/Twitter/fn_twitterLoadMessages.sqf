[] spawn {
	ALF_Twitter_Controls = [];
	_messages = missionNamespace getVariable ["ALF_Twitter_Messages",[]];
	private _start = diag_tickTime;
	waitUntil { (!(isNull (findDisplay 785460))) || ((diag_tickTime - _start) > 2)  };
	ALF_Twitter_Load = true;
	{
		_x call ALF_fnc_twitterRenderMessages;
	} forEach _messages;
	ALF_Twitter_Load = false;
};