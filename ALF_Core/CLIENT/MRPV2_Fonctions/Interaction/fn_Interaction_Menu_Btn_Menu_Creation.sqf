// MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation = {
private _menu = param [0,""];
private _num = param [1,-1];

private _taille_Menu_Allonger = count _menu;

private _MRPV2_Interface_Base = uiNamespace getVariable ["MRPV2_Interface_Diverse",controlnull];
private _ctrlGroup_Menu_Inter = uinamespace getVariable ["_ctrlGroup_Menu_Inter",controlnull];

private _pos_Debut_Btn_Menu_Y = 0.74;
private _ecart_Pos_Btn_Menu_Y = 0.06;

private _nombre_Btn_Menu = _MRPV2_Interface_Base getVariable ["_nombre_Btn_Menu",0];

_MRPV2_Interface_Base displayAddEventHandler ["Unload",
{params ["_ctrl"];
	uiNamespace setVariable ["bob",nil];
}];

private _ctrlButton = _MRPV2_Interface_Base ctrlCreate ["Life_RscButtonMenu",-1,_ctrlGroup_Menu_Inter];
_ctrlButton ctrlSetPosition [1.7,_pos_Debut_Btn_Menu_Y + (_nombre_Btn_Menu * _ecart_Pos_Btn_Menu_Y),0.05,0.045];
_ctrlButton ctrlSetBackgroundColor [0.17,0.22,0.3,0.9];
_ctrlButton ctrlSetText _menu;
_ctrlButton ctrlCommit 0;

if (_num isequalto 0) then 
{
	_ctrlButton ctrlSetPositionw (0.05 + (_taille_Menu_Allonger * 0.011));
	_ctrlButton ctrlCommit 0.2;
	_ctrlButton ctrlSetBackgroundColor [0.6,0.5,0,0.9];

	uiNamespace setVariable ["boba",_ctrlButton];
} else
{
	// [_ctrlButton,_taille_Menu_Allonger] spawn 
	// {params ["_ctrlButton","_taille_Menu_Allonger"];
	// 	_ctrlButton ctrlSetPositionw 0.05 + (_taille_Menu_Allonger * 0.011);
	// 	_ctrlButton ctrlCommit 0.3;

	// 	sleep 0.5;

	// 	_ctrlButton ctrlSetPositionw 0.05;
	// 	_ctrlButton ctrlCommit 0.5;
	// };
};

_MRPV2_Interface_Base setVariable ["_nombre_Btn_Menu",_nombre_Btn_Menu + 1];
_ctrlButton setvariable ["_taille_Menu_Allonger",_taille_Menu_Allonger];

_ctrlButton ctrlAddEventHandler ["MouseButtonClick",
{params ["_ctrl"];
	[] call
	{
		if (tolower (ctrltext _ctrl) isequalto tolower "Civil") exitwith 
		{
			uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",0];
			[] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr;
			private _liste_Actions = [] call MRPV2_fnc_Interaction_Joueurs_Civ;
			[_liste_Actions get "Civil"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;	
		};

		if (tolower (ctrltext _ctrl) isequalto tolower "GN - Base") exitwith 
		{
			uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",1];
			[] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr;
			private _liste_Actions = [] call MRPV2_fnc_Interaction_Joueurs_GN;
			[_liste_Actions get "GN - Base"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;
		};

		if (tolower (ctrltext _ctrl) isequalto tolower "PM - Base") exitwith 
		{
			uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",2];
			[] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr;
			private _liste_Actions = [] call MRPV2_fnc_Interaction_Joueurs_PM;
			[_liste_Actions get "PM - Base"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;		
		};

		if (tolower (ctrltext _ctrl) isequalto tolower "GN - Gestion grade") exitwith 
		{
			uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",2];
			[] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr;
			private _liste_Actions = [] call MRPV2_fnc_Interaction_Joueurs_GN;
			[_liste_Actions get "GN - Gestion grade"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;		
		};
		
		if (tolower (ctrltext _ctrl) isequalto tolower "PM - Gestion grade") exitwith 
		{
			uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",2];
			[] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr;
			private _liste_Actions = [] call MRPV2_fnc_Interaction_Joueurs_PM;
			[_liste_Actions get "PM - Gestion grade"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;		
		};

		if (tolower (ctrltext _ctrl) isequalto tolower "GN - Gestion spécialité") exitwith 
		{
			uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",2];
			[] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr;
			private _liste_Actions = [] call MRPV2_fnc_Interaction_Joueurs_GN;
			[_liste_Actions get "GN - Gestion spécialité"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;		
		};

		if (tolower (ctrltext _ctrl) isequalto tolower "SP - Base") exitwith 
		{
			uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",2];
			[] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr;
			private _liste_Actions = [] call MRPV2_fnc_Interaction_Joueurs_SP;
			[_liste_Actions get "SP - Base"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;		
		};

		if (tolower (ctrltext _ctrl) isequalto tolower "SP - Gestion grade") exitwith 
		{
			uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",2];
			[] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr;
			private _liste_Actions = [] call MRPV2_fnc_Interaction_Joueurs_SP;
			[_liste_Actions get "SP - Gestion grade"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;		
		};

		if (tolower (ctrltext _ctrl) isequalto tolower "Pref - Gestion licences") exitwith 
		{
			uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",2];
			[] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr;
			private _liste_Actions = [] call MRPV2_fnc_Interaction_Joueurs_Pref;
			[_liste_Actions get "Pref - Gestion licences"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;		
		};

		if (tolower (ctrltext _ctrl) isequalto tolower "Entreprise") exitwith 
		{
			uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",3];
			[] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Suppr;
			private _liste_Actions = [] call MRPV2_fnc_Interaction_Joueurs_Ent;
			[_liste_Actions get "Entreprise"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;		
		};
	};

	private _taille_Menu_Allonger = _ctrl getvariable ["_taille_Menu_Allonger",0];
	_ctrlButton ctrlSetPositionw (0.05 + (_taille_Menu_Allonger * 0.01));
	_ctrlButton ctrlCommit 0.2;

	uiNamespace setVariable ["bob",ctrltext _ctrl];

	private _boba = uiNamespace getVariable ["boba",controlnull];
	if (_boba isnotequalto _ctrl) then 
	{
		_boba ctrlSetPositionw (0.02 * safeZoneW);	
		_boba ctrlCommit 0.1;

		uiNamespace setVariable ["boba",_ctrl];
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseEnter",
{params ["_ctrl"];
	_bob = uiNamespace getVariable ["bob",""];
	if (tolower (ctrltext _ctrl) isNotequalto tolower _bob) then 
	{
		private _taille_Menu_Allonger = _ctrl getvariable ["_taille_Menu_Allonger",0];
		_ctrl ctrlSetPositionw (0.05 + (_taille_Menu_Allonger * 0.011));
		_ctrl ctrlCommit 0.2;		
	};
}];

_ctrlButton ctrlAddEventHandler ["MouseExit",
{params ["_ctrl"];
	_bob = uiNamespace getVariable ["bob",""];
	if (tolower (ctrltext _ctrl) isNotequalto tolower _bob) then 
	{
		[_ctrl] spawn 
		{params ["_ctrl"];
			sleep 0.2;
			_ctrl ctrlSetPositionw (0.02 * safeZoneW);	
			_ctrl ctrlCommit 0.4;	
			ctrlSetFocus controlnull;
			_ctrl ctrlActivate false;
			_ctrl ctrlActivate true;					
		};
	};
}];
// };