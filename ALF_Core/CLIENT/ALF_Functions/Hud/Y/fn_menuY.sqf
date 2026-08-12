//ALF_fnc_menuY = {
private "_struct";
if(!dialog) then {createDialog "ymenu_dialog"};
disableSerialization;
private _display = findDisplay 123450;

_pmenupic = _display displayCtrl 123451;
_pmenubtn = _display displayCtrl 1234511;
_pmoney = _display displayCtrl 123452;
_pedit = _display displayCtrl 123453;
_pbtngive = _display displayCtrl 123454;
_plicense = _display displayCtrl 123455;

_kmenupic = _display displayCtrl 123456;
_kmenubtn = _display displayCtrl 1234561;
_klistbox = _display displayCtrl 123457;
_kgivebtn = _display displayCtrl 123458;
_kgivedefbtn = _display displayCtrl 123499;
_kjeterbtn = _display displayCtrl 123459;

_gmenupic1 = _display displayCtrl 123460;
_gmenupic2 = _display displayCtrl 123461;
_gmenubtn = _display displayCtrl 1234601;
_gedit = _display displayCtrl 123462;
_gcreatebtn = _display displayCtrl 123463;
_glistbox = _display displayCtrl 123464;
_gname = _display displayCtrl 123465;
_gpic1 = _display displayCtrl 123466;
_gpic2 = _display displayCtrl 123467;
_gpic3 = _display displayCtrl 123468;
_gpic4 = _display displayCtrl 123469;
_gpic5 = _display displayCtrl 123470;
_gpic6 = _display displayCtrl 123471;
_gbtn1 = _display displayCtrl 123472;
_gbtn2 = _display displayCtrl 123473;
_gbtn3 = _display displayCtrl 123474;
_gbtn4 = _display displayCtrl 123475;
_gbtn5 = _display displayCtrl 123476;
_gbtn6 = _display displayCtrl 123477;

_pamenupic = _display displayCtrl 123478;
_pamenubtn = _display displayCtrl 1234781;
_pacheckbox = _display displayCtrl 123479;
_pafootslider = _display displayCtrl 123480;
_pafootedit = _display displayCtrl 123481;
_pacarslider = _display displayCtrl 123482;
_pacaredit = _display displayCtrl 123483;
_paairslider = _display displayCtrl 123484;
_paairedit = _display displayCtrl 123485;

_kedit = _display displayCtrl 123496;
_kbtn = _display displayCtrl 123497;
_btnmag = _display displayCtrl 123537;

_menu = uiNamespace getVariable "ymenu";

switch (_menu) do 
{
	case 0 : 
	{
		_pmenubtn ctrlShow false;
		_kmenubtn ctrlShow true;
		_gmenubtn ctrlShow true;

		_pmenupic ctrlShow true;
		_pmoney ctrlShow true;
		_pedit ctrlShow true;
		_pbtngive ctrlShow true;
		_plicense ctrlShow true;

		_kmenupic ctrlShow false;
		_klistbox ctrlShow false;
		_kgivebtn ctrlShow false;
		_kgivedefbtn ctrlShow false;
		_kjeterbtn ctrlShow false;

		_gmenupic1 ctrlShow false;
		_gmenupic2 ctrlShow false;
		_gedit ctrlShow false;
		_gcreatebtn ctrlShow false;
		_glistbox ctrlShow false;
		_gname ctrlShow false;
		_gpic1 ctrlShow false;
		_gpic2 ctrlShow false;
		_gpic3 ctrlShow false;
		_gpic4 ctrlShow false;
		_gpic5 ctrlShow false;
		_gpic6 ctrlShow false;
		_gbtn1 ctrlShow false;
		_gbtn2 ctrlShow false;
		_gbtn3 ctrlShow false;
		_gbtn4 ctrlShow false;
		_gbtn5 ctrlShow false;
		_gbtn6 ctrlShow false;

		_pamenupic ctrlShow false;
		_pamenubtn ctrlShow false;
		_pacheckbox ctrlShow false;
		_pafootslider ctrlShow false;
		_pafootedit ctrlShow false;
		_pacarslider ctrlShow false;
		_pacaredit ctrlShow false;
		_paairslider ctrlShow false;
		_paairedit ctrlShow false;

		_kedit ctrlShow false;
		_kbtn ctrlShow false;
		_btnmag ctrlShow false;

		_pmoney ctrlSetStructuredText parseText format["<t align='center' shadow='0' size='1.5px'>%1</t>",[round floor life_cash] call ALF_fnc_numberText];
		_struct = "";
		if(life_donor) then 
		{
			_struct = _struct + format["Premium - %1 jours<br/>",life_duredon];
		};
		if (player in (missionNamespace getVariable ["ALF_AllBracelets",[]])) then 
		{
			if (ALF_TimeBracelet > 0) then 
			{
				_struct = _struct + format["Bracelet - %1<br/>",[ALF_TimeBracelet] call BIS_fnc_secondsToString];
			} else 
			{
				_struct = _struct + "Bracelet - Temps indéterminé<br/>";
			};
		};
		if (player getVariable ["ALF_EnPrison",false] AND {ALF_TimePrison > 0}) then 
		{
			_struct = _struct + format["Prison - %1<br/>",[ALF_TimePrison] call BIS_fnc_secondsToString];
			if(ALF_Prison_Coffre isEqualTo 0) then 
			{
				_struct = _struct + format["Cellule - %1<br/>","Aucune"];
			} else 
			{
				_struct = _struct + format["Cellule - %1<br/>",ALF_Prison_Coffre];
			};
		};

		private _licences = ["CLASSES",["Licenses"]] call ALFTools_Client_Config_fnc_getConfig;

		{
			_displayName = ["STRING",["displayName"],_y] call ALFTools_Client_Config_fnc_getConfig;
			private _varnameConfig = ["STRING", ["Licenses", _x, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
			private _licenceValueConfig = missionNamespace getVariable [format["license_%1",_varnameConfig], false];
			if(_licenceValueConfig AND !(_displayName in ["Femme"])) then 
			{
				_struct = _struct + format["%1<br/>",_displayName];
			};
		} forEach _licences;

		if(_struct isEqualTo "") then {_struct = "Aucune";};
		_plicense ctrlSetStructuredText parseText format["<t align='center' shadow='0' size='1px'>%1</t>",_struct];
	};
	case 1 : 
	{
		_pmenubtn ctrlShow true;
		_kmenubtn ctrlShow false;
		_gmenubtn ctrlShow true;

		_pmenupic ctrlShow false;
		_pmoney ctrlShow false;
		_pedit ctrlShow false;
		_pbtngive ctrlShow false;
		_plicense ctrlShow false;

		_kmenupic ctrlShow true;
		_klistbox ctrlShow true;
		_kgivebtn ctrlShow true;
		_kgivedefbtn ctrlShow true;
		_kjeterbtn ctrlShow true;

		_gmenupic1 ctrlShow false;
		_gmenupic2 ctrlShow false;
		_gedit ctrlShow false;
		_gcreatebtn ctrlShow false;
		_glistbox ctrlShow false;
		_gname ctrlShow false;
		_gpic1 ctrlShow false;
		_gpic2 ctrlShow false;
		_gpic3 ctrlShow false;
		_gpic4 ctrlShow false;
		_gpic5 ctrlShow false;
		_gpic6 ctrlShow false;
		_gbtn1 ctrlShow false;
		_gbtn2 ctrlShow false;
		_gbtn3 ctrlShow false;
		_gbtn4 ctrlShow false;
		_gbtn5 ctrlShow false;
		_gbtn6 ctrlShow false;

		_pamenupic ctrlShow false;
		_pamenubtn ctrlShow false;
		_pacheckbox ctrlShow false;
		_pafootslider ctrlShow false;
		_pafootedit ctrlShow false;
		_pacarslider ctrlShow false;
		_pacaredit ctrlShow false;
		_paairslider ctrlShow false;
		_paairedit ctrlShow false;

		_kedit ctrlShow true;
		_kbtn ctrlShow true;
		_btnmag ctrlShow false;

		lbClear _klistbox;
		life_vehicles = life_vehicles select {!isnull _x};

		for "_i" from 0 to (count life_vehicles)-1 do 
		{
			_veh = life_vehicles select _i;

			if(alive _veh) then 
			{
				_name = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
				
				if (_veh isKindOf "House") then 
				{					
					private _uid = _veh getVariable ["uid",0];
					private _index = life_houses find (str(getPosATL _veh));
					if(_index isNotEqualTo -1) then 
					{
						_klistbox lbAdd format["%1",(_name + "#" + str(_uid))];
					} else 
					{
						_klistbox lbAdd format["[PRET] - %1",(_name + "#" + str(_uid))];
					};

					_klistbox lbSetData [(lbSize _klistbox)-1,str(_i)];
				} else
				{
					private _p = getPlateNumber _veh;
					private _puid = (_veh getVariable ["vehicle_info_owners",["",""]]) # 1;

					if((getPlayerUID player) isEqualTo _puid OR {(_veh getVariable ["business_veh",""] isNotEqualTo "") AND {(player getVariable ["isEmployed",""]) isEqualTo ((_veh getVariable ["business_veh",[""]]) select 0)}}) then 
					{
						_klistbox lbAdd format["%1 - %2",_name,_p];
					} else
					{
						_klistbox lbAdd format["[PRET] - %1 - %2",_name,_p];
					};

					_klistbox lbSetData [(lbSize _klistbox)-1,str(_i)];
				};

				_pic = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "picture");
				if(_pic != "pictureStaticObject") then 
				{
					_klistbox lbSetPicture [(lbSize _klistbox)-1,_pic];
				};
			};
		};
	};
	case 3 : 
	{
		_pmenubtn ctrlShow true;
		_kmenubtn ctrlShow true;
		_gmenubtn ctrlShow false;

		_pmenupic ctrlShow false;
		_pmoney ctrlShow false;
		_pedit ctrlShow false;
		_pbtngive ctrlShow false;
		_plicense ctrlShow false;

		_kmenupic ctrlShow false;
		_klistbox ctrlShow false;
		_kgivebtn ctrlShow false;
		_kgivedefbtn ctrlShow false;
		_kjeterbtn ctrlShow false;

		_gmenupic1 ctrlShow false;
		_gmenupic2 ctrlShow false;
		_gedit ctrlShow false;
		_gcreatebtn ctrlShow false;
		_glistbox ctrlShow false;
		_gname ctrlShow false;
		_gpic1 ctrlShow false;
		_gpic2 ctrlShow false;
		_gpic3 ctrlShow false;
		_gpic4 ctrlShow false;
		_gpic5 ctrlShow false;
		_gpic6 ctrlShow false;
		_gbtn1 ctrlShow false;
		_gbtn2 ctrlShow false;
		_gbtn3 ctrlShow false;
		_gbtn4 ctrlShow false;
		_gbtn5 ctrlShow false;
		_gbtn6 ctrlShow false;

		_pamenupic ctrlShow true;
		_pamenubtn ctrlShow false;
		_pacheckbox ctrlShow true;
		_pafootslider ctrlShow true;
		_pafootedit ctrlShow true;
		_pacarslider ctrlShow true;
		_pacaredit ctrlShow true;
		_paairslider ctrlShow true;
		_paairedit ctrlShow true;

		if !(alf_bouton_magique) then 
		{
			_btnmag ctrlShow true;
		} else 
		{
			_btnmag ctrlShow false;
		};

		_kedit ctrlShow false;
		_kbtn ctrlShow false;

		[] call ALF_fnc_settingsMenu;
	};
};
//};