// /*
// 	Author : ALF - Adam , modifié par MRP - NorX Aengell
// */
// ALF_Server_fnc_playSlotMachine = {
private _machine = param [0,objnull];
private _mise = param [1,10];
private _unit = param [2,objnull];


private _chance = 0;
private _gain = 0;
private _liste_Rouleaux = ["Rouleau_1","Rouleau_2","Rouleau_3"];
private _liste_Rouleau_Debut = [];

[] call 
{
	if (_mise isequalto 10) exitWith {_chance = 55; _gain = _mise * 2;};
	if (_mise isequalto 100) exitWith {_chance = 35; _gain = _mise * 2.5;};
	if (_mise isequalto 1000) exitWith {_chance = 25; _gain = _mise * 3;};
	if (_mise isequalto 10000) exitWith {_chance = 15; _gain = _mise * 4;};
	if (_mise isequalto 100000) exitWith {_chance = 5; _gain = _mise * 5;};
};

uiSleep 0.5;

_machine animate ["Poignee",1,5];

playSound3D ["ALF_Client2\sounds\active_levier.ogg",_machine,false,(_machine getrelpos [0.2,90]) vectoradd [0,0,8],4,1,5];

uiSleep 0.4;

_machine animate ["Poignee",0,5];

{
	private _phase_Rouleau = (_machine animationPhase _x) tofixed 2;	
	private _phase_Rouleau_Ajuster = (parseNumber ((_phase_Rouleau splitString ".") # 1));

	[] call
	{
		if (_phase_Rouleau_Ajuster >= 10 AND {_phase_Rouleau_Ajuster < 20}) exitwith {_liste_Rouleau_Debut pushback [_x,9.15];};
		if (_phase_Rouleau_Ajuster >= 25 AND {_phase_Rouleau_Ajuster < 35}) exitwith {_liste_Rouleau_Debut pushback [_x,9.32];};
		if (_phase_Rouleau_Ajuster >= 45 AND {_phase_Rouleau_Ajuster < 55}) exitwith {_liste_Rouleau_Debut pushback [_x,9.52];};
		if (_phase_Rouleau_Ajuster >= 70 AND {_phase_Rouleau_Ajuster < 80}) exitwith {_liste_Rouleau_Debut pushback [_x,9.75];};
		if (_phase_Rouleau_Ajuster >= 90 AND {_phase_Rouleau_Ajuster < 100}) exitwith {_liste_Rouleau_Debut pushback [_x,9.955];};
	};
} foreach _liste_Rouleaux;

{_machine animate [_x # 0,_x # 1,TRUE];} foreach _liste_Rouleau_Debut;

sleep 0.1;

[_machine] spawn 
{params ["_machine"];
	waitUntil 
	{		
		private _son = playSound3D ["ALF_Client2\sounds\suspens.ogg", _machine, false, (_machine getrelpos [0,0]) vectoradd [0,0,8], 5, 1, 5];
		[_son,_machine] spawn {params ["_son","_machine"];};

		if (
		!(_machine getVariable ["isOn", true]) OR
		{(_machine animationPhase "Rouleau_3") < 2}
		) exitwith {TRUE};

		sleep 0.97;

		FALSE
	};
};

private _gagnant = false;
private _tirage = round (random 100);

if (_tirage <= _chance) then 
{
	_gagnant = true;
	{_machine animate [_x,0.52,4]; sleep 0.4;} foreach _liste_Rouleaux;
} else 
{
	[_machine] spawn 
	{params ["_machine"];
		private _liste_Phases_R1 = [0.15,0.32,0.52,0.75,0.955];
		private _liste_Phases_R2 = [0.15,0.335,0.52,0.75,0.955];
		private _liste_Phases_R3 = [0.15,0.323,0.755,0.96];

		{
			private _phase_Choisis = selectrandom _x;			
			_machine animate ["Rouleau_" + str (_foreachindex + 1),_phase_Choisis + (2 - (_foreachindex * 1)),4];

			sleep 0.4;
		} foreach [_liste_Phases_R1,_liste_Phases_R2,_liste_Phases_R3];
	};
};

waitUntil
{
	if (
	!(_machine getVariable ["isOn", true]) OR
	{(_machine animationPhase "Rouleau_3") < 1}
	) exitwith {TRUE};

	FALSE
};

if (_gagnant) then 
{
	_machine animate ["Jeclignote", 1];

	[_machine] spawn 
	{params ["_machine"];
		for "_i" from 0 to 15 do 
		{
			private _allumer = [1,0] select (_machine animationPhase "light");
			_machine animate ["light",_allumer,true];
			sleep 0.5;
		};
	};
	
	if (_mise in [1000,10000,100000]) then 
	{
		[_machine] spawn 
		{params ["_machine"];
			waitUntil 
			{				
				_son = playSound3D ["ALF_Client2\sounds\jackpot.ogg", _machine, false, (_machine getrelpos [0,0]) vectoradd [0,0,8], 5, 1, 15];

				if (
				!(_machine getVariable ["isOn", true]) OR
				{(_machine animationPhase "Jeclignote") isequalto 0}
				) exitwith {stopSound _son; TRUE};

				sleep 5.5;

				FALSE
			};
		};
	} else
	{
		[_machine] spawn 
		{params ["_machine"];
			waitUntil 
			{				
				_son = playSound3D ["ALF_Client2\sounds\alarme_win.ogg", _machine, false, (_machine getrelpos [0,0]) vectoradd [0,0,8], 3, 1, 10];

				if (
				!(_machine getVariable ["isOn", true]) OR
				{(_machine animationPhase "Jeclignote") isequalto 0}
				) exitwith {stopSound _son; TRUE};

				sleep 1.2;

				FALSE
			};
		};
	};
	
	uiSleep 5;

	_machine setVariable ["gains",_gain,true];

	_machine animate ["Piece", 1];
	_machine animate ["Jeclignote", 0];
	playSound3D ["ALF_Client2\sounds\coin_drop.ogg", _machine, false, (_machine getrelpos [0,0]) vectoradd [0,0,8], 2, 1, 5];

	private _coin = _machine getVariable ["coins",0];
	_machine setVariable ["coins",_coin + _mise + _gain];
	
	private _money = _machine getVariable ["money",0]; // money stock de la machine
	_machine setVariable ["money",_money + _mise,true];

	if (_gain isequalto 500000) then 
	{
		[name _unit,getPlayerUID _unit,"CASINO",format["a gagné 500 000 au casino avec %1.",_tirage]] remoteExec ["ALF_Server_fnc_logIt",2];
	};
} else 
{
	private _money = _machine getVariable ["money",0]; // money stock de la machine
	_machine setVariable ["money",_money + _mise,true];
};

_machine setvariable ["machine_Dispo",nil,true];
// };