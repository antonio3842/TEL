// MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat = {
private _numero = param [0,""];
private _type = param [1,""];
private _id = param [2,-1];
private _service = param [3,""];


private _liste_Unites_En_Service = (units group player);
_numero = _numero regexReplace [" ",""];

if (_type isequalto "Appel civil") exitwith
{
	private _numero_Masquer = player getvariable ["MRP_Telephone_Numero_Cacher",FALSE];
	private _mode_Entreprise = player getvariable ["MRP_Telephone_Mode_Entreprise",FALSE];
	player setvariable ["MRP_Tel_CA_Info_Appelant",[_numero,servertime,"",[_id],_numero_Masquer,_service,_mode_Entreprise],TRUE];
};

// script opérateur quand un civil les appel
if (_type isequalto "Appel civil maj opé") exitwith
{
	if (player getvariable ["MRP_Telephone_Mode_Avion",FALSE]) exitwith {};

	private _joueur_Appellant = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (_numero)}) # 0;
	
	[_joueur_Appellant,"MRP_Tel_CA_Info_Appelant"] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_syncSingleVar",2];


	[{params ["_joueur_Appellant"];
		_joueur_Appellant getvariable ["MRP_Tel_CA_Info_Appelant",[]] isnotequalto []
	},
	{params ["_joueur_Appellant"];
		private _tel_CA_Info_Appelant = _joueur_Appellant getvariable ["MRP_Tel_CA_Info_Appelant",[]];

		private _numero = _tel_CA_Info_Appelant # 0;
		private _duree_Appel = _tel_CA_Info_Appelant # 1;
		private _id_Appelant = _tel_CA_Info_Appelant # 3;
		private _numero_Masquer = _tel_CA_Info_Appelant # 4;
		private _mode_Entreprise = _tel_CA_Info_Appelant # 6;
		
		[_numero,_duree_Appel,_id_Appelant,_numero_Masquer,_mode_Entreprise] call MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Reception_Appel;
		
		private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];		
		_tel_CA_Info_Ope set [_numero,[_duree_Appel,"",_id_Appelant,_numero_Masquer,_mode_Entreprise]];
		player setvariable ["MRP_Tel_CA_Info_Operateur",_tel_CA_Info_Ope];		
	},[_joueur_Appellant],5,{}] call CBA_fnc_waitUntilAndExecute;
};

if (_type isequalto "Appel mon appel") exitwith
{
	private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
	_tel_CA_Info_Ope set ["Mon appel",[_numero,"Appel",_id]];
	player setvariable ["MRP_Tel_CA_Info_Operateur",_tel_CA_Info_Ope];
};

if (_type isequalto "Appel opé maj opé") exitwith
{
	private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
	private _tel_CA_Info_Ope_Num = _tel_CA_Info_Ope getorDefault [_numero,[]];
	private _liste_id_Appelants = _tel_CA_Info_Ope_Num # 2;

	_tel_CA_Info_Ope_Num set [1,"Appel"];
	_tel_CA_Info_Ope_Num set [2,_liste_id_Appelants + [_id]];

	player setvariable ["MRP_Tel_CA_Info_Operateur",_tel_CA_Info_Ope];

	[_numero,"Appel"] call MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Couleur_Cadre;
};

if (_type isequalto "Appel opé maj appelant") exitwith
{
	private _tel_CA_Info_Appelant = player getvariable ["MRP_Tel_CA_Info_Appelant",[]];
	private _liste_id_Appelants = _tel_CA_Info_Appelant # 3;

	_liste_id_Appelants pushback _id;

	_tel_CA_Info_Appelant set [2,"Appel"];
	_tel_CA_Info_Appelant set [3,_liste_id_Appelants];

	[player,["MRP_Tel_CA_Info_Appelant",_tel_CA_Info_Appelant]] remoteExec ["setvariable",_liste_Unites_En_Service];
};

if (_type isequalto "Pause civil simple") exitwith
{
	private _tel_CA_Info_Appelant = player getvariable ["MRP_Tel_CA_Info_Appelant",[]];
	private _liste_id_Appelants = _tel_CA_Info_Appelant # 3;

	_liste_id_Appelants = _liste_id_Appelants select {_x isnotequalto _id};
	_tel_CA_Info_Appelant set [2,"Pause"];
	_tel_CA_Info_Appelant set [3,_liste_id_Appelants];

	player setvariable ["MRP_Tel_CA_Info_Appelant",_tel_CA_Info_Appelant];
};

if (_type isequalto "Pause opé simple") exitwith
{
	private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
	private _tel_CA_Info_Ope_Num = _tel_CA_Info_Ope getorDefault [_numero,[]];
	private _tel_CA_Info_Ope_Mon_Appel = _tel_CA_Info_Ope getorDefault ["Mon appel",[]];
	private _liste_id_Appelants = _tel_CA_Info_Ope_Num # 2;

	_liste_id_Appelants = _liste_id_Appelants - [_id];

	_tel_CA_Info_Ope_Num set [1,"Pause"];
	_tel_CA_Info_Ope_Num set [2,_liste_id_Appelants];
	_tel_CA_Info_Ope_Mon_Appel set [1,"Pause"];

	player setvariable ["MRP_Tel_CA_Info_Operateur",_tel_CA_Info_Ope];

	[_numero,"Pause"] call MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Couleur_Cadre;
};

if (_type isequalto "Pause civil multi") exitwith
{
	private _tel_CA_Info_Appelant = player getvariable ["MRP_Tel_CA_Info_Appelant",[]];
	private _liste_id_Appelants = _tel_CA_Info_Appelant # 3;
	private _liste_id_Appelants_ope = _liste_id_Appelants select {_x isnotequalto _id};
	_tel_CA_Info_Appelant set [3,_liste_id_Appelants_ope];

	player setvariable ["MRP_Tel_CA_Info_Appelant",_tel_CA_Info_Appelant,_liste_id_Appelants];
};

if (_type isequalto "Pause opé multi") exitwith
{
	private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
	private _tel_CA_Info_Ope_Num = _tel_CA_Info_Ope getorDefault [_numero,[]];

	private _liste_id_Appelants = _tel_CA_Info_Ope_Num # 2;
	_liste_id_Appelants = _liste_id_Appelants select {_x isnotequalto _id};

	_tel_CA_Info_Ope_Num set [2,_liste_id_Appelants];

	private _tel_CA_Info_Ope_Mon_Appel = _tel_CA_Info_Ope getorDefault ["Mon appel",[]];
	private _numero_Mon_Appel = _tel_CA_Info_Ope_Mon_Appel # 0;
	if (_tel_CA_Info_Ope_Mon_Appel isnotEqualto [] AND {_numero isequalto _numero_Mon_Appel AND {clientowner isequalto _id}}) then
	{
		_tel_CA_Info_Ope_Mon_Appel set [1,"Pause"];
	};

	player setvariable ["MRP_Tel_CA_Info_Operateur",_tel_CA_Info_Ope];
};

if (_type isequalto "Arret civil") exitwith
{
	// Pour les prises de service on supprime en global
	player setvariable ["MRP_Tel_CA_Info_Appelant",nil,TRUE];
	player setvariable ["MRP_Appel_Etat","Arret appel en cours"];

	[] call MRPV2_fnc_MRP_Tel_Divers_Fin_Appel_TFAR;
};

if (_type isequalto "Arret opé") exitwith
{
	private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
	_tel_CA_Info_Ope deleteAt _numero;

	private _tel_CA_Info_Ope_Mon_Appel = _tel_CA_Info_Ope getorDefault ["Mon appel",[]];
	if (_tel_CA_Info_Ope_Mon_Appel isnotEqualto []) then
	{
		player setvariable ["MRP_Appel_Etat","Pause appel CA"];

		private _numero_Mon_Appel = _tel_CA_Info_Ope_Mon_Appel # 0;
		if (_numero_Mon_Appel isequalto _numero OR {count _tel_CA_Info_Ope isequalto 1}) then {_tel_CA_Info_Ope deleteAt "Mon appel";};

		[] call MRPV2_fnc_MRP_Tel_Divers_Fin_Appel_TFAR;
	};

	[_numero] call MRPV2_fnc_MRP_Tel_Menu_CA_Suppr_Cadre;

	player setvariable ["MRP_Tel_CA_Info_Operateur",_tel_CA_Info_Ope];
};

if (_type isequalto "Arret opé maj autre opé") then
{
	private _tel_CA_Info_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];
	_tel_CA_Info_Ope deleteAt _numero;

	[_numero] call MRPV2_fnc_MRP_Tel_Menu_CA_Suppr_Cadre;

	player setvariable ["MRP_Tel_CA_Info_Operateur",_tel_CA_Info_Ope];
};
// };