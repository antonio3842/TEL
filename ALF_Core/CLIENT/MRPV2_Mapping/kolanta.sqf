// Export of 'Kolanta_mercredi30.martinique' by Antoni Wojda on v0.9

///////////////////////////////////////////////////////////////////////////////////////////
// Init
params [["_layerWhiteList",[],[[]]],["_layerBlacklist",[],[[]]],["_posCenter",[0,0,0],[[]]],["_dir",0,[0]],["_idBlacklist",[],[[]]]];
private _allWhitelisted = _layerWhiteList isEqualTo [];
private _layerRoot = (_allWhitelisted || {true in _layerWhiteList}) && {!(true in _layerBlackList)};
private _layer94 = (_allWhitelisted || {"cache" in _layerWhiteList}) && {!("cache" in _layerBlackList)};
private _layer177 = (_allWhitelisted || {"ile 2" in _layerWhiteList}) && {!("ile 2" in _layerBlackList)};
private _layer168 = (_allWhitelisted || {"ile ceremonie" in _layerWhiteList}) && {!("ile ceremonie" in _layerBlackList)};
private _layer167 = (_allWhitelisted || {"ile 1" in _layerWhiteList}) && {!("ile 1" in _layerBlackList)};
private _layer239 = (_allWhitelisted || {"kohlanta" in _layerWhiteList}) && {!("kohlanta" in _layerBlackList)};


///////////////////////////////////////////////////////////////////////////////////////////
// Markers
private _markers = [];
private _markerIDs = [];


///////////////////////////////////////////////////////////////////////////////////////////
// Groups
private _groups = [];
private _groupIDs = [];

private _item1330 = grpNull;
if (_layerRoot) then {
	_item1330 = createGroup civilian;
	_this = _item1330;
	_groups pushback _this;
	_groupIDs pushback 1330;
};


///////////////////////////////////////////////////////////////////////////////////////////
// Objects
private _objects = [];
private _objectIDs = [];

private _item254 = objNull;
if (_layer167 && _layer239) then {
	_item254 = createVehicle ["Land_LuggageHeap_03_F",[4510.79,3707.52,0.00277853],[],0,"CAN_COLLIDE"];
	_this = _item254;
	_objects pushback _this;
	_objectIDs pushback 254;
	_this setPosWorld [4510.79,3707.52,4.75391];
	_this setVectorDirAndUp [[0.989155,-0.0542119,-0.136503],[0.136704,0,0.990612]];
};

private _item1087 = objNull;
if (_layer168 && _layer239) then {
	_item1087 = createVehicle ["plp_bo_BeachTorchA_Burning",[4593.33,3467.75,-0.00169253],[],0,"CAN_COLLIDE"];
	_this = _item1087;
	_objects pushback _this;
	_objectIDs pushback 1087;
	_this setPosWorld [4593.39,3467.96,2.59686];
	_this setVectorDirAndUp [[0.991131,0.117786,-0.0615256],[0.0449542,0.138508,0.989341]];
};

private _item1088 = objNull;
if (_layer168 && _layer239) then {
	_item1088 = createVehicle ["plp_bo_BeachTorchA_Burning",[4594.13,3464.77,-0.00885653],[],0,"CAN_COLLIDE"];
	_this = _item1088;
	_objects pushback _this;
	_objectIDs pushback 1088;
	_this setPosWorld [4594.05,3464.83,2.87706];
	_this setVectorDirAndUp [[0.990796,0.127276,0.0460962],[-0.05193,0.0429023,0.997729]];
};

private _item1093 = objNull;
if (_layer168 && _layer239) then {
	_item1093 = createVehicle ["Land_ALF_G_Chaise_Bois",[4602.71,3470.72,5.96046e-08],[],0,"CAN_COLLIDE"];
	_this = _item1093;
	_objects pushback _this;
	_objectIDs pushback 1093;
	_this setPosWorld [4602.71,3470.72,0.990384];
	_this setVectorDirAndUp [[-0.663086,0.748543,0],[0,0,1]];
};

private _item1094 = objNull;
if (_layer168 && _layer239) then {
	_item1094 = createVehicle ["Land_ALF_G_Chaise_Bois",[4603.21,3470.02,0],[],0,"CAN_COLLIDE"];
	_this = _item1094;
	_objects pushback _this;
	_objectIDs pushback 1094;
	_this setPosWorld [4603.21,3470.02,1.03609];
	_this setVectorDirAndUp [[-0.33811,0.941107,0],[0,0,1]];
};

private _item1095 = objNull;
if (_layer168 && _layer239) then {
	_item1095 = createVehicle ["Land_ALF_G_Chaise_Bois",[4602.11,3471.32,2.98023e-08],[],0,"CAN_COLLIDE"];
	_this = _item1095;
	_objects pushback _this;
	_objectIDs pushback 1095;
	_this setPosWorld [4602.11,3471.32,0.945813];
	_this setVectorDirAndUp [[-0.815748,0.578407,0],[0,0,1]];
};

private _item1096 = objNull;
if (_layer168 && _layer239) then {
	_item1096 = createVehicle ["Land_ALF_G_Chaise_Bois",[4601.42,3471.72,2.98023e-08],[],0,"CAN_COLLIDE"];
	_this = _item1096;
	_objects pushback _this;
	_objectIDs pushback 1096;
	_this setPosWorld [4601.42,3471.72,0.907891];
	_this setVectorDirAndUp [[-0.911655,0.410956,0],[0,0,1]];
};

private _item1097 = objNull;
if (_layer168 && _layer239) then {
	_item1097 = createVehicle ["Land_ALF_G_Chaise_Bois",[4603.96,3466.56,0],[],0,"CAN_COLLIDE"];
	_this = _item1097;
	_objects pushback _this;
	_objectIDs pushback 1097;
	_this setPosWorld [4603.96,3466.56,1.44444];
	_this setVectorDirAndUp [[0.0182584,0.999833,0],[0,0,1]];
};

private _item1098 = objNull;
if (_layer168 && _layer239) then {
	_item1098 = createVehicle ["Land_ALF_G_Chaise_Bois",[4603.39,3464.29,0],[],0,"CAN_COLLIDE"];
	_this = _item1098;
	_objects pushback _this;
	_objectIDs pushback 1098;
	_this setPosWorld [4603.39,3464.29,1.74702];
	_this setVectorDirAndUp [[0.499812,0.866134,0],[0,0,1]];
};

private _item1099 = objNull;
if (_layer168 && _layer239) then {
	_item1099 = createVehicle ["Land_ALF_G_Chaise_Bois",[4602.89,3463.58,0],[],0,"CAN_COLLIDE"];
	_this = _item1099;
	_objects pushback _this;
	_objectIDs pushback 1099;
	_this setPosWorld [4602.89,3463.58,1.84506];
	_this setVectorDirAndUp [[0.785123,0.619339,0],[0,0,1]];
};

private _item1100 = objNull;
if (_layer168 && _layer239) then {
	_item1100 = createVehicle ["Land_ALF_G_Chaise_Bois",[4603.78,3465.04,0],[],0,"CAN_COLLIDE"];
	_this = _item1100;
	_objects pushback _this;
	_objectIDs pushback 1100;
	_this setPosWorld [4603.78,3465.04,1.64222];
	_this setVectorDirAndUp [[0.290121,0.95699,0],[0,0,1]];
};

private _item1101 = objNull;
if (_layer168 && _layer239) then {
	_item1101 = createVehicle ["Land_ALF_G_Chaise_Bois",[4603.93,3465.82,0],[],0,"CAN_COLLIDE"];
	_this = _item1101;
	_objects pushback _this;
	_objectIDs pushback 1101;
	_this setPosWorld [4603.93,3465.82,1.53383];
	_this setVectorDirAndUp [[0.100912,0.994895,0],[0,0,1]];
};

private _item1111 = objNull;
if (_layer168 && _layer239) then {
	_item1111 = createVehicle ["Land_ALF_G_Chaise_Bois",[4600.73,3471.98,2.98023e-08],[],0,"CAN_COLLIDE"];
	_this = _item1111;
	_objects pushback _this;
	_objectIDs pushback 1111;
	_this setPosWorld [4600.73,3471.98,0.875273];
	_this setVectorDirAndUp [[-0.942527,0.33413,0],[0,0,1]];
};

private _item1163 = objNull;
if (_layer168 && _layer239) then {
	_item1163 = createVehicle ["plp_bo_BeachTorchA_Burning",[4562.87,3503.95,-0.000352859],[],0,"CAN_COLLIDE"];
	_this = _item1163;
	_objects pushback _this;
	_objectIDs pushback 1163;
	_this setPosWorld [4562.99,3504.04,2.93215];
	_this setVectorDirAndUp [[0.798902,0.593514,-0.0974518],[0.0807353,0.0547376,0.995231]];
};

private _item1164 = objNull;
if (_layer168 && _layer239) then {
	_item1164 = createVehicle ["plp_bo_BeachTorchA_Burning",[4563.93,3501.89,0],[],0,"CAN_COLLIDE"];
	_this = _item1164;
	_objects pushback _this;
	_objectIDs pushback 1164;
	_this setPosWorld [4564.05,3501.97,2.96081];
	_this setVectorDirAndUp [[0.798172,0.594496,-0.0974466],[0.0807353,0.0547376,0.995231]];
};

private _item1165 = objNull;
if (_layer168 && _layer239) then {
	_item1165 = createVehicle ["Land_PalmTotem_01_F",[4563.22,3502.61,-1.19209e-07],[],0,"CAN_COLLIDE"];
	_this = _item1165;
	_objects pushback _this;
	_objectIDs pushback 1165;
	_this setPosWorld [4563.22,3502.61,2.12034];
	_this setVectorDirAndUp [[-0.881594,-0.472009,0],[0,0,1]];
};

private _item1301 = objNull;
if (_layer168 && _layer239) then {
	_item1301 = createVehicle ["plp_bo_BeachTorchA_Burning",[4530,3500.64,-0.00167942],[],0,"CAN_COLLIDE"];
	_this = _item1301;
	_objects pushback _this;
	_objectIDs pushback 1301;
	_this setPosWorld [4530.12,3500.76,5.61806];
	_this setVectorDirAndUp [[0.993718,-0.0365856,-0.105762],[0.108358,0.0782913,0.991024]];
};

private _item1302 = objNull;
if (_layer168 && _layer239) then {
	_item1302 = createVehicle ["plp_bo_BeachTorchA_Burning",[4528.96,3498.31,-0.00163555],[],0,"CAN_COLLIDE"];
	_this = _item1302;
	_objects pushback _this;
	_objectIDs pushback 1302;
	_this setPosWorld [4529.11,3498.46,5.9371];
	_this setVectorDirAndUp [[0.994578,-0.0367798,-0.097275],[0.100488,0.099,0.990001]];
};

private _item1303 = objNull;
if (_layer168 && _layer239) then {
	_item1303 = createVehicle ["Land_PalmTotem_01_F",[4529.42,3499.44,0],[],0,"CAN_COLLIDE"];
	_this = _item1303;
	_objects pushback _this;
	_objectIDs pushback 1303;
	_this setPosWorld [4529.42,3499.44,4.92978];
	_this setVectorDirAndUp [[-0.886316,0.462932,-0.0117584],[0.0328937,0.0882642,0.995554]];
};

private _item1356 = objNull;
if (_layer168 && _layer239) then {
	_item1356 = createVehicle ["plp_bo_BeachTorchA_Burning",[4496.94,3527.36,-0.00585413],[],0,"CAN_COLLIDE"];
	_this = _item1356;
	_objects pushback _this;
	_objectIDs pushback 1356;
	_this setPosWorld [4496.99,3527.53,6.191];
	_this setVectorDirAndUp [[0.877997,-0.464598,0.115197],[-0.086417,0.0828567,0.992808]];
};

private _item1357 = objNull;
if (_layer168 && _layer239) then {
	_item1357 = createVehicle ["plp_bo_BeachTorchA_Burning",[4495.04,3525.71,-0.0733829],[],0,"CAN_COLLIDE"];
	_this = _item1357;
	_objects pushback _this;
	_objectIDs pushback 1357;
	_this setPosWorld [4495.08,3525.88,6.37186];
	_this setVectorDirAndUp [[0.880909,-0.459104,0.114992],[-0.086417,0.0828567,0.992808]];
};

private _item1358 = objNull;
if (_layer168 && _layer239) then {
	_item1358 = createVehicle ["Land_PalmTotem_01_F",[4496.05,3526.53,4.76837e-07],[],0,"CAN_COLLIDE"];
	_this = _item1358;
	_objects pushback _this;
	_objectIDs pushback 1358;
	_this setPosWorld [4496.05,3526.53,5.4658];
	_this setVectorDirAndUp [[-0.605824,0.795512,-0.0117589],[0.0672555,0.0659344,0.995555]];
};

private _item1359 = objNull;
if (_layer168 && _layer239) then {
	_item1359 = createVehicle ["plp_bo_BeachTorchA_Burning",[4453.23,3561.28,-0.00823855],[],0,"CAN_COLLIDE"];
	_this = _item1359;
	_objects pushback _this;
	_objectIDs pushback 1359;
	_this setPosWorld [4453.33,3561.66,3.47373];
	_this setVectorDirAndUp [[-0.294388,0.932353,-0.20989],[0.0877512,0.245066,0.965527]];
};

private _item1361 = objNull;
if (_layer168 && _layer239) then {
	_item1361 = createVehicle ["Land_PalmTotem_01_F",[4454.63,3561.01,-0.0299252],[],0,"CAN_COLLIDE"];
	_this = _item1361;
	_objects pushback _this;
	_objectIDs pushback 1361;
	_this setPosWorld [4454.63,3561.01,2.6121];
	_this setVectorDirAndUp [[-0.234192,-0.972126,-0.0112228],[-0.00647865,-0.00998299,0.999929]];
};

private _item1385 = objNull;
if (_layer168 && _layer239) then {
	_item1385 = createVehicle ["plp_bo_BeachTorchA_Burning",[4455.96,3560.44,-0.0633125],[],0,"CAN_COLLIDE"];
	_this = _item1385;
	_objects pushback _this;
	_objectIDs pushback 1385;
	_this setPosWorld [4456.06,3560.82,3.44872];
	_this setVectorDirAndUp [[0.913271,-0.406847,0.0202621],[0.0877512,0.245066,0.965527]];
};

private _item1392 = objNull;
if (_layer168 && _layer239) then {
	_item1392 = createVehicle ["plp_bo_BeachTorchA_Burning",[4609.98,3467.79,-0.00335586],[],0,"CAN_COLLIDE"];
	_this = _item1392;
	_objects pushback _this;
	_objectIDs pushback 1392;
	_this setPosWorld [4609.94,3467.96,2.5331];
	_this setVectorDirAndUp [[0.989573,0.132331,0.0568735],[-0.0718139,0.111017,0.99122]];
};

private _item1393 = objNull;
if (_layer168 && _layer239) then {
	_item1393 = createVehicle ["plp_bo_BeachTorchA_Burning",[4609.42,3470.71,-0.0017947],[],0,"CAN_COLLIDE"];
	_this = _item1393;
	_objects pushback _this;
	_objectIDs pushback 1393;
	_this setPosWorld [4609.41,3470.82,2.24176];
	_this setVectorDirAndUp [[0.99213,0.125074,-0.00590615],[-0.0029901,0.0708208,0.997485]];
};

private _item179 = objNull;
if (_layer177 && _layer239) then {
	_item179 = createVehicle ["Land_Sleeping_bag_F",[4515.71,3705.92,0.0607717],[],0,"CAN_COLLIDE"];
	_this = _item179;
	_objects pushback _this;
	_objectIDs pushback 179;
	_this setPosWorld [4515.71,3705.92,3.84695];
	_this setVectorDirAndUp [[-1.17153e-05,0.99885,0.047934],[0.07238,-0.0478074,0.996231]];
};

private _item180 = objNull;
if (_layer177 && _layer239) then {
	_item180 = createVehicle ["Land_Sleeping_bag_F",[4514.02,3706.41,0.0970814],[],0,"CAN_COLLIDE"];
	_this = _item180;
	_objects pushback _this;
	_objectIDs pushback 180;
	_this setPosWorld [4514.02,3706.41,3.97041];
	_this setVectorDirAndUp [[0.0229475,0.997967,0.0594617],[0,-0.0594773,0.99823]];
};

private _item181 = objNull;
if (_layer177 && _layer239) then {
	_item181 = createVehicle ["Land_Sleeping_bag_F",[4512.75,3705.77,0],[],0,"CAN_COLLIDE"];
	_this = _item181;
	_objects pushback _this;
	_objectIDs pushback 181;
	_this setPosWorld [4512.75,3705.77,3.9965];
	_this setVectorDirAndUp [[0,1,0],[0.136704,0,0.990612]];
};

private _item182 = objNull;
if (_layer177 && _layer239) then {
	_item182 = createVehicle ["Land_Sleeping_bag_F",[4506.81,3705.73,0],[],0,"CAN_COLLIDE"];
	_this = _item182;
	_objects pushback _this;
	_objectIDs pushback 182;
	_this setPosWorld [4506.81,3705.73,4.37582];
	_this setVectorDirAndUp [[-0.296061,0.955169,0],[0,0,1]];
};

private _item183 = objNull;
if (_layer177 && _layer239) then {
	_item183 = createVehicle ["Land_Sleeping_bag_F",[4508.83,3706.35,0],[],0,"CAN_COLLIDE"];
	_this = _item183;
	_objects pushback _this;
	_objectIDs pushback 183;
	_this setPosWorld [4508.83,3706.35,4.37582];
	_this setVectorDirAndUp [[-0.258565,0.965994,0],[0,0,1]];
};

private _item184 = objNull;
if (_layer177 && _layer239) then {
	_item184 = createVehicle ["Land_ClothShelter_02_F",[4514.5,3706.63,0],[],0,"CAN_COLLIDE"];
	_this = _item184;
	_objects pushback _this;
	_objectIDs pushback 184;
	_this setPosWorld [4514.5,3706.63,5.38439];
	_this setVectorDirAndUp [[0.00414805,0.99264,0.121035],[0.0159975,-0.121087,0.992513]];
};

private _item178 = objNull;
if (_layer177 && _layer239) then {
	_item178 = createVehicle ["Land_ClothShelter_02_F",[4508.25,3706.24,0],[],0,"CAN_COLLIDE"];
	_this = _item178;
	_objects pushback _this;
	_objectIDs pushback 178;
	_this setPosWorld [4508.25,3706.24,5.86751];
	_this setVectorDirAndUp [[-0.221989,0.975049,0],[0,0,1]];
};

private _item186 = objNull;
if (_layer177 && _layer239) then {
	_item186 = createVehicle ["plp_up_LogBench",[4505.24,3693.8,0],[],0,"CAN_COLLIDE"];
	_this = _item186;
	_objects pushback _this;
	_objectIDs pushback 186;
	_this setPosWorld [4505.24,3693.8,2.8046];
	_this setVectorDirAndUp [[0.549059,0.824176,0.138812],[0.0578889,-0.203189,0.977427]];
};

private _item187 = objNull;
if (_layer177 && _layer239) then {
	_item187 = createVehicle ["Land_Campfire_F",[4503.01,3692.05,-1.19209e-07],[],0,"CAN_COLLIDE"];
	_this = _item187;
	_objects pushback _this;
	_objectIDs pushback 187;
	_this setPosWorld [4503,3691.98,2.10856];
	_this setVectorDirAndUp [[-0.068086,0.949702,0.305664],[-0.0549169,-0.309478,0.94932]];
};

private _item185 = objNull;
if (_layer177 && _layer239) then {
	_item185 = createVehicle ["plp_up_LogBench",[4500.56,3693.9,8.10623e-06],[],0,"CAN_COLLIDE"];
	_this = _item185;
	_objects pushback _this;
	_objectIDs pushback 185;
	_this setPosWorld [4500.56,3693.9,2.57833];
	_this setVectorDirAndUp [[-0.803017,0.560844,0.201536],[0.000137154,-0.337999,0.941146]];
};

private _item231 = objNull;
if (_layer177 && _layer239) then {
	_item231 = createVehicle ["plp_bo_Seashell06",[4496.28,3703.26,5.14984e-05],[],0,"CAN_COLLIDE"];
	_this = _item231;
	_objects pushback _this;
	_objectIDs pushback 231;
	_this setPosWorld [4496.28,3703.26,4.27181];
	_this setVectorDirAndUp [[0.975396,0.219056,0.024864],[0.182201,-0.864469,0.468504]];
};

private _item233 = objNull;
if (_layer177 && _layer239) then {
	_item233 = createVehicle ["plp_bo_Seashell06",[4496.3,3703.19,0],[],0,"CAN_COLLIDE"];
	_this = _item233;
	_objects pushback _this;
	_objectIDs pushback 233;
	_this setPosWorld [4496.3,3703.19,4.27334];
	_this setVectorDirAndUp [[0.995857,0.0271334,0.0867916],[0,-0.954446,0.298385]];
};

private _item232 = objNull;
if (_layer177 && _layer239) then {
	_item232 = createVehicle ["plp_bo_Seashell09",[4496.21,3703.21,0],[],0,"CAN_COLLIDE"];
	_this = _item232;
	_objects pushback _this;
	_objectIDs pushback 232;
	_this setPosWorld [4496.21,3703.21,4.27304];
	_this setVectorDirAndUp [[0,0.999712,-0.0239912],[0,0.0239912,0.999712]];
};

private _item194 = objNull;
if (_layer177 && _layer239) then {
	_item194 = createVehicle ["Lantern_01_black_F",[4507.6,3706.44,4.76837e-07],[],0,"CAN_COLLIDE"];
	_this = _item194;
	_objects pushback _this;
	_objectIDs pushback 194;
	_this setPosWorld [4507.6,3706.44,4.50496];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item237 = objNull;
if (_layer177 && _layer239) then {
	_item237 = createVehicle ["Lantern_01_black_F",[4514.07,3707.9,1.14441e-05],[],0,"CAN_COLLIDE"];
	_this = _item237;
	_objects pushback _this;
	_objectIDs pushback 237;
	_this setPosWorld [4514.07,3707.88,4.18247];
	_this setVectorDirAndUp [[0,0.99264,0.121102],[0.0159975,-0.121087,0.992513]];
};

private _item238 = objNull;
if (_layer177 && _layer239) then {
	_item238 = createVehicle ["Lantern_01_black_F",[4516.53,3693.9,1.90735e-05],[],0,"CAN_COLLIDE"];
	_this = _item238;
	_objects pushback _this;
	_objectIDs pushback 238;
	_this setPosWorld [4516.55,3693.87,2.63024];
	_this setVectorDirAndUp [[0,0.987594,0.157027],[0.136704,-0.155553,0.978323]];
};

private _item1038 = objNull;
if (_layerRoot) then {
	_item1038 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4947.81,3453.25,-0.000708342],[],0,"CAN_COLLIDE"];
	_this = _item1038;
	_objects pushback _this;
	_objectIDs pushback 1038;
	_this setPosWorld [4947.81,3453.26,1.78147];
	_this setVectorDirAndUp [[0,0.996063,-0.0886489],[-0.0249936,0.0886212,0.995752]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1039 = objNull;
if (_layerRoot) then {
	_item1039 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4968.69,3431.48,2.38419e-07],[],0,"CAN_COLLIDE"];
	_this = _item1039;
	_objects pushback _this;
	_objectIDs pushback 1039;
	_this setPosWorld [4968.68,3431.48,2.80362];
	_this setVectorDirAndUp [[0,0.998802,0.04894],[-0.0269881,-0.0489222,0.998438]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1040 = objNull;
if (_layerRoot) then {
	_item1040 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4967.98,3494.01,-8.14795e-05],[],0,"CAN_COLLIDE"];
	_this = _item1040;
	_objects pushback _this;
	_objectIDs pushback 1040;
	_this setPosWorld [4967.97,3494.03,0.523067];
	_this setVectorDirAndUp [[0,0.993339,-0.115228],[-0.0479448,0.115095,0.992197]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1041 = objNull;
if (_layerRoot) then {
	_item1041 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4944.28,3414.45,-0.00198185],[],0,"CAN_COLLIDE"];
	_this = _item1041;
	_objects pushback _this;
	_objectIDs pushback 1041;
	_this setPosWorld [4944.26,3414.44,1.44041];
	_this setVectorDirAndUp [[-0.965088,0.239806,-0.105346],[-0.118167,-0.0396881,0.9922]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1042 = objNull;
if (_layerRoot) then {
	_item1042 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4994.23,3460.39,0],[],0,"CAN_COLLIDE"];
	_this = _item1042;
	_objects pushback _this;
	_objectIDs pushback 1042;
	_this setPosWorld [4994.2,3460.4,0.417011];
	_this setVectorDirAndUp [[0,0.997559,-0.0698294],[-0.197059,0.0684601,0.977998]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1043 = objNull;
if (_layerRoot) then {
	_item1043 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5009.72,3476.05,2.38419e-07],[],0,"CAN_COLLIDE"];
	_this = _item1043;
	_objects pushback _this;
	_objectIDs pushback 1043;
	_this setPosWorld [5009.71,3476.07,1.84384];
	_this setVectorDirAndUp [[0,0.996894,-0.078755],[-0.0489402,0.0786606,0.995699]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1044 = objNull;
if (_layerRoot) then {
	_item1044 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4991.66,3449.75,-0.00792146],[],0,"CAN_COLLIDE"];
	_this = _item1044;
	_objects pushback _this;
	_objectIDs pushback 1044;
	_this setPosWorld [4991.66,3449.75,2.95362];
	_this setVectorDirAndUp [[-0.0209326,0.999781,-0.000439515],[-0.0209921,0,0.99978]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1045 = objNull;
if (_layerRoot) then {
	_item1045 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4962.59,3420.82,-0.00593352],[],0,"CAN_COLLIDE"];
	_this = _item1045;
	_objects pushback _this;
	_objectIDs pushback 1045;
	_this setPosWorld [4962.62,3420.81,2.23393];
	_this setVectorDirAndUp [[-0.972037,0.114708,0.204904],[0.199883,-0.0538085,0.978341]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1046 = objNull;
if (_layerRoot) then {
	_item1046 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5000.09,3406.18,-0.00196993],[],0,"CAN_COLLIDE"];
	_this = _item1046;
	_objects pushback _this;
	_objectIDs pushback 1046;
	_this setPosWorld [5000.04,3406.17,0.834296];
	_this setVectorDirAndUp [[-0.943623,0.119043,-0.308874],[-0.315943,-0.0454888,0.947687]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1047 = objNull;
if (_layerRoot) then {
	_item1047 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5005.47,3393.04,0],[],0,"CAN_COLLIDE"];
	_this = _item1047;
	_objects pushback _this;
	_objectIDs pushback 1047;
	_this setPosWorld [5005.42,3393.07,3.64931];
	_this setVectorDirAndUp [[0,0.984183,-0.177153],[-0.326981,0.167415,0.930084]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1048 = objNull;
if (_layerRoot) then {
	_item1048 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4974.44,3377.09,-0.00251204],[],0,"CAN_COLLIDE"];
	_this = _item1048;
	_objects pushback _this;
	_objectIDs pushback 1048;
	_this setPosWorld [4974.44,3377.08,1.11108];
	_this setVectorDirAndUp [[0,0.995611,0.0935874],[0.00198347,-0.0935872,0.995609]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1049 = objNull;
if (_layerRoot) then {
	_item1049 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4966.56,3391.35,-3.25441e-05],[],0,"CAN_COLLIDE"];
	_this = _item1049;
	_objects pushback _this;
	_objectIDs pushback 1049;
	_this setPosWorld [4966.55,3391.34,2.01868];
	_this setVectorDirAndUp [[-0.930143,0.364367,-0.0455045],[-0.0747901,-0.0666634,0.994969]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1050 = objNull;
if (_layerRoot) then {
	_item1050 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5019.99,3385.54,7.62939e-05],[],0,"CAN_COLLIDE"];
	_this = _item1050;
	_objects pushback _this;
	_objectIDs pushback 1050;
	_this setPosWorld [5020.01,3385.52,5.01976];
	_this setVectorDirAndUp [[0,0.997346,0.0728061],[0.10934,-0.0723696,0.991366]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1051 = objNull;
if (_layerRoot) then {
	_item1051 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5047.65,3371.45,-0.00232731],[],0,"CAN_COLLIDE"];
	_this = _item1051;
	_objects pushback _this;
	_objectIDs pushback 1051;
	_this setPosWorld [5047.67,3371.43,0.304103];
	_this setVectorDirAndUp [[0.928584,0.371121,0],[0,0,1]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1052 = objNull;
if (_layerRoot) then {
	_item1052 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5048.95,3394.21,0],[],0,"CAN_COLLIDE"];
	_this = _item1052;
	_objects pushback _this;
	_objectIDs pushback 1052;
	_this setPosWorld [5048.97,3394.17,1.81194];
	_this setVectorDirAndUp [[0,0.957562,0.288226],[0.0797452,-0.287308,0.954513]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1053 = objNull;
if (_layerRoot) then {
	_item1053 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5036.97,3404.15,0],[],0,"CAN_COLLIDE"];
	_this = _item1053;
	_objects pushback _this;
	_objectIDs pushback 1053;
	_this setPosWorld [5037.01,3404.16,5.0006];
	_this setVectorDirAndUp [[0,0.999353,-0.0359766],[0.278524,0.0345529,0.959807]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1054 = objNull;
if (_layerRoot) then {
	_item1054 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5047.91,3414.3,0],[],0,"CAN_COLLIDE"];
	_this = _item1054;
	_objects pushback _this;
	_objectIDs pushback 1054;
	_this setPosWorld [5047.93,3414.3,3.9345];
	_this setVectorDirAndUp [[0.995166,0.0965425,0.0179952],[-0.00996159,-0.0830584,0.996495]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1055 = objNull;
if (_layerRoot) then {
	_item1055 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5019.6,3462.24,-0.000124931],[],0,"CAN_COLLIDE"];
	_this = _item1055;
	_objects pushback _this;
	_objectIDs pushback 1055;
	_this setPosWorld [5019.62,3462.27,2.96591];
	_this setVectorDirAndUp [[0,0.98188,-0.189503],[0.0896377,0.18874,0.977928]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1056 = objNull;
if (_layerRoot) then {
	_item1056 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5074.12,3465.89,-0.000186712],[],0,"CAN_COLLIDE"];
	_this = _item1056;
	_objects pushback _this;
	_objectIDs pushback 1056;
	_this setPosWorld [5074.13,3465.91,0.635181];
	_this setVectorDirAndUp [[0,0.989367,-0.145437],[0.0129966,0.145425,0.989284]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1057 = objNull;
if (_layerRoot) then {
	_item1057 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5087.16,3440.38,0],[],0,"CAN_COLLIDE"];
	_this = _item1057;
	_objects pushback _this;
	_objectIDs pushback 1057;
	_this setPosWorld [5087.18,3440.38,1.46753];
	_this setVectorDirAndUp [[-0.918884,-0.392697,0.0379603],[0.00345832,0.0881962,0.996097]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1058 = objNull;
if (_layerRoot) then {
	_item1058 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5063.21,3429.86,-0.0576034],[],0,"CAN_COLLIDE"];
	_this = _item1058;
	_objects pushback _this;
	_objectIDs pushback 1058;
	_this setPosWorld [5063.22,3429.87,3.04522];
	_this setVectorDirAndUp [[0,0.999902,-0.0139947],[0.0359766,0.0139856,0.999255]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1059 = objNull;
if (_layerRoot) then {
	_item1059 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5057.81,3415.72,4.76837e-07],[],0,"CAN_COLLIDE"];
	_this = _item1059;
	_objects pushback _this;
	_objectIDs pushback 1059;
	_this setPosWorld [5057.81,3415.73,3.75497];
	_this setVectorDirAndUp [[0,0.998897,-0.0469484],[0.0399682,0.0469109,0.998099]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1060 = objNull;
if (_layerRoot) then {
	_item1060 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5110.38,3399.89,0],[],0,"CAN_COLLIDE"];
	_this = _item1060;
	_objects pushback _this;
	_objectIDs pushback 1060;
	_this setPosWorld [5110.38,3399.89,0.413362];
	_this setVectorDirAndUp [[-0.40473,-0.91338,0.0439412],[0.0214473,0.038558,0.999026]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1062 = objNull;
if (_layerRoot) then {
	_item1062 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5128.47,3412.57,0],[],0,"CAN_COLLIDE"];
	_this = _item1062;
	_objects pushback _this;
	_objectIDs pushback 1062;
	_this setPosWorld [5128.46,3412.58,1.41243];
	_this setVectorDirAndUp [[0.927455,0.373478,0.0184725],[-0.0379725,0.0449219,0.998269]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1063 = objNull;
if (_layerRoot) then {
	_item1063 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5130,3431.3,-0.00857145],[],0,"CAN_COLLIDE"];
	_this = _item1063;
	_objects pushback _this;
	_objectIDs pushback 1063;
	_this setPosWorld [5130.01,3431.3,0.743152];
	_this setVectorDirAndUp [[0,0.999992,0.00399666],[-0.0279894,-0.0039951,0.9996]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1064 = objNull;
if (_layerRoot) then {
	_item1064 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5021.64,3428.6,-0.00295234],[],0,"CAN_COLLIDE"];
	_this = _item1064;
	_objects pushback _this;
	_objectIDs pushback 1064;
	_this setPosWorld [5021.64,3428.63,3.73323];
	_this setVectorDirAndUp [[0,0.980202,-0.198001],[0.0179995,0.197969,0.980043]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1065 = objNull;
if (_layerRoot) then {
	_item1065 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5028.16,3410.31,-4.24385e-05],[],0,"CAN_COLLIDE"];
	_this = _item1065;
	_objects pushback _this;
	_objectIDs pushback 1065;
	_this setPosWorld [5028.15,3410.33,6.65618];
	_this setVectorDirAndUp [[0,0.990342,-0.138648],[-0.0628748,0.138373,0.988382]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1066 = objNull;
if (_layerRoot) then {
	_item1066 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5042.68,3436.31,-7.62939e-05],[],0,"CAN_COLLIDE"];
	_this = _item1066;
	_objects pushback _this;
	_objectIDs pushback 1066;
	_this setPosWorld [5042.68,3436.32,3.65185];
	_this setVectorDirAndUp [[0,0.993896,-0.110322],[-0.0209978,0.110298,0.993677]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1067 = objNull;
if (_layerRoot) then {
	_item1067 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5027.64,3445.46,0.192991],[],0,"CAN_COLLIDE"];
	_this = _item1067;
	_objects pushback _this;
	_objectIDs pushback 1067;
	_this setPosWorld [5027.64,3445.46,3.48155];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1068 = objNull;
if (_layerRoot) then {
	_item1068 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5086.08,3399.55,-0.00309396],[],0,"CAN_COLLIDE"];
	_this = _item1068;
	_objects pushback _this;
	_objectIDs pushback 1068;
	_this setPosWorld [5086.1,3399.51,2.91844];
	_this setVectorDirAndUp [[0,0.972166,0.234292],[0.133786,-0.232186,0.963427]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1069 = objNull;
if (_layerRoot) then {
	_item1069 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5055.67,3461.05,-1.19209e-07],[],0,"CAN_COLLIDE"];
	_this = _item1069;
	_objects pushback _this;
	_objectIDs pushback 1069;
	_this setPosWorld [5055.68,3461.08,2.02287];
	_this setVectorDirAndUp [[0,0.982961,-0.183814],[0.0289889,0.183737,0.982548]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1070 = objNull;
if (_layerRoot) then {
	_item1070 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4993.51,3368.9,0],[],0,"CAN_COLLIDE"];
	_this = _item1070;
	_objects pushback _this;
	_objectIDs pushback 1070;
	_this setPosWorld [4993.5,3368.88,0.963499];
	_this setVectorDirAndUp [[0.903456,0.393331,0.170464],[-0.185327,-0.000192882,0.982677]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1071 = objNull;
if (_layerRoot) then {
	_item1071 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5020.1,3495.54,0],[],0,"CAN_COLLIDE"];
	_this = _item1071;
	_objects pushback _this;
	_objectIDs pushback 1071;
	_this setPosWorld [5020.12,3495.56,0.515433];
	_this setVectorDirAndUp [[0,0.994429,-0.105409],[0.119145,0.104658,0.987346]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1072 = objNull;
if (_layerRoot) then {
	_item1072 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4492.17,3706.34,-8.7738e-05],[],0,"CAN_COLLIDE"];
	_this = _item1072;
	_objects pushback _this;
	_objectIDs pushback 1072;
	_this setPosWorld [4492.17,3706.35,4.35426];
	_this setVectorDirAndUp [[0,0.999712,-0.0239912],[0,0.0239912,0.999712]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1073 = objNull;
if (_layerRoot) then {
	_item1073 = createVehicle ["Land_HumanSkeleton_F",[4492.81,3706.89,4.76837e-07],[],0,"CAN_COLLIDE"];
	_this = _item1073;
	_objects pushback _this;
	_objectIDs pushback 1073;
	_this setPosWorld [4492.81,3706.9,4.43834];
	_this setVectorDirAndUp [[-0.999689,-0.00681479,-0.0239931],[-0.0239925,-0.000163333,0.999712]];
};

private _item1077 = objNull;
if (_layerRoot) then {
	_item1077 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5027.33,3432.72,-0.0819421],[],0,"CAN_COLLIDE"];
	_this = _item1077;
	_objects pushback _this;
	_objectIDs pushback 1077;
	_this setPosWorld [5027.33,3432.72,3.24596];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1078 = objNull;
if (_layerRoot) then {
	_item1078 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5070.68,3406.17,0],[],0,"CAN_COLLIDE"];
	_this = _item1078;
	_objects pushback _this;
	_objectIDs pushback 1078;
	_this setPosWorld [5070.68,3406.16,4.54339];
	_this setVectorDirAndUp [[0,0.998205,0.0598914],[0.0339803,-0.0598568,0.997628]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1079 = objNull;
if (_layerRoot) then {
	_item1079 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5090.68,3416.33,0],[],0,"CAN_COLLIDE"];
	_this = _item1079;
	_objects pushback _this;
	_objectIDs pushback 1079;
	_this setPosWorld [5090.72,3416.34,0.931938];
	_this setVectorDirAndUp [[0,0.993676,-0.112285],[0.248003,0.108777,0.962633]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1080 = objNull;
if (_layerRoot) then {
	_item1080 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5068.84,3447.34,0],[],0,"CAN_COLLIDE"];
	_this = _item1080;
	_objects pushback _this;
	_objectIDs pushback 1080;
	_this setPosWorld [5068.84,3447.33,2.61055];
	_this setVectorDirAndUp [[0,0.999872,0.0159975],[-0.0029901,-0.0159974,0.999868]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1081 = objNull;
if (_layerRoot) then {
	_item1081 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4993.76,3483.43,-0.00201261],[],0,"CAN_COLLIDE"];
	_this = _item1081;
	_objects pushback _this;
	_objectIDs pushback 1081;
	_this setPosWorld [4993.74,3483.4,0.91934];
	_this setVectorDirAndUp [[0,0.984183,0.177152],[-0.119145,-0.17589,0.977173]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1082 = objNull;
if (_layerRoot) then {
	_item1082 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4951.15,3486.17,3.72529e-09],[],0,"CAN_COLLIDE"];
	_this = _item1082;
	_objects pushback _this;
	_objectIDs pushback 1082;
	_this setPosWorld [4951.15,3486.19,0.208257];
	_this setVectorDirAndUp [[0,0.994429,-0.10541],[-0.0489415,0.105283,0.993237]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1083 = objNull;
if (_layerRoot) then {
	_item1083 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5117.59,3455.49,0],[],0,"CAN_COLLIDE"];
	_this = _item1083;
	_objects pushback _this;
	_objectIDs pushback 1083;
	_this setPosWorld [5117.59,3455.49,1.02196];
	_this setVectorDirAndUp [[0,0.9998,0.0199947],[-0.00600007,-0.0199943,0.999782]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1084 = objNull;
if (_layerRoot) then {
	_item1084 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5058.8,3443.68,-3.55244e-05],[],0,"CAN_COLLIDE"];
	_this = _item1084;
	_objects pushback _this;
	_objectIDs pushback 1084;
	_this setPosWorld [5058.81,3443.69,2.89755];
	_this setVectorDirAndUp [[0,0.999279,-0.0379725],[0.0259917,0.0379597,0.998941]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1085 = objNull;
if (_layerRoot) then {
	_item1085 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5001.05,3374.95,-0.004812],[],0,"CAN_COLLIDE"];
	_this = _item1085;
	_objects pushback _this;
	_objectIDs pushback 1085;
	_this setPosWorld [5001.03,3374.94,2.19888];
	_this setVectorDirAndUp [[0.439797,0.895534,-0.0678004],[-0.0648893,0.106982,0.992141]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1201 = objNull;
if (_layerRoot) then {
	_item1201 = createVehicle ["plp_upm_BistroTblMtlBigDrk",[4555.52,3516.19,0.147113],[],0,"CAN_COLLIDE"];
	_this = _item1201;
	_objects pushback _this;
	_objectIDs pushback 1201;
	_this setPosWorld [4555.54,3516.22,1.72518];
	_this setVectorDirAndUp [[0.877822,0.473341,-0.0733309],[0.0510255,0.0598146,0.996904]];
};

private _item1202 = objNull;
if (_layerRoot) then {
	_item1202 = createVehicle ["Land_PortableSpeakers_01_F",[4555.91,3515.98,0.93392],[],0,"CAN_COLLIDE"];
	_this = _item1202;
	_objects pushback _this;
	_objectIDs pushback 1202;
	_this setPosWorld [4555.91,3515.98,2.14596];
	_this setVectorDirAndUp [[-0.765479,0.64346,0],[0,0,1]];
};

private _item1203 = objNull;
if (_layerRoot) then {
	_item1203 = createVehicle ["Land_Laptop_Intel_Oldman_F",[4555.52,3516.36,0.908469],[],0,"CAN_COLLIDE"];
	_this = _item1203;
	_objects pushback _this;
	_objectIDs pushback 1203;
	_this setPosWorld [4555.53,3516.37,2.24057];
	_this setVectorDirAndUp [[-0.405519,-0.910967,0.0754519],[0.0511174,0.0598143,0.9969]];
	_this setObjectTextureGlobal [0,"a3\missions_f_oldman\data\img\screens\csatntb_co.paa"];
};

private _item1205 = objNull;
if (_layerRoot) then {
	_item1205 = createVehicle ["land_MRP_MEUBLE_ChaisePlastique",[4556.65,3514.01,0],[],0,"CAN_COLLIDE"];
	_this = _item1205;
	_objects pushback _this;
	_objectIDs pushback 1205;
	_this setPosWorld [4556.67,3514.04,1.74104];
	_this setVectorDirAndUp [[-0.324685,-0.942988,0.0731685],[0.0509345,0.0598149,0.996909]];
};

private _item1213 = objNull;
if (_layerRoot) then {
	_item1213 = createVehicle ["Land_Saw_F",[4555.58,3516.25,0.0308803],[],0,"CAN_COLLIDE"];
	_this = _item1213;
	_objects pushback _this;
	_objectIDs pushback 1213;
	_this setPosWorld [4555.58,3516.25,1.22151];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item1214 = objNull;
if (_layerRoot) then {
	_item1214 = createVehicle ["Land_MoneyBills_01_bunch_F",[4555.57,3515.76,0.933988],[],0,"CAN_COLLIDE"];
	_this = _item1214;
	_objects pushback _this;
	_objectIDs pushback 1214;
	_this setPosWorld [4555.57,3515.76,2.14924];
	_this setVectorDirAndUp [[0,0.998205,-0.0598926],[0.0511164,0.0598143,0.9969]];
};

private _item1215 = objNull;
if (_layerRoot) then {
	_item1215 = createVehicle ["Land_File_F",[4555.42,3515.89,0.0201454],[],0,"CAN_COLLIDE"];
	_this = _item1215;
	_objects pushback _this;
	_objectIDs pushback 1215;
	_this setPosWorld [4555.42,3515.89,1.24961];
	_this setVectorDirAndUp [[-0.912804,0.408398,0],[0,0,1]];
};

private _item1217 = objNull;
if (_layerRoot) then {
	_item1217 = createVehicle ["Land_Hammer_F",[4555.99,3513.38,0.0856113],[],0,"CAN_COLLIDE"];
	_this = _item1217;
	_objects pushback _this;
	_objectIDs pushback 1217;
	_this setPosWorld [4555.99,3513.39,1.48271];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item1218 = objNull;
if (_layerRoot) then {
	_item1218 = createVehicle ["Land_GasTank_01_yellow_F",[4553.59,3515.7,-3.20673e-05],[],0,"CAN_COLLIDE"];
	_this = _item1218;
	_objects pushback _this;
	_objectIDs pushback 1218;
	_this setPosWorld [4553.61,3515.72,1.65847];
	_this setVectorDirAndUp [[0,0.997628,-0.0688362],[0.0598924,0.0687127,0.995837]];
};

private _item1221 = objNull;
if (_layerRoot) then {
	_item1221 = createVehicle ["AluminiumFoil_01_F",[4555.57,3513.05,0],[],0,"CAN_COLLIDE"];
	_this = _item1221;
	_objects pushback _this;
	_objectIDs pushback 1221;
	_this setPosWorld [4555.59,3513.07,1.65394];
	_this setVectorDirAndUp [[0.673399,-0.739205,0.010505],[0.0598924,0.0687127,0.995837]];
};

private _item1222 = objNull;
if (_layerRoot) then {
	_item1222 = createVehicle ["Land_Gloves_F",[4555.13,3513.23,0.0857176],[],0,"CAN_COLLIDE"];
	_this = _item1222;
	_objects pushback _this;
	_objectIDs pushback 1222;
	_this setPosWorld [4555.13,3513.23,1.48502];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item1223 = objNull;
if (_layerRoot) then {
	_item1223 = createVehicle ["Land_MetalWire_F",[4555.48,3513.5,0.0854013],[],0,"CAN_COLLIDE"];
	_this = _item1223;
	_objects pushback _this;
	_objectIDs pushback 1223;
	_this setPosWorld [4555.48,3513.5,1.44743];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item1226 = objNull;
if (_layerRoot) then {
	_item1226 = createVehicle ["Land_Sign_Mines_F",[4555.12,3512.72,0],[],0,"CAN_COLLIDE"];
	_this = _item1226;
	_objects pushback _this;
	_objectIDs pushback 1226;
	_this setPosWorld [4555.12,3512.72,1.61883];
	_this setVectorDirAndUp [[0.776401,-0.630239,0],[0,0,1]];
	_this setObjectTextureGlobal [0,"a3\signs_f\signm\data\signm_mines_co.paa"];
	_this setObjectMaterialGlobal [0,""];
};

private _item1228 = objNull;
if (_layerRoot) then {
	_item1228 = createVehicle ["plp_bo_Seashell08",[4555.47,3513.53,0.0854139],[],0,"CAN_COLLIDE"];
	_this = _item1228;
	_objects pushback _this;
	_objectIDs pushback 1228;
	_this setPosWorld [4555.47,3513.53,1.44389];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item1230 = objNull;
if (_layerRoot) then {
	_item1230 = createVehicle ["land_bouteille_rhum",[4556.75,3514.27,0],[],0,"CAN_COLLIDE"];
	_this = _item1230;
	_objects pushback _this;
	_objectIDs pushback 1230;
	_this setPosWorld [4556.75,3514.27,1.35981];
	_this setVectorDirAndUp [[0,0.998205,-0.0598926],[0.0509345,0.0598149,0.996909]];
	[_this,"[[[[],[]],[[""bouteille_rhum""],[1]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1231 = objNull;
if (_layerRoot) then {
	_item1231 = createVehicle ["Land_MRP_Iphone_12",[4555.41,3515.96,0.934033],[],0,"CAN_COLLIDE"];
	_this = _item1231;
	_objects pushback _this;
	_objectIDs pushback 1231;
	_this setPosWorld [4555.41,3515.96,2.20166];
	_this setVectorDirAndUp [[0,0.998205,-0.0598926],[0.0511164,0.0598143,0.9969]];
};

private _item1233 = objNull;
if (_layerRoot) then {
	_item1233 = createVehicle ["land_bouteille_rhum",[4554.09,3515.75,-1.06096e-05],[],0,"CAN_COLLIDE"];
	_this = _item1233;
	_objects pushback _this;
	_objectIDs pushback 1233;
	_this setPosWorld [4554.1,3515.76,1.4074];
	_this setVectorDirAndUp [[0,0.997628,-0.0688362],[0.0598924,0.0687127,0.995837]];
	[_this,"[[[[],[]],[[""bouteille_rhum""],[1]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1234 = objNull;
if (_layerRoot) then {
	_item1234 = createVehicle ["land_bouteille_rhum",[4555.16,3512.9,0],[],0,"CAN_COLLIDE"];
	_this = _item1234;
	_objects pushback _this;
	_objectIDs pushback 1234;
	_this setPosWorld [4555.17,3512.91,1.53985];
	_this setVectorDirAndUp [[0,0.997628,-0.0688362],[0.0598924,0.0687127,0.995837]];
	[_this,"[[[[],[]],[[""bouteille_rhum""],[1]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1235 = objNull;
if (_layerRoot) then {
	_item1235 = createVehicle ["land_bouteille_rhum",[4555.2,3516.45,0],[],0,"CAN_COLLIDE"];
	_this = _item1235;
	_objects pushback _this;
	_objectIDs pushback 1235;
	_this setPosWorld [4555.21,3516.45,1.30784];
	_this setVectorDirAndUp [[0,0.998205,-0.0598926],[0.0509345,0.0598149,0.996909]];
	[_this,"[[[[],[]],[[""bouteille_rhum""],[1]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1236 = objNull;
if (_layerRoot) then {
	_item1236 = createVehicle ["land_bouteille_rhum",[4556.43,3513.52,-1.07288e-05],[],0,"CAN_COLLIDE"];
	_this = _item1236;
	_objects pushback _this;
	_objectIDs pushback 1236;
	_this setPosWorld [4556.43,3513.53,1.42132];
	_this setVectorDirAndUp [[0,0.997628,-0.0688362],[0.0598924,0.0687127,0.995837]];
	[_this,"[[[[],[]],[[""bouteille_rhum""],[1]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1237 = objNull;
if (_layerRoot) then {
	_item1237 = createVehicle ["land_bouteille_rhum",[4555.45,3516.66,0],[],0,"CAN_COLLIDE"];
	_this = _item1237;
	_objects pushback _this;
	_objectIDs pushback 1237;
	_this setPosWorld [4555.46,3516.67,1.28222];
	_this setVectorDirAndUp [[0,0.998205,-0.0598926],[0.0509345,0.0598149,0.996909]];
	[_this,"[[[[],[]],[[""bouteille_rhum""],[1]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1241 = objNull;
if (_layerRoot) then {
	_item1241 = createVehicle ["murshun_cigs_cigpackItem",[4555.1,3516.23,0],[],0,"CAN_COLLIDE"];
	_this = _item1241;
	_objects pushback _this;
	_objectIDs pushback 1241;
	_this setPosWorld [4555.1,3516.23,1.20594];
	_this setVectorDirAndUp [[0,0.998205,-0.0598926],[0.0509345,0.0598149,0.996909]];
};

private _item1258 = objNull;
if (_layerRoot) then {
	_item1258 = createVehicle ["plp_up_BarrierTapePoliceGround",[4553.99,3515.39,0],[],0,"CAN_COLLIDE"];
	_this = _item1258;
	_objects pushback _this;
	_objectIDs pushback 1258;
	_this setPosWorld [4553.99,3515.39,1.35658];
	_this setVectorDirAndUp [[-0.836233,0.548374,0],[0,0,1]];
};

private _item1263 = objNull;
if (_layerRoot) then {
	_item1263 = createVehicle ["Land_Rug_01_F",[4554.31,3515.29,0],[],0,"CAN_COLLIDE"];
	_this = _item1263;
	_objects pushback _this;
	_objectIDs pushback 1263;
	_this setPosWorld [4554.31,3515.29,1.31732];
	_this setVectorDirAndUp [[-0.446395,0.894157,-0.0348493],[0.0598924,0.0687127,0.995837]];
};

private _item1265 = objNull;
if (_layerRoot) then {
	_item1265 = createVehicle ["Land_Rug_01_F",[4555.19,3513.48,0],[],0,"CAN_COLLIDE"];
	_this = _item1265;
	_objects pushback _this;
	_objectIDs pushback 1265;
	_this setPosWorld [4555.19,3513.48,1.38878];
	_this setVectorDirAndUp [[-0.446395,0.894157,-0.0348493],[0.0598924,0.0687127,0.995837]];
};

private _item1268 = objNull;
if (_layerRoot) then {
	_item1268 = createVehicle ["murshun_cigs_lighterItem",[4555.03,3516.36,0.0147176],[],0,"CAN_COLLIDE"];
	_this = _item1268;
	_objects pushback _this;
	_objectIDs pushback 1268;
	_this setPosWorld [4555.03,3516.36,1.21628];
	_this setVectorDirAndUp [[0,0.998205,-0.0598926],[0.0509345,0.0598149,0.996909]];
};

private _item1266 = objNull;
if (_layerRoot) then {
	_item1266 = createVehicle ["Land_Rug_01_F",[4556.56,3514.17,0],[],0,"CAN_COLLIDE"];
	_this = _item1266;
	_objects pushback _this;
	_objectIDs pushback 1266;
	_this setPosWorld [4556.56,3514.17,1.26577];
	_this setVectorDirAndUp [[-0.446617,0.894194,-0.0308331],[0.0509345,0.0598149,0.996909]];
};

private _item1269 = objNull;
if (_layerRoot) then {
	_item1269 = createVehicle ["immersion_pops_poppackItem",[4556.16,3514.17,0.014704],[],0,"CAN_COLLIDE"];
	_this = _item1269;
	_objects pushback _this;
	_objectIDs pushback 1269;
	_this setPosWorld [4556.16,3514.17,1.29047];
	_this setVectorDirAndUp [[0,0.998205,-0.0598926],[0.0509345,0.0598149,0.996909]];
};

private _item1270 = objNull;
if (_layerRoot) then {
	_item1270 = createVehicle ["immersion_pops_poppackItem",[4556.13,3514.29,0.014721],[],0,"CAN_COLLIDE"];
	_this = _item1270;
	_objects pushback _this;
	_objectIDs pushback 1270;
	_this setPosWorld [4556.13,3514.29,1.28486];
	_this setVectorDirAndUp [[-0.846555,-0.52892,-0.059895],[-0.0777162,0.0114973,0.996909]];
};

private _item1271 = objNull;
if (_layerRoot) then {
	_item1271 = createVehicle ["immersion_pops_poppackItem",[4556.26,3514.28,0.0147234],[],0,"CAN_COLLIDE"];
	_this = _item1271;
	_objects pushback _this;
	_objectIDs pushback 1271;
	_this setPosWorld [4556.26,3514.28,1.27871];
	_this setVectorDirAndUp [[-0.98051,0.187117,-0.0598941],[-0.0492086,0.0612418,0.996909]];
};

private _item1272 = objNull;
if (_layerRoot) then {
	_item1272 = createVehicle ["immersion_pops_poppackItem",[4556.13,3513.96,0.0147345],[],0,"CAN_COLLIDE"];
	_this = _item1272;
	_objects pushback _this;
	_objectIDs pushback 1272;
	_this setPosWorld [4556.13,3513.96,1.30445];
	_this setVectorDirAndUp [[-0.302588,-0.951238,-0.0598903],[-0.0666666,-0.0415592,0.996909]];
};

private _item1275 = objNull;
if (_layerRoot) then {
	_item1275 = createVehicle ["plp_bo_CigarBox_Stc",[4555.67,3514.39,0.0150689],[],0,"CAN_COLLIDE"];
	_this = _item1275;
	_objects pushback _this;
	_objectIDs pushback 1275;
	_this setPosWorld [4555.67,3514.39,1.39874];
	_this setVectorDirAndUp [[0,0.998205,-0.0598926],[0.0509345,0.0598149,0.996909]];
};

private _item1281 = objNull;
if (_layerRoot) then {
	_item1281 = createVehicle ["plp_bo_BeachBagSmallPink_Stc",[4556.47,3514.56,1.19209e-07],[],0,"CAN_COLLIDE"];
	_this = _item1281;
	_objects pushback _this;
	_objectIDs pushback 1281;
	_this setPosWorld [4556.47,3514.56,1.46234];
	_this setVectorDirAndUp [[0.561642,-0.827116,0.0209315],[0.0509345,0.0598149,0.996909]];
};

private _item1282 = objNull;
if (_layerRoot) then {
	_item1282 = createVehicle ["Land_Shoot_House_Corner_F",[4555.87,3516.73,0],[],0,"CAN_COLLIDE"];
	_this = _item1282;
	_objects pushback _this;
	_objectIDs pushback 1282;
	_this setPosWorld [4555.87,3516.73,2.81986];
	_this setVectorDirAndUp [[0.42995,-0.902279,0.0321698],[0.0509345,0.0598149,0.996909]];
};

private _item1283 = objNull;
if (_layerRoot) then {
	_item1283 = createVehicle ["Land_Shoot_House_Corner_F",[4557.28,3513.89,-1.19209e-07],[],0,"CAN_COLLIDE"];
	_this = _item1283;
	_objects pushback _this;
	_objectIDs pushback 1283;
	_this setPosWorld [4557.28,3513.89,2.91799];
	_this setVectorDirAndUp [[-0.887635,-0.454784,0.0726386],[0.0509345,0.0598149,0.996909]];
};

private _item1284 = objNull;
if (_layerRoot) then {
	_item1284 = createVehicle ["Land_Shoot_House_Corner_F",[4553.77,3515.72,0],[],0,"CAN_COLLIDE"];
	_this = _item1284;
	_objects pushback _this;
	_objectIDs pushback 1284;
	_this setPosWorld [4553.77,3515.72,2.99252];
	_this setVectorDirAndUp [[0.887717,0.452395,-0.0854182],[0.0615696,0.0672116,0.995837]];
};

private _item1285 = objNull;
if (_layerRoot) then {
	_item1285 = createVehicle ["Land_Shoot_House_Corner_F",[4555.19,3512.88,-1.19209e-07],[],0,"CAN_COLLIDE"];
	_this = _item1285;
	_objects pushback _this;
	_objectIDs pushback 1285;
	_this setPosWorld [4555.19,3512.88,3.10341];
	_this setVectorDirAndUp [[-0.445811,0.894446,-0.0349044],[0.0598924,0.0687127,0.995837]];
};

private _item1286 = objNull;
if (_layerRoot) then {
	_item1286 = createVehicle ["Land_Shoot_House_Wall_F",[4556.49,3513.08,1.19209e-07],[],0,"CAN_COLLIDE"];
	_this = _item1286;
	_objects pushback _this;
	_objectIDs pushback 1286;
	_this setPosWorld [4556.49,3513.08,3.00347];
	_this setVectorDirAndUp [[-0.438355,0.898096,-0.0356047],[0.0598924,0.0687127,0.995837]];
};

private _item1287 = objNull;
if (_layerRoot) then {
	_item1287 = createVehicle ["Land_Shoot_House_Wall_F",[4554.57,3516.54,-1.19209e-07],[],0,"CAN_COLLIDE"];
	_this = _item1287;
	_objects pushback _this;
	_objectIDs pushback 1287;
	_this setPosWorld [4554.57,3516.54,2.88994];
	_this setVectorDirAndUp [[-0.438573,0.898144,-0.0314811],[0.0509345,0.0598149,0.996909]];
};

private _item1288 = objNull;
if (_layerRoot) then {
	_item1288 = createVehicle ["Land_Shoot_House_Wall_F",[4556.93,3515.48,-1.19209e-07],[],0,"CAN_COLLIDE"];
	_this = _item1288;
	_objects pushback _this;
	_objectIDs pushback 1288;
	_this setPosWorld [4556.93,3515.48,2.8331];
	_this setVectorDirAndUp [[0.897481,0.435142,-0.0719632],[0.0509345,0.0598149,0.996909]];
};

private _item1289 = objNull;
if (_layerRoot) then {
	_item1289 = createVehicle ["Land_Shoot_House_Wall_F",[4553.69,3512.66,-1.19209e-07],[],0,"CAN_COLLIDE"];
	_this = _item1289;
	_objects pushback _this;
	_objectIDs pushback 1289;
	_this setPosWorld [4553.69,3512.66,3.20007];
	_this setVectorDirAndUp [[-0.438355,0.898096,-0.0356047],[0.0598924,0.0687127,0.995837]];
};

private _item1290 = objNull;
if (_layerRoot) then {
	_item1290 = createVehicle ["Land_Shoot_House_Wall_F",[4553.1,3513.59,0],[],0,"CAN_COLLIDE"];
	_this = _item1290;
	_objects pushback _this;
	_objectIDs pushback 1290;
	_this setPosWorld [4553.1,3513.59,3.17146];
	_this setVectorDirAndUp [[0.838399,0.537981,-0.0875442],[0.0598924,0.0687127,0.995837]];
};

private _item1291 = objNull;
if (_layerRoot) then {
	_item1291 = createVehicle ["Land_Shoot_House_Wall_F",[4552.39,3515.45,0],[],0,"CAN_COLLIDE"];
	_this = _item1291;
	_objects pushback _this;
	_objectIDs pushback 1291;
	_this setPosWorld [4552.39,3515.45,3.08595];
	_this setVectorDirAndUp [[-0.438355,0.898096,-0.0356047],[0.0598924,0.0687127,0.995837]];
};

private _item1292 = objNull;
if (_layerRoot) then {
	_item1292 = createVehicle ["Land_TimberLog_02_F",[4567.42,3504.68,0],[],0,"CAN_COLLIDE"];
	_this = _item1292;
	_objects pushback _this;
	_objectIDs pushback 1292;
	_this setPosWorld [4567.42,3504.68,1.15751];
	_this setVectorDirAndUp [[-0.393194,0.919362,-0.0131274],[0.264802,0.1269,0.955916]];
};

private _item1267 = objNull;
if (_layerRoot) then {
	_item1267 = createVehicle ["Land_Rug_01_F",[4555.69,3515.97,0],[],0,"CAN_COLLIDE"];
	_this = _item1267;
	_objects pushback _this;
	_objectIDs pushback 1267;
	_this setPosWorld [4555.69,3515.97,1.20239];
	_this setVectorDirAndUp [[-0.446617,0.894194,-0.0308331],[0.0509345,0.0598149,0.996909]];
};

private _item1296 = objNull;
if (_layerRoot) then {
	_item1296 = createVehicle ["immersion_pops_poppackItem",[4555.67,3515.55,0.0146583],[],0,"CAN_COLLIDE"];
	_this = _item1296;
	_objects pushback _this;
	_objectIDs pushback 1296;
	_this setPosWorld [4555.67,3515.55,1.23282];
	_this setVectorDirAndUp [[0,0.998205,-0.0598926],[0.0509345,0.0598149,0.996909]];
};

private _item1310 = objNull;
if (_layerRoot) then {
	_item1310 = createVehicle ["Land_TimberLog_02_F",[4523.43,3502.03,0],[],0,"CAN_COLLIDE"];
	_this = _item1310;
	_objects pushback _this;
	_objectIDs pushback 1310;
	_this setPosWorld [4523.43,3502.03,4.80264];
	_this setVectorDirAndUp [[0.499168,0.859119,-0.112896],[0.343311,-0.0764586,0.936104]];
};

private _item1312 = objNull;
if (_layerRoot) then {
	_item1312 = createVehicle ["Land_TimberLog_02_F",[4519.28,3500.73,4.76837e-07],[],0,"CAN_COLLIDE"];
	_this = _item1312;
	_objects pushback _this;
	_objectIDs pushback 1312;
	_this setPosWorld [4519.28,3500.73,5.3504];
	_this setVectorDirAndUp [[0.919863,-0.389954,-0.0422744],[-0.024713,-0.165181,0.985954]];
};

private _item1313 = objNull;
if (_layerRoot) then {
	_item1313 = createVehicle ["Land_TimberLog_02_F",[4522.28,3505.52,4.76837e-07],[],0,"CAN_COLLIDE"];
	_this = _item1313;
	_objects pushback _this;
	_objectIDs pushback 1313;
	_this setPosWorld [4522.28,3505.52,4.67144];
	_this setVectorDirAndUp [[0.919863,-0.389954,-0.0422744],[-0.024713,-0.165181,0.985954]];
};

private _item1314 = objNull;
if (_layerRoot) then {
	_item1314 = createVehicle ["Land_TimberLog_02_F",[4518.19,3504.27,0],[],0,"CAN_COLLIDE"];
	_this = _item1314;
	_objects pushback _this;
	_objectIDs pushback 1314;
	_this setPosWorld [4518.19,3504.27,5.26251];
	_this setVectorDirAndUp [[0.521418,0.842093,-0.137851],[0.207319,0.0316895,0.97776]];
};

private _item1331 = objNull;
if (_layerRoot) then {
	_item1331 = _item1330 createUnit ["C_man_polo_3_F",[4566.64,3495.98,2.7096],[],0,"CAN_COLLIDE"];
	_item1330 selectLeader _item1331;
	_this = _item1331;
	_objects pushback _this;
	_objectIDs pushback 1331;
	_this setPosWorld [4566.64,3496.03,4.18983];
	_this setVectorDirAndUp [[0.977948,-0.208848,0],[0,0,1]];
	selectPlayer _this;
	_this setname "Stergos Petridis";;
	_this setface "GreekHead_A3_07";;
	_this setspeaker "male02gre";;
	_this setpitch 0.952301;;
};

private _item1343 = objNull;
if (_layerRoot) then {
	_item1343 = createVehicle ["VR_Area_01_circle_4_yellow_F",[4482.1,3536.97,0.0666618],[],0,"CAN_COLLIDE"];
	_this = _item1343;
	_objects pushback _this;
	_objectIDs pushback 1343;
	_this setPosWorld [4482.1,3536.97,3.54287];
	_this setVectorDirAndUp [[-0.00824528,0.983706,-0.179596],[0.0384916,0.179782,0.982953]];
	_this setObjectTextureGlobal [0,"#(argb,8,8,3)color(0.581,0.441,0.293,1,co)"];
};

private _item1344 = objNull;
if (_layerRoot) then {
	_item1344 = createVehicle ["AreaMarker_01_F",[4482.02,3536.99,0],[],0,"CAN_COLLIDE"];
	_this = _item1344;
	_objects pushback _this;
	_objectIDs pushback 1344;
	_this setPosWorld [4482.02,3536.99,3.47481];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
	_this setObjectTextureGlobal [0,"a3\props_f_decade\objectives\data\confrontationarea_01_area_f_ca.paa"];
	_this setObjectMaterialGlobal [0,""];
};

private _item1350 = objNull;
if (_layerRoot) then {
	_item1350 = createVehicle ["Land_Trophy_01_gold_F",[4591.71,3465.92,0.0333341],[],0,"CAN_COLLIDE"];
	_this = _item1350;
	_objects pushback _this;
	_objectIDs pushback 1350;
	_this setPosWorld [4591.7,3465.93,1.38162];
	_this setVectorDirAndUp [[0.975408,0.220403,0.000780137],[-0.0156045,0.0655273,0.997729]];
};

private _item1354 = objNull;
if (_layerRoot) then {
	_item1354 = createVehicle ["Land_ConnectorTent_01_floor_light_F",[4482.02,3537.11,0],[],0,"CAN_COLLIDE"];
	_this = _item1354;
	_objects pushback _this;
	_objectIDs pushback 1354;
	_this setPosWorld [4482.02,3537.11,3.45196];
	_this setVectorDirAndUp [[0,0.982961,-0.183814],[0.023991,0.183761,0.982678]];
};

private _item1368 = objNull;
if (_layerRoot) then {
	_item1368 = createVehicle ["land_MRP_meuble_table_3_3",[4455.3,3551.84,0],[],0,"CAN_COLLIDE"];
	_this = _item1368;
	_objects pushback _this;
	_objectIDs pushback 1368;
	_this setPosWorld [4455.3,3551.84,4.12622];
	_this setVectorDirAndUp [[-0.960087,-0.256108,0.112434],[0.0678431,0.176745,0.981916]];
};

private _item1378 = objNull;
if (_layerRoot) then {
	_item1378 = createVehicle ["land_MRP_meuble_table_3_3",[4455.88,3554.98,0],[],0,"CAN_COLLIDE"];
	_this = _item1378;
	_objects pushback _this;
	_objectIDs pushback 1378;
	_this setPosWorld [4455.88,3554.98,3.52055];
	_this setVectorDirAndUp [[-0.956456,-0.268019,0.115579],[0.0688359,0.177684,0.981677]];
};

private _item1379 = objNull;
if (_layerRoot) then {
	_item1379 = createVehicle ["land_MRP_meuble_table_3_3",[4451.42,3549.86,0],[],0,"CAN_COLLIDE"];
	_this = _item1379;
	_objects pushback _this;
	_objectIDs pushback 1379;
	_this setPosWorld [4451.42,3549.86,4.74296];
	_this setVectorDirAndUp [[-0.962687,-0.249044,0.105883],[0.0678431,0.156666,0.985319]];
};

private _item1380 = objNull;
if (_layerRoot) then {
	_item1380 = createVehicle ["land_MRP_meuble_table_3_3",[4449.49,3553.39,0],[],0,"CAN_COLLIDE"];
	_this = _item1380;
	_objects pushback _this;
	_objectIDs pushback 1380;
	_this setPosWorld [4449.49,3553.39,4.25051];
	_this setVectorDirAndUp [[-0.960878,-0.246918,0.125479],[0.0827151,0.176546,0.980811]];
};

private _item1381 = objNull;
if (_layerRoot) then {
	_item1381 = createVehicle ["land_MRP_meuble_table_3_3",[4450.5,3556.53,0],[],0,"CAN_COLLIDE"];
	_this = _item1381;
	_objects pushback _this;
	_objectIDs pushback 1381;
	_this setPosWorld [4450.5,3556.53,3.60824];
	_this setVectorDirAndUp [[-0.96765,-0.228057,0.107908],[0.0678431,0.176745,0.981916]];
};

private _item1387 = objNull;
if (_layerRoot) then {
	_item1387 = createVehicle ["ALF_TapisRouge",[4600.48,3467.54,-0.400748],[],0,"CAN_COLLIDE"];
	_this = _item1387;
	_objects pushback _this;
	_objectIDs pushback 1387;
	_this setPosWorld [4600.48,3467.54,0.434365];
	_this setVectorDirAndUp [[-0.185753,0.982596,0],[0,0,1]];
};

private _item1389 = objNull;
if (_layerRoot) then {
	_item1389 = createVehicle ["Land_WinnersPodium_01_F",[4591.23,3465.87,0.0176466],[],0,"CAN_COLLIDE"];
	_this = _item1389;
	_objects pushback _this;
	_objectIDs pushback 1389;
	_this setPosWorld [4591.23,3465.87,1.63491];
	_this setVectorDirAndUp [[-0.976109,-0.217277,-0.000996418],[-0.0156045,0.0655273,0.997729]];
};

private _item1390 = objNull;
if (_layerRoot) then {
	_item1390 = createVehicle ["Land_Trophy_01_silver_F",[4591.91,3465.06,0.0192983],[],0,"CAN_COLLIDE"];
	_this = _item1390;
	_objects pushback _this;
	_objectIDs pushback 1390;
	_this setPosWorld [4591.9,3465.06,1.41533];
	_this setVectorDirAndUp [[0.955482,0.295015,-0.00443176],[-0.0156045,0.0655273,0.997729]];
};

private _item1391 = objNull;
if (_layerRoot) then {
	_item1391 = createVehicle ["Land_Trophy_01_bronze_F",[4591.49,3466.92,-0.00791562],[],0,"CAN_COLLIDE"];
	_this = _item1391;
	_objects pushback _this;
	_objectIDs pushback 1391;
	_this setPosWorld [4591.48,3466.93,1.28596];
	_this setVectorDirAndUp [[0.975665,0.219263,0.000859017],[-0.0156045,0.0655273,0.997729]];
};

private _item1397 = objNull;
if (_layerRoot) then {
	_item1397 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4455.94,3555.14,0.85183],[],0,"CAN_COLLIDE"];
	_this = _item1397;
	_objects pushback _this;
	_objectIDs pushback 1397;
	_this setPosWorld [4455.95,3555.17,4.05498];
	_this setVectorDirAndUp [[0,0.989537,-0.144278],[0,0.144278,0.989537]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1398 = objNull;
if (_layerRoot) then {
	_item1398 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4455.3,3551.92,0.853898],[],0,"CAN_COLLIDE"];
	_this = _item1398;
	_objects pushback _this;
	_objectIDs pushback 1398;
	_this setPosWorld [4455.31,3551.95,4.68151];
	_this setVectorDirAndUp [[0,0.986656,-0.162819],[0,0.162819,0.986656]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1399 = objNull;
if (_layerRoot) then {
	_item1399 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4451.49,3549.94,0.85303],[],0,"CAN_COLLIDE"];
	_this = _item1399;
	_objects pushback _this;
	_objectIDs pushback 1399;
	_this setPosWorld [4451.5,3549.97,5.29523];
	_this setVectorDirAndUp [[0.999233,0.00926775,-0.0380539],[0.0368872,0.103903,0.993903]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1400 = objNull;
if (_layerRoot) then {
	_item1400 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4450.56,3556.64,0.830328],[],0,"CAN_COLLIDE"];
	_this = _item1400;
	_objects pushback _this;
	_objectIDs pushback 1400;
	_this setPosWorld [4450.57,3556.67,4.13116];
	_this setVectorDirAndUp [[0,0.983077,-0.183191],[0,0.183191,0.983077]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1401 = objNull;
if (_layerRoot) then {
	_item1401 = createVehicle ["Land_PlasticCase_01_small_olive_F",[4449.4,3553.44,0.840114],[],0,"CAN_COLLIDE"];
	_this = _item1401;
	_objects pushback _this;
	_objectIDs pushback 1401;
	_this setPosWorld [4449.41,3553.47,4.80459];
	_this setVectorDirAndUp [[0.106545,0.973535,-0.202184],[0,0.203342,0.979108]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1402 = objNull;
if (_layerRoot) then {
	_item1402 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5002.61,3387.47,-0.00578332],[],0,"CAN_COLLIDE"];
	_this = _item1402;
	_objects pushback _this;
	_objectIDs pushback 1402;
	_this setPosWorld [5002.56,3387.44,2.77965];
	_this setVectorDirAndUp [[0.4165,0.86136,0.290837],[-0.326981,-0.156571,0.931971]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1403 = objNull;
if (_layerRoot) then {
	_item1403 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5034.84,3391.44,-0.0175409],[],0,"CAN_COLLIDE"];
	_this = _item1403;
	_objects pushback _this;
	_objectIDs pushback 1403;
	_this setPosWorld [5034.86,3391.44,4.37098];
	_this setVectorDirAndUp [[0.438178,0.896707,-0.0625747],[0.107375,0.0169,0.994075]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1404 = objNull;
if (_layerRoot) then {
	_item1404 = createVehicle ["Land_PlasticCase_01_small_olive_F",[5038.46,3453.72,-0.00179029],[],0,"CAN_COLLIDE"];
	_this = _item1404;
	_objects pushback _this;
	_objectIDs pushback 1404;
	_this setPosWorld [5038.46,3453.73,2.85518];
	_this setVectorDirAndUp [[-0.432644,-0.900631,0.0410113],[0.0239934,0.0339709,0.999135]];
	[_this,"[[[[],[]],[[],[]],[[],[]],[[],[]]],false]"] call bis_fnc_initAmmoBox;;
};

private _item1408 = objNull;
if (_layerRoot) then {
	_item1408 = createVehicle ["Land_PierWooden_02_ladder_F",[4865.87,3468.23,10.772],[],0,"CAN_COLLIDE"];
	_this = _item1408;
	_objects pushback _this;
	_objectIDs pushback 1408;
	_this setPosWorld [4865.87,3468.23,-16.9852];
	_this setVectorDirAndUp [[-0.894644,0.44678,0],[0,0,1]];
};

///////////////////////////////////////////////////////////////////////////////////////////
// Group attributes (applied only once group units exist)
_this = _item1330;
if !(units _this isEqualTo []) then {
	[_this,0] setWaypointPosition [position leader _this,0];
	_this setGroupIdGlobal ["Alpha 1-1"];;
};


///////////////////////////////////////////////////////////////////////////////////////////
// Layers
if (_layer94) then {missionNamespace setVariable ["Kolanta_mercredi30_Cache",[[_item91],[]]];};
if (_layer177) then {missionNamespace setVariable ["Kolanta_mercredi30_ile 2",[[_item179,_item180,_item181,_item182,_item183,_item184,_item178,_item186,_item187,_item185,_item231,_item233,_item232,_item194,_item237,_item238],[]]];};
if (_layer168) then {missionNamespace setVariable ["Kolanta_mercredi30_ile ceremonie",[[_item1087,_item1088,_item1093,_item1094,_item1095,_item1096,_item1097,_item1098,_item1099,_item1100,_item1101,_item1111,_item1163,_item1164,_item1165,_item1301,_item1302,_item1303,_item1356,_item1357,_item1358,_item1359,_item1361,_item1385,_item1392,_item1393],[]]];};
if (_layer167) then {missionNamespace setVariable ["Kolanta_mercredi30_Ile 1",[[_item254],[]]];};
if (_layer239) then {missionNamespace setVariable ["Kolanta_mercredi30_Kohlanta",[[_item254,_item1087,_item1088,_item1093,_item1094,_item1095,_item1096,_item1097,_item1098,_item1099,_item1100,_item1101,_item1111,_item1163,_item1164,_item1165,_item1301,_item1302,_item1303,_item1356,_item1357,_item1358,_item1359,_item1361,_item1385,_item1392,_item1393,_item179,_item180,_item181,_item182,_item183,_item184,_item178,_item186,_item187,_item185,_item231,_item233,_item232,_item194,_item237,_item238,_item91],[]]];};



///////////////////////////////////////////////////////////////////////////////////////////
// Module activations (only once everything is spawned and connected)
if !(isNull _item91) then {_item91 setvariable ["BIS_fnc_initModules_activate",true];};

/*
systemChat "[MAPPING] Oaui.";
MRPV2_Mapping_LastName = "kolanta";

systemChat "[MAPPING] Oaui2.";
if (isNil "MRPV2_Mapping_Objects") then { MRPV2_Mapping_Objects = []; };

{
    MRPV2_Mapping_Objects pushBack _x;
} forEach _objects;
*/