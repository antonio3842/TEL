// MRPV2_fnc_MRP_Tel_Init_Heure = {
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
_ctrl_Image ctrlSetPosition [0.04,0.04,0.13,0.05];
_ctrl_Image ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_Fond_Heure_dxt5.paa";
_ctrl_Image ctrlCommit 0;


// Cadran Heure
_edit = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_ctrl_Fond_Info_Iphone];
uiNamespace setVariable ["MRP_Telephone_Cadran_Heure",_edit];
_edit ctrlSetPosition [0.072,0.044,0.07,0.04];
_edit ctrlCommit 0;
_edit ctrlSetText "";

[
	{params ["_args", "_pfID"];
		_args params ["_Telephone_Base"];

		[] call MRPV2_fnc_MRP_Tel_Init_Gestion_Anim_Affichage;

		if (isnull _Telephone_Base) exitwith {[_pfID] call CBA_fnc_removePerFrameHandler;};

		private _joueur_Mort_Ou_A_Terre = lifeState player in ["INCAPACITATED","DEAD"];
		if (_joueur_Mort_Ou_A_Terre) then
		{
			closedialog 2;
		};

		private _heure = (systemTimeUTC # 3) + UTC_DIFF;
		private _minute = ([(systemTimeUTC # 4)] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;

		if (_heure >= 24) then
		{
			_heure = ([_heure - 24] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
		} else
		{
			_heure = ([_heure] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
		};

		private _cadre_SMS = uiNamespace getVariable ["MRP_Telephone_Cadran_Heure",displayNull];
		_cadre_SMS ctrlSetStructuredText parsetext format ["<t shadow='0' color='#000000' size='1' align='left'>%1:%2</t>",_heure,_minute];
	},
	0.1,
	[_Telephone_Base]
] call CBA_fnc_addPerFrameHandler;

TRUE
// };