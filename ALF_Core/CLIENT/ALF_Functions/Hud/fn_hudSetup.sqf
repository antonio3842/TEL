#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_hudSetup.sqf
	Author: ALF Team

	Description:
	Setups the hud for the player?
*/
[{
	disableSerialization;

	private _display = uiNamespace getVariable ["playerHUD",displayNull];
	private _isHudEnabled = profileNameSpace getVariable ["playerHUD_Enabled",true];

    if (isNull _display && {_isHudEnabled}) then {
		("playerHUD" call BIS_fnc_rscLayer) cutRsc ["playerHUD","PLAIN"];
		_display = uiNamespace getVariable ["playerHUD",displayNull];
	};
	if (!isNull _display && {!_isHudEnabled}) then {
		("playerHUD" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
		uiNameSpace setVariable ["playerHUD",nil];
	};
	if (isNull _display) exitwith {};

    _magcolor = "#FFFFFF";
    _ammocolor = "#FFFFFF";
    _ammotext = parseText format[""];
    _amountmagtext = parseText format[""];
    _weaponname = parseText format[""];
    _hudinfo = weaponState player;
    _curweapon = _hudinfo select 0;
    _curmagazine = _hudinfo select 4;
    _className = _hudinfo select 3;
    _gunmodeold = _hudinfo select 2;
    _gunmode = "";

	if ((_gunmodeold isEqualTo "single") or (_gunmodeold isEqualTo "FullAuto") or (_gunmodeold isEqualTo "Burst") or (_gunmodeold isEqualTo "manual")) then {
        _gunmode = _gunmodeold;
        if (_gunmodeold isEqualTo "single") then {_gunmode = "Coup par coup"};
        if (_gunmodeold isEqualTo "FullAuto") then {_gunmode = "Automatique"};
        if (_gunmodeold isEqualTo "Burst") then {_gunmode = "Rafale"};
        if (_gunmodeold isEqualTo "manual") then {_gunmode = "Manuel"};
    };
    _magforpic = "";
    if (_curweapon != "") then {
        _magforpic = (getArray (configFile >> "CfgWeapons" >> _curweapon >> "magazines")) select 0;
    };
    _picture = "";
    _picture = getText (configFile >> "CfgMagazines" >> _magforpic >> "picture");
    _noweaponsarray = ["","","","",0];
    _nothing = _noweaponsarray select 0;
    if (_nothing isEqualTo _curweapon) then {} else {
        _zeroing = currentZeroing player;

        _magazineClass = currentMagazine player;
        _weaponname = getText (configFile >> "CfgWeapons" >> _curweapon >> "displayName");
        _maxammo = getNumber(configFile >> "CfgMagazines" >> _magazineClass >> "count") ;
        _prcentammo = 0;
        if (_curmagazine isEqualTo 0) then {
            _prcentammo = 0;
        } else {
            _prcentammo = (_curmagazine / _maxammo) * 100;
        };
        _amountmag = {_x isEqualTo (currentmagazine player)} count magazines player;
        if (_amountmag isEqualTo 0) then {
            _amountmagtext = parseText format["Je n'ai plus de chargeur"];
            _magcolor = "#FFFFFF";
        } else {
            if (_amountmag isEqualTo 1) then {
                _amountmagtext = parseText format["Il me reste %1 chargeur", _amountmag];
                        _magcolor = "#FFFFFF";
            } else {
                if (_amountmag > 1) then {
                    _amountmagtext = parseText format["Il me reste %1 chargeurs", _amountmag];
                    _magcolor = "#FFFFFF";
                };
            };
        };
        if (_prcentammo isEqualTo 0) then {
            _ammotext = parseText format["Je n'ai plus de balles"];
            _ammocolor = "#FFFFFF";
        } else {
            if (_prcentammo < 20) then {
                _ammotext = parseText format["Le chargeur est presque vide"];
                _ammocolor = "#FFFFFF";
            } else {
                if (_prcentammo < 40) then {
                    _ammotext = parseText format["Il ne reste plus beaucoup de balles"];
                    _ammocolor = "#FFFFFF";
                } else {
                    if (_prcentammo < 60) then {
                        _ammotext = parseText format["Le chargeur pèse environ moitié moins"];
                        _ammocolor = "#FFFFFF";
                    } else {
                        if (_prcentammo < 80) then {
                            _ammotext = parseText format["J'ai assez de balles"];
                            _ammocolor = "#FFFFFF";
                        } else {
                            if (_prcentammo < 100) then {
                                _ammotext = parseText format["J'ai beaucoup de balles"];
                                _ammocolor = "#FFFFFF";
                            } else {
                                if (_prcentammo isEqualTo 100) then {
                                    _ammotext = parseText format["Le chargeur est plein"];
                                    _ammocolor = "#FFFFFF";
                                };
                            };
                        };
                    };
                };
            };
        };
    };

	_soif = floor (life_thirst / 10);
	_hunger = floor (life_hunger / 10);
	_stress = Player_Stress;

	private _ctrl = 1200; 
    private _status = [
        [(_hunger > 3) && ( _hunger <= 5),"\ALF_Client2\icons\ALF_Food50.paa"],
        [(_hunger > 2) &&( _hunger <= 3),"\ALF_Client2\icons\ALF_Food30.paa"],
        [_hunger <= 2,"\ALF_Client2\icons\ALF_Food10.paa"],
        [(_soif > 3) && ( _soif <= 5),"\ALF_Client2\icons\ALF_Drink50.paa"],
        [(_soif > 2) &&( _soif <= 3),"\ALF_Client2\icons\ALF_Drink30.paa"],
        [_soif <= 2,"\ALF_Client2\icons\ALF_Drink10.paa"],
        [(_stress > 30) && ( _stress <= 50),"\ALF_Client2\icons\Stress_Low.paa"],
        [(_stress > 20) &&( _stress <= 30),"\ALF_Client2\icons\stress_med.paa"],
        [(TF_speak_volume_level == "yelling"),"\ALF_Client2\icons\TFR_Yelling.paa"],
        [(TF_speak_volume_level == "normal"),"\ALF_Client2\icons\TFR_Normal.paa"],
        [(TF_speak_volume_level == "whispering"),"\ALF_Client2\icons\TFR_Whispering.paa"],
        [(life_fadeSound == true),"\ALF_Client2\icons\ALF_EarPlug.paa"],
        [(ALF_Phone_inCall == true),"\ALF_Client2\icons\InCall.paa"],
        [(ALF_Phone_Avion == true),"\ALF_Client2\icons\CallOff.paa"],
        [(ALF_Phone_Mute == true),"\ALF_Client2\icons\ViberMode.paa"],
        [(ALF_Phone_SMS == true),"\ALF_Client2\icons\NewSms.paa"],
        [(ALF_Phone_Anonyme == true),"\ALF_Client2\icons\anonyme.paa"],
        [(player in (missionNamespace getVariable ["ALF_AllBracelets",[]])),"\ALF_Client2\icons\bracelet.paa"]
    ];

    {
        _condition = _x#0;
        _statuspic = _x#1;
        if (_condition) then {
            (_display displayCtrl _ctrl) ctrlSetText _statuspic;
            (_display displayCtrl _ctrl) ctrlShow true;
            _ctrl = _ctrl + 1;
        };
    } forEach _status;

    for "_i" from _ctrl to 1209 do {
        (_display displayCtrl _i) ctrlShow false;
    };

    _ammohudtext = parseText format ["<t font='EtelkaNarrowMediumPro' color='%1' size='0.9' align='left'>%2</t>",_ammocolor, _ammotext];
    _maghudtext = parseText format ["<t font='EtelkaNarrowMediumPro' color='%1' size='1' align='left'>%2</t>", _magcolor, _amountmagtext];
    _gunmodetext = parseText format ["<t font='EtelkaNarrowMediumPro' color='#FFFFFF' size='1' align='center'>%1</t>", _gunmode];
    _weapontexthud = parseText format ["<t font='EtelkaNarrowMediumPro' color='#FFFFFF' size='1' align='left'>%1</t>", _weaponname];
    (_display displayCtrl 16418) ctrlSetText _picture;
    (_display displayCtrl 16422) ctrlSetStructuredText _ammohudtext;
    (_display displayCtrl 16419) ctrlSetStructuredText _gunmodetext;
    (_display displayCtrl 16421) ctrlSetStructuredText _maghudtext;
    (_display displayCtrl 16420) ctrlSetStructuredText _weapontexthud;
}, 0.5] call CBA_fnc_addPerFrameHandler;
