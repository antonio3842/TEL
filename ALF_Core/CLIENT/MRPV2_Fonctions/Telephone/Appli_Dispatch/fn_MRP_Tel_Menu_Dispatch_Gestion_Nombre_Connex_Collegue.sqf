// MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue = {
private _texte = param [0,""];
private _frequence = param [1,""];
private _index = param [2,-1];


private _ctrl_Liste_Controle_Canaux = uiNamespace getVariable ["MRP_Telephone_Menu_Dispatch_ctrl_Liste_Controle_Canaux",controlNull];
if (_ctrl_Liste_Controle_Canaux isequalto controlNull) exitwith {TRUE};

private _liste_Controle = allControls _ctrl_Liste_Controle_Canaux;
private _ctrl_Ancien_Nombre = controlNull;

{
	if ((ctrltext _x) isequalto _texte) then {_ctrl_Ancien_Nombre = _liste_Controle # (_foreachindex + 1);};
} foreach _liste_Controle;

if !(isnil {_ctrl_Ancien_Nombre}) then
{
	private _est_Connecter_A_La_Freq = !(isnil {MRP_Telephone_Info_Dispatch}) AND {_texte in str(MRP_Telephone_Info_Dispatch)};
	private _nombre_Joueur_Connecter = [_frequence,_index] call MRPV2_fnc_MRP_Tel_Menu_Dispatch_Gestion_Nombre_Ope_Freq;

	if (_est_Connecter_A_La_Freq) then
	{
		_ctrl_Ancien_Nombre ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#3dff00' size='1' align='Right'>%1</t>",_nombre_Joueur_Connecter];
	} else
	{
		_ctrl_Ancien_Nombre ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='1.5' color='#ffffff' size='1' align='Right'>%1</t>",_nombre_Joueur_Connecter];
	};
};

TRUE
// };