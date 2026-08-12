#undef GUI_GRID_H
#define GUI_GRID_H	(0.04)

//--- swag
#define IDC_SWAG_B_APPEL	2222
#define IDC_SWAG_B_RESPAWN	2223


class COMA
{
	idd = 4333;
	onLoad = "";
    onUnLoad = "";
	class controls 
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Matthew Way, v1.063, #Nyjygu)
		////////////////////////////////////////////////////////
		
		class B_APPEL: RscButton
		{
			idc = IDC_SWAG_B_APPEL;
			x = 0.0410937 * safezoneW + safezoneX;
			y = 0.863 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class B_RESPAWN: RscButton
		{
			idc = IDC_SWAG_B_RESPAWN;
			x = 0.0410937 * safezoneW + safezoneX;
			y = 0.907 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.033 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

    };
};
/* #Dizabe
$[
	1.063,
	["swag",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,1,0],
	[1600,"B_APPEL",[2,"",["-24.5 * GUI_GRID_W + GUI_GRID_X","29 * GUI_GRID_H + GUI_GRID_Y","16.5 * GUI_GRID_W","1.5 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"B_RESPAWN",[2,"",["-24.5 * GUI_GRID_W + GUI_GRID_X","31 * GUI_GRID_H + GUI_GRID_Y","16.5 * GUI_GRID_W","1.5 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
