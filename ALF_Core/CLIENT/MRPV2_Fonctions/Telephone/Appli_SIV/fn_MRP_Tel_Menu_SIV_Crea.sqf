// MRPV2_fnc_MRP_Tel_Menu_SIV_Crea = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Fond\Neogend_Fond_PC_Storm_Vide.paa";

// Titre
private _titre = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
_titre ctrlSetPosition [0.09,0.09,0.42,0.07];
_titre ctrlCommit 0;
_titre ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#ffffff' size='1.7' align='left'>SIV</t>";

private _sous_Titre = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
_sous_Titre ctrlSetPosition [0.09,0.155,0.42,0.05];
_sous_Titre ctrlCommit 0;
_sous_Titre ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#8fa3bf' size='1' align='left'>Recherche par plaque</t>";

// Carte champ recherche (plaque)
private _cadre_Champ = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_cadre_Champ ctrlSetPosition [0.09,0.24,0.41,0.09];
_cadre_Champ ctrlSetBackgroundColor [1,1,1,0.08];
_cadre_Champ ctrlCommit 0;

private _edit = _Telephone_Base ctrlCreate ["MRP_Telephone_RscEdit_Cadre_Invisible",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_SIV_Champ_Recherche",_edit];
_edit ctrlSetPosition [0.11,0.255,0.35,0.06];
_edit ctrlSetBackgroundColor [0,0,0,0];
_edit ctrlSetFont "SFUIDisplay_46";
_edit ctrlSetFontHeight 0.055;
_edit ctrlSetTextColor [1,1,1,0.4];
_edit ctrlSetText "AA-123-BB";
_edit ctrlCommit 0;

_edit ctrlAddEventHandler ["SetFocus",
{params ["_control"];
	if (ctrlText _control isEqualTo "AA-123-BB") then {_control ctrlSetText "";};
	_control ctrlSetTextColor [1,1,1,1];
}];

_edit ctrlAddEventHandler ["Killfocus",
{params ["_control"];
	if (ctrlText _control isEqualTo "") then
	{
		_control ctrlSetTextColor [1,1,1,0.4];
		_control ctrlSetText "AA-123-BB";
	};
}];

_edit ctrlAddEventHandler ["Keydown",
{params ["_control"];
	[_control,9] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere;
}];

// Formatage auto en majuscule + tirets (AA-123-BB) au fil de la frappe
_edit ctrlAddEventHandler ["KeyUp",
{params ["_control","_key"];
	if (_key isEqualTo 28) exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_SIV_Action_Rechercher;};

	private _texte = toupper (ctrlText _control);
	private _brut = (toArray _texte) select {(toString [_x]) isnotequalto "-"};
	_brut resize (7 min (count _brut));

	private _formate = "";
	{
		_formate = _formate + (toString [_x]);
		if (_forEachIndex isequalto 1 OR {_forEachIndex isequalto 4}) then {_formate = _formate + "-";};
	} foreach _brut;

	if (_texte isnotequalto "" AND {_texte isnotequalto "AA-123-BB"}) then
	{
		_control ctrlSetText _formate;
		_control ctrlSetTextSelection [count _formate,0];
	};
}];

// Bouton RECHERCHER (RscText visuel + MRP_Bouton invisible superposé pour le clic)
private _pos_Bouton_Rech = [0.09,0.35,0.41,0.08];

private _visuel_Rech = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_visuel_Rech ctrlSetPosition _pos_Bouton_Rech;
_visuel_Rech ctrlSetBackgroundColor [0.15,0.45,0.85,1];
_visuel_Rech ctrlSetText "RECHERCHER";
_visuel_Rech ctrlSetTextColor [1,1,1,1];
_visuel_Rech ctrlSetFontHeight 0.045;
_visuel_Rech ctrlSetShadow 0;
_visuel_Rech ctrlSetFont "SFUIDisplay_46";
_visuel_Rech ctrlCommit 0;

private _ctrlButtonRech = _Telephone_Base ctrlCreate ["MRP_Bouton",-1,_telephone_Cadre_Base];
_ctrlButtonRech ctrlSetPosition _pos_Bouton_Rech;
_ctrlButtonRech ctrlCommit 0;
_ctrlButtonRech setvariable ["_visuel",_visuel_Rech];

_ctrlButtonRech ctrlAddEventHandler ["ButtonClick",
{params ["_control"];
	private _visuel = _control getvariable ["_visuel",controlNull];
	[_visuel] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	playsound "MRP_Telephone_Touche_Appli";
	[] call MRPV2_fnc_MRP_Tel_Menu_SIV_Action_Rechercher;
}];

// Carte résultat
private _cadre_Resultat = _Telephone_Base ctrlCreate ["RscText",-1,_telephone_Cadre_Base];
_cadre_Resultat ctrlSetPosition [0.09,0.47,0.41,0.55];
_cadre_Resultat ctrlSetBackgroundColor [1,1,1,0.06];
_cadre_Resultat ctrlCommit 0;

private _resultat = _Telephone_Base ctrlCreate ["RscStructuredText",-1,_telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_SIV_Zone_Resultat",_resultat];
_resultat ctrlSetPosition [0.11,0.49,0.37,0.51];
_resultat ctrlCommit 0;
_resultat ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#8fa3bf' size='1' align='left'>Entrez une plaque pour lancer la recherche.</t>";

// Bouton retour menu principal
[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };
