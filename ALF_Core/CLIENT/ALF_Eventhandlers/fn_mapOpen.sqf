// /*

// Copyright 2023

// Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

// Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

// More information at kainnon@getyourpath.fr

// All rights reserved.

// */

//ALF_fnc_mapOpen = 
//{

waitUntil {visibleMap};

private _markers 	= [];
private _array		= [];
private _marker		= "";
private _name		= "";
private _unit       = objNull;

private _radio = tolower (call TFAR_fnc_activeSwRadio);

[] call
{
	private _pos = getPosATL player;
  	mapAnimAdd [0.1, 0.1, _pos];
  	mapAnimCommit;
  
	//Admin.
	if (alf_admin_btn) then
	{
		{
			_name = name _x;
			_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
			_marker setMarkerTypeLocal "Mil_dot";

			if (_x getVariable ["adminmarker",false] && {ALF_AdminLevel > 2}) then 
			{
				_marker setMarkerColorLocal "ColorOrange";
				_marker setMarkerTextLocal format["ADMIN MARKER - %1 - %2",_name, _x getVariable ["ALF_CurrentNameTFAR", ""]];
			} else 
			{
				if (_x getVariable ["ReviveMedic",false]) then 
				{
					_marker setMarkerColorLocal "ColorCivilian";
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

			_markers pushBack [_marker, _x];

		} forEach playableUnits;
	};

	//B4 et B18
	if ((b_4 || b_18) && b_enService) then
	{
		//Fourrière
		_array = missionNamespace getVariable ["VehiculeImmobiliser",[]];
		{
			if (isNull _x) then 
			{
				_array deleteAt _forEachIndex;
			} else 
			{
				_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
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
		if !(count _array isEqualTo count (missionNamespace getVariable ["VehiculeImmobiliser",[]])) then 
		{
			missionNamespace setVariable ["VehiculeImmobiliser",_array,true];
		};
		
		//CASSE
		_array = missionNamespace getVariable ["VehiculeCasse",[]];
		{
			if (isNull _x) then 
			{
				_array deleteAt _forEachIndex;
			} else 
			{
				_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
				_marker setMarkerColorLocal "ColorOrange";
				_marker setMarkerTypeLocal "Mil_dot";
				_marker setMarkerTextLocal "Epave";
				_markers pushBack [_marker,_x];
			};
		} forEach _array;
		if !(count _array isEqualTo count (missionNamespace getVariable ["VehiculeCasse",[]])) then 
		{
			missionNamespace setVariable ["VehiculeCasse",_array,true];
		};
	};

	if (b_18 && b_enService) then {
		private _data = missionNamespace getVariable [
			"MRP_dirObj_currentWreck",
			[objNull, false]
		];

		_data params ["_obj", "_actif"];

		if (!isNull _obj && {_obj != objNull} && {_actif}) then {
			private _posObj = getPos _obj;
			private _marker = createMarkerLocal ["DirObj_marker", _posObj];
			_marker setMarkerColorLocal "ColorOrange";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerTextLocal "Objet sur les voies !";
			_markers pushBack [_marker, _obj];
		};
	};

	if (MRP_Bie_EnService) then {
		_array = missionNamespace getVariable ["listePanne", []];
		{
			if (isNull _x) then 
			{
				_array deleteAt _forEachIndex;
			} else 
			{
				_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
				_marker setMarkerColorLocal "ColorOrange";
				_marker setMarkerTypeLocal "Mil_dot";
				_marker setMarkerTextLocal "Objet en panne";
				_markers pushBack [_marker,_x];
			};
		} forEach _array;
	};
	
	if (MRP_Bie_EnService || (b_18 && b_enService)) then {
		{
			if (((_x) animationSourcePhase "disable_source") > 0.5) then {
            _marker = createMarkerLocal [format ["Trafo_%1", round(random(1000))], (getpos _x)];
            _marker setMarkerTypeLocal "hd_dot";
            _marker setMarkerTextLocal "!! Transfo COUPER !!";
            _marker setMarkerColorLocal "ColorRed";
            _markers pushBack [_marker,_x];
        } else {
            _marker = createMarkerLocal [format ["Trafo_%1", round(random(1000))], (getpos _x)];
            _marker setMarkerTypeLocal "hd_dot";
            _marker setMarkerTextLocal "Transfo En marche";
            _marker setMarkerColorLocal "ColorGreen";
            _markers pushBack [_marker,_x];
			};
			
		} forEach [ALF_BIE_SECTEUR_1,ALF_BIE_SECTEUR_2,ALF_BIE_SECTEUR_3,ALF_BIE_SECTEUR_4];
	};

	if (MRP_Eboueur_EnService) then {
		private _zone = player getVariable ["MRP_Eboueur_Zone", ""];
		private _listePoub = format ["MRP_EBOUEUR_POUBELLES%1", _zone];
		_array = missionNamespace getVariable [_listePoub, []];
		{
			if (isNull _x) then 
			{
				_array deleteAt _forEachIndex;
			} else 
			{
				_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
				_marker setMarkerColorLocal "ColorOrange";
				_marker setMarkerTypeLocal "Mil_dot";
				_marker setMarkerTextLocal "Poubelle";
				_markers pushBack [_marker,_x];
			};
		} forEach _array;
	};

	//Pénit
	if (life_penit_service) then
	{
				_array = missionNamespace getVariable ["ALF_AllBracelets",[]];
		{
			if (isNull _x) then 
			{
				_array deleteAt _forEachIndex;
			} else 
			{
				_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
				if (_x getVariable ["ALF_EnPrison",false]) then 
				{
					_marker setMarkerColorLocal "ColorKhaki";
				} else 
				{
					_marker setMarkerColorLocal "ColorRed";
				};
				_marker setMarkerTypeLocal "Mil_dot";
				_marker setMarkerTextLocal format ["Bracelet Electronique : %1",name _x];
				_markers pushBack [_marker,_x];
			};
		} forEach _array;
		if !((count _array) isEqualTo (count (missionNamespace getVariable ["ALF_AllBracelets",[]]))) then 
		{
			missionNamespace setVariable ["ALF_AllBracelets",_array,true];
		};
	};

	//Gendarme 
	if (life_gendarme_service && {"alf_neogend" in _radio}) then
	{
		if (player distance (nearestObject [position player,"Land_mrp_gendarmerie_principale"]) < 100 || {player distance (nearestObject [position player,"Land_mrp_gendarmerie_e"]) < 100} || {player distance (nearestObject [position player,"Land_MRP_gendarmerie2"]) < 100} || {player distance (nearestObject [position player,"Land_MRP_Caserne_GN"]) < 100} || {alf_gendarmerie_command}) then 
		{
			private _groupe_GN = (groups civilian select {"Gendarmerie" in groupid _x}) # 0;
			if !(isnil {_groupe_GN}) then 
			{
				{
					private _rL = _x call TFAR_fnc_radiosList;
					private _n = false;
					{if ("alf_neogend" in _radio) then {_n = true;};} forEach _rL;
					if (_n && {!(_x isEqualTo player)}) then 
					{
						_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
						_marker setMarkerColorLocal "ColorBLUFOR";
						_marker setMarkerTypeLocal "Mil_dot";
						_name = switch (_x getVariable ["SonyFreq",0]) do 
                        {
                            case 31 : {"Gendarme (PAM FDF)";};
                            case 32 : {"Gendarme (PAM TRINITE)";};
                            case 33 : {"Gendarme (PAM ST-PIERRE)";};
                            case 34 : {"Gendarme (PAM LE MARIN)";};
                            case 35 : {"Gendarme (CSA)";};
                            case 36 : {"Gendarme (FAGN)";};
                            case 37 : {"Gendarme (DSI 1)";};
                            case 38 : {"Gendarme (DSI 2)";};
                            case 39 : {"Gendarme (PI)";};
                            case 40 : {"Gendarme (PMO 1)";};
                            case 41 : {"Gendarme (PMO 2)";};
                            case 42 : {"Gendarme (ERI)";};
                            case 43 : {"Gendarme (GIC)";};
                            case 44 : {"Gendarme (GIC 2)";};
                            case 45 : {"Gendarme (BRIG. NAUT)";};
                            case 46 : {"Gendarme (OAD)";};
                            case 47 : {"Gendarme (ORC)";};
                            case 48 : {"Gendarme (TICP)";};
                            case 49 : {"Gendarme (DIR 1 CMDT)";};
                            case 50 : {"Gendarme (DIR 2 OPE)";};
                            case 51 : {"Gendarme (DIR 3 FORM)";};
                            default {"Gendarme (Sans unité)"};
                        };
						_marker setMarkerTextLocal format["%1",_name];
						_markers pushBack [_marker,_x];
					};
				} forEach units _groupe_GN;
			};
		};

		_array = missionNamespace getVariable ["VehiculeImmobiliser",[]];
		{
			if (isNull _x) then 
			{
				_array deleteAt _forEachIndex;
			} else 
			{
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

		if !((count _array) isEqualTo (count (missionNamespace getVariable ["VehiculeImmobiliser",[]]))) then 
		{
			missionNamespace setVariable ["VehiculeImmobiliser",_array,true];
		};

		if (license_SR) then 
		{
			_array = missionNamespace getVariable ["VehiculeTracker",[]];
			{
				if (isNull _x) then 
				{
					_array deleteAt _forEachIndex;
				} else 
				{
					private _marker = createMarkerLocal [format["%1_trackergps",_x],visiblePosition _x];
					_marker setMarkerColorLocal "ColorRed";
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
					_marker setMarkerTextLocal format ["Tracker GPS : %1",_pf];
					_markers pushBack [_marker,_x];
				};
			} forEach _array;
			if !((count _array) isEqualTo (count (missionNamespace getVariable ["VehiculeTracker",[]]))) then 
			{
				missionNamespace setVariable ["VehiculeTracker",_array,true];
			};
		};

		_array = missionNamespace getVariable ["ALF_AllBracelets",[]];
		{
			if (isNull _x) then 
			{
				_array deleteAt _forEachIndex;
			} else 
			{
				_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
				_marker setMarkerColorLocal "ColorRed";
				_marker setMarkerTypeLocal "Mil_dot";
				_marker setMarkerTextLocal format ["Bracelet Electronique : %1",name _x];
				_markers pushBack [_marker,_x];
			};
		} forEach _array;
		if !((count _array) isEqualTo (count (missionNamespace getVariable ["ALF_AllBracelets",[]]))) then 
		{
			missionNamespace setVariable ["ALF_AllBracelets",_array,true];
		};

		{
			_marker = createMarkerLocal [format["%1_marker",_x],(_x select 0)];
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerTextLocal format ["Position perdue : %1",(_x select 1)];
			_markers pushBack [_marker,objNull];
		} forEach (missionNamespace getVariable ["ALF_AllPositionBracelets",[]]);
	};

	//Pompier
	if (life_pompier_service && {tolower "alf_SonyPo" in tolower _radio}) then
	{
		private _groupe_SP = (groups civilian select {"Pompiers" in groupid _x}) # 0;
		if (!isnil {_groupe_SP}) then  
		{
			{
				private _rL = _x call TFAR_fnc_radiosList;
				private _n = false;
				{if("alf_SonyPo" in _radio) then {_n = true;};} forEach _rL;
				if (_n && {!(_x isEqualTo player)}) then 
				{
					private _marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
					_marker setMarkerColorLocal "ColorIndependent";
					_marker setMarkerTypeLocal "Mil_dot";
					private _name = switch (_x getVariable ["SonyFreq",0]) do 
					{
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
					_markers pushBack [_marker,_x];
				};
			} forEach units _groupe_SP;
		};

		_units = playableUnits select {(_x getVariable ["ReviveMedic",false]) && (_x getVariable ["requestMedic",false])};
		{
			_marker = createMarkerLocal [format["%1_dead_marker",_x],visiblePosition _x];
			_marker setMarkerColorLocal "ColorWhite";
			_marker setMarkerTypeLocal "MRPV2_urgence_icon";
			_marker setMarkerTextLocal "DEMANDE D'URGENCE";
			_markers pushBack [_marker,_x];
		} forEach _units;
		{
			_marker = createMarkerLocal [_x select 0,_x select 1];
			_marker setMarkerColorLocal (_x select 2);
			_marker setMarkerTypeLocal (_x select 4);
			_marker setMarkerTextLocal (_x select 3);
			_markers pushBack [_marker,objNull];
		} forEach byscream_fires_marker;
	};

	if ("ItemGPS" in assignedItems player) then
	{
		_marker = createMarkerLocal ["MRPV2_Marqueur_GPS_Joueur",visiblePosition player];
		_marker setMarkerColorLocal "ColorRed";
		_marker setMarkerTypeLocal "Select";
		_markers pushBack [_marker,player];
	};
};

for "_i" from 0 to 1 step 0 do 
{
	if(!visibleMap) exitWith {};
	{	
		_marker = _x param[0, "", [""]];
		_unit 	= _x param[1, objNull, [objNull]];

		if(!isNil "_unit" && {!isNull _unit}) then {_marker setMarkerPosLocal (visiblePosition _unit);};
	} forEach _markers;	
	uiSleep 0.04;
};

{deleteMarkerLocal (_x select 0);} forEach _markers;

_markers 	= [];
_array		= [];
_marker		= "";
_name		= "";
_unit 		= objNull;
//};
