// MRPV2_fnc_MRP_Tel_Init_Ouverture = {
if !(isAbleToBreathe player) exitwith {};
if (gestureState player isequalto "mrp_menotter") exitwith {};
if (attachedobjects player select {isplayer _x} isNotequalto []) exitwith {};

_displayOrControl = createDialog ["MRP_Telephone",true];

//desactivation des autres fréquence radio courte portée
if !(isnil {(call TFAR_fnc_ActiveSwRadio)}) then
{
	private _radio_Enregistrer_Active = player getvariable ["MRP_Tel_Radio_Frequence_Active",0];
	private _liste_Radio_Enregistrer = ((profileNamespace getvariable ["MRP_Telephone_Configuration",[]]) # 9);
	_liste_Radio_Enregistrer = _liste_Radio_Enregistrer + [["Active",_radio_Enregistrer_Active]];
	private _radio = tolower (call TFAR_fnc_activeSwRadio);

	for "_i" from 0 to 9 do
	{
		//Desactivation de la radio enregistré sur le canal 1 et 2 si pas dans les canaux perso enregistré dans l'appli RADIO 
		if (_i in [1,2]) then
		{			
			private _radio_Enregistrer = [_radio,_i] call TFAR_fnc_GetChannelFrequency;
			private _radio_Non_Valide = _liste_Radio_Enregistrer select {_x # 1 isequalto _radio_Enregistrer} isequalto [];

			// Fixe pour ne pas niquer les freq des service spéciaux
			if (_radio_Non_Valide AND {parsenumber _radio_Enregistrer > parsenumber "512"}) then {_radio_Non_Valide = FALSE;};

			if (_radio_Non_Valide) then 
			{
				[_radio,_i,""] call TFAR_fnc_SetChannelFrequency;
				
				if (_i isequalto 1) then
				{
					{
						private _raccourcis = _x;

						private _configuration_Raccourcis_TFAR = ["TFAR",_raccourcis] call CBA_fnc_getKeybind;
						_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
						_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
						_configuration_Raccourcis_TFAR set [8,TRUE];

						_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;
					} foreach  ["SWTransmit"];
				};

				if (_i isequalto 2) then
				{
					{
						private _raccourcis = _x;

						private _configuration_Raccourcis_TFAR = ["TFAR",_raccourcis] call CBA_fnc_getKeybind;
						_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
						_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
						_configuration_Raccourcis_TFAR set [8,TRUE];

						_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;
					} foreach  ["SWTransmitAdditional"];
				};

			};
		} else
		{
			[_radio,_i,""] call TFAR_fnc_SetChannelFrequency;
		};		
	};
};

sleep 0.1;

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
if (_Telephone_Base isEquaLTo displayNull) then
{
	uiNamespace setVariable ["MRP_Telephone_Base",_displayOrControl];
	_Telephone_Base = _displayOrControl;
};

private _x = 0.378788;
private _y = 0.0090909;
private _w = 1.10139;
private _h = 1.39347;

private _telephone_Est_Neogend = ("MRP_Item_Neogend" in str (assignedItems player));
if (_telephone_Est_Neogend) then
{
	_y = -0.06;
	_h = 1.41;
};

private _fond_Ecran = _Telephone_Base ctrlCreate ["RscPicture",-1];
uiNamespace setVariable ["MRP_Telephone_Fond",_fond_Ecran];
_fond_Ecran ctrlSetPosition [_x,_y,_w,_h];
_fond_Ecran ctrlCommit 0;

private _html = _Telephone_Base ctrlCreate ["RscHTML",-1];
uiNamespace setVariable ["MRP_Telephone_Fond_HTML",_html];
_html ctrlSetPosition [0.682, 0.0429,0.49,1.325];
_html ctrlenable FALSE;
_html ctrlCommit 0;

if (_telephone_Est_Neogend) then
{
	_y = -0.13;
	_h = 1.54;
};

private _coque = _Telephone_Base ctrlCreate ["RscPicture",-1];
uiNamespace setVariable ["MRP_Telephone_Coque",_coque];
_coque ctrlSetPosition [_x,_y,_w,_h];
_coque ctrlCommit 0;

if (_telephone_Est_Neogend) then
{
	_coque ctrlSetText "MRP_Telephones\Data\Menu_Principal\Coque_Neogend.paa";
} else
{
	_coque ctrlSetText "MRP_Telephones\Data\Menu_Principal\Contour_Iphone_Menu.paa";
};

_x = 0.65;
_y = 0.005;
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

			private _MRP_Tel_Menu_Taxi = uiNamespace getVariable ["MRP_Tel_Menu_Taxi",controlNull];
			if ("Menu_Note_Vide_dxt5" in ctrltext _Telephone_Fond AND {!isNull _MRP_Tel_Menu_Taxi}) exitwith
			{
				[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Crea;
			};

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

if (_telephone_Est_Neogend) then {_y = -0.056;};

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