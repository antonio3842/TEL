// [] spawn {
// Conf des service
MRP_Liste_Numeros_Services = createHashMapFromArray
[
	["Gendarmerie",["17","GN"]],
	["Pompier",["18","SP"]],
	["policemunicipale",["21","AP"]]
];

private _new = profileNamespace getVariable ["MRP_Telephone_Configuration_newV3",true];
if (_new) then {
	profileNamespace setVariable ["MRP_Telephone_Liste_Note",createHashMap];
	profileNamespace setVariable ["MRP_Telephone_Liste_SMS",createHashMap];
	profileNamespace setVariable ["MRP_Telephone_Liste_Contact",createHashMap];
	profileNamespace setVariable ["MRP_Telephone_Configuration",[]];
};
profileNamespace setVariable ["MRP_Telephone_Configuration_newV3",false];

[] call MRPV2_fnc_MRP_Tel_Init_Joueur_Conf;
// [] call MRPV2_fnc_MRP_Tel_Init_Joueur_Histo;

//if true exitwith {};

// NE JAMAIS ENLEVER AU CAS OU DES GENS ON DES BLEMES PROFIL
private _Telephone_Liste_Note_Vide = profileNamespace getVariable ["MRP_Telephone_Liste_Note",createHashMap] isequalto createHashMap;
if (_Telephone_Liste_Note_Vide) then {profileNamespace setVariable ["MRP_Telephone_Liste_Note",createHashMap];};

private _liste_Historique = profileNamespace getvariable ["MRP_Telephone_Liste_Historique",[]];

// _Telephone_Liste_Historique_Vide = profileNamespace getVariable ["MRP_Telephone_Liste_Historique",[]] isequalto [];
// if (_Telephone_Liste_Historique_Vide) then {profileNamespace setVariable ["MRP_Telephone_Liste_Historique",[]];};

private _Telephone_Liste_SMS_Vide = profileNamespace getVariable ["MRP_Telephone_Liste_SMS",createHashMap] isequalto createHashMap;
if (_Telephone_Liste_SMS_Vide) then {profileNamespace setVariable ["MRP_Telephone_Liste_SMS",createHashMap];};

private _Telephone_Liste_Contact_Vide = profileNamespace getVariable ["MRP_Telephone_Liste_Contact",createHashMap] isequalto createHashMap;
if (_Telephone_Liste_Contact_Vide) then {profileNamespace setVariable ["MRP_Telephone_Liste_Contact",createHashMap];};

[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Gestion_Nombre_SMS;
[] call MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel;

[] spawn
{
    private _liste_Canaux = [0,1,2,3,4,5,6,7,8,9,12];

    while {alive player} do
    {
        if !(isNil {call TFAR_fnc_activeSwRadio}) then
        {
            private _radio = call TFAR_fnc_activeSwRadio;

            {
                private _canal = _x;
                private _frequence_Actuelle = [_radio,_canal] call TFAR_fnc_getChannelFrequency;

                if (_frequence_Actuelle in ["","any"]) then
                {
					private _entier = 30 + floor (random 482); // 30 à 511
					private _dixieme = floor (random 10); // 0 à 9

					_freSur = format ["%1.%2",_entier,_dixieme];

                    [_radio,_canal,_freSur] call TFAR_fnc_SetChannelFrequency;
                };
            } foreach _liste_Canaux;
        };

        sleep 3;
    };
};


[{
	!isnil {call TFAR_fnc_activeSwRadio}
},
{
	[] call MRPV2_fnc_MRP_Tel_Divers_Desac_Raccourcis_TFAR;

	//desactivation des autres fréquence radio courte portée
	for "_i" from 0 to 9 do
	{
		[(call TFAR_fnc_ActiveSwRadio),_i,""] call TFAR_fnc_SetChannelFrequency;
	};

	// Tentative fixe radio fantome, a l'init du joueur on release tout type de comm radio
	player call TFAR_fnc_releaseAllTangents;
},[],120,{}] call CBA_fnc_waitUntilAndExecute;

TRUE
// };