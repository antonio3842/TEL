private _ctrlButton_Arret = param [0,controlNull];
private _numero = param [1,""];


private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
private _info_Appel_CA_Ope = _tel_CA_Info_Ope get _numero;
private _liste_id_Appelants = _info_Appel_CA_Ope # 2;

// S'il y a juste un appellant et un opérateur en ligne
if (count _liste_id_Appelants isequalto 2) then
{
	private _Rscframe = _control getvariable ["_Rscframe",controlNull];

	_Rscframe ctrlsettextcolor [0.9,0.38,0.16,1];
	_control ctrlsetfade 0.7;
	_control ctrlCommit 0.3;

	_ctrlButton_Arret ctrlenable false;
	_ctrlButton_Arret ctrlsetfade 0.7;
	_ctrlButton_Arret ctrlCommit 0;

	private _liste_Unites_En_Service = (allplayers select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)isEquaLTo ([] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)});
	[_numero,"Pause"] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Couleur_Cadre",_liste_Unites_En_Service];
} else
{
	if (_CG_Options isnotequalto controlNull) then
	{
		private _ctrlButton_Pause = _CG_Options getvariable ["_ctrlButton_Pause",controlNull];
		_ctrlButton_Pause ctrlenable false;
		_ctrlButton_Pause ctrlsetfade 0.7;
		_ctrlButton_Pause ctrlCommit 0;

		_ctrlButton_Arret ctrlenable false;
		_ctrlButton_Arret ctrlsetfade 0.7;
		_ctrlButton_Arret ctrlCommit 0;
	};
};

if (_CG_Options isnotequalto controlNull) then
{
	private _ctrlButton_Accepter = _CG_Options getVariable ["_ctrlButton_Accepter",controlNull];
	_ctrlButton_Accepter ctrlenable true;
	_ctrlButton_Accepter ctrlsetfade 0;
	_ctrlButton_Accepter ctrlCommit 0.3;
	_ctrlButton_Accepter ctrlsettextcolor [0.9,0.9,0.9,1];
};

TRUE