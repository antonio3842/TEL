private["_item", "_pos", "_object"];
_item = _this select 0;

if !(vehicle player isEqualTo player) exitWith {
	["Rubalise", "Il faut sortir du véhicule", "warning", false] spawn ALF_fnc_doMsg;
};


if !(isNil "rubalise_deploy") exitWith {
	hint "Vous êtes déjà en train de déployer une rubalise !"
};
rubalise_deploy = true;
hint "Appuyez sur la touche O dès que vous voulez accrocher la rubalise à l'endroit visé.";
pos1=[];
pos2=[];
arrow = "Sign_Arrow_F" createVehicleLocal [0, 0, 0];
typerubalise=_item;
onEachFrame {
	_ins = lineIntersectsSurfaces [
		AGLToASL positionCameraToWorld [0, 0, 0],
		AGLToASL positionCameraToWorld [0, 0, 1000],
		player,
		objNull,
		true,
		1,
		"GEOM",
		"NONE"
	];
	if (count _ins == 0) exitWith {
		arrow setPosASL [0, 0, 0]
	};
	arrow setPosASL (_ins select 0 select 0);
	arrow setVectorUp (_ins select 0 select 1);
};

keyhandler = findDisplay 46 displayAddEventHandler ["KeyDown", {
	[_this] spawn {
		if ((param[0, displayNull] select 1) isEqualTo 24) then {
			_ins = lineIntersectsSurfaces [
				AGLToASL positionCameraToWorld [0, 0, 0],
				AGLToASL positionCameraToWorld [0, 0, 1000],
				player,
				objNull,
				true,
				1,
				"GEOM",
				"NONE"
			];
			if (count _ins == 0) then {
				hint "L'endroit visé n'est pas correct !";
			} else {
				_pos = _ins select 0 select 0;
				if ((ASLToAGL _pos) distance player > 5) exitWith {hint "Vous etes trop loin de l'endroit sélectionné !"};
				if (pos1 isEqualTo []) then {
					veh1 = _ins select 0 select 2;
					pos1 = veh1 worldToModel (ASLToAGL _pos);
					hint "Désormais, trouvez le deuxième endroit où accrocher la rubalise et appuyez sur la touche O.";
				} else {
					veh2 = _ins select 0 select 2;
					pos2 = veh2 worldToModel (ASLToAGL _pos);
					_1 = createVehicle ["C_Quadbike_01_F", [0, 0, 10], [], 0, "CAN_COLLIDE"];
					_2 = createVehicle ["C_Quadbike_01_F", [0, 0, 20], [], 0, "CAN_COLLIDE"];
					sleep 0.1;
					{
						_x allowDamage false;
						[_x] remoteExec ["hideObjectGlobal", 2];
						_x setVariable ["MRP_Rubalise", typerubalise, true];
					} forEach [_1, _2];
					sleep 0.1;

					player removeMagazine typerubalise;

					_1 attachTo [veh1, pos1];
					_2 attachTo [veh2, pos2];
					if !(_1 in (attachedObjects veh1)) then {
						_1 setPos ((veh1 modelToWorld pos1) vectorAdd [0, 0, -1.5]);
					};
					if !(_2 in (attachedObjects veh2)) then {
						_2 setPos ((veh2 modelToWorld pos2) vectorAdd [0, 0, -1.5]);
					};
					sleep 0.1;
					_distance = _1 distance _2;
					ropeCreate [_1, [0, 0, 0], _2, [0, 0, 0], _distance, ["", [0, 0, -1]], ["", [0, 0, -1]], typerubalise];

					findDisplay 46 displayRemoveEventHandler ["KeyDown", keyhandler];

					onEachFrame {};
					deleteVehicle arrow;
					rubalise_deploy = nil;
                    typerubalise = nil;
				};
			};
		};
	};
}];