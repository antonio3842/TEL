// MRPV2_fnc_Vehicule_Achat = {
private _type_Achat = param [0, ""];
private _type_Veh = param [1, ""];


if((time - life_action_delay) < 0.5) exitWith {["INFO", "Vous appuyez trop vite.", "warning"] spawn ALF_fnc_doMsg;};
life_action_delay = time;

private _quitter = false;
private _className = lbData[2302,lbCurSel 2302];

private _licences = ["STRING", ["LifeCfgVehicles", _className, "licenses"]] call ALFTools_Client_Config_fnc_getConfig;
private _prix_Achat = ["NUMBER", ["LifeCfgVehicles", _className, "achat"]] call ALFTools_Client_Config_fnc_getConfig;
if (_prix_Achat <= 0) exitWith {["INFO", "Le prix du véhicule n'est pas bien configuré. Voyez avec le fournisseur.", "warning"] spawn ALF_fnc_doMsg; closeDialog 0;};

comment "b_33 réduction prix - 50% au lieu de 25%";
private _hasB33 = player getVariable ["b_33", false];
private _isB33Enterprise = false;
private _batimentB33 = objNull;

private _liste_Concessionnaires = nearestObjects [player, ["Land_MRP_Concessionnaire"], 30];
if (count _liste_Concessionnaires > 0) then {
    _batimentB33 = _liste_Concessionnaires # 0;
    if (!isNull _batimentB33) then {
        private _bizData = _batimentB33 getVariable ["business", []];
        if (count _bizData >= 5) then {
            private _secteur = _bizData # 4;
            if (typeName _secteur == "STRING") then {
                _secteur = parseNumber _secteur;
            };
            _isB33Enterprise = (_secteur == 33);
        };
    };
};

if (_hasB33 || _isB33Enterprise) then {
    _prix_Achat = _prix_Achat * 0.5;
};

if (_licences isNotEqualTo "") then 
{
    private _varnameConfig = ["STRING", ["Licenses", _licences, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
    private _licenceConfigVal = missionNamespace getVariable [format["license_%1",_varnameConfig], false];
    if !(_licenceConfigVal) then {_quitter = true;};
};
if (_quitter) exitWith {["INFO", "Vous n'avez pas le permis requis.", "warning"] spawn ALF_fnc_doMsg; closeDialog 0;};

private _isB33Local = _isB33Enterprise;
private _batimentB33Local = _batimentB33;

[_isB33Local, _batimentB33Local] call 
{
    params ["_isB33Local", "_batimentB33Local"];
    if(_type_Achat isEqualTo "Civil Achat") exitWith 
    {
        if (_isB33Local && !isNull _batimentB33Local) then {
            private _var = _batimentB33Local getVariable ["business",[]];
            if (count _var < 4) exitWith {
                ["INFO","Erreur: données entreprise invalides.","warning"] spawn ALF_fnc_doMsg;
                _quitter = true;
            };
            private _capitalstr = _var # 3;
            private _siretstr = _var # 2;
            private _vehnumber = if (count _var > 7) then {_var # 7} else {0};
            
            if (typeName _capitalstr == "STRING") then {
                _capitalstr = parseNumber _capitalstr;
            };
            
            if(_capitalstr < _prix_Achat) then {
                ["INFO","Il n'y a pas assez dans le capital de l'entreprise.","warning"] spawn ALF_fnc_doMsg;
                _quitter = true;
            } else {
                private _action = ["Etes-vous certain de vouloir acheter ce vehicule pour votre entreprise ?","Entreprise","OUI","NON"] call BIS_fnc_guiMessage;
                if (!_action) exitWith {
                    ["INFO","Annulation..","warning"] spawn ALF_fnc_doMsg; 
                    _quitter = true;
                };
                
                _capitalstr = _capitalstr - _prix_Achat;
                _var set[3,_capitalstr];
                _vehnumber = _vehnumber + 1;
                if (count _var > 7) then {
                    _var set[7,_vehnumber];
                } else {
                    _var pushBack _vehnumber;
                };
                _batimentB33Local setVariable ["business",_var,true];                

                [_siretstr,_capitalstr] remoteExec ["ALF_Server_fnc_capitalBusiness",2];
                
                [name player,getPlayerUID player,"ENTREPRISE",format["A acheté %1 pour %2€ (capital entreprise).",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_prix_Achat] call ALF_fnc_numberText]] remoteExec ["ALF_Server_fnc_logIt",2];
            };
        } else {
            if(_prix_Achat > life_cash) then 
            {
                private _handle = [_prix_Achat,false] call ALF_fnc_handleCB;

                if(_handle) exitWith {closeDialog 0; _quitter = true;};
                [name player,getPlayerUID player,"VEHICULE",format["A acheté %1 pour %2€ par carte.",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_prix_Achat] call ALF_fnc_numberText]] remoteExec ["ALF_Server_fnc_logIt",2];
            } else 
            {
                life_cash = life_cash - _prix_Achat;
                [0] call SOCK_fnc_updatePartial;
                [name player,getPlayerUID player,"VEHICULE",format["A acheté %1 pour %2€ en espèce | Espèce apres achat : %3€.",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_prix_Achat] call ALF_fnc_numberText, life_cash]] remoteExec ["ALF_Server_fnc_logIt",2];
            };
        };
    };
    if(_type_Achat isEqualTo "GN Achat") exitWith 
    {
        private _value = missionNamespace getVariable ["CNG",0];
        if(_value < _prix_Achat) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg; _quitter = true;};

        _value = _value - _prix_Achat;
        missionNamespace setVariable ["CNG",_value,true];
        [getPlayerUID player,name player,_prix_Achat] remoteExec ["ALF_Server_fnc_retirerCNG",2];
    };
    if(_type_Achat isEqualTo "AP Achat") exitWith 
    {
        private _value = missionNamespace getVariable ["CNPM",0];
        if(_value < _prix_Achat) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg; _quitter = true;};

        _value = _value - _prix_Achat;
        missionNamespace setVariable ["CNPM",_value,true];
        [getPlayerUID player,name player,_prix_Achat] remoteExec ["ALF_Server_fnc_retirerCNPM",2];
    };
    if(_type_Achat isEqualTo "SP Achat") then 
    {
        private _value = missionNamespace getVariable ["CNP",0];
        if(_value < _prix_Achat) exitWith {["INFO","Il n'y a pas assez dans les caisses.","warning"] spawn ALF_fnc_doMsg; _quitter = true;};

        _value = _value - _prix_Achat;
        missionNamespace setVariable ["CNP",_value,true];
        [getPlayerUID player,name player,_prix_Achat] remoteExec ["ALF_Server_fnc_retirerCNP",2];
    };
};
if(_quitter) exitWith {};

[_className,player,_type_Achat,_prix_Achat,_type_Veh,_isB33Enterprise] remoteExec ["MRPV2_Server_fnc_Vehicule_Gestion_Dispo_Et_Ajout_BDD",2];
closeDialog 0;
// };

/* table compte pm 
CREATE TABLE IF NOT EXISTS `cnpm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Listage des données de la table armalife.cng : ~1 rows (environ)
INSERT INTO `cnpm` (`id`, `bank`) VALUES
    (1, '100000');

CREATE TABLE IF NOT EXISTS `cnpm_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `name` text NOT NULL,
  `value` varchar(64) NOT NULL,
  `time` int(11) NOT NULL DEFAULT 15,
  `insert_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10357 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
*/
