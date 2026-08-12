// MRPV2_fnc_MRP_Tel_Menu_Reglages_Gestion_Options_Actives = {
private _initialisation = param [0,FALSE];
private _liste_Idc = param [1,[]];
private _type_Bouton = param [2,0];


private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
private _option_Activer = _telephone_Configuration # _type_Bouton;

if (_initialisation AND {!_option_Activer}) exitwith {TRUE};

if !(_initialisation) then {_option_Activer = !_option_Activer;};

private _ctrl_Fond = _liste_Idc # 0;
private _ctrl_Bouton =  _liste_Idc # 1;

private _temps_Action = 0;
private _pos_Bouton = ctrlPosition _ctrl_Bouton;
private _decalage_X = 0.026;

if (_option_Activer) then
{
	if !(_initialisation) then
	{
		_telephone_Configuration set [_type_Bouton,TRUE];
		_temps_Action = 0.2;
	};

	_ctrl_Bouton ctrlSetPosition [(_pos_Bouton # 0) + _decalage_X,(_pos_Bouton # 1),(_pos_Bouton # 2),(_pos_Bouton # 3)];
	_ctrl_Bouton ctrlCommit _temps_Action;

	_ctrl_Fond ctrlSetFade 0;
	_ctrl_Fond ctrlCommit _temps_Action;

	if (_type_Bouton isEquaLTo 0) then
	{
		player setVariable ["MRP_Telephone_Mode_Avion",TRUE];

		private _Telephone_Etat_Reseau = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Init_Etat_Reseau",controlNull];
		_Telephone_Etat_Reseau ctrlSetText "MRP_Telephones\Data\Menu_Principal\Icone_Mode_Avion.paa";

		[false] call MRPV2_fnc_MRP_Tel_Divers_Prise_Service_CA;
	};
} else
{
	if !(_initialisation) then
	{
		_telephone_Configuration set [_type_Bouton,FALSE];
		_temps_Action = 0.2;
	};

	_ctrl_Bouton ctrlSetPosition [(_pos_Bouton # 0) - _decalage_X,(_pos_Bouton # 1),(_pos_Bouton # 2),(_pos_Bouton # 3)];
	_ctrl_Bouton ctrlCommit _temps_Action;

	_ctrl_Fond ctrlSetFade 1;
	_ctrl_Fond ctrlCommit _temps_Action;

	if (_type_Bouton isEquaLTo 0) then
	{
		player setVariable ["MRP_Telephone_Mode_Avion",FALSE];

		private _Telephone_Etat_Reseau = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Init_Etat_Reseau",controlNull];
		_Telephone_Etat_Reseau ctrlSetText "MRP_Telephones\Data\Menu_Principal\Icone_Reseau_dxt5.paa";

		[true] call MRPV2_fnc_MRP_Tel_Divers_Prise_Service_CA;
	};
};

TRUE
// };