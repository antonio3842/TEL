private["_pos", "_object"];
_generator = _this select 0;
if !(vehicle player isEqualTo player) exitWith {
    hint "Il faut sortir du véhicule !";
};
if !(isNil "cable_deploy") exitWith {
    hint "Vous êtes déjà en train de déployer un câble !";
};

cable_deploy = true;
cable_generator = _generator;

hint "Visez l'objet à raccorder et appuyez sur O (max 10m).";

arrow = "Sign_Arrow_F" createVehicleLocal [0, 0, 0];

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
        arrow setPosASL [0, 0, 0];
    };
    arrow setPosASL (_ins select 0 select 0);
    arrow setVectorUp (_ins select 0 select 1);
};

keyhandler = findDisplay 46 displayAddEventHandler ["KeyDown", {
    [_this] spawn {
        private _originalThis = _this select 0;
        private _generator = cable_generator;
        if ((_originalThis select 1) isEqualTo 24) then {
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
                hint "L'endroit visé n'est pas valide !";
            };

            _pos = _ins select 0 select 0;

            if ((_generator distance (ASLToAGL _pos)) > 10) exitWith {
                hint "L'objet visé est trop loin ! (max 10m)";
            };

            veh2 = _ins select 0 select 2;
            pos2 = veh2 worldToModel (ASLToAGL _pos);

			if (isNull veh2) exitWith {
				hint "Aucun objet détecté à cet endroit !";
			};

            // Ancre invisible côté générateur
            _anc1 = createVehicle ["C_Quadbike_01_F", [0, 0, 10], [], 0, "CAN_COLLIDE"];
            // Ancre invisible côté cible
            _anc2 = createVehicle ["C_Quadbike_01_F", [0, 0, 20], [], 0, "CAN_COLLIDE"];
            sleep 0.1;

            {
                _x allowDamage false;
                [_x] remoteExec ["hideObjectGlobal", 2];
            } forEach [_anc1, _anc2];
            sleep 0.1;

            _anc1 attachTo [_generator, [0, 0, 0]];
            _anc2 attachTo [veh2, pos2];

            if !(_anc2 in (attachedObjects veh2)) then {
                _anc2 setPos ((veh2 modelToWorld pos2) vectorAdd [0, 0, -1.5]);
            };
            sleep 0.1;
			_generator setVariable ["_cableTarget", veh2];
            _distance = _anc1 distance _anc2;
            ropeCreate [_anc1, [0, 0, 0], _anc2, [0, 0, 0], _distance];
			
			[_generator,veh2] spawn {
				while {true} do {
					_essence = _this#0 getVariable ["generatorEssence", 0];
					_essence  = _essence - 1;
					_this#1 setVariable ["HasCourant", true, true];
					if (_essence <= 0) then {
						_essence = 0;
						_this#1 setVariable ["HasCourant", false, true];
					};
					_this#0 setVariable ["generatorEssence", _essence, true];
					sleep 60;
				};
			};
			
			[_generator] spawn {
				while {(_this#0 getVariable ["soundLoop", false])} do {
					_essence = _this#0 getVariable ["generatorEssence", 0];
					if (_essence >= 15) then {
						[(_this#0), "LinkTerminal_01_Standby_Loop"] remoteExec ["say3D"];
					} else {
						if (_essence >= 1) then {
							[(_this#0), "LinkTerminal_02_Standby_Loop"] remoteExec ["say3D"];
						} else {
							//[(_this#0), ""] remoteExec ["say3D"];
						};
					};
					sleep 13.98;
				};
			};
			
            findDisplay 46 displayRemoveEventHandler ["KeyDown", keyhandler];
            onEachFrame {};
            deleteVehicle arrow;
            cable_deploy = nil;
			cable_generator = nil;
			[] spawn ALF_fnc_actionLamps;
            hint "Câble raccordé ! Courant activé.";
        };
    };
}];