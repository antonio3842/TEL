#include "\ALF_Core\SERVER\script_macros.hpp"

private["_currentArray"];

ALFMARKET_Events = time + (30*60);

ALFMARKET_Items_Groups =
[
	["Pierre",
		[
			["ALF_pierre_small",-1,55,70],
			["ALF_Cuivre",-1,270,300],
			["ALF_Fer",-1,550,650],
			["Verre_plat",-1,150,300]
			// ["ALF_Bronze",-1,385,585],
			// ["ALF_Argent",-1,610,810],
			//["ALF_Or",-1,10000,20000]
		],
		1
	],
	["Paysan",
		[
			["ALF_Banane",-1,10,10],
			// ["ALF_Peche",-1,10,10],
			// ["ALF_Raisin",-1,25,25],
			["ALF_Champignon",-1,60,70],
			["ALF_Tabac_Seche",-90,250,340],
			["murshun_cigs_cig0",-490,1300,1500],
			// ["ALF_Fraise",-1,55,75],
			// ["ALF_Truffe",-1,200,260],
			["ALF_Buche",-1,150,200],
			["ALF_Planche_B",-1,365,485],
			["peau_mouton",-1,100,220]
		],
		1
	],
	["Entreprise",
		[
			// ["ALF_Vin",-1,385,585],
			["ALF_XxX",-1,385,585],
			// ["ALF_Pinot",-1,385,585],
			// ["ALF_Whisky",-1,500,900],
			// ["ALF_Confiture_Fraise",-1,500,900],
			// ["ALF_Confiture_Pomme",-1,350,600],
			// ["ALF_Jus_Pomme",-1,350,550],
			// ["ALF_Jus_Fraise",-1,350,550],
			// ["ALF_Jus_Raisin",-1,350,550],
			["ALF_Barile_P_F",-1,700,800],
			["ALF_Barile_Station",-1,1800,2000],
			["ALF_diamant_taille",-1,1400,1500],
			["ALF_diamant_precieux",-1,2000,2100],
			["ALF_saphir_taille",-1,1375,1500],
			["bouteille_rhum",-1,175,150],
			["MRP_Palette",-1,1000,1200],
			["MRP_Linteau_x6",-1,6300,6500],
			["MRP_Carton_Compote",-1,2000,4000],
			["MRP_IPN_x6",-1,13000,13200],
			["carton_rhum",-1,5000,5200],
			["MRP_saphir_precieux",-1,1800,2000],
			["Verre_plat_x10",-1,7000,7200]
		],
		1
	],
	["Peche",
		[
			["ALF_Maquereau_Crue_M",-1, 255, 250],
            ["ALF_Maquereau_Cuit_M",-1, 180, 250],
            ["ALF_Sardine",-1, 225, 250],
            ["ALF_Thon",-1, 255, 300],
            ["MRP_Sushi_Thon",-1, 975, 1100],
            ["ALF_Barbeau",-1, 300, 350],
            ["ALF_Brochet",-1, 375, 400],
            ["ALF_Anguille",-1, 450, 500],
            ["ALF_Saumon",-1, 450, 550],
            ["MRP_Sushi_Saumon",-1, 1200, 1300],
			["MRP_Blanc_Poulet",-1, 1900, 2300],
			["MRP_Cote_agneau",-1, 1900, 2300],
			["MRP_viande_lapin",-1, 1900, 2300],
			// ["ALF_Tortue",-1, 3000, 4000], // illégal
			["ALF_Squale",-1, 2000, 2500]  // illégal
		],
		0.8
	],
	["Illegal",
		[
			["ALF_Weed",-1,1200,1800],
			["ALF_Weed_2",-1,1400,1950],
			["ALF_Weed_3",-1,1600,2300],
			["ALF_Weed_P",-1,19000,28800],
			["ALF_Weed_P_2",-1,24000,35700],
			["ALF_Weed_P_3",-1,32000,42800],
			["ALF_Relique_1",-1,19000,21000],
			["ALF_Relique_2",-1,21000,22000],
			["ALF_Relique_3",-1,22000,24000],
			["ALF_Cupidon",-1,70000,90000],
			["ALF_Cocaine",-1,5300,6300],
			["ALF_Cocaine_2",-1,5300,6300],
			["ALF_Meth50",-1,3900,5200],
			["ALF_Meth90",-1,5900,7100],
			["Carapace_Tortue",-1,2500,3000],
			["Viande_Tortue",-1,3000,380],
			["ALF_Squale",-1, 2000, 2500]  // illégal
		],
		1
	]
];

ALFMARKET_Items_Base =
[
	["ALF_Banane",10],
	["ALF_Champignon",60],
	["ALF_Tabac_Seche",100],
	["ALF_Mais",225],
	["ALF_Buche",150],
	["ALF_Planche_B",365],
	["ALF_pierre_small",55],
	["ALF_Cuivre",270],
	["ALF_Fer",550],
	["ALF_Bronze",485],
	["ALF_Argent",710],
	["ALF_Barile_P_F",1800],
	["murshun_cigs_cig0",500],
	["ALF_Barile_Station",1100],
	["ALF_Or",15000],
	["ALF_diamant_taille",1400],
	["ALF_diamant_precieux",2000],
	["ALF_saphir_taille",1375],
	["ALF_Weed",1447],
	["ALF_Weed_2",1695],
	["ALF_Weed_3",1695],
	["ALF_Weed_P",19000],
	["ALF_Weed_P_2",20000],
	["ALF_Weed_P_3",30000],
	["ALF_Cocaine",5300],
	["ALF_Cocaine_2",5300],
	["ALF_Meth50",4830],
	["ALF_Meth90",6545],
	["ALF_Relique_1",20000],
	["ALF_Relique_2",21500],
	["ALF_Relique_3",23000],
	["ALF_Cupidon",80000],
	["ALF_Maquereau_Crue_M",200],
	["ALF_Maquereau_Cuit_M",130],
	["ALF_Sardine",200],
	["ALF_Thon",150],
	["ALF_Barbeau",200],
	["ALF_Saumon",250],
	["carton_rhum",5000],
	["ALF_Brochet",300],
	["ALF_Anguille",350],
	["ALF_Tortue",1200],
	["ALF_Squale",1700],
	["ALF_XxX",400],
	["ALF_Confiture_Fraise",800],
	["ALF_Confiture_Pomme",500],
	["ALF_Whisky",750],
	["bouteille_rhum",120],
	["Carapace_Tortue",2500],
	["MRP_Palette",1000],
	["MRP_Linteau_x6",6300],
	["MRP_Carton_Compote",3500],
	["MRP_IPN_x6",13000],
	["Verre_plat",200],
	["MRP_Blanc_Poulet",2150],
	["MRP_Cote_agneau",2150],
	["MRP_viande_lapin",2150],
	["Viande_Tortue",2000],
	["MRP_Sushi_Saumon",900],
	["MRP_Sushi_Thon",700],
	["MRP_saphir_precieux",1800],
	["peau_mouton",170],
	["Verre_plat_x10",7000]

];

//[["ALF_Banane",10,0],["ALF_Champignon",60,0],["ALF_Tabac_Seche",100,0],["ALF_Mais",225,0],["ALF_Buche",150,0],["ALF_Planche_B",365,0],["ALF_pierre_small",55,0],["ALF_Cuivre",270,0],["ALF_Fer",550,0],["ALF_Bronze",485,0],["ALF_Argent",710,0],["ALF_Barile_P_F",1800,0],["murshun_cigs_cig0",500,0],["ALF_Barile_Station",1100,0],["ALF_Or",15000,0],["ALF_diamant_taille",1400,0],["ALF_diamant_precieux",2000,0],["ALF_saphir_taille",1375,0],["ALF_Weed",1447,0],["ALF_Weed_2",1695,0],["ALF_Weed_3",1695,0],["ALF_Weed_P",7200,0],["ALF_Weed_P_2",8400,0],["ALF_Weed_P_3",9600,0],["ALF_Cocaine",4256,0],["ALF_Cocaine_2",6021,0],["ALF_Meth50",4830,0],["ALF_Meth90",6545,0],["ALF_Relique_1",20000,0],["ALF_Relique_2",21500,0],["ALF_Relique_3",23000,0],["ALF_Cupidon",80000,0],["ALF_Maquereau_Crue_M",200,0],["ALF_Maquereau_Cuit_M",130,0],["ALF_Sardine",200,0],["ALF_Thon",150,0],["ALF_Barbeau",200,0],["ALF_Saumon",250,0],["carton_rhum",5000,0],["ALF_Brochet",300,0],["ALF_Anguille",350,0],["ALF_Tortue",1200,0],["ALF_Squale",1700,0],["ALF_XxX",400,0],["ALF_Confiture_Fraise",800,0],["ALF_Confiture_Pomme",500,0],["ALF_Whisky",750,0],["bouteille_rhum",120,0],["Carapace_Tortue",2500,0],["MRP_Palette",1000,0],["MRP_Linteau_x6",6300,0],["MRP_Carton_Compote",3500,0],["MRP_IPN_x6",13000,0],["Verre_plat",200,0],["MRP_Blanc_Poulet",2150,0],["MRP_Cote_agneau",2150,0],["MRP_viande_lapin",2150,0],["Viande_Tortue",2000,0],["MRP_Sushi_Saumon",900,0],["MRP_Sushi_Thon",700,0],["MRP_saphir_precieux",1800,0],["peau_mouton",170,0],["Verre_plat_x10",7000,0]]

ALFMARKET_Items_PriceArr = [];
ALFMARKET_sellarraycopy = ALFMARKET_Items_Base;
{
	_currentArray = _x;
	ALFMARKET_Items_PriceArr pushBack [_currentArray select 0,_currentArray select 1,0];
} forEach ALFMARKET_Items_Base;

[1] call ALF_Server_fnc_saveBourse;
ALFMARKET_UpdateCount = 0;

uiSleep 5;

for "_i" from 0 to 1 step 0 do {
	uiSleep (5 * 60);
	[0] remoteExecCall ["ALF_fnc_updateClientBourse",0];
	uiSleep 5;
	if((time - ALFMARKET_Events) > (30*60)) then {
		[] call ALF_Server_fnc_calculBourse;
		ALFMARKET_UpdateCount = ALFMARKET_UpdateCount + 1;
		if ((ALFMARKET_UpdateCount isEqualTo 3)) then {
			[] spawn {
				ALFMARKET_UpdateCount = 0;
				[0] call ALF_Server_fnc_saveBourse;
			};
		};
	};
};
