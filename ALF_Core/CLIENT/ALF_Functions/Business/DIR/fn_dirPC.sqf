/*______________________________________
|									 	|
|		Autheur : Yoan Verquion      	|
|		Pour : Arma3LifeFrance         	|
|		Scripts : fn_dirPC.sqf  		|
|______________________________________ */

if (isServer) exitWith {};
if !(hasInterface) exitWith {};


if(!dialog) then {
	createDialog "ALF_dirPc";
};

/* ALL Control */

private _display = findDisplay 7529001;
private _backgroung = _display displayCtrl 1486301;
private _btnFeux = _display displayCtrl 1486302;
private _btnCentrale = _display displayCtrl 1486303;
private _mapInfo = _display displayCtrl 1486304;
private _mapView = _display displayCtrl 1486305;
private _btnClose = _display displayCtrl 1486306;


/* End all control */

private _menu = uiNamespace getVariable "alf_dir_menu";

switch (_menu) do {
	case 0: {
		_mapInfo ctrlShow false;
		_mapView ctrlShow false;
		_btnClose ctrlShow false;
		_btnFeux ctrlShow false;
		_btnCentrale ctrlShow true;

		_backgroung ctrlSetText "\alf_client2\textures\DIR\PCMain.paa";
		_btnFeux buttonSetAction "uiNamespace setVariable ['alf_dir_menu',1]; [] spawn ALF_fnc_dirPC;";
		_btnCentrale buttonSetAction "uiNamespace setVariable ['alf_dir_menu',2]; [] spawn ALF_fnc_dirPC;";
	};
	case 1: {
		_mapInfo ctrlShow true;
		_mapView ctrlShow false;
		_btnClose ctrlShow true;
		_btnFeux ctrlShow false;
		_btnCentrale ctrlShow false;

		_btnClose buttonSetAction "uiNamespace setVariable ['alf_dir_menu',0]; [] spawn ALF_fnc_dirPC;";
		_backgroung ctrlSetText "\alf_client2\textures\DIR\PCMap.paa";

		{
			deleteMarkerLocal _x;
		} forEach ALF_MarkerTempDir;

		ALF_CountTempDirActive = [];
		ALF_CountTempDirDesactive = [];
		{
			if (_x getVariable ["ALF_FeuCasse",false]) then {
				_marker = createMarkerLocal [format ["feutrico_%1",round(random(1000))], (getpos _x)];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "hd_dot";
				_marker setMarkerTextLocal format["En maintenance"];
				_marker setMarkerColorLocal "ColorRed";
				_marker setMarkerAlphaLocal 0.8;

				ALF_CountTempDirDesactive pushBack _x;
				ALF_MarkerTempDir pushBack _marker;
			} else {
				_marker = createMarkerLocal [format ["feutrico_%1",round(random(1000))], (getpos _x)];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "hd_dot";
				_marker setMarkerTextLocal format["Fonctionnel"];
				_marker setMarkerColorLocal "ColorGreen";
				_marker setMarkerAlphaLocal 0.8;

				ALF_CountTempDirActive pushBack _x;
				ALF_MarkerTempDir pushBack _marker;
			};
		} forEach ALF_DIR_FEU1;
		{
			if (_x getVariable ["ALF_FeuCasse",false]) then {
				_marker = createMarkerLocal [format ["feutrico_%1",round(random(1000))], (getpos _x)];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "hd_dot";
				_marker setMarkerTextLocal format["En maintenance"];
				_marker setMarkerColorLocal "ColorRed";
				_marker setMarkerAlphaLocal 0.8;
				ALF_CountTempDirDesactive pushBack _x;

				ALF_MarkerTempDir pushBack _marker;
			} else {
				_marker = createMarkerLocal [format ["feutrico_%1",round(random(1000))], (getpos _x)];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "hd_dot";
				_marker setMarkerTextLocal format["Fonctionnel"];
				_marker setMarkerColorLocal "ColorGreen";
				_marker setMarkerAlphaLocal 0.8;
				ALF_CountTempDirActive pushBack _x;

				ALF_MarkerTempDir pushBack _marker;
			};
		} forEach ALF_DIR_FEU2;
		_mapView ctrlShow true;

		_nbFeuHS = count ALF_CountTempDirDesactive;
		_nbFeuActive = count ALF_CountTempDirActive;
		_nbTotal = _nbFeuHS + _nbFeuActive;

		_mapInfo ctrlSetStructuredText parseText format["<t size='1' align='center'> FEUX TRICOLORES</t><br/><t size='0.80'><br/>%1 feux en maintenance<br/>%2 feux fonctionnels<br/>%3 feux de circulations",_nbFeuHS,_nbFeuActive,_nbTotal];
	};
	case 2: {
		_mapInfo ctrlShow true;
		_mapView ctrlShow true;
		_btnClose ctrlShow true;
		_btnFeux ctrlShow false;
		_btnCentrale ctrlShow false;
		private _enMarche = 0;
		private _coupe = 0;
		_btnClose buttonSetAction "uiNamespace setVariable ['alf_dir_menu',0]; [] spawn ALF_fnc_dirPC;";
		_backgroung ctrlSetText "\alf_client2\textures\DIR\PCMap.paa";

		{
			deleteMarkerLocal _x;
		} forEach ALF_MarkerTempDir;
		
		{
			if (((_x) animationSourcePhase "disable_source") > 0.5) then {
            _marker = createMarkerLocal [format ["Trafo_%1", round(random(1000))], (getpos _x)];
            _marker setMarkerShapeLocal "ICON";
            _marker setMarkerTypeLocal "hd_dot";
            _marker setMarkerSizeLocal [4, 4];
            _marker setMarkerTextLocal "!! COUPER !!";
            _marker setMarkerColorLocal "ColorRed";
            _marker setMarkerAlphaLocal 0.8;
            ALF_MarkerTempDir pushBack _marker;
			_coupe = _coupe + 1;
        } else {
            _marker = createMarkerLocal [format ["Trafo_%1", round(random(1000))], (getpos _x)];
            _marker setMarkerShapeLocal "ICON";
            _marker setMarkerTypeLocal "hd_dot";
            _marker setMarkerSizeLocal [4, 4];
            _marker setMarkerTextLocal "En marche";
            _marker setMarkerColorLocal "ColorGreen";
            _marker setMarkerAlphaLocal 0.8;
            ALF_MarkerTempDir pushBack _marker;
			_enMarche = _enMarche + 1;
			};
			
		} forEach [ALF_BIE_SECTEUR_1,ALF_BIE_SECTEUR_2,ALF_BIE_SECTEUR_3,ALF_BIE_SECTEUR_4];
		
		_mapInfo ctrlSetStructuredText parseText format ["<t size='1' align='center' t color='#00FF00'>Transformateurs actifs : %1/4</t><br/><t color='#FF0000'>Transformateurs coupés : %2/4</t></t>",_enMarche, _coupe];

		
		for "_i" from 0 to 1 step 0 do { 
			if (uiNamespace getVariable ["alf_dir_menu",0] == 2) then {
				continue;
			} else {
				{
					deleteMarkerLocal _x;
				} forEach ALF_MarkerTempDir;
				break;
			};
		};
	};
};

