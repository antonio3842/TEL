// Nom du fichier : fn_setupKeyBinding_Objets.sqf
// Auteur : NorX Aengell
// Description : Configuration des touches liées aux interactions avec les objets
// Dépendances requises : ALF_fnc_menuNokia, ALF_fnc_menuiPhone, ALF_fnc_menuSony, mav_gps_fnc_initNavigation

["Martinique RP", "Telephone_ALF", ["Telephone", "Touche pour afficher le telephone."], 
{
    if(!dialog && {!([player] call ALF_fnc_checkMenotter)} && {!life_action_inUse} && {!([player] call ALF_fnc_checkSurrender)}) then 
    {
        private _radio = tolower (call TFAR_fnc_activeSwRadio);
        switch (true) do 
        {
            case (tolower "alf_3310" in _radio): 
            {
                if (currentWeapon player isEqualTo "") then 
                {
                    [] spawn ALF_fnc_menuNokia;
                } 
                else 
                {
                    ["Telephone", "Vous avez les mains encombrés.", "danger", false] spawn ALF_fnc_doMsg;
                };
            };
            case (tolower "alf_iphone" in _radio): 
            {
                if (currentWeapon player isEqualTo "") then 
                {
                    [] spawn ALF_fnc_menuiPhone;
                } 
                else 
                {
                    ["Telephone", "Vous avez les mains encombrés.", "danger", false] spawn ALF_fnc_doMsg;
                };
            };
            case (tolower "alf_neogend" in _radio): {[] spawn ALF_fnc_menuSony;};
            case (tolower "alf_sonypo" in _radio): {[] spawn ALF_fnc_menuSonyP;};
            case (tolower "alf_sonypm" in _radio): {[] spawn ALF_fnc_menuSonyPM;};
        };
    };
}, {}, [21, [true, false, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Afficher_GPS_ALF", ["Afficher le GPS", "Touche pour afficher le GPS."], 
{
    private _handled = false;
    if ((missionNamespace getVariable ["mav_gps_v_dialog_handlerBlockedUntil", 0]) > diag_tickTime) exitWith {true};
    missionNamespace setVariable ["mav_gps_v_dialog_handlerBlockedUntil", diag_tickTime];

    if (!dialog && {!_handled} && {"ALF_GPS" in ((items player) + (assignedItems player))}) then 
    {
        _handled = true;
        [] call mav_gps_fnc_initNavigation;
    };
    _handled
}, {}, [49, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Sifflet", ["Sifflet", "Siffler."], 
{
    if (time - life_action_delay < 2) exitWith {true};

    if (player isEqualTo (vehicle player) && {"ALF_sifflet" in (magazines player)}) then 
    {
        life_action_delay = time;
        [player,"ALF_Sifflet"] remoteExecCall ["ALF_fnc_say3D",0];
        player setFatigue ((getFatigue player) + 0.05);
    };
    _handled
}, {}, [55, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Casque_antibruit_ALF", ["Casque anti-bruit", "Touche pour activer/desactiver votre casque anti-bruit."], 
{
    [] call ALF_fnc_fadeSound;
    true
}, {}, [36, [true, false, false]]] call CBA_fnc_addKeybind;