// MRPV2_fnc_MRP_Tel_Menu_Appel_Tentative_Expediteur = {
// si on appel un service on passe sur un autre script

private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
private _est_Un_Numero_Special = _liste_Entreprise select {((_x getOrDefault ["PHONE",""]) isequalto MRP_Telephone_Numero_Appel)} isNotequalto [];
if (_est_Un_Numero_Special) exitwith {[] spawn MRPV2_fnc_MRP_Tel_Menu_Appel_Expediteur_Num_Speciaux;};

// On recherche le joueur parmis la liste de tous les joueurs par son numero de tel qui est publique
_joueur_Destinataire = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (MRP_Telephone_Numero_Appel)}) # 0;
if (isnil {_joueur_Destinataire}) exitwith {};

// Si le joueur destinataire a pas de tel on quitte
private _pas_De_Telephone = assignedItems _joueur_Destinataire select {"MRP_Item_Iphone_12" in _x OR {"MRP_Item_Neogend" in _x}} isEqualto [];
if (_pas_De_Telephone) exitwith {};

_joueur_Destinataire setvariable ["MRP_Appel_Etat",nil];
_joueur_Destinataire setvariable ["MRP_Telephone_Mode_Avion",nil];

[_joueur_Destinataire,"MRP_Appel_Etat"] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_syncSingleVar",_joueur_Destinataire];
[_joueur_Destinataire,"MRP_Telephone_Mode_Avion"] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_syncSingleVar",_joueur_Destinataire];

// Si le joueur est toujours en mode entrprise pour le tel mais nest plus en service on desactive le mdoe entreprise sur le tel

if !(b_enService) then
{
	private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
	_telephone_Configuration set [11,FALSE];
	profileNamespace setVariable ["MRP_Telephone_Configuration",_telephone_Configuration];
	player setvariable ["MRP_Telephone_Mode_Entreprise",FALSE];
};

// Si mode entreprise on file le num de l'entreprise plutot que son num perso
private _mode_Entreprise = player getvariable ["MRP_Telephone_Mode_Entreprise",FALSE];
private _numero_Expediteur_Mode_Entreprise = "";
if (_mode_Entreprise) then {_numero_Expediteur_Mode_Entreprise = player getVariable ["TelPro",""];};

// On envoie une demande d'info au destinataire qui nous renvoie des variables
// ON TEST EN SYNCHRONISANT DIRECTEMENT LES VARIABLES DU DESTINATAIRE SUR LE PC DE LEXPEDITEUR
private _numero_Expediteur = player getVariable ["phoneNumber",""];
private _numero_Masquer = player getvariable ["MRP_Telephone_Numero_Cacher",FALSE];
[player,_numero_Expediteur,_numero_Masquer] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Appel_Demande_Info_Dest",_joueur_Destinataire];

// On attend les reponses du destinataires sur si il est en mode avion (il est pas dispo, on continue la sonnerie jusqua 6)
// et son état (et ce quil est deja en appel ou tentative avec d'autre)
// et si il nous a bloqué
// Si au bout de 5 sec on a pas recu les infos on sort du waituntil
[{params ["_joueur_Destinataire"];
	!isnil {_joueur_Destinataire getvariable ["MRP_Telephone_Mode_Avion",nil]} AND
	{!isnil {_joueur_Destinataire getvariable ["MRP_Appel_Etat",nil]} AND
	{!isnil {player getvariable ["MRP_Telephone_Expediteur_Est_Bloquer",nil]}}}
},
{params ["_joueur_Destinataire","_numero_Expediteur","_numero_Expediteur_Mode_Entreprise","_mode_Entreprise"];
	private _pas_Mode_Avion = !(_joueur_Destinataire getvariable ["MRP_Telephone_Mode_Avion",FALSE]);
	private _appel_Etat_Destinataire = _joueur_Destinataire getvariable ["MRP_Appel_Etat",""];
	private _pas_En_Appel = !(_appel_Etat_Destinataire in ["Appel en cours","Tentative appel expéditeur","Tentative appel destinataire","Appel CA en cours"]);
	private _expediteur_Non_Bloquer = !(player getvariable ["MRP_Telephone_Expediteur_Est_Bloquer",FALSE]);
	// Si l'appel peux se faire on lance le script d'init d'appel et on suppr les variables temp
	if (_pas_Mode_Avion AND {_pas_En_Appel AND {_expediteur_Non_Bloquer}}) then
	{
		[_numero_Expediteur,_numero_Expediteur_Mode_Entreprise,_mode_Entreprise] remoteexec ["MRPV2_fnc_MRP_Tel_Menu_Appel_Init_Variables",_joueur_Destinataire];
		[_joueur_Destinataire] call MRPV2_fnc_MRP_Tel_Menu_Appel_Tentative_Expediteur_Protocole_Dilemme;
		player setVariable ["MRP_Telephone_Expediteur_Est_Bloquer",nil];
	};
},[_joueur_Destinataire,_numero_Expediteur,_numero_Expediteur_Mode_Entreprise,_mode_Entreprise],
5,
{params ["_joueur_Destinataire"];
	player setVariable ["MRP_Telephone_Expediteur_Est_Bloquer",nil];
	_joueur_Destinataire setVariable ["MRP_Appel_Etat",nil];
},[_joueur_Destinataire]] call CBA_fnc_waitUntilAndExecute;


TRUE
// };