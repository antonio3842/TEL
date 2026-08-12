// MRPV2_fnc_MRP_Tel_Menu_Appel_Action_Bouton = {
private _numero = param [0,""];
private _control = param [1,controlNull];


[_control] spawn MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer;

if !(isnil {MRP_Telephone_Gestion_Numero_Interne}) exitwith {};

private _cadran_Numero = uiNamespace getVariable ["MRP_Telephone_Menu_Appel_Cadran_Numero",controlNull];
private _numero_Partiel = ctrlText _cadran_Numero;
private _numero_Complet = _numero_Partiel + _numero;
private _numero_Fractionner = _numero_Partiel splitstring "";
private _nombre_Numero_Fractionner = count _numero_Fractionner + 1;
private _limite_Numero = 15;

[] call
{
	private _nom_son = _numero;
	if (_numero isEqualTo "*") then {_nom_son = "Etoile";};
	if (_numero isEqualTo "#") then {_nom_son = "Diese";};

	playsound ("MRP_Telephone_Numero_" + _nom_son);
};

if (_nombre_Numero_Fractionner < _limite_Numero) then
{
	private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
	private _numero_Est_Contact = (_liste_Contact getOrDefault [_numero,[]]) isNotequalto [];
	private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
	private _numero_Est_Service = (_liste_Entreprise select {(_x getOrDefault ["PHONE",""]) isequalto _numero_Complet}) isnotequalto [];

	if (_numero_Est_Contact OR {_numero_Est_Service}) then {MRP_Telephone_Gestion_Numero_Interne = _numero_Complet;};

	_intituler_Identifiant = [_numero_Complet] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Intituler;
	_cadran_Numero ctrlSetStructuredText parseText format ["<t font='SFUIDisplay_46' shadow='0' color='#000000' size='1.8' valign='bottom' align='center'>%1</t>",_intituler_Identifiant];
};

[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Gestion_Couleur_Bouton_Ajouter;

TRUE
// };