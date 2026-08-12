/*
	File : fn_createEpaveVehicle.sqf
	Author: ALF Team
*/

private _epave = param [0,objnull];
private _type = param [1,0];
private _joueur = param [2,objnull];

switch _type do {

	//Init des variables
	case 0 : {
		if !(_epave getVariable ["ALF_EpaveCasse",false]) then {
		_epave setVariable ["ALF_EpaveCasse",true,true];
		private _vehicules = missionNamespace getVariable ["VehiculeCasse",[]];
		_vehicules pushBack _epave;
		missionNamespace setVariable ["VehiculeCasse",_vehicules,true];
		};
	};

	//Delete VL
	case 1 : {
		_dbInfo = _epave getVariable["dbInfo",[]];
		if(count _dbInfo > 0) then {
			_uid = _dbInfo select 0;
			_plate = _dbInfo select 1;
				_insure = _dbInfo select 2;
				_insurecount = _dbInfo select 3;
			if (_uid in [-1,-2,-3]) then {
		
				if (_uid isEqualTo -1) then {
					_query = format["UPDATE vehicles_cop SET alive='1', active='0', gear='[]', damage='[]' WHERE plate='%1'",_plate];
					[_query,1] call ALF_Server_fnc_asyncCall;
				} else {
				if (_uid isEqualTo -3) then {
				_query = format["UPDATE vehicles_penit SET alive='1', active='0', gear='[]', damage='[]' WHERE plate='%1'",_plate];
				[_query,1] call ALF_Server_fnc_asyncCall;
			} else {
				_query = format["UPDATE vehicles_med SET alive='1', active='0', gear='[]', damage='[]' WHERE plate='%1'",_plate];
				[_query,1] call ALF_Server_fnc_asyncCall;
				};
			};
		
			} else {
				if (_insure >= 2) then {
					_query = format["UPDATE vehicles SET alive='1', active='0', gear='[]', damage='[]' WHERE pid='%1' AND plate='%2'",_uid,_plate];
					[_query,1] call ALF_Server_fnc_asyncCall;
				} else {
					if (_insurecount >= 2) then {
						_query = format["UPDATE vehicles SET alive='0', gear='[]' WHERE pid='%1' AND plate='%2'",_uid,_plate];
						[_query,1] call ALF_Server_fnc_asyncCall;
						private _e = false;
						{
							if((getPlayerUID _epave) isEqualTo _uid) exitWith {
								[] remoteExecCall ["ALF_fnc_removeAxaCount",_epave];
								_e = true;
							};
						} forEach playableUnits;
		
						if !(_e) then {
							[format["UPDATE players SET axacount=axacount-1 WHERE playerid='%1'",_uid],1] call ALF_Server_fnc_asyncCall;
						};
					} else {
						if (_insure isEqualTo 1) then {
							_query = format["UPDATE vehicles SET alive='1', active='0', insure='0', insurecount=(insurecount + 1), gear='[]', damage='[]', insuretime='7' WHERE pid='%1' AND plate='%2'",_uid,_plate];
							[_query,1] call ALF_Server_fnc_asyncCall;
							private _e = false;
							{
									if((getPlayerUID _epave) isEqualTo _uid) exitWith {
										[] remoteExecCall ["ALF_fnc_removeAxaCount",_epave];
										_e = true;
								};
							} forEach playableUnits;
		
							if !(_e) then {
									[format["UPDATE players SET axacount=axacount-1 WHERE playerid='%1'",_uid],1] call ALF_Server_fnc_asyncCall;
							};
						} else {
							_query = format["UPDATE vehicles SET alive='0', gear='[]' WHERE pid='%1' AND plate='%2'",_uid,_plate];
							[_query,1] call ALF_Server_fnc_asyncCall;
						};
					};
				};
			};
		};
		if(!isNil "_epave" && {!isNull _epave}) then {
				{
				detach _epave;
				deleteVehicle _epave;
			} forEach (attachedObjects _epave);
			deleteVehicle _epave;
			["INFO","Le véhicule vient d'être envoyé à la casse.","success"] remoteExec ["ALF_fnc_doMsg",_joueur];
		};
	};
};
