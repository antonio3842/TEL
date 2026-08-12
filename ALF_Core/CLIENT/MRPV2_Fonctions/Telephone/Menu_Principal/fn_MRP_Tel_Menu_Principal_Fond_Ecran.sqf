// MRPV2_fnc_MRP_Tel_Menu_Principal_Fond_Ecran = {
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];

private _liste_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
private _fond = _liste_Configuration # 3 # 0;

if ("MRP_Item_Neogend" in str assignedItems player) then
{
	private _perm = _liste_Configuration # 3 # 1 # 1;
	private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;

	if (_permission_Joueur isnotequalto _perm) then {(_liste_Configuration # 3) set [1,["",""]];};

	_fond = _liste_Configuration # 3 # 1 # 0;

	if (_fond isequalto "") then
	{
		if (_permission_Joueur isEquaLTo "GN") exitwith {_fond = "Neogend_Fond_GN_1";};
		if (_permission_Joueur isEquaLTo "SP") exitwith {_fond = "Neogend_Fond_SP_1";};
		if (_permission_Joueur isEquaLTo "AP") exitwith {_fond = "Neogend_Fond_AP_1";};

		_fond = "Neogend_Fond_Neutre";
	};

	(_liste_Configuration # 3) set [1,[_fond,_permission_Joueur]];
};

if (_fond isequalto "Perso") then
{
	private _Telephone_Fond_HTML = uiNamespace getVariable ["MRP_Telephone_Fond_HTML",controlNull];
	_Telephone_Fond_HTML htmlLoad "phone1080_11_637.html";
} else
{
	_Telephone_Fond ctrlSetText "MRP_Telephones\Data\Fond\" + _fond + ".paa";
};

TRUE
// };