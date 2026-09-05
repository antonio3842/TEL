// MRPV2_fnc_MRP_Tel_Menu_CA_Action_Appel_Variables = {
private _control = param [0,controlNull];
private _numero = param [1,""];


private _info_Appel_CA_Ope = player getvariable ["MRP_Tel_CA_Info_Operateur",createHashMap] get _numero;
private _liste_id_Appelants = _info_Appel_CA_Ope # 2;
private _id_Appelant = _liste_id_Appelants # 0;
private _etat_Appel = _info_Appel_CA_Ope # 1;
private _numero_Masquer = _info_Appel_CA_Ope # 3;
private _mode_Entreprise = _info_Appel_CA_Ope # 4;

[] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_Suppr_Son",_id_Appelant];

[_numero,"Appel mon appel",_id_Appelant,""] call MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat;

// On maj les cadres et statut des autres opé
private _liste_Unites_En_Service = (units group player);;

[_numero,"Appel opé maj opé",clientowner] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_liste_Unites_En_Service];

private _unite_Appellant = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (_numero)}) # 0;
private _service = [] call MRPV2_fnc_MRP_NB_Service_Vers_TXT;
[_numero,"Appel opé maj appelant",clientowner,_service] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_unite_Appellant];

player setvariable ["MRP_Appel_Etat","Appel CA en cours"];

[_numero] call MRPV2_fnc_MRP_Tel_Divers_Debut_Appel_TFAR;
[player] call MRPV2_fnc_MRP_Tel_Divers_Gestion_Etat_Joueur_En_Appel;

if (_numero_Masquer) then {_numero = "";};
if (_mode_Entreprise) then {_numero = _unite_Appellant getVariable ["TelPro",""];};

TRUE
// };