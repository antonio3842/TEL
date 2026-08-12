/*
	File: fn_checkaxa.sqf
	Author: ALF Team
*/
private _acp = ["SELECT playerid, axacount FROM players WHERE axa > 0",2,true] call ALF_Server_fnc_asyncCall;
if(count _acp > 0) then {
	{
		private _acuid = _x select 0;
		private _axac = _x select 1;
		private _ac = ([format["SELECT COUNT(*) FROM vehicles WHERE pid='%1' AND insure='1'",_acuid],2] call ALF_Server_fnc_asyncCall) select 0;
		if !(_ac isEqualTo _axac) then {
			[format["UPDATE players SET axacount='%1' WHERE playerid='%2'",_ac,_acuid],1] call ALF_Server_fnc_asyncCall;
		};
	} forEach _acp;
};

/*
private _p = ["SELECT playerid, isPremium FROM players WHERE axa='4'",2,true] call ALF_Server_fnc_asyncCall;
if (count _p > 0) then {
	{
		private _uid = _x select 0;
		private _premium = _x select 1;
		private _limit = 10;
		if (_premium isEqualTo "1") then {
			_limit = 20;
		};

		[format["UPDATE players SET axa='3' WHERE playerid='%1'",_uid],1] call ALF_Server_fnc_asyncCall;

		private _c = ([format["SELECT COUNT(*) FROM vehicles WHERE pid='%1' AND insure='1'",_uid],2] call ALF_Server_fnc_asyncCall) select 0;

		if (_c > _limit) then {
			private _q = [format["SELECT id FROM vehicles WHERE pid='%1' AND insure='1'",_uid],2,true] call ALF_Server_fnc_asyncCall;
			private _n = 0;
			{
				_n = _n + 1;
				if (_n > _limit) then {
					[format["UPDATE vehicles SET insure='0' WHERE id='%1'",_x select 0],1] call ALF_Server_fnc_asyncCall;
				};
			} forEach _q;

			[format["UPDATE players SET axacount='%2' WHERE playerid='%1'",_uid,_limit],1] call ALF_Server_fnc_asyncCall;
		};
	} forEach _p;
};
*/


private _p = ["SELECT playerid, isPremium FROM players WHERE axa='4'",2,true] call ALF_Server_fnc_asyncCall;

if (count _p > 0) then {
    {
        private _uid      = _x select 0;
        private _premium  = _x select 1;
        
        private _limit = 10;
        if (_premium isEqualTo 1) then {
            _limit = 20;
        };

        if (_premium isEqualTo 0) then {
            [format["UPDATE players SET axa='3' WHERE playerid='%1'",_uid],1] call ALF_Server_fnc_asyncCall;
        };

        private _c = ([format["SELECT COUNT(*) FROM vehicles WHERE pid='%1' AND insure='1'",_uid],2] call ALF_Server_fnc_asyncCall) select 0;

        if (_c > _limit) then {
            private _q = [format["SELECT id FROM vehicles WHERE pid='%1' AND insure='1'",_uid],2,true] call ALF_Server_fnc_asyncCall;
            private _n = 0;
            {
                _n = _n + 1;
                if (_n > _limit) then {
                    [format["UPDATE vehicles SET insure='0' WHERE id='%1'",_x select 0],1] call ALF_Server_fnc_asyncCall;
                };
            } forEach _q;

            [format["UPDATE players SET axacount='%2' WHERE playerid='%1'",_uid,_limit],1] call ALF_Server_fnc_asyncCall;
        };
    } forEach _p;
};