#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_craftItem.sqf
	Author: ALF Team
*/
private _mode = _this select 0;
if(isNil "_mode") exitWith {};

switch (_mode) do {
	case 0 : {
		["ALF_Sonnette4G",false] call ALF_fnc_handleItem;
		["ALF_3310",false] call ALF_fnc_handleItem;
		for "_i" from 1 to 2 do {
			["ALF_Vodka",false] call ALF_fnc_handleItem;
		};

		["ALF_C4_Artisanal",true] call ALF_fnc_handleItem;
		["CRAFT","Vous venez de crafter un C4 artisanal !","success"] spawn ALF_fnc_doMsg;
	};
	case 1 : {
		["ALF_pierre_small",false] call ALF_fnc_handleItem;
		for "_i" from 1 to 2 do {
			["ALF_BaconT",false] call ALF_fnc_handleItem;
		};
		for "_i" from 1 to 2 do {
			["ALF_WaterB_G",false] call ALF_fnc_handleItem;
		};
		["ALF_pierre_fer_small",false] call ALF_fnc_handleItem;
		["ALF_ZipCutterP",true] call ALF_fnc_handleItem;
		["CRAFT","Vous venez de crafter un ciseau INOX !","success"] spawn ALF_fnc_doMsg;
	};
	case 2 : {
		for "_i" from 1 to 5 do {
			["ALF_Banane",false] call ALF_fnc_handleItem;
		};
		for "_i" from 1 to 3 do {
			["ALF_Pomme",false] call ALF_fnc_handleItem;
		};
		["ALF_WaterB_G",false] call ALF_fnc_handleItem;
		["ALF_Vodka",true] call ALF_fnc_handleItem;
		["CRAFT","Vous venez de crafter une bouteille de Vodka !","success"] spawn ALF_fnc_doMsg;
	};
	case 3 : {
		["ALF_pierre_small",false] call ALF_fnc_handleItem;
		for "_i" from 1 to 3 do {
			["ALF_Buche",false] call ALF_fnc_handleItem;
		};
		["ALF_Batte",true] call ALF_fnc_handleItem;
		["CRAFT","Vous venez de crafter une batte !","success"] spawn ALF_fnc_doMsg;
	};
	case 4 : {
		["ALF_pierre_small",false] call ALF_fnc_handleItem;
		["ALF_pierre_fer_small",false] call ALF_fnc_handleItem;
		for "_i" from 1 to 5 do {
			["ALF_BaconT",false] call ALF_fnc_handleItem;
		};

		["ALF_Couteau",true] call ALF_fnc_handleItem;
		["CRAFT","Vous venez de crafter un couteau !","success"] spawn ALF_fnc_doMsg;
	};
	case 5 : {
		["ALF_Cocaine",false] call ALF_fnc_handleItem;
		for "_i" from 1 to 2 do {
			["ALF_Banane",false] call ALF_fnc_handleItem;
		};

		for "_i" from 1 to 2 do {
			["ALF_Cocaine_2",true] call ALF_fnc_handleItem;
		};
		["CRAFT","Vous venez de crafter de la cocaine coupé !","success"] spawn ALF_fnc_doMsg;
	};
	case 6 : {
		/*
		["ALF_Pioche",false] call ALF_fnc_handleItem;
		["ALF_Peche",false] call ALF_fnc_handleItem;
		for "_i" from 1 to 2 do {
			["ALF_Banane",false] call ALF_fnc_handleItem;
		};
		for "_i" from 1 to 2 do {
			["ALF_BaconT",false] call ALF_fnc_handleItem;
		};

		["KA_crossbow_vodka",true] call ALF_fnc_handleItem;
		["CRAFT","Vous venez de crafter une pioche customisé !","success"] spawn ALF_fnc_doMsg;
		*/
	};
	case 7 : {
		for "_i" from 1 to 2 do {
			["ALF_Cuivre",false] call ALF_fnc_handleItem;
		};
		for "_i" from 1 to 4 do {
			["ALF_coca",false] call ALF_fnc_handleItem;
		};
		["ALF_Locker_Artisanal",true] call ALF_fnc_handleItem;
		["CRAFT","Vous venez de crafter un cadenas artisanal !","success"] spawn ALF_fnc_doMsg;
	};
	case 8 : {
		for "_i" from 1 to 2 do {
			["ALF_Cuivre",false] call ALF_fnc_handleItem;
		};
		for "_i" from 1 to 4 do {
			["ALF_coca",false] call ALF_fnc_handleItem;
		};
		["ALF_3310",false] call ALF_fnc_handleItem;
		for "_i" from 1 to 2 do {
			["ALF_Vodka",false] call ALF_fnc_handleItem;
		};

		["ALF_LockerC4_Artisanal",true] call ALF_fnc_handleItem;
		["CRAFT","Vous venez de crafter un piege artisanal !","success"] spawn ALF_fnc_doMsg;
	};
	case 8 : {
		for "_i" from 1 to 2 do {
			["ALF_Cuivre",false] call ALF_fnc_handleItem;
		};
		for "_i" from 1 to 4 do {
			["ALF_coca",false] call ALF_fnc_handleItem;
		};
		["ALF_3310",false] call ALF_fnc_handleItem;
		for "_i" from 1 to 2 do {
			["ALF_Vodka",false] call ALF_fnc_handleItem;
		};

		["ALF_LockerC4_Artisanal",true] call ALF_fnc_handleItem;
		["CRAFT","Vous venez de crafter un piege artisanal !","success"] spawn ALF_fnc_doMsg;
	};
	case 9 : {
		for "_i" from 1 to 3 do {
			["ALF_Pomme",false] call ALF_fnc_handleItem;
		};
		["ALF_Mais",false] call ALF_fnc_handleItem;

		["ALF_Tarte_Pomme",true] call ALF_fnc_handleItem;
		["BOULANGERIE","Vous venez de faire une tarte aux pommes artisanale !","success"] spawn ALF_fnc_doMsg;
	};
	case 10 : {
		for "_i" from 1 to 3 do {
			["ALF_Fraise",false] call ALF_fnc_handleItem;
		};
		["ALF_Mais",false] call ALF_fnc_handleItem;

		["ALF_Tarte_Fraise",true] call ALF_fnc_handleItem;
		["BOULANGERIE","Vous venez de faire une tarte aux fraises artisanale !","success"] spawn ALF_fnc_doMsg;
	};
	case 11 : {
		for "_i" from 1 to 4 do {
			["ALF_Pomme",false] call ALF_fnc_handleItem;
		};

		["ALF_Confiture_Pomme",true] call ALF_fnc_handleItem;
		["BOULANGERIE","Vous venez de faire une compote de pommes artisanale !","success"] spawn ALF_fnc_doMsg;
	};
	case 12 : {
		for "_i" from 1 to 4 do {
			["ALF_Fraise",false] call ALF_fnc_handleItem;
		};

		["ALF_Confiture_Fraise",true] call ALF_fnc_handleItem;
		["BOULANGERIE","Vous venez de faire une confiture de fraises artisanale !","success"] spawn ALF_fnc_doMsg;
	};
	case 13 : {
		for "_i" from 1 to 4 do {
			["ALF_Fraise",false] call ALF_fnc_handleItem;
		};

		["ALF_Jus_Fraise",true] call ALF_fnc_handleItem;
		["PRESSOIR","Vous venez de faire un jus de fraise !","success"] spawn ALF_fnc_doMsg;
	};
	case 14 : {
		for "_i" from 1 to 4 do {
			["ALF_Pomme",false] call ALF_fnc_handleItem;
		};

		["ALF_Jus_Pomme",true] call ALF_fnc_handleItem;
		["PRESSOIR","Vous venez de faire un jus de pomme !","success"] spawn ALF_fnc_doMsg;
	};
	case 15 : {
		for "_i" from 1 to 4 do {
			["ALF_Raisin",false] call ALF_fnc_handleItem;
		};

		["ALF_Jus_Raisin",true] call ALF_fnc_handleItem;
		["PRESSOIR","Vous venez de faire un jus de raisin !","success"] spawn ALF_fnc_doMsg;
	};
};
