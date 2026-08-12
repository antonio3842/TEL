// MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Ope_Freq = {
private _frequence_base = param [0,0,[0,""]];
private _index = param [1,-1];


// si les chiffre arrive en string on les convertis en nombre
if (typename _frequence_base isequalto "STRING") then {_frequence_base = parsenumber _frequence_base;};

private _frequence = _frequence_base;
if (_index isnotequalto -1) then {_frequence = _frequence_base + _index};

private _service = (((player getvariable ["service",objnull]) getvariable ["ent",[-1,""]]) # 0);
private _liste_Collegues = (allplayers select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT) isEquaLTo ([] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)}) - [player];

private _canal_rechercher = 1;
if (_index isequalto 0) then {_canal_rechercher = 2;};

private _nombre = count (_liste_Collegues select {([(_x getSlotItemName 611),_canal_rechercher] call TFAR_fnc_GetChannelFrequency) isequalto str _frequence});

_nombre
// };