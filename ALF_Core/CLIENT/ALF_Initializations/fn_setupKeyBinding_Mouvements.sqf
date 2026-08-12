// Nom du fichier : fn_setupKeyBinding_Mouvements.sqf
// Auteur : NorX Aengell
// Description : Configuration des touches liées aux mouvements et animations du personnage
// Dépendances requises : ALF_fnc_checkMenotter, ALF_fnc_checkSurrender

["Martinique RP", "Repos_ALF", ["Repos", "Touche pour se mettre au repos."], 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if (animationState player isEqualTo "Acts_JetsShooterIdle_stillpose_m") then 
    {
        player playActionNow "gestureNod";
    } 
    else 
    {
        player playActionNow "Acts_JetsShooterIdle_stillpose";
    };
    true
}, {}, [1, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Pompe_ALF", ["Pompe", "Touche pour faire des pompes."], 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if !(ALF_Animation) then 
    {
        [] spawn 
        {
            ALF_Animation = true;
            player playMoveNow "AmovPercMstpSnonWnonDnon_exercisePushup";
            waitUntil {!(animationState player isEqualTo "AmovPercMstpSnonWnonDnon_exercisePushup")};
            ALF_Animation = false;
        };
    };
    true
}, {}, [2, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Flexion_lente_ALF", ["Flexion lente", "Touche pour faire des flexions lentes."], 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if !(ALF_Animation) then 
    {
        [] spawn 
        {
            ALF_Animation = true;
            player playMoveNow "AmovPercMstpSnonWnonDnon_exercisekneeBendA";
            waitUntil {!(animationState player isEqualTo "AmovPercMstpSnonWnonDnon_exercisekneeBendA")};
            ALF_Animation = false;
        };
    };
    true
}, {}, [3, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Flexion_rapide_ALF", ["Flexion rapide", "Touche pour faire des flexions rapides."], 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if !(ALF_Animation) then 
    {
        [] spawn 
        {
            ALF_Animation = true;
            player playMoveNow "AmovPercMstpSnonWnonDnon_exercisekneeBendB";
            waitUntil {!(animationState player isEqualTo "AmovPercMstpSnonWnonDnon_exercisekneeBendB")};
            ALF_Animation = false;
        };
    };
    true
}, {}, [4, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Dab_ALF", ["Dab", "Touche pour faire un dab."], 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if !(ALF_Animation) then 
    {
        [] spawn 
        {
            ALF_Animation = true;
            player playActionNow "ALF_Dab";
        };
    };
    true
}, 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if (ALF_Animation) then 
    {
        [] spawn 
        {
            player playActionNow "gestureNod";
            [{player playActionNow "gestureNod";}] call CBA_fnc_execNextFrame;
            ALF_Animation = false;
        };
    };
    true
}, [5, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Fuck_ALF", ["Fuck", "Touche pour faire un doigt d'honneur."], 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if !(ALF_Animation) then 
    {
        [] spawn 
        {
            ALF_Animation = true;
            player playActionNow "ALF_Fuck";
        };
    };
    true
}, 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if (ALF_Animation) then 
    {
        [] spawn 
        {
            player playActionNow "gestureNod";
            [{player playActionNow "gestureNod";}] call CBA_fnc_execNextFrame;
            ALF_Animation = false;
        };
    };
    true
}, [6, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Bras_ALF", ["Bras Croisés", "Touche pour croiser ses bras."], 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if (ALF_Animation) then 
    {
        [] spawn 
        {
            player switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_8_out";
            ALF_Animation = false;
        };
    } 
    else 
    {
        [] spawn 
        {
            ALF_Animation = true;
            player switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_8";
        };
    };
    true
}, {}, [7, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Bras2_ALF", ["Bras sur le côté", "Touche pour mettre ses bras sur son bassin."], 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if (ALF_Animation) then 
    {
        [] spawn 
        {
            player switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_1_out";
            ALF_Animation = false;
        };
    } 
    else 
    {
        [] spawn 
        {
            ALF_Animation = true;
            player switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_1";
        };
    };
    true
}, {}, [8, [false, true, false]]] call CBA_fnc_addKeybind;

["Martinique RP", "Dance_ALF", ["Dance", "Touche pour danser."], 
{
    if !(isNull objectParent player) exitWith {};
    if (life_action_inUse || {life_istazed} || {ALF_ActivePrisePistolet} || {ALF_Phone_tryCall} || {ALF_Phone_inCall} || {[player] call ALF_fnc_checkMenotter} || {[player] call ALF_fnc_checkSurrender} || {animationState player isEqualTo "crew"} || {lifeState player isEqualTo "INCAPACITATED"} || {!alive player} || {player getVariable ["ReviveMedic",false]}) exitWith {};
    if (time - life_action_delay < 1.5) exitWith {true};
    life_action_delay = time;
    // OPTIMISÉ: switchMove direct (synchronisé automatiquement par Arma) au lieu de broadcast à tous les clients
    if !(ALF_Animation) then 
    {
        ALF_Animation = true;
        [player, selectRandom ["Acts_Dance_01","Acts_Dance_02"]] remoteExec ["switchMove", 0];
    } 
    else 
    {
        ALF_Animation = false;
        player switchMove "";
    };
    true
}, {}, [9, [false, true, false]]] call CBA_fnc_addKeybind;