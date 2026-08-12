private _Telephone_Cadre_Base_Tentative = param [0,controlNull];


private _fond_Haut = _Telephone_Base ctrlCreate ["RscBackGround",-1,_Telephone_Cadre_Base_Tentative];

if ("MRP_Item_Iphone_12" in str assignedItems player) then
{
	_fond_Haut ctrlSetPosition [0.05,0.032,0.458,0.03];

	private _fond_Milieu = _Telephone_Base ctrlCreate ["RscBackGround",-1,_Telephone_Cadre_Base_Tentative];
	_fond_Milieu ctrlSetPosition [0.03,0.062,0.5,1.28];
	_fond_Milieu ctrlSetBackgroundColor [0,0,0,0.3];
	_fond_Milieu ctrlCommit 0;
	_fond_Milieu ctrlenable FALSE;

	private _fond_Bas = _Telephone_Base ctrlCreate ["RscBackGround",-1,_Telephone_Cadre_Base_Tentative];
	_fond_Bas ctrlSetPosition [0.05,1.341,0.458,0.029];
	_fond_Bas ctrlSetBackgroundColor [0,0,0,0.3];
	_fond_Bas ctrlCommit 0;
	_fond_Bas ctrlenable FALSE;
} else
{
	_fond_Haut ctrlSetPosition [0.037,0.039,0.485,1.335];
};

_fond_Haut ctrlSetBackgroundColor [0,0,0,0.3];
_fond_Haut ctrlCommit 0;
_fond_Haut ctrlenable FALSE;

TRUE