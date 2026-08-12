/*
	File: fn_priseService.sqf
	ALF NiiRoZz
*/
params [
	["_mode",-1,[0]]
];
if (_mode isEqualTo -1) exitWith {};

switch (_mode) do 
{
	case 0: 
	{ 		
		if (isRemoteExecuted) then 
		{
			private _groupe_GN = (groups civilian select {"Gendarmerie" in groupid _x}) # 0;
			if (!isnil {_groupe_GN} AND {_x in units _groupe_GN}) then 
			{
				{
					_x setVariable ["SonyFreq",(_x getVariable ["SonyFreq",0]),(remoteExecutedOwner)];
					_x setVariable ["SonyFreqAdd",(_x getVariable ["SonyFreqAdd",0]),(remoteExecutedOwner)];
				} forEach units _groupe_GN;
			};
		};
	};
	case 1: 
	{
		if (isRemoteExecuted) then 
		{
			private _groupe_SP = (groups civilian select {"Pompiers" in groupid _x}) # 0;
			if (!isnil {_groupe_SP} AND {_x in units _groupe_SP}) then 
			{
				{
					_x setVariable ["SonyFreq",(_x getVariable ["SonyFreq",0]),(remoteExecutedOwner)];
					_x setVariable ["SonyFreqAdd",(_x getVariable ["SonyFreqAdd",0]),(remoteExecutedOwner)];
				} forEach units _groupe_SP;
			};
		};
	};
	case 2: 
	{
		private _units = playableUnits select {_x getVariable ["PenitService",false]};
		missionNamespace setVariable ["ALF_AllPenits",_units,(_units apply {_x getVariable ["ALF_ownerID",2]})];
		if (isRemoteExecuted) then {
			{
				_x setVariable ["SonyFreq",(_x getVariable ["SonyFreq",0]),(remoteExecutedOwner)];
				_x setVariable ["SonyFreqAdd",(_x getVariable ["SonyFreqAdd",0]),(remoteExecutedOwner)];
			} forEach _units;
		};
	};
	default { };
};