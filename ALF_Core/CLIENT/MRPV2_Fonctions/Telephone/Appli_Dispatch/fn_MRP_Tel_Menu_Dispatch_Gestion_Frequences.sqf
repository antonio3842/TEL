private _liste_Frequence = [];
private _frequence_Base = 0;
private _permission_Joueur = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;

private _frequence_Gendarmerie = 600;
private _liste_Frequence_Gendarme =
[
	"GLOBAL","Commandement",
	"PAM Fort de France","PAM Saint Pierre","PAM Le Marin","PAM Le Robert",
	"DSI 1","DSI 2","DSI 3",
	"PMO 1 ","PMO 2",
	"Griffon 972",
	"Brigade Nautique",
	"OP 1","OP 2"
];

private _frequence_Pompier = 650;
private _liste_Frequence_Pompier =
[
    "GLOBAL","CTA / CODIS",
    "Régulation Médicale","Commandement",
    "VSAV 1","VSAV 2","VSAV 3","VSAV 4","VIDP 1","FPT 1","EPA 1 / FPT 2",
    "AR 1","AR 2","SSSM 1","SSSM 2",
    "Divers 1","Divers 2"
];

private _frequence_AP = 700;
private _liste_Frequence_AP =
[
	"GLOBAL","Commandement",
	"Régulation",
	"AP 1","AP 2","AP 3","AP 4","AP 5",
	"PM 1","PM 2",
	"OP 1","OP 2"
];

private _frequence_DIR = 750;
private _liste_Frequence_DIR =
[
	"GLOBAL","Central",
	"DIR 1",
	"DIR 2","DIR 3","DIR 4",
	"Travaux 1","Travaux 2","Permis","SG"
];

[] call
{
	if (_permission_Joueur isEquaLTo "GN") exitwith
	{
		_liste_Frequence = _liste_Frequence_Gendarme;
		_frequence_Base = _frequence_Gendarmerie;
	};

	if (_permission_Joueur isEquaLTo "SP") exitwith
	{
		_liste_Frequence = _liste_Frequence_Pompier;
		_frequence_Base = _frequence_Pompier;
	};

	if (_permission_Joueur isEquaLTo "AP") then
	{
		_liste_Frequence = _liste_Frequence_AP;
		_frequence_Base = _frequence_AP;
	};
};

[_liste_Frequence,_frequence_Base]