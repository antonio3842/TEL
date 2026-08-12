private _cle = param [0,""];


private _titre = ctrltext (uiNamespace getVariable ["MRP_Tel_Var_Note_Titre",controlNull]);
private _texte = ctrltext (uiNamespace getVariable ["MRP_Tel_Var_Note_Texte",controlNull]);

private _Telephone_Liste_Note = profileNamespace getvariable ["MRP_Telephone_Liste_Note",createhashmap];

if (_cle isEqualto "") then {_cle = str(count _Telephone_Liste_Note + 1);};

_Telephone_Liste_Note set [_cle,[_titre,_texte]];

profileNamespace setvariable ["MRP_Telephone_Liste_Note",_Telephone_Liste_Note];

TRUE