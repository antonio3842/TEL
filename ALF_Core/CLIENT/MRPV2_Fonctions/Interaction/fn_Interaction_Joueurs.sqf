//MRPV2_fnc_Interaction_Joueurs = {
private _joueur = param [0,objnull];


life_pInact_curObject = _joueur;

private _liste_Actions = createhashmap;

licence_Target = [];
licence_rankTarget = [];
[0] remoteExecCall ["ALF_fnc_Parmes",_joueur];

[{licence_Target isNotEqualTo [] AND {licence_rankTarget isNotEqualTo []}},
{params ["_liste_Actions","_joueur"];
    _liste_Actions = [_liste_Actions] call MRPV2_fnc_Interaction_Joueurs_Civ;
    if (life_copLevel > 0) then {_liste_Actions = [_liste_Actions] call MRPV2_fnc_Interaction_Joueurs_GN;};
    if (life_penit > 0) then {_liste_Actions = [_liste_Actions] call MRPV2_fnc_Interaction_Joueurs_PM;};
    if (life_medicLevel > 0) then {_liste_Actions = [_liste_Actions] call MRPV2_fnc_Interaction_Joueurs_SP;};
    // Prefecture
    if (life_publique > 0 AND {b_13}) then {_liste_Actions = [_liste_Actions] call MRPV2_fnc_Interaction_Joueurs_Pref;};
    // Tribunal
    // if (life_publique > 0 AND {b_23}) then {_liste_Actions = [_liste_Actions] call MRPV2_fnc_Interaction_Trib;};

    _liste_Actions = [_liste_Actions] call MRPV2_fnc_Interaction_Joueurs_Ent;

    [_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;

    if ("Civil" in _liste_Actions) then {["Civil",0] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};
    if ("GN - Base" in _liste_Actions) then {["GN - Base"] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};
    if ("GN - Gestion grade" in _liste_Actions) then {["GN - Gestion grade"] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};
    if ("GN - Gestion spécialité" in _liste_Actions) then {["GN - Gestion spécialité"] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};
    if ("PM - Base" in _liste_Actions) then {["PM - Base"] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};
    if ("PM - Gestion grade" in _liste_Actions) then {["PM - Gestion grade"] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};
    if ("SP - Base" in _liste_Actions) then {["SP - Base"] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};
    if ("SP - Gestion grade" in _liste_Actions) then {["SP - Gestion grade"] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};

    // Prefecture
    if ("Pref - Gestion licences" in _liste_Actions) then {["Pref - Gestion licences"] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};

    // Tribunal
    // if ("Tribunal" in _liste_Actions) then {["Tribunal"] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};

    if ("Entreprise" in _liste_Actions) then {["Entreprise"] call MRPV2_fnc_Interaction_Menu_Btn_Menu_Creation;};
},[_liste_Actions,_joueur]] call CBA_fnc_waitUntilAndExecute;

//};