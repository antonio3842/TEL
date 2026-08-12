
		params ["_bullet"] ;

		private ["_from","_vel","_coefGravity"] ;
		if !(_bullet isEqualType objNull) then {
			// if the bullet has been passed, use its value
			_from = _args#0 ;
			_vel = _args#1 ;
			_coefGravity = 0.1;
		} else {
			// otherwise use the given values
			_from = getPosASL _bullet ;
			_vel = velocity _bullet ;
			_coefGravity = 0.1 ;
		} ;

		if (_from#2 < 0) exitWith {
			[-1,[-1,-1,-1]]
		} ;

		private _linePos = _from ;
		private _estimatedTime = 7 ;
		private _step = 0.05 ;
		private _velCalc = [] + _vel ;

		private _returnPos = [-1,-1,-1] ;
		// do the stupid trick
		for "_i" from 0 to 7 step _step do {
			_velCalc = _velCalc vectorAdd [0,0,-9.8*_step*_coefGravity] ;
			private _linePosNext = _linePos vectorAdd (_velCalc vectorMultiply _step) ;
			//debug line
			
			private _intersect = ((lineIntersectsSurfaces [_linePos,_linePosNext,objNull,objNull,true,1,"GEOM","PHYSX"]) call {
				if (count _this != 0) exitWith {
					_this#0#0 ;
				} ;
				[-1,-1,-1]
			}) ;

			if (
				_intersect isNotEqualTo [-1,-1,-1] && _i > 0.2
			) exitWith {
				_estimatedTime = _i + (_step * 2) ;
				_returnPos = _intersect ;
			} ;
			_linePos = _linePosNext ;
		} ;

		[_estimatedTime,_returnPos]
		