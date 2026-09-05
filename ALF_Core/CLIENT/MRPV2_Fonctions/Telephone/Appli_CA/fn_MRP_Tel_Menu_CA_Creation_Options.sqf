// MRPV2_fnc_MRP_Tel_Menu_CA_Creation_Options = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

private _edit = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_edit ctrlSetPosition [0.35,0.2,0.15,0.07];
_edit ctrlSetBackgroundColor [0,0,0,0.3];
_edit ctrlSetText "Options";
_edit ctrlSetTextColor [1,1,1,1];
_edit ctrlSetFontHeight 0.06;
_edit ctrlSetShadow 0;
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButton ctrlSetPosition [0.35,0.2,0.15,0.07];
_ctrlButton ctrlCommit 0;
_ctrlButton setvariable ["_texte_Options",_edit];

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	playsound "MRP_Telephone_Touche_Appli";
	
	private _texte_Options = _control getvariable ["_texte_Options",controlNull];
	[_texte_Options] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

	private _ctrl_texte_Options = _control getvariable ["_texte_Options",controlNull];
	private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
	private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

	if (ctrltext _ctrl_texte_Options isequalto "Options") then
	{
		private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",controlNull];
		_ctrl_Liste_Controle_Canaux ctrlSetPosition [0.045,0.6,0.46,0.7];
		_ctrl_Liste_Controle_Canaux ctrlCommit 0.3;

		_Telephone_Cadre_Option = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_telephone_Cadre_Base];
		uiNamespace setVariable ["MRP_Telephone_Menu_Dispatch_Menu_Options",_Telephone_Cadre_Option];
		_Telephone_Cadre_Option ctrlSetPosition [0.05,0.25,0.4,0.35];
		_Telephone_Cadre_Option ctrlCommit 0;

		_ctrl_texte_Options ctrlSetText "Fermer";

		private _edit = _Telephone_Base ctrlCreate ["RscText",-1,_Telephone_Cadre_Option];
		_edit ctrlSetPosition [0,0,0.15,0.07];
		_edit ctrlSetText "Appel";
		_edit ctrlSetTextColor [1,1,1,1];
		_edit ctrlSetFontHeight 0.05;
		_edit ctrlSetShadow 0;
		_edit ctrlSetFont "SFUIDisplay_46";
		_edit ctrlSetFade 1;
		_edit ctrlCommit 0;
		_edit ctrlSetFade 0;
		_edit ctrlCommit 0.5;			

		private _RscPicture = _Telephone_Base ctrlCreate ["RscPicture",-1,_Telephone_Cadre_Option];
		_RscPicture ctrlSetPosition [0.1,0.15,0.08,0.09];
		_RscPicture ctrlSetText "MRP_icone_tel\Data\Icones_Applications\Icone_Options_CA_Muet.paa";
		_RscPicture ctrlSetTextColor [0.7,0.7,0.7,1];
		_RscPicture ctrlCommit 0;
		
		// Bouton Mute
		private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_Telephone_Cadre_Option];
		_ctrlButton ctrlSetPosition [0.1,0.15,0.08,0.09];
		_ctrlButton ctrlCommit 0;
		_ctrlButton ctrlsettooltip "Muter";
		_ctrlButton setvariable ["_RscPicture",_RscPicture];

		_ctrlButton ctrlAddEventHandler ["ButtonClick",
		{params ["_control"];
			[_control,1] spawn MRP_Gestion_Anti_Spam_Bouton;

			private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createHashMap] getorDefault ["Mon appel",["",""]];
			if (_tel_CA_Info_Ope isequalto ["",""]) exitwith {};

			private _RscPicture = _control getvariable "_RscPicture";

			// Démute
			if (isnil {MRP_Telephone_Est_Muter}) then
			{
				MRP_Telephone_Est_Muter = TRUE;

				_RscPicture ctrlSetTextColor [0,1,0,1];
				_control ctrlsettooltip "Démuter";

				["Déconnexion"] spawn MRPV2_fnc_MRP_Tel_Divers_Connexion_TFAR;
			} else
			{
				MRP_Telephone_Est_Muter = nil;

				_RscPicture ctrlSetTextColor [1,1,1,1];
				_control ctrlsettooltip "Muter";

				["Connexion"] spawn MRPV2_fnc_MRP_Tel_Divers_Connexion_TFAR;
			};
		}];

		_ctrlButton ctrlAddEventHandler ["MouseEnter",
		{params ["_control"];
			private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createHashMap] getorDefault ["Mon appel",["",""]];
			if (_tel_CA_Info_Ope isequalto ["",""]) exitwith {};

			private _RscPicture = _control getvariable "_RscPicture";

			if (isnil {MRP_Telephone_Est_Muter}) then
			{
				_RscPicture ctrlSetTextColor [1,1,1,1];
			} else
			{
				_RscPicture ctrlSetTextColor [0,1,0,1];
			};
		}];

		_ctrlButton ctrlAddEventHandler ["MouseExit",
		{params ["_control"];
			private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createHashMap] getorDefault ["Mon appel",["",""]];
			if (_tel_CA_Info_Ope isequalto ["",""]) exitwith {};

			private _RscPicture = _control getvariable "_RscPicture";

			if (isnil {MRP_Telephone_Est_Muter}) then
			{
				_RscPicture ctrlSetTextColor [0.8,0.8,0.8,1];
			} else
			{
				_RscPicture ctrlSetTextColor [0,0.8,0,1];
			};
		}];

		if (isnil {MRP_Telephone_Est_Muter}) then
		{
			_RscPicture ctrlSetTextColor [0.8,0.8,0.8,1];
		} else
		{
			_RscPicture ctrlSetTextColor [0,0.8,0,1];
		};

		// Bouton Volume +
		private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Option];
		_ctrlButton ctrlSetPosition [0.34,0.08,0.06,0.08];
		_ctrlButton ctrlCommit 0;
		_ctrlButton ctrlsettooltip "Volume +";
		_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Volume_Augmenter_dxt5.paa";

		_ctrlButton ctrlAddEventHandler ["ButtonClick",
		{params ["_ctrl"];
			private _volume = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume;

			if (_volume < 9) then
			{
				playSound "TFAR_rotatorPush";

				[(call TFAR_fnc_ActiveSwRadio),_volume + 1] call TFAR_fnc_setSwVolume;
				[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_showRadioVolume;

				[_ctrl] spawn MRP_Gestion_Effet_Bouton_Appuyer;
			};
		}];

		// Bouton Volume -
		private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_Telephone_Cadre_Option];
		_ctrlButton ctrlSetPosition [0.34,0.22,0.06,0.08];
		_ctrlButton ctrlCommit 0;
		_ctrlButton ctrlsettooltip "Volume -";
		_ctrlButton ctrlSetText "MRP_icone_tel\Data\Menu_Radio\Icone_Radio_Volume_Diminuer.paa";

		_ctrlButton ctrlAddEventHandler ["ButtonClick",
		{params ["_ctrl"];
			private _volume = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume;

			if (_volume > 0) then
			{
				playSound "TFAR_rotatorPush";

				[(call TFAR_fnc_ActiveSwRadio),_volume - 1] call TFAR_fnc_setSwVolume;
				[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_showRadioVolume;

				[_ctrl] spawn MRP_Gestion_Effet_Bouton_Appuyer;
			};
		}];
	} else
	{
		private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",controlNull];
		_ctrl_Liste_Controle_Canaux ctrlSetPosition [0.045,0.3,0.46,1];
		_ctrl_Liste_Controle_Canaux ctrlCommit 0.3;

		_ctrl_texte_Options ctrlSetText "Options";

		private _Menu_Options = uiNamespace getVariable ["MRP_Telephone_Menu_Dispatch_Menu_Options",controlNull];
		[_Menu_Options] spawn
		{params ["_Menu_Options"];
			{
				_x ctrlsetfade 1;
				_x ctrlcommit 0.3;
			} foreach allControls _Menu_Options;

			sleep 0.3;

			ctrlDelete _Menu_Options;
		};
	};

	[_control] spawn {params ["_control"]; uisleep 0.3; _control ctrlEnable TRUE;};
}];

TRUE
// };