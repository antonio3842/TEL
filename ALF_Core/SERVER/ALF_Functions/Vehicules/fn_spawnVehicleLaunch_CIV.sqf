// ALF_Server_fnc_spawnVehicleLaunch_CIV = {
if !(isServer) exitWith {};
//Veh civ							0       		1    			2     			3        		4     			5      			6				7				8				9              10                   11
private _q = ["SELECT vehicles.classname, vehicles.pid, vehicles.plate, vehicles.gear, vehicles.position, vehicles.fuel, vehicles.damage, vehicles.insure, players.name, vehicles.type, vehicles.insurecount, vehicles.peinture
FROM vehicles
INNER JOIN players
WHERE players.playerid = vehicles.pid
AND vehicles.active = '1' AND vehicles.alive = '1'",2,true] call ALF_Server_fnc_asyncCall;

if (count _q > 0) then 
{
	{
		private _valeur = _x;
		private _pid = _valeur # 1;
		private _plaque = _valeur # 2;

		private _ps = [_valeur # 4] call ALF_Server_fnc_mresToArray;
		if(_ps isEqualType "") then {_ps = call compile format["%1", _ps];};		

		private _damage = [_valeur # 6] call ALF_Server_fnc_mresToArray;
		if(_damage isEqualType "") then {_damage = call compile format["%1", _damage];};

		private _sp = _ps select 0;
		private _dir = _ps select 1;
		private _in = _valeur # 7;
		private _incount = _valeur # 10;

        diag_log format["VEHICULE CIV : %1", _valeur];

		private _veh = (_valeur # 0) createVehicle [0,0,1000];
		_veh allowDamage false;
		_veh setDir _dir;
		if(_veh isKindOf "Ship") then 
		{
			_veh setPosATL [_sp select 0,_sp select 1,1];
		} else 
		{
			_veh setPosATL _sp;
		};

		private _f = _valeur # 5;
		_veh setFuel _f;
		_veh lock 2;

		private _n = _valeur # 8;
		_veh setVariable ["vehicle_info_owners",["",_pid],true];
		_veh setVariable ["dbInfo",[_pid,_plaque,_in,_incount,0]];
		_veh setVariable ["Flashed",false];
		_veh enableDynamicSimulation true;
		_veh disableTIEquipment true;
		[_veh,TRUE] remoteExec ["lockInventory",0,true];

		[_veh,_valeur # 3] spawn MRPV2_Server_fnc_Vehicule_Inventaire_Chargement;

		if((_valeur # 0) in ["V_ALF_Megane_G_Gendarmerie","V_ALF_Berlingo_Gendarmerie","V_ALF_Subaru_Gendarmerie","V_ALF_GIGN","V_ALF_Titan_Gendarmerie","V_ALF_DV15_Gendarmerie","V_ALF_Vito_Gendarmerie"]) then {
			_veh setVariable ["TF_RadioType", "alf_megaphone", true];
			{_veh setHit[_x,1];} forEach ["lightg01_h","lightg02_h","lightg03_h","lightg04_h","lightg05_h","lightg06_h","lightg07_h","lightg08_h"];
		};

		if(_veh isKindOf "Air") then {
			_veh setVariable ["TF_RadioType", "alf_radioheli", true];
			private _freq = random[1000, 5000, 9999];
			_veh setVariable ["helicofreq", _freq, true];
		};

		/////////////////////////////////	KEYS	/////////////////////////////////////
		if(count(_valeur # 9) isEqualTo 9) then {
			private _arr = missionNamespace getVariable [format["%1_KEYSB",(_valeur # 9)],[]];
			_arr pushBack _veh;
			_arr = _arr - [objNull];
			missionNamespace setVariable[format["%1_KEYSB",(_valeur # 9)],_arr,true];
			_veh setVariable ["business_veh",[_valeur # 9],true];
		} else {
			private _arr = missionNamespace getVariable [format["%1_KEYS",_pid],[]];
			_arr pushBack _veh;
			_arr = _arr - [objNull];
			missionNamespace setVariable[format["%1_KEYS",_pid],_arr];
		};
		//////////////////////////////////////////////////////////////////////////////
		
		[_veh] spawn {params ["_veh"]; sleep 2; _veh allowDamage true;}; 

		if (count _damage > 0) then {
			private _parts = getAllHitPointsDamage _veh;

			{
				_veh setHitPointDamage [format["%1",((_parts select 0) select _forEachIndex)],_x];
			} forEach _damage;
		};

		if (_in > 0) then 
		{
			_veh animateSource ["assu", 0, true];
		} else 
		{
			_veh animateSource ["assu", 1, true];
		};

		_veh animateSource ["tracker", 1, true];

		[_valeur,_veh] spawn
		{params ["_valeur", "_veh"];
			private _peinture = _valeur # 11;
			if (_peinture isEqualType "") then {
				private _rawPeinture = trim _peinture;
				private _parsedPeinture = [];

				if (
					(count _rawPeinture > 1) &&
					{(_rawPeinture select [0,1]) isEqualTo """} &&
					{(_rawPeinture select [(count _rawPeinture) - 1,1]) isEqualTo """}
				) then {
					_rawPeinture = trim (_rawPeinture select [1, (count _rawPeinture) - 2]);
				};

				if (
					(count _rawPeinture >= 7) &&
					{(_rawPeinture select [0,2]) isEqualTo "["""} &&
					{(_rawPeinture select [(count _rawPeinture) - 2,2]) isEqualTo """]"}
				) then {
					private _body = _rawPeinture select [2, (count _rawPeinture) - 4];
					private _sepIndex = _body find """,""";
					if (_sepIndex > -1) then {
						private _textureParsed = _body select [0, _sepIndex];
						private _materialParsed = _body select [_sepIndex + 3, (count _body) - (_sepIndex + 3)];
						_parsedPeinture = [_textureParsed, _materialParsed];
					};
				};

				if (count _parsedPeinture isEqualTo 2) then {
					_peinture = _parsedPeinture;
				} else {
					if (_rawPeinture isNotEqualTo "" && {_rawPeinture isNotEqualTo "[]"}) then {
						diag_log format ["[spawnVehicleLaunch_CIV] peinture invalide ignorée plate=%1 raw=%2", _valeur # 2, _rawPeinture];
					};
					_peinture = [];
				};
			};

			if (tolower (typename _peinture) isEqualTo (tolower "array") AND {count _peinture isequalto 2}) then 
			{
				private _textureIndex = 0;
				if ("_mrp_" in tolower (typeof _veh)) then {_textureIndex = 11;};

				private _texture = _peinture param [0, ""];
				private _material = _peinture param [1, ""];
				if (_texture isEqualType "" && {_texture != ""}) then {_veh setObjectTextureGlobal [_textureIndex, _texture];};
				if (_material isEqualType "" && {_material != ""}) then {_veh setObjectMaterialGlobal [_textureIndex, _material];};
			};			
		};

		[_veh,_plaque] remoteExec ["setPlateNumber",owner _veh];
		_plaque = _plaque splitString "";

		_veh setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque select 0]];
		_veh setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque select 1]];
		_veh setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque select 3]];
		_veh setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque select 4]];
		_veh setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque select 5]];
		_veh setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque select 7]];
		_veh setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque select 8]];
	} forEach _q;
};
// };[] call ALF_Server_fnc_spawnVehicleLaunch_CIV;
