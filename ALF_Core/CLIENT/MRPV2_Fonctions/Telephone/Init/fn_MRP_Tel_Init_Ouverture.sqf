// MRPV2_fnc_MRP_Tel_Init_Ouverture = {
if !(isAbleToBreathe player) exitwith {};
if (gestureState player isequalto "mrp_menotter") exitwith {};
if (attachedobjects player select {isplayer _x} isNotequalto []) exitwith {};

_displayOrControl = createDialog ["MRP_Telephone",true];

sleep 0.1;

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
if (_Telephone_Base isEquaLTo displayNull) then
{
	uiNamespace setVariable ["MRP_Telephone_Base",_displayOrControl];
	_Telephone_Base = _displayOrControl;
};

private _numTel = ALF_Phone_Number;
if (_numTel isEqualTo "") then {
	_numTel = player getVariable ["phoneNumber", ""];
};
if !(_numTel isEqualTo "") then {
	player setVariable ["phoneNumber", _numTel, true];
};

// ===== Réglage de la position verticale du téléphone à l'écran =====
private _decalage_Y_Iphone = -0.15;
private _decalage_Y_Neogend = -0.05;
// ====================================================================

private _x = 0.378788;
private _y = 0.0090909 + _decalage_Y_Iphone;
private _w = 1.10139;
private _h = 1.39347;

private _telephone_Est_Neogend = ("MRP_Item_Neogend" in str (assignedItems player));
if (_telephone_Est_Neogend) then
{
	_y = -0.06 + _decalage_Y_Neogend;
	_h = 1.41;
};

private _fond_Ecran = _Telephone_Base ctrlCreate ["RscPicture",-1];
uiNamespace setVariable ["MRP_Telephone_Fond",_fond_Ecran];
_fond_Ecran ctrlSetPosition [_x,_y,_w,_h];
_fond_Ecran ctrlCommit 0;

private _html = _Telephone_Base ctrlCreate ["RscHTML",-1];
uiNamespace setVariable ["MRP_Telephone_Fond_HTML",_html];
_html ctrlSetPosition [0.682, 0.0429 + _decalage_Y_Iphone,0.49,1.325];
_html ctrlenable FALSE;
_html ctrlCommit 0;

if (_telephone_Est_Neogend) then
{
	_y = -0.13 + _decalage_Y_Neogend;
	_h = 1.54;
};

private _coque = _Telephone_Base ctrlCreate ["RscPicture",-1];
uiNamespace setVariable ["MRP_Telephone_Coque",_coque];
_coque ctrlSetPosition [_x,_y,_w,_h];
_coque ctrlCommit 0;

if (_telephone_Est_Neogend) then
{
	_coque ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Coque_Neogend.paa";
} else
{
	_coque ctrlSetText "MRP_icone_tel\Data\Menu_Principal\Contour_Iphone_Menu.paa";
};

_x = 0.65;
_y = 0.005 + _decalage_Y_Iphone;
_w = 0.56;
_h = 1.4;

private _telephone_Cadre_Base = _Telephone_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1];
_telephone_Cadre_Base ctrlSetPixelPrecision 2;
uiNamespace setVariable ["MRP_Telephone_Cadre_Base",_telephone_Cadre_Base];

// code de suppression des variables et autre quand on ferme le tel
_telephone_Cadre_Base ctrlAddEventHandler ["Destroy",
{params ["_control"];
	[] call MRPV2_fnc_MRP_Tel_Init_Fermeture;
}];

_telephone_Cadre_Base ctrlAddEventHandler ["MouseButtonUp",
{params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
	private _ctrl_Image = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_Creation_Fond_Menu_Bas",controlNull];

	if (_button isequalto 1 AND {_ctrl_Image isequalto controlNull}) then
	{
		private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
		if (_MRP_Appel_Etat in ["Appel en cours","Tentative appel expéditeur","Tentative appel destinataire"]) exitwith {};

		playsound "MRP_Telephone_Touche_Appli";

		[] spawn
		{
			private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
			if (ctrltext _Telephone_Fond isequalto "") exitwith {};

			sleep 0.2;

			[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
/*
			private _MRP_Tel_Menu_Taxi = uiNamespace getVariable ["MRP_Tel_Menu_Taxi",controlNull];
			if ("Menu_Note_Vide_dxt5" in ctrltext _Telephone_Fond AND {!isNull _MRP_Tel_Menu_Taxi}) exitwith
			{
				[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Crea;
			};
*/
			private _MRP_Tel_Menu_Annuaire = uiNamespace getVariable ["MRP_Tel_Menu_Annuaire",controlNull];
			if ("Menu_Note_Vide_dxt5" in ctrltext _Telephone_Fond AND {_MRP_Tel_Menu_Annuaire isequalto controlNull}) exitwith
			{
				[] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Crea;
			};

			if ("Menu_SMS_Discussion_Vide_dxt5" in ctrltext _Telephone_Fond) exitwith
			{
				[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea;
			};

			if ("Menu_SMS_ecrire_dxt5" in ctrltext _Telephone_Fond) exitwith
			{
				[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea;
			};

			if ("Menu_Contact_Fiche_dxt5" in ctrltext _Telephone_Fond) exitwith
			{
				[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Crea;
			};

			if ("Menu_Contact_Modifier_Nouveau_dxt5" in ctrltext _Telephone_Fond) exitwith
			{
				[] call MRPV2_fnc_MRP_Tel_Menu_Contact_Lecture_Fiche;
			};

			if ("Menu_Reglages_dxt5" in ctrltext _Telephone_Fond) exitwith
			{
				[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;
				[] call MRPV2_fnc_MRP_Tel_Menu_Reglages_Crea;
			};

			[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Crea;
			MRP_Telephone_Gestion_Numero_Interne = nil;
			MRP_Telephone_Numero_Appel = nil;
		};

		private _Bouton_Retour = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_Bouton_Retour",controlNull];
		[_Bouton_Retour] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;
	};
}];

if (_telephone_Est_Neogend) then {_y = -0.056 + _decalage_Y_Neogend;};

_telephone_Cadre_Base ctrlSetPosition [_x,_y,_w,_h];
_telephone_Cadre_Base ctrlSetMousePosition [0.9, 0.7];
_telephone_Cadre_Base ctrlCommit 0;

[] call MRPV2_fnc_MRP_Tel_Init_Heure;
[] call MRPV2_fnc_MRP_Tel_Init_Etat;

private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];

// Choix de l'écran a ouvrir si appel ou autre en cours
if !(_MRP_Appel_Etat in ["","Appel CA en cours"]) exitwith
{
	if (_MRP_Appel_Etat isEqualTo "Tentative appel expéditeur") exitwith
	{
		[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Exped_Crea;
	};

	if (_MRP_Appel_Etat isEqualTo "Tentative appel destinataire") exitwith
	{
		[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Desti_Crea;
		[] call MRPV2_fnc_MRP_Tel_Init_Crea_Et_AttachTo;
	};

	if (_MRP_Appel_Etat isEquaLTo "Appel en cours") exitwith
	{
		[] call MRPV2_fnc_MRP_Tel_Menu_Appel_En_Cours_Crea;
	};
};

 private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
 if (_liste_Entreprise isequalto []) then
 {
 0 spawn MRPV2_fnc_MRP_Tel_Menu_Annuaire_Call_API;

 	[{
 		!isnil {MRP_Telephone_Annuaire}
 	},
 	{
 		profilenamespace setvariable ["MRP_Tel_Liste_Entreprise",MRP_Telephone_Annuaire];
 		MRP_Telephone_Annuaire = nil;
 	},[],3,{}] call CBA_fnc_waitUntilAndExecute;
 };

MRP_Telephone_Numero_Appel = "";

[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Crea;
[] call MRPV2_fnc_MRP_Tel_Init_Crea_Et_AttachTo;

TRUE
// };