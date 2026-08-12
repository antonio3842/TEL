private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _telephone_Cadre_Base = uiNamespace getVariable ["MRP_Telephone_Cadre_Base",controlNull];

private _liste_Enfants = (allControls _telephone_Cadre_Base) - [_telephone_Cadre_Base];

uiNamespace setVariable ["MRP_Tel_Menu_Taxi", controlNull];
uiNamespace setVariable ["MRP_Tel_Menu_Taxi_Statut", controlNull];
uiNamespace setVariable ["MRP_Tel_Menu_Taxi_Bouton_Appel", controlNull];
uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Bouton_Taxi", controlNull];
uiNamespace setVariable ["MRP_Telephone_Menu_Principal_Label_Taxi", controlNull];

{
	[_x] spawn {params ["_x"]; ctrlDelete _x;};
} foreach _liste_Enfants;

private _liste_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
private _fond = _liste_Configuration # 3 # 0;

if (_fond isequalto "Perso") then
{
	private _Telephone_Fond_HTML = uiNamespace getVariable ["MRP_Telephone_Fond_HTML",controlNull];
	_Telephone_Fond_HTML htmlLoad "";
};

TRUE