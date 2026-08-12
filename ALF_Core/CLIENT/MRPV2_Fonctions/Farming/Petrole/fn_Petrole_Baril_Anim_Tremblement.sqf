// Client_fnc_Petrole_Baril_Anim_Tremblement ={
private _liste_Ctrl = param [0,[]];


playSoundUI ["MRPV2_Petrole_Baril_Vide",0.4,0.8 + random 0.4];

{
	[_x] spawn
	{params ["_x"];
		private _ctrlGrp_Baril = _x # 0;
		private _pos_Baril = _x # 2;

		for "_i" from 0 to 5 do
		{					
			private _alea_X = 0.01 - random 0.02;
			private _alea_Y = 0.01 - random 0.02;

			_ctrlGrp_Baril ctrlSetPositionX ((_pos_Baril # 0) + _alea_X);
			_ctrlGrp_Baril ctrlSetPositionY ((_pos_Baril # 1) + _alea_Y);
			_ctrlGrp_Baril ctrlCommit 0.02;

			sleep 0.04;					
		};

		_ctrlGrp_Baril ctrlSetPositionX (_pos_Baril # 0);
		_ctrlGrp_Baril ctrlSetPositionY (_pos_Baril # 1);
		_ctrlGrp_Baril ctrlCommit 0.02;
	};
} foreach _liste_Ctrl;

TRUE
// };