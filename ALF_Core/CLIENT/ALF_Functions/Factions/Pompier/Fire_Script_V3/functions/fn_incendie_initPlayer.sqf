if (isNil "byscream_demi_raccord_hand") then { //Pour éviter de charger plusieurs fois les EH lors du respawn
	call ALF_fnc_incendie_initEH;
	byscream_bsl = nil;


	[] spawn {
		while {true} do {
			{
				if ((player distance _x) <= 8 && isNull (player getVariable ['byscream_son_ari',objNull])) then {
					hint "Vous vous asphyxiez avec les fumées, reculez ou mettez un ARI !";
					playSound3D ["MRP_Incendie\sounds\tousser.ogg", player, false, getPosASL player, 3, 1, 10];
				};
			} forEach byscream_fires;
			uiSleep 10;
		};
	};

};

call ALF_fnc_incendie_initActions;