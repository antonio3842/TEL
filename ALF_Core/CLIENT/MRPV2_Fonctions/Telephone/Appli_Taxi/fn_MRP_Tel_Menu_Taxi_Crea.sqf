// MRPV2_fnc_MRP_Tel_Menu_Taxi_Crea = {
disableSerialization;

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base", displayNull];
private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond", controlNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base", controlNull];

_Telephone_Fond ctrlSetText "MRP_icone_tel\Data\Menu_Bloc_Note\Menu_Note_Vide_dxt5.paa";

private _ctrl_Titre = _Telephone_Base ctrlCreate ["RscStructuredText", -1, _telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_Menu_Taxi", _ctrl_Titre];
_ctrl_Titre ctrlSetPosition [0.05, 0.12, 0.45, 0.1];
_ctrl_Titre ctrlCommit 0;
_ctrl_Titre ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#000000' size='2' align='left'>%1</t>", "Taxi"];

private _ctrl_Statut = _Telephone_Base ctrlCreate ["RscStructuredText", -1, _telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_Menu_Taxi_Statut", _ctrl_Statut];
_ctrl_Statut ctrlSetPosition [0.06, 0.28, 0.44, 0.12];
_ctrl_Statut ctrlCommit 0;

private _ctrlButton = _Telephone_Base ctrlCreate ["MRP_Bouton", -1, _telephone_Cadre_Base];
uiNamespace setVariable ["MRP_Tel_Menu_Taxi_Bouton_Appel", _ctrlButton];
_ctrlButton ctrlSetPosition [0.08, 0.48, 0.4, 0.1];
_ctrlButton ctrlSetText "Appeler un taxi";
_ctrlButton ctrlSetTextColor [0, 0, 0, 1];
_ctrlButton ctrlCommit 0;

_ctrlButton ctrlAddEventHandler ["ButtonClick",
{
	params ["_control"];
	[_control, 1.5] spawn MRPV2_fnc_MRP_Tel_Divers_Anti_Spam_Bouton;
	[] call MRPV2_fnc_MRP_Tel_Menu_Taxi_Action_Appeler;
}];

[] call MRPV2_fnc_MRP_Tel_Menu_Taxi_Gestion_Statut;

[] spawn
{
	while {!isNull (uiNamespace getVariable ["MRP_Tel_Menu_Taxi_Statut", controlNull])} do {
		sleep 5;
		if (!isNull (uiNamespace getVariable ["MRP_Tel_Menu_Taxi_Statut", controlNull])) then {
			[] call MRPV2_fnc_MRP_Tel_Menu_Taxi_Gestion_Statut;
		};
	};
};

[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Action_Retour;

TRUE
// };
