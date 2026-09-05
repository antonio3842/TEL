// MRPV2_fnc_MRP_Tel_Menu_SMS_Action_Reception = {
private _message = param [0,""];
private _date = param [1,[]];
private _numero_Expediteur = param [2,""];


private _info_Config = profileNamespace getvariable ["MRP_Telephone_Configuration",createhashmap];
private _en_Mode_Avion = _info_Config # 0;
if (_en_Mode_Avion OR (ALF_Forfait < 1)) exitwith {};

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _info_Contact = _liste_Contact getOrDefault [_numero_Expediteur,[]];
private _contact_Est_Bloquer = FALSE;

if (_info_Contact isNotequalto []) then {_contact_Est_Bloquer = _info_Contact # 5;};
if (_contact_Est_Bloquer) exitwith {};

// Ajout du message dans les SMS
private _telephone_Liste_SMS = profileNamespace getvariable ["MRP_Telephone_Liste_SMS",createhashmap];
private _Telephone_Liste_SMS_Precis = _telephone_Liste_SMS getOrDefault [_numero_Expediteur,[]];

if (_Telephone_Liste_SMS_Precis isEqualTo []) then
{
	_telephone_Liste_SMS set [_numero_Expediteur,[[0,_message,_date]]];
	profileNamespace setvariable ["MRP_Telephone_Liste_SMS",_telephone_Liste_SMS];
} else
{
	_Telephone_Liste_SMS_Precis pushback [0,_message,_date];
};

// Si téléphone sur soit on joue le son de réception
private _a_Telephone = assignedItems player select {"MRP_Item_Iphone_12" in _x OR {"MRP_Item_Neogend" in _x}} isNotEqualto [];
if (_a_Telephone) then {playsound "MRP_Telephone_Message_Recus";};

// Si téléphone pas ouvert on sort du script
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
if (_Telephone_Base isequalto displayNull) exitwith {};

// On récupère le nombre de SMS recus
private _compteur_Nouveau_SMS = ["Menu principal",_numero_Expediteur] call MRPV2_fnc_MRP_Tel_Menu_SMS_Gestion_Nombre_SMS;

// Si on est sur le menu principal et que l'on a des SMS recus on affiche le nombre
private _icone_SMS = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_Creation_Bouton_SMS",controlNull];
if (_icone_SMS isNotEquaLTo controlNull AND {_compteur_Nouveau_SMS > 0}) exitwith
{
	_icone_SMS ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Icone_SMS_Mess.paa";
	_icone_SMS ctrlSetPosition [0.163,1.189,0.132,0.132];
	_icone_SMS ctrlCommit 0;

	private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
	private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];
	private _ctrl_Compteur_Nouveau_Mess = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_Compteur_Nouveau_Mess",controlNull];

	if (_ctrl_Compteur_Nouveau_Mess isEqualTo controlNull) then
	{
		_ctrl_Compteur_Nouveau_Mess = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
		uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Compteur_Nouveau_Mess",_ctrl_Compteur_Nouveau_Mess];
		_ctrl_Compteur_Nouveau_Mess ctrlSetPosition [0.237,1.195,0.05,0.05];
		_ctrl_Compteur_Nouveau_Mess ctrlCommit 0;
	};

	_ctrl_Compteur_Nouveau_Mess ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#ffffff' shadow='0' size='0.8' align='center'>%1</t>",_compteur_Nouveau_SMS];
};

// Si on est sur le menu de liste des SMS,que lon a des SMS recus on recrée la liste contact
private _Ctrl_TV = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Liste_Ctrl_TV",controlNull];
if (_Ctrl_TV isnotequalto controlNull) exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Liste;};

// Si on est dans l'écran de lecture du SMS que l'on a recus on fait défiler lecran jusqu'au dernier SMS
private _conteneur_SMS = uiNamespace getVariable ["MRP_menu_SMS_Lecture_Conteneur_SMS",controlNull];
if (_conteneur_SMS isNotEquaLTo controlNull AND {_numero_Expediteur isEqualTO MRP_Telephone_Gestion_Numero_Interne}) then
{
	[0,_message,_date] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Cadre;

	[] spawn
	{
		private _conteneur_SMS = uiNamespace getVariable ["MRP_menu_SMS_Lecture_Conteneur_SMS",controlNull];

		sleep 0.01;

		_conteneur_SMS ctrlSetScrollValues [1,-1];
	};
};

private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _joueur_Est_Dans_SMS_Recus = "Menu_SMS_Discussion_Vide_dxt5" in ctrltext _Telephone_Fond AND {_numero_Expediteur isequalto MRP_Telephone_Gestion_Numero_Interne};

// On actualise en même temps la liste d'historique de SMS pour qu'il soit bien pris en compte
if (_joueur_Est_Dans_SMS_Recus) then {["SMS",MRP_Telephone_Gestion_Numero_Interne] call MRPV2_fnc_MRP_Tel_Menu_SMS_Gestion_Nombre_SMS;};

TRUE
// };