/*
	File: fn_medicMarkers.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Marks downed players on the map when it's open.
*/

sleep 0.5;
if (visibleMap) then {
	private _markers 	= [];
	private _units 		= [];
	private _pompiers 	= [];
	private _morts     	= [];
	private _admin     	= [];

	if (alf_admin_btn) then 
	{
		{
			if !(_x isEqualTo player) then {
				private _name = name _x;
				private _marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
				_marker setMarkerTypeLocal "Mil_dot";
				if (_x getVariable ["adminmarker",false] && {ALF_AdminLevel > 2}) then {
					_marker setMarkerColorLocal "ColorOrange";
					_marker setMarkerTextLocal format["ADMIN MARKER - %1 - %2",_name, _x getVariable ["ALF_CurrentNameTFAR", ""]];
				} else {
					if (_x getvariable["ReviveMedic",false]) then {
						_marker setMarkerColorLocal "colorCivilian";
						_marker setMarkerTextLocal format["MORT | %1 - %2",_name, _x getVariable ["ALF_CurrentNameTFAR", ""]];
					} else 
					{
						private _groupe_GN = (groups civilian select {"Gendarmerie" in groupid _x}) # 0;
                        if (!isnil {_groupe_GN} AND {_x in units _groupe_GN}) then 
                        {
							_marker setMarkerColorLocal "ColorBLUFOR";
						} else 
						{
							private _groupe_SP = (groups civilian select {"Pompiers" in groupid _x}) # 0;
							if (!isnil {_groupe_SP} AND {_x in units _groupe_SP}) then  
							{
                            	_marker setMarkerColorLocal "ColorIndependent";
                            } else 
							{
                            	_marker setMarkerColorLocal "ColorRed";
                            };
						};
						_marker setMarkerTextLocal format["%1 - %2",_name, _x getVariable ["ALF_CurrentNameTFAR", ""]];
					};
				};
				_admin pushBack [_marker,_x];
			};
		} forEach playableUnits;
	};

	if (life_pompier_service && {"alf_SonyPo" in _radio}) then 
	{
		private _groupe_SP = (groups civilian select {"Pompiers" in groupid _x}) # 0;
		if (!isnil {_groupe_SP} AND {_x in units _groupe_SP}) then  
		{
			{
				private _rL = _x call TFAR_fnc_radiosList;
				private _n = false;
				{if("alf_SonyPo" in _radio) then {_n = true;};} forEach _rL;
				if (_n && {!(_x isEqualTo player)}) then {
					private _marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
					_marker setMarkerColorLocal "ColorIndependent";
					_marker setMarkerTypeLocal "Mil_dot";
					private _name = switch (_x getVariable ["SonyFreq",0]) do {
						case 61 : {"Pompier (VSAV 1)";};
						case 62 : {"Pompier (VSAV 2)";};
						case 63 : {"Pompier (VSAV 3)";};
						case 64 : {"Pompier (VSAV 4)";};
						case 65 : {"Pompier (FPT 1)";};
						case 66 : {"Pompier (FPT 2)";};
						case 67 : {"Pompier (FPT 3)";};
						case 68 : {"Pompier (EPA 1)";};
						case 69 : {"Pompier (EPA 2)";};
						case 70 : {"Pompier (DRAGON)";};
						case 71 : {"Pompier (BRIG. NAUT)";};
						case 72 : {"Pompier (SMUR 1)";};
						case 73 : {"Pompier (SMUR 2)";};
						case 74 : {"Pompier (SMUR 3)";};
						case 75 : {"Pompier (OP 1)";};
						case 76 : {"Pompier (OP 2)";};
						case 77 : {"Pompier (OFF. PERM)";};
						default{"Pompier (Sans unité)"};
					};
					_marker setMarkerTextLocal format["%1",_name];
					_pompiers pushBack [_marker,_x];
				};
			} forEach units _groupe_SP;
		};

		_units = playableUnits select {(_x getVariable ["ReviveMedic",false]) && (_x getVariable ["requestMedic",false])};
		{
			_marker = createMarkerLocal [format["%1_dead_marker",_x],visiblePosition _x];
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTypeLocal "loc_Hospital";
			_marker setMarkerTextLocal "Civil mourant";
			_morts pushBack _marker;
		} forEach _units;
		{
			_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerTextLocal "!! INCENDIE !!";
			_markers pushBack _marker;
		} forEach ALF_HC_Fire;
	} else {
		if (b_Depanneur) then {
			_array = missionNamespace getVariable ["VehiculeImmobiliser",[]];
			{
				if (isNull _x) then {
					_array deleteAt _forEachIndex;
				} else {
					private _marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
					_marker setMarkerColorLocal "ColorOrange";
					_marker setMarkerTypeLocal "Mil_dot";
					_plaque = [_x] call ALF_fnc_getPlaque;
					_p1 = _plaque select 0;
					_p2 = _plaque select 1;
					_p3 = _plaque select 2;
					_p4 = _plaque select 3;
					_p5 = _plaque select 4;
					_p6 = _plaque select 5;
					_p7 = _plaque select 6;
					_p8 = _plaque select 7;
					_p9 = _plaque select 8;
					_pf = format["%1%2%3%4%5%6%7%8%9",_p1,_p2,_p3,_p4,_p5,_p6,_p7,_p8,_p9];
					_marker setMarkerTextLocal format ["Vehicule Immobilisé : %1",_pf];
					_markers pushBack [_marker,_x];
				};
			} forEach _array;
			if !(count _array isEqualTo count (missionNamespace getVariable ["VehiculeImmobiliser",[]])) then {
				missionNamespace setVariable ["VehiculeImmobiliser",_array,true];
			};
		};
	};

	markerfinal = [];
	markerfinal = _markers + _pompiers + _morts + _admin;
	for "_i" from 0 to 1 step 0 do {
		if(!visibleMap) exitWith {};
		{
			private _markerss = "";
			private _unitss = objNull;
			private _markerss 	= _x param[0, "", [""]];
			private _unitss 	= _x param[1, objNull, [objNull]];
			if(!isNil "_unitss" && {!isNull _unitss}) then {
				if(!isNull _unitss) then {
					_markerss setMarkerPosLocal (visiblePosition _unitss);
				};
			};
		} forEach markerfinal;
		sleep 0.2;
	};	

	{deleteMarkerLocal (_x select 0)} forEach markerfinal;
	_markers = [];
	_units = [];
	_markerss = [];
	_unitss = [];
	markerfinal = nil;
};

