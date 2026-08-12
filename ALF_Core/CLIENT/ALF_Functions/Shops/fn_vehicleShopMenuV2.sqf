// ALF_fnc_vehicleShopMenuv2 = {
private _nom_Boutique = param[0,""];
private _titre_Boutique = param[1,""];


disableSerialization;

if (_nom_Boutique isEqualTo "") exitWith {};
if (_nom_Boutique in ["cop","cop_heli","cop_mari"] && {life_coplevel < 2}) exitWith {["INFO","Vous n'avez pas accès à ceci.","warning"] spawn ALF_fnc_doMsg;};
if (_nom_Boutique in ["pompier","pompier_heli","pompier_mari"] && {life_mediclevel < 2}) exitWith {["INFO","Vous n'avez pas accès à ceci.","warning"] spawn ALF_fnc_doMsg;};
if (_nom_Boutique in ["prisonpro","policemunicipale"] && {life_penit < 1}) exitWith {["INFO","Vous n'avez pas accès à ceci.","warning"] spawn ALF_fnc_doMsg;};
if (!createDialog "Life_Vehicle_Shop_v2") exitWith {};

life_veh_shop = [_nom_Boutique,""];
ctrlSetText [2301,_titre_Boutique];
ctrlEnable [2309,false];

private _display = findDisplay 2300;
private _bouton_Achat = _display displayCtrl 2309;
// ['_nom_Boutique ' + str(_nom_Boutique)] remoteExec ['systemchat',0]; // PERF FIX: Debug désactivé
[] call 
{
    if (_nom_Boutique in ["cop"]) exitwith {_bouton_Achat buttonSetAction "['GN Achat','Car'] spawn MRPV2_fnc_Vehicule_Achat;";};
    if (_nom_Boutique in ["cop_heli"]) exitwith {_bouton_Achat buttonSetAction "['GN Achat','Air'] spawn MRPV2_fnc_Vehicule_Achat;";};
    if (_nom_Boutique in ["cop_mari"]) exitwith {_bouton_Achat buttonSetAction "['GN Achat','Ship'] spawn MRPV2_fnc_Vehicule_Achat;";};

    if (_nom_Boutique in ["pompier","shipp"]) exitwith {_bouton_Achat buttonSetAction "['SP Achat','Car'] spawn MRPV2_fnc_Vehicule_Achat;";};
    if (_nom_Boutique in ["pompier_heli"]) exitwith {_bouton_Achat buttonSetAction "['SP Achat','Air'] spawn MRPV2_fnc_Vehicule_Achat;";};
    if (_nom_Boutique in ["prisonpro","policemunicipale"]) exitwith {_bouton_Achat buttonSetAction "['AP Achat','Car'] spawn MRPV2_fnc_Vehicule_Achat;";};
    if (_nom_Boutique in ["ship"]) exitwith {_bouton_Achat buttonSetAction "['Civil Achat','Ship'] spawn MRPV2_fnc_Vehicule_Achat;";};
    if (_nom_Boutique in ["wiki_tropic"]) exitwith {_bouton_Achat buttonSetAction "['Civil Achat','Ship'] spawn MRPV2_fnc_Vehicule_Achat;";};
	if (_nom_Boutique in ["marine_et_riviere"]) exitwith {_bouton_Achat buttonSetAction "['Civil Achat','Ship'] spawn MRPV2_fnc_Vehicule_Achat;";};
    if (_nom_Boutique in ["Aerien","civ_heli"]) exitwith {_bouton_Achat buttonSetAction "['Civil Achat','Air'] spawn MRPV2_fnc_Vehicule_Achat;";};
    
    if (_nom_Boutique in ["mmprestigebuy","mmprestigeclasseAP","mmprestigeclasseA","mmprestigeclasseB","mmprestigeclasseC","mmprestigeVE","mmprestigeAncienne"]) exitwith 
    {
        if(!(b_33 && ((getPlayerUID player) in ["76561198170517007","7656119841106","7656115115161"]))) then 
        {
            _bouton_Achat ctrlShow false;
        } 
        else 
        {
            _bouton_Achat buttonSetAction "[] spawn ALF_fnc_vehicleShopBuy;";
        };
    };
    // Shops b_13 et b_23 utilisent le système d'entreprise de base
    if (_nom_Boutique in ["b_13","b_23"]) exitwith {
        _bouton_Achat buttonSetAction "[] spawn ALF_fnc_BusinessCarShopBuy;";
    };
    _bouton_Achat buttonSetAction "['Civil Achat','Car'] spawn MRPV2_fnc_Vehicule_Achat;";
};

private _liste_Vehicules = ["ARRAY",["CarShops",_nom_Boutique,"vehicles"]] call ALFTools_Client_Config_fnc_getConfig;
private _controle = ((findDisplay 2300) displayCtrl 2302);
lbClear _controle;

{
    private _nom_Classe = (_x select 0);
    private _niveau_Assertion = (_x select 1);
    private _nom_Niveau = (_niveau_Assertion select 0);
    private _type_Niveau = (_niveau_Assertion select 1);
    private _valeur_Niveau = (_niveau_Assertion select 2);
    private _valeur_Licence = (_x select 2);
    private _tout_Afficher = true;

    if(_valeur_Licence isEqualTo "") then 
    {
        if(!(_valeur_Niveau isEqualTo -1)) then 
        {
            private _niveau = missionNamespace getVariable _nom_Niveau;
            if(_niveau isEqualType {}) then 
            {
                _niveau = call _niveau;
            };
            
            _tout_Afficher = switch(_type_Niveau) do 
            {
                case "SCALAR": { _niveau >= _valeur_Niveau };
                case "BOOL": { _niveau };
                case "EQUAL": { _niveau isEqualTo _valeur_Niveau };
                default { false };
            };
        };
    } 
    else 
    {
        private _config_Nom_Variable = ["STRING",["Licenses",_valeur_Licence,"variable"]] call ALFTools_Client_Config_fnc_getConfig;
        private _niveau = missionNamespace getVariable [format["license_%1",_config_Nom_Variable],false];
        if!(_niveau) then {_tout_Afficher = false;};
    };

    if(_tout_Afficher) then 
    {
        private _info_Vehicule = [_nom_Classe] call ALF_fnc_fetchVehInfo;

        if (isNil "_info_Vehicule" || {count _info_Vehicule < 4}) then 
        {
            diag_log format ["Erreur: _info_Vehicule est invalide pour %1", _nom_Classe];
        } 
        else 
        {
            private _index = _controle lbAdd (_info_Vehicule # 3);

            if (!isNil { _info_Vehicule # 2 } && { _info_Vehicule # 2 != "" }) then
            {
                _controle lbSetPicture [_index, (_info_Vehicule # 2)];
            }
            else 
            {
                diag_log format ["Erreur: Image non trouvée pour %1", _nom_Classe];
            };

            _controle lbSetData [_index, _nom_Classe];
            _controle lbSetValue [_index, _forEachIndex];
        };
    };
} forEach _liste_Vehicules;
lbSort _controle;
[] call ALF_fnc_vehicleShopInit3DPreview;
((findDisplay 2300) displayCtrl 2302) lbSetCurSel 0;
// };
