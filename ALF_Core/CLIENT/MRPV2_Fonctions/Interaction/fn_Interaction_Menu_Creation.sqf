/*
// MRPV2_fnc_Interaction_Menu_Creation = {
private _liste_Actions = param [0,createhashmap];


if (_liste_Actions isequalto createhashmap AND {cursorobject isKindOf "man"}) exitwith {["INTERACTION","Vous n'avez aucune interaction disponible avec cette personne.","warning"] spawn ALF_fnc_doMsg;};
if (_liste_Actions isequalto createhashmap AND {!(cursorobject isKindOf "man")}) exitwith {};

createDialog "MRPV2_Interface_Diverse";

private _MRPV2_Interface_Base = uiNamespace getVariable ["MRPV2_Interface_Diverse",controlnull];
private _ctrlGroup = uinamespace getVariable ["_ctrlGroup",controlnull];
private _liste_Bouton_Inter = [];

private _ctrlGroup_Menu_Inter = _MRPV2_Interface_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_ctrlGroup];
uinamespace setVariable ["_ctrlGroup_Menu_Inter",_ctrlGroup_Menu_Inter];
_ctrlGroup_Menu_Inter ctrlSetPosition [-0.7,safeZoney,safeZonew,safeZoneh];
_ctrlGroup_Menu_Inter ctrlSetBackgroundColor [1,0,0,1];
_ctrlGroup_Menu_Inter ctrlCommit 0;

private _pos_Fond = [0.78,0.4,0.9,1.2];

private _ctrl_Fond = _MRPV2_Interface_Base ctrlCreate ["Rscpicture",-1,_ctrlGroup_Menu_Inter];
_ctrl_Fond ctrlsetfade 1;
_ctrl_Fond ctrlCommit 0;
_ctrl_Fond ctrlSetText "\MRPV2_Texture\asset\Menu_Inter_V2.paa";
_ctrl_Fond ctrlSetPosition _pos_Fond;
_ctrl_Fond ctrlCommit 0;

_ctrl_Fond ctrlsetfade 0;
_ctrl_Fond ctrlCommit 0.1;

uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",0];

if (isplayer cursorobject) then 
{
	[_liste_Actions get "Civil"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;
} else 
{
	[_liste_Actions get ""] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;
};
// };
*/


// MRPV2_fnc_Interaction_Menu_Creation = {
private _liste_Actions = param [0,createhashmap];

private _actionsList = _liste_Actions getOrDefault ["",[]];

if (_liste_Actions isequalto createhashmap AND {cursorobject isKindOf "man"}) exitwith {/*["INTERACTION","Vous n'avez aucune interaction disponible avec cette personne.","warning"] spawn ALF_fnc_doMsg;*/};

createDialog "MRPV2_Interface_Diverse";

private _MRPV2_Interface_Base = uiNamespace getVariable ["MRPV2_Interface_Diverse",controlnull];
private _ctrlGroup = uinamespace getVariable ["_ctrlGroup",controlnull];
private _liste_Bouton_Inter = [];

private _ctrlGroup_Menu_Inter = _MRPV2_Interface_Base ctrlCreate ["RscControlsGroupNoScrollbars",-1,_ctrlGroup];
uinamespace setVariable ["_ctrlGroup_Menu_Inter",_ctrlGroup_Menu_Inter];
_ctrlGroup_Menu_Inter ctrlSetPosition [-0.7,safeZoney,safeZonew,safeZoneh];
_ctrlGroup_Menu_Inter ctrlSetBackgroundColor [1,0,0,1];
_ctrlGroup_Menu_Inter ctrlCommit 0;

private _pos_Fond = [0.78,0.4,0.9,1.2];

private _ctrl_Fond = _MRPV2_Interface_Base ctrlCreate ["Rscpicture",-1,_ctrlGroup_Menu_Inter];
_ctrl_Fond ctrlsetfade 1;
_ctrl_Fond ctrlCommit 0;
_ctrl_Fond ctrlSetText "\MRPV2_Texture\asset\Menu_Inter_V2.paa";
_ctrl_Fond ctrlSetPosition _pos_Fond;
_ctrl_Fond ctrlCommit 0;

_ctrl_Fond ctrlsetfade 0;
_ctrl_Fond ctrlCommit 0.1;

uinamespace setVariable ["MRPV2_Menu_Inter_Menu_Choisis",0];

if (isplayer cursorobject) then 
{
	[_liste_Actions get "Civil"] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;
} else 
{
	[_liste_Actions get ""] call MRPV2_fnc_Interaction_Menu_Btn_Inter_Creation;
};
// };