// MRPV2_fnc_Admins_Actions = {
private _action = param [0,""];
private _somme_Liquide = param [1,0];
private _joueur_Admin = param [2,objnull];


if (_action isEqualTo "Recois liquide") exitwith
{
	private _liquide_Avant = life_cash;
	life_cash = life_cash + _somme_Liquide;

	[name player,getPlayerUID player,"MODO",format ["A reçus %1€ par %2. (Avant : %3, Apres : %4)",_somme_Liquide tofixed 0,name _joueur_Admin,_liquide_Avant tofixed 0,life_cash tofixed 0]] remoteExec ["ALF_Server_fnc_logIt",2];
	["LA FRANCE",format ["Vous avez reçus %1€ du gouvernement.",_somme_Liquide tofixed 0],"info"] spawn ALF_fnc_doMsg;
	["LA FRANCE",format ["Vous avez envoyé %1€ à %2. Liquide avant : %3€, Liquide après : %4€",_somme_Liquide tofixed 0,name player,_liquide_Avant tofixed 0,life_cash tofixed 0],"success"] remoteExec ["ALF_fnc_doMsg",_joueur_Admin];
};

private _menu_Admin = findDisplay 98;
if (isnil {_menu_Admin}) exitwith {};

private _joueur_Dans_Liste = lbCurSel 1500;
private _joueur_Cibler = ALF_PlayersList # _joueur_Dans_Liste;

if (_action isEqualTo "Donner liquide") exitwith
{
	private _msg = ctrlText 1402;

	private _pas_Chiffre = FALSE;
	if (_msg isEqualTo "") exitwith {hint "Vous devez écrire un nombre entier dans le cadre noir."; [] spawn {sleep 1; hint "";};};

	{
		if !(_x in "0123456789") exitWith {_pas_Chiffre = TRUE;};
	} forEach (_msg splitstring "");
	if (_pas_Chiffre) exitwith {hint "Vous devez écrire un nombre entier."; [] spawn {sleep 1; hint "";};};

	private _reponse = [format["Voulez-vous donner %1€ en liquide à %2 ?",_msg,name _joueur_Cibler],"MODO","OUI","NON"] call BIS_fnc_guiMessage;
	if (_reponse) then 
	{
		private _somme_Liquide = parsenumber _msg;
		["Recois liquide",_somme_Liquide,player] remoteExec ['MRPV2_fnc_Admins_Actions',_joueur_Cibler];
		[name player,getPlayerUID player,"MODO",format ["A donné %1€ à %2.",_somme_Liquide,name _joueur_Cibler]] remoteExec ["ALF_Server_fnc_logIt",2];

		ctrlsetText [1402,""];
	};
};

if (_action isEqualTo "Gestion Verrouillage") exitwith
{
	private _texte = "verrouiller";
	if (_action isEqualTo "Bannir") then {_texte = "déverrouiller";};

	private _reponse = [format ["Voulez-vous vraiment %1 le serveur ?",_texte],"MODO","OUI","NON"] call BIS_fnc_guiMessage;
	if (_reponse) then 
	{
		[objnull,_action,player] remoteExec ['MRPV2_Server_fnc_Admins_Actions',2];
	};
};

if (_action in ["Ejecter","Bannir"]) then 
{
	private _texte = "éjecter";
	if (_action isEqualTo "Bannir") then {_texte = "bannir";};

	private _reponse = [format ["Voulez-vous vraiment %1 %2 du serveur ?",_texte,name _joueur_Cibler],"MODO","OUI","NON"] call BIS_fnc_guiMessage;
	if (_reponse) then 
	{
		[_joueur_Cibler,_action,player] remoteExec ['MRPV2_Server_fnc_Admins_Actions',2];
	};
};

if (_action isEqualTo "Donner item") exitwith 
{
	private _msg = ctrlText 1402;

	if (_msg isEqualTo "") exitwith 
	{
		hint "Vous devez écrire le classname de l'objet dans le cadre noir.";
		[] spawn {sleep 1; hint "";};
	};

	private _reponse = [format["Voulez-vous donner 1x %1 à %2 ?", _msg, name _joueur_Cibler], "MODO", "OUI", "NON"] call BIS_fnc_guiMessage;
	if (_reponse) then 
	{
		["Recois item", 0, player, _msg] remoteExec ["MRPV2_fnc_Admins_Actions", _joueur_Cibler];
		[name player, getPlayerUID player, "MODO", format ["A donné 1x %1 à %2.", _msg, name _joueur_Cibler]] remoteExec ["ALF_Server_fnc_logIt", 2];

		ctrlSetText [1402, ""];
	};
};

if (_action isEqualTo "Recois item") exitwith 
{
	private _item = param [3, ""];

	if (_item isEqualTo "") exitWith {systemChat "DEBUG - Aucun objet reçu (champ vide).";};	

	player addItem _item;

	["LA FRANCE", format ["Vous avez reçu 1x %1 du gouvernement.", _item], "info"] spawn ALF_fnc_doMsg;
};

if (_action isEqualTo "Veh Temp") exitWith {
	private _classname = ctrlText 1402;

	if (_classname isEqualTo "") exitWith {
		hint "Vous devez écrire le classname du véhicule dans le champ noir.";
		[] spawn {sleep 1; hint "";};
	};

	private _reponse = [format ["Voulez-vous vraiment faire spawn %1 ?", _classname], "MODO", "OUI", "NON"] call BIS_fnc_guiMessage;
	if (_reponse) then {
		private _veh = createVehicle [_classname, getPos player, [], 0, "NONE"];
		_veh setDir getDir player;
		player moveInDriver _veh;

		[name player, getPlayerUID player, "MODO", format ["A fait spawn un véhicule : %1", _classname]] remoteExec ["ALF_Server_fnc_logIt", 2];
		ctrlSetText [1402, ""];
	};
};
// };