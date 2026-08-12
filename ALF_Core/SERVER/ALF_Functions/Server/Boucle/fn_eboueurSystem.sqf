/*
	This file is for Nanou's HeadlessClient.
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

for "_i" from 0 to 1 step 0 do {
	if(isNull _obj OR isNil "_obj") then {_obj = createVehicle ["ALF_Poubelle", [3391.54,4242.19,0.00143886], [], 0, "NONE"]; _obj enableSimulationGlobal false;};
	if(isNull _obj2 OR isNil "_obj2") then {_obj2 = createVehicle ["ALF_Poubelle", [3646.28,4250.47,0.00143886], [], 0, "NONE"]; _obj2 enableSimulationGlobal false;;};
	if(isNull _obj3 OR isNil "_obj3") then {_obj3 = createVehicle ["ALF_Poubelle", [3735.27,4026.95,0.00143862], [], 0, "NONE"];_obj3 enableSimulationGlobal false;;};
	if(isNull _obj4 OR isNil "_obj4") then {_obj4 = createVehicle ["ALF_Poubelle", [3677.88,4397.36,0.00143909], [], 0, "NONE"];_obj4 enableSimulationGlobal false;;};
	if(isNull _obj5 OR isNil "_obj5") then {_obj5 = createVehicle ["ALF_Poubelle", [3299.99,4438.6,0.00145435], [], 0, "NONE"];_obj5 enableSimulationGlobal false;;};
	if(isNull _obj6 OR isNil "_obj6") then {_obj6 = createVehicle ["ALF_Poubelle", [3958.27,4469.88,0.00143909], [], 0, "NONE"];_obj6 enableSimulationGlobal false;;};
	if(isNull _obj7 OR isNil "_obj7") then {_obj7 = createVehicle ["ALF_Poubelle", [3881.72,4532.32,0.00143909], [], 0, "NONE"];_obj7 enableSimulationGlobal false;;};
	if(isNull _obj8 OR isNil "_obj8") then {_obj8 = createVehicle ["ALF_Poubelle", [3881.33,4567.31,0.00143909], [], 0, "NONE"];_obj8 enableSimulationGlobal false;;};
	if(isNull _obj9 OR isNil "_obj9") then {_obj9 = createVehicle ["ALF_Poubelle", [3879.15,4610.89,0.00143909], [], 0, "NONE"];_obj9 enableSimulationGlobal false;;};
	if(isNull _obj10 OR isNil "_obj10") then {_obj10 = createVehicle ["ALF_Poubelle", [3751.87,4613.97,0.00143814], [], 0, "NONE"];_obj10 enableSimulationGlobal false;;};
	if(isNull _obj11 OR isNil "_obj11") then {_obj11 = createVehicle ["ALF_Poubelle", [4088.96,4693.52,0.00143909], [], 0, "NONE"];_obj11 enableSimulationGlobal false;;};
	if(isNull _obj12 OR isNil "_obj12") then {_obj12 = createVehicle ["ALF_Poubelle", [5269.69,4644.09,0.00143909], [], 0, "NONE"];_obj12 enableSimulationGlobal false;;};
	if(isNull _obj13 OR isNil "_obj13") then {_obj13 = createVehicle ["ALF_Poubelle", [4252.29,4251.71,0.00143909], [], 0, "NONE"];_obj13 enableSimulationGlobal false;;};
	if(isNull _obj14 OR isNil "_obj14") then {_obj14 = createVehicle ["ALF_Poubelle", [4576.74,4620.67,0.00143909], [], 0, "NONE"];_obj14 enableSimulationGlobal false;;};
	if(isNull _obj15 OR isNil "_obj15") then {_obj15 = createVehicle ["ALF_Poubelle", [4049.3,4507.16,0.00143909], [], 0, "NONE"];_obj15 enableSimulationGlobal false;;};
	if(isNull _obj16 OR isNil "_obj16") then {_obj16 = createVehicle ["ALF_Poubelle", [4561.75,4751.67,0.00143909], [], 0, "NONE"];_obj16 enableSimulationGlobal false;;};
	if(isNull _obj17 OR isNil "_obj17") then {_obj17 = createVehicle ["ALF_Poubelle", [4342.39,4327.4,0.00143909], [], 0, "NONE"];_obj17 enableSimulationGlobal false;;};
	if(isNull _obj18 OR isNil "_obj18") then {_obj18 = createVehicle ["ALF_Poubelle", [4807.37,4460.62,0.00143909], [], 0, "NONE"];_obj18 enableSimulationGlobal false;;};
	if(isNull _obj19 OR isNil "_obj19") then {_obj19 = createVehicle ["ALF_Poubelle", [4083.02,4310.32,0.00143909], [], 0, "NONE"];_obj19 enableSimulationGlobal false;;};
	if(isNull _obj20 OR isNil "_obj20") then {_obj20 = createVehicle ["ALF_Poubelle", [4706.43,4751.59,0.00143909], [], 0, "NONE"];_obj20 enableSimulationGlobal false;;};
	{
		if(count (magazineCargo _x) < 10) then {
			_x addMagazineCargoGlobal ["ALF_Dechets",2];
		};
	} forEach [_obj,_obj2,_obj3,_obj4,_obj5,_obj6,_obj7,_obj8,_obj9,_obj10,_obj11,_obj12,_obj13,_obj14,_obj15,_obj16,_obj17,_obj18,_obj19,_obj20];
	
	uiSleep 900;
};