private _Telephone_Liste_Historique = profileNamespace getvariable ["MRP_Telephone_Liste_Historique",[]];
private _telephone_Configuration = profileNamespace getvariable ["MRP_Telephone_Configuration",[]];

_telephone_Configuration set [8,count _Telephone_Liste_Historique];

TRUE