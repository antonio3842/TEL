// MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Cadre = {
private _SMS_Placer_A_Gauche = param [0,0];
private _message = param [1,""];
private _liste_Date = param [2,[]];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _menu_SMS_Lecture_Conteneur_SMS = uiNamespace getVariable ["MRP_menu_SMS_Lecture_Conteneur_SMS",displayNull];

private _taille_Cadre_Messages_Simple = 0.07;
private _taille_Cadre_Messages_Multiple = 0.056;
private _espacement_Verticale_Entre_Messages = 0.01;

[_liste_Date] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Cadre_Date;

private _position_Verticale_Image_Droite_Haut = -0.0025;
private _position_Verticale_Image_Gauche_Haut = -0.0015;

private _position_Horizontal = 0.05;
private _position_Horizontal_Image_Droite_Haut = 0;
private _position_Horizontal_Image_Gauche_Haut = -0.0385;

private _position_Horizontal_SMS_Bleu = 0;
private _taille_Image_Droite_haut = 0;
private _couleur_Message = [0.912,0.912,0.92,1];

// Bord haut gauche cadre SMS
private _ctrl_Image_Gauche_Haut = _Telephone_Base ctrlCreate ["RscPicture",-1,_menu_SMS_Lecture_Conteneur_SMS];
_ctrl_Image_Gauche_Haut ctrlSetPixelPrecision 2;
_ctrl_Image_Gauche_Haut ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Debut_SMS_Gris_dxt5.paa";

// Image Droite haut
private _ctrl_Image_Droite_Haut = _Telephone_Base ctrlCreate ["RscPicture",-1,_menu_SMS_Lecture_Conteneur_SMS];
_ctrl_Image_Droite_Haut ctrlSetPixelPrecision 2;
_ctrl_Image_Droite_Haut ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Fin_SMS_Gris_dxt5.paa";

// Cadre SMS
private _cadre_SMS = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _menu_SMS_Lecture_Conteneur_SMS];
_cadre_SMS ctrlenable false;

private _ctrl_Determin_Longueur_Texte = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1];
_ctrl_Determin_Longueur_Texte ctrlSetPosition [0,0,0.355,100];
_ctrl_Determin_Longueur_Texte ctrlSetbackgroundcolor [0.1,0.1,0.35,0.3];
_ctrl_Determin_Longueur_Texte ctrlcommit 0;

private _ctrl_Determin_Hauteur_Texte = _Telephone_Base ctrlcreate ["RscEditMulti",-1];
_ctrl_Determin_Hauteur_Texte ctrlsetfade 1;
_ctrl_Determin_Hauteur_Texte ctrlSetbackgroundcolor [0.1,0.1,0.35,0.3];
_ctrl_Determin_Hauteur_Texte ctrlSetPosition [0,0,0.355,100];
_ctrl_Determin_Hauteur_Texte ctrlsetfont "SFUIDisplay_20";
_ctrl_Determin_Hauteur_Texte ctrlSetFontHeight 0.05;
_ctrl_Determin_Hauteur_Texte ctrlcommit 0;

_ctrl_Determin_Hauteur_Texte ctrlSettext _message;
private _hauteur_Texte_Temp = (ctrlTextheight _ctrl_Determin_Hauteur_Texte);

// Gestion message multi ligne
private _nombre_Retour_Ligne = (count(_message regexFind ["<br />"]));
private _nombre_Retour_Ligne_AJuster = [_nombre_Retour_Ligne,_nombre_Retour_Ligne - 1] select (_nombre_Retour_Ligne > 0);
private _ligne_SMS_Sur_Plusieur_Ligne = FALSE;

// On remplace par un charactere special qui servira de separateur
private _liste_Messages_Retour_Ligne = _message regexReplace ["<br />","|||"];
_liste_Messages_Retour_Ligne = _liste_Messages_Retour_Ligne splitstring "|||";

_liste_Messages_Retour_Ligne = _liste_Messages_Retour_Ligne apply {[count _x, _x]};
_liste_Messages_Retour_Ligne sort false;

private _longueur_Cadre = 0.041;
private _hauteur_Cadre = 0;

{
	private _nombre_Charactere = _x # 0;
	private _message = trim (_x # 1);

	_ctrl_Determin_Longueur_Texte ctrlSetStructuredText parsetext format ["<t color='#ffffff' shadow='0' font='SFUIDisplay_20' size='1.2' align='left'>%1</t>",_message];
	private _longueur_Texte = (ctrlTextwidth _ctrl_Determin_Longueur_Texte) max 0.041;

	_ctrl_Determin_Hauteur_Texte ctrlSettext _message;
	_ctrl_Determin_Hauteur_Texte ctrlCommit 0;

	if (_foreachindex > 0) then {_nombre_Retour_Ligne = _nombre_Retour_Ligne - 1;};

	private _hauteur_Texte_Temp = (ctrlTextheight _ctrl_Determin_Hauteur_Texte);
	private _hauteur_Cadre_Temp = _hauteur_Texte_Temp / 0.05;

	_hauteur_Cadre = _hauteur_Cadre + _hauteur_Cadre_Temp;

	if (_hauteur_Texte_Temp > 0.05) then {_ligne_SMS_Sur_Plusieur_Ligne = TRUE;};
	if (_nombre_Charactere isequalto (_liste_Messages_Retour_Ligne # 0 # 0)) then {_longueur_Cadre = _longueur_Texte min 0.35;};
} foreach _liste_Messages_Retour_Ligne;

_hauteur_Cadre = (_hauteur_Cadre + _nombre_Retour_Ligne) max 1;

ctrlDelete _ctrl_Determin_Longueur_Texte;
ctrlDelete _ctrl_Determin_Hauteur_Texte;

private _taille_Cadre_Messages_Finale = (_taille_Cadre_Messages_Simple * _hauteur_Cadre);

private _position_Debut_Cadre_SMS_Milieu = 0.036;
private _position_Verticale_Sms_Milieu = 0;
private _position_Verticale_Sms = MRP_Position_Hauteur_Cadre + 0.013;

_position_Horizontal_Image_Droite_Haut = (_longueur_Cadre - 0.014);

// Si le message est sur plus d'une ligne
if (_hauteur_Cadre > 1) then
{
	private _position_Verticale_Image_Gauche_Bas = 0;
	private _position_Verticale_Image_Droite_Bas = 0;
	private _position_Horizontal_Image_Droite_Bas = 0;
	private _position_Horizontal_Image_Gauche_Bas = 0;
	private _cadre_SMS_Milieu_Longueur_Cadre = 0;

	_longueur_Cadre = _longueur_Cadre min 0.35;

	private _ajout_Hauteur_Grand_Message = 0.0;

	_taille_Cadre_Messages_Finale = _ajout_Hauteur_Grand_Message + (_taille_Cadre_Messages_Multiple * _hauteur_Cadre);

	// Dans cette ordre pour que le cadre milieu ne soit pas caché par les images de bord
	// Cadre gauche bas
	private _ctrl_Image_Gauche_Bas = _Telephone_Base ctrlcreate ["RscPicture",-1,_menu_SMS_Lecture_Conteneur_SMS];

	// Cadre droite bas
	private _ctrl_Image_Droite_Bas = _Telephone_Base ctrlcreate ["RscPicture",-1,_menu_SMS_Lecture_Conteneur_SMS];

	// Cadre SMS milieu
	private _cadre_SMS_Milieu = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _menu_SMS_Lecture_Conteneur_SMS];
	_cadre_SMS_Milieu ctrlenable false;

	if (_SMS_Placer_A_Gauche isEqualTo 0) then
	{
		_ctrl_Image_Gauche_Haut ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Gauche_Rond_SMS_Gris_dxt5.paa";
		_ctrl_Image_Gauche_Bas ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Debut_SMS_Gris_dxt5.paa";
		_ctrl_Image_Droite_Bas ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Fin_SMS_Gris_dxt5.paa";

		_position_Verticale_Sms_Milieu = MRP_Position_Hauteur_Cadre + 0.03;

		_position_Horizontal_Image_Droite_Haut = (_longueur_Cadre - 0.014) min 0.35;

		_position_Horizontal_Image_Gauche_Haut = -0.0348;

		_position_Verticale_Image_Gauche_Bas = _taille_Cadre_Messages_Finale - 0.071;
		_position_Horizontal_Image_Gauche_Bas =  - 0.0385;

		_position_Verticale_Image_Droite_Bas = _taille_Cadre_Messages_Finale - 0.071;
		_position_Horizontal_Image_Droite_Bas = _longueur_Cadre - 0.0126;

		_cadre_SMS_Milieu_Longueur_Cadre = 0.0425;
	} else
	{
		_couleur_Message = [0,0.550,1,1];
		_position_Horizontal_SMS_Bleu = 0.05;

		_ctrl_Image_Gauche_Haut ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Gauche_Rond_SMS_Bleu_dxt5.paa";
		_ctrl_Image_Droite_Haut ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Droite_Rond_SMS_Bleu_dxt5.paa";

		_position_Horizontal_Image_Gauche_Haut = -0.0348 + _position_Horizontal_SMS_Bleu;
		_position_Verticale_Image_Gauche_Haut = -0.0015;

		_position_Horizontal_Image_Gauche_Bas = - 0.0345 + _position_Horizontal_SMS_Bleu;
		_position_Verticale_Image_Gauche_Bas = _taille_Cadre_Messages_Finale - 0.0725;

		_position_Horizontal_Image_Droite_Haut = (_longueur_Cadre - 0.0155 + _position_Horizontal_SMS_Bleu);

		_position_Horizontal_Image_Droite_Bas = _longueur_Cadre - 0.01 + _position_Horizontal_SMS_Bleu;
		_position_Verticale_Image_Droite_Bas = _taille_Cadre_Messages_Finale - 0.0715;

		_cadre_SMS_Milieu_Longueur_Cadre = 0.0408;

		_ctrl_Image_Gauche_Bas ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Gauche_Rond_SMS_Bleu_dxt5.paa";
		_ctrl_Image_Droite_Bas ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Droite_debut_SMS_Bleu_dxt5.paa";

		_position_Horizontal_SMS_Bleu =  0.4 - _longueur_Cadre;
		_position_Horizontal_Image_Gauche_Bas = - 0.0345 + _position_Horizontal_SMS_Bleu;
		_position_Horizontal_Image_Droite_Bas = _longueur_Cadre - 0.01 + _position_Horizontal_SMS_Bleu;
	};

	_ctrl_Image_Gauche_Bas ctrlSetPosition [_position_Horizontal + _position_Horizontal_Image_Gauche_Bas,MRP_Position_Hauteur_Cadre + _position_Verticale_Image_Gauche_Bas,0.05,0.074];
	_ctrl_Image_Gauche_Bas ctrlCommit 0;

	_cadre_SMS_Milieu ctrlSetPosition [_position_Horizontal - 0.0205 + _position_Horizontal_SMS_Bleu,MRP_Position_Hauteur_Cadre + 0.03,_longueur_Cadre + _cadre_SMS_Milieu_Longueur_Cadre,_taille_Cadre_Messages_Finale - 0.06];

	_cadre_SMS_Milieu ctrlSetBackgroundColor _couleur_Message;
	_cadre_SMS_Milieu ctrlCommit 0;

	_ctrl_Image_Droite_Bas ctrlSetPosition [_position_Horizontal + _position_Horizontal_Image_Droite_Bas,MRP_Position_Hauteur_Cadre + _position_Verticale_Image_Droite_Bas,0.05,0.074];
	_ctrl_Image_Droite_Bas ctrlCommit 0;
};

// Création du controle "Texte" en tout dernier pour etre visible
// Texte SMS
private _texte_SMS = _Telephone_Base ctrlcreate ["MRP_Structured_Text",-1, _menu_SMS_Lecture_Conteneur_SMS];

// Emplacement SMS A gauche
if (_SMS_Placer_A_Gauche isEqualTo 0) then
{
	if (_ligne_SMS_Sur_Plusieur_Ligne) then
	{
		_texte_SMS ctrlSetStructuredText parsetext format ["<t color='#000000' shadow='0' font='SFUIDisplay_20' size='1.2' align='left'>%1</t>",_message];
	} else
	{
		_texte_SMS ctrlSetStructuredText parsetext format ["<t color='#000000' shadow='0' font='SFUIDisplay_20' size='1.2' align='center'>%1</t>",_message];
	};
} else
{
	_couleur_Message = [0,0.550,1,1];

	if (_ligne_SMS_Sur_Plusieur_Ligne) then
	{
		_texte_SMS ctrlSetStructuredText parsetext format ["<t color='#FFFFFF' shadow='0' font='SFUIDisplay_20' size='1.2' align='left'>%1</t>",_message];
	} else
	{
		_texte_SMS ctrlSetStructuredText parsetext format ["<t color='#FFFFFF' shadow='0' font='SFUIDisplay_20' size='1.2' align='center'>%1</t>",_message];
	};

	if (_longueur_Cadre <= 0.35) then
	{
		_position_Horizontal_SMS_Bleu =  0.4 - _longueur_Cadre;
		_position_Horizontal_Image_Gauche_Haut = -0.0348 + _position_Horizontal_SMS_Bleu;
		_position_Verticale_Image_Gauche_Haut = -0.0012;

		_position_Horizontal_Image_Droite_Haut = (_longueur_Cadre - 0.014) + _position_Horizontal_SMS_Bleu;
		_taille_Image_Droite_haut = 0.002;

		if (_nombre_Retour_Ligne isEqualTo 0 AND {_hauteur_Cadre isequalto 1}) then
		{
			_position_Horizontal_Image_Droite_Haut = (_longueur_Cadre - 0.011) + _position_Horizontal_SMS_Bleu;

			_ctrl_Image_Gauche_Haut ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Gauche_Rond_SMS_Bleu_dxt5.paa";
			_ctrl_Image_Droite_Haut ctrlSetText "MRP_icone_tel\Data\Menu_SMS\Morceau_Droite_debut_SMS_Bleu_dxt5.paa";

			_texte_SMS ctrlSetStructuredText parsetext format ["<t color='#FFFFFF' shadow='0' font='SFUIDisplay_20' size='1.2' align='center'>%1</t>",_message];
		};
	};
};

_ctrl_Image_Gauche_Haut ctrlSetPosition [_position_Horizontal + _position_Horizontal_Image_Gauche_Haut,MRP_Position_Hauteur_Cadre + _position_Verticale_Image_Gauche_Haut,0.05,0.074];
_ctrl_Image_Gauche_Haut ctrlCommit 0;

_cadre_SMS ctrlSetPosition [_position_Horizontal + _position_Horizontal_SMS_Bleu,MRP_Position_Hauteur_Cadre,_longueur_Cadre,_taille_Cadre_Messages_Finale];
_cadre_SMS ctrlSetbackgroundcolor _couleur_Message;
_cadre_SMS ctrlCommit 0;

_ctrl_Image_Droite_Haut ctrlSetPosition [_position_Horizontal + _position_Horizontal_Image_Droite_Haut,MRP_Position_Hauteur_Cadre + _position_Verticale_Image_Droite_Haut,0.05,0.074 + _taille_Image_Droite_haut];
_ctrl_Image_Droite_Haut ctrlCommit 0;

_texte_SMS ctrlSetPosition [_position_Horizontal + _position_Horizontal_SMS_Bleu - 0.003,_position_Verticale_Sms,_longueur_Cadre + 0.005,_taille_Cadre_Messages_Finale - 0.02];
_texte_SMS ctrlCommit 0;

if (_hauteur_Cadre > 1) then
{
	MRP_Position_Hauteur_Cadre = MRP_Position_Hauteur_Cadre + (_hauteur_Cadre * _taille_Cadre_Messages_Multiple) + (_espacement_Verticale_Entre_Messages * 2);
} else
{
	MRP_Position_Hauteur_Cadre = MRP_Position_Hauteur_Cadre + (_hauteur_Cadre * _taille_Cadre_Messages_Simple) + _espacement_Verticale_Entre_Messages;
};

TRUE
// };