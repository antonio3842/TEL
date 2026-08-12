// ALF_Server_fnc_vehicleCreateBusiness = {

private _uid = _this # 0;
private _veh = param [1,objnull];
private _siret = _this # 2;
private _unit = _this # 3;
private _nombre_Veh_Proche = _this # 4;

//Error checks
if (_uid isEqualTo "" OR {isNull _veh}) exitWith {};
if !(alive _veh) exitWith {};
private _className = typeOf _veh;
private _peinture = [];

private _plaque = [] call MRPV2_fnc_Vehicule_Creation_Plaque;
[_veh,_plaque] remoteExec ["setPlateNumber",owner _veh];
private _queryplate = format["SELECT plate FROM vehicles WHERE plate='%1'",_plaque];
private _plateresult = [_queryplate,2] call ALF_Server_fnc_asyncCall;

if(_plateresult isequalto []) then 
{
	private _querySecteur = format["SELECT secteur FROM business WHERE siret='%1' AND active='1'",_siret];
	private _secteurResult = [_querySecteur,2] call ALF_Server_fnc_asyncCall;
	private _isB33 = false;
	if (!(_secteurResult isEqualTo [])) then {
		private _secteur = _secteurResult # 0;
		if (typeName _secteur == "STRING") then {
			_secteur = parseNumber _secteur;
		};
		_isB33 = (_secteur == 33);
	};
	
	if (_isB33) then {		
	} else {
		private _querydispo = format["SELECT dispo FROM shop WHERE classname='%1'",_className];
		private _disporesult = [_querydispo,2] call ALF_Server_fnc_asyncCall;
		private _dispo = _disporesult # 0;
		if (typeName _dispo == "STRING") then {
			_dispo = parseNumber _dispo;
		};
		private _newdispo = _dispo - 1;

		if(_newdispo < 0) exitWith 
		{
			deleteVehicle _veh;
			["INFO","Erreur dans le système, le véhicule n'était plus disponible.","danger"] remoteExec ["ALF_fnc_doMsg",_unit];
		};
		private _query = format["UPDATE shop SET dispo='%1' WHERE classname='%2'",_newdispo,_className];
		[_query,1] call ALF_Server_fnc_asyncCall;
	};

	[_uid,_siret,_className,_plaque,_peinture] call ALF_Server_fnc_insertVehicle;

	if (_nombre_Veh_Proche isequalto 0) exitwith {deleteVehicle _veh;};

	private _insure = 0;
	_veh setVariable ["dbInfo",[_uid,_plaque,_insure,0,0]];
	_plaque = _plaque splitString "";
	_veh setObjectTextureGlobal [1, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 0]];
	_veh setObjectTextureGlobal [2, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 1]];
	_veh setObjectTextureGlobal [3, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 3]];
	_veh setObjectTextureGlobal [4, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 4]];
	_veh setObjectTextureGlobal [5, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 5]];
	_veh setObjectTextureGlobal [6, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 7]];
	_veh setObjectTextureGlobal [7, format ["\ALF_Vehicules\ALF_data\plaque\%1.paa",_plaque # 8]];
} else 
{
	[_uid,_veh,_siret,_unit,_peinture] call ALF_Server_fnc_vehicleCreateBusiness;
};
// };