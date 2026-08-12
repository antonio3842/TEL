/*
	File: fn_menuXP.sqf
	Author: ALF Adam
*/

if(!dialog) then {createDialog "xpmenu"};
disableSerialization;
_display = findDisplay 98765;

_xp1 = _display displayCtrl 98769;
_xp2 = _display displayCtrl 98770;
_xp3 = _display displayCtrl 98771;
_xp4 = _display displayCtrl 98772;
_xp5 = _display displayCtrl 98773;
_xp6 = _display displayCtrl 98774;
_xp7 = _display displayCtrl 98775;
_xp8 = _display displayCtrl 98776;
_xp9 = _display displayCtrl 98777;
_xp10 = _display displayCtrl 98778;

_xptxt = _display displayCtrl 98768;

private _menu = uiNamespace getVariable["xpmenu",0];
private _xp = 
[
//Banane						//Buche										//Champignon 							//Tabac							//Mais				
	[
		["\ALF_Client2\textures\XP\pomme",666],["\ALF_Client2\textures\XP\peche",666],["\ALF_Client2\textures\XP\buche",750],["\ALF_Client2\textures\XP\mais",750],
		["\ALF_Client2\textures\XP\raisin",1166],["",0],["",0],["",0],["",0],["",0]
	],
	[
		["\ALF_Client2\textures\XP\pierre",666],["\ALF_Client2\textures\XP\cuivre",666],["\ALF_Client2\textures\XP\fer",666],["\ALF_Client2\textures\XP\saphir",1166],
		["\ALF_Client2\textures\XP\bidon",1500],["\ALF_Client2\textures\XP\petrole",1500],["\ALF_Client2\textures\XP\diamant",1500],
		["\ALF_Client2\textures\XP\pepiteor",1500],["",0],["",0]
	],
	[
		["\ALF_Client2\textures\XP\macro",666],["\ALF_Client2\textures\XP\sardine",666],["\ALF_Client2\textures\XP\thon",666],["\ALF_Client2\textures\XP\barbeau",1166],
		["\ALF_Client2\textures\XP\brochet",1166],["\ALF_Client2\textures\XP\anguille",1166],["\ALF_Client2\textures\XP\tortue",1500],["\ALF_Client2\textures\XP\saumon",1500],
		["\ALF_Client2\textures\XP\squale",1500],["",0]
	],
	[
		["\ALF_Client2\textures\XP\weed",500],["\ALF_Client2\textures\XP\cocaine",500],["\ALF_Client2\textures\XP\meth",1750],["\ALF_Client2\textures\XP\artefact",4500],
		["",0],["",0],["",0],["",0],["",0],["",0]
	]
];

private _alfxp = [alf_xp_recolte,alf_xp_minage,alf_xp_peche,alf_xp_illegal];
private _alfniv = [alf_niv_recolte,alf_niv_minage,alf_niv_peche,alf_niv_illegal];

private _idc_actual = 98769;
{
	if ((_x select 0) isEqualTo "") then {
		(_display displayCtrl _idc_actual) ctrlSetText "";
	} else {
		if (([alf_niv_recolte,alf_niv_minage,alf_niv_peche,alf_niv_illegal] select _menu) >= _forEachIndex) then {
			(_display displayCtrl _idc_actual) ctrlSetText ((_x select 0) + "1.paa");
		} else {
			(_display displayCtrl _idc_actual) ctrlSetText ((_x select 0) + "2.paa");
		};
	};
	_idc_actual = _idc_actual + 1;
} forEach (_xp select _menu);

_xptxt ctrlSetStructuredText parseText format["<t align='left' color='#000000' shadow='0' size='1px'>%1</t>",[_alfxp select _menu] call ALF_fnc_numberText];


/*
private _xp = [
				[["\ALF_Client2\textures\XP\pomme",666],["\ALF_Client2\textures\XP\peche",666],["\ALF_Client2\textures\XP\buche",666],["\ALF_Client2\textures\XP\mais",1166],["\ALF_Client2\textures\XP\raisin",1166],["\ALF_Client2\textures\XP\huitre",1166],["\ALF_Client2\textures\XP\champignon",1500],["\ALF_Client2\textures\XP\tabac",1500],["\ALF_Client2\textures\XP\fraise",1500],["\ALF_Client2\textures\XP\truffe",1500]],
				[["\ALF_Client2\textures\XP\pierre",666],["\ALF_Client2\textures\XP\cuivre",666],["\ALF_Client2\textures\XP\fer",666],["\ALF_Client2\textures\XP\bronze",1166],["\ALF_Client2\textures\XP\argent",1166],["\ALF_Client2\textures\XP\saphir",1166],["\ALF_Client2\textures\XP\bidon",1500],["\ALF_Client2\textures\XP\petrole",1500],["\ALF_Client2\textures\XP\diamant",1500],["\ALF_Client2\textures\XP\pepiteor",1500]],
				[["\ALF_Client2\textures\XP\macro",666],["\ALF_Client2\textures\XP\sardine",666],["\ALF_Client2\textures\XP\thon",666],["\ALF_Client2\textures\XP\barbeau",1166],["\ALF_Client2\textures\XP\brochet",1166],["\ALF_Client2\textures\XP\anguille",1166],["\ALF_Client2\textures\XP\tortue",1500],["\ALF_Client2\textures\XP\saumon",1500],["\ALF_Client2\textures\XP\squale",1500],["",0]],
				[["\ALF_Client2\textures\XP\weed",500],["\ALF_Client2\textures\XP\cocaine",500],["\ALF_Client2\textures\XP\meth",1750],["\ALF_Client2\textures\XP\artefact",4500],["",0],["",0],["",0],["",0],["",0],["",0]]
			  ];

_xptxt ctrlSetStructuredText parseText format["<t align='left' color='#000000' shadow='0' size='1px'>%1 XP</t>",[_alfxp select _menu] call ALF_fnc_numberText];


*/