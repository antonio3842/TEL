// alf_fnc_showCarStats = {
private _veh = _this # 0;
disableSerialization;
private _display = findDisplay 30200;
private _MainCarVert = _display displayCtrl 30201;
private _MainCarOrange = _display displayCtrl 30202;
private _MainCarRouge = _display displayCtrl 30203;
private _LFCarVert = _display displayCtrl 30204;
private _LFCarOrange = _display displayCtrl 30205;
private _LFCarRouge = _display displayCtrl 30206;
private _LF2CarVert = _display displayCtrl 30207;
private _LF2CarOrange = _display displayCtrl 30208;
private _LF2CarRouge = _display displayCtrl 30209;
private _LRCarVert = _display displayCtrl 30210;
private _LRCarOrange = _display displayCtrl 30211;
private _LRCarRouge = _display displayCtrl 30212;
private _LR2CarVert = _display displayCtrl 30213;
private _LR2CarOrange = _display displayCtrl 30214;
private _LR2CarRouge = _display displayCtrl 30215;
private _EngineCarVert = _display displayCtrl 30216;
private _EngineCarOrange = _display displayCtrl 30217;
private _EngineCarRouge = _display displayCtrl 30218;
_MainCarVert ctrlShow false;
_MainCarOrange ctrlShow false;
_MainCarRouge ctrlShow false;
_LFCarVert ctrlShow false;
_LFCarOrange ctrlShow false;
_LFCarRouge ctrlShow false;
_LF2CarVert ctrlShow false;
_LF2CarOrange ctrlShow false;
_LF2CarRouge ctrlShow false;
_LRCarVert ctrlShow false;
_LRCarOrange ctrlShow false;
_LRCarRouge ctrlShow false;
_LR2CarVert ctrlShow false;
_LR2CarOrange ctrlShow false;
_LR2CarRouge ctrlShow false;
_EngineCarVert ctrlShow false;
_EngineCarOrange ctrlShow false;
_EngineCarRouge ctrlShow false;


private _MainTruckVert = _display displayCtrl 30231;
private _MainTruckOrange = _display displayCtrl 30232;
private _MainTruckRouge = _display displayCtrl 30233;
private _LMTruckVert = _display displayCtrl 30237;
private _LMTruckOrange = _display displayCtrl 30238;
private _LMTruckRouge = _display displayCtrl 30239;
private _RMTruckVert = _display displayCtrl 30234;
private _RMTruckOrange = _display displayCtrl 30235;
private _RMTruckRouge = _display displayCtrl 30236;
_MainTruckVert ctrlShow false;
_MainTruckOrange ctrlShow false;
_MainTruckRouge ctrlShow false;
_LMTruckVert ctrlShow false;
_LMTruckOrange ctrlShow false;
_LMTruckRouge ctrlShow false;
_RMTruckVert ctrlShow false;
_RMTruckOrange ctrlShow false;
_RMTruckRouge ctrlShow false;

private _MainBoatVert = _display displayCtrl 30240;
private _MainBoatOrange = _display displayCtrl 30241;
private _MainBoatRouge = _display displayCtrl 30242;
_MainBoatVert ctrlShow false;
_MainBoatOrange ctrlShow false;
_MainBoatRouge ctrlShow false;

private _MainMotoVert = _display displayCtrl 30219;
private _MainMotoOrange = _display displayCtrl 30220;
private _MainMotoRouge = _display displayCtrl 30221;
private _EngineMotoVert = _display displayCtrl 30222;
private _EngineMotoOrange = _display displayCtrl 30223;
private _EngineMotoRouge = _display displayCtrl 30224;
private _FMotoVert = _display displayCtrl 30225;
private _FMotoOrange = _display displayCtrl 30226;
private _FMotoRouge = _display displayCtrl 30227;
private _BMotoVert = _display displayCtrl 30228;
private _BMotoOrange = _display displayCtrl 30229;
private _BMotoRouge = _display displayCtrl 30230;
_MainMotoVert ctrlShow false;
_MainMotoOrange ctrlShow false;
_MainMotoRouge ctrlShow false;
_EngineMotoVert ctrlShow false;
_EngineMotoOrange ctrlShow false;
_EngineMotoRouge ctrlShow false;
_FMotoVert ctrlShow false;
_FMotoOrange ctrlShow false;
_FMotoRouge ctrlShow false;
_BMotoVert ctrlShow false;
_BMotoOrange ctrlShow false;
_BMotoRouge ctrlShow false;

private _HeliVert = _display displayCtrl 30417;
private _HeliOrange = _display displayCtrl 30418;
private _HeliRouge = _display displayCtrl 30419;
_HeliVert ctrlShow false;
_HeliOrange ctrlShow false;
_HeliRouge ctrlShow false;

private _Fuel0 = _display displayCtrl 30300;
private _Fuel10 = _display displayCtrl 30301;
private _Fuel20 = _display displayCtrl 30302;
private _Fuel30 = _display displayCtrl 30303;
private _Fuel40 = _display displayCtrl 30304;
private _Fuel50 = _display displayCtrl 30305;
private _Fuel60 = _display displayCtrl 30306;
private _Fuel70 = _display displayCtrl 30307;
private _Fuel80 = _display displayCtrl 30308;
private _Fuel90 = _display displayCtrl 30309;
private _Fuel100 = _display displayCtrl 30310;
_Fuel0 ctrlShow false;
_Fuel10 ctrlShow false;
_Fuel20 ctrlShow false;
_Fuel30 ctrlShow false;
_Fuel40 ctrlShow false;
_Fuel50 ctrlShow false;
_Fuel60 ctrlShow false;
_Fuel70 ctrlShow false;
_Fuel80 ctrlShow false;
_Fuel90 ctrlShow false;
_Fuel100 ctrlShow false;

private _Sabot = _display displayCtrl 30420;
_Sabot ctrlShow false;

if(_veh in (missionNamespace getVariable ["VehiculeImmobiliser",[]])) then {_Sabot ctrlShow true;};

private _dammage = getDammage _veh;
switch (true) do 
{
	case (_dammage < 0.33) : 
	{
		_MainCarVert ctrlShow true;
	};
	case (_dammage >= 0.33 AND _dammage < 0.66) : 
	{
		_MainCarOrange ctrlShow true;
	};
	case (_dammage >= 0.66) :
	{
		_MainCarRouge ctrlShow true;
	};
};

private _engineDamage = _veh getHitPointDamage "hitEngine";
switch (true) do 
{
	case (_engineDamage < 0.33) : 
	{
		_EngineCarVert ctrlShow true;
	};
	case (_engineDamage >= 0.33 AND _engineDamage < 0.66) : 
	{
		_EngineCarOrange ctrlShow true;
	};
	case (_engineDamage >= 0.66) : 
	{
		_EngineCarRouge ctrlShow true;
	};
};

private _hitlf = _veh getHitPointDamage "HitLFWheel";
switch (true) do 
{
	case (_hitlf < 0.33) : 
	{
		_LFCarVert ctrlShow true;
	};
	case (_hitlf >= 0.33 AND _hitlf < 0.66) : 
	{
		_LFCarOrange ctrlShow true;
	};
	case (_hitlf >= 0.66) : 
	{
		_LFCarRouge ctrlShow true;
	};
};
private _hitlf2 = _veh getHitPointDamage "HitLF2Wheel";
switch (true) do 
{
	case (_hitlf2 < 0.33) : 
	{
		_LF2CarVert ctrlShow true;
	};
	case (_hitlf2 >= 0.33 AND _hitlf2 < 0.66) : 
	{
		_LF2CarOrange ctrlShow true;
	};
	case (_hitlf2 >= 0.66) : 
	{
		_LF2CarRouge ctrlShow true;
	};
};
private _hitrf = _veh getHitPointDamage "HitRFWheel";
switch (true) do 
{
	case (_hitrf < 0.33) : 
	{
		_LRCarVert ctrlShow true;
	};
	case (_hitrf >= 0.33 AND _hitrf < 0.66) : 
	{
		_LRCarOrange ctrlShow true;
	};
	case (_hitrf >= 0.66) : 
	{
		_LRCarRouge ctrlShow true;
	};
};
private _hitrf2 = _veh getHitPointDamage "HitRF2Wheel";
switch (true) do 
{
	case (_hitrf2 < 0.33) : {_LR2CarVert ctrlShow true;};
	case (_hitrf2 >= 0.33 AND _hitrf2 < 0.66) : {_LR2CarOrange ctrlShow true;};
	case (_hitrf2 >= 0.66) : {_LR2CarRouge ctrlShow true;};
};

private _fuel = fuel _veh;
switch (true) do 
{
	case (_fuel isEqualTo 0) : {_Fuel0 ctrlShow true;};
	case (_fuel > 0 AND _fuel < 0.1) : {_Fuel10 ctrlShow true;};
	case (_fuel >= 0.1 AND _fuel < 0.2) : {_Fuel20 ctrlShow true;};
	case (_fuel >= 0.2 AND _fuel < 0.3) : {_Fuel30 ctrlShow true;};
	case (_fuel >= 0.3 AND _fuel < 0.4) : {_Fuel40 ctrlShow true;};
	case (_fuel >= 0.4 AND _fuel < 0.5) : {_Fuel50 ctrlShow true;};
	case (_fuel >= 0.5 AND _fuel < 0.6) : {_Fuel60 ctrlShow true;};
	case (_fuel >= 0.6 AND _fuel < 0.7) : {_Fuel70 ctrlShow true;};
	case (_fuel >= 0.7 AND _fuel < 0.8) : {_Fuel80 ctrlShow true;};
	case (_fuel >= 0.8 AND _fuel < 0.9) : {_Fuel90 ctrlShow true;};
	case (_fuel >= 0.9) : {_Fuel100 ctrlShow true;};	
};
// };