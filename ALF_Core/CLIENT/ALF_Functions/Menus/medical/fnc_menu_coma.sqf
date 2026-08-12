5 fadeSound 0.1;
if ((player getVariable ["tf_globalVolume", 1]) > 0) then {player setVariable ["tf_globalVolume", 0.1, true]};
if ((player getVariable ["tf_voiceVolume", 1]) > 0) then {player setVariable ["tf_voiceVolume", 0, true]};

"ath_coma" cutRsc ["ath_coma","PLAIN"];
closeDialog 0;

#define ATH(ctrl) ((uiNamespace getVariable ["ath_coma",displayNull]) displayCtrl ctrl)
#define FDISPLAY(ctrl) ((findDisplay 4333) displayCtrl ctrl)

// rsctitle
#define IDC_SWAG_ST_TEXT 1722
#define IDC_SWAG_I_BACK	1822
// rscstd
#define IDC_SWAG_B_APPEL	2222
#define IDC_SWAG_B_RESPAWN	2223

#define PgV(var) (player getVariable var)

{ detach _x; } forEach attachedObjects player; // we never know

tmp_coma_menu = {
	createDialog "COMA";
	FDISPLAY(IDC_SWAG_B_APPEL) ctrlSetText "Appeler les secours";
	FDISPLAY(IDC_SWAG_B_RESPAWN) ctrlEnable false;
	FDISPLAY(IDC_SWAG_B_RESPAWN) ctrlSetText "Réapparaître";
	if (!isNil "tmp_coma_menu_respawn") then {
		FDISPLAY(IDC_SWAG_B_APPEL) ctrlEnable false;
		FDISPLAY(IDC_SWAG_B_APPEL) ctrlSetText "Appel envoyé aux secours !";
	};

	FDISPLAY(IDC_SWAG_B_APPEL) ctrlAddEventHandler ["ButtonClick",{
		if (!isNil "tmp_coma_menu_respawn") exitWith {};
		systemChat "APPEL SENT";
		FDISPLAY(IDC_SWAG_B_APPEL) ctrlEnable false;
		FDISPLAY(IDC_SWAG_B_APPEL) ctrlSetText "Appel envoyé aux secours !";
		player call MRPV2_fnc_MRP_Coma_Notification;
	}];

	FDISPLAY(IDC_SWAG_B_RESPAWN) ctrlAddEventHandler ["ButtonClick",{
		tmp_pending_respawn = true;
		call CLIENT_fnc_menu_comaClose;
		[player] call MRPV2_fnc_MRP_Coma_Suppression_Marqueur;
		["RESPAWN",format["[PLAYER:%1] a décidé de RESPAWN comme un gros lâche",(player getvariable "intraID")]] spawn CLIENT_fnc_LOG;
		forceRespawn player;
	}];
};

// different coma messages
_messages = ["Et bien.. Nous pouvons dire que vous êtes dans une situation bien délicate..."
, "Suite a une conjoncture d'évenements pas spécialement en votre faveur..."
, "De malheureux inconvénients sont survenus..."
, "Vous avez probablement déjà vécu des jours meilleurs..."
, "Cette fois-ci, ce n'est pas une simple entorse..."
, "Pas de chance ¯\_(ツ)_/¯ !"
, "C'était probablement pas votre jour de chance..."
, "Bon.. Vous êtes dans de beaux draps..."
, "Vous avez probablement déjà vécu des jours meilleurs..."
, "Finalement, est-ce que la mort est une fin en soi ?"
, "Il n'y a pas de honte à être dans cet état, enfin presque..."
, "Vous savez, il n'y a pas de bonne ou de mauvaise situation, juste des rencontres..."
, "Ne paniquez pas, ca va bien se passer..."
, "Bon, ca craint."
, "Il y a fort à parier que vous commencez à regretter vos choix..."
, "Gardez votre calme et respirez profondément...<br/>Hum attendez, ça risque de devenir compliqué..."
, "A priori vous n'êtes pas encore mort, c'est déjà une bonne chose..."];

_staticStr = format["<t size='2' font='PuristaBold'>Vous êtes inconscient</t><br/><br/>
<t size='1'>%1</t><br/><br/><br/>
<t size='1' font='PuristaBold'>Voici les causes de ce désagrément :</t><br/>
",selectrandom _messages];

[_staticStr] spawn {
	params ["_staticStr"];
	systemChat "COMA ATH LOOP START";
	while {!isNil {(uiNamespace getVariable "ath_coma")}} do 
	{
		if (isNull findDisplay 4333) then {call tmp_coma_menu;};
		if (PgV("isASYS")) then {FDISPLAY(IDC_SWAG_B_RESPAWN) ctrlEnable true;};
		if (!isNil {player getVariable "MRP_Coma_Info"} && ctrlEnabled FDISPLAY(IDC_SWAG_B_APPEL)) then {
			FDISPLAY(IDC_SWAG_B_APPEL) ctrlEnable false;
			FDISPLAY(IDC_SWAG_B_APPEL) ctrlSetText "Appel envoyé aux secours !";
		};

		_strCauses = "";
		switch (true) do {
			case (PgV("PAIN") > 5): {_strCauses = _strCauses + "- Vous avez extrêmement mal<br/>"};
			case (PgV("PAIN") > 2.8): {_strCauses = _strCauses + "- Vous avez très mal<br/>"};
			case (PgV("PAIN") > 1.5): {_strCauses = _strCauses + "- Vous avez mal<br/>"};
		};
		if (PgV("isFIB")) then {_strCauses = _strCauses +"- Votre coeur s'est emballé<br/>"};
		if (PgV("isASYS")) then {_strCauses = _strCauses +"- Vous êtes en arrêt cardiaque<br/>"};

		_dist_max_player = 90000;
		_dist_max_pompier = 90000;
		{
			_dist = (_x distance player);
			if ((lifeState _x) != "INCAPACITED" && _x != player) then {
				_playerCompanyID = ((_x getVariable ["service",objNull]) getVariable ["ent",[-1,""]])#0;
				if (_playerCompanyID == 19) then {
					if (_dist < _dist_max_pompier) then {_dist_max_pompier = _dist;};
				} else {
					if (_dist < _dist_max_player) then {_dist_max_player = _dist;};
				};
			};
		} forEach (call BIS_fnc_listPlayers);

		if (_dist_max_player == 90000) then {_dist_max_player = "Aucun..."} else {_dist_max_player = format["%1m",round(_dist_max_player)]};
		if (_dist_max_pompier == 90000) then {_dist_max_pompier = "Aucun..."} else {_dist_max_pompier = format["%1m",round(_dist_max_pompier)]};

		_timer = 1200;
		switch (true) do {
			case (PgV("isFIB")): {_timer = PgV("FIB_timer") + 360;};
			case (PgV("isASYS")): {_timer = PgV("ASYS_timer");};
		};

		_timerStr = "";
		switch (true) do {
			case (_timer >= 1200): {_timerStr = "<br/>Pour le moment, votre pronostic vital n'est pas engagé.";};
			case (_timer > 0): {_timerStr = format["<br/>Il ne vous reste qu'environ %1 minutes de survie.",round(_timer/60)];};
			case (_timer <= 0): {_timerStr = "<br/>Vous voyez la lumière";};
		};
		
		ATH(IDC_SWAG_ST_TEXT) ctrlSetStructuredText parseText format["%1<t size='1'>%2</t><br/><br/>Pompier le plus proche : %3<br/>Civil le plus proche : %4<br/><br/>Tenez-bon ! Vous pouvez toujours être réanimé par un bon samaritain.<br/>%5",
		_staticStr,_strCauses,_dist_max_pompier,_dist_max_player,_timerStr];
		sleep 0.05;
	};
};