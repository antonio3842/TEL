// ALF_fnc_pistoletEssence = {
params 
[
	["_mode",-1,[0]],
	["_pompe",objNull,[objNull]],
	["_pistolet","",[""]]
];

if (isNull _pompe OR {_mode isEqualTo -1}) exitWith {};

switch (_mode) do 
{
	case 0: 
	{
		private _station = (nearestObjects [player, ["plp_up_PropaneTankA"], 100]) # 0;
		if (isnil {_station}) exitWith {["Total", "Une erreur vient de ce produire.", "success"] spawn ALF_fnc_doMsg;};

		private _litreStation = _station getVariable ["station_litre",3000];
		if (_litreStation <= 0) exitWith {["Total", "Il n'y a plus d'essence dans la station service.", "success"] spawn ALF_fnc_doMsg;};

		if (currentWeapon player isNotEqualTo "") then 
		{
			life_curWep_h = currentWeapon player;
			player action ["SwitchWeapon", player, player, 100];
			player switchCamera cameraView;
		};

		ALF_activePrisePistolet = true;
		_activeKart = "C_Kart_01_Red_F" createVehicle [0,0,0];
		_activeKart allowDamage false;
		hideObject _activeKart;
		[_activeKart] remoteExecCall ["hideObjectGlobal",2];
		uiSleep 1;

		_activePistoletObj = "ALF_Pistolet_Essence" createVehicle [0,0,0];
		_activePistoletObj setVariable ["ALF_activePistolet",_pistolet,true];
		_activePistoletObj setVariable ["ALF_activePompe",_pompe,true];
		_activePistoletObj allowDamage false;
		_activePistoletObj enableSimulation false;
		_activePistoletObj setPosATL ((getPosATL player) vectorAdd [0,0,1]);
		_activePistoletObj enableRopeAttach true;

		_activeKart enableRopeAttach true;
		_activeKart setPosASL (_pompe modelToWorldWorld ((_pompe selectionPosition (["rope_1","rope_2"] select (_pistolet isEqualTo "pistolet_2"))) vectorAdd [0,0,-1]));
		
		ropeCreate [_activeKart, [0,0,0], _activePistoletObj, "rope_start", 5];

		_pompe animateSource [(["pistolet_1_source","pistolet_2_source"] select (_pistolet isEqualTo "pistolet_2")), 1, true];
		player playActionNow "ALF_Pistolet_Essence";
		_activePistoletObj attachTo [player, [-0.025,0.045,-0.095], "RightHandMiddle1"];
		_activePistoletObj setDir 270;

		uiSleep 0.35;

		{
			_x setObjectTexture [0, "\ALF_Batiments\ALF_Station\proxies\data\Tuyau_Pompe_CO.paa"];
			_x setObjectTexture [1, ""];
			_x setObjectTexture [2, ""];
		} forEach ((player nearObjects ["ropesegment", 25]) + (player nearObjects ["rope", 25]));

		[_activePistoletObj] spawn 
		{
			_activePistoletObj = _this # 0;
			uiSleep 1.5;
			if !(isNull _activePistoletObj) then 
			{
				[2,_activePistoletObj] remoteExecCall ["ALF_fnc_pistoletEssence",0,_activePistoletObj];
			};
		};

		[_pompe,_pistolet] spawn 
		{
			params [
				["_pompe",objNull,[objNull]],
				["_pistolet","",[""]]
			];

			for "_i" from 0 to 1 step 0 do 
			{
				if !(ALF_activePrisePistolet) exitWith {};
				if !(currentWeapon player isEqualTo "") then 
				{
					life_curWep_h = currentWeapon player;
					player action ["SwitchWeapon", player, player, 100];
					player switchCamera cameraView;
				};
				if ([player] call ALF_fnc_checkMenotter OR {[player] call ALF_fnc_checkSurrender}) exitWith {[1,_pompe,_pistolet] spawn ALF_fnc_pistoletEssence;};
				if (_pompe distance2D player >= 5.5) exitWith {[1,_pompe,_pistolet] spawn ALF_fnc_pistoletEssence;};
				_dir = _pompe getRelDir player;
				if ((_pistolet isEqualTo "pistolet_1" AND {_dir <= 180 AND {_dir >= 0}}) OR {_pistolet isEqualTo "pistolet_2" AND {_dir <= 360 AND {_dir >= 180}}}) exitWith 
				{
					[1,_pompe,_pistolet] spawn ALF_fnc_pistoletEssence;
				};
				sleep 0.05;
			};
		};
	};

	case 1: 
	{
		private _activePistoletObj = objNull;
		{
			if ((typeOf _x) isEqualTo "ALF_Pistolet_Essence") exitWith {_activePistoletObj = _x;};
		} forEach (attachedObjects player);
		if (isNull _activePistoletObj) exitWith {};

		private _nombrelitres = _activePistoletObj getVariable ["ALF_NombreLitre",0];
		private _veh = _activePistoletObj getVariable ["ALF_activeVeh",objNull];

		private _price = 0;
		if (_nombrelitres > 0) then 
		{
			private _fuelCost = ["NUMBER", ["Life_Settings", "fuel_cost"]] call ALFTools_Client_Config_fnc_getConfig;
			_price = _nombrelitres * _fuelCost;
		};

		if (_price > 0) then 
		{
			private _exit = false;
			private _handle = false;

			if(_price > life_cash) then 
			{
				_handle = [_price,false] call ALF_fnc_handleCB;
				if(_handle) exitWith {_exit = true;};
			} else 
			{
				life_cash = round (life_cash - _price);
				[0] call SOCK_fnc_updatePartial;
			};

			if (_exit) exitWith 
			{
				["Vidéo surveillance", "Tu es parti sans payer ! Les services de la Gendarmerie sont prévenus !", "danger", false] spawn ALF_fnc_doMsg;
				["COG", format["De COG à l'ensemble des effectifs, véhicule ayant refusé de payer - station service située en %1.",mapGridPosition _pompe]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];

				private _cam = nearestObject[position player,"Land_ALF_Security"];
				if(isNull _cam) exitWith {};
				if(_cam distance player > 100) exitWith {};

				private _hour = date # 3;
				private _min = date # 4;
				if(_min >= 0 AND _min <= 9) then {_min = format["0%1", _min];};

				_plaque = getPlateNumber _veh splitstring "";
				if(isNil "_plaque") exitWith {};

				_p1 = _plaque # 0;
				_p2 = _plaque # 1;
				_p3 = _plaque # 2;
				_p4 = _plaque # 3;
				_p5 = _plaque # 4;
				_p6 = _plaque # 5;
				_p7 = _plaque # 6;
				_p8 = _plaque # 7;
				_p9 = _plaque # 8;

				private _pf = "";
				if ((random 10) < 4) then 
				{
					_pf = format["%1*%2%3%4%5%6%7* - %8 €",_p1,_p3,_p4,_p5,_p6,_p7,_p8,_price];
				} else 
				{
					_pf = format["%1%2%3%4%5%6%7%8%9 - %10 €",_p1,_p2,_p3,_p4,_p5,_p6,_p7,_p8,_p9,_price];
				};

				[_cam,format["%1:%2",_hour,_min],[_pf]] remoteExecCall ["ALF_Server_fnc_setCameraVar",2];
			};

			if (_nombrelitres > 0) then 
			{
				["Station service", format["Vous avez payé votre essence pour %1 €",_price], "success", false] spawn ALF_fnc_doMsg;
			};
		};

		ALF_activePrisePistolet = false;

		ropeDestroy ((ropes _activePistoletObj) # 0);

		_activeKart = nearestObject [_pompe modelToWorld (_pompe selectionPosition (["rope_1","rope_2"] select ((_activePistoletObj getVariable ["ALF_activePistolet","pistolet_2"]) isEqualTo "pistolet_2"))), "C_Kart_01_Red_F"];
		deleteVehicle _activeKart;
		_activeKart = objNull;

		_pompe animateSource [(["pistolet_1_source","pistolet_2_source"] select ((_activePistoletObj getVariable ["ALF_activePistolet","pistolet_2"]) isEqualTo "pistolet_2")), 0, true];

		detach _activePistoletObj;
		deleteVehicle _activePistoletObj;

		player playActionNow "gestureNod";

		ALF_activePistolet = "";
	};

	case 2: 
	{
		if (!hasInterface OR {isNull _pompe}) exitWith {};

		{
			_x setObjectTexture [0, "\ALF_Batiments\ALF_Station\proxies\data\Tuyau_Pompe_CO.paa"];
			_x setObjectTexture [1, ""];
			_x setObjectTexture [2, ""];
		} forEach ((_pompe nearObjects ["ropesegment", 25]) + (_pompe nearObjects ["rope", 25]));
	};

	case 3: {player action ["engineOff", vehicle player];};

	case 4: 
	{
		private _activePistoletObj = objNull;
		{
			if ((typeOf _x) isEqualTo "ALF_Pistolet_Essence") exitWith 
			{
				_activePistoletObj = _x;
			};
		} forEach (attachedObjects _pompe);
		if (isNull _activePistoletObj) exitWith {};

		private _nombrelitres = _activePistoletObj getVariable ["ALF_NombreLitre",0];
		private _veh = _activePistoletObj getVariable ["ALF_activeVeh",objNull];

		if (_nombrelitres > 0) then 
		{
			private _fuelCost = ["NUMBER", ["Life_Settings", "fuel_cost"]] call ALFTools_Client_Config_fnc_getConfig;
			private _price = _nombrelitres * _fuelCost;

			["Vidéo surveillance", "Vous êtes partis sans payer ! Les services de Gendarmerie sont prévenus !", "danger", false] spawn ALF_fnc_doMsg;
			["COG", format["De COG à l'ensemble des effectifs, véhicule ayant refusé de payer - station service située en %1.",mapGridPosition _pompe]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];

			private _cam = nearestObject [position player,"Land_ALF_Security"];
			if(isNull _cam) exitWith {};
			if(_cam distance player > 100) exitWith {};

			private _hour = date # 3;
			private _min = date # 4;
			if(_min >= 0 AND _min <= 9) then {_min = format["0%1", _min];};

			_plaque = getPlateNumber _veh splitstring "";
			if(isNil "_plaque") exitWith {};

			_p1 = _plaque # 0;
			_p2 = _plaque # 1;
			_p3 = _plaque # 2;
			_p4 = _plaque # 3;
			_p5 = _plaque # 4;
			_p6 = _plaque # 5;
			_p7 = _plaque # 6;
			_p8 = _plaque # 7;
			_p9 = _plaque # 8;

			private _pf = "";
			if ((random 10) < 4) then 
			{
				_pf = format["%1*%2%3%4%5%6%7* - %8 €",_p1,_p3,_p4,_p5,_p6,_p7,_p8,_price];
			} else 
			{
				_pf = format["%1%2%3%4%5%6%7%8%9 - %10 €",_p1,_p2,_p3,_p4,_p5,_p6,_p7,_p8,_p9,_price];
			};

			[_cam,format["%1:%2",_hour,_min],[_pf]] remoteExecCall ["ALF_Server_fnc_setCameraVar",2];
		};

		ALF_activePrisePistolet = false;

		ropeDestroy ((ropes _activePistoletObj) # 0);

		private _pompe2 = nearestObjects[player, ["Land_ALF_Pompe"], 50] # 0;

		if !(isNull _pompe2) then 
		{
			_activeKart = nearestObject [_pompe2 modelToWorld (_pompe2 selectionPosition (["rope_1","rope_2"] select ((_activePistoletObj getVariable ["ALF_activePistolet","pistolet_2"]) isEqualTo "pistolet_2"))), "C_Kart_01_Red_F"];
			deleteVehicle _activeKart;
			_activeKart = objNull;

			_pompe2 animateSource [(["pistolet_1_source","pistolet_2_source"] select ((_activePistoletObj getVariable ["ALF_activePistolet","pistolet_2"]) isEqualTo "pistolet_2")), 0, true];
		};

		detach _activePistoletObj;
		deleteVehicle _activePistoletObj;

		ALF_activePistolet = "";
	};
};
// };