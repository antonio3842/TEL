sleep 5;

private _arrayVille = [
        [6082.643,7273.304,2.461], //la trinité
        [7682.413,4677.812,0.000], //le françois
        [6672.062,5862.331,0.005], //Le robert
        [9347.677,3151.848,0.005], //Le vauclin
        [8361.947,1695.482,0.000], //Le marin
        [5161.717,1734.831,0.000], //Le Diamant
        [3602.727,2191.743,0.000], //Les anses-d'arlet
        [4434.286,3344.091,0.000], //Les trois ilets
        [4357.159,4585.126,0.000], //Fort de france
        //[3088.294,4285.754,0.000], //Fort de france vieux
        [4998.901,6763.546,0.000], //Gros morne
        [6044.409,8471.512,0.000], //Crosmy
        [3816.022,9241.959,0.000], //Le Lorrain
        [2429.264,9904.565,0.000], //Macouba
        [1733.916,9961.952,0.000], //Grand Riviere
        [2556.442,8597.587,0.000], //Ajoupa Bouillon
        [377.560,8893.635,0.000], //Le precheur
        [1228.854,7220.004,0.000], //Saint Pierre
        [2166.21,6541.591,0.000], //Le Morne Vert
        [2181.079,5503.642,0.000] //Case Pilote
        //[2812.61,6057.88,0.00140667]
];
private _selectRandomVille 	= selectRandom _arrayVille;
private _arrayHouse 		= nearestObjects [_selectRandomVille, ["House"], 500];
private _arrayHousePossible = [];

{
	if (typeOf _x in ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_House_Big_03_F","Land_House_Big_04_F","Land_i_House_Big_01_b_white_F","Land_i_House_Big_01_b_brown_F","Land_i_House_Big_01_b_blue_F","Land_i_House_Big_01_b_whiteblue_F","Land_i_House_Big_01_b_pink_F","Land_i_House_Big_01_b_yellow_F","Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_House_Big_02_F","Land_i_House_Big_02_b_blue_F","Land_i_House_Big_02_b_white_F","Land_i_House_Big_02_b_whiteblue_F","Land_i_House_Big_02_b_yellow_F","Land_i_House_Big_02_b_brown_F","Land_i_House_Big_02_b_pink_F","Land_ALF_MaisonMetal","Land_ALF_MaisonMetal_Blanc","Land_ALF_MaisonMetal_Verte","Land_ALF_MaisonMetal_Rouge","Land_ALF_MaisonMetal_Grise","Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V3_F","Land_i_House_Small_03_V1_F","Land_i_House_Small_02_b_blue_F","Land_i_House_Small_02_b_brown_F","Land_i_House_Small_02_b_pink_F","Land_i_House_Small_02_b_white_F","Land_i_House_Small_02_b_whiteblue_F","Land_i_House_Small_02_b_yellow_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_House_Big_01_F","Land_House_Small_02_F","Land_House_Small_01_F","Land_House_Small_03_F","Land_House_Small_06_F","Land_House_Small_04_F","Land_House_Small_05_F","Land_i_House_Small_01_b_brown_F"]) then {
		_arrayHousePossible pushBack _x;
	};
} forEach _arrayHouse;

private _selectHouse = selectRandom _arrayHousePossible;

player setVariable["ALF_GoFastHouse", _selectHouse, true];

_time = 0;
_distance = (player distance _selectHouse) / 1000;
_time = floor (_distance * 50);
alf_gofast_time = _time;
alf_gofast_time_started = time;

alf_gofast_prixfinal = _time * 80;

_timedialogue = format["%1 minute(s) et %2 seconde(s)",floor (_time/60), floor ((_time/60-(floor(_time/60)))*60)];
["Dealer", format["Allez go frérot, tu as %1 pour amener toute la came sur le point, sinon il te payera moins cher !",_timedialogue]] spawn BIS_fnc_showSubtitle;
alf_gofast_task = player createSimpleTask ["Amenez la drogue (gofast)"];
alf_gofast_task setTaskState "Assigned";
alf_gofast_task setSimpleTaskDescription ["Amenez la drogue","Amenez la drogue","marker"];
alf_gofast_task setSimpleTaskDestination (getPos _selectHouse);

["TaskAssigned",["","Amenez la drogue sur le point"]] call BIS_fnc_showNotification;
_selectHouse setVariable ['Gofast_Colis',getPlayerUID player,true];


player setVariable ["alf_gofast_haveColis", true, true];

[vehicletocharge] spawn {
    _vehicle = param[0,objNull,[objNull]];
    _time_restant = 100;
    uiSleep 5;
    while {!(_vehicle getVariable ["alf_gofast_isDeloading",false]) && _time_restant > 0} do {
        
        _time_restant = floor ((alf_gofast_time_started+alf_gofast_time)-time);
        if (_time_restant < 0) then {
            _time_restant = 0;
        };
        _timedialogue = format["%1 minute(s) et %2 seconde(s)",floor (_time_restant/60), floor ((_time_restant/60-(floor(_time_restant/60)))*60)];
        if (_time_restant > 180) then {
            ["Dealer", format["Temps restant: %1",_timedialogue]] spawn BIS_fnc_showSubtitle;
        };
        if (_time_restant <= 180 && _time_restant > 90) then {
            ["Dealer", format["<t color='#F5AD27'>Temps restant: %1</t>",_timedialogue]] spawn BIS_fnc_showSubtitle;
        };
        if (_time_restant <= 90) then {
            ["Dealer", format["<t color='#F52727'>Temps restant: %1</t>",_timedialogue]] spawn BIS_fnc_showSubtitle;
        };  
        uiSleep 5;
    };
    
};

sleep _time;
if (_selectHouse getVariable ['Gofast_Colis',''] isNotEqualTo '') then {
	alf_gofast_prixfinal = floor (alf_gofast_prixfinal / 2);

	while {(_selectHouse getVariable ['Gofast_Colis',''] isNotEqualTo '') && (alf_gofast_prixfinal > 10)} do {
		sleep (_time/10);
	    alf_gofast_prixfinal = floor (alf_gofast_prixfinal / 2);
	};

};
