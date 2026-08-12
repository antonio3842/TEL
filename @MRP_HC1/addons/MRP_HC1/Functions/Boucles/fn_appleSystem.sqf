/*
    File: fn_appleSystem.sqf
    Author: ALF Team
    Desc: Systeme de spawn de fruits (bananes, raisins, huitres, champignons)
    hc_1 - Boucle systeme
*/

private _obj = objNull;
private _obj2 = objNull;
private _obj3 = objNull;
private _obj4 = objNull;
private _obj5 = objNull;
private _obj6 = objNull;
private _obj7 = objNull;
private _obj8 = objNull;
private _obj9 = objNull;
private _obj10 = objNull;
private _obj11 = objNull;
private _obj12 = objNull;
private _obj13 = objNull;
private _obj14 = objNull;
private _obj15 = objNull;
private _obj16 = objNull;
private _obj17 = objNull;
private _obj18 = objNull;
private _obj19 = objNull;
private _obj20 = objNull;
private _obj21 = objNull;
private _obj22 = objNull;
private _obj23 = objNull;
private _obj24 = objNull;
private _obj25 = objNull;
private _obj36 = objNull;
private _obj37 = objNull;
private _obj38 = objNull;
private _obj39 = objNull;
private _obj40 = objNull;

for "_i" from 0 to 1 step 0 do {
    // Bananes
    if(isNull _obj OR isNil "_obj") then {_obj = createVehicle ["groundweaponholder", [5917.16,7809.19,0.00173187], [], 0, "CAN_COLLIDE"]; _obj enableDynamicSimulation true;};
    if(isNull _obj2 OR isNil "_obj2") then {_obj2 = createVehicle ["groundweaponholder", [5901.1,7813.94,0.00111389], [], 0, "CAN_COLLIDE"]; _obj2 enableDynamicSimulation true;};
    if(isNull _obj3 OR isNil "_obj3") then {_obj3 = createVehicle ["groundweaponholder", [5916.9,7794.32,0.00174141], [], 0, "CAN_COLLIDE"]; _obj3 enableDynamicSimulation true;};
    if(isNull _obj4 OR isNil "_obj4") then {_obj4 = createVehicle ["groundweaponholder", [5929.86,7781.12,0.00145721], [], 0, "CAN_COLLIDE"]; _obj4 enableDynamicSimulation true;};
    if(isNull _obj5 OR isNil "_obj5") then {_obj5 = createVehicle ["groundweaponholder", [5943.98,7771.34,0.00154114], [], 0, "CAN_COLLIDE"]; _obj5 enableDynamicSimulation true;};
    if(isNull _obj6 OR isNil "_obj6") then {_obj6 = createVehicle ["groundweaponholder", [5945.02,7757.02,0.00123596], [], 0, "CAN_COLLIDE"]; _obj6 enableDynamicSimulation true;};
    if(isNull _obj7 OR isNil "_obj7") then {_obj7 = createVehicle ["groundweaponholder", [5937.42,7744.11,0.000972748], [], 0, "CAN_COLLIDE"]; _obj7 enableDynamicSimulation true;};
    if(isNull _obj8 OR isNil "_obj8") then {_obj8 = createVehicle ["groundweaponholder", [5947.23,7745.82,0.0018158], [], 0, "CAN_COLLIDE"]; _obj8 enableDynamicSimulation true;};
    if(isNull _obj9 OR isNil "_obj9") then {_obj9 = createVehicle ["groundweaponholder", [5980.99,7748.16,0.00132942], [], 0, "CAN_COLLIDE"]; _obj9 enableDynamicSimulation true;};
    if(isNull _obj10 OR isNil "_obj10") then {_obj10 = createVehicle ["groundweaponholder", [5989.91,7733.4,0.00133801], [], 0, "CAN_COLLIDE"]; _obj10 enableDynamicSimulation true;};
    {
        if(count (magazineCargo _x) < 10) then {
            _x addMagazineCargoGlobal ["ALF_Banane",10];
        };
    } forEach [_obj,_obj2,_obj3,_obj4,_obj5,_obj6,_obj7,_obj8,_obj9,_obj10];

    // Raisins zone 1
    //if(isNull _obj11 OR isNil "_obj11") then {_obj11 = createVehicle ["groundweaponholder", [7916.71,3872.78,0.00159836], [], 0, "CAN_COLLIDE"]; _obj11 setVariable ["TakeRaisin",true,true]; _obj11 enableDynamicSimulation true;};
    //if(isNull _obj12 OR isNil "_obj12") then {_obj12 = createVehicle ["groundweaponholder", [7873.22,3846.44,0.00149345], [], 0, "CAN_COLLIDE"]; _obj12 setVariable ["TakeRaisin",true,true]; _obj12 enableDynamicSimulation true;};
    //if(isNull _obj13 OR isNil "_obj13") then {_obj13 = createVehicle ["groundweaponholder", [7880.39,3812.5,0.00143909], [], 0, "CAN_COLLIDE"]; _obj13 setVariable ["TakeRaisin",true,true]; _obj13 enableDynamicSimulation true;};
    //if(isNull _obj14 OR isNil "_obj14") then {_obj14 = createVehicle ["groundweaponholder", [7927.52,3817.11,0.00151253], [], 0, "CAN_COLLIDE"]; _obj14 setVariable ["TakeRaisin",true,true]; _obj14 enableDynamicSimulation true;};
    //if(isNull _obj15 OR isNil "_obj15") then {_obj15 = createVehicle ["groundweaponholder", [7969.37,3836.34,0.00166512], [], 0, "CAN_COLLIDE"]; _obj15 setVariable ["TakeRaisin",true,true]; _obj15 enableDynamicSimulation true;};
    //if(isNull _obj16 OR isNil "_obj16") then {_obj16 = createVehicle ["groundweaponholder", [7972.9,3877.85,0.0016613], [], 0, "CAN_COLLIDE"]; _obj16 setVariable ["TakeRaisin",true,true]; _obj16 enableDynamicSimulation true;};
    //if(isNull _obj17 OR isNil "_obj17") then {_obj17 = createVehicle ["groundweaponholder", [7938.62,3906.34,0.00166321], [], 0, "CAN_COLLIDE"]; _obj17 setVariable ["TakeRaisin",true,true]; _obj17 enableDynamicSimulation true;};
    //if(isNull _obj18 OR isNil "_obj18") then {_obj18 = createVehicle ["groundweaponholder", [7898.44,3911.59,0.00126648], [], 0, "CAN_COLLIDE"]; _obj18 setVariable ["TakeRaisin",true,true]; _obj18 enableDynamicSimulation true;};
    //{
     //   if(count (magazineCargo _x) < 16) then {
     //       _x addMagazineCargoGlobal ["ALF_Raisin",4];
     //   };
    //} forEach [_obj11,_obj12,_obj13,_obj14,_obj15,_obj16,_obj17,_obj18];

    // Huitres
    if(isNull _obj19 OR isNil "_obj19") then {_obj19 = createVehicle ["groundweaponholder", [4127.03,9391.29,-0.391556], [], 0, "CAN_COLLIDE"]; _obj19 enableDynamicSimulation true;};
    if(isNull _obj20 OR isNil "_obj20") then {_obj20 = createVehicle ["groundweaponholder", [4134.61,9376.14,-0.705316], [], 0, "CAN_COLLIDE"]; _obj20 enableDynamicSimulation true;};
    if(isNull _obj21 OR isNil "_obj21") then {_obj21 = createVehicle ["groundweaponholder", [4150.67,9367.3,-1.36238], [], 0, "CAN_COLLIDE"]; _obj21 enableDynamicSimulation true;};
    if(isNull _obj22 OR isNil "_obj22") then {_obj22 = createVehicle ["groundweaponholder", [4162.05,9378.46,-0.756465], [], 0, "CAN_COLLIDE"]; _obj22 enableDynamicSimulation true;};
    if(isNull _obj23 OR isNil "_obj23") then {_obj23 = createVehicle ["groundweaponholder", [4152.33,9390.33,-1.16843], [], 0, "CAN_COLLIDE"]; _obj23 enableDynamicSimulation true;};
    if(isNull _obj24 OR isNil "_obj24") then {_obj24 = createVehicle ["groundweaponholder", [4155.45,9406.37,-0.640312], [], 0, "CAN_COLLIDE"]; _obj24 enableDynamicSimulation true;};
    if(isNull _obj25 OR isNil "_obj25") then {_obj25 = createVehicle ["groundweaponholder", [4168.33,9397.09,-0.517456], [], 0, "CAN_COLLIDE"]; _obj25 enableDynamicSimulation true;};
    {
        if(count (magazineCargo _x) < 6) then {
            _x addMagazineCargoGlobal ["ALF_Huitre",5];
        };
    } forEach [_obj19,_obj20,_obj21,_obj22,_obj23,_obj24,_obj25];

    // Champignons
    if(isNull _obj36 OR isNil "_obj36") then {_obj36 = createVehicle ["groundweaponholder", [1718.65,7777.58,0.000736237], [], 0, "CAN_COLLIDE"]; _obj36 enableDynamicSimulation true;};
    if(isNull _obj37 OR isNil "_obj37") then {_obj37 = createVehicle ["groundweaponholder", [1735.86,7786.52,0.0026474], [], 0, "CAN_COLLIDE"]; _obj37 enableDynamicSimulation true;};
    if(isNull _obj38 OR isNil "_obj38") then {_obj38 = createVehicle ["groundweaponholder", [1750.7,7767.81,0.00155258], [], 0, "CAN_COLLIDE"]; _obj38 enableDynamicSimulation true;};
    if(isNull _obj39 OR isNil "_obj39") then {_obj39 = createVehicle ["groundweaponholder", [1727.21,7751.84,0.00142288], [], 0, "CAN_COLLIDE"]; _obj39 enableDynamicSimulation true;};
    if(isNull _obj40 OR isNil "_obj40") then {_obj40 = createVehicle ["groundweaponholder", [1713.62,7758.62,0.00130653], [], 0, "CAN_COLLIDE"]; _obj40 enableDynamicSimulation true;};
    {
        if(count (magazineCargo _x) < 6) then {
            _x addMagazineCargoGlobal ["ALF_Champignon",5];
        };
    } forEach [_obj36,_obj37,_obj38,_obj39,_obj40];

    uiSleep 60;
};
