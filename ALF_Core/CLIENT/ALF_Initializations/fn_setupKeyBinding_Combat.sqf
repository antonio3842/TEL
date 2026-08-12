// Nom du fichier : fn_setupKeyBinding_Combat.sqf
// Auteur : NorX Aengell
// Description : Configuration des touches liées au combat et aux interactions hostiles
// Dépendances requises : ALF_fnc_radar, ALF_fnc_knockoutAction, ALF_fnc_restrainAction, ALF_fnc_combat, ALF_fnc_surrender, ALF_fnc_checkMenotter

["Martinique RP", "Main_tete_ALF", ["Main sur la tête", "Touche pour mettre/enlever vos mains sur la tête."], 
{
    if([player] call ALF_fnc_checkSurrender) then 
    {
        player playActionNow "gestureNod";
        _array = player getVariable ["ALF_MenotterSurrender",[false,false]];
        _array set [1,false];
        player setVariable ["ALF_MenotterSurrender",_array,true];
        [] spawn 
        {
            sleep 2;
            player forceWalk false;
        };
    } 
    else 
    {
        [] spawn ALF_fnc_surrender;
    };
    true
}, {}, [48, [true, false, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Menotter_ALF", ["Menotter", "Touche pour menotter une personne."], 
{
    private _handle = false;
    if (!isNull cursorObject && {cursorObject isKindOf "Man"} && {(isPlayer cursorObject)} && {alive cursorObject} && {cursorObject distance player < 2} && {!([cursorObject] call ALF_fnc_checkMenotter)} && {speed cursorObject < 1}) then 
    {
        _handle = true;
        if("ALF_Menottes" in (magazines player)) then 
        {
            [] call ALF_fnc_restrainAction;
        } 
        else 
        {
            if("ALF_ZipTies" in (magazines player)) then 
            {
                [] call ALF_fnc_restrain2Action;
            } 
            else 
            {
                ["INFO", "Vous n'avez pas de menottes.", "warning"] spawn ALF_fnc_doMsg;
            };
        };
    };
    _handle
}, {}, [19, [true, false, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Assommer_ALF", ["Assommer", "Touche pour assommer une personne."], 
{
    private _handle = false;
    if (!isNull cursorObject && {cursorObject isKindOf "Man"} && {isPlayer cursorObject} && {alive cursorObject} && {cursorObject distance player < 4} && {speed cursorObject < 1}) then 
    {
        if((animationState cursorObject) != "Incapacitated" && {(currentWeapon player isEqualTo primaryWeapon player OR currentWeapon player isEqualTo handgunWeapon player)} && {currentWeapon player != ""} && {!life_knockout} && {!([player] call ALF_fnc_checkMenotter)} && {!life_istazed} && {!life_isknocked}) then 
        {
            [cursorObject] spawn ALF_fnc_knockoutAction;
            _handle = true;
        };
    };
    _handle
}, {}, [34, [true, false, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "CoupPoing", ["Coup de poing", "Mettre un coup de poing."], 
{
    if (time - life_action_delay < 1.5) exitWith {true};
    life_action_delay = time;

    if (!dialog && (player isEqualTo (vehicle player))) then {[cursorTarget] spawn ALF_fnc_combat;};
    _handled
}, {}, [54, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Radar_ALF", ["Radar", "Touche pour afficher le radar."], 
{
    if((currentWeapon player) isEqualTo "ALF_Rangefinder") then {[] call ALF_fnc_radar;};
}, {}, [38, [false, false, false]]] call CBA_fnc_addKeybind;