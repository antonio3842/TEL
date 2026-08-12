// MRPV2_fnc_MRP_Tel_Divers_Fin_Appel_TFAR = {
private _radio = tolower (call TFAR_fnc_activeSwRadio);

if (isnil {_radio}) exitwith {FALSE};

["Déconnexion"] call MRPV2_fnc_MRP_Tel_Divers_Connexion_TFAR;

private _radio = tolower (call TFAR_fnc_activeSwRadio);

[_radio,0] call TFAR_fnc_setSwChannel;
[_radio,12,""] call TFAR_fnc_SetChannelFrequency;
[] call TFAR_fnc_hideHint;
[_radio,tf_west_radio_code] call TFAR_fnc_setSwRadioCode;
player setvariable ["MRP_Telephone_Volume_Appel",nil];

private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
private _frequence_radio = player getvariable ["MRP_Tel_Freq_Radio",""];

if (_MRP_Appel_Etat isnoTequalto "Pause appel CA" AND {!isnil {MRP_Telephone_Info_Dispatch}} OR {_frequence_radio isnotequalto ""})  then
{

	private _pos_Ecouteur_Radio_principale = (profileNamespace getvariable ["MRP_Telephone_Configuration",[]]) # 10 # 0;
	[_radio,_pos_Ecouteur_Radio_principale] call TFAR_fnc_setSwStereo;

	if (_radio isnotEqualTo "") then
	{
		private _conf_Raccourcis_Transmission_Courte_Portee = ["TFAR","SWTransmit"] call CBA_fnc_getKeybind;
		_conf_Raccourcis_Transmission_Courte_Portee set [3,
		{
			call TFAR_fnc_onSwTangentPressed;

			private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
			private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
			private _type_Appli = [_permission_Joueur] call MRPV2_fnc_MRP_Tel_Divers_Type_Appli;
			private _texte_Transmission_Radio = "";

			if ((isnil {MRP_Telephone_Info_Dispatch}) OR {MRP_Telephone_Info_Dispatch getORDefault ["Principal",[]] isequalto []}) then
			{
				_texte_Transmission_Radio = ["Transmission","RADIO",_frequence] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;
			} else
			{
				_texte_Transmission_Radio = ["Transmission",_type_Appli,"Principal"] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;
			};

			[parsetext _texte_Transmission_Radio,-1] call TFAR_fnc_showHint;
		}];

		_conf_Raccourcis_Transmission_Courte_Portee set [4,
		{
			call TFAR_fnc_onSwTangentReleased;

			private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
			private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
			private _type_Appli = [_permission_Joueur] call MRPV2_fnc_MRP_Tel_Divers_Type_Appli;
			private _texte_Transmission_Radio = "";

			if ((isnil {MRP_Telephone_Info_Dispatch}) OR {MRP_Telephone_Info_Dispatch getORDefault ["Principal",[]] isequalto []}) then
			{
				_texte_Transmission_Radio = ["Transmis avec","RADIO",_frequence] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;
			} else
			{
				_texte_Transmission_Radio = ["Transmis avec",_type_Appli,"Principal"] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;
			};

			[parsetext _texte_Transmission_Radio,2] call TFAR_fnc_showHint;
		}];

		_conf_Raccourcis_Transmission_Courte_Portee set [8,TRUE];
		_conf_Raccourcis_Transmission_Courte_Portee call CBA_fnc_addKeybind;
	};

	private _canal_Supp = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel;
	if (_canal_Supp isEqualTo 1) then
	{
		private _conf_Raccourcis_Transmission_Courte_Portee = ["TFAR","SWTransmitAdditional"] call CBA_fnc_getKeybind;
		_conf_Raccourcis_Transmission_Courte_Portee set [3,
		{
			call TFAR_fnc_onAdditionalSwTangentPressed;

			private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
			private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
			private _type_Appli = [_permission_Joueur] call MRPV2_fnc_MRP_Tel_Divers_Type_Appli;

			private _texte_Transmission_Radio = ["Transmission",_type_Appli,"Secondaire"] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;

			[parsetext _texte_Transmission_Radio,-1] call TFAR_fnc_showHint;
		}];

		_conf_Raccourcis_Transmission_Courte_Portee set [4,
		{
			call TFAR_fnc_onAdditionalSwTangentReleased;

			private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
			private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
			private _type_Appli = [_permission_Joueur] call MRPV2_fnc_MRP_Tel_Divers_Type_Appli;

			private _texte_Transmission_Radio = ["Transmis avec",_type_Appli,"Secondaire"] call MRPV2_fnc_MRP_Tel_Divers_Config_Mess_Transmission_TFAR;

			[parsetext _texte_Transmission_Radio,2] call TFAR_fnc_showHint;
		}];

		_conf_Raccourcis_Transmission_Courte_Portee set [8,TRUE];
		_conf_Raccourcis_Transmission_Courte_Portee call CBA_fnc_addKeybind;
	};
};

if (_radio call TFAR_fnc_getSwSpeakers) then {[_radio] call TFAR_fnc_setSwSpeakers;};

[_radio,0] call TFAR_fnc_setSwVolume;
[] call TFAR_fnc_hideHint;
player call TFAR_fnc_releaseAllTangents;

TRUE
// };