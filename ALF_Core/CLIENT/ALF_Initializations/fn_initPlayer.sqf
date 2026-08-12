/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
#include "\ALF_Client\script_macros.hpp"

waitUntil {sleep 0.3; !(isNull (findDisplay 46))};

if (ALF_Prison) then 
{
	if (life_is_alive) then 
	{
		player setPosATL life_civ_position;
	} else 
	{
		player setDamage 1;
	};

	[-1] spawn ALF_fnc_boucleEnPrison;
} else 
{
	if (life_is_alive) then 
	{
		if(life_playerfirstjoinserver) then 
		{
			// ALF_PlayingVideo = false;
			// [] spawn ALF_fnc_spawnVideo;
			// waitUntil {sleep 0.5; ALF_PlayingVideo};
			[getPlayerUID player] remoteExecCall ["ALF_Server_fnc_FirstJoinServer",2];
			[] spawn ALF_fnc_civLoadout;
		} else 
		{
			if (!isnil {life_civ_position} AND {life_civ_position isnotequalto [0,0,0]}) then {player setPosATL life_civ_position;};			
		};
	} else 
	{
		if (!isnil {life_civ_position} AND {life_civ_position isnotequalto [0,0,0]}) then {player setPosATL life_civ_position;};
		player setDamage 1;
	};
};

[3] call SOCK_fnc_updatePartial; //Alive + POS

[] call ALF_fnc_setupKeyBinding;

setViewDistance 500;

//Teamspeak
ALF_Teamspeak_Plugin_Enabled = false;
ALF_Teamspeak_Server_Enabled = false;
ALF_Teamspeak_Channel_Enabled = false;
if (ALF_AdminLevel isEqualTo 0) then 
{
	[{
		if !(call TFAR_fnc_isTeamSpeakPluginEnabled) then 
		{
			if !(ALF_Teamspeak_Plugin_Enabled) then 
			{
				ALF_Teamspeak_Plugin_Enabled = true;
				"teamspeakPlugin" cutText ["Merci d'activer votre plugin sur ts3 OR TS3 -> Settings -> Plugins","BLACK FADED"];
				"teamspeakPlugin" cutFadeOut 99999999;
			};
		} else 
		{
			if (ALF_Teamspeak_Plugin_Enabled) then 
			{
				ALF_Teamspeak_Plugin_Enabled = false;
				"teamspeakPlugin" cutText ["","BLACK IN"];
			};
		};

		_serverts = [] call TFAR_fnc_getTeamSpeakServerName;
		_channelts = [] call TFAR_fnc_getTeamSpeakChannelName;

		if !(_serverts isEqualTo "Martinique RolePlay") then 
		{
			if !(ALF_Teamspeak_Server_Enabled) then 
			{
				ALF_Teamspeak_Server_Enabled = true;
				"teamspeakServ" cutText ["Vous devez être sur l'onglet de notre teamspeak pour pouvoir jouer.","BLACK FADED"];
				"teamspeakServ" cutFadeOut 99999999;
			};
		} else 
		{
			if (ALF_Teamspeak_Server_Enabled) then 
			{
				ALF_Teamspeak_Server_Enabled = false;
				"teamspeakServ" cutText ["","BLACK IN"];
			};
		};

		if !(_channelts isEqualTo "TaskForceRadio") then 
		{
			if !(ALF_Teamspeak_Channel_Enabled) then 
			{
				ALF_Teamspeak_Channel_Enabled = true;
				"teamspeakChannel" cutText ["Vous devez etre sur l'onglet de notre teamspeak pour pouvoir jouer.","BLACK FADED"];
				"teamspeakChannel" cutFadeOut 99999999;
			};
		} else 
		{
			if (ALF_Teamspeak_Channel_Enabled) then 
			{
				ALF_Teamspeak_Channel_Enabled = false;
				"teamspeakChannel" cutText ["","BLACK IN"];
			};
		};
	}, 10] call CBA_fnc_addPerFrameHandler;
};

//Playtime + AutoSync
[{
	ALF_PlayTime = ALF_PlayTime + 10;
	[getPlayerUID player,ALF_PlayTime] remoteExec ["ALF_Server_fnc_playTime",2];
}, (5*60)] call CBA_fnc_addPerFrameHandler;//600

//Ajout des markers lorsqu'on ouvre la carte
addMissionEventHandler ["Map",
{
	if (_this select 0) then {[] spawn ALF_fnc_mapOpen;};

	_this spawn ALF_SmartMarker_fnc_handleMap;
}];

if (ALF_AdminLevel < 4) then {showChat false;};

//Liste OBJ Admin Menu
if (ALF_AdminLevel >= 4) then 
{
    ALL_VEHS_TO_SEARCH_C = [];
    ALL_OBJS_TO_SEARCH_C = [];
    ALL_BAGS_TO_SEARCH_C = [];
    _cfg = configFile >> 'cfgVehicles';
    for '_j' from 0 to (count _cfg)-1 do 
	{
        _c = _cfg select _j;
        if (isClass _c) then 
		{
            _t = configName _c;
            if (toLower _t find '_base' isEqualTo -1) then 
			{
                _BackPack = getText(configfile >> 'CfgVehicles' >> _t >> 'vehicleClass') == 'BackPacks';
                if(_BackPack)then 
				{
                    ALL_BAGS_TO_SEARCH_C pushBack _t;
                } else 
				{
                    if ((_t isKindOf 'Air') OR (_t isKindOf 'LandVehicle') OR (_t isKindOf 'Ship')) then 
					{
                        _pic = getText(_c >> 'picture');
                        if!((toLower _pic) in ['','pictureheal','picturepapercar','picturething','picturestaticobject']) then 
						{
                            ALL_VEHS_TO_SEARCH_C pushBack _t;
                        };
                    } else 
					{
                        if((_t isKindOf 'Building') OR (_t isKindOf 'Building') OR (_t isKindOf 'ThingX') OR (_t isKindOf 'Constructions_static_F') OR (_t isKindOf 'Constructions_foundation_F'))then 
						{
                            _lt = toLower _t;
                            if((_lt find 'weapon' == -1) && (_lt find 'proxy' == -1)) then {ALL_OBJS_TO_SEARCH_C pushBack _t;};
                        };
                    };
                };
            };
        };
    };
};

//Test de la nuit plus belle
_adjustLight = 
{
	_brightness = if (CHBN_adjustBrightness > 0) then {200 * abs (1 - (2 ^ CHBN_adjustBrightness))} else {0};
	CHBN_light setLightAttenuation [10e10,(30000 / (_brightness max 10e-10)),4.31918e-005,4.31918e-005];
	CHBN_light setLightAmbient CHBN_adjustColor;
};

CHBN_adjustBrightness = missionNamespace getVariable ["CHBN_adjustBrightness",1.10];
CHBN_adjustColor = missionNamespace getVariable ["CHBN_adjustColor",[0.3,0.5,1]];

if (!isNil "CHBN_light") then {deleteVehicle CHBN_light};
CHBN_light = "#lightpoint" createVehicleLocal [0,0,0];
CHBN_light setLightBrightness 1;
CHBN_light setLightDayLight false;
call _adjustLight;

//Stress 
ALF_Stress = profileNamespace getVariable ["alf_stress",100];
if (!(typeName ALF_Stress == "SCALAR")) then 
{
	ALF_Stress = 100;
	ALF_Stress = profileNamespace setVariable ["alf_stress",100];
};

//Maladies
// if (count(alf_deseases) > 0) then 
// {
// 	[] spawn 
// 	{
// 		{
// 			[(_x select 0)] spawn ALF_fnc_handleDesease;
// 		} forEach alf_deseases;
// 	};
// };

private _cacheStaticModels = [];
private _vehicleClasses = "isClass _x && (configName _x) isKindOf 'Static'" configClasses (configFile >> "CfgVehicles");

{
    private _model = getText (_x >> "model");
    if (_model != "") then 
	{
        private _array = _model splitString "\";
        _cacheStaticModels pushBackUnique toLower (_array select ((count _array) - 1));
    };
} forEach _vehicleClasses;

private _nonAIVehicleClasses = "isClass _x" configClasses (configFile >> "CfgNonAIVehicles");

private _cfgBase = configFile >> "CfgNonAIVehicles";
{
    private _model = getText (_x >> "model");
    if (_model != "") then 
	{
        private _array = _model splitString "\";
        _cacheStaticModels pushBackUnique toLower (_array select ((count _array) - 1));
    };
} forEach (_nonaivehicleClasses select {(configName _x) isKindOf ["Bridge_base_F", _cfgBase]});

uiNamespace setVariable ["cacheStaticModels", compileFinal str _cacheStaticModels];

// SYSTEME ENDURANCE DESACTIVE - ALF_fnc_changeSpeed supprime
// [] spawn ALF_fnc_changeSpeed;
[] call ALF_fnc_turtleHold_init;

// quittage de group de la mission
[player] joinSilent grpNull;

player setVariable ["tf_sendingDistanceMultiplicator", 10.0];
[] spawn ALF_fnc_inventaire_controlleur;
call ALF_fnc_incendie_initPlayer;


// Détection sexe pour Magasin
private _visage = tolower (face player);
private _liste_Tete_Femmes = ["elena","female","rbcc"];
private _cfg_Texture_Tete = tolower (gettext (configfile >> "CfgFaces" >> "Man_A3" >> _visage >> "texture"));

if ("fem_" in _visage OR {"tcgm_" in _visage OR {(count (_liste_Tete_Femmes select {_x in _visage}) > 0) OR {"femal3" in _cfg_Texture_Tete}}}) then 
{
    License_Femme = true;
};

call MRP_Rubalise_fnc_rubalise_init;

