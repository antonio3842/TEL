private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];

// ===== Réglage de la position verticale du téléphone à l'écran =====
private _decalage_Y_Iphone = -0.15;
private _decalage_Y_Neogend = -0.05;
// ====================================================================

private _y = 0.005 + _decalage_Y_Iphone;
if ("MRP_Item_Neogend" in str (assignedItems player)) then {_y = -0.05 + _decalage_Y_Neogend;};

// Creation controlGroup pour l'heure
private _ctrl_Fond_Info_Iphone = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1];
_ctrl_Fond_Info_Iphone ctrlSetPosition [0.65,_y,0.56,0.1];
_ctrl_Fond_Info_Iphone ctrlCommit 0;

private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_ctrl_Fond_Info_Iphone];
_ctrl_Image ctrlSetPosition [0.39,0.04,0.13,0.05];
_ctrl_Image ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_Fond_Etat_dxt5.paa";
_ctrl_Image ctrlCommit 0;

private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_ctrl_Fond_Info_Iphone];
uiNamespace setVariable ["MRPV2_fnc_MRP_Tel_Init_Etat_Reseau",_ctrl_Image];
_ctrl_Image ctrlSetPosition [0.39,0.04,0.13,0.05];

if (player getvariable ["MRP_Telephone_Mode_Avion",FALSE]) then
{
	_ctrl_Image ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_Mode_Avion.paa";
} else
{
	_ctrl_Image ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_Reseau_dxt5.paa";
};

_ctrl_Image ctrlCommit 0;

private _ctrl_Image = _Telephone_Base ctrlCreate ["RscPicture",-1,_ctrl_Fond_Info_Iphone];
_ctrl_Image ctrlSetPosition [0.39,0.04,0.13,0.05];
_ctrl_Image ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_Batterie_dxt5.paa";
_ctrl_Image ctrlCommit 0;

private _edit = _Telephone_Base ctrlCreate ["RscBackground",-1,_ctrl_Fond_Info_Iphone];
_edit ctrlSetPixelPrecision 2;

private _temps_Serveur_Max = (SERVER_TotalSessionTime / 60 / 60);

[
	{params ["_args", "_pfID"];
		_args params ["_temps_Serveur_Max","_edit","_Telephone_Base"];

		if (isnull _Telephone_Base) exitwith {[_pfID] call CBA_fnc_removePerFrameHandler;};

		private _temps_Serveur =  SERVER_TotalSessionTime - servertime;
		private _remplissage_Barre = (linearConversion [0,SERVER_TotalSessionTime,_temps_Serveur,0,0.023]) max 0.004;

		private _couleur_Rouge = linearConversion [SERVER_TotalSessionTime,0,_temps_Serveur,0,1];
		private _couleur_Verte = linearConversion [0,SERVER_TotalSessionTime,_temps_Serveur,0,1];

		private _pourcentage_Remplissage = (_remplissage_Barre * 100) / 0.023;

		[] call
		{
			if (_pourcentage_Remplissage > 70) exitwith {_couleur_Verte = 1; _couleur_Rouge = 0;};
			if (_pourcentage_Remplissage <= 70 AND {_pourcentage_Remplissage > 40}) exitwith {_couleur_Verte = 0.5; _couleur_Rouge = 1;};
			if (_pourcentage_Remplissage <= 40 AND {_temps_Serveur > 1800}) exitwith {_couleur_Verte = 0; _couleur_Rouge = 1;};

			if (_temps_Serveur <= 1800) then
			{
				_couleur_Verte = 0;
				_couleur_Rouge = 1;
				_remplissage_Barre = 0.004;

				if (ctrlText _edit isEquaLTo "") then
				{
					_edit ctrlsetText "Clignotant";

					[
						{params ["_args", "_pfID"];
							_args params ["_edit","_Telephone_Base"];

							if (isnull _Telephone_Base) exitwith {[_pfID] call CBA_fnc_removePerFrameHandler;};

							if (ctrlfade _edit isEqualTo 1) then
							{
								_edit ctrlsetfade 0;
								_edit ctrlCommit 0.5;
							} else
							{
								_edit ctrlsetfade 1;
								_edit ctrlCommit 0.5;
							};
						},
						1,
						[_edit,_Telephone_Base]
					] call CBA_fnc_addPerFrameHandler;
				};
			};
		};

		_edit ctrlSetPosition [0.467,0.056,_remplissage_Barre,0.015];
		_edit ctrlSetBackgroundColor [_couleur_Rouge,_couleur_Verte,0,1];
		_edit ctrlCommit 0;
	},
	180,
	[_temps_Serveur_Max,_edit,_Telephone_Base]
] call CBA_fnc_addPerFrameHandler;

TRUE