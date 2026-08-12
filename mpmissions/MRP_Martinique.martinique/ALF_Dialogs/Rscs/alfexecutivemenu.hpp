/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ALF_ExecutiveMenu_Dialog
{
	idd = 98;
	name= "ALF_ExecutiveMenu_Dialog";
	movingEnable = false;
	enableSimulation = false;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class static_bg: RscPicture
        {
            idc = 1200;
            text = "ALF_Client2\textures\Executive\ExecutivePanel.paa";
            x = 0 * safezoneW + safezoneX;
            y = 0 * safezoneH + safezoneY;
            w = 1 * safezoneW;
            h = 1 * safezoneH;
        };
        class PlayersList: Life_RscListBox
		{
			idc = 1500;
			x = 0.226719 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.572 * safezoneH;
			sizeEx = .95 * GUI_GRID_H;
		};
		class PlayersSearch: Life_RscEdit
		{
			idc = 1400;
            text = "";
			x = 0.226719 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class PlayerInformation: Life_RscListBox
		{
			idc = 1503;
			x = 0.319529 * safezoneW + safezoneX;
            y = 0.203 * safezoneH + safezoneY;
            w = 0.448594 * safezoneW;
            h = 0.264 * safezoneH;
		};
		class ActionsList: Life_RscListBox
		{
			idc = 1504;
			x = 0.319531 * safezoneW + safezoneX;
            y = 0.478 * safezoneH + safezoneY;
            w = 0.144375 * safezoneW;
            h = 0.319 * safezoneH;
		};
		class MessageBox: Life_RscEdit
		{
			idc = 1402;
            text = "";
			x = 0.474219 * safezoneW + safezoneX;
            y = 0.478 * safezoneH + safezoneY;
            w = 0.293906 * safezoneW;
            h = 0.044 * safezoneH;
		};
		class DirectMessage: Life_RscButtonMenu
		{
			idc = -1;
			text = "Msg Direct";
			x = 0.685625 * safezoneW + safezoneX;
            y = 0.522 * safezoneH + safezoneY;
            w = 0.0825 * safezoneW;
            h = 0.022 * safezoneH;
			action = "call ALF_fnc_staff_direct_message;";
		};
		class GlobalMessage: Life_RscButtonMenu
		{
			idc = -1;
			text = "Msg Global";
			x = 0.474219 * safezoneW + safezoneX;
            y = 0.522 * safezoneH + safezoneY;
            w = 0.0825 * safezoneW;
            h = 0.022 * safezoneH;
			action = "call ALF_fnc_staff_global_message;";
		};
        class BFMMessage: Life_RscButtonMenu
        {
            idc = -1;
            text = "Msg BFMTV";
            x = 0.577344 * safezoneW + safezoneX;
            y = 0.522 * safezoneH + safezoneY;
            w = 0.0825 * safezoneW;
            h = 0.022 * safezoneH;
            action = "call ALF_fnc_bfmOfficiel;";
        };
		class AdminOption_1: Life_RscButtonMenu
		{
			idc = 1016;
            text = "TP Carte";
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[] spawn ALF_fnc_staff_map_teleport;";
		};
		class AdminOption_2: Life_RscButtonMenu
		{
			idc = 1018;
            text = "Freeze";
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "call ALF_fnc_staff_freeze;";
		};
		class AdminOption_3: Life_RscButtonMenu
		{
			idc = 1019;
			text = "Donner liquide";
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "['Donner liquide'] spawn MRPV2_fnc_Admins_Actions;";
		};
		class AdminOption_4: Life_RscButtonMenu
		{
			idc = -1;
			text = "Donner item";
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "['Donner item'] spawn MRPV2_fnc_Admins_Actions;";
		};
		class AdminOption_5: Life_RscButtonMenu
		{
			idc = -1;
			text = "Kicker joueur";
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "['Ejecter'] spawn MRPV2_fnc_Admins_Actions;";
		};
		class AdminOption_6: Life_RscButtonMenu
		{
			idc = -1;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "hint 'AdminOption_6';";
		};
		class AdminOption_7: Life_RscButtonMenu
		{
			idc = 1015;
			text = "Mode Admin";
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[] spawn ALF_fnc_staff_noclip;";
		};
		class AdminOption_8: Life_RscButtonMenu
		{
			idc = -1;
            text = "TP vers moi";
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "call ALF_fnc_staff_teleport_to;";
		};
		class AdminOption_9: Life_RscButtonMenu
		{
			idc = 1453;
            text = "Invincible";
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "call ALF_fnc_staff_god;";
		};
		class AdminOption_10: Life_RscButtonMenu
		{
			idc = -1;
			text = "Soigner";
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "call ALF_fnc_staff_heal_player;";
		};
		class AdminOption_11: Life_RscButtonMenu
		{
			idc = -1;			
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "['Gestion Verrouillage'] spawn MRPV2_fnc_Admins_Actions;";
		};
		class AdminOption_12: Life_RscButtonMenu
		{
			idc = -1;
			text = "Veh Temp";
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "['Veh Temp'] spawn MRPV2_fnc_Admins_Actions;";
		};
		class AdminOption_13: Life_RscButtonMenu
		{
			idc = -1;

			x = 0.577344 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "hint 'AdminOption_13';";
		};
		class AdminOption_14: Life_RscButtonMenu
		{
			idc = -1;

			x = 0.577344 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "hint 'AdminOption_14';";
		};
		class AdminOption_15: Life_RscButtonMenu
		{
			idc = -1;
            text = "TP vers lui";
			x = 0.685625 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "call ALF_fnc_staff_teleport_to_me;";
		};
		class AdminOption_16: Life_RscButtonMenu
		{
			idc = -1;
            text = "Réanimer";
			x = 0.685625 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "call ALF_fnc_staff_revive;";
		};
		class AdminOption_17: Life_RscButtonMenu
		{
			idc = -1;			
			x = 0.685625 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "hint 'AdminOption_17';";
		};
		class AdminOption_18: Life_RscButtonMenu
		{
			idc = -1;
			x = 0.685625 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "hint 'AdminOption_18';";
		};
		class AdminOption_19: Life_RscButtonMenu
		{
			idc = -1;
			text = "Bannir joueur";
			x = 0.685625 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "['Bannir'] spawn MRPV2_fnc_Admins_Actions;";
		};
		class AdminOption_20: Life_RscButtonMenu
		{
			idc = -1;
			x = 0.685625 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "hint 'AdminOption_20';";
		};
		class AdminOption_21: Life_RscButtonMenu
		{
			idc = -1;
			text = "START PAF";
			x = 0.685625 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			action = "if (ALF_AdminLevel >= 3) then {[] remoteExec ['ALF_Server_fnc_pafFlyover', 2]} else {hint 'Accès refusé'}";
		};
	};
};
