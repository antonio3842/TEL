private _nombre_Appel_Archiver = (profileNamespace getvariable ["MRP_Telephone_Configuration",[]]) # 8;
private _nombre_Appel_Historique = count (profileNamespace getvariable ["MRP_Telephone_Liste_Historique",[]]);
private _compteur_Nouveau_Appel = _nombre_Appel_Historique - _nombre_Appel_Archiver;

_compteur_Nouveau_Appel