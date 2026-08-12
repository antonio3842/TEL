private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];
if (_telephone_Cadre_Base isequalto controlNull) exitwith {};

sleep 1;

private _Telephone_Cadre_Base_Tentative = uiNamespace getVariable ["MRP_Telephone_Cadre_Base_Tentative",controlNull];

if (_Telephone_Cadre_Base_Tentative isNotEquaLTo controlNull) then
{
	private _liste_Enfants = allControls _Telephone_Cadre_Base_Tentative;

	{
		ctrlDelete _x;
	} foreach _liste_Enfants;

	ctrlDelete _Telephone_Cadre_Base_Tentative;
};

private _fond_Menu_En_Attente = uiNamespace getVariable ["MRP_Telephone_Fond_Menu_En_Attente",""];

// si pendant l'appel on a refermer le tel on repart sur lecran principal
if (_fond_Menu_En_Attente isequalto "") exitwith
{
	[] call MRPV2_fnc_MRP_Tel_Menu_Principal_Crea;

	TRUE
};

private _liste_Enfants = allControls _telephone_Cadre_Base;

{
	_x ctrlShow TRUE;
} foreach _liste_Enfants;

private _Telephone_Fond = uiNamespace getVariable ["MRP_Telephone_Fond",controlNull];
// private _Telephone_Fond_2 = uiNamespace getVariable ["MRP_Telephone_Fond_2",controlNull];

_Telephone_Fond ctrlSetText _fond_Menu_En_Attente;
// _Telephone_Fond_2 ctrlSetText _fond_Menu_En_Attente;
uiNamespace setVariable ["MRP_Telephone_Fond_Menu_En_Attente",nil];

private _compteur_Nouveau_Appel = [] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Nombre_Appel;
private _ctrlButton = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_Creation_Bouton_Appel",controlNull];

// Modification icone si nouveau appel sur le menu principal
if (_compteur_Nouveau_Appel > 0 AND {_ctrlButton isNotEqualTo controlNull}) then
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Principal\Icone_Appel_Rec.paa";
	_ctrlButton ctrlSetPosition [0.053,1.188,0.133,0.133];
	_ctrlButton ctrlCommit 0;

	private _ctrl_Compteur_Nouveau_Appel = uiNamespace getVariable ["MRP_Telephone_Menu_Principal_Compteur_Nouveau_Appel",controlNull];

	if (_ctrl_Compteur_Nouveau_Appel isEqualTo controlNull) then
	{
		private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
		_ctrl_Compteur_Nouveau_Appel = _Telephone_Base ctrlCreate ["MRP_Structured_Text",-1,_telephone_Cadre_Base];
		uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Compteur_Nouveau_Appel",_ctrl_Compteur_Nouveau_Appel];
		_ctrl_Compteur_Nouveau_Appel ctrlSetPosition [0.127,1.195,0.05,0.05];
		_ctrl_Compteur_Nouveau_Appel ctrlCommit 0;
	};

	_ctrl_Compteur_Nouveau_Appel ctrlSetStructuredText parsetext format ["<t font='SFUIDisplay_20' color='#ffffff' shadow='0' size='0.8' align='center'>%1</t>",_compteur_Nouveau_Appel];
};

// Si on est dans menu historique on met a jour la liste
private _ctrl_Historique = uiNamespace getVariable ["MRP_Telephone_Menu_Historique_Ctrl",controlNull];

if (_ctrl_Historique isnotEqualTo controlNull) then
{
	[] call MRPV2_fnc_MRP_Tel_Menu_Historique_Crea_Liste;
};

TRUE