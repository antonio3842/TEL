private _fond = (profileNamespace getvariable ["MRP_Telephone_Configuration",[]]) # 3;
private _liste_Fond = (profileNamespace getvariable ["MRP_Telephone_Configuration",[]]) # 5;
private _liste_Fond_Blanc = _liste_Fond # 0;
private _couleur_Numero_Est_Noir = TRUE;

if (_fond in _liste_Fond_Blanc) then
{
	_couleur_Numero_Est_Noir = FALSE;
};

_couleur_Numero_Est_Noir