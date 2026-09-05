// MRPV2_fnc_MRP_Tel_Menu_Principal_Crea_Liste_Appli = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base", displayNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base", controlNull];

if (isNull _Telephone_Base || {isNull _telephone_Cadre_Base}) exitWith {FALSE};

private _compteur_Horizontal = 0;
private _pos_Depart_Horizontal = 0.09;
private _compteur_Verticale = 0;
private _pos_Depart_Verticale = 0.2;
private _liste_Appli_Final = [];
// Taxi en 2e position = 1re ligne du téléphone (3 icônes max par ligne)
private _liste_Appli_Commun = ["Bloc_Note","Taxi","Radio","Annuaire"];
private _liste_Appli_Gendarmerie = ["PcStorm","CORG","SIV"];
private _liste_Appli_SAMU_Pompier = ["CODIS","CTA"];
private _liste_Appli_AP = ["DSPOM","AP"];
private _liste_Appli_Entreprise = ["Centre_Appel"];

[] call
{
	_liste_Appli_Final append _liste_Appli_Commun;

	private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;

	private _joueur_A_Iphone = tolower "Iphone_12" in tolower str assignedItems player;

	if (_joueur_A_Iphone AND {_permission_Joueur isEqualTo "ENT"}) exitwith {_liste_Appli_Final append _liste_Appli_Entreprise;};
	if (!_joueur_A_Iphone AND {_permission_Joueur isEqualTo "GN"}) exitwith {_liste_Appli_Final append _liste_Appli_Gendarmerie;};
	if (!_joueur_A_Iphone AND {_permission_Joueur isEqualTo "SP"}) exitwith {_liste_Appli_Final append _liste_Appli_SAMU_Pompier;};
	if (!_joueur_A_Iphone AND {_permission_Joueur isEqualTo "AP"}) then {_liste_Appli_Final append _liste_Appli_AP;};
};

{
	private _appli = _x;

	if (_compteur_Horizontal isEqualTo 3) then
	{
		_compteur_Horizontal = 0;
		_compteur_Verticale = _compteur_Verticale + 1;
	};

	private _ecart_Horizontal = (0.15 * _compteur_Horizontal);
	private _ecart_Vertical = 0.2 * _compteur_Verticale;

	private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_RscClickableText",-1,_telephone_Cadre_Base];
	_ctrlButton ctrlSetPosition [_pos_Depart_Horizontal + _ecart_Horizontal,_pos_Depart_Verticale + _ecart_Vertical,0.092,0.12];
	private _icone = format ["MRP_icone_tel\Data\Icones_Applications\Icone_%1.paa", _appli];
	_ctrlButton ctrlSetText _icone;
	_ctrlButton ctrlSetTextColor [0.9,0.9,0.9,1];
	_ctrlButton ctrlSettooltip "";
	_ctrlButton ctrlCommit 0;
	_ctrlButton setVariable ["_appli",_appli];

	if (_appli isequalto "Mail") then
	{
		uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Creation_Bouton_Mail",_ctrlButton];
		_ctrlButton ctrlSetURL format ["https:%1%2panel.martinique-roleplay.fr/mail/box/","/","/"];
		_ctrlButton ctrlSettooltip "";
	};

	_edit = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
	_edit ctrlSetPosition [_pos_Depart_Horizontal - 0.01 + _ecart_Horizontal,_pos_Depart_Verticale + 0.13 + _ecart_Vertical,0.11,0.1];
	_edit ctrlCommit 0;

	_edit ctrlSetStructuredText parseText format ["<t  shadow='2' color='#ffffff' size='1' align='center'>%1</t>",_appli regexReplace ["_"," "]];

	_ctrlButton ctrlAddEventHandler ["ButtonClick",
	{params ["_ctrl"];
		playsound "MRP_Telephone_Touche_Appli";

		[_ctrl] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
		[_ctrl] spawn {params ["_ctrl"]; uisleep 0.2;[_ctrl] call MRPV2_fnc_MRP_Tel_Divers_Appli_Ouverture;};
	}];

	_compteur_Horizontal = _compteur_Horizontal + 1;
} foreach _liste_Appli_Final;

TRUE
// };