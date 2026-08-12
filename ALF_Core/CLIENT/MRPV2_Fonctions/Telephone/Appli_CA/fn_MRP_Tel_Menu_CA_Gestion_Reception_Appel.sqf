// MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Reception_Appel = {
private _numero = param [0,""];
private _duree_Appel = param [1,0];
private _id_Appelant = param [2,0];
private _numero_Masquer = param [3,FALSE];
private _mode_Entreprise = param [4,FALSE];

if (player getvariable ["MRP_Telephone_Mode_Avion",FALSE]) exitwith {};
private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_CA_ctrl_Liste_Controle_Canaux",controlNull];
private _liste_Tous_Ctrl = (allControls _ctrl_Liste_Controle_Canaux) select {ctrlClassName _x isEqualTo "RscControlsGroupNoScrollbars" AND {ctrltooltip _x isNotEqualTo ""}};

if (_ctrl_Liste_Controle_Canaux isNotEquaLTo controlNull) then
{
	private _ctrl_Ouvert = (_liste_Tous_Ctrl select {(ctrlposition _x # 3) isEqualTo 0.26}) # 0;

	private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
	private _nombre_Appel = count _tel_CA_Info_Ope;

	if !(isnil {_ctrl_Ouvert}) then {if ((ctrlposition _ctrl_Ouvert # 3) > 0.12) then {_nombre_Appel = _nombre_Appel + 1;};};

	[_numero,_duree_Appel,"",_nombre_Appel,_id_Appelant,_numero_Masquer,_mode_Entreprise] call MRPV2_fnc_MRP_Tel_Menu_CA_Ajout_Cadre_Appel;
};

private _appli = "CENTRE APPEL";

[] call
{
	private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
	if (_permission_Joueur isequalto "GN") exitwith {_appli = "CORG";};
	if (_permission_Joueur isequalto "SP") exitwith {_appli = "CTA";};
	if (_permission_Joueur isequalto "AP") then {_appli = "DSPOM";};
};

if (_numero_Masquer) then 
{
	_numero = "Numéro masqué";
} else
{
	if (_mode_Entreprise) then
	{
		private _joueur_Destinataire = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (_numero)}) # 0;
		_numero = _joueur_Destinataire getVariable ["entreprise",""];
	} else {

	_numero = _numero insert [2," "];
	_numero = _numero insert [5," "];
	_numero = _numero insert [8," "];
	_numero = _numero insert [11," "];
	};
};

[_numero,format ["<t color='#ffffff' align='center'>Appel en attente dans l%1application : %2</t>",'''',_appli],"info"] spawn ALF_fnc_doMsg;

TRUE
// };