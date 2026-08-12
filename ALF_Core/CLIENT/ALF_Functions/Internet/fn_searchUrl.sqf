// ALF_fnc_searchUrl = {
private _url = ctrlText 24502;
if (_url isEqualTo "") exitWith {["Intranet", "L'url est vide.", "success"] spawn ALF_fnc_doMsg;};

if (_url isEqualTo "armurerie.fr" OR {_url isEqualTo "www.armurerie.fr"}) exitWith 
{
	alf_shop_panier = [];
	uiNamespace setVariable ['internetmenu',3];
	[] call ALF_fnc_menuInternet;
};

private _quitter = false;

if (_url in [ALF_Blackmarket,ALF_Blackmarket2,ALF_Blackmarket3,ALF_Blackmarket4,ALF_Blackmarket5,ALF_Blackmarket6]) exitWith
{
	if ((nearestLocations [position player, ["NameCityCapital"], 300]) isequalto []) exitWith 
	{
    ["Intranet", "Ce site n'est pas accessible depuis ce cybercafé.", "success"] spawn ALF_fnc_doMsg;
		_quitter = true;
	};

	if ((time - life_action_delay) < 2) exitWith {["ERREUR", "Vous appuyez trop vite.", "warning"] spawn ALF_fnc_doMsg;};

	private _groupe_GN = (groups civilian select {"Gendarmerie" in groupid _x}) # 0;

	if (isnil {_groupe_GN} OR {count (units _groupe_GN) < 2}) exitWith {["CYBER","Le site demandé est indisponible pour le moment ! Réessayez plus tard !","danger"] spawn ALF_fnc_doMsg;};
	life_action_delay = time;
	[_url] remoteExecCall ["ALF_Server_fnc_searchURLDN", 2];
};
if (_quitter) exitwith {};

if (_url isEqualTo "boursedirect.fr" OR {_url isEqualTo "www.boursedirect.fr"}) exitWith 
{
	uiNamespace setVariable ['internetmenu',7];
	[] call ALF_fnc_menuInternet;
};
if (_url isEqualTo "b0urse_Cr1me.onion" OR {_url isEqualTo "www.b0urse_Cr1me.onion"}) exitWith 
{
	uiNamespace setVariable ['internetmenu',17];
	[] call ALF_fnc_menuInternet;
	[] spawn ALF_fnc_detectingBad;
};
if (_url isEqualTo "leboncoin.fr" OR {_url isEqualTo "www.leboncoin.fr"}) exitWith 
{
	uiNamespace setVariable ['internetmenu',8];
	[] call ALF_fnc_menuInternet;
};

["Intranet", "Le serveur ne renvoi aucun résultat.", "success"] spawn ALF_fnc_doMsg;
// };
