class Life_keyGiveBill {
	idd = 3755;
	name = "Life_keyGiveBill";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class Life_RscTitleBackground: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.3;
			y = 0.2;
			w = 0.47;
			h = (1 / 25);
		};

		class MainBackground: Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.3;
			y = 0.2 + (11 / 250);
			w = 0.47;
			h = 0.3 - (22 / 250);
		};
	};

	class controls {
		class Title: Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 3756;
			text = "Montant de la transaction";
			x = 0.3;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};

		class amountEdit: Life_RscEdit {
			idc = 3757;
			text = "0";
			sizeEx = 0.030;
			x = 0.40;
			y = 0.30;
			w = 0.25;
			h = 0.03;
		};

		class submitBtn: Life_RscButtonMenu {
			idc = 3758;
			text = "Envoyer";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "closeDialog 0; private _amount = parseNumber (ctrlText 3757); if (_amount > 0) then { [0, _amount, uiNamespace getVariable ['ALF_KeyGiveBill_Vehicle', objNull], uiNamespace getVariable ['ALF_KeyGiveBill_Unit', objNull], uiNamespace getVariable ['ALF_KeyGiveBill_Index', -1]] call ALF_fnc_keyGiveDefBill; } else { ['INFO', 'Le montant doit être supérieur à 0.', 'warning'] spawn ALF_fnc_doMsg; };";
			x = 0.40;
			y = 0.35;
			w = 0.25;
			h = (1 / 25);
		};
	};
};

