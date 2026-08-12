// MRPV2_fnc_MRP_Tel_Divers_Debut_Appel_TFAR = {
private _numero_Appel = param [0,""];

[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;

// Si le joueur est a terre ou mort on quitte
private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
if (_MRP_Appel_Etat isequalto "") exitwith {FALSE};
if (isnull player) exitwith {FALSE};

// FIX (bug "rappel qui se connecte sans que le CA décroche") : on force la
// remise à zéro du canal téléphonique (12) AVANT de le retuner sur la nouvelle
// fréquence. Si un appel précédent n'a pas été proprement raccroché côté
// serveur/opérateur, sa fréquence pouvait rester accrochée sur cette radio ;
// comme la fréquence utilisée est toujours le numéro de l'appelant (donc
// identique à chaque appel), un rappel se reconnectait alors instantanément
// à l'ancienne communication. Ce reset rend une éventuelle fréquence "collée"
// inoffensive avant d'établir la nouvelle communication.
[(call TFAR_fnc_ActiveSwRadio),12,""] call TFAR_fnc_SetChannelFrequency;

if ((call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwSpeakers) then {[(call TFAR_fnc_ActiveSwRadio)] call TFAR_fnc_setSwSpeakers;};

private _frequence = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
player setvariable ["MRP_Tel_Freq_Radio",_frequence];

if ((call TFAR_fnc_currentSWFrequency) isnotEqualTo "") then
{
	private _configuration_Raccourcis_TFAR = ["TFAR","SWTransmit"] call CBA_fnc_getKeybind;
	_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
	_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
	_configuration_Raccourcis_TFAR set [8,TRUE];

	_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;
};

private _canal_Supp = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel;
if (_canal_Supp isEqualTo 1) then
{
	private _configuration_Raccourcis_TFAR = ["TFAR","SWTransmitAdditional"] call CBA_fnc_getKeybind;
	_configuration_Raccourcis_TFAR set [3,{[] call TFAR_fnc_hideHint;}];
	_configuration_Raccourcis_TFAR set [4,{[] call TFAR_fnc_hideHint;}];
	_configuration_Raccourcis_TFAR set [8,TRUE];

	_configuration_Raccourcis_TFAR call CBA_fnc_addKeybind;
};

[(call TFAR_fnc_ActiveSwRadio),12] call TFAR_fnc_setSwChannel;
[(call TFAR_fnc_ActiveSwRadio),12,_numero_Appel] call TFAR_fnc_SetChannelFrequency;

[(call TFAR_fnc_ActiveSwRadio),_numero_Appel + tf_west_radio_code] call TFAR_fnc_setSwRadioCode;
[(call TFAR_fnc_ActiveSwRadio),1] call TFAR_fnc_setSwStereo;

["Connexion"] spawn MRPV2_fnc_MRP_Tel_Divers_Connexion_TFAR;

TRUE
// };