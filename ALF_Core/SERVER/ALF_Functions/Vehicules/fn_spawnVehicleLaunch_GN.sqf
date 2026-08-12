//Veh Cop						0     	 1      2      3        4    	5      	6	   7 
private _requete = ["SELECT classname, plate, gear, position, fuel, damage, type, peinture FROM vehicles_cop WHERE active = '1' AND alive = '1'",2,true] call ALF_Server_fnc_asyncCall;
requete = _requete;
publicVariable "requete";
if (count _requete > 0) then 
{
	 diag_log format ["Query Success: Loaded %1 Cop vehicles.", count _requete];
	{
		private _valeur = _x;
		private _plaque = _valeur # 1;		

		private _pos_Dir = [_valeur # 3] call ALF_Server_fnc_mresToArray;
		if(_pos_Dir isEqualType "") then {_pos_Dir = call compile format["%1", _pos_Dir];};

		private _carbu = _valeur # 4;

		private _damage = [_valeur # 5] call ALF_Server_fnc_mresToArray;
		if(_damage isEqualType "") then {_damage = call compile format["%1", _damage];};

		private _pos = _pos_Dir # 0;
		private _dir = _pos_Dir # 1;

        diag_log format["VEHICULE COP : %1", _valeur];

		private _veh = (_valeur # 0) createVehicle [0,0,1000];
		_veh allowDamage false;
		_veh enableSimulation false;

		if(_veh isKindOf "Ship") then 
		{
			_veh setPosATL [_pos # 0,_pos # 1,1];
		} else 
		{
			_veh setPosATL _pos;
		};

		_veh setDir _dir;
		_veh setFuel _carbu;
		_veh lock 2;

		_veh setVariable ["vehicle_info_owners",["Gendarmerie",""],true];
		_veh setVariable ["dbInfo",[-1,_plaque,1,0,0]];
		_veh setVariable ["Flashed",false];
		_veh enableDynamicSimulation true;
		_veh disableTIEquipment true;
		[_veh,TRUE] remoteExec ["lockInventory",0,true];	

		[_veh,_valeur # 2] spawn MRPV2_Server_fnc_Vehicule_Inventaire_Chargement;

		if((_valeur # 0) in ["V_ALF_Megane_G_Gendarmerie","V_ALF_Berlingo_Gendarmerie","V_ALF_Subaru_Gendarmerie","V_ALF_GIGN","V_ALF_Titan_Gendarmerie","V_ALF_DV15_Gendarmerie","V_ALF_Vito_Gendarmerie"]) then {
			_veh setVariable ["TF_RadioType", "alf_megaphone", true];
			{_veh setHit[_x,1];} forEach ["lightg01_h","lightg02_h","lightg03_h","lightg04_h","lightg05_h","lightg06_h","lightg07_h","lightg08_h"];
		};

		if(_veh isKindOf "Air") then 
		{
			_veh setVariable ["TF_RadioType", "alf_radioheli", true];
			private _freq = random[1000, 5000, 9999];
			_veh setVariable ["helicofreq", _freq, true];
		};

		private _arr = missionNamespace getVariable ["GENDARMERIE_KEYS",[]];
		_arr pushBack _veh;
		_arr = _arr - [objNull];
		missionNamespace setVariable["GENDARMERIE_KEYS",_arr];
		
		[_veh] spawn {params ["_veh"]; sleep 2; _veh allowDamage true;}; 
		_veh enableSimulation true;

		if (count _damage > 0) then 
		{
			private _parts = getAllHitPointsDamage _veh;

			{
				_veh setHitPointDamage [format["%1",((_parts # 0) # _forEachIndex)],_x];
			} forEach _damage;
		};

		_veh animateSource ["assu", 0, true];
		_veh animateSource ["tracker", 1, true];

		[_valeur,_veh] spawn
		{params ["_valeur", "_veh"];
			private _peinture = _valeur # 7;
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
						diag_log format ["[spawnVehicleLaunch_GN] peinture invalide ignorée plate=%1 raw=%2", _valeur # 1, _rawPeinture];
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

		_veh setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 0]];
		_veh setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 1]];
		_veh setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 3]];
		_veh setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 4]];
		_veh setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 5]];
		_veh setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 7]];
		_veh setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 8]];
	} forEach _requete;
};
