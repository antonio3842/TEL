// MRPV2_fnc_MRP_Tel_Init_Joueur_Histo = {
private _retour = [] call MRPV2_fnc_MRP_Tel_Init_Histo_API;
private _code_Rep = _retour # 0;
private _liste_Histo = _retour # 1;


if true exitwith {};

if (_code_Rep isequalto 200 AND {_liste_Histo isEqualTo []}) then
{	
	private _liste_Histo_ProfileName = profileNamespace getvariable ["MRP_Telephone_Liste_Historique",[]];
	if (_liste_Histo_ProfileName isNotEqualTo []) then
	{
		player setvariable ["MRP_Telephone_Liste_Historique",_liste_Histo_ProfileName];
		[_liste_Histo_ProfileName] call MRPV2_fnc_MRP_Tel_Init_Joueur_Histo_API_Crea;
	};
} else
{
	profileNamespace getvariable ["MRP_Telephone_Liste_Historique",[]];
	private _Telephone_Configuration_Vide = (profileNamespace getVariable ["MRP_Telephone_Configuration",[]]) isequalto [];

	if (_Telephone_Configuration_Vide) then
	{
		_config_Tel =
		[
			FALSE,//0 Mode avion activé
			FALSE,//1 Mode vibreur
			FALSE,//2 Mode Incognito activé
			["Generique_1",["",""]],//3 fond ecran
			"Apple",//4 Sonnerie
			[],//5 Fond Perso Internet et liste fond ecran fond noir (0) et fond blanc (1) (Remplissage déplacé plus bas)
			[],//6 Liste sonnerie dispo (Remplissage déplacé plus bas)
			createHashMap,//7 Liste nombre SMS par contact archivé
			0,//8 Nombre appel archivé
			[],//9 Liste fréquence sauvegarder Appli radio
			[0,0],//10 Liste position audio Principal et Secondaire
			FALSE, //11 Mode entreprise		
			[0,0] //12 Nombre mail cache et durée servertime avant re call
		];		
	} else
	{
		_config_Tel = profileNamespace getVariable ["MRP_Telephone_Configuration",[]];
		_config_Tel set [5,[]];
		_config_Tel set [6,[]];
	};

	[_config_Tel] call MRPV2_fnc_MRP_Tel_Init_Conf_API_Crea;
};

private _liste_Fond = 
[["Perso"],
[
	"France",
	"GIGN",
	"Biker",
	"Pompier",
	"Punisher",
	"SC_Vanguard"
],
[
	"Generique_1",
	"Generique_2",
	"Martinique",
	"Canabis",
	"ACAB",
	"WEEB",
	"Plage",
	"Justice"
]];

private _liste_Son = 
[
	"Apple",
	"Tempasta",
	"Marimba"
];

_config_Tel set [5,_liste_Fond];
_config_Tel set [6,_liste_Son];

player setVariable ["MRP_Telephone_Configuration",_config_Tel];

player setVariable ["MRP_Telephone_Numero_Cacher",_config_Tel # 2];
player setVariable ["MRP_Telephone_Mode_Avion",_config_Tel # 0];
player setVariable ["MRP_Telephone_Mode_Entreprise",_config_Tel # 11];
// };