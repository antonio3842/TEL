// [{
// MRPV2_fnc_Interaction_PNJ_Concessionnaire = {
private _objCurseur = toloweransi str cursorObject;
private _liste_Actions = createHashMap;
private _infos = [];

[] call 
{
    if (toloweransi "MRPV2_PNJ_Concessionnaire_Camion" in _objCurseur) exitWith {_infos = ["camion", "Concessionnaire d'utilitaires"];};
    if (toloweransi "MRPV2_PNJ_Concessionnaire_BMW" in _objCurseur) exitWith {_infos = ["sports", "Concessionnaire Sports"];};
    if (toloweransi "MRPV2_PNJ_Concessionnaire_Audi" in _objCurseur) exitWith {_infos = ["audi", "Concessionnaire Audi"];};
    if (toloweransi "MRPV2_PNJ_Concessionnaire_Scooter" in _objCurseur) exitWith {_infos = ["ALF_Scooter", "Concessionnaire de scooter"];};
    if (toloweransi "MRPV2_PNJ_Concessionnaire_Moto" in _objCurseur) exitWith {_infos = ["moto", "Concessionnaire de moto"];};
    if (toloweransi "MRPV2_PNJ_Concessionnaire_Peugeot" in _objCurseur) exitWith {_infos = ["peugeot", "Concess. Peugeot/Citröen"];};
    if (toloweransi "MRPV2_PNJ_Concessionnaire_Renault" in _objCurseur) exitWith {_infos = ["renault", "Concessionnaire Renault"];};
    if (toloweransi "MRPV2_PNJ_Concessionnaire_Luxe" in _objCurseur) exitWith {_infos = ["luxe", "Concessionnaire de Luxe"];};
    if (toloweransi "MRPV2_PNJ_Concessionnaire_citadines" in _objCurseur) exitWith {_infos = ["citadines", "Concessionnaire de citadines"];};
    if (toloweransi "MRPV2_PNJ_Concessionnaire_suv" in _objCurseur) exitWith {_infos = ["suv", "Concessionnaire de SUV"];};
	if (toloweransi "MRPV2_PNJ_Concessionnaire_Donnateur" in _objCurseur) exitWith {_infos = ["donor", "Concessionnaire VIP"];};
};

if (_infos isEqualTo []) exitWith {};
if (toloweransi "MRPV2_PNJ_Concessionnaire_Donnateur" in _objCurseur AND {!life_donOR}) exitwith 
{
    ["CONCESSIONNAIRE", "Vous devez être un donateur pour utiliser ces services.", "warning"] spawn ALF_fnc_doMsg;
};

private _texte = _infos # 1;
private _texte_tooltype = "";
private _action = compile format 
[
    "closeDialog 0;
    %1 call ALF_fnc_vehicleShopMenuV2;
    ",_infos
];

private _liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
_liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
_liste_Actions set ["", _liste_Sous_Actions];

private _texte = "Service de garage";
private _texte_tooltype = "Vous permet de ranger votre véhicule quand vous en achetez un nouveau";
private _action = 
{closeDialog 0;
    [] spawn 
    {
        private _veh_Proches = nearestObjects [player, ["Car"], 60];
        
        _veh_Proches = _veh_Proches select 
        {
            alive _x AND 
            {((_x getVariable ["vehicle_info_owners", ["", ""]]) # 1) isEqualTo (getPlayerUID player)}
        };

        _veh_Proches = _veh_Proches - [vehicle player];

        if ((count _veh_Proches) isEqualTo 0) exitWith {["CONCESSIONNAIRE", "Vous n'avez pas de véhicule à proximité.", "danger"] spawn ALF_fnc_doMsg;};

        private _vehicule = _veh_Proches # 0;
        private _plaque = getPlateNumber _vehicule;

        private _confirm_dep = 
        [
            format ["Voulez-vous ranger le véhicule '%1' ? Vous ne pourrez pas le re sortir ici.", _plaque],
            "CONCESSIONNAIRE", "Oui", "Non"
        ] call BIS_fnc_guiMessage;

        if (_confirm_dep) then {['Car', 'Civil'] call MRPV2_fnc_Vehicule_Garage_Ranger;};
    };
};

private _liste_Sous_Actions = _liste_Actions getOrDefault ["", []];
_liste_Sous_Actions pushback [_texte, _texte_tooltype, _action];
_liste_Actions set ["", _liste_Sous_Actions];

_liste_Actions
// };}] remoteExec ['call',0,true];