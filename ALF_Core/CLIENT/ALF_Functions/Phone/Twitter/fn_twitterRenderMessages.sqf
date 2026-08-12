params [
	["_from", name player, [name player]],
	["_content", "", [""]],
	["_at", 0, [0]]
];

private _messageIndex = count ALF_Twitter_Controls;
private _display = findDisplay 785460;

if (isNull _display) exitWith {};

private _bodyCtrl = _display displayCtrl 16199;
private _groupCtrl = _display ctrlCreate ["MessageGroup", 16200 + _messageIndex, _bodyCtrl];
private _metaCtrl = _display ctrlCreate ["MetaCtrl", -1, _groupCtrl];
private _messageCtrl = _display ctrlCreate ["ContentCtrl", -1, _groupCtrl];

_groupCtrl ctrlSetFade 1;
_groupCtrl ctrlCommit 0;

private _timeDelta = diag_tickTime - _at;
private _timeReadable = call {
	if (_timeDelta >= 3600) exitWith { [ round (_timeDelta / 3600), 'heures' ]};
	if (_timeDelta >= 60) exitWith { [ round (_timeDelta / 60), 'minutes' ]};
	[ round _timeDelta, 'secondes' ]
};

_metaCtrl ctrlSetStructuredText parseText format ["%1", _from];
_messageCtrl ctrlSetText _content;

private _lines = ceil ((count _content) / 27);
private _contentHeight = ctrlTextHeight _messageCtrl;

private _height = (ctrlPosition _groupCtrl)#3;
_groupCtrl ctrlSetPositionH (_height + _contentHeight);
_groupCtrl ctrlSetPositionY ((ctrlPosition _bodyCtrl)#3 - (_height + _contentHeight));
_groupCtrl ctrlCommit 0;

_messageCtrl ctrlSetPositionH _contentHeight;
_messageCtrl ctrlCommit 0;


_groupCtrl ctrlSetFade 0;
_groupCtrl ctrlCommit 0.3;
{
	_x ctrlSetPositionY ((ctrlPosition _x)#1 - (ctrlPosition _groupCtrl)#3);
	_x ctrlCommit ([0.3, 0] select ALF_Twitter_Load);
} forEach ALF_Twitter_Controls;

ALF_Twitter_Controls pushBack _groupCtrl;
