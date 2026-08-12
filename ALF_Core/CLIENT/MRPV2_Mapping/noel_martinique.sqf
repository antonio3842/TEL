// Export of 'noel.martinique' by Thibaud Garnier on v0.9

///////////////////////////////////////////////////////////////////////////////////////////
// Init
params [["_layerWhiteList",[],[[]]],["_layerBlacklist",[],[[]]],["_posCenter",[0,0,0],[[]]],["_dir",0,[0]],["_idBlacklist",[],[[]]]];
private _allWhitelisted = _layerWhiteList isEqualTo [];
private _layerRoot = (_allWhitelisted || {true in _layerWhiteList}) && {!(true in _layerBlacklist)};


///////////////////////////////////////////////////////////////////////////////////////////
// Markers
private _markers = [];
private _markerIDs = [];


///////////////////////////////////////////////////////////////////////////////////////////
// Groups
private _groups = [];
private _groupIDs = [];


///////////////////////////////////////////////////////////////////////////////////////////
// Objects
private _objects = [];
private _objectIDs = [];

private _item0 = objNull;
if (_layerRoot) then {
	_item0 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[4240.75,4265.84,-9.53674e-07],[],0,"CAN_COLLIDE"];
	_this = _item0;
	_objects pushback _this;
	_objectIDs pushback 0;
	_this setPosWorld [4240.75,4265.84,16.934];
	_this setVectorDirAndUp [[0.0031704,-0.999995,0],[0,0,1]];
};

private _item2 = objNull;
if (_layerRoot) then {
	_item2 = createVehicle ["Land_O2_Sapin_Noel_anim",[4250.18,4265.98,0.277319],[],0,"CAN_COLLIDE"];
	_this = _item2;
	_objects pushback _this;
	_objectIDs pushback 2;
	_this setPosWorld [4250.18,4265.98,17.3594];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item4 = objNull;
if (_layerRoot) then {
	_item4 = createVehicle ["Land_Bare_boulder_02_F",[4250.3,4265.8,0],[],0,"CAN_COLLIDE"];
	_this = _item4;
	_objects pushback _this;
	_objectIDs pushback 4;
	_this setPosWorld [4250.3,4265.8,13.6664];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item5 = objNull;
if (_layerRoot) then {
	_item5 = createVehicle ["Land_MRP_O2_Kdo",[4249.97,4267.22,0],[],0,"CAN_COLLIDE"];
	_this = _item5;
	_objects pushback _this;
	_objectIDs pushback 5;
	_this setPosWorld [4249.97,4267.22,13.8028];
	_this setVectorDirAndUp [[-0.976305,-0.216397,0],[0,0,1]];
};

private _item6 = objNull;
if (_layerRoot) then {
	_item6 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4251.24,4267.01,0],[],0,"CAN_COLLIDE"];
	_this = _item6;
	_objects pushback _this;
	_objectIDs pushback 6;
	_this setPosWorld [4251.24,4267.01,14.0112];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item7 = objNull;
if (_layerRoot) then {
	_item7 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4251.65,4266.66,0],[],0,"CAN_COLLIDE"];
	_this = _item7;
	_objects pushback _this;
	_objectIDs pushback 7;
	_this setPosWorld [4251.65,4266.66,13.8028];
	_this setVectorDirAndUp [[-0.999729,-0.0232852,0],[0,0,1]];
};

private _item8 = objNull;
if (_layerRoot) then {
	_item8 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4250.89,4267.37,0],[],0,"CAN_COLLIDE"];
	_this = _item8;
	_objects pushback _this;
	_objectIDs pushback 8;
	_this setPosWorld [4250.89,4267.37,13.8028];
	_this setVectorDirAndUp [[-0.405454,0.914115,0],[0,0,1]];
};

private _item9 = objNull;
if (_layerRoot) then {
	_item9 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4249.7,4266.88,0],[],0,"CAN_COLLIDE"];
	_this = _item9;
	_objects pushback _this;
	_objectIDs pushback 9;
	_this setPosWorld [4249.7,4266.88,13.8028];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item10 = objNull;
if (_layerRoot) then {
	_item10 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[4248.44,4264.97,0],[],0,"CAN_COLLIDE"];
	_this = _item10;
	_objects pushback _this;
	_objectIDs pushback 10;
	_this setPosWorld [4248.44,4264.97,14.0112];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item11 = objNull;
if (_layerRoot) then {
	_item11 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4248.22,4265.54,0],[],0,"CAN_COLLIDE"];
	_this = _item11;
	_objects pushback _this;
	_objectIDs pushback 11;
	_this setPosWorld [4248.22,4265.54,13.8028];
	_this setVectorDirAndUp [[0.999982,0.00601498,0],[0,0,1]];
};

private _item12 = objNull;
if (_layerRoot) then {
	_item12 = createVehicle ["Land_MRP_O2_Kdo",[4248.1,4265.98,0],[],0,"CAN_COLLIDE"];
	_this = _item12;
	_objects pushback _this;
	_objectIDs pushback 12;
	_this setPosWorld [4248.1,4265.98,13.8028];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item13 = objNull;
if (_layerRoot) then {
	_item13 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4247.89,4265.24,0],[],0,"CAN_COLLIDE"];
	_this = _item13;
	_objects pushback _this;
	_objectIDs pushback 13;
	_this setPosWorld [4247.89,4265.24,13.8028];
	_this setVectorDirAndUp [[0.918211,0.396091,0],[0,0,1]];
};

private _item14 = objNull;
if (_layerRoot) then {
	_item14 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4250.31,4264.86,0],[],0,"CAN_COLLIDE"];
	_this = _item14;
	_objects pushback _this;
	_objectIDs pushback 14;
	_this setPosWorld [4250.31,4264.86,13.8028];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item15 = objNull;
if (_layerRoot) then {
	_item15 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4250.74,4265.08,0],[],0,"CAN_COLLIDE"];
	_this = _item15;
	_objects pushback _this;
	_objectIDs pushback 15;
	_this setPosWorld [4250.74,4265.08,13.8028];
	_this setVectorDirAndUp [[0.998086,0.0618421,0],[0,0,1]];
};

private _item16 = objNull;
if (_layerRoot) then {
	_item16 = createVehicle ["Land_O2_Sapin_Noel",[4262.36,4278.31,1.68846],[],0,"CAN_COLLIDE"];
	_this = _item16;
	_objects pushback _this;
	_objectIDs pushback 16;
	_this setPosWorld [4262.36,4278.31,18.7706];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item17 = objNull;
if (_layerRoot) then {
	_item17 = createVehicle ["Land_O2_Sapin_Noel",[4262.18,4254.22,1.68846],[],0,"CAN_COLLIDE"];
	_this = _item17;
	_objects pushback _this;
	_objectIDs pushback 17;
	_this setPosWorld [4262.18,4254.22,18.7706];
	_this setVectorDirAndUp [[0.344279,-0.938868,0],[0,0,1]];
};

private _item18 = objNull;
if (_layerRoot) then {
	_item18 = createVehicle ["Land_O2_Noel_Lum_Boule_seul",[4264.13,4256.91,1.68846],[],0,"CAN_COLLIDE"];
	_this = _item18;
	_objects pushback _this;
	_objectIDs pushback 18;
	_this setPosWorld [4264.13,4256.91,17.2789];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item19 = objNull;
if (_layerRoot) then {
	_item19 = createVehicle ["Land_O2_Noel_Lum_Sapin_seul",[4264.17,4275.67,1.68845],[],0,"CAN_COLLIDE"];
	_this = _item19;
	_objects pushback _this;
	_objectIDs pushback 19;
	_this setPosWorld [4264.17,4275.67,17.3802];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item20 = objNull;
if (_layerRoot) then {
	_item20 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4260.9,4266.36,6.72068],[],0,"CAN_COLLIDE"];
	_this = _item20;
	_objects pushback _this;
	_objectIDs pushback 20;
	_this setPosWorld [4260.9,4266.36,22.4354];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item21 = objNull;
if (_layerRoot) then {
	_item21 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4260.92,4268.38,7.35357],[],0,"CAN_COLLIDE"];
	_this = _item21;
	_objects pushback _this;
	_objectIDs pushback 21;
	_this setPosWorld [4260.92,4268.38,22.944];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item22 = objNull;
if (_layerRoot) then {
	_item22 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4260.7,4264.63,7.39408],[],0,"CAN_COLLIDE"];
	_this = _item22;
	_objects pushback _this;
	_objectIDs pushback 22;
	_this setPosWorld [4260.7,4264.63,22.9845];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item23 = objNull;
if (_layerRoot) then {
	_item23 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[4262.16,4271.73,1.68846],[],0,"CAN_COLLIDE"];
	_this = _item23;
	_objects pushback _this;
	_objectIDs pushback 23;
	_this setPosWorld [4262.16,4271.73,15.6996];
	_this setVectorDirAndUp [[-0.34116,-0.940005,0],[0,0,1]];
};

private _item24 = objNull;
if (_layerRoot) then {
	_item24 = createVehicle ["Land_MRP_O2_Kdo",[4262.29,4271.22,1.68846],[],0,"CAN_COLLIDE"];
	_this = _item24;
	_objects pushback _this;
	_objectIDs pushback 24;
	_this setPosWorld [4262.29,4271.22,15.4912];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item25 = objNull;
if (_layerRoot) then {
	_item25 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[4262.15,4261.23,1.68846],[],0,"CAN_COLLIDE"];
	_this = _item25;
	_objects pushback _this;
	_objectIDs pushback 25;
	_this setPosWorld [4262.15,4261.23,15.6996];
	_this setVectorDirAndUp [[-0.172627,-0.984987,0],[0,0,1]];
};

private _item26 = objNull;
if (_layerRoot) then {
	_item26 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4261.75,4260.92,1.68846],[],0,"CAN_COLLIDE"];
	_this = _item26;
	_objects pushback _this;
	_objectIDs pushback 26;
	_this setPosWorld [4261.75,4260.92,15.4912];
	_this setVectorDirAndUp [[-0.858543,-0.512741,0],[0,0,1]];
};

private _item27 = objNull;
if (_layerRoot) then {
	_item27 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4262.33,4261.75,1.68846],[],0,"CAN_COLLIDE"];
	_this = _item27;
	_objects pushback _this;
	_objectIDs pushback 27;
	_this setPosWorld [4262.33,4261.75,15.4912];
	_this setVectorDirAndUp [[0.21243,-0.977176,0],[0,0,1]];
};

private _item28 = objNull;
if (_layerRoot) then {
	_item28 = createVehicle ["Land_O2_Noel_Lum_Neige",[4265.74,4280.71,4.57209],[],0,"CAN_COLLIDE"];
	_this = _item28;
	_objects pushback _this;
	_objectIDs pushback 28;
	_this setPosWorld [4265.74,4280.71,20.2868];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item30 = objNull;
if (_layerRoot) then {
	_item30 = createVehicle ["Land_O2_Noel_Lum_Neige",[4278.44,4280.7,4.56539],[],0,"CAN_COLLIDE"];
	_this = _item30;
	_objects pushback _this;
	_objectIDs pushback 30;
	_this setPosWorld [4278.44,4280.7,20.2801];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item31 = objNull;
if (_layerRoot) then {
	_item31 = createVehicle ["Land_O2_Noel_Lum_Neige",[4278.33,4252.03,4.42936],[],0,"CAN_COLLIDE"];
	_this = _item31;
	_objects pushback _this;
	_objectIDs pushback 31;
	_this setPosWorld [4278.33,4252.03,20.1441];
	_this setVectorDirAndUp [[0.137871,-0.99045,0],[0,0,1]];
};

private _item32 = objNull;
if (_layerRoot) then {
	_item32 = createVehicle ["Land_O2_Noel_Lum_Neige",[4265.53,4251.98,4.44237],[],0,"CAN_COLLIDE"];
	_this = _item32;
	_objects pushback _this;
	_objectIDs pushback 32;
	_this setPosWorld [4265.53,4251.98,20.1571];
	_this setVectorDirAndUp [[0.137871,-0.99045,0],[0,0,1]];
};

private _item33 = objNull;
if (_layerRoot) then {
	_item33 = createVehicle ["Land_O2_Sapin_Noel",[4233.94,4248.07,0.112001],[],0,"CAN_COLLIDE"];
	_this = _item33;
	_objects pushback _this;
	_objectIDs pushback 33;
	_this setPosWorld [4233.94,4248.07,17.1941];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item34 = objNull;
if (_layerRoot) then {
	_item34 = createVehicle ["Land_O2_Sapin_Noel",[4233.66,4279.8,0.109999],[],0,"CAN_COLLIDE"];
	_this = _item34;
	_objects pushback _this;
	_objectIDs pushback 34;
	_this setPosWorld [4233.66,4279.8,17.1921];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item37 = objNull;
if (_layerRoot) then {
	_item37 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[4542.86,4608.13,-9.53674e-07],[],0,"CAN_COLLIDE"];
	_this = _item37;
	_objects pushback _this;
	_objectIDs pushback 37;
	_this setPosWorld [4542.86,4608.13,16.934];
	_this setVectorDirAndUp [[-0.00700715,-0.999975,0],[0,0,1]];
};

private _item39 = objNull;
if (_layerRoot) then {
	_item39 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[4542.85,4631.18,0.109999],[],0,"CAN_COLLIDE"];
	_this = _item39;
	_objects pushback _this;
	_objectIDs pushback 39;
	_this setPosWorld [4542.85,4631.18,14.1212];
	_this setVectorDirAndUp [[-0.584779,-0.811193,0],[0,0,1]];
};

private _item41 = objNull;
if (_layerRoot) then {
	_item41 = createVehicle ["Land_MRP_O2_Kdo",[4542.82,4630.67,0.109999],[],0,"CAN_COLLIDE"];
	_this = _item41;
	_objects pushback _this;
	_objectIDs pushback 41;
	_this setPosWorld [4542.82,4630.67,13.9128];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item42 = objNull;
if (_layerRoot) then {
	_item42 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4542.81,4631.97,0.109999],[],0,"CAN_COLLIDE"];
	_this = _item42;
	_objects pushback _this;
	_objectIDs pushback 42;
	_this setPosWorld [4542.81,4631.97,13.9128];
	_this setVectorDirAndUp [[0.978099,0.208139,0],[0,0,1]];
};

private _item43 = objNull;
if (_layerRoot) then {
	_item43 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4543.13,4628.89,3.78208],[],0,"CAN_COLLIDE"];
	_this = _item43;
	_objects pushback _this;
	_objectIDs pushback 43;
	_this setPosWorld [4543.13,4628.89,19.4968];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item44 = objNull;
if (_layerRoot) then {
	_item44 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4543.04,4626.34,11.086],[],0,"CAN_COLLIDE"];
	_this = _item44;
	_objects pushback _this;
	_objectIDs pushback 44;
	_this setPosWorld [4543.04,4626.34,26.8007];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item45 = objNull;
if (_layerRoot) then {
	_item45 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4543.12,4628.67,1.30065],[],0,"CAN_COLLIDE"];
	_this = _item45;
	_objects pushback _this;
	_objectIDs pushback 45;
	_this setPosWorld [4543.12,4628.67,16.8911];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item46 = objNull;
if (_layerRoot) then {
	_item46 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4542.72,4626.54,2.42084],[],0,"CAN_COLLIDE"];
	_this = _item46;
	_objects pushback _this;
	_objectIDs pushback 46;
	_this setPosWorld [4542.72,4626.54,18.0113];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item47 = objNull;
if (_layerRoot) then {
	_item47 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4542.91,4626.75,6.69966],[],0,"CAN_COLLIDE"];
	_this = _item47;
	_objects pushback _this;
	_objectIDs pushback 47;
	_this setPosWorld [4542.91,4626.75,22.2901];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item48 = objNull;
if (_layerRoot) then {
	_item48 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4543.08,4628.97,9.73037],[],0,"CAN_COLLIDE"];
	_this = _item48;
	_objects pushback _this;
	_objectIDs pushback 48;
	_this setPosWorld [4543.08,4628.97,25.3208];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item49 = objNull;
if (_layerRoot) then {
	_item49 = createVehicle ["Land_O2_Noel_Lum_Boule_seul",[4540.99,4650.53,4.34677],[],0,"CAN_COLLIDE"];
	_this = _item49;
	_objects pushback _this;
	_objectIDs pushback 49;
	_this setPosWorld [4540.99,4650.53,19.9372];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item50 = objNull;
if (_layerRoot) then {
	_item50 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4541.06,4642.85,3.80206],[],0,"CAN_COLLIDE"];
	_this = _item50;
	_objects pushback _this;
	_objectIDs pushback 50;
	_this setPosWorld [4541.06,4642.85,19.5168];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item52 = objNull;
if (_layerRoot) then {
	_item52 = createVehicle ["Land_O2_Noel_Lum_Sapin_seul",[4543.72,4653.39,3.58855],[],0,"CAN_COLLIDE"];
	_this = _item52;
	_objects pushback _this;
	_objectIDs pushback 52;
	_this setPosWorld [4543.72,4653.39,19.2803];
	_this setVectorDirAndUp [[-0.999996,-0.00274657,0],[0,0,1]];
};

private _item53 = objNull;
if (_layerRoot) then {
	_item53 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[4568.37,4663.8,0.101999],[],0,"CAN_COLLIDE"];
	_this = _item53;
	_objects pushback _this;
	_objectIDs pushback 53;
	_this setPosWorld [4568.37,4663.8,14.1132];
	_this setVectorDirAndUp [[-0.470658,-0.882316,0],[0,0,1]];
};

private _item54 = objNull;
if (_layerRoot) then {
	_item54 = createVehicle ["Land_MRP_O2_Kdo",[4564.96,4663.75,0.0997496],[],0,"CAN_COLLIDE"];
	_this = _item54;
	_objects pushback _this;
	_objectIDs pushback 54;
	_this setPosWorld [4564.96,4663.75,13.9025];
	_this setVectorDirAndUp [[-0.985063,-0.172192,0],[0,0,1]];
};

private _item55 = objNull;
if (_layerRoot) then {
	_item55 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4548.98,4663.55,2.88235],[],0,"CAN_COLLIDE"];
	_this = _item55;
	_objects pushback _this;
	_objectIDs pushback 55;
	_this setPosWorld [4548.98,4663.55,18.5971];
	_this setVectorDirAndUp [[-0.999993,-0.00382517,0],[0,0,1]];
};

private _item56 = objNull;
if (_layerRoot) then {
	_item56 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4566.52,4663.55,1.65525],[],0,"CAN_COLLIDE"];
	_this = _item56;
	_objects pushback _this;
	_objectIDs pushback 56;
	_this setPosWorld [4566.52,4663.55,17.2457];
	_this setVectorDirAndUp [[-0.999977,0.00676962,0],[0,0,1]];
};

private _item57 = objNull;
if (_layerRoot) then {
	_item57 = createVehicle ["Land_O2_Noel_Lum_Boule_seul",[4576.86,4658.12,2.95888],[],0,"CAN_COLLIDE"];
	_this = _item57;
	_objects pushback _this;
	_objectIDs pushback 57;
	_this setPosWorld [4576.86,4658.12,18.5493];
	_this setVectorDirAndUp [[-0.999989,-0.00477979,0],[0,0,1]];
};

private _item58 = objNull;
if (_layerRoot) then {
	_item58 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4537.59,4636,0.176506],[],0,"CAN_COLLIDE"];
	_this = _item58;
	_objects pushback _this;
	_objectIDs pushback 58;
	_this setPosWorld [4537.59,4636,13.9793];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item59 = objNull;
if (_layerRoot) then {
	_item59 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4537.25,4636.38,0.140726],[],0,"CAN_COLLIDE"];
	_this = _item59;
	_objects pushback _this;
	_objectIDs pushback 59;
	_this setPosWorld [4537.25,4636.38,14.1519];
	_this setVectorDirAndUp [[0.698756,0.715361,0],[0,0,1]];
};

private _item60 = objNull;
if (_layerRoot) then {
	_item60 = createVehicle ["Land_O2_Sapin_Noel_anim",[4543.36,4650.9,-0.385],[],0,"CAN_COLLIDE"];
	_this = _item60;
	_objects pushback _this;
	_objectIDs pushback 60;
	_this setPosWorld [4543.36,4650.9,16.6971];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item61 = objNull;
if (_layerRoot) then {
	_item61 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4542.65,4649.2,0.189903],[],0,"CAN_COLLIDE"];
	_this = _item61;
	_objects pushback _this;
	_objectIDs pushback 61;
	_this setPosWorld [4542.65,4649.2,13.9927];
	_this setVectorDirAndUp [[-0.570609,0.821222,0],[0,0,1]];
};

private _item62 = objNull;
if (_layerRoot) then {
	_item62 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[4542.05,4649.15,0.192191],[],0,"CAN_COLLIDE"];
	_this = _item62;
	_objects pushback _this;
	_objectIDs pushback 62;
	_this setPosWorld [4542.05,4649.15,14.2034];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item63 = objNull;
if (_layerRoot) then {
	_item63 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4544.79,4650.55,0.180223],[],0,"CAN_COLLIDE"];
	_this = _item63;
	_objects pushback _this;
	_objectIDs pushback 63;
	_this setPosWorld [4544.79,4650.55,13.983];
	_this setVectorDirAndUp [[-0.373105,0.927789,0],[0,0,1]];
};

private _item64 = objNull;
if (_layerRoot) then {
	_item64 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4544.97,4651.06,0.178845],[],0,"CAN_COLLIDE"];
	_this = _item64;
	_objects pushback _this;
	_objectIDs pushback 64;
	_this setPosWorld [4544.97,4651.06,14.19];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item65 = objNull;
if (_layerRoot) then {
	_item65 = createVehicle ["Land_O2_Noel_Lum_JoyFet_seul",[4548.96,4641.5,-1.2],[],0,"CAN_COLLIDE"];
	_this = _item65;
	_objects pushback _this;
	_objectIDs pushback 65;
	_this setPosWorld [4548.96,4641.5,15.8557];
	_this setVectorDirAndUp [[-0.00116929,-0.999999,0],[0,0,1]];
};

private _item66 = objNull;
if (_layerRoot) then {
	_item66 = createVehicle ["Land_MRP_O2_Kdo",[4550.9,4640.22,1.38],[],0,"CAN_COLLIDE"];
	_this = _item66;
	_objects pushback _this;
	_objectIDs pushback 66;
	_this setPosWorld [4550.9,4640.22,15.1828];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item68 = objNull;
if (_layerRoot) then {
	_item68 = createVehicle ["Land_O2_Noel_Lum_Sapin_seul",[4548.99,4646.85,0.169824],[],0,"CAN_COLLIDE"];
	_this = _item68;
	_objects pushback _this;
	_objectIDs pushback 68;
	_this setPosWorld [4548.99,4646.85,15.8616];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item71 = objNull;
if (_layerRoot) then {
	_item71 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4563.96,4648.22,1.38],[],0,"CAN_COLLIDE"];
	_this = _item71;
	_objects pushback _this;
	_objectIDs pushback 71;
	_this setPosWorld [4563.96,4648.22,15.3912];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item72 = objNull;
if (_layerRoot) then {
	_item72 = createVehicle ["Land_O2_Noel_Lum_JoyFet_seul",[4541.21,4646.75,2.57065],[],0,"CAN_COLLIDE"];
	_this = _item72;
	_objects pushback _this;
	_objectIDs pushback 72;
	_this setPosWorld [4541.21,4646.75,19.6264];
	_this setVectorDirAndUp [[-0.00443299,-0.99999,0],[0,0,1]];
};

private _item73 = objNull;
if (_layerRoot) then {
	_item73 = createVehicle ["Land_O2_Sapin_Noel",[4147.72,4604.61,0.113001],[],0,"CAN_COLLIDE"];
	_this = _item73;
	_objects pushback _this;
	_objectIDs pushback 73;
	_this setPosWorld [4147.72,4604.61,17.1951];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item74 = objNull;
if (_layerRoot) then {
	_item74 = createVehicle ["Land_O2_Sapin_Noel",[4147.48,4537.11,0.114],[],0,"CAN_COLLIDE"];
	_this = _item74;
	_objects pushback _this;
	_objectIDs pushback 74;
	_this setPosWorld [4147.48,4537.11,17.1961];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item75 = objNull;
if (_layerRoot) then {
	_item75 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[4150.56,4613.16,-9.53674e-07],[],0,"CAN_COLLIDE"];
	_this = _item75;
	_objects pushback _this;
	_objectIDs pushback 75;
	_this setPosWorld [4150.56,4613.16,16.934];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item76 = objNull;
if (_layerRoot) then {
	_item76 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[4150.69,4528.95,-9.53674e-07],[],0,"CAN_COLLIDE"];
	_this = _item76;
	_objects pushback _this;
	_objectIDs pushback 76;
	_this setPosWorld [4150.69,4528.95,16.934];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item77 = objNull;
if (_layerRoot) then {
	_item77 = createVehicle ["Land_MRP_O2_Kdo",[4126.41,4577.73,0.939075],[],0,"CAN_COLLIDE"];
	_this = _item77;
	_objects pushback _this;
	_objectIDs pushback 77;
	_this setPosWorld [4126.41,4577.73,14.7419];
	_this setVectorDirAndUp [[-0.434892,0.900483,0],[0,0,1]];
};

private _item78 = objNull;
if (_layerRoot) then {
	_item78 = createVehicle ["Land_O2_Sapin_Noel_anim",[4117.29,4555.62,0],[],0,"CAN_COLLIDE"];
	_this = _item78;
	_objects pushback _this;
	_objectIDs pushback 78;
	_this setPosWorld [4117.29,4555.62,17.0821];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item79 = objNull;
if (_layerRoot) then {
	_item79 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[4123.07,4567.94,0],[],0,"CAN_COLLIDE"];
	_this = _item79;
	_objects pushback _this;
	_objectIDs pushback 79;
	_this setPosWorld [4123.07,4567.94,14.0112];
	_this setVectorDirAndUp [[-0.296515,0.955028,0],[0,0,1]];
};

private _item80 = objNull;
if (_layerRoot) then {
	_item80 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4123.4,4568.3,0],[],0,"CAN_COLLIDE"];
	_this = _item80;
	_objects pushback _this;
	_objectIDs pushback 80;
	_this setPosWorld [4123.4,4568.3,13.8028];
	_this setVectorDirAndUp [[0.755867,0.654725,0],[0,0,1]];
};

private _item81 = objNull;
if (_layerRoot) then {
	_item81 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4122.92,4567.43,0],[],0,"CAN_COLLIDE"];
	_this = _item81;
	_objects pushback _this;
	_objectIDs pushback 81;
	_this setPosWorld [4122.92,4567.43,13.8028];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item82 = objNull;
if (_layerRoot) then {
	_item82 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[4151.07,4574.6,0.110002],[],0,"CAN_COLLIDE"];
	_this = _item82;
	_objects pushback _this;
	_objectIDs pushback 82;
	_this setPosWorld [4151.07,4574.6,14.1212];
	_this setVectorDirAndUp [[0.409569,0.912279,0],[0,0,1]];
};

private _item83 = objNull;
if (_layerRoot) then {
	_item83 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4151.16,4573.85,0.110002],[],0,"CAN_COLLIDE"];
	_this = _item83;
	_objects pushback _this;
	_objectIDs pushback 83;
	_this setPosWorld [4151.16,4573.85,13.9128];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item84 = objNull;
if (_layerRoot) then {
	_item84 = createVehicle ["Land_O2_Sapin_Noel",[4085.96,4669.35,0.111002],[],0,"CAN_COLLIDE"];
	_this = _item84;
	_objects pushback _this;
	_objectIDs pushback 84;
	_this setPosWorld [4085.96,4669.35,17.1931];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item85 = objNull;
if (_layerRoot) then {
	_item85 = createVehicle ["Land_O2_Sapin_Noel",[4059.86,4669.96,0.111002],[],0,"CAN_COLLIDE"];
	_this = _item85;
	_objects pushback _this;
	_objectIDs pushback 85;
	_this setPosWorld [4059.86,4669.96,17.1931];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item86 = objNull;
if (_layerRoot) then {
	_item86 = createVehicle ["Land_O2_Noel_Lum_Neige",[4105.75,4697.56,5.23054],[],0,"CAN_COLLIDE"];
	_this = _item86;
	_objects pushback _this;
	_objectIDs pushback 86;
	_this setPosWorld [4105.75,4697.56,20.9453];
	_this setVectorDirAndUp [[-0.999985,-0.00549312,0],[0,0,1]];
};

private _item87 = objNull;
if (_layerRoot) then {
	_item87 = createVehicle ["Land_O2_Noel_Lum_Neige",[4143.28,4697.73,5.20829],[],0,"CAN_COLLIDE"];
	_this = _item87;
	_objects pushback _this;
	_objectIDs pushback 87;
	_this setPosWorld [4143.28,4697.73,20.923];
	_this setVectorDirAndUp [[0.999975,0.00703337,0],[0,0,1]];
};

private _item88 = objNull;
if (_layerRoot) then {
	_item88 = createVehicle ["Land_O2_Noel_Lum_JoyFet_seul",[4124.43,4696.94,0.561052],[],0,"CAN_COLLIDE"];
	_this = _item88;
	_objects pushback _this;
	_objectIDs pushback 88;
	_this setPosWorld [4124.43,4696.94,17.6168];
	_this setVectorDirAndUp [[1,0.000919775,0],[0,0,1]];
};

private _item89 = objNull;
if (_layerRoot) then {
	_item89 = createVehicle ["Land_MRP_O2_Kdo",[4128.41,4696.56,0.271868],[],0,"CAN_COLLIDE"];
	_this = _item89;
	_objects pushback _this;
	_objectIDs pushback 89;
	_this setPosWorld [4128.41,4696.56,14.0746];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item90 = objNull;
if (_layerRoot) then {
	_item90 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4119.9,4696.58,0.271868],[],0,"CAN_COLLIDE"];
	_this = _item90;
	_objects pushback _this;
	_objectIDs pushback 90;
	_this setPosWorld [4119.9,4696.58,14.2831];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item91 = objNull;
if (_layerRoot) then {
	_item91 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[4129.08,4696.54,0.271868],[],0,"CAN_COLLIDE"];
	_this = _item91;
	_objects pushback _this;
	_objectIDs pushback 91;
	_this setPosWorld [4129.08,4696.54,14.2831];
	_this setVectorDirAndUp [[0.97785,0.209306,0],[0,0,1]];
};

private _item92 = objNull;
if (_layerRoot) then {
	_item92 = createVehicle ["Land_MRP_O2_Kdo",[4120.38,4696.74,0.271868],[],0,"CAN_COLLIDE"];
	_this = _item92;
	_objects pushback _this;
	_objectIDs pushback 92;
	_this setPosWorld [4120.38,4696.74,14.0746];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item93 = objNull;
if (_layerRoot) then {
	_item93 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4129.14,4695.94,0.271868],[],0,"CAN_COLLIDE"];
	_this = _item93;
	_objects pushback _this;
	_objectIDs pushback 93;
	_this setPosWorld [4129.14,4695.94,14.0746];
	_this setVectorDirAndUp [[0.977068,0.212925,0],[0,0,1]];
};

private _item94 = objNull;
if (_layerRoot) then {
	_item94 = createVehicle ["Land_O2_Noel_Lum_Sapin_seul",[4127.23,4696.91,-0.272],[],0,"CAN_COLLIDE"];
	_this = _item94;
	_objects pushback _this;
	_objectIDs pushback 94;
	_this setPosWorld [4127.23,4696.91,15.4198];
	_this setVectorDirAndUp [[-0.999998,0.00191976,0],[0,0,1]];
};

private _item95 = objNull;
if (_layerRoot) then {
	_item95 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4119.73,4696.04,0.271868],[],0,"CAN_COLLIDE"];
	_this = _item95;
	_objects pushback _this;
	_objectIDs pushback 95;
	_this setPosWorld [4119.73,4696.04,14.0746];
	_this setVectorDirAndUp [[0.904419,0.426646,0],[0,0,1]];
};

private _item96 = objNull;
if (_layerRoot) then {
	_item96 = createVehicle ["Land_O2_Noel_Lum_Boule_seul",[4121.78,4696.93,-0.3],[],0,"CAN_COLLIDE"];
	_this = _item96;
	_objects pushback _this;
	_objectIDs pushback 96;
	_this setPosWorld [4121.78,4696.93,15.2904];
	_this setVectorDirAndUp [[0.999982,-0.00598646,0],[0,0,1]];
};

private _item97 = objNull;
if (_layerRoot) then {
	_item97 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4124.47,4684.02,0.630965],[],0,"CAN_COLLIDE"];
	_this = _item97;
	_objects pushback _this;
	_objectIDs pushback 97;
	_this setPosWorld [4124.47,4684.02,14.4337];
	_this setVectorDirAndUp [[0.241333,0.970442,0],[0,0,1]];
};

private _item98 = objNull;
if (_layerRoot) then {
	_item98 = createVehicle ["Land_MRP_O2_Gros_Kdo_Rose",[4149.04,4711.89,0.99569],[],0,"CAN_COLLIDE"];
	_this = _item98;
	_objects pushback _this;
	_objectIDs pushback 98;
	_this setPosWorld [4149.04,4711.89,15.0069];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item99 = objNull;
if (_layerRoot) then {
	_item99 = createVehicle ["Land_O2_Sapin_Noel",[4154.12,4717.19,0.111002],[],0,"CAN_COLLIDE"];
	_this = _item99;
	_objects pushback _this;
	_objectIDs pushback 99;
	_this setPosWorld [4154.12,4717.19,17.1931];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item100 = objNull;
if (_layerRoot) then {
	_item100 = createVehicle ["Land_O2_Sapin_Noel_anim",[4286.9,4266.17,1.688],[],0,"CAN_COLLIDE"];
	_this = _item100;
	_objects pushback _this;
	_objectIDs pushback 100;
	_this setPosWorld [4286.9,4266.17,18.7701];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item101 = objNull;
if (_layerRoot) then {
	_item101 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[4285.42,4267.8,1.688],[],0,"CAN_COLLIDE"];
	_this = _item101;
	_objects pushback _this;
	_objectIDs pushback 101;
	_this setPosWorld [4285.42,4267.8,15.6992];
	_this setVectorDirAndUp [[-0.577693,-0.816254,0],[0,0,1]];
};

private _item102 = objNull;
if (_layerRoot) then {
	_item102 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4285.28,4264.62,1.688],[],0,"CAN_COLLIDE"];
	_this = _item102;
	_objects pushback _this;
	_objectIDs pushback 102;
	_this setPosWorld [4285.28,4264.62,15.6992];
	_this setVectorDirAndUp [[0.521358,-0.853338,0],[0,0,1]];
};

private _item103 = objNull;
if (_layerRoot) then {
	_item103 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4285.16,4265.75,1.688],[],0,"CAN_COLLIDE"];
	_this = _item103;
	_objects pushback _this;
	_objectIDs pushback 103;
	_this setPosWorld [4285.16,4265.75,15.4908];
	_this setVectorDirAndUp [[0.993938,-0.109946,0],[0,0,1]];
};

private _item104 = objNull;
if (_layerRoot) then {
	_item104 = createVehicle ["Land_O2_Sapin_Noel_anim",[5248.32,4607.47,0.4773],[],0,"CAN_COLLIDE"];
	_this = _item104;
	_objects pushback _this;
	_objectIDs pushback 104;
	_this setPosWorld [5248.32,4607.47,18.3394];
	_this setVectorDirAndUp [[-0.720748,0.693197,0],[0,0,1]];
};

private _item105 = objNull;
if (_layerRoot) then {
	_item105 = createVehicle ["Land_Bare_boulder_02_F",[5248.53,4607.43,0.112],[],0,"CAN_COLLIDE"];
	_this = _item105;
	_objects pushback _this;
	_objectIDs pushback 105;
	_this setPosWorld [5248.53,4607.43,14.5584];
	_this setVectorDirAndUp [[-0.720748,0.693197,0],[0,0,1]];
};

private _item106 = objNull;
if (_layerRoot) then {
	_item106 = createVehicle ["Land_MRP_O2_Kdo",[5247.28,4608.18,0.112],[],0,"CAN_COLLIDE"];
	_this = _item106;
	_objects pushback _this;
	_objectIDs pushback 106;
	_this setPosWorld [5247.28,4608.18,14.6948];
	_this setVectorDirAndUp [[-0.520804,-0.853676,0],[0,0,1]];
};

private _item107 = objNull;
if (_layerRoot) then {
	_item107 = createVehicle ["Land_MRP_O2_Gros_Kdo",[5248.32,4608.95,0.112],[],0,"CAN_COLLIDE"];
	_this = _item107;
	_objects pushback _this;
	_objectIDs pushback 107;
	_this setPosWorld [5248.32,4608.95,14.9032];
	_this setVectorDirAndUp [[-0.720748,0.693197,0],[0,0,1]];
};

private _item108 = objNull;
if (_layerRoot) then {
	_item108 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5248.86,4609,0.112],[],0,"CAN_COLLIDE"];
	_this = _item108;
	_objects pushback _this;
	_objectIDs pushback 108;
	_this setPosWorld [5248.86,4609,14.6948];
	_this setVectorDirAndUp [[-0.676227,-0.736694,0],[0,0,1]];
};

private _item109 = objNull;
if (_layerRoot) then {
	_item109 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5247.81,4608.94,0.112],[],0,"CAN_COLLIDE"];
	_this = _item109;
	_objects pushback _this;
	_objectIDs pushback 109;
	_this setPosWorld [5247.81,4608.94,14.6948];
	_this setVectorDirAndUp [[-0.939906,0.341432,0],[0,0,1]];
};

private _item110 = objNull;
if (_layerRoot) then {
	_item110 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5247.34,4607.74,0.112],[],0,"CAN_COLLIDE"];
	_this = _item110;
	_objects pushback _this;
	_objectIDs pushback 110;
	_this setPosWorld [5247.34,4607.74,14.6948];
	_this setVectorDirAndUp [[-0.720748,0.693197,0],[0,0,1]];
};

private _item111 = objNull;
if (_layerRoot) then {
	_item111 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[5247.84,4605.52,0.112],[],0,"CAN_COLLIDE"];
	_this = _item111;
	_objects pushback _this;
	_objectIDs pushback 111;
	_this setPosWorld [5247.84,4605.52,14.9032];
	_this setVectorDirAndUp [[-0.720748,0.693197,0],[0,0,1]];
};

private _item112 = objNull;
if (_layerRoot) then {
	_item112 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5247.28,4605.75,0.112],[],0,"CAN_COLLIDE"];
	_this = _item112;
	_objects pushback _this;
	_objectIDs pushback 112;
	_this setPosWorld [5247.28,4605.75,14.6948];
	_this setVectorDirAndUp [[0.688849,0.724905,0],[0,0,1]];
};

private _item113 = objNull;
if (_layerRoot) then {
	_item113 = createVehicle ["Land_MRP_O2_Kdo",[5246.88,4605.97,0.112],[],0,"CAN_COLLIDE"];
	_this = _item113;
	_objects pushback _this;
	_objectIDs pushback 113;
	_this setPosWorld [5246.88,4605.97,14.6948];
	_this setVectorDirAndUp [[-0.720748,0.693197,0],[0,0,1]];
};

private _item114 = objNull;
if (_layerRoot) then {
	_item114 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5247.27,4605.31,0.112],[],0,"CAN_COLLIDE"];
	_this = _item114;
	_objects pushback _this;
	_objectIDs pushback 114;
	_this setPosWorld [5247.27,4605.31,14.6948];
	_this setVectorDirAndUp [[0.351019,0.936368,0],[0,0,1]];
};

private _item115 = objNull;
if (_layerRoot) then {
	_item115 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5249.22,4606.79,0.112],[],0,"CAN_COLLIDE"];
	_this = _item115;
	_objects pushback _this;
	_objectIDs pushback 115;
	_this setPosWorld [5249.22,4606.79,14.6948];
	_this setVectorDirAndUp [[-0.720748,0.693197,0],[0,0,1]];
};

private _item116 = objNull;
if (_layerRoot) then {
	_item116 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5249.36,4607.25,0.112],[],0,"CAN_COLLIDE"];
	_this = _item116;
	_objects pushback _this;
	_objectIDs pushback 116;
	_this setPosWorld [5249.36,4607.25,14.6948];
	_this setVectorDirAndUp [[0.647298,0.762237,0],[0,0,1]];
};

private _item117 = objNull;
if (_layerRoot) then {
	_item117 = createVehicle ["Land_O2_Noel_Lum_JoyFet_seul",[5278.42,4629.12,0.758389],[],0,"CAN_COLLIDE"];
	_this = _item117;
	_objects pushback _this;
	_objectIDs pushback 117;
	_this setPosWorld [5278.42,4629.12,18.5941];
	_this setVectorDirAndUp [[-0.742315,0.670051,0],[0,0,1]];
};

private _item118 = objNull;
if (_layerRoot) then {
	_item118 = createVehicle ["Land_MRP_O2_Gros_Kdo",[5275.77,4637.88,0.110001],[],0,"CAN_COLLIDE"];
	_this = _item118;
	_objects pushback _this;
	_objectIDs pushback 118;
	_this setPosWorld [5275.77,4637.88,14.9012];
	_this setVectorDirAndUp [[-0.887103,0.461571,0],[0,0,1]];
};

private _item119 = objNull;
if (_layerRoot) then {
	_item119 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5276.06,4637.31,0.110001],[],0,"CAN_COLLIDE"];
	_this = _item119;
	_objects pushback _this;
	_objectIDs pushback 119;
	_this setPosWorld [5276.06,4637.31,14.6928];
	_this setVectorDirAndUp [[0.743056,0.669229,0],[0,0,1]];
};

private _item120 = objNull;
if (_layerRoot) then {
	_item120 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5286.98,4627.58,0.110001],[],0,"CAN_COLLIDE"];
	_this = _item120;
	_objects pushback _this;
	_objectIDs pushback 120;
	_this setPosWorld [5286.98,4627.58,14.6928];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item121 = objNull;
if (_layerRoot) then {
	_item121 = createVehicle ["Land_MRP_O2_Gros_Kdo",[5287.45,4627.2,0.1],[],0,"CAN_COLLIDE"];
	_this = _item121;
	_objects pushback _this;
	_objectIDs pushback 121;
	_this setPosWorld [5287.45,4627.2,14.8912];
	_this setVectorDirAndUp [[-0.576074,-0.817397,0],[0,0,1]];
};

private _item122 = objNull;
if (_layerRoot) then {
	_item122 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5287.9,4627.55,0.110001],[],0,"CAN_COLLIDE"];
	_this = _item122;
	_objects pushback _this;
	_objectIDs pushback 122;
	_this setPosWorld [5287.9,4627.55,14.6928];
	_this setVectorDirAndUp [[-0.91808,0.396396,0],[0,0,1]];
};

private _item123 = objNull;
if (_layerRoot) then {
	_item123 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[5265.3,4640.61,1.11762],[],0,"CAN_COLLIDE"];
	_this = _item123;
	_objects pushback _this;
	_objectIDs pushback 123;
	_this setPosWorld [5265.3,4640.61,17.6123];
	_this setVectorDirAndUp [[-0.737145,0.675734,0],[0,0,1]];
};

private _item124 = objNull;
if (_layerRoot) then {
	_item124 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[5260.29,4645.15,3.33466],[],0,"CAN_COLLIDE"];
	_this = _item124;
	_objects pushback _this;
	_objectIDs pushback 124;
	_this setPosWorld [5260.29,4645.15,19.7051];
	_this setVectorDirAndUp [[-0.758751,0.651381,0],[0,0,1]];
};

private _item125 = objNull;
if (_layerRoot) then {
	_item125 = createVehicle ["Land_O2_Noel_Lum_Boule_seul",[5276.96,4636.19,-0.21],[],0,"CAN_COLLIDE"];
	_this = _item125;
	_objects pushback _this;
	_objectIDs pushback 125;
	_this setPosWorld [5276.96,4636.19,16.1604];
	_this setVectorDirAndUp [[0.72066,-0.693289,0],[0,0,1]];
};

private _item126 = objNull;
if (_layerRoot) then {
	_item126 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[5285.75,4628.27,-0.71],[],0,"CAN_COLLIDE"];
	_this = _item126;
	_objects pushback _this;
	_objectIDs pushback 126;
	_this setPosWorld [5285.75,4628.27,15.7847];
	_this setVectorDirAndUp [[-0.753081,0.657927,0],[0,0,1]];
};

private _item127 = objNull;
if (_layerRoot) then {
	_item127 = createVehicle ["Land_O2_Noel_Lum_Sapin_seul",[5293.02,4615.73,0.818398],[],0,"CAN_COLLIDE"];
	_this = _item127;
	_objects pushback _this;
	_objectIDs pushback 127;
	_this setPosWorld [5293.02,4615.73,17.2902];
	_this setVectorDirAndUp [[-0.742767,0.66955,0],[0,0,1]];
};

private _item129 = objNull;
if (_layerRoot) then {
	_item129 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[5260.84,4645.13,0],[],0,"CAN_COLLIDE"];
	_this = _item129;
	_objects pushback _this;
	_objectIDs pushback 129;
	_this setPosWorld [5260.84,4645.13,14.7912];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item130 = objNull;
if (_layerRoot) then {
	_item130 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5261.37,4645.17,0],[],0,"CAN_COLLIDE"];
	_this = _item130;
	_objects pushback _this;
	_objectIDs pushback 130;
	_this setPosWorld [5261.37,4645.17,14.5828];
	_this setVectorDirAndUp [[-0.922591,0.385781,0],[0,0,1]];
};

private _item131 = objNull;
if (_layerRoot) then {
	_item131 = createVehicle ["Land_MRP_O2_Kdo",[5256.66,4639.08,1.35],[],0,"CAN_COLLIDE"];
	_this = _item131;
	_objects pushback _this;
	_objectIDs pushback 131;
	_this setPosWorld [5256.66,4639.08,15.9328];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item132 = objNull;
if (_layerRoot) then {
	_item132 = createVehicle ["Land_O2_Noel_Lum_Boule_seul",[5253.62,4623.4,1.68301],[],0,"CAN_COLLIDE"];
	_this = _item132;
	_objects pushback _this;
	_objectIDs pushback 132;
	_this setPosWorld [5253.62,4623.4,18.0534];
	_this setVectorDirAndUp [[0.67165,0.740869,0],[0,0,1]];
};

private _item133 = objNull;
if (_layerRoot) then {
	_item133 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[5256.11,4626.16,0.58116],[],0,"CAN_COLLIDE"];
	_this = _item133;
	_objects pushback _this;
	_objectIDs pushback 133;
	_this setPosWorld [5256.11,4626.16,17.0759];
	_this setVectorDirAndUp [[0.676,0.736901,0],[0,0,1]];
};

private _item134 = objNull;
if (_layerRoot) then {
	_item134 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[5260.95,4628.38,3.58669],[],0,"CAN_COLLIDE"];
	_this = _item134;
	_objects pushback _this;
	_objectIDs pushback 134;
	_this setPosWorld [5260.95,4628.38,20.0814];
	_this setVectorDirAndUp [[0.740197,-0.67239,0],[0,0,1]];
};

private _item135 = objNull;
if (_layerRoot) then {
	_item135 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[5262.99,4626.52,3.26527],[],0,"CAN_COLLIDE"];
	_this = _item135;
	_objects pushback _this;
	_objectIDs pushback 135;
	_this setPosWorld [5262.99,4626.52,19.6357];
	_this setVectorDirAndUp [[0.765172,-0.643826,0],[0,0,1]];
};

private _item136 = objNull;
if (_layerRoot) then {
	_item136 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[5264.62,4625.06,5.30663],[],0,"CAN_COLLIDE"];
	_this = _item136;
	_objects pushback _this;
	_objectIDs pushback 136;
	_this setPosWorld [5264.62,4625.06,21.6771];
	_this setVectorDirAndUp [[0.737687,-0.675143,0],[0,0,1]];
};

private _item137 = objNull;
if (_layerRoot) then {
	_item137 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[5276.49,4614.34,4.23195],[],0,"CAN_COLLIDE"];
	_this = _item137;
	_objects pushback _this;
	_objectIDs pushback 137;
	_this setPosWorld [5276.49,4614.34,20.7267];
	_this setVectorDirAndUp [[-0.737843,0.674973,0],[0,0,1]];
};

private _item138 = objNull;
if (_layerRoot) then {
	_item138 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[5279.26,4611.9,2.51209],[],0,"CAN_COLLIDE"];
	_this = _item138;
	_objects pushback _this;
	_objectIDs pushback 138;
	_this setPosWorld [5279.26,4611.9,19.0068];
	_this setVectorDirAndUp [[-0.744431,0.6677,0],[0,0,1]];
};

private _item139 = objNull;
if (_layerRoot) then {
	_item139 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[5277.27,4613.69,3.08546],[],0,"CAN_COLLIDE"];
	_this = _item139;
	_objects pushback _this;
	_objectIDs pushback 139;
	_this setPosWorld [5277.27,4613.69,19.4559];
	_this setVectorDirAndUp [[-0.7251,0.688644,0],[0,0,1]];
};

private _item140 = objNull;
if (_layerRoot) then {
	_item140 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[5264.19,4586.1,0.0997715],[],0,"CAN_COLLIDE"];
	_this = _item140;
	_objects pushback _this;
	_objectIDs pushback 140;
	_this setPosWorld [5264.19,4586.1,16.5945];
	_this setVectorDirAndUp [[-0.673468,-0.739216,0],[0,0,1]];
};

private _item141 = objNull;
if (_layerRoot) then {
	_item141 = createVehicle ["Land_O2_Noel_Lum_Sapin_seul",[5262.32,4583.93,0.557131],[],0,"CAN_COLLIDE"];
	_this = _item141;
	_objects pushback _this;
	_objectIDs pushback 141;
	_this setPosWorld [5262.32,4583.93,17.0289];
	_this setVectorDirAndUp [[0.666467,0.745535,0],[0,0,1]];
};

private _item142 = objNull;
if (_layerRoot) then {
	_item142 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[5264.56,4624.73,0.111],[],0,"CAN_COLLIDE"];
	_this = _item142;
	_objects pushback _this;
	_objectIDs pushback 142;
	_this setPosWorld [5264.56,4624.73,14.9022];
	_this setVectorDirAndUp [[-0.772879,0.634553,0],[0,0,1]];
};

private _item143 = objNull;
if (_layerRoot) then {
	_item143 = createVehicle ["Land_MRP_O2_Kdo",[5264.94,4624.36,0.111],[],0,"CAN_COLLIDE"];
	_this = _item143;
	_objects pushback _this;
	_objectIDs pushback 143;
	_this setPosWorld [5264.94,4624.36,14.6938];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item144 = objNull;
if (_layerRoot) then {
	_item144 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5264.24,4625.13,0.111],[],0,"CAN_COLLIDE"];
	_this = _item144;
	_objects pushback _this;
	_objectIDs pushback 144;
	_this setPosWorld [5264.24,4625.13,14.6938];
	_this setVectorDirAndUp [[0.662593,0.74898,0],[0,0,1]];
};

private _item145 = objNull;
if (_layerRoot) then {
	_item145 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5276.99,4608.97,0],[],0,"CAN_COLLIDE"];
	_this = _item145;
	_objects pushback _this;
	_objectIDs pushback 145;
	_this setPosWorld [5276.99,4608.97,14.5828];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item146 = objNull;
if (_layerRoot) then {
	_item146 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[4058.51,5860.72,2.84051],[],0,"CAN_COLLIDE"];
	_this = _item146;
	_objects pushback _this;
	_objectIDs pushback 146;
	_this setPosWorld [4058.51,5860.72,21.1045];
	_this setVectorDirAndUp [[0.803929,-0.594725,0],[0,0,1]];
};

private _item150 = objNull;
if (_layerRoot) then {
	_item150 = createVehicle ["Land_MRP_O2_Kdo",[4108.55,5925.86,0.104461],[],0,"CAN_COLLIDE"];
	_this = _item150;
	_objects pushback _this;
	_objectIDs pushback 150;
	_this setPosWorld [4108.55,5925.86,15.2372];
	_this setVectorDirAndUp [[-0.628179,-0.778069,0],[0,0,1]];
};

private _item151 = objNull;
if (_layerRoot) then {
	_item151 = createVehicle ["Land_MRP_O2_Gros_Kdo_Rose",[4108.71,5926.39,0.104461],[],0,"CAN_COLLIDE"];
	_this = _item151;
	_objects pushback _this;
	_objectIDs pushback 151;
	_this setPosWorld [4108.71,5926.39,15.4456];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item152 = objNull;
if (_layerRoot) then {
	_item152 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4112.89,5916.21,0.50523],[],0,"CAN_COLLIDE"];
	_this = _item152;
	_objects pushback _this;
	_objectIDs pushback 152;
	_this setPosWorld [4112.89,5916.21,15.638];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item156 = objNull;
if (_layerRoot) then {
	_item156 = createVehicle ["Land_O2_Sapin_Noel_anim",[4136.16,5929.62,0.365299],[],0,"CAN_COLLIDE"];
	_this = _item156;
	_objects pushback _this;
	_objectIDs pushback 156;
	_this setPosWorld [4136.16,5929.62,18.7774];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item157 = objNull;
if (_layerRoot) then {
	_item157 = createVehicle ["Land_Bare_boulder_02_F",[4135.99,5929.76,0],[],0,"CAN_COLLIDE"];
	_this = _item157;
	_objects pushback _this;
	_objectIDs pushback 157;
	_this setPosWorld [4135.99,5929.76,14.9964];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item158 = objNull;
if (_layerRoot) then {
	_item158 = createVehicle ["Land_MRP_O2_Kdo",[4136.76,5928.52,0.000999451],[],0,"CAN_COLLIDE"];
	_this = _item158;
	_objects pushback _this;
	_objectIDs pushback 158;
	_this setPosWorld [4136.76,5928.52,15.1338];
	_this setVectorDirAndUp [[0.853829,0.520554,0],[0,0,1]];
};

private _item159 = objNull;
if (_layerRoot) then {
	_item159 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4135.49,5928.3,0.0019989],[],0,"CAN_COLLIDE"];
	_this = _item159;
	_objects pushback _this;
	_objectIDs pushback 159;
	_this setPosWorld [4135.49,5928.3,15.3432];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item160 = objNull;
if (_layerRoot) then {
	_item160 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4134.98,5928.51,0],[],0,"CAN_COLLIDE"];
	_this = _item160;
	_objects pushback _this;
	_objectIDs pushback 160;
	_this setPosWorld [4134.98,5928.51,15.1328];
	_this setVectorDirAndUp [[0.938456,0.345399,0],[0,0,1]];
};

private _item161 = objNull;
if (_layerRoot) then {
	_item161 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4135.94,5928.08,0.0019989],[],0,"CAN_COLLIDE"];
	_this = _item161;
	_objects pushback _this;
	_objectIDs pushback 161;
	_this setPosWorld [4135.94,5928.08,15.1348];
	_this setVectorDirAndUp [[0.679332,-0.733831,0],[0,0,1]];
};

private _item162 = objNull;
if (_layerRoot) then {
	_item162 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4136.9,5928.93,0.000999451],[],0,"CAN_COLLIDE"];
	_this = _item162;
	_objects pushback _this;
	_objectIDs pushback 162;
	_this setPosWorld [4136.9,5928.93,15.1338];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item163 = objNull;
if (_layerRoot) then {
	_item163 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[4137.48,5931.14,0.0019989],[],0,"CAN_COLLIDE"];
	_this = _item163;
	_objects pushback _this;
	_objectIDs pushback 163;
	_this setPosWorld [4137.48,5931.14,15.3432];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item164 = objNull;
if (_layerRoot) then {
	_item164 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4137.87,5930.68,0.0019989],[],0,"CAN_COLLIDE"];
	_this = _item164;
	_objects pushback _this;
	_objectIDs pushback 164;
	_this setPosWorld [4137.87,5930.68,15.1348];
	_this setVectorDirAndUp [[-0.944282,-0.329139,0],[0,0,1]];
};

private _item165 = objNull;
if (_layerRoot) then {
	_item165 = createVehicle ["Land_MRP_O2_Kdo",[4138.13,5930.29,0.0019989],[],0,"CAN_COLLIDE"];
	_this = _item165;
	_objects pushback _this;
	_objectIDs pushback 165;
	_this setPosWorld [4138.13,5930.29,15.1348];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item166 = objNull;
if (_layerRoot) then {
	_item166 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4138.08,5931.06,0.0019989],[],0,"CAN_COLLIDE"];
	_this = _item166;
	_objects pushback _this;
	_objectIDs pushback 166;
	_this setPosWorld [4138.08,5931.06,15.1348];
	_this setVectorDirAndUp [[-0.740735,-0.671797,0],[0,0,1]];
};

private _item167 = objNull;
if (_layerRoot) then {
	_item167 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4135.68,5930.64,0],[],0,"CAN_COLLIDE"];
	_this = _item167;
	_objects pushback _this;
	_objectIDs pushback 167;
	_this setPosWorld [4135.68,5930.64,15.1328];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item168 = objNull;
if (_layerRoot) then {
	_item168 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4135.33,5930.29,0],[],0,"CAN_COLLIDE"];
	_this = _item168;
	_objects pushback _this;
	_objectIDs pushback 168;
	_this setPosWorld [4135.33,5930.29,15.1328];
	_this setVectorDirAndUp [[-0.92443,-0.381352,0],[0,0,1]];
};

private _item169 = objNull;
if (_layerRoot) then {
	_item169 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[4588,7461.87,0],[],0,"CAN_COLLIDE"];
	_this = _item169;
	_objects pushback _this;
	_objectIDs pushback 169;
	_this setPosWorld [4588,7461.87,17.964];
	_this setVectorDirAndUp [[0.599659,0.800256,0],[0,0,1]];
};

private _item170 = objNull;
if (_layerRoot) then {
	_item170 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[4458.37,7504.58,0],[],0,"CAN_COLLIDE"];
	_this = _item170;
	_objects pushback _this;
	_objectIDs pushback 170;
	_this setPosWorld [4458.37,7504.58,17.904];
	_this setVectorDirAndUp [[0.257584,0.966256,0],[0,0,1]];
};

private _item171 = objNull;
if (_layerRoot) then {
	_item171 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[4480.45,7538.61,0],[],0,"CAN_COLLIDE"];
	_this = _item171;
	_objects pushback _this;
	_objectIDs pushback 171;
	_this setPosWorld [4480.45,7538.61,17.904];
	_this setVectorDirAndUp [[0.576527,0.817078,0],[0,0,1]];
};

private _item172 = objNull;
if (_layerRoot) then {
	_item172 = createVehicle ["Land_O2_Sapin_Noel_anim",[4381.75,7523.91,0.364997],[],0,"CAN_COLLIDE"];
	_this = _item172;
	_objects pushback _this;
	_objectIDs pushback 172;
	_this setPosWorld [4381.75,7523.91,18.4171];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item173 = objNull;
if (_layerRoot) then {
	_item173 = createVehicle ["Land_Bare_boulder_02_F",[4381.58,7524.05,0],[],0,"CAN_COLLIDE"];
	_this = _item173;
	_objects pushback _this;
	_objectIDs pushback 173;
	_this setPosWorld [4381.58,7524.05,14.6364];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item174 = objNull;
if (_layerRoot) then {
	_item174 = createVehicle ["Land_MRP_O2_Kdo",[4382.35,7522.81,0.000694275],[],0,"CAN_COLLIDE"];
	_this = _item174;
	_objects pushback _this;
	_objectIDs pushback 174;
	_this setPosWorld [4382.35,7522.81,14.7735];
	_this setVectorDirAndUp [[0.853829,0.520554,0],[0,0,1]];
};

private _item175 = objNull;
if (_layerRoot) then {
	_item175 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4381.08,7522.6,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item175;
	_objects pushback _this;
	_objectIDs pushback 175;
	_this setPosWorld [4381.08,7522.6,14.9829];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item176 = objNull;
if (_layerRoot) then {
	_item176 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4380.58,7522.8,0],[],0,"CAN_COLLIDE"];
	_this = _item176;
	_objects pushback _this;
	_objectIDs pushback 176;
	_this setPosWorld [4380.58,7522.8,14.7728];
	_this setVectorDirAndUp [[0.938456,0.345399,0],[0,0,1]];
};

private _item177 = objNull;
if (_layerRoot) then {
	_item177 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4381.53,7522.37,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item177;
	_objects pushback _this;
	_objectIDs pushback 177;
	_this setPosWorld [4381.53,7522.37,14.7745];
	_this setVectorDirAndUp [[0.679332,-0.733831,0],[0,0,1]];
};

private _item178 = objNull;
if (_layerRoot) then {
	_item178 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4382.5,7523.22,0.000694275],[],0,"CAN_COLLIDE"];
	_this = _item178;
	_objects pushback _this;
	_objectIDs pushback 178;
	_this setPosWorld [4382.5,7523.22,14.7735];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item179 = objNull;
if (_layerRoot) then {
	_item179 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[4383.07,7525.43,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item179;
	_objects pushback _this;
	_objectIDs pushback 179;
	_this setPosWorld [4383.07,7525.43,14.9829];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item180 = objNull;
if (_layerRoot) then {
	_item180 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4383.46,7524.97,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item180;
	_objects pushback _this;
	_objectIDs pushback 180;
	_this setPosWorld [4383.46,7524.97,14.7745];
	_this setVectorDirAndUp [[-0.944282,-0.329139,0],[0,0,1]];
};

private _item181 = objNull;
if (_layerRoot) then {
	_item181 = createVehicle ["Land_MRP_O2_Kdo",[4383.72,7524.58,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item181;
	_objects pushback _this;
	_objectIDs pushback 181;
	_this setPosWorld [4383.72,7524.58,14.7745];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item182 = objNull;
if (_layerRoot) then {
	_item182 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4383.68,7525.35,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item182;
	_objects pushback _this;
	_objectIDs pushback 182;
	_this setPosWorld [4383.68,7525.35,14.7745];
	_this setVectorDirAndUp [[-0.740735,-0.671797,0],[0,0,1]];
};

private _item183 = objNull;
if (_layerRoot) then {
	_item183 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4381.27,7524.93,0],[],0,"CAN_COLLIDE"];
	_this = _item183;
	_objects pushback _this;
	_objectIDs pushback 183;
	_this setPosWorld [4381.27,7524.93,14.7728];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item184 = objNull;
if (_layerRoot) then {
	_item184 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4380.93,7524.59,0],[],0,"CAN_COLLIDE"];
	_this = _item184;
	_objects pushback _this;
	_objectIDs pushback 184;
	_this setPosWorld [4380.93,7524.59,14.7728];
	_this setVectorDirAndUp [[-0.92443,-0.381352,0],[0,0,1]];
};

private _item185 = objNull;
if (_layerRoot) then {
	_item185 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4403.98,7539.32,5.10469],[],0,"CAN_COLLIDE"];
	_this = _item185;
	_objects pushback _this;
	_objectIDs pushback 185;
	_this setPosWorld [4403.98,7539.32,21.7894];
	_this setVectorDirAndUp [[0.423383,0.905951,0],[0,0,1]];
};

private _item186 = objNull;
if (_layerRoot) then {
	_item186 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4404.6,7540.72,4.65539],[],0,"CAN_COLLIDE"];
	_this = _item186;
	_objects pushback _this;
	_objectIDs pushback 186;
	_this setPosWorld [4404.6,7540.72,21.2158];
	_this setVectorDirAndUp [[0.423689,0.905808,0],[0,0,1]];
};

private _item187 = objNull;
if (_layerRoot) then {
	_item187 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4404.64,7540.68,7.69501],[],0,"CAN_COLLIDE"];
	_this = _item187;
	_objects pushback _this;
	_objectIDs pushback 187;
	_this setPosWorld [4404.64,7540.68,24.2554];
	_this setVectorDirAndUp [[0.423689,0.905808,0],[0,0,1]];
};

private _item188 = objNull;
if (_layerRoot) then {
	_item188 = createVehicle ["Land_O2_Sapin_Noel_anim",[4420.79,7534.86,0.392024],[],0,"CAN_COLLIDE"];
	_this = _item188;
	_objects pushback _this;
	_objectIDs pushback 188;
	_this setPosWorld [4420.79,7534.86,18.4442];
	_this setVectorDirAndUp [[-0.97762,-0.210379,0],[0,0,1]];
};

private _item189 = objNull;
if (_layerRoot) then {
	_item189 = createVehicle ["Land_Bare_boulder_02_F",[4420.94,7535.02,0.0270281],[],0,"CAN_COLLIDE"];
	_this = _item189;
	_objects pushback _this;
	_objectIDs pushback 189;
	_this setPosWorld [4420.94,7535.02,14.6635];
	_this setVectorDirAndUp [[-0.97762,-0.210379,0],[0,0,1]];
};

private _item190 = objNull;
if (_layerRoot) then {
	_item190 = createVehicle ["Land_MRP_O2_Kdo",[4419.62,7534.4,0.0277224],[],0,"CAN_COLLIDE"];
	_this = _item190;
	_objects pushback _this;
	_objectIDs pushback 190;
	_this setPosWorld [4419.62,7534.4,14.8005];
	_this setVectorDirAndUp [[0.416949,-0.90893,0],[0,0,1]];
};

private _item191 = objNull;
if (_layerRoot) then {
	_item191 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4419.56,7535.69,0.0287218],[],0,"CAN_COLLIDE"];
	_this = _item191;
	_objects pushback _this;
	_objectIDs pushback 191;
	_this setPosWorld [4419.56,7535.69,15.0099];
	_this setVectorDirAndUp [[-0.97762,-0.210379,0],[0,0,1]];
};

private _item192 = objNull;
if (_layerRoot) then {
	_item192 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4419.82,7536.16,0.0270281],[],0,"CAN_COLLIDE"];
	_this = _item192;
	_objects pushback _this;
	_objectIDs pushback 192;
	_this setPosWorld [4419.82,7536.16,14.7998];
	_this setVectorDirAndUp [[0.233086,-0.972456,0],[0,0,1]];
};

private _item193 = objNull;
if (_layerRoot) then {
	_item193 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4419.28,7535.26,0.0287218],[],0,"CAN_COLLIDE"];
	_this = _item193;
	_objects pushback _this;
	_objectIDs pushback 193;
	_this setPosWorld [4419.28,7535.26,14.8015];
	_this setVectorDirAndUp [[-0.808359,-0.58869,0],[0,0,1]];
};

private _item194 = objNull;
if (_layerRoot) then {
	_item194 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4420.01,7534.21,0.0277224],[],0,"CAN_COLLIDE"];
	_this = _item194;
	_objects pushback _this;
	_objectIDs pushback 194;
	_this setPosWorld [4420.01,7534.21,14.8005];
	_this setVectorDirAndUp [[-0.97762,-0.210379,0],[0,0,1]];
};

private _item195 = objNull;
if (_layerRoot) then {
	_item195 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[4422.14,7533.38,0.0277214],[],0,"CAN_COLLIDE"];
	_this = _item195;
	_objects pushback _this;
	_objectIDs pushback 195;
	_this setPosWorld [4422.14,7533.38,15.0089];
	_this setVectorDirAndUp [[-0.97762,-0.210379,0],[0,0,1]];
};

private _item196 = objNull;
if (_layerRoot) then {
	_item196 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4421.64,7533.04,0.0277214],[],0,"CAN_COLLIDE"];
	_this = _item196;
	_objects pushback _this;
	_objectIDs pushback 196;
	_this setPosWorld [4421.64,7533.04,14.8005];
	_this setVectorDirAndUp [[-0.216256,0.976337,0],[0,0,1]];
};

private _item197 = objNull;
if (_layerRoot) then {
	_item197 = createVehicle ["Land_MRP_O2_Kdo",[4421.22,7532.83,0.0277214],[],0,"CAN_COLLIDE"];
	_this = _item197;
	_objects pushback _this;
	_objectIDs pushback 197;
	_this setPosWorld [4421.22,7532.83,14.8005];
	_this setVectorDirAndUp [[-0.97762,-0.210379,0],[0,0,1]];
};

private _item198 = objNull;
if (_layerRoot) then {
	_item198 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4421.99,7532.78,0.0277214],[],0,"CAN_COLLIDE"];
	_this = _item198;
	_objects pushback _this;
	_objectIDs pushback 198;
	_this setPosWorld [4421.99,7532.78,14.8005];
	_this setVectorDirAndUp [[-0.580399,0.814332,0],[0,0,1]];
};

private _item199 = objNull;
if (_layerRoot) then {
	_item199 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4421.86,7535.23,0.0260277],[],0,"CAN_COLLIDE"];
	_this = _item199;
	_objects pushback _this;
	_objectIDs pushback 199;
	_this setPosWorld [4421.86,7535.23,14.7988];
	_this setVectorDirAndUp [[-0.97762,-0.210379,0],[0,0,1]];
};

private _item200 = objNull;
if (_layerRoot) then {
	_item200 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4421.55,7535.6,0.0270281],[],0,"CAN_COLLIDE"];
	_this = _item200;
	_objects pushback _this;
	_objectIDs pushback 200;
	_this setPosWorld [4421.55,7535.6,14.7998];
	_this setVectorDirAndUp [[-0.270435,0.962738,0],[0,0,1]];
};

private _item202 = objNull;
if (_layerRoot) then {
	_item202 = createVehicle ["Land_O2_Sapin_Noel_anim",[4454.04,7581.67,0.404672],[],0,"CAN_COLLIDE"];
	_this = _item202;
	_objects pushback _this;
	_objectIDs pushback 202;
	_this setPosWorld [4454.04,7581.67,18.4568];
	_this setVectorDirAndUp [[-0.905294,-0.424786,0],[0,0,1]];
};

private _item203 = objNull;
if (_layerRoot) then {
	_item203 = createVehicle ["Land_Bare_boulder_02_F",[4454.16,7581.86,0.0396099],[],0,"CAN_COLLIDE"];
	_this = _item203;
	_objects pushback _this;
	_objectIDs pushback 203;
	_this setPosWorld [4454.16,7581.86,14.676];
	_this setVectorDirAndUp [[-0.905294,-0.424786,0],[0,0,1]];
};

private _item204 = objNull;
if (_layerRoot) then {
	_item204 = createVehicle ["Land_MRP_O2_Kdo",[4453.01,7580.96,0.0397301],[],0,"CAN_COLLIDE"];
	_this = _item204;
	_objects pushback _this;
	_objectIDs pushback 204;
	_this setPosWorld [4453.01,7580.96,14.8125];
	_this setVectorDirAndUp [[0.610624,-0.79192,0],[0,0,1]];
};

private _item205 = objNull;
if (_layerRoot) then {
	_item205 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4452.66,7582.2,0.0413036],[],0,"CAN_COLLIDE"];
	_this = _item205;
	_objects pushback _this;
	_objectIDs pushback 205;
	_this setPosWorld [4452.66,7582.2,15.0225];
	_this setVectorDirAndUp [[-0.905294,-0.424786,0],[0,0,1]];
};

private _item206 = objNull;
if (_layerRoot) then {
	_item206 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4452.81,7582.72,0.0396099],[],0,"CAN_COLLIDE"];
	_this = _item206;
	_objects pushback _this;
	_objectIDs pushback 206;
	_this setPosWorld [4452.81,7582.72,14.8124];
	_this setVectorDirAndUp [[0.445751,-0.895157,0],[0,0,1]];
};

private _item207 = objNull;
if (_layerRoot) then {
	_item207 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4452.49,7581.72,0.0407295],[],0,"CAN_COLLIDE"];
	_this = _item207;
	_objects pushback _this;
	_objectIDs pushback 207;
	_this setPosWorld [4452.49,7581.72,14.8135];
	_this setVectorDirAndUp [[-0.655312,-0.755359,0],[0,0,1]];
};

private _item208 = objNull;
if (_layerRoot) then {
	_item208 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4453.44,7580.86,0.0397301],[],0,"CAN_COLLIDE"];
	_this = _item208;
	_objects pushback _this;
	_objectIDs pushback 208;
	_this setPosWorld [4453.44,7580.86,14.8125];
	_this setVectorDirAndUp [[-0.905294,-0.424786,0],[0,0,1]];
};

private _item209 = objNull;
if (_layerRoot) then {
	_item209 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[4455.7,7580.53,0.0413399],[],0,"CAN_COLLIDE"];
	_this = _item209;
	_objects pushback _this;
	_objectIDs pushback 209;
	_this setPosWorld [4455.7,7580.53,15.0225];
	_this setVectorDirAndUp [[-0.905294,-0.424786,0],[0,0,1]];
};

private _item210 = objNull;
if (_layerRoot) then {
	_item210 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4455.28,7580.09,0.0413399],[],0,"CAN_COLLIDE"];
	_this = _item210;
	_objects pushback _this;
	_objectIDs pushback 210;
	_this setPosWorld [4455.28,7580.09,14.8141];
	_this setVectorDirAndUp [[-0.430224,0.902722,0],[0,0,1]];
};

private _item211 = objNull;
if (_layerRoot) then {
	_item211 = createVehicle ["Land_MRP_O2_Kdo",[4454.93,7579.79,0.0413399],[],0,"CAN_COLLIDE"];
	_this = _item211;
	_objects pushback _this;
	_objectIDs pushback 211;
	_this setPosWorld [4454.93,7579.79,14.8141];
	_this setVectorDirAndUp [[-0.905294,-0.424786,0],[0,0,1]];
};

private _item212 = objNull;
if (_layerRoot) then {
	_item212 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4455.69,7579.92,0.0413399],[],0,"CAN_COLLIDE"];
	_this = _item212;
	_objects pushback _this;
	_objectIDs pushback 212;
	_this setPosWorld [4455.69,7579.92,14.8141];
	_this setVectorDirAndUp [[-0.748622,0.662997,0],[0,0,1]];
};

private _item213 = objNull;
if (_layerRoot) then {
	_item213 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4455,7582.27,0.0395985],[],0,"CAN_COLLIDE"];
	_this = _item213;
	_objects pushback _this;
	_objectIDs pushback 213;
	_this setPosWorld [4455,7582.27,14.8124];
	_this setVectorDirAndUp [[-0.905294,-0.424786,0],[0,0,1]];
};

private _item214 = objNull;
if (_layerRoot) then {
	_item214 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4454.63,7582.57,0.0396099],[],0,"CAN_COLLIDE"];
	_this = _item214;
	_objects pushback _this;
	_objectIDs pushback 214;
	_this setPosWorld [4454.63,7582.57,14.8124];
	_this setVectorDirAndUp [[-0.479959,0.877291,0],[0,0,1]];
};

private _item215 = objNull;
if (_layerRoot) then {
	_item215 = createVehicle ["Land_O2_Noel_Lum_Boule_seul",[4405.24,7542.7,5.64234],[],0,"CAN_COLLIDE"];
	_this = _item215;
	_objects pushback _this;
	_objectIDs pushback 215;
	_this setPosWorld [4405.24,7542.7,22.2028];
	_this setVectorDirAndUp [[0.439453,0.898266,0],[0,0,1]];
};

private _item216 = objNull;
if (_layerRoot) then {
	_item216 = createVehicle ["Land_O2_Noel_Lum_Sapin_seul",[4408.32,7549.16,5.62125],[],0,"CAN_COLLIDE"];
	_this = _item216;
	_objects pushback _this;
	_objectIDs pushback 216;
	_this setPosWorld [4408.32,7549.16,22.283];
	_this setVectorDirAndUp [[0.437235,0.899347,0],[0,0,1]];
};

private _item217 = objNull;
if (_layerRoot) then {
	_item217 = createVehicle ["Land_MRP_O2_Gros_Kdo_Rose",[4404.47,7545.14,0.22392],[],0,"CAN_COLLIDE"];
	_this = _item217;
	_objects pushback _this;
	_objectIDs pushback 217;
	_this setPosWorld [4404.47,7545.14,15.2051];
	_this setVectorDirAndUp [[0.526907,0.849923,0],[0,0,1]];
};

private _item218 = objNull;
if (_layerRoot) then {
	_item218 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4405.02,7545.08,0.223919],[],0,"CAN_COLLIDE"];
	_this = _item218;
	_objects pushback _this;
	_objectIDs pushback 218;
	_this setPosWorld [4405.02,7545.08,14.9967];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item219 = objNull;
if (_layerRoot) then {
	_item219 = createVehicle ["Land_MRP_O2_Kdo",[4403.92,7544.85,0.22392],[],0,"CAN_COLLIDE"];
	_this = _item219;
	_objects pushback _this;
	_objectIDs pushback 219;
	_this setPosWorld [4403.92,7544.85,14.9967];
	_this setVectorDirAndUp [[-0.925215,0.379442,0],[0,0,1]];
};

private _item220 = objNull;
if (_layerRoot) then {
	_item220 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[4403.51,7538.08,0.0260191],[],0,"CAN_COLLIDE"];
	_this = _item220;
	_objects pushback _this;
	_objectIDs pushback 220;
	_this setPosWorld [4403.51,7538.08,15.0072];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item221 = objNull;
if (_layerRoot) then {
	_item221 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4397.87,7541.66,0.221066],[],0,"CAN_COLLIDE"];
	_this = _item221;
	_objects pushback _this;
	_objectIDs pushback 221;
	_this setPosWorld [4397.87,7541.66,15.2022];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item222 = objNull;
if (_layerRoot) then {
	_item222 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4389.98,7551.2,0.221067],[],0,"CAN_COLLIDE"];
	_this = _item222;
	_objects pushback _this;
	_objectIDs pushback 222;
	_this setPosWorld [4389.98,7551.2,14.9938];
	_this setVectorDirAndUp [[-0.916839,0.399258,0],[0,0,1]];
};

private _item223 = objNull;
if (_layerRoot) then {
	_item223 = createVehicle ["Land_MRP_O2_Kdo",[4373.58,7551.96,1.16139],[],0,"CAN_COLLIDE"];
	_this = _item223;
	_objects pushback _this;
	_objectIDs pushback 223;
	_this setPosWorld [4373.58,7551.96,15.9342];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item228 = objNull;
if (_layerRoot) then {
	_item228 = createVehicle ["Land_O2_Sapin_Noel",[4424.06,7553.67,0.039115],[],0,"CAN_COLLIDE"];
	_this = _item228;
	_objects pushback _this;
	_objectIDs pushback 228;
	_this setPosWorld [4424.06,7553.67,18.0912];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item229 = objNull;
if (_layerRoot) then {
	_item229 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[4389.12,7577.25,2.563],[],0,"CAN_COLLIDE"];
	_this = _item229;
	_objects pushback _this;
	_objectIDs pushback 229;
	_this setPosWorld [4389.12,7577.25,17.5442];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item230 = objNull;
if (_layerRoot) then {
	_item230 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4396.42,7564.05,0.0289822],[],0,"CAN_COLLIDE"];
	_this = _item230;
	_objects pushback _this;
	_objectIDs pushback 230;
	_this setPosWorld [4396.42,7564.05,15.0102];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item231 = objNull;
if (_layerRoot) then {
	_item231 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4396.34,7564.48,0.0389824],[],0,"CAN_COLLIDE"];
	_this = _item231;
	_objects pushback _this;
	_objectIDs pushback 231;
	_this setPosWorld [4396.34,7564.48,14.8118];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item232 = objNull;
if (_layerRoot) then {
	_item232 = createVehicle ["Land_MRP_O2_Kdo",[4396.74,7563.56,0.0389824],[],0,"CAN_COLLIDE"];
	_this = _item232;
	_objects pushback _this;
	_objectIDs pushback 232;
	_this setPosWorld [4396.74,7563.56,14.8118];
	_this setVectorDirAndUp [[-0.511231,-0.859443,0],[0,0,1]];
};

private _item233 = objNull;
if (_layerRoot) then {
	_item233 = createVehicle ["Land_MRP_O2_Gros_Kdo_Rose",[4416.96,7604.25,0.0250378],[],0,"CAN_COLLIDE"];
	_this = _item233;
	_objects pushback _this;
	_objectIDs pushback 233;
	_this setPosWorld [4416.96,7604.25,15.0062];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item235 = objNull;
if (_layerRoot) then {
	_item235 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4416.53,7604.7,0.0250378],[],0,"CAN_COLLIDE"];
	_this = _item235;
	_objects pushback _this;
	_objectIDs pushback 235;
	_this setPosWorld [4416.53,7604.7,14.7978];
	_this setVectorDirAndUp [[-0.982872,-0.184288,0],[0,0,1]];
};

private _item237 = objNull;
if (_layerRoot) then {
	_item237 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4381.64,7537.71,0.768422],[],0,"CAN_COLLIDE"];
	_this = _item237;
	_objects pushback _this;
	_objectIDs pushback 237;
	_this setPosWorld [4381.64,7537.71,15.5412];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item238 = objNull;
if (_layerRoot) then {
	_item238 = createVehicle ["Land_O2_Noel_Lum_Boule_seul",[4366.28,7555.37,3.38831],[],0,"CAN_COLLIDE"];
	_this = _item238;
	_objects pushback _this;
	_objectIDs pushback 238;
	_this setPosWorld [4366.28,7555.37,19.9487];
	_this setVectorDirAndUp [[0.907729,-0.419557,0],[0,0,1]];
};

private _item239 = objNull;
if (_layerRoot) then {
	_item239 = createVehicle ["Land_O2_Noel_Lum_JoyFet_seul",[4397.03,7541.01,-9.53674e-07],[],0,"CAN_COLLIDE"];
	_this = _item239;
	_objects pushback _this;
	_objectIDs pushback 239;
	_this setPosWorld [4397.03,7541.01,18.0257];
	_this setVectorDirAndUp [[0.905613,-0.424105,0],[0,0,1]];
};

private _item240 = objNull;
if (_layerRoot) then {
	_item240 = createVehicle ["Land_O2_Sapin_Noel",[4497.77,7515.49,-9.53674e-07],[],0,"CAN_COLLIDE"];
	_this = _item240;
	_objects pushback _this;
	_objectIDs pushback 240;
	_this setPosWorld [4497.77,7515.49,18.0988];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item241 = objNull;
if (_layerRoot) then {
	_item241 = createVehicle ["Land_MRP_O2_Gros_Kdo_Rose",[4484.82,7543.52,0.039505],[],0,"CAN_COLLIDE"];
	_this = _item241;
	_objects pushback _this;
	_objectIDs pushback 241;
	_this setPosWorld [4484.82,7543.52,15.0207];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item242 = objNull;
if (_layerRoot) then {
	_item242 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4484.26,7543.26,0.039505],[],0,"CAN_COLLIDE"];
	_this = _item242;
	_objects pushback _this;
	_objectIDs pushback 242;
	_this setPosWorld [4484.26,7543.26,14.8123];
	_this setVectorDirAndUp [[-0.819051,0.573721,0],[0,0,1]];
};

private _item243 = objNull;
if (_layerRoot) then {
	_item243 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4400.42,7554.99,5.1893],[],0,"CAN_COLLIDE"];
	_this = _item243;
	_objects pushback _this;
	_objectIDs pushback 243;
	_this setPosWorld [4400.42,7554.99,21.874];
	_this setVectorDirAndUp [[-0.90736,0.420355,0],[0,0,1]];
};

private _item244 = objNull;
if (_layerRoot) then {
	_item244 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4394.55,7557.92,2.83919],[],0,"CAN_COLLIDE"];
	_this = _item244;
	_objects pushback _this;
	_objectIDs pushback 244;
	_this setPosWorld [4394.55,7557.92,19.5239];
	_this setVectorDirAndUp [[-0.90736,0.420355,0],[0,0,1]];
};

private _item245 = objNull;
if (_layerRoot) then {
	_item245 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4389.13,7560.22,4.99141],[],0,"CAN_COLLIDE"];
	_this = _item245;
	_objects pushback _this;
	_objectIDs pushback 245;
	_this setPosWorld [4389.13,7560.22,21.6761];
	_this setVectorDirAndUp [[-0.90736,0.420355,0],[0,0,1]];
};

private _item246 = objNull;
if (_layerRoot) then {
	_item246 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4406.57,7552.14,5.22951],[],0,"CAN_COLLIDE"];
	_this = _item246;
	_objects pushback _this;
	_objectIDs pushback 246;
	_this setPosWorld [4406.57,7552.14,21.7899];
	_this setVectorDirAndUp [[-0.903475,0.428641,0],[0,0,1]];
};

private _item247 = objNull;
if (_layerRoot) then {
	_item247 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4404.68,7553,7.37672],[],0,"CAN_COLLIDE"];
	_this = _item247;
	_objects pushback _this;
	_objectIDs pushback 247;
	_this setPosWorld [4404.68,7553,23.9371];
	_this setVectorDirAndUp [[-0.903475,0.428641,0],[0,0,1]];
};

private _item248 = objNull;
if (_layerRoot) then {
	_item248 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4397.24,7557.56,6.38555],[],0,"CAN_COLLIDE"];
	_this = _item248;
	_objects pushback _this;
	_objectIDs pushback 248;
	_this setPosWorld [4397.24,7557.56,22.946];
	_this setVectorDirAndUp [[-0.903475,0.428641,0],[0,0,1]];
};

private _item249 = objNull;
if (_layerRoot) then {
	_item249 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4392.8,7558.54,7.35679],[],0,"CAN_COLLIDE"];
	_this = _item249;
	_objects pushback _this;
	_objectIDs pushback 249;
	_this setPosWorld [4392.8,7558.54,23.9172];
	_this setVectorDirAndUp [[-0.903475,0.428641,0],[0,0,1]];
};

private _item250 = objNull;
if (_layerRoot) then {
	_item250 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4373.55,7551.97,3.66118],[],0,"CAN_COLLIDE"];
	_this = _item250;
	_objects pushback _this;
	_objectIDs pushback 250;
	_this setPosWorld [4373.55,7551.97,20.3459];
	_this setVectorDirAndUp [[-0.90736,0.420355,0],[0,0,1]];
};

private _item251 = objNull;
if (_layerRoot) then {
	_item251 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4385.15,7546.6,5.20011],[],0,"CAN_COLLIDE"];
	_this = _item251;
	_objects pushback _this;
	_objectIDs pushback 251;
	_this setPosWorld [4385.15,7546.6,21.7605];
	_this setVectorDirAndUp [[0.901506,-0.432766,0],[0,0,1]];
};

private _item252 = objNull;
if (_layerRoot) then {
	_item252 = createVehicle ["Land_O2_Noel_Lum_Neige_seul_petit",[4386.71,7545.88,3.02527],[],0,"CAN_COLLIDE"];
	_this = _item252;
	_objects pushback _this;
	_objectIDs pushback 252;
	_this setPosWorld [4386.71,7545.88,19.5857];
	_this setVectorDirAndUp [[0.913177,-0.407563,0],[0,0,1]];
};

private _item253 = objNull;
if (_layerRoot) then {
	_item253 = createVehicle ["Land_O2_Noel_Lum_Boule_seul",[4401.48,7539.03,3.74734],[],0,"CAN_COLLIDE"];
	_this = _item253;
	_objects pushback _this;
	_objectIDs pushback 253;
	_this setPosWorld [4401.48,7539.03,20.3078];
	_this setVectorDirAndUp [[-0.906706,0.421764,0],[0,0,1]];
};

private _item254 = objNull;
if (_layerRoot) then {
	_item254 = createVehicle ["Land_O2_Noel_Lum_Neige_seul",[4392.5,7543.18,3.02527],[],0,"CAN_COLLIDE"];
	_this = _item254;
	_objects pushback _this;
	_objectIDs pushback 254;
	_this setPosWorld [4392.5,7543.18,19.71];
	_this setVectorDirAndUp [[-0.90736,0.420355,0],[0,0,1]];
};

private _item255 = objNull;
if (_layerRoot) then {
	_item255 = createVehicle ["Land_O2_Noel_Lum_Sapin_seul",[4379.73,7549.13,3.62348],[],0,"CAN_COLLIDE"];
	_this = _item255;
	_objects pushback _this;
	_objectIDs pushback 255;
	_this setPosWorld [4379.73,7549.13,20.2853];
	_this setVectorDirAndUp [[0.907825,-0.41935,0],[0,0,1]];
};

private _item256 = objNull;
if (_layerRoot) then {
	_item256 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[4392.02,7512.78,0.0138044],[],0,"CAN_COLLIDE"];
	_this = _item256;
	_objects pushback _this;
	_objectIDs pushback 256;
	_this setPosWorld [4392.02,7512.78,14.995];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item257 = objNull;
if (_layerRoot) then {
	_item257 = createVehicle ["Land_MRP_O2_Kdo",[4391.91,7513.33,0.026],[],0,"CAN_COLLIDE"];
	_this = _item257;
	_objects pushback _this;
	_objectIDs pushback 257;
	_this setPosWorld [4391.91,7513.33,14.7988];
	_this setVectorDirAndUp [[-0.856367,0.516367,0],[0,0,1]];
};

private _item258 = objNull;
if (_layerRoot) then {
	_item258 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4432.87,7508.51,0.0179996],[],0,"CAN_COLLIDE"];
	_this = _item258;
	_objects pushback _this;
	_objectIDs pushback 258;
	_this setPosWorld [4432.87,7508.51,14.9992];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item259 = objNull;
if (_layerRoot) then {
	_item259 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4433.49,7508.37,0.0279999],[],0,"CAN_COLLIDE"];
	_this = _item259;
	_objects pushback _this;
	_objectIDs pushback 259;
	_this setPosWorld [4433.49,7508.37,14.8008];
	_this setVectorDirAndUp [[-0.512225,-0.858851,0],[0,0,1]];
};

private _item260 = objNull;
if (_layerRoot) then {
	_item260 = createVehicle ["Land_O2_Sapin_Noel_anim",[4887.64,7896.99,0.364995],[],0,"CAN_COLLIDE"];
	_this = _item260;
	_objects pushback _this;
	_objectIDs pushback 260;
	_this setPosWorld [4887.64,7896.99,18.6371];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item261 = objNull;
if (_layerRoot) then {
	_item261 = createVehicle ["Land_Bare_boulder_02_F",[4887.47,7897.13,0],[],0,"CAN_COLLIDE"];
	_this = _item261;
	_objects pushback _this;
	_objectIDs pushback 261;
	_this setPosWorld [4887.47,7897.13,14.8564];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item262 = objNull;
if (_layerRoot) then {
	_item262 = createVehicle ["Land_MRP_O2_Kdo",[4888.24,7895.89,0.000694275],[],0,"CAN_COLLIDE"];
	_this = _item262;
	_objects pushback _this;
	_objectIDs pushback 262;
	_this setPosWorld [4888.24,7895.89,14.9935];
	_this setVectorDirAndUp [[0.853829,0.520554,0],[0,0,1]];
};

private _item263 = objNull;
if (_layerRoot) then {
	_item263 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4886.97,7895.67,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item263;
	_objects pushback _this;
	_objectIDs pushback 263;
	_this setPosWorld [4886.97,7895.67,15.2029];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item264 = objNull;
if (_layerRoot) then {
	_item264 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4886.46,7895.88,0],[],0,"CAN_COLLIDE"];
	_this = _item264;
	_objects pushback _this;
	_objectIDs pushback 264;
	_this setPosWorld [4886.46,7895.88,14.9928];
	_this setVectorDirAndUp [[0.938456,0.345399,0],[0,0,1]];
};

private _item265 = objNull;
if (_layerRoot) then {
	_item265 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4887.42,7895.45,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item265;
	_objects pushback _this;
	_objectIDs pushback 265;
	_this setPosWorld [4887.42,7895.45,14.9945];
	_this setVectorDirAndUp [[0.679332,-0.733831,0],[0,0,1]];
};

private _item266 = objNull;
if (_layerRoot) then {
	_item266 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4888.38,7896.3,0.000694275],[],0,"CAN_COLLIDE"];
	_this = _item266;
	_objects pushback _this;
	_objectIDs pushback 266;
	_this setPosWorld [4888.38,7896.3,14.9935];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item267 = objNull;
if (_layerRoot) then {
	_item267 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[4888.96,7898.51,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item267;
	_objects pushback _this;
	_objectIDs pushback 267;
	_this setPosWorld [4888.96,7898.51,15.2029];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item268 = objNull;
if (_layerRoot) then {
	_item268 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4889.35,7898.05,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item268;
	_objects pushback _this;
	_objectIDs pushback 268;
	_this setPosWorld [4889.35,7898.05,14.9945];
	_this setVectorDirAndUp [[-0.944282,-0.329139,0],[0,0,1]];
};

private _item269 = objNull;
if (_layerRoot) then {
	_item269 = createVehicle ["Land_MRP_O2_Kdo",[4889.61,7897.66,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item269;
	_objects pushback _this;
	_objectIDs pushback 269;
	_this setPosWorld [4889.61,7897.66,14.9945];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item270 = objNull;
if (_layerRoot) then {
	_item270 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4889.57,7898.43,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item270;
	_objects pushback _this;
	_objectIDs pushback 270;
	_this setPosWorld [4889.57,7898.43,14.9945];
	_this setVectorDirAndUp [[-0.740735,-0.671797,0],[0,0,1]];
};

private _item271 = objNull;
if (_layerRoot) then {
	_item271 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4887.16,7898.01,0],[],0,"CAN_COLLIDE"];
	_this = _item271;
	_objects pushback _this;
	_objectIDs pushback 271;
	_this setPosWorld [4887.16,7898.01,14.9928];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item272 = objNull;
if (_layerRoot) then {
	_item272 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4886.81,7897.67,0],[],0,"CAN_COLLIDE"];
	_this = _item272;
	_objects pushback _this;
	_objectIDs pushback 272;
	_this setPosWorld [4886.81,7897.67,14.9928];
	_this setVectorDirAndUp [[-0.92443,-0.381352,0],[0,0,1]];
};

private _item273 = objNull;
if (_layerRoot) then {
	_item273 = createVehicle ["Land_O2_Sapin_Noel_anim",[5978.3,4202.82,0.364997],[],0,"CAN_COLLIDE"];
	_this = _item273;
	_objects pushback _this;
	_objectIDs pushback 273;
	_this setPosWorld [5978.3,4202.82,18.3071];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item274 = objNull;
if (_layerRoot) then {
	_item274 = createVehicle ["Land_Bare_boulder_02_F",[5978.13,4202.96,0],[],0,"CAN_COLLIDE"];
	_this = _item274;
	_objects pushback _this;
	_objectIDs pushback 274;
	_this setPosWorld [5978.13,4202.96,14.5264];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item275 = objNull;
if (_layerRoot) then {
	_item275 = createVehicle ["Land_MRP_O2_Kdo",[5978.9,4201.72,0.000694275],[],0,"CAN_COLLIDE"];
	_this = _item275;
	_objects pushback _this;
	_objectIDs pushback 275;
	_this setPosWorld [5978.9,4201.72,14.6635];
	_this setVectorDirAndUp [[0.853829,0.520554,0],[0,0,1]];
};

private _item276 = objNull;
if (_layerRoot) then {
	_item276 = createVehicle ["Land_MRP_O2_Gros_Kdo",[5977.63,4201.5,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item276;
	_objects pushback _this;
	_objectIDs pushback 276;
	_this setPosWorld [5977.63,4201.5,14.8729];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item277 = objNull;
if (_layerRoot) then {
	_item277 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5977.13,4201.71,0],[],0,"CAN_COLLIDE"];
	_this = _item277;
	_objects pushback _this;
	_objectIDs pushback 277;
	_this setPosWorld [5977.13,4201.71,14.6628];
	_this setVectorDirAndUp [[0.938456,0.345399,0],[0,0,1]];
};

private _item278 = objNull;
if (_layerRoot) then {
	_item278 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5978.08,4201.28,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item278;
	_objects pushback _this;
	_objectIDs pushback 278;
	_this setPosWorld [5978.08,4201.28,14.6645];
	_this setVectorDirAndUp [[0.679332,-0.733831,0],[0,0,1]];
};

private _item279 = objNull;
if (_layerRoot) then {
	_item279 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5979.04,4202.13,0.000694275],[],0,"CAN_COLLIDE"];
	_this = _item279;
	_objects pushback _this;
	_objectIDs pushback 279;
	_this setPosWorld [5979.04,4202.13,14.6635];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item280 = objNull;
if (_layerRoot) then {
	_item280 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[5979.62,4204.34,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item280;
	_objects pushback _this;
	_objectIDs pushback 280;
	_this setPosWorld [5979.62,4204.34,14.8729];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item281 = objNull;
if (_layerRoot) then {
	_item281 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5980.01,4203.88,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item281;
	_objects pushback _this;
	_objectIDs pushback 281;
	_this setPosWorld [5980.01,4203.88,14.6645];
	_this setVectorDirAndUp [[-0.944282,-0.329139,0],[0,0,1]];
};

private _item282 = objNull;
if (_layerRoot) then {
	_item282 = createVehicle ["Land_MRP_O2_Kdo",[5980.27,4203.49,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item282;
	_objects pushback _this;
	_objectIDs pushback 282;
	_this setPosWorld [5980.27,4203.49,14.6645];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item283 = objNull;
if (_layerRoot) then {
	_item283 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5980.23,4204.26,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item283;
	_objects pushback _this;
	_objectIDs pushback 283;
	_this setPosWorld [5980.23,4204.26,14.6645];
	_this setVectorDirAndUp [[-0.740735,-0.671797,0],[0,0,1]];
};

private _item284 = objNull;
if (_layerRoot) then {
	_item284 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5977.82,4203.84,0],[],0,"CAN_COLLIDE"];
	_this = _item284;
	_objects pushback _this;
	_objectIDs pushback 284;
	_this setPosWorld [5977.82,4203.84,14.6628];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item285 = objNull;
if (_layerRoot) then {
	_item285 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5977.48,4203.49,0],[],0,"CAN_COLLIDE"];
	_this = _item285;
	_objects pushback _this;
	_objectIDs pushback 285;
	_this setPosWorld [5977.48,4203.49,14.6628];
	_this setVectorDirAndUp [[-0.92443,-0.381352,0],[0,0,1]];
};

private _item287 = objNull;
if (_layerRoot) then {
	_item287 = createVehicle ["Land_O2_Sapin_Noel_anim",[6996.03,2413.52,0.365078],[],0,"CAN_COLLIDE"];
	_this = _item287;
	_objects pushback _this;
	_objectIDs pushback 287;
	_this setPosWorld [6996.03,2413.52,47.3172];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item288 = objNull;
if (_layerRoot) then {
	_item288 = createVehicle ["Land_Bare_boulder_02_F",[6995.86,2413.66,0],[],0,"CAN_COLLIDE"];
	_this = _item288;
	_objects pushback _this;
	_objectIDs pushback 288;
	_this setPosWorld [6995.86,2413.66,43.5364];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item289 = objNull;
if (_layerRoot) then {
	_item289 = createVehicle ["Land_MRP_O2_Kdo",[6996.63,2412.42,0.000694275],[],0,"CAN_COLLIDE"];
	_this = _item289;
	_objects pushback _this;
	_objectIDs pushback 289;
	_this setPosWorld [6996.63,2412.42,43.6735];
	_this setVectorDirAndUp [[0.853829,0.520554,0],[0,0,1]];
};

private _item290 = objNull;
if (_layerRoot) then {
	_item290 = createVehicle ["Land_MRP_O2_Gros_Kdo",[6995.36,2412.21,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item290;
	_objects pushback _this;
	_objectIDs pushback 290;
	_this setPosWorld [6995.36,2412.21,43.8829];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item291 = objNull;
if (_layerRoot) then {
	_item291 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6994.86,2412.41,0],[],0,"CAN_COLLIDE"];
	_this = _item291;
	_objects pushback _this;
	_objectIDs pushback 291;
	_this setPosWorld [6994.86,2412.41,43.6728];
	_this setVectorDirAndUp [[0.938456,0.345399,0],[0,0,1]];
};

private _item292 = objNull;
if (_layerRoot) then {
	_item292 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6995.81,2411.98,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item292;
	_objects pushback _this;
	_objectIDs pushback 292;
	_this setPosWorld [6995.81,2411.98,43.6745];
	_this setVectorDirAndUp [[0.679332,-0.733831,0],[0,0,1]];
};

private _item293 = objNull;
if (_layerRoot) then {
	_item293 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6996.78,2412.83,0.000694275],[],0,"CAN_COLLIDE"];
	_this = _item293;
	_objects pushback _this;
	_objectIDs pushback 293;
	_this setPosWorld [6996.78,2412.83,43.6735];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item294 = objNull;
if (_layerRoot) then {
	_item294 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[6997.35,2415.04,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item294;
	_objects pushback _this;
	_objectIDs pushback 294;
	_this setPosWorld [6997.35,2415.04,43.8829];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item295 = objNull;
if (_layerRoot) then {
	_item295 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6997.74,2414.58,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item295;
	_objects pushback _this;
	_objectIDs pushback 295;
	_this setPosWorld [6997.74,2414.58,43.6745];
	_this setVectorDirAndUp [[-0.944282,-0.329139,0],[0,0,1]];
};

private _item296 = objNull;
if (_layerRoot) then {
	_item296 = createVehicle ["Land_MRP_O2_Kdo",[6998,2414.2,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item296;
	_objects pushback _this;
	_objectIDs pushback 296;
	_this setPosWorld [6998,2414.2,43.6745];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item297 = objNull;
if (_layerRoot) then {
	_item297 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6997.96,2414.96,0.00169373],[],0,"CAN_COLLIDE"];
	_this = _item297;
	_objects pushback _this;
	_objectIDs pushback 297;
	_this setPosWorld [6997.96,2414.96,43.6745];
	_this setVectorDirAndUp [[-0.740735,-0.671797,0],[0,0,1]];
};

private _item298 = objNull;
if (_layerRoot) then {
	_item298 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6995.55,2414.54,0],[],0,"CAN_COLLIDE"];
	_this = _item298;
	_objects pushback _this;
	_objectIDs pushback 298;
	_this setPosWorld [6995.55,2414.54,43.6728];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item299 = objNull;
if (_layerRoot) then {
	_item299 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6995.21,2414.2,0],[],0,"CAN_COLLIDE"];
	_this = _item299;
	_objects pushback _this;
	_objectIDs pushback 299;
	_this setPosWorld [6995.21,2414.2,43.6728];
	_this setVectorDirAndUp [[-0.92443,-0.381352,0],[0,0,1]];
};

private _item300 = objNull;
if (_layerRoot) then {
	_item300 = createVehicle ["Land_O2_Sapin_Noel_anim",[5277.08,8575.06,0.414565],[],0,"CAN_COLLIDE"];
	_this = _item300;
	_objects pushback _this;
	_objectIDs pushback 300;
	_this setPosWorld [5277.08,8575.06,18.6267];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item301 = objNull;
if (_layerRoot) then {
	_item301 = createVehicle ["Land_Bare_boulder_02_F",[5276.91,8575.2,0.0490685],[],0,"CAN_COLLIDE"];
	_this = _item301;
	_objects pushback _this;
	_objectIDs pushback 301;
	_this setPosWorld [5276.91,8575.2,14.8455];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item302 = objNull;
if (_layerRoot) then {
	_item302 = createVehicle ["Land_MRP_O2_Kdo",[5277.68,8573.96,0.0497627],[],0,"CAN_COLLIDE"];
	_this = _item302;
	_objects pushback _this;
	_objectIDs pushback 302;
	_this setPosWorld [5277.68,8573.96,14.9825];
	_this setVectorDirAndUp [[0.853829,0.520554,0],[0,0,1]];
};

private _item303 = objNull;
if (_layerRoot) then {
	_item303 = createVehicle ["Land_MRP_O2_Gros_Kdo",[5276.41,8573.75,0.0507622],[],0,"CAN_COLLIDE"];
	_this = _item303;
	_objects pushback _this;
	_objectIDs pushback 303;
	_this setPosWorld [5276.41,8573.75,15.1919];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item304 = objNull;
if (_layerRoot) then {
	_item304 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5275.91,8573.95,0.0490685],[],0,"CAN_COLLIDE"];
	_this = _item304;
	_objects pushback _this;
	_objectIDs pushback 304;
	_this setPosWorld [5275.91,8573.95,14.9818];
	_this setVectorDirAndUp [[0.938456,0.345399,0],[0,0,1]];
};

private _item305 = objNull;
if (_layerRoot) then {
	_item305 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5276.86,8573.52,0.0507622],[],0,"CAN_COLLIDE"];
	_this = _item305;
	_objects pushback _this;
	_objectIDs pushback 305;
	_this setPosWorld [5276.86,8573.52,14.9835];
	_this setVectorDirAndUp [[0.679332,-0.733831,0],[0,0,1]];
};

private _item306 = objNull;
if (_layerRoot) then {
	_item306 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5277.83,8574.37,0.0497627],[],0,"CAN_COLLIDE"];
	_this = _item306;
	_objects pushback _this;
	_objectIDs pushback 306;
	_this setPosWorld [5277.83,8574.37,14.9825];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item307 = objNull;
if (_layerRoot) then {
	_item307 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[5278.4,8576.58,0.0406618],[],0,"CAN_COLLIDE"];
	_this = _item307;
	_objects pushback _this;
	_objectIDs pushback 307;
	_this setPosWorld [5278.4,8576.58,15.1818];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item308 = objNull;
if (_layerRoot) then {
	_item308 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5278.79,8576.12,0.0406618],[],0,"CAN_COLLIDE"];
	_this = _item308;
	_objects pushback _this;
	_objectIDs pushback 308;
	_this setPosWorld [5278.79,8576.12,14.9734];
	_this setVectorDirAndUp [[-0.944282,-0.329139,0],[0,0,1]];
};

private _item309 = objNull;
if (_layerRoot) then {
	_item309 = createVehicle ["Land_MRP_O2_Kdo",[5279.05,8575.74,0.0406618],[],0,"CAN_COLLIDE"];
	_this = _item309;
	_objects pushback _this;
	_objectIDs pushback 309;
	_this setPosWorld [5279.05,8575.74,14.9734];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item310 = objNull;
if (_layerRoot) then {
	_item310 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5279.01,8576.5,0.0406618],[],0,"CAN_COLLIDE"];
	_this = _item310;
	_objects pushback _this;
	_objectIDs pushback 310;
	_this setPosWorld [5279.01,8576.5,14.9734];
	_this setVectorDirAndUp [[-0.740735,-0.671797,0],[0,0,1]];
};

private _item311 = objNull;
if (_layerRoot) then {
	_item311 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5276.6,8576.08,0.0389681],[],0,"CAN_COLLIDE"];
	_this = _item311;
	_objects pushback _this;
	_objectIDs pushback 311;
	_this setPosWorld [5276.6,8576.08,14.9717];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item312 = objNull;
if (_layerRoot) then {
	_item312 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5276.26,8575.74,0.0490685],[],0,"CAN_COLLIDE"];
	_this = _item312;
	_objects pushback _this;
	_objectIDs pushback 312;
	_this setPosWorld [5276.26,8575.74,14.9818];
	_this setVectorDirAndUp [[-0.92443,-0.381352,0],[0,0,1]];
};

private _item313 = objNull;
if (_layerRoot) then {
	_item313 = createVehicle ["Land_O2_Sapin_Noel_anim",[3869.19,9175.46,0.331254],[],0,"CAN_COLLIDE"];
	_this = _item313;
	_objects pushback _this;
	_objectIDs pushback 313;
	_this setPosWorld [3869.19,9175.46,19.1845];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item314 = objNull;
if (_layerRoot) then {
	_item314 = createVehicle ["Land_Bare_boulder_02_F",[3869.02,9175.6,0],[],0,"CAN_COLLIDE"];
	_this = _item314;
	_objects pushback _this;
	_objectIDs pushback 314;
	_this setPosWorld [3869.02,9175.6,15.4372];
	_this setVectorDirAndUp [[0.323434,-0.946226,-0.00685078],[-0.0109997,-0.0109991,0.999879]];
};

private _item315 = objNull;
if (_layerRoot) then {
	_item315 = createVehicle ["Land_MRP_O2_Kdo",[3869.79,9174.35,0],[],0,"CAN_COLLIDE"];
	_this = _item315;
	_objects pushback _this;
	_objectIDs pushback 315;
	_this setPosWorld [3869.79,9174.35,15.5683];
	_this setVectorDirAndUp [[0.853829,0.520554,0],[0,0,1]];
};

private _item316 = objNull;
if (_layerRoot) then {
	_item316 = createVehicle ["Land_MRP_O2_Gros_Kdo",[3868.52,9174.14,0],[],0,"CAN_COLLIDE"];
	_this = _item316;
	_objects pushback _this;
	_objectIDs pushback 316;
	_this setPosWorld [3868.52,9174.14,15.7604];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item317 = objNull;
if (_layerRoot) then {
	_item317 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[3868.01,9174.35,0],[],0,"CAN_COLLIDE"];
	_this = _item317;
	_objects pushback _this;
	_objectIDs pushback 317;
	_this setPosWorld [3868.01,9174.35,15.5487];
	_this setVectorDirAndUp [[0.938456,0.345399,0],[0,0,1]];
};

private _item318 = objNull;
if (_layerRoot) then {
	_item318 = createVehicle ["Land_MRP_O2_Kdo_Vert",[3868.97,9173.92,0],[],0,"CAN_COLLIDE"];
	_this = _item318;
	_objects pushback _this;
	_objectIDs pushback 318;
	_this setPosWorld [3868.97,9173.92,15.5545];
	_this setVectorDirAndUp [[0.679332,-0.733831,0],[0,0,1]];
};

private _item319 = objNull;
if (_layerRoot) then {
	_item319 = createVehicle ["Land_MRP_O2_Kdo_Rose",[3869.93,9174.77,0],[],0,"CAN_COLLIDE"];
	_this = _item319;
	_objects pushback _this;
	_objectIDs pushback 319;
	_this setPosWorld [3869.93,9174.77,15.5745];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item320 = objNull;
if (_layerRoot) then {
	_item320 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[3870.51,9176.98,0],[],0,"CAN_COLLIDE"];
	_this = _item320;
	_objects pushback _this;
	_objectIDs pushback 320;
	_this setPosWorld [3870.51,9176.98,15.8079];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item321 = objNull;
if (_layerRoot) then {
	_item321 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[3870.9,9176.52,0],[],0,"CAN_COLLIDE"];
	_this = _item321;
	_objects pushback _this;
	_objectIDs pushback 321;
	_this setPosWorld [3870.9,9176.52,15.5945];
	_this setVectorDirAndUp [[-0.944282,-0.329139,0],[0,0,1]];
};

private _item322 = objNull;
if (_layerRoot) then {
	_item322 = createVehicle ["Land_MRP_O2_Kdo",[3871.16,9176.13,0],[],0,"CAN_COLLIDE"];
	_this = _item322;
	_objects pushback _this;
	_objectIDs pushback 322;
	_this setPosWorld [3871.16,9176.13,15.5902];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item323 = objNull;
if (_layerRoot) then {
	_item323 = createVehicle ["Land_MRP_O2_Kdo_Rose",[3871.11,9176.9,0],[],0,"CAN_COLLIDE"];
	_this = _item323;
	_objects pushback _this;
	_objectIDs pushback 323;
	_this setPosWorld [3871.11,9176.9,15.5987];
	_this setVectorDirAndUp [[-0.740735,-0.671797,0],[0,0,1]];
};

private _item324 = objNull;
if (_layerRoot) then {
	_item324 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[3868.7,9176.48,0],[],0,"CAN_COLLIDE"];
	_this = _item324;
	_objects pushback _this;
	_objectIDs pushback 324;
	_this setPosWorld [3868.7,9176.48,15.5798];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item325 = objNull;
if (_layerRoot) then {
	_item325 = createVehicle ["Land_MRP_O2_Kdo_Vert",[3868.36,9176.13,0],[],0,"CAN_COLLIDE"];
	_this = _item325;
	_objects pushback _this;
	_objectIDs pushback 325;
	_this setPosWorld [3868.36,9176.13,15.5722];
	_this setVectorDirAndUp [[-0.92443,-0.381352,0],[0,0,1]];
};

private _item326 = objNull;
if (_layerRoot) then {
	_item326 = createVehicle ["Land_O2_Sapin_Noel_anim",[6210.46,7521.89,0.326198],[],0,"CAN_COLLIDE"];
	_this = _item326;
	_objects pushback _this;
	_objectIDs pushback 326;
	_this setPosWorld [6210.46,7521.89,18.2983];
	_this setVectorDirAndUp [[-0.902894,0.429864,0],[0,0,1]];
};

private _item327 = objNull;
if (_layerRoot) then {
	_item327 = createVehicle ["Land_Bare_boulder_02_F",[6210.68,7521.91,0],[],0,"CAN_COLLIDE"];
	_this = _item327;
	_objects pushback _this;
	_objectIDs pushback 327;
	_this setPosWorld [6210.68,7521.91,14.5564];
	_this setVectorDirAndUp [[-0.902894,0.429864,0],[0,0,1]];
};

private _item328 = objNull;
if (_layerRoot) then {
	_item328 = createVehicle ["Land_MRP_O2_Kdo",[6209.25,7522.23,0],[],0,"CAN_COLLIDE"];
	_this = _item328;
	_objects pushback _this;
	_objectIDs pushback 328;
	_this setPosWorld [6209.25,7522.23,14.6928];
	_this setVectorDirAndUp [[-0.224295,-0.974521,0],[0,0,1]];
};

private _item329 = objNull;
if (_layerRoot) then {
	_item329 = createVehicle ["Land_MRP_O2_Gros_Kdo",[6209.99,7523.29,0],[],0,"CAN_COLLIDE"];
	_this = _item329;
	_objects pushback _this;
	_objectIDs pushback 329;
	_this setPosWorld [6209.99,7523.29,14.9012];
	_this setVectorDirAndUp [[-0.902894,0.429864,0],[0,0,1]];
};

private _item330 = objNull;
if (_layerRoot) then {
	_item330 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6210.49,7523.51,0],[],0,"CAN_COLLIDE"];
	_this = _item330;
	_objects pushback _this;
	_objectIDs pushback 330;
	_this setPosWorld [6210.49,7523.51,14.6928];
	_this setVectorDirAndUp [[-0.408724,-0.912658,0],[0,0,1]];
};

private _item331 = objNull;
if (_layerRoot) then {
	_item331 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6209.51,7523.12,0],[],0,"CAN_COLLIDE"];
	_this = _item331;
	_objects pushback _this;
	_objectIDs pushback 331;
	_this setPosWorld [6209.51,7523.12,14.6928];
	_this setVectorDirAndUp [[-0.999639,0.0268637,0],[0,0,1]];
};

private _item332 = objNull;
if (_layerRoot) then {
	_item332 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6209.45,7521.84,0],[],0,"CAN_COLLIDE"];
	_this = _item332;
	_objects pushback _this;
	_objectIDs pushback 332;
	_this setPosWorld [6209.45,7521.84,14.6928];
	_this setVectorDirAndUp [[-0.902894,0.429864,0],[0,0,1]];
};

private _item333 = objNull;
if (_layerRoot) then {
	_item333 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[6210.63,7519.88,0],[],0,"CAN_COLLIDE"];
	_this = _item333;
	_objects pushback _this;
	_objectIDs pushback 333;
	_this setPosWorld [6210.63,7519.88,14.9012];
	_this setVectorDirAndUp [[-0.902894,0.429864,0],[0,0,1]];
};

private _item334 = objNull;
if (_layerRoot) then {
	_item334 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6210.02,7519.93,0],[],0,"CAN_COLLIDE"];
	_this = _item334;
	_objects pushback _this;
	_objectIDs pushback 334;
	_this setPosWorld [6210.02,7519.93,14.6928];
	_this setVectorDirAndUp [[0.424425,0.905463,0],[0,0,1]];
};

private _item335 = objNull;
if (_layerRoot) then {
	_item335 = createVehicle ["Land_MRP_O2_Kdo",[6209.56,7520.01,0],[],0,"CAN_COLLIDE"];
	_this = _item335;
	_objects pushback _this;
	_objectIDs pushback 335;
	_this setPosWorld [6209.56,7520.01,14.6928];
	_this setVectorDirAndUp [[-0.902894,0.429864,0],[0,0,1]];
};

private _item336 = objNull;
if (_layerRoot) then {
	_item336 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6210.15,7519.51,0],[],0,"CAN_COLLIDE"];
	_this = _item336;
	_objects pushback _this;
	_objectIDs pushback 336;
	_this setPosWorld [6210.15,7519.51,14.6928];
	_this setVectorDirAndUp [[0.0370778,0.999312,0],[0,0,1]];
};

private _item337 = objNull;
if (_layerRoot) then {
	_item337 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6211.53,7521.52,0],[],0,"CAN_COLLIDE"];
	_this = _item337;
	_objects pushback _this;
	_objectIDs pushback 337;
	_this setPosWorld [6211.53,7521.52,14.6928];
	_this setVectorDirAndUp [[-0.902894,0.429864,0],[0,0,1]];
};

private _item338 = objNull;
if (_layerRoot) then {
	_item338 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6211.52,7522.01,0],[],0,"CAN_COLLIDE"];
	_this = _item338;
	_objects pushback _this;
	_objectIDs pushback 338;
	_this setPosWorld [6211.52,7522.01,14.6928];
	_this setVectorDirAndUp [[0.373204,0.927749,0],[0,0,1]];
};

private _item339 = objNull;
if (_layerRoot) then {
	_item339 = createVehicle ["Land_O2_Sapin_Noel_anim",[6224.99,7596.51,0.4362],[],0,"CAN_COLLIDE"];
	_this = _item339;
	_objects pushback _this;
	_objectIDs pushback 339;
	_this setPosWorld [6224.99,7596.51,18.4083];
	_this setVectorDirAndUp [[-0.98949,-0.144604,0],[0,0,1]];
};

private _item340 = objNull;
if (_layerRoot) then {
	_item340 = createVehicle ["Land_Bare_boulder_02_F",[6225.16,7596.65,0.110001],[],0,"CAN_COLLIDE"];
	_this = _item340;
	_objects pushback _this;
	_objectIDs pushback 340;
	_this setPosWorld [6225.16,7596.65,14.6664];
	_this setVectorDirAndUp [[-0.98949,-0.144604,0],[0,0,1]];
};

private _item341 = objNull;
if (_layerRoot) then {
	_item341 = createVehicle ["Land_MRP_O2_Kdo",[6223.8,7596.12,0.0613022],[],0,"CAN_COLLIDE"];
	_this = _item341;
	_objects pushback _this;
	_objectIDs pushback 341;
	_this setPosWorld [6223.8,7596.12,14.7541];
	_this setVectorDirAndUp [[0.355301,-0.934752,0],[0,0,1]];
};

private _item342 = objNull;
if (_layerRoot) then {
	_item342 = createVehicle ["Land_MRP_O2_Gros_Kdo",[6223.82,7597.41,0.0623016],[],0,"CAN_COLLIDE"];
	_this = _item342;
	_objects pushback _this;
	_objectIDs pushback 342;
	_this setPosWorld [6223.82,7597.41,14.9635];
	_this setVectorDirAndUp [[-0.98949,-0.144604,0],[0,0,1]];
};

private _item343 = objNull;
if (_layerRoot) then {
	_item343 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6224.12,7597.87,0],[],0,"CAN_COLLIDE"];
	_this = _item343;
	_objects pushback _this;
	_objectIDs pushback 343;
	_this setPosWorld [6224.12,7597.87,14.6928];
	_this setVectorDirAndUp [[0.167605,-0.985854,0],[0,0,1]];
};

private _item344 = objNull;
if (_layerRoot) then {
	_item344 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6223.52,7597.01,0.0623016],[],0,"CAN_COLLIDE"];
	_this = _item344;
	_objects pushback _this;
	_objectIDs pushback 344;
	_this setPosWorld [6223.52,7597.01,14.7551];
	_this setVectorDirAndUp [[-0.845877,-0.533377,0],[0,0,1]];
};

private _item345 = objNull;
if (_layerRoot) then {
	_item345 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6224.18,7595.9,0.0613022],[],0,"CAN_COLLIDE"];
	_this = _item345;
	_objects pushback _this;
	_objectIDs pushback 345;
	_this setPosWorld [6224.18,7595.9,14.7541];
	_this setVectorDirAndUp [[-0.98949,-0.144604,0],[0,0,1]];
};

private _item346 = objNull;
if (_layerRoot) then {
	_item346 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[6226.25,7594.93,0.0623016],[],0,"CAN_COLLIDE"];
	_this = _item346;
	_objects pushback _this;
	_objectIDs pushback 346;
	_this setPosWorld [6226.25,7594.93,14.9635];
	_this setVectorDirAndUp [[-0.98949,-0.144604,0],[0,0,1]];
};

private _item347 = objNull;
if (_layerRoot) then {
	_item347 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6225.72,7594.63,0.0623016],[],0,"CAN_COLLIDE"];
	_this = _item347;
	_objects pushback _this;
	_objectIDs pushback 347;
	_this setPosWorld [6225.72,7594.63,14.7551];
	_this setVectorDirAndUp [[-0.150553,0.988602,0],[0,0,1]];
};

private _item348 = objNull;
if (_layerRoot) then {
	_item348 = createVehicle ["Land_MRP_O2_Kdo",[6225.29,7594.45,0.0623016],[],0,"CAN_COLLIDE"];
	_this = _item348;
	_objects pushback _this;
	_objectIDs pushback 348;
	_this setPosWorld [6225.29,7594.45,14.7551];
	_this setVectorDirAndUp [[-0.98949,-0.144604,0],[0,0,1]];
};

private _item349 = objNull;
if (_layerRoot) then {
	_item349 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6226.06,7594.35,0.0623016],[],0,"CAN_COLLIDE"];
	_this = _item349;
	_objects pushback _this;
	_objectIDs pushback 349;
	_this setPosWorld [6226.06,7594.35,14.7551];
	_this setVectorDirAndUp [[-0.524705,0.851284,0],[0,0,1]];
};

private _item350 = objNull;
if (_layerRoot) then {
	_item350 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6226.08,7596.8,0.0999002],[],0,"CAN_COLLIDE"];
	_this = _item350;
	_objects pushback _this;
	_objectIDs pushback 350;
	_this setPosWorld [6226.08,7596.8,14.7927];
	_this setVectorDirAndUp [[-0.98949,-0.144604,0],[0,0,1]];
};

private _item351 = objNull;
if (_layerRoot) then {
	_item351 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6225.81,7597.2,0.0707083],[],0,"CAN_COLLIDE"];
	_this = _item351;
	_objects pushback _this;
	_objectIDs pushback 351;
	_this setPosWorld [6225.81,7597.2,14.7635];
	_this setVectorDirAndUp [[-0.20552,0.978653,0],[0,0,1]];
};

private _item352 = objNull;
if (_layerRoot) then {
	_item352 = createVehicle ["Land_O2_Sapin_Noel_anim",[6162.69,7606.34,0.438085],[],0,"CAN_COLLIDE"];
	_this = _item352;
	_objects pushback _this;
	_objectIDs pushback 352;
	_this setPosWorld [6162.69,7606.34,18.4102];
	_this setVectorDirAndUp [[-0.905143,-0.425107,0],[0,0,1]];
};

private _item353 = objNull;
if (_layerRoot) then {
	_item353 = createVehicle ["Land_Bare_boulder_02_F",[6162.81,7606.53,0.111881],[],0,"CAN_COLLIDE"];
	_this = _item353;
	_objects pushback _this;
	_objectIDs pushback 353;
	_this setPosWorld [6162.81,7606.53,14.6683];
	_this setVectorDirAndUp [[-0.905143,-0.425107,0],[0,0,1]];
};

private _item354 = objNull;
if (_layerRoot) then {
	_item354 = createVehicle ["Land_MRP_O2_Kdo",[6161.66,7605.63,0],[],0,"CAN_COLLIDE"];
	_this = _item354;
	_objects pushback _this;
	_objectIDs pushback 354;
	_this setPosWorld [6161.66,7605.63,14.6928];
	_this setVectorDirAndUp [[0.610905,-0.791704,0],[0,0,1]];
};

private _item355 = objNull;
if (_layerRoot) then {
	_item355 = createVehicle ["Land_MRP_O2_Gros_Kdo",[6161.31,7606.87,0],[],0,"CAN_COLLIDE"];
	_this = _item355;
	_objects pushback _this;
	_objectIDs pushback 355;
	_this setPosWorld [6161.31,7606.87,14.9012];
	_this setVectorDirAndUp [[-0.905143,-0.425107,0],[0,0,1]];
};

private _item356 = objNull;
if (_layerRoot) then {
	_item356 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6161.46,7607.39,0],[],0,"CAN_COLLIDE"];
	_this = _item356;
	_objects pushback _this;
	_objectIDs pushback 356;
	_this setPosWorld [6161.46,7607.39,14.6928];
	_this setVectorDirAndUp [[0.446068,-0.894999,0],[0,0,1]];
};

private _item357 = objNull;
if (_layerRoot) then {
	_item357 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6161.13,7606.39,0],[],0,"CAN_COLLIDE"];
	_this = _item357;
	_objects pushback _this;
	_objectIDs pushback 357;
	_this setPosWorld [6161.13,7606.39,14.6928];
	_this setVectorDirAndUp [[-0.655044,-0.755591,0],[0,0,1]];
};

private _item358 = objNull;
if (_layerRoot) then {
	_item358 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6162.08,7605.53,0.0631828],[],0,"CAN_COLLIDE"];
	_this = _item358;
	_objects pushback _this;
	_objectIDs pushback 358;
	_this setPosWorld [6162.08,7605.53,14.756];
	_this setVectorDirAndUp [[-0.905143,-0.425107,0],[0,0,1]];
};

private _item359 = objNull;
if (_layerRoot) then {
	_item359 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[6164.34,7605.2,0.0641823],[],0,"CAN_COLLIDE"];
	_this = _item359;
	_objects pushback _this;
	_objectIDs pushback 359;
	_this setPosWorld [6164.34,7605.2,14.9654];
	_this setVectorDirAndUp [[-0.905143,-0.425107,0],[0,0,1]];
};

private _item360 = objNull;
if (_layerRoot) then {
	_item360 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6163.93,7604.76,0.0641823],[],0,"CAN_COLLIDE"];
	_this = _item360;
	_objects pushback _this;
	_objectIDs pushback 360;
	_this setPosWorld [6163.93,7604.76,14.757];
	_this setVectorDirAndUp [[-0.430544,0.90257,0],[0,0,1]];
};

private _item361 = objNull;
if (_layerRoot) then {
	_item361 = createVehicle ["Land_MRP_O2_Kdo",[6163.57,7604.46,0.0641823],[],0,"CAN_COLLIDE"];
	_this = _item361;
	_objects pushback _this;
	_objectIDs pushback 361;
	_this setPosWorld [6163.57,7604.46,14.757];
	_this setVectorDirAndUp [[-0.905143,-0.425107,0],[0,0,1]];
};

private _item362 = objNull;
if (_layerRoot) then {
	_item362 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6164.33,7604.59,0.0641823],[],0,"CAN_COLLIDE"];
	_this = _item362;
	_objects pushback _this;
	_objectIDs pushback 362;
	_this setPosWorld [6164.33,7604.59,14.757];
	_this setVectorDirAndUp [[-0.748857,0.662731,0],[0,0,1]];
};

private _item363 = objNull;
if (_layerRoot) then {
	_item363 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6163.65,7606.94,0.101781],[],0,"CAN_COLLIDE"];
	_this = _item363;
	_objects pushback _this;
	_objectIDs pushback 363;
	_this setPosWorld [6163.65,7606.94,14.7946];
	_this setVectorDirAndUp [[-0.905143,-0.425107,0],[0,0,1]];
};

private _item364 = objNull;
if (_layerRoot) then {
	_item364 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6163.27,7607.24,0.0725889],[],0,"CAN_COLLIDE"];
	_this = _item364;
	_objects pushback _this;
	_objectIDs pushback 364;
	_this setPosWorld [6163.27,7607.24,14.7654];
	_this setVectorDirAndUp [[-0.48027,0.877121,0],[0,0,1]];
};

private _item365 = objNull;
if (_layerRoot) then {
	_item365 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[6165.65,7527.2,0],[],0,"CAN_COLLIDE"];
	_this = _item365;
	_objects pushback _this;
	_objectIDs pushback 365;
	_this setPosWorld [6165.65,7527.2,17.824];
	_this setVectorDirAndUp [[0.930142,-0.367199,0],[0,0,1]];
};

private _item369 = objNull;
if (_layerRoot) then {
	_item369 = createVehicle ["Land_O2_Sapin_Noel_anim",[7508.15,7254.25,0.326198],[],0,"CAN_COLLIDE"];
	_this = _item369;
	_objects pushback _this;
	_objectIDs pushback 369;
	_this setPosWorld [7508.15,7254.25,17.9383];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item370 = objNull;
if (_layerRoot) then {
	_item370 = createVehicle ["Land_Bare_boulder_02_F",[7507.98,7254.39,0],[],0,"CAN_COLLIDE"];
	_this = _item370;
	_objects pushback _this;
	_objectIDs pushback 370;
	_this setPosWorld [7507.98,7254.39,14.1964];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item371 = objNull;
if (_layerRoot) then {
	_item371 = createVehicle ["Land_MRP_O2_Kdo",[7508.75,7253.15,0],[],0,"CAN_COLLIDE"];
	_this = _item371;
	_objects pushback _this;
	_objectIDs pushback 371;
	_this setPosWorld [7508.75,7253.15,14.3328];
	_this setVectorDirAndUp [[0.853829,0.520554,0],[0,0,1]];
};

private _item372 = objNull;
if (_layerRoot) then {
	_item372 = createVehicle ["Land_MRP_O2_Gros_Kdo",[7507.48,7252.94,0],[],0,"CAN_COLLIDE"];
	_this = _item372;
	_objects pushback _this;
	_objectIDs pushback 372;
	_this setPosWorld [7507.48,7252.94,14.5412];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item373 = objNull;
if (_layerRoot) then {
	_item373 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[7506.97,7253.14,0],[],0,"CAN_COLLIDE"];
	_this = _item373;
	_objects pushback _this;
	_objectIDs pushback 373;
	_this setPosWorld [7506.97,7253.14,14.3328];
	_this setVectorDirAndUp [[0.938456,0.345399,0],[0,0,1]];
};

private _item374 = objNull;
if (_layerRoot) then {
	_item374 = createVehicle ["Land_MRP_O2_Kdo_Vert",[7507.93,7252.71,0],[],0,"CAN_COLLIDE"];
	_this = _item374;
	_objects pushback _this;
	_objectIDs pushback 374;
	_this setPosWorld [7507.93,7252.71,14.3328];
	_this setVectorDirAndUp [[0.679332,-0.733831,0],[0,0,1]];
};

private _item375 = objNull;
if (_layerRoot) then {
	_item375 = createVehicle ["Land_MRP_O2_Kdo_Rose",[7508.89,7253.56,0],[],0,"CAN_COLLIDE"];
	_this = _item375;
	_objects pushback _this;
	_objectIDs pushback 375;
	_this setPosWorld [7508.89,7253.56,14.3328];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item376 = objNull;
if (_layerRoot) then {
	_item376 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[7509.47,7255.77,0],[],0,"CAN_COLLIDE"];
	_this = _item376;
	_objects pushback _this;
	_objectIDs pushback 376;
	_this setPosWorld [7509.47,7255.77,14.5412];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item377 = objNull;
if (_layerRoot) then {
	_item377 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[7509.86,7255.31,0],[],0,"CAN_COLLIDE"];
	_this = _item377;
	_objects pushback _this;
	_objectIDs pushback 377;
	_this setPosWorld [7509.86,7255.31,14.3328];
	_this setVectorDirAndUp [[-0.944282,-0.329139,0],[0,0,1]];
};

private _item378 = objNull;
if (_layerRoot) then {
	_item378 = createVehicle ["Land_MRP_O2_Kdo",[7510.12,7254.93,0],[],0,"CAN_COLLIDE"];
	_this = _item378;
	_objects pushback _this;
	_objectIDs pushback 378;
	_this setPosWorld [7510.12,7254.93,14.3328];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item379 = objNull;
if (_layerRoot) then {
	_item379 = createVehicle ["Land_MRP_O2_Kdo_Rose",[7510.07,7255.69,0],[],0,"CAN_COLLIDE"];
	_this = _item379;
	_objects pushback _this;
	_objectIDs pushback 379;
	_this setPosWorld [7510.07,7255.69,14.3328];
	_this setVectorDirAndUp [[-0.740735,-0.671797,0],[0,0,1]];
};

private _item380 = objNull;
if (_layerRoot) then {
	_item380 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[7507.66,7255.27,0],[],0,"CAN_COLLIDE"];
	_this = _item380;
	_objects pushback _this;
	_objectIDs pushback 380;
	_this setPosWorld [7507.66,7255.27,14.3328];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item381 = objNull;
if (_layerRoot) then {
	_item381 = createVehicle ["Land_MRP_O2_Kdo_Vert",[7507.32,7254.93,0],[],0,"CAN_COLLIDE"];
	_this = _item381;
	_objects pushback _this;
	_objectIDs pushback 381;
	_this setPosWorld [7507.32,7254.93,14.3328];
	_this setVectorDirAndUp [[-0.92443,-0.381352,0],[0,0,1]];
};

private _item382 = objNull;
if (_layerRoot) then {
	_item382 = createVehicle ["Land_O2_Sapin_Noel_anim",[5004.94,6781.23,0.326198],[],0,"CAN_COLLIDE"];
	_this = _item382;
	_objects pushback _this;
	_objectIDs pushback 382;
	_this setPosWorld [5004.94,6781.23,18.4383];
	_this setVectorDirAndUp [[0.229242,-0.97337,0],[0,0,1]];
};

private _item383 = objNull;
if (_layerRoot) then {
	_item383 = createVehicle ["Land_Bare_boulder_02_F",[5004.79,6781.38,0],[],0,"CAN_COLLIDE"];
	_this = _item383;
	_objects pushback _this;
	_objectIDs pushback 383;
	_this setPosWorld [5004.79,6781.38,14.6964];
	_this setVectorDirAndUp [[0.229242,-0.97337,0],[0,0,1]];
};

private _item384 = objNull;
if (_layerRoot) then {
	_item384 = createVehicle ["Land_MRP_O2_Kdo",[5005.43,6780.07,0],[],0,"CAN_COLLIDE"];
	_this = _item384;
	_objects pushback _this;
	_objectIDs pushback 384;
	_this setPosWorld [5005.43,6780.07,14.8328];
	_this setVectorDirAndUp [[0.900699,0.434444,0],[0,0,1]];
};

private _item385 = objNull;
if (_layerRoot) then {
	_item385 = createVehicle ["Land_MRP_O2_Gros_Kdo",[5004.15,6779.98,0],[],0,"CAN_COLLIDE"];
	_this = _item385;
	_objects pushback _this;
	_objectIDs pushback 385;
	_this setPosWorld [5004.15,6779.98,15.0412];
	_this setVectorDirAndUp [[0.229242,-0.97337,0],[0,0,1]];
};

private _item386 = objNull;
if (_layerRoot) then {
	_item386 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5003.66,6780.24,0],[],0,"CAN_COLLIDE"];
	_this = _item386;
	_objects pushback _this;
	_objectIDs pushback 386;
	_this setPosWorld [5003.66,6780.24,14.8328];
	_this setVectorDirAndUp [[0.967768,0.251844,0],[0,0,1]];
};

private _item387 = objNull;
if (_layerRoot) then {
	_item387 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5004.57,6779.72,0],[],0,"CAN_COLLIDE"];
	_this = _item387;
	_objects pushback _this;
	_objectIDs pushback 387;
	_this setPosWorld [5004.57,6779.72,14.8328];
	_this setVectorDirAndUp [[0.60421,-0.796825,0],[0,0,1]];
};

private _item388 = objNull;
if (_layerRoot) then {
	_item388 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5005.62,6780.47,0],[],0,"CAN_COLLIDE"];
	_this = _item388;
	_objects pushback _this;
	_objectIDs pushback 388;
	_this setPosWorld [5005.62,6780.47,14.8328];
	_this setVectorDirAndUp [[0.229242,-0.97337,0],[0,0,1]];
};

private _item389 = objNull;
if (_layerRoot) then {
	_item389 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[5006.4,6782.61,0],[],0,"CAN_COLLIDE"];
	_this = _item389;
	_objects pushback _this;
	_objectIDs pushback 389;
	_this setPosWorld [5006.4,6782.61,15.0412];
	_this setVectorDirAndUp [[0.229242,-0.97337,0],[0,0,1]];
};

private _item390 = objNull;
if (_layerRoot) then {
	_item390 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5006.75,6782.11,0],[],0,"CAN_COLLIDE"];
	_this = _item390;
	_objects pushback _this;
	_objectIDs pushback 390;
	_this setPosWorld [5006.75,6782.11,14.8328];
	_this setVectorDirAndUp [[-0.971973,-0.235092,0],[0,0,1]];
};

private _item391 = objNull;
if (_layerRoot) then {
	_item391 = createVehicle ["Land_MRP_O2_Kdo",[5006.97,6781.7,0],[],0,"CAN_COLLIDE"];
	_this = _item391;
	_objects pushback _this;
	_objectIDs pushback 391;
	_this setPosWorld [5006.97,6781.7,14.8328];
	_this setVectorDirAndUp [[0.229242,-0.97337,0],[0,0,1]];
};

private _item392 = objNull;
if (_layerRoot) then {
	_item392 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5007,6782.47,0],[],0,"CAN_COLLIDE"];
	_this = _item392;
	_objects pushback _this;
	_objectIDs pushback 392;
	_this setPosWorld [5007,6782.47,14.8328];
	_this setVectorDirAndUp [[-0.802958,-0.596035,0],[0,0,1]];
};

private _item393 = objNull;
if (_layerRoot) then {
	_item393 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5004.56,6782.29,0],[],0,"CAN_COLLIDE"];
	_this = _item393;
	_objects pushback _this;
	_objectIDs pushback 393;
	_this setPosWorld [5004.56,6782.29,14.8328];
	_this setVectorDirAndUp [[0.229242,-0.97337,0],[0,0,1]];
};

private _item394 = objNull;
if (_layerRoot) then {
	_item394 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5004.19,6781.98,0],[],0,"CAN_COLLIDE"];
	_this = _item394;
	_objects pushback _this;
	_objectIDs pushback 394;
	_this setPosWorld [5004.19,6781.98,14.8328];
	_this setVectorDirAndUp [[-0.95733,-0.288998,0],[0,0,1]];
};

private _item395 = objNull;
if (_layerRoot) then {
	_item395 = createVehicle ["Land_O2_Sapin_Noel_anim",[4653.3,7039.77,0.640964],[],0,"CAN_COLLIDE"];
	_this = _item395;
	_objects pushback _this;
	_objectIDs pushback 395;
	_this setPosWorld [4653.3,7039.77,18.7531];
	_this setVectorDirAndUp [[0.584463,0.81142,0],[0,0,1]];
};

private _item396 = objNull;
if (_layerRoot) then {
	_item396 = createVehicle ["Land_Bare_boulder_02_F",[4653.29,7039.55,0.314758],[],0,"CAN_COLLIDE"];
	_this = _item396;
	_objects pushback _this;
	_objectIDs pushback 396;
	_this setPosWorld [4653.29,7039.55,15.0112];
	_this setVectorDirAndUp [[0.584463,0.81142,0],[0,0,1]];
};

private _item397 = objNull;
if (_layerRoot) then {
	_item397 = createVehicle ["Land_MRP_O2_Kdo",[4653.86,7040.9,0.26606],[],0,"CAN_COLLIDE"];
	_this = _item397;
	_objects pushback _this;
	_objectIDs pushback 397;
	_this setPosWorld [4653.86,7040.9,15.0988];
	_this setVectorDirAndUp [[-0.91867,0.395026,0],[0,0,1]];
};

private _item398 = objNull;
if (_layerRoot) then {
	_item398 = createVehicle ["Land_MRP_O2_Gros_Kdo",[4654.77,7039.99,0.157059],[],0,"CAN_COLLIDE"];
	_this = _item398;
	_objects pushback _this;
	_objectIDs pushback 398;
	_this setPosWorld [4654.77,7039.99,15.1982];
	_this setVectorDirAndUp [[0.584463,0.81142,0],[0,0,1]];
};

private _item399 = objNull;
if (_layerRoot) then {
	_item399 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4654.89,7039.46,0.204758],[],0,"CAN_COLLIDE"];
	_this = _item399;
	_objects pushback _this;
	_objectIDs pushback 399;
	_this setPosWorld [4654.89,7039.46,15.0375];
	_this setVectorDirAndUp [[-0.824809,0.565411,0],[0,0,1]];
};

private _item400 = objNull;
if (_layerRoot) then {
	_item400 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4654.69,7040.48,0.157059],[],0,"CAN_COLLIDE"];
	_this = _item400;
	_objects pushback _this;
	_objectIDs pushback 400;
	_this setPosWorld [4654.69,7040.48,14.9898];
	_this setVectorDirAndUp [[0.205274,0.978705,0],[0,0,1]];
};

private _item401 = objNull;
if (_layerRoot) then {
	_item401 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4653.44,7040.78,0.26606],[],0,"CAN_COLLIDE"];
	_this = _item401;
	_objects pushback _this;
	_objectIDs pushback 401;
	_this setPosWorld [4653.44,7040.78,15.0988];
	_this setVectorDirAndUp [[0.584463,0.81142,0],[0,0,1]];
};

private _item402 = objNull;
if (_layerRoot) then {
	_item402 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[4651.3,7039.97,0.267059],[],0,"CAN_COLLIDE"];
	_this = _item402;
	_objects pushback _this;
	_objectIDs pushback 402;
	_this setPosWorld [4651.3,7039.97,15.3082];
	_this setVectorDirAndUp [[0.584463,0.81142,0],[0,0,1]];
};

private _item403 = objNull;
if (_layerRoot) then {
	_item403 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4651.45,7040.55,0.267059],[],0,"CAN_COLLIDE"];
	_this = _item403;
	_objects pushback _this;
	_objectIDs pushback 403;
	_this setPosWorld [4651.45,7040.55,15.0998];
	_this setVectorDirAndUp [[0.814921,-0.579572,0],[0,0,1]];
};

private _item404 = objNull;
if (_layerRoot) then {
	_item404 = createVehicle ["Land_MRP_O2_Kdo",[4651.61,7040.99,0.267059],[],0,"CAN_COLLIDE"];
	_this = _item404;
	_objects pushback _this;
	_objectIDs pushback 404;
	_this setPosWorld [4651.61,7040.99,15.0998];
	_this setVectorDirAndUp [[0.584463,0.81142,0],[0,0,1]];
};

private _item405 = objNull;
if (_layerRoot) then {
	_item405 = createVehicle ["Land_MRP_O2_Kdo_Rose",[4651.02,7040.51,0.267059],[],0,"CAN_COLLIDE"];
	_this = _item405;
	_objects pushback _this;
	_objectIDs pushback 405;
	_this setPosWorld [4651.02,7040.51,15.0998];
	_this setVectorDirAndUp [[0.976556,-0.215265,0],[0,0,1]];
};

private _item406 = objNull;
if (_layerRoot) then {
	_item406 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[4652.75,7038.79,0.304658],[],0,"CAN_COLLIDE"];
	_this = _item406;
	_objects pushback _this;
	_objectIDs pushback 406;
	_this setPosWorld [4652.75,7038.79,15.1374];
	_this setVectorDirAndUp [[0.584463,0.81142,0],[0,0,1]];
};

private _item407 = objNull;
if (_layerRoot) then {
	_item407 = createVehicle ["Land_MRP_O2_Kdo_Vert",[4653.23,7038.71,0.275466],[],0,"CAN_COLLIDE"];
	_this = _item407;
	_objects pushback _this;
	_objectIDs pushback 407;
	_this setPosWorld [4653.23,7038.71,15.1082];
	_this setVectorDirAndUp [[0.846012,-0.533165,0],[0,0,1]];
};

private _item408 = objNull;
if (_layerRoot) then {
	_item408 = createVehicle ["Land_O2_Sapin_Noel_anim",[5090.53,4099.32,0.326198],[],0,"CAN_COLLIDE"];
	_this = _item408;
	_objects pushback _this;
	_objectIDs pushback 408;
	_this setPosWorld [5090.53,4099.32,18.1783];
	_this setVectorDirAndUp [[-0.342877,0.93938,0],[0,0,1]];
};

private _item409 = objNull;
if (_layerRoot) then {
	_item409 = createVehicle ["Land_Bare_boulder_02_F",[5090.71,4099.19,0],[],0,"CAN_COLLIDE"];
	_this = _item409;
	_objects pushback _this;
	_objectIDs pushback 409;
	_this setPosWorld [5090.71,4099.19,14.4364];
	_this setVectorDirAndUp [[-0.342877,0.93938,0],[0,0,1]];
};

private _item410 = objNull;
if (_layerRoot) then {
	_item410 = createVehicle ["Land_MRP_O2_Kdo",[5089.91,4100.41,0],[],0,"CAN_COLLIDE"];
	_this = _item410;
	_objects pushback _this;
	_objectIDs pushback 410;
	_this setPosWorld [5089.91,4100.41,14.5728];
	_this setVectorDirAndUp [[-0.842924,-0.538032,0],[0,0,1]];
};

private _item411 = objNull;
if (_layerRoot) then {
	_item411 = createVehicle ["Land_MRP_O2_Gros_Kdo",[5091.18,4100.65,0],[],0,"CAN_COLLIDE"];
	_this = _item411;
	_objects pushback _this;
	_objectIDs pushback 411;
	_this setPosWorld [5091.18,4100.65,14.7812];
	_this setVectorDirAndUp [[-0.342877,0.93938,0],[0,0,1]];
};

private _item412 = objNull;
if (_layerRoot) then {
	_item412 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5091.69,4100.46,0],[],0,"CAN_COLLIDE"];
	_this = _item412;
	_objects pushback _this;
	_objectIDs pushback 412;
	_this setPosWorld [5091.69,4100.46,14.5728];
	_this setVectorDirAndUp [[-0.931142,-0.364658,0],[0,0,1]];
};

private _item413 = objNull;
if (_layerRoot) then {
	_item413 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5090.72,4100.87,0],[],0,"CAN_COLLIDE"];
	_this = _item413;
	_objects pushback _this;
	_objectIDs pushback 413;
	_this setPosWorld [5090.72,4100.87,14.5728];
	_this setVectorDirAndUp [[-0.694304,0.719681,0],[0,0,1]];
};

private _item414 = objNull;
if (_layerRoot) then {
	_item414 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5089.78,4100,0],[],0,"CAN_COLLIDE"];
	_this = _item414;
	_objects pushback _this;
	_objectIDs pushback 414;
	_this setPosWorld [5089.78,4100,14.5728];
	_this setVectorDirAndUp [[-0.342877,0.93938,0],[0,0,1]];
};

private _item415 = objNull;
if (_layerRoot) then {
	_item415 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[5089.25,4097.78,0],[],0,"CAN_COLLIDE"];
	_this = _item415;
	_objects pushback _this;
	_objectIDs pushback 415;
	_this setPosWorld [5089.25,4097.78,14.7812];
	_this setVectorDirAndUp [[-0.342877,0.93938,0],[0,0,1]];
};

private _item416 = objNull;
if (_layerRoot) then {
	_item416 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5088.85,4098.23,0],[],0,"CAN_COLLIDE"];
	_this = _item416;
	_objects pushback _this;
	_objectIDs pushback 416;
	_this setPosWorld [5088.85,4098.23,14.5728];
	_this setVectorDirAndUp [[0.937301,0.348521,0],[0,0,1]];
};

private _item417 = objNull;
if (_layerRoot) then {
	_item417 = createVehicle ["Land_MRP_O2_Kdo",[5088.58,4098.61,0],[],0,"CAN_COLLIDE"];
	_this = _item417;
	_objects pushback _this;
	_objectIDs pushback 417;
	_this setPosWorld [5088.58,4098.61,14.5728];
	_this setVectorDirAndUp [[-0.342877,0.93938,0],[0,0,1]];
};

private _item418 = objNull;
if (_layerRoot) then {
	_item418 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5088.64,4097.84,0],[],0,"CAN_COLLIDE"];
	_this = _item418;
	_objects pushback _this;
	_objectIDs pushback 418;
	_this setPosWorld [5088.64,4097.84,14.5728];
	_this setVectorDirAndUp [[0.726739,0.686914,0],[0,0,1]];
};

private _item419 = objNull;
if (_layerRoot) then {
	_item419 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5091.04,4098.31,0],[],0,"CAN_COLLIDE"];
	_this = _item419;
	_objects pushback _this;
	_objectIDs pushback 419;
	_this setPosWorld [5091.04,4098.31,14.5728];
	_this setVectorDirAndUp [[-0.342877,0.93938,0],[0,0,1]];
};

private _item420 = objNull;
if (_layerRoot) then {
	_item420 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5091.37,4098.66,0],[],0,"CAN_COLLIDE"];
	_this = _item420;
	_objects pushback _this;
	_objectIDs pushback 420;
	_this setPosWorld [5091.37,4098.66,14.5728];
	_this setVectorDirAndUp [[0.916378,0.400314,0],[0,0,1]];
};

private _item421 = objNull;
if (_layerRoot) then {
	_item421 = createVehicle ["Land_O2_Sapin_Noel_anim",[1608.64,10097.7,0.326584],[],0,"CAN_COLLIDE"];
	_this = _item421;
	_objects pushback _this;
	_objectIDs pushback 421;
	_this setPosWorld [1608.64,10097.7,8.73871];
	_this setVectorDirAndUp [[-0.935402,0.353586,0],[0,0,1]];
};

private _item422 = objNull;
if (_layerRoot) then {
	_item422 = createVehicle ["Land_Bare_boulder_02_F",[1608.86,10097.7,0],[],0,"CAN_COLLIDE"];
	_this = _item422;
	_objects pushback _this;
	_objectIDs pushback 422;
	_this setPosWorld [1608.86,10097.7,4.99643];
	_this setVectorDirAndUp [[-0.935402,0.353586,0],[0,0,1]];
};

private _item423 = objNull;
if (_layerRoot) then {
	_item423 = createVehicle ["Land_MRP_O2_Kdo",[1607.41,10097.9,0],[],0,"CAN_COLLIDE"];
	_this = _item423;
	_objects pushback _this;
	_objectIDs pushback 423;
	_this setPosWorld [1607.41,10097.9,5.13278];
	_this setVectorDirAndUp [[-0.14279,-0.989753,0],[0,0,1]];
};

private _item424 = objNull;
if (_layerRoot) then {
	_item424 = createVehicle ["Land_MRP_O2_Gros_Kdo",[1608.06,10099,0],[],0,"CAN_COLLIDE"];
	_this = _item424;
	_objects pushback _this;
	_objectIDs pushback 424;
	_this setPosWorld [1608.06,10099,5.34118];
	_this setVectorDirAndUp [[-0.935402,0.353586,0],[0,0,1]];
};

private _item425 = objNull;
if (_layerRoot) then {
	_item425 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1608.54,10099.3,0],[],0,"CAN_COLLIDE"];
	_this = _item425;
	_objects pushback _this;
	_objectIDs pushback 425;
	_this setPosWorld [1608.54,10099.3,5.13278];
	_this setVectorDirAndUp [[-0.33171,-0.943381,0],[0,0,1]];
};

private _item426 = objNull;
if (_layerRoot) then {
	_item426 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1607.6,10098.8,0],[],0,"CAN_COLLIDE"];
	_this = _item426;
	_objects pushback _this;
	_objectIDs pushback 426;
	_this setPosWorld [1607.6,10098.8,5.13278];
	_this setVectorDirAndUp [[-0.998428,-0.0560433,0],[0,0,1]];
};

private _item427 = objNull;
if (_layerRoot) then {
	_item427 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1607.64,10097.6,0],[],0,"CAN_COLLIDE"];
	_this = _item427;
	_objects pushback _this;
	_objectIDs pushback 427;
	_this setPosWorld [1607.64,10097.6,5.13278];
	_this setVectorDirAndUp [[-0.935402,0.353586,0],[0,0,1]];
};

private _item428 = objNull;
if (_layerRoot) then {
	_item428 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[1608.98,10095.7,0],[],0,"CAN_COLLIDE"];
	_this = _item428;
	_objects pushback _this;
	_objectIDs pushback 428;
	_this setPosWorld [1608.98,10095.7,5.34118];
	_this setVectorDirAndUp [[-0.935402,0.353586,0],[0,0,1]];
};

private _item429 = objNull;
if (_layerRoot) then {
	_item429 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1608.37,10095.7,0],[],0,"CAN_COLLIDE"];
	_this = _item429;
	_objects pushback _this;
	_objectIDs pushback 429;
	_this setPosWorld [1608.37,10095.7,5.13278];
	_this setVectorDirAndUp [[0.347954,0.937512,0],[0,0,1]];
};

private _item430 = objNull;
if (_layerRoot) then {
	_item430 = createVehicle ["Land_MRP_O2_Kdo",[1607.91,10095.7,0],[],0,"CAN_COLLIDE"];
	_this = _item430;
	_objects pushback _this;
	_objectIDs pushback 430;
	_this setPosWorld [1607.91,10095.7,5.13278];
	_this setVectorDirAndUp [[-0.935402,0.353586,0],[0,0,1]];
};

private _item431 = objNull;
if (_layerRoot) then {
	_item431 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1608.53,10095.3,0],[],0,"CAN_COLLIDE"];
	_this = _item431;
	_objects pushback _this;
	_objectIDs pushback 431;
	_this setPosWorld [1608.53,10095.3,5.13278];
	_this setVectorDirAndUp [[-0.0458374,0.998949,0],[0,0,1]];
};

private _item432 = objNull;
if (_layerRoot) then {
	_item432 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1609.74,10097.4,0],[],0,"CAN_COLLIDE"];
	_this = _item432;
	_objects pushback _this;
	_objectIDs pushback 432;
	_this setPosWorld [1609.74,10097.4,5.13278];
	_this setVectorDirAndUp [[-0.935402,0.353586,0],[0,0,1]];
};

private _item433 = objNull;
if (_layerRoot) then {
	_item433 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1609.69,10097.9,0],[],0,"CAN_COLLIDE"];
	_this = _item433;
	_objects pushback _this;
	_objectIDs pushback 433;
	_this setPosWorld [1609.69,10097.9,5.13278];
	_this setVectorDirAndUp [[0.295062,0.955478,0],[0,0,1]];
};

private _item434 = objNull;
if (_layerRoot) then {
	_item434 = createVehicle ["Land_O2_Sapin_Noel_anim",[1154.5,7377.67,0.374951],[],0,"CAN_COLLIDE"];
	_this = _item434;
	_objects pushback _this;
	_objectIDs pushback 434;
	_this setPosWorld [1154.5,7377.67,13.1571];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item435 = objNull;
if (_layerRoot) then {
	_item435 = createVehicle ["Land_Bare_boulder_02_F",[1154.33,7377.81,0.0486984],[],0,"CAN_COLLIDE"];
	_this = _item435;
	_objects pushback _this;
	_objectIDs pushback 435;
	_this setPosWorld [1154.33,7377.81,9.41512];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item436 = objNull;
if (_layerRoot) then {
	_item436 = createVehicle ["Land_MRP_O2_Kdo",[1155.1,7376.57,0],[],0,"CAN_COLLIDE"];
	_this = _item436;
	_objects pushback _this;
	_objectIDs pushback 436;
	_this setPosWorld [1155.1,7376.57,9.50278];
	_this setVectorDirAndUp [[0.853829,0.520554,0],[0,0,1]];
};

private _item437 = objNull;
if (_layerRoot) then {
	_item437 = createVehicle ["Land_MRP_O2_Gros_Kdo",[1153.83,7376.35,0.000999451],[],0,"CAN_COLLIDE"];
	_this = _item437;
	_objects pushback _this;
	_objectIDs pushback 437;
	_this setPosWorld [1153.83,7376.35,9.71218];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item438 = objNull;
if (_layerRoot) then {
	_item438 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1153.32,7376.56,0.0486984],[],0,"CAN_COLLIDE"];
	_this = _item438;
	_objects pushback _this;
	_objectIDs pushback 438;
	_this setPosWorld [1153.32,7376.56,9.55148];
	_this setVectorDirAndUp [[0.938456,0.345399,0],[0,0,1]];
};

private _item439 = objNull;
if (_layerRoot) then {
	_item439 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1154.28,7376.13,0.000999451],[],0,"CAN_COLLIDE"];
	_this = _item439;
	_objects pushback _this;
	_objectIDs pushback 439;
	_this setPosWorld [1154.28,7376.13,9.50378];
	_this setVectorDirAndUp [[0.679332,-0.733831,0],[0,0,1]];
};

private _item440 = objNull;
if (_layerRoot) then {
	_item440 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1155.24,7376.98,0],[],0,"CAN_COLLIDE"];
	_this = _item440;
	_objects pushback _this;
	_objectIDs pushback 440;
	_this setPosWorld [1155.24,7376.98,9.50278];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item441 = objNull;
if (_layerRoot) then {
	_item441 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[1155.82,7379.19,0.000999451],[],0,"CAN_COLLIDE"];
	_this = _item441;
	_objects pushback _this;
	_objectIDs pushback 441;
	_this setPosWorld [1155.82,7379.19,9.71218];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item442 = objNull;
if (_layerRoot) then {
	_item442 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1156.21,7378.73,0.000999451],[],0,"CAN_COLLIDE"];
	_this = _item442;
	_objects pushback _this;
	_objectIDs pushback 442;
	_this setPosWorld [1156.21,7378.73,9.50378];
	_this setVectorDirAndUp [[-0.944282,-0.329139,0],[0,0,1]];
};

private _item443 = objNull;
if (_layerRoot) then {
	_item443 = createVehicle ["Land_MRP_O2_Kdo",[1156.47,7378.34,0.000999451],[],0,"CAN_COLLIDE"];
	_this = _item443;
	_objects pushback _this;
	_objectIDs pushback 443;
	_this setPosWorld [1156.47,7378.34,9.50378];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item444 = objNull;
if (_layerRoot) then {
	_item444 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1156.43,7379.11,0.000999451],[],0,"CAN_COLLIDE"];
	_this = _item444;
	_objects pushback _this;
	_objectIDs pushback 444;
	_this setPosWorld [1156.43,7379.11,9.50378];
	_this setVectorDirAndUp [[-0.740735,-0.671797,0],[0,0,1]];
};

private _item445 = objNull;
if (_layerRoot) then {
	_item445 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1154.02,7378.69,0.0385981],[],0,"CAN_COLLIDE"];
	_this = _item445;
	_objects pushback _this;
	_objectIDs pushback 445;
	_this setPosWorld [1154.02,7378.69,9.54138];
	_this setVectorDirAndUp [[0.323453,-0.946244,0],[0,0,1]];
};

private _item446 = objNull;
if (_layerRoot) then {
	_item446 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1153.67,7378.34,0.00940609],[],0,"CAN_COLLIDE"];
	_this = _item446;
	_objects pushback _this;
	_objectIDs pushback 446;
	_this setPosWorld [1153.67,7378.34,9.51219];
	_this setVectorDirAndUp [[-0.92443,-0.381352,0],[0,0,1]];
};

private _item447 = objNull;
if (_layerRoot) then {
	_item447 = createVehicle ["Land_O2_Sapin_Noel_anim",[1282.39,7265.78,0.326253],[],0,"CAN_COLLIDE"];
	_this = _item447;
	_objects pushback _this;
	_objectIDs pushback 447;
	_this setPosWorld [1282.39,7265.78,13.1084];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item448 = objNull;
if (_layerRoot) then {
	_item448 = createVehicle ["Land_Bare_boulder_02_F",[1282.48,7265.98,0],[],0,"CAN_COLLIDE"];
	_this = _item448;
	_objects pushback _this;
	_objectIDs pushback 448;
	_this setPosWorld [1282.48,7265.98,9.36643];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item449 = objNull;
if (_layerRoot) then {
	_item449 = createVehicle ["Land_MRP_O2_Kdo",[1281.46,7264.94,0],[],0,"CAN_COLLIDE"];
	_this = _item449;
	_objects pushback _this;
	_objectIDs pushback 449;
	_this setPosWorld [1281.46,7264.94,9.50278];
	_this setVectorDirAndUp [[0.710984,-0.703208,0],[0,0,1]];
};

private _item450 = objNull;
if (_layerRoot) then {
	_item450 = createVehicle ["Land_MRP_O2_Gros_Kdo",[1280.95,7266.12,0],[],0,"CAN_COLLIDE"];
	_this = _item450;
	_objects pushback _this;
	_objectIDs pushback 450;
	_this setPosWorld [1280.95,7266.12,9.71118];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item451 = objNull;
if (_layerRoot) then {
	_item451 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1281.03,7266.66,0],[],0,"CAN_COLLIDE"];
	_this = _item451;
	_objects pushback _this;
	_objectIDs pushback 451;
	_this setPosWorld [1281.03,7266.66,9.50278];
	_this setVectorDirAndUp [[0.561387,-0.827553,0],[0,0,1]];
};

private _item452 = objNull;
if (_layerRoot) then {
	_item452 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1280.84,7265.63,0],[],0,"CAN_COLLIDE"];
	_this = _item452;
	_objects pushback _this;
	_objectIDs pushback 452;
	_this setPosWorld [1280.84,7265.63,9.50278];
	_this setVectorDirAndUp [[-0.548482,-0.836163,0],[0,0,1]];
};

private _item453 = objNull;
if (_layerRoot) then {
	_item453 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1281.9,7264.9,0],[],0,"CAN_COLLIDE"];
	_this = _item453;
	_objects pushback _this;
	_objectIDs pushback 453;
	_this setPosWorld [1281.9,7264.9,9.50278];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item454 = objNull;
if (_layerRoot) then {
	_item454 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[1284.18,7264.87,0],[],0,"CAN_COLLIDE"];
	_this = _item454;
	_objects pushback _this;
	_objectIDs pushback 454;
	_this setPosWorld [1284.18,7264.87,9.71118];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item455 = objNull;
if (_layerRoot) then {
	_item455 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1283.83,7264.38,0],[],0,"CAN_COLLIDE"];
	_this = _item455;
	_objects pushback _this;
	_objectIDs pushback 455;
	_this setPosWorld [1283.83,7264.38,9.50278];
	_this setVectorDirAndUp [[-0.547011,0.837126,0],[0,0,1]];
};

private _item456 = objNull;
if (_layerRoot) then {
	_item456 = createVehicle ["Land_MRP_O2_Kdo",[1283.52,7264.04,0],[],0,"CAN_COLLIDE"];
	_this = _item456;
	_objects pushback _this;
	_objectIDs pushback 456;
	_this setPosWorld [1283.52,7264.04,9.50278];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item457 = objNull;
if (_layerRoot) then {
	_item457 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1284.25,7264.26,0],[],0,"CAN_COLLIDE"];
	_this = _item457;
	_objects pushback _this;
	_objectIDs pushback 457;
	_this setPosWorld [1284.25,7264.26,9.50278];
	_this setVectorDirAndUp [[-0.830514,0.556998,0],[0,0,1]];
};

private _item458 = objNull;
if (_layerRoot) then {
	_item458 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1283.26,7266.5,0],[],0,"CAN_COLLIDE"];
	_this = _item458;
	_objects pushback _this;
	_objectIDs pushback 458;
	_this setPosWorld [1283.26,7266.5,9.50278];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item459 = objNull;
if (_layerRoot) then {
	_item459 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1282.84,7266.75,0],[],0,"CAN_COLLIDE"];
	_this = _item459;
	_objects pushback _this;
	_objectIDs pushback 459;
	_this setPosWorld [1282.84,7266.75,9.50278];
	_this setVectorDirAndUp [[-0.5929,0.805276,0],[0,0,1]];
};

private _item460 = objNull;
if (_layerRoot) then {
	_item460 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[1022.69,6530.81,-4.76837e-07],[],0,"CAN_COLLIDE"];
	_this = _item460;
	_objects pushback _this;
	_objectIDs pushback 460;
	_this setPosWorld [1022.69,6530.81,7.76038];
	_this setVectorDirAndUp [[-0.999993,-0.00364397,0],[0,0,1]];
};

private _item464 = objNull;
if (_layerRoot) then {
	_item464 = createVehicle ["Land_O2_Sapin_Noel_anim",[1039.49,6495.23,0.691583],[],0,"CAN_COLLIDE"];
	_this = _item464;
	_objects pushback _this;
	_objectIDs pushback 464;
	_this setPosWorld [1039.49,6495.23,8.52371];
	_this setVectorDirAndUp [[-0.249317,0.968422,0],[0,0,1]];
};

private _item465 = objNull;
if (_layerRoot) then {
	_item465 = createVehicle ["Land_Bare_boulder_02_F",[1039.65,6495.08,0],[],0,"CAN_COLLIDE"];
	_this = _item465;
	_objects pushback _this;
	_objectIDs pushback 465;
	_this setPosWorld [1039.65,6495.08,4.41643];
	_this setVectorDirAndUp [[0.0276427,0.999618,0],[0,0,1]];
};

private _item466 = objNull;
if (_layerRoot) then {
	_item466 = createVehicle ["Land_MRP_O2_Kdo",[1038.98,6496.37,0],[],0,"CAN_COLLIDE"];
	_this = _item466;
	_objects pushback _this;
	_objectIDs pushback 466;
	_this setPosWorld [1038.98,6496.37,4.55278];
	_this setVectorDirAndUp [[-0.891524,-0.452974,0],[0,0,1]];
};

private _item467 = objNull;
if (_layerRoot) then {
	_item467 = createVehicle ["Land_MRP_O2_Gros_Kdo",[1040.27,6496.49,0],[],0,"CAN_COLLIDE"];
	_this = _item467;
	_objects pushback _this;
	_objectIDs pushback 467;
	_this setPosWorld [1040.27,6496.49,4.76118];
	_this setVectorDirAndUp [[-0.249317,0.968422,0],[0,0,1]];
};

private _item468 = objNull;
if (_layerRoot) then {
	_item468 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1040.75,6496.25,0],[],0,"CAN_COLLIDE"];
	_this = _item468;
	_objects pushback _this;
	_objectIDs pushback 468;
	_this setPosWorld [1040.75,6496.25,4.55278];
	_this setVectorDirAndUp [[-0.962354,-0.271799,0],[0,0,1]];
};

private _item469 = objNull;
if (_layerRoot) then {
	_item469 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1039.83,6496.75,0],[],0,"CAN_COLLIDE"];
	_this = _item469;
	_objects pushback _this;
	_objectIDs pushback 469;
	_this setPosWorld [1039.83,6496.75,4.55278];
	_this setVectorDirAndUp [[-0.620555,0.784163,0],[0,0,1]];
};

private _item470 = objNull;
if (_layerRoot) then {
	_item470 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1038.81,6495.97,0],[],0,"CAN_COLLIDE"];
	_this = _item470;
	_objects pushback _this;
	_objectIDs pushback 470;
	_this setPosWorld [1038.81,6495.97,4.55278];
	_this setVectorDirAndUp [[-0.249317,0.968422,0],[0,0,1]];
};

private _item471 = objNull;
if (_layerRoot) then {
	_item471 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[1038.06,6493.81,0],[],0,"CAN_COLLIDE"];
	_this = _item471;
	_objects pushback _this;
	_objectIDs pushback 471;
	_this setPosWorld [1038.06,6493.81,4.76118];
	_this setVectorDirAndUp [[-0.249317,0.968422,0],[0,0,1]];
};

private _item472 = objNull;
if (_layerRoot) then {
	_item472 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1037.71,6494.3,0],[],0,"CAN_COLLIDE"];
	_this = _item472;
	_objects pushback _this;
	_objectIDs pushback 472;
	_this setPosWorld [1037.71,6494.3,4.55278];
	_this setVectorDirAndUp [[0.966905,0.255138,0],[0,0,1]];
};

private _item473 = objNull;
if (_layerRoot) then {
	_item473 = createVehicle ["Land_MRP_O2_Kdo",[1037.48,6494.71,0],[],0,"CAN_COLLIDE"];
	_this = _item473;
	_objects pushback _this;
	_objectIDs pushback 473;
	_this setPosWorld [1037.48,6494.71,4.55278];
	_this setVectorDirAndUp [[-0.249317,0.968422,0],[0,0,1]];
};

private _item474 = objNull;
if (_layerRoot) then {
	_item474 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1037.46,6493.94,0],[],0,"CAN_COLLIDE"];
	_this = _item474;
	_objects pushback _this;
	_objectIDs pushback 474;
	_this setPosWorld [1037.46,6493.94,4.55278];
	_this setVectorDirAndUp [[0.790463,0.612509,0],[0,0,1]];
};

private _item475 = objNull;
if (_layerRoot) then {
	_item475 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1039.9,6494.17,0],[],0,"CAN_COLLIDE"];
	_this = _item475;
	_objects pushback _this;
	_objectIDs pushback 475;
	_this setPosWorld [1039.9,6494.17,4.55278];
	_this setVectorDirAndUp [[-0.249317,0.968422,0],[0,0,1]];
};

private _item476 = objNull;
if (_layerRoot) then {
	_item476 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1040.27,6494.49,0],[],0,"CAN_COLLIDE"];
	_this = _item476;
	_objects pushback _this;
	_objectIDs pushback 476;
	_this setPosWorld [1040.27,6494.49,4.55278];
	_this setVectorDirAndUp [[0.95115,0.30873,0],[0,0,1]];
};

private _item477 = objNull;
if (_layerRoot) then {
	_item477 = createVehicle ["Land_O2_Sapin_Noel_anim",[1985.56,9943.15,0.691757],[],0,"CAN_COLLIDE"];
	_this = _item477;
	_objects pushback _this;
	_objectIDs pushback 477;
	_this setPosWorld [1985.56,9943.15,18.7839];
	_this setVectorDirAndUp [[-0.894836,-0.446395,0],[0,0,1]];
};

private _item478 = objNull;
if (_layerRoot) then {
	_item478 = createVehicle ["Land_Bare_boulder_02_F",[1985.68,9943.34,0],[],0,"CAN_COLLIDE"];
	_this = _item478;
	_objects pushback _this;
	_objectIDs pushback 478;
	_this setPosWorld [1985.68,9943.34,14.6764];
	_this setVectorDirAndUp [[-0.894836,-0.446395,0],[0,0,1]];
};

private _item479 = objNull;
if (_layerRoot) then {
	_item479 = createVehicle ["Land_MRP_O2_Kdo",[1984.55,9942.41,0],[],0,"CAN_COLLIDE"];
	_this = _item479;
	_objects pushback _this;
	_objectIDs pushback 479;
	_this setPosWorld [1984.55,9942.41,14.8128];
	_this setVectorDirAndUp [[0.629458,-0.777035,0],[0,0,1]];
};

private _item480 = objNull;
if (_layerRoot) then {
	_item480 = createVehicle ["Land_MRP_O2_Gros_Kdo",[1984.17,9943.64,0],[],0,"CAN_COLLIDE"];
	_this = _item480;
	_objects pushback _this;
	_objectIDs pushback 480;
	_this setPosWorld [1984.17,9943.64,15.0212];
	_this setVectorDirAndUp [[-0.894836,-0.446395,0],[0,0,1]];
};

private _item481 = objNull;
if (_layerRoot) then {
	_item481 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1984.31,9944.17,0],[],0,"CAN_COLLIDE"];
	_this = _item481;
	_objects pushback _this;
	_objectIDs pushback 481;
	_this setPosWorld [1984.31,9944.17,14.8128];
	_this setVectorDirAndUp [[0.46711,-0.884199,0],[0,0,1]];
};

private _item482 = objNull;
if (_layerRoot) then {
	_item482 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1984.01,9943.16,0],[],0,"CAN_COLLIDE"];
	_this = _item482;
	_objects pushback _this;
	_objectIDs pushback 482;
	_this setPosWorld [1984.01,9943.16,14.8128];
	_this setVectorDirAndUp [[-0.636991,-0.770871,0],[0,0,1]];
};

private _item483 = objNull;
if (_layerRoot) then {
	_item483 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1984.98,9942.32,0],[],0,"CAN_COLLIDE"];
	_this = _item483;
	_objects pushback _this;
	_objectIDs pushback 483;
	_this setPosWorld [1984.98,9942.32,14.8128];
	_this setVectorDirAndUp [[-0.894836,-0.446395,0],[0,0,1]];
};

private _item484 = objNull;
if (_layerRoot) then {
	_item484 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[1987.25,9942.05,0],[],0,"CAN_COLLIDE"];
	_this = _item484;
	_objects pushback _this;
	_objectIDs pushback 484;
	_this setPosWorld [1987.25,9942.05,15.0212];
	_this setVectorDirAndUp [[-0.894836,-0.446395,0],[0,0,1]];
};

private _item485 = objNull;
if (_layerRoot) then {
	_item485 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1986.84,9941.6,0],[],0,"CAN_COLLIDE"];
	_this = _item485;
	_objects pushback _this;
	_objectIDs pushback 485;
	_this setPosWorld [1986.84,9941.6,14.8128];
	_this setVectorDirAndUp [[-0.451769,0.892135,0],[0,0,1]];
};

private _item486 = objNull;
if (_layerRoot) then {
	_item486 = createVehicle ["Land_MRP_O2_Kdo",[1986.49,9941.29,0],[],0,"CAN_COLLIDE"];
	_this = _item486;
	_objects pushback _this;
	_objectIDs pushback 486;
	_this setPosWorld [1986.49,9941.29,14.8128];
	_this setVectorDirAndUp [[-0.894836,-0.446395,0],[0,0,1]];
};

private _item487 = objNull;
if (_layerRoot) then {
	_item487 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1987.25,9941.43,0],[],0,"CAN_COLLIDE"];
	_this = _item487;
	_objects pushback _this;
	_objectIDs pushback 487;
	_this setPosWorld [1987.25,9941.43,14.8128];
	_this setVectorDirAndUp [[-0.764321,0.644836,0],[0,0,1]];
};

private _item488 = objNull;
if (_layerRoot) then {
	_item488 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1986.51,9943.77,0],[],0,"CAN_COLLIDE"];
	_this = _item488;
	_objects pushback _this;
	_objectIDs pushback 488;
	_this setPosWorld [1986.51,9943.77,14.8128];
	_this setVectorDirAndUp [[-0.894836,-0.446395,0],[0,0,1]];
};

private _item489 = objNull;
if (_layerRoot) then {
	_item489 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1986.12,9944.06,0],[],0,"CAN_COLLIDE"];
	_this = _item489;
	_objects pushback _this;
	_objectIDs pushback 489;
	_this setPosWorld [1986.12,9944.06,14.8128];
	_this setVectorDirAndUp [[-0.500879,0.865517,0],[0,0,1]];
};

private _item490 = objNull;
if (_layerRoot) then {
	_item490 = createVehicle ["Land_O2_Sapin_Noel_anim",[6407.8,6089.09,0.691528],[],0,"CAN_COLLIDE"];
	_this = _item490;
	_objects pushback _this;
	_objectIDs pushback 490;
	_this setPosWorld [6407.8,6089.09,39.9637];
	_this setVectorDirAndUp [[-0.373761,-0.927525,0],[0,0,1]];
};

private _item491 = objNull;
if (_layerRoot) then {
	_item491 = createVehicle ["Land_Bare_boulder_02_F",[6407.76,6089.3,0],[],0,"CAN_COLLIDE"];
	_this = _item491;
	_objects pushback _this;
	_objectIDs pushback 491;
	_this setPosWorld [6407.76,6089.3,35.8564];
	_this setVectorDirAndUp [[-0.373761,-0.927525,0],[0,0,1]];
};

private _item492 = objNull;
if (_layerRoot) then {
	_item492 = createVehicle ["Land_MRP_O2_Kdo",[6407.53,6087.86,0],[],0,"CAN_COLLIDE"];
	_this = _item492;
	_objects pushback _this;
	_objectIDs pushback 492;
	_this setPosWorld [6407.53,6087.86,35.9928];
	_this setVectorDirAndUp [[0.986429,-0.164191,0],[0,0,1]];
};

private _item493 = objNull;
if (_layerRoot) then {
	_item493 = createVehicle ["Land_MRP_O2_Gros_Kdo",[6406.43,6088.53,0],[],0,"CAN_COLLIDE"];
	_this = _item493;
	_objects pushback _this;
	_objectIDs pushback 493;
	_this setPosWorld [6406.43,6088.53,36.2012];
	_this setVectorDirAndUp [[-0.373761,-0.927525,0],[0,0,1]];
};

private _item494 = objNull;
if (_layerRoot) then {
	_item494 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6406.18,6089.01,0],[],0,"CAN_COLLIDE"];
	_this = _item494;
	_objects pushback _this;
	_objectIDs pushback 494;
	_this setPosWorld [6406.18,6089.01,35.9928];
	_this setVectorDirAndUp [[0.935977,-0.352062,0],[0,0,1]];
};

private _item495 = objNull;
if (_layerRoot) then {
	_item495 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6406.63,6088.06,0],[],0,"CAN_COLLIDE"];
	_this = _item495;
	_objects pushback _this;
	_objectIDs pushback 495;
	_this setPosWorld [6406.63,6088.06,35.9928];
	_this setVectorDirAndUp [[0.0344074,-0.999408,0],[0,0,1]];
};

private _item496 = objNull;
if (_layerRoot) then {
	_item496 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6407.91,6088.08,0],[],0,"CAN_COLLIDE"];
	_this = _item496;
	_objects pushback _this;
	_objectIDs pushback 496;
	_this setPosWorld [6407.91,6088.08,35.9928];
	_this setVectorDirAndUp [[-0.373761,-0.927525,0],[0,0,1]];
};

private _item497 = objNull;
if (_layerRoot) then {
	_item497 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[6409.79,6089.37,0],[],0,"CAN_COLLIDE"];
	_this = _item497;
	_objects pushback _this;
	_objectIDs pushback 497;
	_this setPosWorld [6409.79,6089.37,36.2012];
	_this setVectorDirAndUp [[-0.373761,-0.927525,0],[0,0,1]];
};

private _item498 = objNull;
if (_layerRoot) then {
	_item498 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6409.79,6088.77,0],[],0,"CAN_COLLIDE"];
	_this = _item498;
	_objects pushback _this;
	_objectIDs pushback 498;
	_this setPosWorld [6409.79,6088.77,35.9928];
	_this setVectorDirAndUp [[-0.929756,0.368176,0],[0,0,1]];
};

private _item499 = objNull;
if (_layerRoot) then {
	_item499 = createVehicle ["Land_MRP_O2_Kdo",[6409.73,6088.31,0],[],0,"CAN_COLLIDE"];
	_this = _item499;
	_objects pushback _this;
	_objectIDs pushback 499;
	_this setPosWorld [6409.73,6088.31,35.9928];
	_this setVectorDirAndUp [[-0.373761,-0.927525,0],[0,0,1]];
};

private _item500 = objNull;
if (_layerRoot) then {
	_item500 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6410.2,6088.92,0],[],0,"CAN_COLLIDE"];
	_this = _item500;
	_objects pushback _this;
	_objectIDs pushback 500;
	_this setPosWorld [6410.2,6088.92,35.9928];
	_this setVectorDirAndUp [[-0.999707,-0.0241923,0],[0,0,1]];
};

private _item501 = objNull;
if (_layerRoot) then {
	_item501 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6408.1,6090.17,0],[],0,"CAN_COLLIDE"];
	_this = _item501;
	_objects pushback _this;
	_objectIDs pushback 501;
	_this setPosWorld [6408.1,6090.17,35.9928];
	_this setVectorDirAndUp [[-0.373761,-0.927525,0],[0,0,1]];
};

private _item502 = objNull;
if (_layerRoot) then {
	_item502 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6407.62,6090.14,0],[],0,"CAN_COLLIDE"];
	_this = _item502;
	_objects pushback _this;
	_objectIDs pushback 502;
	_this setPosWorld [6407.62,6090.14,35.9928];
	_this setVectorDirAndUp [[-0.948864,0.315686,0],[0,0,1]];
};

private _item503 = objNull;
if (_layerRoot) then {
	_item503 = createVehicle ["Land_O2_Sapin_Noel_anim",[3226.26,3012.56,2.68392],[],0,"CAN_COLLIDE"];
	_this = _item503;
	_objects pushback _this;
	_objectIDs pushback 503;
	_this setPosWorld [3226.26,3012.56,7.62184];
	_this setVectorDirAndUp [[-0.991906,-0.126978,0],[0,0,1]];
};

private _item504 = objNull;
if (_layerRoot) then {
	_item504 = createVehicle ["Land_Bare_boulder_02_F",[3226.43,3012.7,1.987],[],0,"CAN_COLLIDE"];
	_this = _item504;
	_objects pushback _this;
	_objectIDs pushback 504;
	_this setPosWorld [3226.43,3012.7,3.51118];
	_this setVectorDirAndUp [[-0.991906,-0.126978,0],[0,0,1]];
};

private _item505 = objNull;
if (_layerRoot) then {
	_item505 = createVehicle ["Land_MRP_O2_Kdo",[3225.06,3012.19,2.0257],[],0,"CAN_COLLIDE"];
	_this = _item505;
	_objects pushback _this;
	_objectIDs pushback 505;
	_this setPosWorld [3225.06,3012.19,3.67918];
	_this setVectorDirAndUp [[0.338615,-0.940925,0],[0,0,1]];
};

private _item506 = objNull;
if (_layerRoot) then {
	_item506 = createVehicle ["Land_MRP_O2_Gros_Kdo",[3225.11,3013.48,2.02246],[],0,"CAN_COLLIDE"];
	_this = _item506;
	_objects pushback _this;
	_objectIDs pushback 506;
	_this setPosWorld [3225.11,3013.48,3.90236];
	_this setVectorDirAndUp [[-0.991906,-0.126978,0],[0,0,1]];
};

private _item507 = objNull;
if (_layerRoot) then {
	_item507 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[3225.41,3013.93,2.01294],[],0,"CAN_COLLIDE"];
	_this = _item507;
	_objects pushback _this;
	_objectIDs pushback 507;
	_this setPosWorld [3225.41,3013.93,3.69076];
	_this setVectorDirAndUp [[0.15004,-0.98868,0],[0,0,1]];
};

private _item508 = objNull;
if (_layerRoot) then {
	_item508 = createVehicle ["Land_MRP_O2_Kdo_Vert",[3224.79,3013.08,2.03222],[],0,"CAN_COLLIDE"];
	_this = _item508;
	_objects pushback _this;
	_objectIDs pushback 508;
	_this setPosWorld [3224.79,3013.08,3.69816];
	_this setVectorDirAndUp [[-0.855233,-0.518244,0],[0,0,1]];
};

private _item509 = objNull;
if (_layerRoot) then {
	_item509 = createVehicle ["Land_MRP_O2_Kdo_Rose",[3225.43,3011.97,2.01742],[],0,"CAN_COLLIDE"];
	_this = _item509;
	_objects pushback _this;
	_objectIDs pushback 509;
	_this setPosWorld [3225.43,3011.97,3.66774];
	_this setVectorDirAndUp [[-0.991906,-0.126978,0],[0,0,1]];
};

private _item510 = objNull;
if (_layerRoot) then {
	_item510 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[3227.48,3010.96,1.95837],[],0,"CAN_COLLIDE"];
	_this = _item510;
	_objects pushback _this;
	_objectIDs pushback 510;
	_this setPosWorld [3227.48,3010.96,3.80301];
	_this setVectorDirAndUp [[-0.991906,-0.126978,0],[0,0,1]];
};

private _item511 = objNull;
if (_layerRoot) then {
	_item511 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[3226.95,3010.67,1.97443],[],0,"CAN_COLLIDE"];
	_this = _item511;
	_objects pushback _this;
	_objectIDs pushback 511;
	_this setPosWorld [3226.95,3010.67,3.60658];
	_this setVectorDirAndUp [[-0.132942,0.991124,0],[0,0,1]];
};

private _item512 = objNull;
if (_layerRoot) then {
	_item512 = createVehicle ["Land_MRP_O2_Kdo",[3226.52,3010.49,1.98737],[],0,"CAN_COLLIDE"];
	_this = _item512;
	_objects pushback _this;
	_objectIDs pushback 512;
	_this setPosWorld [3226.52,3010.49,3.61704];
	_this setVectorDirAndUp [[-0.991906,-0.126978,0],[0,0,1]];
};

private _item513 = objNull;
if (_layerRoot) then {
	_item513 = createVehicle ["Land_MRP_O2_Kdo_Rose",[3227.28,3010.38,1.9651],[],0,"CAN_COLLIDE"];
	_this = _item513;
	_objects pushback _this;
	_objectIDs pushback 513;
	_this setPosWorld [3227.28,3010.38,3.59324];
	_this setVectorDirAndUp [[-0.509478,0.860484,0],[0,0,1]];
};

private _item514 = objNull;
if (_layerRoot) then {
	_item514 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[3227.36,3012.83,1.95948],[],0,"CAN_COLLIDE"];
	_this = _item514;
	_objects pushback _this;
	_objectIDs pushback 514;
	_this setPosWorld [3227.36,3012.83,3.62184];
	_this setVectorDirAndUp [[-0.991906,-0.126978,0],[0,0,1]];
};

private _item515 = objNull;
if (_layerRoot) then {
	_item515 = createVehicle ["Land_MRP_O2_Kdo_Vert",[3227.09,3013.23,1.96682],[],0,"CAN_COLLIDE"];
	_this = _item515;
	_objects pushback _this;
	_objectIDs pushback 515;
	_this setPosWorld [3227.09,3013.23,3.63482];
	_this setVectorDirAndUp [[-0.188077,0.982154,0],[0,0,1]];
};

private _item518 = objNull;
if (_layerRoot) then {
	_item518 = createVehicle ["Land_O2_Sapin_Noel_anim",[8093.43,2403.25,0.691615],[],0,"CAN_COLLIDE"];
	_this = _item518;
	_objects pushback _this;
	_objectIDs pushback 518;
	_this setPosWorld [8093.43,2403.25,18.9137];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item519 = objNull;
if (_layerRoot) then {
	_item519 = createVehicle ["Land_Bare_boulder_02_F",[8093.53,2403.45,0],[],0,"CAN_COLLIDE"];
	_this = _item519;
	_objects pushback _this;
	_objectIDs pushback 519;
	_this setPosWorld [8093.53,2403.45,14.8064];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item520 = objNull;
if (_layerRoot) then {
	_item520 = createVehicle ["Land_MRP_O2_Kdo",[8092.51,2402.4,0],[],0,"CAN_COLLIDE"];
	_this = _item520;
	_objects pushback _this;
	_objectIDs pushback 520;
	_this setPosWorld [8092.51,2402.4,14.9428];
	_this setVectorDirAndUp [[0.710984,-0.703208,0],[0,0,1]];
};

private _item521 = objNull;
if (_layerRoot) then {
	_item521 = createVehicle ["Land_MRP_O2_Gros_Kdo",[8092,2403.59,0],[],0,"CAN_COLLIDE"];
	_this = _item521;
	_objects pushback _this;
	_objectIDs pushback 521;
	_this setPosWorld [8092,2403.59,15.1512];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item522 = objNull;
if (_layerRoot) then {
	_item522 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8092.07,2404.12,0],[],0,"CAN_COLLIDE"];
	_this = _item522;
	_objects pushback _this;
	_objectIDs pushback 522;
	_this setPosWorld [8092.07,2404.12,14.9428];
	_this setVectorDirAndUp [[0.561387,-0.827553,0],[0,0,1]];
};

private _item523 = objNull;
if (_layerRoot) then {
	_item523 = createVehicle ["Land_MRP_O2_Kdo_Vert",[8091.89,2403.09,0],[],0,"CAN_COLLIDE"];
	_this = _item523;
	_objects pushback _this;
	_objectIDs pushback 523;
	_this setPosWorld [8091.89,2403.09,14.9428];
	_this setVectorDirAndUp [[-0.548482,-0.836163,0],[0,0,1]];
};

private _item524 = objNull;
if (_layerRoot) then {
	_item524 = createVehicle ["Land_MRP_O2_Kdo_Rose",[8092.94,2402.36,0],[],0,"CAN_COLLIDE"];
	_this = _item524;
	_objects pushback _this;
	_objectIDs pushback 524;
	_this setPosWorld [8092.94,2402.36,14.9428];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item525 = objNull;
if (_layerRoot) then {
	_item525 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[8095.23,2402.34,0],[],0,"CAN_COLLIDE"];
	_this = _item525;
	_objects pushback _this;
	_objectIDs pushback 525;
	_this setPosWorld [8095.23,2402.34,15.1512];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item526 = objNull;
if (_layerRoot) then {
	_item526 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8094.87,2401.85,0],[],0,"CAN_COLLIDE"];
	_this = _item526;
	_objects pushback _this;
	_objectIDs pushback 526;
	_this setPosWorld [8094.87,2401.85,14.9428];
	_this setVectorDirAndUp [[-0.547011,0.837126,0],[0,0,1]];
};

private _item527 = objNull;
if (_layerRoot) then {
	_item527 = createVehicle ["Land_MRP_O2_Kdo",[8094.56,2401.5,0],[],0,"CAN_COLLIDE"];
	_this = _item527;
	_objects pushback _this;
	_objectIDs pushback 527;
	_this setPosWorld [8094.56,2401.5,14.9428];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item528 = objNull;
if (_layerRoot) then {
	_item528 = createVehicle ["Land_MRP_O2_Kdo_Rose",[8095.3,2401.73,0],[],0,"CAN_COLLIDE"];
	_this = _item528;
	_objects pushback _this;
	_objectIDs pushback 528;
	_this setPosWorld [8095.3,2401.73,14.9428];
	_this setVectorDirAndUp [[-0.830514,0.556998,0],[0,0,1]];
};

private _item529 = objNull;
if (_layerRoot) then {
	_item529 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8094.31,2403.97,0],[],0,"CAN_COLLIDE"];
	_this = _item529;
	_objects pushback _this;
	_objectIDs pushback 529;
	_this setPosWorld [8094.31,2403.97,14.9428];
	_this setVectorDirAndUp [[-0.840401,-0.541965,0],[0,0,1]];
};

private _item530 = objNull;
if (_layerRoot) then {
	_item530 = createVehicle ["Land_MRP_O2_Kdo_Vert",[8093.89,2404.21,0],[],0,"CAN_COLLIDE"];
	_this = _item530;
	_objects pushback _this;
	_objectIDs pushback 530;
	_this setPosWorld [8093.89,2404.21,14.9428];
	_this setVectorDirAndUp [[-0.5929,0.805276,0],[0,0,1]];
};

private _item531 = objNull;
if (_layerRoot) then {
	_item531 = createVehicle ["Land_O2_Sapin_Noel_anim",[7755.3,4577.95,0.801567],[],0,"CAN_COLLIDE"];
	_this = _item531;
	_objects pushback _this;
	_objectIDs pushback 531;
	_this setPosWorld [7755.3,4577.95,18.1237];
	_this setVectorDirAndUp [[0.970508,0.241068,0],[0,0,1]];
};

private _item532 = objNull;
if (_layerRoot) then {
	_item532 = createVehicle ["Land_Bare_boulder_02_F",[7755.15,4577.79,0.110038],[],0,"CAN_COLLIDE"];
	_this = _item532;
	_objects pushback _this;
	_objectIDs pushback 532;
	_this setPosWorld [7755.15,4577.79,14.0165];
	_this setVectorDirAndUp [[0.970508,0.241068,0],[0,0,1]];
};

private _item533 = objNull;
if (_layerRoot) then {
	_item533 = createVehicle ["Land_MRP_O2_Kdo",[7756.45,4578.45,0.110038],[],0,"CAN_COLLIDE"];
	_this = _item533;
	_objects pushback _this;
	_objectIDs pushback 533;
	_this setPosWorld [7756.45,4578.45,14.1528];
	_this setVectorDirAndUp [[-0.445372,0.895346,0],[0,0,1]];
};

private _item534 = objNull;
if (_layerRoot) then {
	_item534 = createVehicle ["Land_MRP_O2_Gros_Kdo",[7756.56,4577.17,0.110038],[],0,"CAN_COLLIDE"];
	_this = _item534;
	_objects pushback _this;
	_objectIDs pushback 534;
	_this setPosWorld [7756.56,4577.17,14.3612];
	_this setVectorDirAndUp [[0.970508,0.241068,0],[0,0,1]];
};

private _item535 = objNull;
if (_layerRoot) then {
	_item535 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[7756.31,4576.68,0.110038],[],0,"CAN_COLLIDE"];
	_this = _item535;
	_objects pushback _this;
	_objectIDs pushback 535;
	_this setPosWorld [7756.31,4576.68,14.1528];
	_this setVectorDirAndUp [[-0.263601,0.964632,0],[0,0,1]];
};

private _item536 = objNull;
if (_layerRoot) then {
	_item536 = createVehicle ["Land_MRP_O2_Kdo_Vert",[7756.82,4577.6,0.110038],[],0,"CAN_COLLIDE"];
	_this = _item536;
	_objects pushback _this;
	_objectIDs pushback 536;
	_this setPosWorld [7756.82,4577.6,14.1528];
	_this setVectorDirAndUp [[0.789415,0.61386,0],[0,0,1]];
};

private _item537 = objNull;
if (_layerRoot) then {
	_item537 = createVehicle ["Land_MRP_O2_Kdo_Rose",[7756.06,4578.63,0.110038],[],0,"CAN_COLLIDE"];
	_this = _item537;
	_objects pushback _this;
	_objectIDs pushback 537;
	_this setPosWorld [7756.06,4578.63,14.1528];
	_this setVectorDirAndUp [[0.970508,0.241068,0],[0,0,1]];
};

private _item538 = objNull;
if (_layerRoot) then {
	_item538 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[7753.9,4579.39,0.205438],[],0,"CAN_COLLIDE"];
	_this = _item538;
	_objects pushback _this;
	_objectIDs pushback 538;
	_this setPosWorld [7753.9,4579.39,14.4566];
	_this setVectorDirAndUp [[0.970508,0.241068,0],[0,0,1]];
};

private _item539 = objNull;
if (_layerRoot) then {
	_item539 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[7754.4,4579.74,0.110038],[],0,"CAN_COLLIDE"];
	_this = _item539;
	_objects pushback _this;
	_objectIDs pushback 539;
	_this setPosWorld [7754.4,4579.74,14.1528];
	_this setVectorDirAndUp [[0.246901,-0.969041,0],[0,0,1]];
};

private _item540 = objNull;
if (_layerRoot) then {
	_item540 = createVehicle ["Land_MRP_O2_Kdo",[7754.8,4579.97,0.110038],[],0,"CAN_COLLIDE"];
	_this = _item540;
	_objects pushback _this;
	_objectIDs pushback 540;
	_this setPosWorld [7754.8,4579.97,14.1528];
	_this setVectorDirAndUp [[0.970508,0.241068,0],[0,0,1]];
};

private _item541 = objNull;
if (_layerRoot) then {
	_item541 = createVehicle ["Land_MRP_O2_Kdo_Rose",[7754.03,4579.99,0.110038],[],0,"CAN_COLLIDE"];
	_this = _item541;
	_objects pushback _this;
	_objectIDs pushback 541;
	_this setPosWorld [7754.03,4579.99,14.1528];
	_this setVectorDirAndUp [[0.605761,-0.795646,0],[0,0,1]];
};

private _item542 = objNull;
if (_layerRoot) then {
	_item542 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[7754.25,4577.55,0.222037],[],0,"CAN_COLLIDE"];
	_this = _item542;
	_objects pushback _this;
	_objectIDs pushback 542;
	_this setPosWorld [7754.25,4577.55,14.2648];
	_this setVectorDirAndUp [[0.970508,0.241068,0],[0,0,1]];
};

private _item543 = objNull;
if (_layerRoot) then {
	_item543 = createVehicle ["Land_MRP_O2_Kdo_Vert",[7754.56,4577.19,0.222037],[],0,"CAN_COLLIDE"];
	_this = _item543;
	_objects pushback _this;
	_objectIDs pushback 543;
	_this setPosWorld [7754.56,4577.19,14.2648];
	_this setVectorDirAndUp [[0.300625,-0.953742,0],[0,0,1]];
};

private _item544 = objNull;
if (_layerRoot) then {
	_item544 = createVehicle ["Land_O2_Sapin_Noel_anim",[8036.12,6411.75,0.806649],[],0,"CAN_COLLIDE"];
	_this = _item544;
	_objects pushback _this;
	_objectIDs pushback 544;
	_this setPosWorld [8036.12,6411.75,17.4188];
	_this setVectorDirAndUp [[-0.150924,-0.988545,0],[0,0,1]];
};

private _item545 = objNull;
if (_layerRoot) then {
	_item545 = createVehicle ["Land_Bare_boulder_02_F",[8036.03,6411.95,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item545;
	_objects pushback _this;
	_objectIDs pushback 545;
	_this setPosWorld [8036.03,6411.95,13.3115];
	_this setVectorDirAndUp [[-0.150924,-0.988545,0],[0,0,1]];
};

private _item546 = objNull;
if (_layerRoot) then {
	_item546 = createVehicle ["Land_MRP_O2_Kdo",[8036.13,6410.5,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item546;
	_objects pushback _this;
	_objectIDs pushback 546;
	_this setPosWorld [8036.13,6410.5,13.4479];
	_this setVectorDirAndUp [[0.997782,0.0665706,0],[0,0,1]];
};

private _item547 = objNull;
if (_layerRoot) then {
	_item547 = createVehicle ["Land_MRP_O2_Gros_Kdo",[8034.91,6410.9,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item547;
	_objects pushback _this;
	_objectIDs pushback 547;
	_this setPosWorld [8034.91,6410.9,13.6563];
	_this setVectorDirAndUp [[-0.150924,-0.988545,0],[0,0,1]];
};

private _item548 = objNull;
if (_layerRoot) then {
	_item548 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8034.56,6411.31,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item548;
	_objects pushback _this;
	_objectIDs pushback 548;
	_this setPosWorld [8034.56,6411.31,13.4479];
	_this setVectorDirAndUp [[0.991792,-0.127865,0],[0,0,1]];
};

private _item549 = objNull;
if (_layerRoot) then {
	_item549 = createVehicle ["Land_MRP_O2_Kdo_Vert",[8035.21,6410.49,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item549;
	_objects pushback _this;
	_objectIDs pushback 549;
	_this setPosWorld [8035.21,6410.49,13.4479];
	_this setVectorDirAndUp [[0.262847,-0.964837,0],[0,0,1]];
};

private _item550 = objNull;
if (_layerRoot) then {
	_item550 = createVehicle ["Land_MRP_O2_Kdo_Rose",[8036.46,6410.8,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item550;
	_objects pushback _this;
	_objectIDs pushback 550;
	_this setPosWorld [8036.46,6410.8,13.4479];
	_this setVectorDirAndUp [[-0.150924,-0.988545,0],[0,0,1]];
};

private _item551 = objNull;
if (_layerRoot) then {
	_item551 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[8037.99,6412.49,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item551;
	_objects pushback _this;
	_objectIDs pushback 551;
	_this setPosWorld [8037.99,6412.49,13.6563];
	_this setVectorDirAndUp [[-0.150924,-0.988545,0],[0,0,1]];
};

private _item552 = objNull;
if (_layerRoot) then {
	_item552 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8038.12,6411.9,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item552;
	_objects pushback _this;
	_objectIDs pushback 552;
	_this setPosWorld [8038.12,6411.9,13.4479];
	_this setVectorDirAndUp [[-0.989435,0.144976,0],[0,0,1]];
};

private _item553 = objNull;
if (_layerRoot) then {
	_item553 = createVehicle ["Land_MRP_O2_Kdo",[8038.17,6411.44,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item553;
	_objects pushback _this;
	_objectIDs pushback 553;
	_this setPosWorld [8038.17,6411.44,13.4479];
	_this setVectorDirAndUp [[-0.150924,-0.988545,0],[0,0,1]];
};

private _item554 = objNull;
if (_layerRoot) then {
	_item554 = createVehicle ["Land_MRP_O2_Kdo_Rose",[8038.49,6412.14,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item554;
	_objects pushback _this;
	_objectIDs pushback 554;
	_this setPosWorld [8038.49,6412.14,13.4479];
	_this setVectorDirAndUp [[-0.967473,-0.252974,0],[0,0,1]];
};

private _item555 = objNull;
if (_layerRoot) then {
	_item555 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8036.16,6412.88,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item555;
	_objects pushback _this;
	_objectIDs pushback 555;
	_this setPosWorld [8036.16,6412.88,13.4479];
	_this setVectorDirAndUp [[-0.150924,-0.988545,0],[0,0,1]];
};

private _item556 = objNull;
if (_layerRoot) then {
	_item556 = createVehicle ["Land_MRP_O2_Kdo_Vert",[8035.7,6412.73,0.115093],[],0,"CAN_COLLIDE"];
	_this = _item556;
	_objects pushback _this;
	_objectIDs pushback 556;
	_this setPosWorld [8035.7,6412.73,13.4479];
	_this setVectorDirAndUp [[-0.995987,0.0895016,0],[0,0,1]];
};

private _item557 = objNull;
if (_layerRoot) then {
	_item557 = createVehicle ["Land_O2_Noel_Lum_JoyFet",[8047.75,6416.76,0],[],0,"CAN_COLLIDE"];
	_this = _item557;
	_objects pushback _this;
	_objectIDs pushback 557;
	_this setPosWorld [8047.75,6416.76,16.464];
	_this setVectorDirAndUp [[0.999985,0.00555329,0],[0,0,1]];
};

private _item558 = objNull;
if (_layerRoot) then {
	_item558 = createVehicle ["Land_O2_Sapin_Noel",[3913.54,4428.67,0.111],[],0,"CAN_COLLIDE"];
	_this = _item558;
	_objects pushback _this;
	_objectIDs pushback 558;
	_this setPosWorld [3913.54,4428.67,17.1931];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item559 = objNull;
if (_layerRoot) then {
	_item559 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[3936.43,4460.68,0.111],[],0,"CAN_COLLIDE"];
	_this = _item559;
	_objects pushback _this;
	_objectIDs pushback 559;
	_this setPosWorld [3936.43,4460.68,13.9138];
	_this setVectorDirAndUp [[-0.851596,0.524198,0],[0,0,1]];
};

private _item560 = objNull;
if (_layerRoot) then {
	_item560 = createVehicle ["Land_MRP_O2_Gros_Kdo_Bleu",[3936.6,4461.18,0.111],[],0,"CAN_COLLIDE"];
	_this = _item560;
	_objects pushback _this;
	_objectIDs pushback 560;
	_this setPosWorld [3936.6,4461.18,14.1222];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item561 = objNull;
if (_layerRoot) then {
	_item561 = createVehicle ["Land_MRP_O2_Kdo",[3936.42,4461.68,0.111],[],0,"CAN_COLLIDE"];
	_this = _item561;
	_objects pushback _this;
	_objectIDs pushback 561;
	_this setPosWorld [3936.42,4461.68,13.9138];
	_this setVectorDirAndUp [[-0.980646,-0.195791,0],[0,0,1]];
};

private _item562 = objNull;
if (_layerRoot) then {
	_item562 = createVehicle ["Land_MRP_O2_Kdo_Vert",[3937.33,4465.38,3.10162],[],0,"CAN_COLLIDE"];
	_this = _item562;
	_objects pushback _this;
	_objectIDs pushback 562;
	_this setPosWorld [3937.33,4465.38,16.9044];
	_this setVectorDirAndUp [[0.848651,0.528954,0],[0,0,1]];
};

private _item563 = objNull;
if (_layerRoot) then {
	_item563 = createVehicle ["Land_O2_Sapin_Noel_anim",[3902.04,4477.94,0.691637],[],0,"CAN_COLLIDE"];
	_this = _item563;
	_objects pushback _this;
	_objectIDs pushback 563;
	_this setPosWorld [3902.04,4477.94,17.7738];
	_this setVectorDirAndUp [[-0.984008,0.178122,0],[0,0,1]];
};

private _item564 = objNull;
if (_layerRoot) then {
	_item564 = createVehicle ["Land_Bare_boulder_02_F",[3902.24,4478.03,0],[],0,"CAN_COLLIDE"];
	_this = _item564;
	_objects pushback _this;
	_objectIDs pushback 564;
	_this setPosWorld [3902.24,4478.03,13.6664];
	_this setVectorDirAndUp [[-0.984008,0.178122,0],[0,0,1]];
};

private _item565 = objNull;
if (_layerRoot) then {
	_item565 = createVehicle ["Land_MRP_O2_Kdo",[3900.78,4477.96,0],[],0,"CAN_COLLIDE"];
	_this = _item565;
	_objects pushback _this;
	_objectIDs pushback 565;
	_this setPosWorld [3900.78,4477.96,13.8028];
	_this setVectorDirAndUp [[0.0390356,-0.999238,0],[0,0,1]];
};

private _item566 = objNull;
if (_layerRoot) then {
	_item566 = createVehicle ["Land_MRP_O2_Gros_Kdo",[3901.22,4479.17,0],[],0,"CAN_COLLIDE"];
	_this = _item566;
	_objects pushback _this;
	_objectIDs pushback 566;
	_this setPosWorld [3901.22,4479.17,14.0112];
	_this setVectorDirAndUp [[-0.984008,0.178122,0],[0,0,1]];
};

private _item567 = objNull;
if (_layerRoot) then {
	_item567 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[3901.64,4479.51,0],[],0,"CAN_COLLIDE"];
	_this = _item567;
	_objects pushback _this;
	_objectIDs pushback 567;
	_this setPosWorld [3901.64,4479.51,13.8028];
	_this setVectorDirAndUp [[-0.155161,-0.987889,0],[0,0,1]];
};

private _item568 = objNull;
if (_layerRoot) then {
	_item568 = createVehicle ["Land_MRP_O2_Kdo_Vert",[3900.8,4478.89,0],[],0,"CAN_COLLIDE"];
	_this = _item568;
	_objects pushback _this;
	_objectIDs pushback 568;
	_this setPosWorld [3900.8,4478.89,13.8028];
	_this setVectorDirAndUp [[-0.971718,-0.236145,0],[0,0,1]];
};

private _item569 = objNull;
if (_layerRoot) then {
	_item569 = createVehicle ["Land_MRP_O2_Kdo_Rose",[3901.07,4477.63,0],[],0,"CAN_COLLIDE"];
	_this = _item569;
	_objects pushback _this;
	_objectIDs pushback 569;
	_this setPosWorld [3901.07,4477.63,13.8028];
	_this setVectorDirAndUp [[-0.984008,0.178122,0],[0,0,1]];
};

private _item570 = objNull;
if (_layerRoot) then {
	_item570 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[3902.72,4476.05,0],[],0,"CAN_COLLIDE"];
	_this = _item570;
	_objects pushback _this;
	_objectIDs pushback 570;
	_this setPosWorld [3902.72,4476.05,14.0112];
	_this setVectorDirAndUp [[-0.984008,0.178122,0],[0,0,1]];
};

private _item571 = objNull;
if (_layerRoot) then {
	_item571 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[3902.13,4475.94,0],[],0,"CAN_COLLIDE"];
	_this = _item571;
	_objects pushback _this;
	_objectIDs pushback 571;
	_this setPosWorld [3902.13,4475.94,13.8028];
	_this setVectorDirAndUp [[0.1722,0.985062,0],[0,0,1]];
};

private _item572 = objNull;
if (_layerRoot) then {
	_item572 = createVehicle ["Land_MRP_O2_Kdo",[3901.67,4475.9,0],[],0,"CAN_COLLIDE"];
	_this = _item572;
	_objects pushback _this;
	_objectIDs pushback 572;
	_this setPosWorld [3901.67,4475.9,13.8028];
	_this setVectorDirAndUp [[-0.984008,0.178122,0],[0,0,1]];
};

private _item573 = objNull;
if (_layerRoot) then {
	_item573 = createVehicle ["Land_MRP_O2_Kdo_Rose",[3902.36,4475.56,0],[],0,"CAN_COLLIDE"];
	_this = _item573;
	_objects pushback _this;
	_objectIDs pushback 573;
	_this setPosWorld [3902.36,4475.56,13.8028];
	_this setVectorDirAndUp [[-0.226203,0.97408,0],[0,0,1]];
};

private _item574 = objNull;
if (_layerRoot) then {
	_item574 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[3903.16,4477.87,0],[],0,"CAN_COLLIDE"];
	_this = _item574;
	_objects pushback _this;
	_objectIDs pushback 574;
	_this setPosWorld [3903.16,4477.87,13.8028];
	_this setVectorDirAndUp [[-0.984008,0.178122,0],[0,0,1]];
};

private _item575 = objNull;
if (_layerRoot) then {
	_item575 = createVehicle ["Land_MRP_O2_Kdo_Vert",[3903.03,4478.34,0],[],0,"CAN_COLLIDE"];
	_this = _item575;
	_objects pushback _this;
	_objectIDs pushback 575;
	_this setPosWorld [3903.03,4478.34,13.8028];
	_this setVectorDirAndUp [[0.116928,0.99314,0],[0,0,1]];
};

private _item576 = objNull;
if (_layerRoot) then {
	_item576 = createVehicle ["Land_MRP_O2_Kdo",[3936.54,4474.2,1.66946],[],0,"CAN_COLLIDE"];
	_this = _item576;
	_objects pushback _this;
	_objectIDs pushback 576;
	_this setPosWorld [3936.54,4474.2,15.4722];
	_this setVectorDirAndUp [[0.71135,-0.702838,0],[0,0,1]];
};

private _item577 = objNull;
if (_layerRoot) then {
	_item577 = createVehicle ["Land_O2_Sapin_Noel_anim",[8744.96,2966.46,0.691616],[],0,"CAN_COLLIDE"];
	_this = _item577;
	_objects pushback _this;
	_objectIDs pushback 577;
	_this setPosWorld [8744.96,2966.46,18.5137];
	_this setVectorDirAndUp [[-0.0376096,0.999292,0],[0,0,1]];
};

private _item578 = objNull;
if (_layerRoot) then {
	_item578 = createVehicle ["Land_Bare_boulder_02_F",[8745.08,2966.27,0],[],0,"CAN_COLLIDE"];
	_this = _item578;
	_objects pushback _this;
	_objectIDs pushback 578;
	_this setPosWorld [8745.08,2966.27,14.4064];
	_this setVectorDirAndUp [[-0.0376096,0.999292,0],[0,0,1]];
};

private _item579 = objNull;
if (_layerRoot) then {
	_item579 = createVehicle ["Land_MRP_O2_Kdo",[8744.7,2967.68,0],[],0,"CAN_COLLIDE"];
	_this = _item579;
	_objects pushback _this;
	_objectIDs pushback 579;
	_this setPosWorld [8744.7,2967.68,14.5428];
	_this setVectorDirAndUp [[-0.967476,-0.252963,0],[0,0,1]];
};

private _item580 = objNull;
if (_layerRoot) then {
	_item580 = createVehicle ["Land_MRP_O2_Gros_Kdo",[8745.98,2967.52,0],[],0,"CAN_COLLIDE"];
	_this = _item580;
	_objects pushback _this;
	_objectIDs pushback 580;
	_this setPosWorld [8745.98,2967.52,14.7512];
	_this setVectorDirAndUp [[-0.0376096,0.999292,0],[0,0,1]];
};

private _item581 = objNull;
if (_layerRoot) then {
	_item581 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8746.4,2967.18,0],[],0,"CAN_COLLIDE"];
	_this = _item581;
	_objects pushback _this;
	_objectIDs pushback 581;
	_this setPosWorld [8746.4,2967.18,14.5428];
	_this setVectorDirAndUp [[-0.998146,-0.0608683,0],[0,0,1]];
};

private _item582 = objNull;
if (_layerRoot) then {
	_item582 = createVehicle ["Land_MRP_O2_Kdo_Vert",[8745.61,2967.87,0],[],0,"CAN_COLLIDE"];
	_this = _item582;
	_objects pushback _this;
	_objectIDs pushback 582;
	_this setPosWorld [8745.61,2967.87,14.5428];
	_this setVectorDirAndUp [[-0.439546,0.89822,0],[0,0,1]];
};

private _item583 = objNull;
if (_layerRoot) then {
	_item583 = createVehicle ["Land_MRP_O2_Kdo_Rose",[8744.44,2967.33,0],[],0,"CAN_COLLIDE"];
	_this = _item583;
	_objects pushback _this;
	_objectIDs pushback 583;
	_this setPosWorld [8744.44,2967.33,14.5428];
	_this setVectorDirAndUp [[-0.0376096,0.999292,0],[0,0,1]];
};

private _item584 = objNull;
if (_layerRoot) then {
	_item584 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[8743.26,2965.38,0],[],0,"CAN_COLLIDE"];
	_this = _item584;
	_objects pushback _this;
	_objectIDs pushback 584;
	_this setPosWorld [8743.26,2965.38,14.7512];
	_this setVectorDirAndUp [[-0.0376096,0.999292,0],[0,0,1]];
};

private _item585 = objNull;
if (_layerRoot) then {
	_item585 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8743.01,2965.93,0],[],0,"CAN_COLLIDE"];
	_this = _item585;
	_objects pushback _this;
	_objectIDs pushback 585;
	_this setPosWorld [8743.01,2965.93,14.5428];
	_this setVectorDirAndUp [[0.999048,0.04362,0],[0,0,1]];
};

private _item586 = objNull;
if (_layerRoot) then {
	_item586 = createVehicle ["Land_MRP_O2_Kdo",[8742.88,2966.38,0],[],0,"CAN_COLLIDE"];
	_this = _item586;
	_objects pushback _this;
	_objectIDs pushback 586;
	_this setPosWorld [8742.88,2966.38,14.5428];
	_this setVectorDirAndUp [[-0.0376096,0.999292,0],[0,0,1]];
};

private _item587 = objNull;
if (_layerRoot) then {
	_item587 = createVehicle ["Land_MRP_O2_Kdo_Rose",[8742.7,2965.63,0],[],0,"CAN_COLLIDE"];
	_this = _item587;
	_objects pushback _this;
	_objectIDs pushback 587;
	_this setPosWorld [8742.7,2965.63,14.5428];
	_this setVectorDirAndUp [[0.902665,0.430345,0],[0,0,1]];
};

private _item588 = objNull;
if (_layerRoot) then {
	_item588 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8745.13,2965.34,0],[],0,"CAN_COLLIDE"];
	_this = _item588;
	_objects pushback _this;
	_objectIDs pushback 588;
	_this setPosWorld [8745.13,2965.34,14.5428];
	_this setVectorDirAndUp [[-0.0376096,0.999292,0],[0,0,1]];
};

private _item589 = objNull;
if (_layerRoot) then {
	_item589 = createVehicle ["Land_MRP_O2_Kdo_Vert",[8745.55,2965.57,0],[],0,"CAN_COLLIDE"];
	_this = _item589;
	_objects pushback _this;
	_objectIDs pushback 589;
	_this setPosWorld [8745.55,2965.57,14.5428];
	_this setVectorDirAndUp [[0.995054,0.0993365,0],[0,0,1]];
};

private _item590 = objNull;
if (_layerRoot) then {
	_item590 = createVehicle ["Land_O2_Sapin_Noel_anim",[6972.91,3701.53,0.812155],[],0,"CAN_COLLIDE"];
	_this = _item590;
	_objects pushback _this;
	_objectIDs pushback 590;
	_this setPosWorld [6972.91,3701.53,21.7343];
	_this setVectorDirAndUp [[-0.421632,-0.906767,0],[0,0,1]];
};

private _item591 = objNull;
if (_layerRoot) then {
	_item591 = createVehicle ["Land_Bare_boulder_02_F",[6972.88,3701.75,0.120537],[],0,"CAN_COLLIDE"];
	_this = _item591;
	_objects pushback _this;
	_objectIDs pushback 591;
	_this setPosWorld [6972.88,3701.75,17.627];
	_this setVectorDirAndUp [[-0.544337,-0.838866,0],[0,0,1]];
};

private _item592 = objNull;
if (_layerRoot) then {
	_item592 = createVehicle ["Land_MRP_O2_Kdo",[6972.58,3700.32,0.120537],[],0,"CAN_COLLIDE"];
	_this = _item592;
	_objects pushback _this;
	_objectIDs pushback 592;
	_this setPosWorld [6972.58,3700.32,17.7633];
	_this setVectorDirAndUp [[0.976522,-0.215419,0],[0,0,1]];
};

private _item593 = objNull;
if (_layerRoot) then {
	_item593 = createVehicle ["Land_MRP_O2_Gros_Kdo",[6971.51,3701.04,0.120537],[],0,"CAN_COLLIDE"];
	_this = _item593;
	_objects pushback _this;
	_objectIDs pushback 593;
	_this setPosWorld [6971.51,3701.04,17.9717];
	_this setVectorDirAndUp [[-0.421632,-0.906767,0],[0,0,1]];
};

private _item594 = objNull;
if (_layerRoot) then {
	_item594 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6971.29,3701.54,0.147892],[],0,"CAN_COLLIDE"];
	_this = _item594;
	_objects pushback _this;
	_objectIDs pushback 594;
	_this setPosWorld [6971.29,3701.54,17.7907];
	_this setVectorDirAndUp [[0.916339,-0.400403,0],[0,0,1]];
};

private _item595 = objNull;
if (_layerRoot) then {
	_item595 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6971.68,3700.57,0.120537],[],0,"CAN_COLLIDE"];
	_this = _item595;
	_objects pushback _this;
	_objectIDs pushback 595;
	_this setPosWorld [6971.68,3700.57,17.7633];
	_this setVectorDirAndUp [[-0.0177683,-0.999842,0],[0,0,1]];
};

private _item596 = objNull;
if (_layerRoot) then {
	_item596 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6972.97,3700.51,0.120537],[],0,"CAN_COLLIDE"];
	_this = _item596;
	_objects pushback _this;
	_objectIDs pushback 596;
	_this setPosWorld [6972.97,3700.51,17.7633];
	_this setVectorDirAndUp [[-0.421632,-0.906767,0],[0,0,1]];
};

private _item597 = objNull;
if (_layerRoot) then {
	_item597 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[6974.91,3701.71,0.120537],[],0,"CAN_COLLIDE"];
	_this = _item597;
	_objects pushback _this;
	_objectIDs pushback 597;
	_this setPosWorld [6974.91,3701.71,17.9717];
	_this setVectorDirAndUp [[-0.421632,-0.906767,0],[0,0,1]];
};

private _item598 = objNull;
if (_layerRoot) then {
	_item598 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6974.88,3701.11,0.120537],[],0,"CAN_COLLIDE"];
	_this = _item598;
	_objects pushback _this;
	_objectIDs pushback 598;
	_this setPosWorld [6974.88,3701.11,17.7633];
	_this setVectorDirAndUp [[-0.909287,0.41617,0],[0,0,1]];
};

private _item599 = objNull;
if (_layerRoot) then {
	_item599 = createVehicle ["Land_MRP_O2_Kdo",[6974.8,3700.65,0.120537],[],0,"CAN_COLLIDE"];
	_this = _item599;
	_objects pushback _this;
	_objectIDs pushback 599;
	_this setPosWorld [6974.8,3700.65,17.7633];
	_this setVectorDirAndUp [[-0.421632,-0.906767,0],[0,0,1]];
};

private _item600 = objNull;
if (_layerRoot) then {
	_item600 = createVehicle ["Land_MRP_O2_Kdo_Rose",[6975.3,3701.23,0.120537],[],0,"CAN_COLLIDE"];
	_this = _item600;
	_objects pushback _this;
	_objectIDs pushback 600;
	_this setPosWorld [6975.3,3701.23,17.7633];
	_this setVectorDirAndUp [[-0.999608,0.0279848,0],[0,0,1]];
};

private _item601 = objNull;
if (_layerRoot) then {
	_item601 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[6973.27,3702.6,0.241074],[],0,"CAN_COLLIDE"];
	_this = _item601;
	_objects pushback _this;
	_objectIDs pushback 601;
	_this setPosWorld [6973.27,3702.6,17.8839];
	_this setVectorDirAndUp [[-0.421632,-0.906767,0],[0,0,1]];
};

private _item602 = objNull;
if (_layerRoot) then {
	_item602 = createVehicle ["Land_MRP_O2_Kdo_Vert",[6972.78,3702.59,0.241074],[],0,"CAN_COLLIDE"];
	_this = _item602;
	_objects pushback _this;
	_objectIDs pushback 602;
	_this setPosWorld [6972.78,3702.59,17.8839];
	_this setVectorDirAndUp [[-0.931106,0.364748,0],[0,0,1]];
};

private _item603 = objNull;
if (_layerRoot) then {
	_item603 = createVehicle ["Land_O2_Sapin_Noel_anim",[5403.17,2076.59,0.691616],[],0,"CAN_COLLIDE"];
	_this = _item603;
	_objects pushback _this;
	_objectIDs pushback 603;
	_this setPosWorld [5403.17,2076.59,6.13374];
	_this setVectorDirAndUp [[0.193256,-0.981148,0],[0,0,1]];
};

private _item604 = objNull;
if (_layerRoot) then {
	_item604 = createVehicle ["Land_Bare_boulder_02_F",[5403.01,2076.75,0],[],0,"CAN_COLLIDE"];
	_this = _item604;
	_objects pushback _this;
	_objectIDs pushback 604;
	_this setPosWorld [5403.01,2076.75,2.02643];
	_this setVectorDirAndUp [[0.193256,-0.981148,0],[0,0,1]];
};

private _item605 = objNull;
if (_layerRoot) then {
	_item605 = createVehicle ["Land_MRP_O2_Kdo",[5403.61,2075.41,0],[],0,"CAN_COLLIDE"];
	_this = _item605;
	_objects pushback _this;
	_objectIDs pushback 605;
	_this setPosWorld [5403.61,2075.41,2.16278];
	_this setVectorDirAndUp [[0.91608,0.400995,0],[0,0,1]];
};

private _item606 = objNull;
if (_layerRoot) then {
	_item606 = createVehicle ["Land_MRP_O2_Gros_Kdo",[5402.32,2075.37,-2.38419e-07],[],0,"CAN_COLLIDE"];
	_this = _item606;
	_objects pushback _this;
	_objectIDs pushback 606;
	_this setPosWorld [5402.32,2075.37,2.37118];
	_this setVectorDirAndUp [[0.193256,-0.981148,0],[0,0,1]];
};

private _item607 = objNull;
if (_layerRoot) then {
	_item607 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5401.85,2075.64,0],[],0,"CAN_COLLIDE"];
	_this = _item607;
	_objects pushback _this;
	_objectIDs pushback 607;
	_this setPosWorld [5401.85,2075.64,2.16278];
	_this setVectorDirAndUp [[0.976382,0.21605,0],[0,0,1]];
};

private _item608 = objNull;
if (_layerRoot) then {
	_item608 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5402.74,2075.09,0],[],0,"CAN_COLLIDE"];
	_this = _item608;
	_objects pushback _this;
	_objectIDs pushback 608;
	_this setPosWorld [5402.74,2075.09,2.16278];
	_this setVectorDirAndUp [[0.574469,-0.818526,0],[0,0,1]];
};

private _item609 = objNull;
if (_layerRoot) then {
	_item609 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5403.81,2075.8,0],[],0,"CAN_COLLIDE"];
	_this = _item609;
	_objects pushback _this;
	_objectIDs pushback 609;
	_this setPosWorld [5403.81,2075.8,2.16278];
	_this setVectorDirAndUp [[0.193256,-0.981148,0],[0,0,1]];
};

private _item610 = objNull;
if (_layerRoot) then {
	_item610 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[5404.67,2077.92,-2.38419e-07],[],0,"CAN_COLLIDE"];
	_this = _item610;
	_objects pushback _this;
	_objectIDs pushback 610;
	_this setPosWorld [5404.67,2077.92,2.37118];
	_this setVectorDirAndUp [[0.193256,-0.981148,0],[0,0,1]];
};

private _item611 = objNull;
if (_layerRoot) then {
	_item611 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5405,2077.41,0],[],0,"CAN_COLLIDE"];
	_this = _item611;
	_objects pushback _this;
	_objectIDs pushback 611;
	_this setPosWorld [5405,2077.41,2.16278];
	_this setVectorDirAndUp [[-0.979968,-0.199155,0],[0,0,1]];
};

private _item612 = objNull;
if (_layerRoot) then {
	_item612 = createVehicle ["Land_MRP_O2_Kdo",[5405.21,2076.99,0],[],0,"CAN_COLLIDE"];
	_this = _item612;
	_objects pushback _this;
	_objectIDs pushback 612;
	_this setPosWorld [5405.21,2076.99,2.16278];
	_this setVectorDirAndUp [[0.193256,-0.981148,0],[0,0,1]];
};

private _item613 = objNull;
if (_layerRoot) then {
	_item613 = createVehicle ["Land_MRP_O2_Kdo_Rose",[5405.27,2077.75,0],[],0,"CAN_COLLIDE"];
	_this = _item613;
	_objects pushback _this;
	_objectIDs pushback 613;
	_this setPosWorld [5405.27,2077.75,2.16278];
	_this setVectorDirAndUp [[-0.824354,-0.566074,0],[0,0,1]];
};

private _item614 = objNull;
if (_layerRoot) then {
	_item614 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[5402.82,2077.66,0],[],0,"CAN_COLLIDE"];
	_this = _item614;
	_objects pushback _this;
	_objectIDs pushback 614;
	_this setPosWorld [5402.82,2077.66,2.16278];
	_this setVectorDirAndUp [[0.193256,-0.981148,0],[0,0,1]];
};

private _item615 = objNull;
if (_layerRoot) then {
	_item615 = createVehicle ["Land_MRP_O2_Kdo_Vert",[5402.44,2077.37,0],[],0,"CAN_COLLIDE"];
	_this = _item615;
	_objects pushback _this;
	_objectIDs pushback 615;
	_this setPosWorld [5402.44,2077.37,2.16278];
	_this setVectorDirAndUp [[-0.967319,-0.253563,0],[0,0,1]];
};

private _item616 = objNull;
if (_layerRoot) then {
	_item616 = createVehicle ["Land_O2_Sapin_Noel_anim",[2287.07,8070.64,0.691636],[],0,"CAN_COLLIDE"];
	_this = _item616;
	_objects pushback _this;
	_objectIDs pushback 616;
	_this setPosWorld [2287.07,8070.64,18.8938];
	_this setVectorDirAndUp [[-0.999183,0.0404214,0],[0,0,1]];
};

private _item617 = objNull;
if (_layerRoot) then {
	_item617 = createVehicle ["Land_Bare_boulder_02_F",[2287.27,8070.75,0],[],0,"CAN_COLLIDE"];
	_this = _item617;
	_objects pushback _this;
	_objectIDs pushback 617;
	_this setPosWorld [2287.27,8070.75,14.7864];
	_this setVectorDirAndUp [[-0.999183,0.0404214,0],[0,0,1]];
};

private _item618 = objNull;
if (_layerRoot) then {
	_item618 = createVehicle ["Land_MRP_O2_Kdo",[2285.83,8070.48,0],[],0,"CAN_COLLIDE"];
	_this = _item618;
	_objects pushback _this;
	_objectIDs pushback 618;
	_this setPosWorld [2285.83,8070.48,14.9228];
	_this setVectorDirAndUp [[0.176757,-0.984255,0],[0,0,1]];
};

private _item619 = objNull;
if (_layerRoot) then {
	_item619 = createVehicle ["Land_MRP_O2_Gros_Kdo",[2286.09,8071.74,0],[],0,"CAN_COLLIDE"];
	_this = _item619;
	_objects pushback _this;
	_objectIDs pushback 619;
	_this setPosWorld [2286.09,8071.74,15.1312];
	_this setVectorDirAndUp [[-0.999183,0.0404214,0],[0,0,1]];
};

private _item620 = objNull;
if (_layerRoot) then {
	_item620 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[2286.46,8072.14,0],[],0,"CAN_COLLIDE"];
	_this = _item620;
	_objects pushback _this;
	_objectIDs pushback 620;
	_this setPosWorld [2286.46,8072.14,14.9228];
	_this setVectorDirAndUp [[-0.0171446,-0.999853,0],[0,0,1]];
};

private _item621 = objNull;
if (_layerRoot) then {
	_item621 = createVehicle ["Land_MRP_O2_Kdo_Vert",[2285.72,8071.4,0],[],0,"CAN_COLLIDE"];
	_this = _item621;
	_objects pushback _this;
	_objectIDs pushback 621;
	_this setPosWorld [2285.72,8071.4,14.9228];
	_this setVectorDirAndUp [[-0.929757,-0.368173,0],[0,0,1]];
};

private _item622 = objNull;
if (_layerRoot) then {
	_item622 = createVehicle ["Land_MRP_O2_Kdo_Rose",[2286.16,8070.19,0],[],0,"CAN_COLLIDE"];
	_this = _item622;
	_objects pushback _this;
	_objectIDs pushback 622;
	_this setPosWorld [2286.16,8070.19,14.9228];
	_this setVectorDirAndUp [[-0.999183,0.0404214,0],[0,0,1]];
};

private _item623 = objNull;
if (_layerRoot) then {
	_item623 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[2288.02,8068.86,0],[],0,"CAN_COLLIDE"];
	_this = _item623;
	_objects pushback _this;
	_objectIDs pushback 623;
	_this setPosWorld [2288.02,8068.86,15.1312];
	_this setVectorDirAndUp [[-0.999183,0.0404214,0],[0,0,1]];
};

private _item624 = objNull;
if (_layerRoot) then {
	_item624 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[2287.44,8068.66,0],[],0,"CAN_COLLIDE"];
	_this = _item624;
	_objects pushback _this;
	_objectIDs pushback 624;
	_this setPosWorld [2287.44,8068.66,14.9228];
	_this setVectorDirAndUp [[0.0344105,0.999408,0],[0,0,1]];
};

private _item625 = objNull;
if (_layerRoot) then {
	_item625 = createVehicle ["Land_MRP_O2_Kdo",[2286.99,8068.56,0],[],0,"CAN_COLLIDE"];
	_this = _item625;
	_objects pushback _this;
	_objectIDs pushback 625;
	_this setPosWorld [2286.99,8068.56,14.9228];
	_this setVectorDirAndUp [[-0.999183,0.0404214,0],[0,0,1]];
};

private _item626 = objNull;
if (_layerRoot) then {
	_item626 = createVehicle ["Land_MRP_O2_Kdo_Rose",[2287.72,8068.32,0],[],0,"CAN_COLLIDE"];
	_this = _item626;
	_objects pushback _this;
	_objectIDs pushback 626;
	_this setPosWorld [2287.72,8068.32,14.9228];
	_this setVectorDirAndUp [[-0.358652,0.933471,0],[0,0,1]];
};

private _item627 = objNull;
if (_layerRoot) then {
	_item627 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[2288.2,8070.72,0],[],0,"CAN_COLLIDE"];
	_this = _item627;
	_objects pushback _this;
	_objectIDs pushback 627;
	_this setPosWorld [2288.2,8070.72,14.9228];
	_this setVectorDirAndUp [[-0.999183,0.0404214,0],[0,0,1]];
};

private _item628 = objNull;
if (_layerRoot) then {
	_item628 = createVehicle ["Land_MRP_O2_Kdo_Vert",[2288,8071.16,0],[],0,"CAN_COLLIDE"];
	_this = _item628;
	_objects pushback _this;
	_objectIDs pushback 628;
	_this setPosWorld [2288,8071.16,14.9228];
	_this setVectorDirAndUp [[-0.0214477,0.99977,0],[0,0,1]];
};

private _item629 = objNull;
if (_layerRoot) then {
	_item629 = createVehicle ["Land_O2_Sapin_Noel_anim",[8913.78,415.072,0.79398],[],0,"CAN_COLLIDE"];
	_this = _item629;
	_objects pushback _this;
	_objectIDs pushback 629;
	_this setPosWorld [8913.78,415.072,18.7261];
	_this setVectorDirAndUp [[0.823925,-0.566699,0],[0,0,1]];
};

private _item630 = objNull;
if (_layerRoot) then {
	_item630 = createVehicle ["Land_Bare_boulder_02_F",[8913.56,415.08,0.0568533],[],0,"CAN_COLLIDE"];
	_this = _item630;
	_objects pushback _this;
	_objectIDs pushback 630;
	_this setPosWorld [8913.56,415.08,14.5733];
	_this setVectorDirAndUp [[0.823969,-0.566599,0.00633733],[-0.010608,-0.00424247,0.999935]];
};

private _item631 = objNull;
if (_layerRoot) then {
	_item631 = createVehicle ["Land_MRP_O2_Kdo",[8914.91,414.542,0.0445337],[],0,"CAN_COLLIDE"];
	_this = _item631;
	_objects pushback _this;
	_objectIDs pushback 631;
	_this setPosWorld [8914.91,414.542,14.6973];
	_this setVectorDirAndUp [[0.374976,0.927035,0],[0,0,1]];
};

private _item632 = objNull;
if (_layerRoot) then {
	_item632 = createVehicle ["Land_MRP_O2_Gros_Kdo",[8914.02,413.614,0.0283308],[],0,"CAN_COLLIDE"];
	_this = _item632;
	_objects pushback _this;
	_objectIDs pushback 632;
	_this setPosWorld [8914.02,413.614,14.8895];
	_this setVectorDirAndUp [[0.823925,-0.566699,0],[0,0,1]];
};

private _item633 = objNull;
if (_layerRoot) then {
	_item633 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8913.49,413.478,0.0229568],[],0,"CAN_COLLIDE"];
	_this = _item633;
	_objects pushback _this;
	_objectIDs pushback 633;
	_this setPosWorld [8913.49,413.478,14.6757];
	_this setVectorDirAndUp [[0.54736,0.836897,0],[0,0,1]];
};

private _item634 = objNull;
if (_layerRoot) then {
	_item634 = createVehicle ["Land_MRP_O2_Kdo_Vert",[8914.52,413.702,0.0325613],[],0,"CAN_COLLIDE"];
	_this = _item634;
	_objects pushback _this;
	_objectIDs pushback 634;
	_this setPosWorld [8914.52,413.702,14.6853];
	_this setVectorDirAndUp [[0.982933,-0.183965,0],[0,0,1]];
};

private _item635 = objNull;
if (_layerRoot) then {
	_item635 = createVehicle ["Land_MRP_O2_Kdo_Rose",[8914.78,414.96,0.0489759],[],0,"CAN_COLLIDE"];
	_this = _item635;
	_objects pushback _this;
	_objectIDs pushback 635;
	_this setPosWorld [8914.78,414.96,14.7018];
	_this setVectorDirAndUp [[0.823925,-0.566699,0],[0,0,1]];
};

private _item636 = objNull;
if (_layerRoot) then {
	_item636 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[8913.93,417.077,0.0731058],[],0,"CAN_COLLIDE"];
	_this = _item636;
	_objects pushback _this;
	_objectIDs pushback 636;
	_this setPosWorld [8913.93,417.077,14.9343];
	_this setVectorDirAndUp [[0.823925,-0.566699,0],[0,0,1]];
};

private _item637 = objNull;
if (_layerRoot) then {
	_item637 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8914.52,416.94,0.0672665],[],0,"CAN_COLLIDE"];
	_this = _item637;
	_objects pushback _this;
	_objectIDs pushback 637;
	_this setPosWorld [8914.52,416.94,14.72];
	_this setVectorDirAndUp [[-0.561733,-0.827319,0],[0,0,1]];
};

private _item638 = objNull;
if (_layerRoot) then {
	_item638 = createVehicle ["Land_MRP_O2_Kdo",[8914.96,416.786,0.0624971],[],0,"CAN_COLLIDE"];
	_this = _item638;
	_objects pushback _this;
	_objectIDs pushback 638;
	_this setPosWorld [8914.96,416.786,14.7153];
	_this setVectorDirAndUp [[0.823925,-0.566699,0],[0,0,1]];
};

private _item639 = objNull;
if (_layerRoot) then {
	_item639 = createVehicle ["Land_MRP_O2_Kdo_Rose",[8914.46,417.375,0.0712471],[],0,"CAN_COLLIDE"];
	_this = _item639;
	_objects pushback _this;
	_objectIDs pushback 639;
	_this setPosWorld [8914.46,417.375,14.724];
	_this setVectorDirAndUp [[-0.194,-0.981002,0],[0,0,1]];
};

private _item640 = objNull;
if (_layerRoot) then {
	_item640 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[8912.78,415.601,0.0640478],[],0,"CAN_COLLIDE"];
	_this = _item640;
	_objects pushback _this;
	_objectIDs pushback 640;
	_this setPosWorld [8912.78,415.601,14.7168];
	_this setVectorDirAndUp [[0.823925,-0.566699,0],[0,0,1]];
};

private _item641 = objNull;
if (_layerRoot) then {
	_item641 = createVehicle ["Land_MRP_O2_Kdo_Vert",[8912.71,415.121,0.0536604],[],0,"CAN_COLLIDE"];
	_this = _item641;
	_objects pushback _this;
	_objectIDs pushback 641;
	_this setPosWorld [8912.71,415.121,14.7064];
	_this setVectorDirAndUp [[-0.514661,-0.857394,0],[0,0,1]];
};

private _item642 = objNull;
if (_layerRoot) then {
	_item642 = createVehicle ["Land_O2_Sapin_Noel_anim",[1834.51,9988.53,0.801754],[],0,"CAN_COLLIDE"];
	_this = _item642;
	_objects pushback _this;
	_objectIDs pushback 642;
	_this setPosWorld [1834.51,9988.53,18.8939];
	_this setVectorDirAndUp [[0.248351,0.96867,0],[0,0,1]];
};

private _item643 = objNull;
if (_layerRoot) then {
	_item643 = createVehicle ["Land_Bare_boulder_02_F",[1834.58,9988.32,0.11],[],0,"CAN_COLLIDE"];
	_this = _item643;
	_objects pushback _this;
	_objectIDs pushback 643;
	_this setPosWorld [1834.58,9988.32,14.7864];
	_this setVectorDirAndUp [[0.248351,0.96867,0],[0,0,1]];
};

private _item644 = objNull;
if (_layerRoot) then {
	_item644 = createVehicle ["Land_MRP_O2_Kdo",[1834.62,9989.78,0.11019],[],0,"CAN_COLLIDE"];
	_this = _item644;
	_objects pushback _this;
	_objectIDs pushback 644;
	_this setPosWorld [1834.62,9989.78,14.923];
	_this setVectorDirAndUp [[-0.99946,0.0328487,0],[0,0,1]];
};

private _item645 = objNull;
if (_layerRoot) then {
	_item645 = createVehicle ["Land_MRP_O2_Gros_Kdo",[1835.8,9989.26,0.11019],[],0,"CAN_COLLIDE"];
	_this = _item645;
	_objects pushback _this;
	_objectIDs pushback 645;
	_this setPosWorld [1835.8,9989.26,15.1314];
	_this setVectorDirAndUp [[0.248351,0.96867,0],[0,0,1]];
};

private _item646 = objNull;
if (_layerRoot) then {
	_item646 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1836.11,9988.81,0.11019],[],0,"CAN_COLLIDE"];
	_this = _item646;
	_objects pushback _this;
	_objectIDs pushback 646;
	_this setPosWorld [1836.11,9988.81,14.923];
	_this setVectorDirAndUp [[-0.97419,0.225728,0],[0,0,1]];
};

private _item647 = objNull;
if (_layerRoot) then {
	_item647 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1835.54,9989.7,0.11019],[],0,"CAN_COLLIDE"];
	_this = _item647;
	_objects pushback _this;
	_objectIDs pushback 647;
	_this setPosWorld [1835.54,9989.7,14.923];
	_this setVectorDirAndUp [[-0.165729,0.986171,0],[0,0,1]];
};

private _item648 = objNull;
if (_layerRoot) then {
	_item648 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1834.27,9989.51,0.11],[],0,"CAN_COLLIDE"];
	_this = _item648;
	_objects pushback _this;
	_objectIDs pushback 648;
	_this setPosWorld [1834.27,9989.51,14.9228];
	_this setVectorDirAndUp [[0.248351,0.96867,0],[0,0,1]];
};

private _item649 = objNull;
if (_layerRoot) then {
	_item649 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[1832.58,9987.98,0.11],[],0,"CAN_COLLIDE"];
	_this = _item649;
	_objects pushback _this;
	_objectIDs pushback 649;
	_this setPosWorld [1832.58,9987.98,15.1312];
	_this setVectorDirAndUp [[0.248351,0.96867,0],[0,0,1]];
};

private _item650 = objNull;
if (_layerRoot) then {
	_item650 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1832.5,9988.58,0.11],[],0,"CAN_COLLIDE"];
	_this = _item650;
	_objects pushback _this;
	_objectIDs pushback 650;
	_this setPosWorld [1832.5,9988.58,14.9228];
	_this setVectorDirAndUp [[0.970146,-0.24252,0],[0,0,1]];
};

private _item651 = objNull;
if (_layerRoot) then {
	_item651 = createVehicle ["Land_MRP_O2_Kdo",[1832.5,9989.04,0.11],[],0,"CAN_COLLIDE"];
	_this = _item651;
	_objects pushback _this;
	_objectIDs pushback 651;
	_this setPosWorld [1832.5,9989.04,14.9228];
	_this setVectorDirAndUp [[0.248351,0.96867,0],[0,0,1]];
};

private _item652 = objNull;
if (_layerRoot) then {
	_item652 = createVehicle ["Land_MRP_O2_Kdo_Rose",[1832.11,9988.38,0.11],[],0,"CAN_COLLIDE"];
	_this = _item652;
	_objects pushback _this;
	_objectIDs pushback 652;
	_this setPosWorld [1832.11,9988.38,14.9228];
	_this setVectorDirAndUp [[0.987813,0.155643,0],[0,0,1]];
};

private _item653 = objNull;
if (_layerRoot) then {
	_item653 = createVehicle ["Land_MRP_O2_Kdo_Bleu",[1834.36,9987.41,0.11],[],0,"CAN_COLLIDE"];
	_this = _item653;
	_objects pushback _this;
	_objectIDs pushback 653;
	_this setPosWorld [1834.36,9987.41,14.9228];
	_this setVectorDirAndUp [[0.248351,0.96867,0],[0,0,1]];
};

private _item654 = objNull;
if (_layerRoot) then {
	_item654 = createVehicle ["Land_MRP_O2_Kdo_Vert",[1834.83,9987.51,0.11],[],0,"CAN_COLLIDE"];
	_this = _item654;
	_objects pushback _this;
	_objectIDs pushback 654;
	_this setPosWorld [1834.83,9987.51,14.9228];
	_this setVectorDirAndUp [[0.982175,-0.187971,0],[0,0,1]];
};

private _item655 = objNull;
if (_layerRoot) then {
	_item655 = createVehicle ["Land_Deer",[4261.31,4266.32,10.7824],[],0,"CAN_COLLIDE"];
	_this = _item655;
	_objects pushback _this;
	_objectIDs pushback 655;
	_this setPosWorld [4261.31,4266.32,25.5443];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item657 = objNull;
if (_layerRoot) then {
	_item657 = createVehicle ["Land_Snowman",[4117.39,4686.21,0],[],0,"CAN_COLLIDE"];
	_this = _item657;
	_objects pushback _this;
	_objectIDs pushback 657;
	_this setPosWorld [4117.39,4686.21,14.6678];
	_this setVectorDirAndUp [[-0.70132,0.712846,0],[0,0,1]];
};

private _item658 = objNull;
if (_layerRoot) then {
	_item658 = createVehicle ["Land_MRP_O2_Kdo",[4117.19,4685.73,0],[],0,"CAN_COLLIDE"];
	_this = _item658;
	_objects pushback _this;
	_objectIDs pushback 658;
	_this setPosWorld [4117.19,4685.73,13.8028];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item659 = objNull;
if (_layerRoot) then {
	_item659 = createVehicle ["Land_MRP_O2_Gros_Kdo_Vert",[4116.75,4685.83,0],[],0,"CAN_COLLIDE"];
	_this = _item659;
	_objects pushback _this;
	_objectIDs pushback 659;
	_this setPosWorld [4116.75,4685.83,14.0112];
	_this setVectorDirAndUp [[0,1,0],[0,0,1]];
};

private _item660 = objNull;
if (_layerRoot) then {
	_item660 = createVehicle ["Land_Deer",[4133.81,4689.4,0],[],0,"CAN_COLLIDE"];
	_this = _item660;
	_objects pushback _this;
	_objectIDs pushback 660;
	_this setPosWorld [4133.81,4689.4,14.7619];
	_this setVectorDirAndUp [[-0.903657,0.428257,0],[0,0,1]];
};

private _item661 = objNull;
if (_layerRoot) then {
	_item661 = createVehicle ["Land_Deer",[4536.41,4631.67,5.34626],[],0,"CAN_COLLIDE"];
	_this = _item661;
	_objects pushback _this;
	_objectIDs pushback 661;
	_this setPosWorld [4536.41,4631.67,20.1082];
	_this setVectorDirAndUp [[-0.445382,0.895341,0],[0,0,1]];
};

private _item663 = objNull;
if (_layerRoot) then {
	_item663 = createVehicle ["Land_Deer",[5267.58,4603.9,0],[],0,"CAN_COLLIDE"];
	_this = _item663;
	_objects pushback _this;
	_objectIDs pushback 663;
	_this setPosWorld [5267.58,4603.9,15.5419];
	_this setVectorDirAndUp [[0.0297876,0.999556,0],[0,0,1]];
};

private _item664 = objNull;
if (_layerRoot) then {
	_item664 = createVehicle ["Land_Snowman",[5260.64,4595.68,0],[],0,"CAN_COLLIDE"];
	_this = _item664;
	_objects pushback _this;
	_objectIDs pushback 664;
	_this setPosWorld [5260.64,4595.68,15.4478];
	_this setVectorDirAndUp [[0.796495,-0.604645,0],[0,0,1]];
};

private _item665 = objNull;
if (_layerRoot) then {
	_item665 = createVehicle ["Land_Deer",[4416.61,7541.72,0.0251932],[],0,"CAN_COLLIDE"];
	_this = _item665;
	_objects pushback _this;
	_objectIDs pushback 665;
	_this setPosWorld [4416.61,7541.72,15.7571];
	_this setVectorDirAndUp [[-0.673304,0.739366,0],[0,0,1]];
};

private _item666 = objNull;
if (_layerRoot) then {
	_item666 = createVehicle ["Land_Snowman",[4378.64,7543.44,0],[],0,"CAN_COLLIDE"];
	_this = _item666;
	_objects pushback _this;
	_objectIDs pushback 666;
	_this setPosWorld [4378.64,7543.44,15.6378];
	_this setVectorDirAndUp [[-0.441285,0.897367,0],[0,0,1]];
};


///////////////////////////////////////////////////////////////////////////////////////////
// Triggers
private _triggers = [];
private _triggerIDs = [];


///////////////////////////////////////////////////////////////////////////////////////////
// Group attributes (applied only once group units exist)


///////////////////////////////////////////////////////////////////////////////////////////
// Waypoints
private _waypoints = [];
private _waypointIDs = [];


///////////////////////////////////////////////////////////////////////////////////////////
// Logics
private _logics = [];
private _logicIDs = [];


///////////////////////////////////////////////////////////////////////////////////////////
// Layers


///////////////////////////////////////////////////////////////////////////////////////////
// Crews


///////////////////////////////////////////////////////////////////////////////////////////
// Vehicle cargo


///////////////////////////////////////////////////////////////////////////////////////////
// Connections


///////////////////////////////////////////////////////////////////////////////////////////
// Inits (executed only once all entities exist; isNil used to ensure non-scheduled environment)
isNil {
	// Rendre tous les objets cassables/destructibles (DÉSACTIVÉ)
	/*
	{
		if (!isNull _x) then {
			_x allowDamage true;
		};
	} forEach _objects;
	*/
};


///////////////////////////////////////////////////////////////////////////////////////////
// Module activations (only once everything is spawned and connected)


///////////////////////////////////////////////////////////////////////////////////////////
[[_objects,_groups,_triggers,_waypoints,_logics,_markers],[_objectIDs,_groupIDs,_triggerIDs,_waypointIDs,_logicIDs,_markerIDs]]


