// Retire l’ancien holdAction (si relance)
if (!isNil "alf_turtle_hold_on_player") then {
    [player, alf_turtle_hold_on_player] call BIS_fnc_holdActionRemove;
};

private _icon = "\A3\ui_f\data\IGUI\Cfg\holdactions\holdAction_take_ca.paa";

// Affichage seulement si une Turtle_F MORTE est à <= 3 m
private _show = "count ((nearestObjects [player, ['Turtle_F'], 3]) select { !alive _x || {lifeState _x == 'DEAD'} }) > 0";

alf_turtle_hold_on_player = [
    player,
    "Ramasser la tortue (morte)",
    _icon,
    _icon,
    _show,                     // condition d'affichage (string)
    _show,                     // condition de progression (string)
    {}, {},                   // onStart, onProgress
    {
        params ["_target","_caller","_actionId","_args"];

        // Trouve une tortue morte à portée
        private _deadTurtle = ((nearestObjects [_caller, ['Turtle_F'], 3]) select { !alive _x || {lifeState _x == 'DEAD'} }) param [0, objNull];

        if (!isNull _deadTurtle) then {

            // >>> NE PAS supprimer côté client <<<
            // deleteVehicle _deadTurtle;   // (supprimé)

            // Donne les items de loot au joueur (si ta fonction existe)
            if (!isNull _caller) then {
                _caller addMagazine "Viande_Tortue";
                _caller addMagazine "Carapace_Tortue";
            };

            // Marque le cadavre comme "looté" (info & anti doublon) et notifie le serveur
            _deadTurtle setVariable ["alf_looted", true, true];
            [_deadTurtle] remoteExecCall ["ALF_fnc_respawnTurtle_server", 2];

            ["Info","Tortue morte dépecée.","success"] spawn ALF_fnc_doMsg;
        } else {
            ["Info","Aucune tortue morte à portée.","warning"] spawn ALF_fnc_doMsg;
        };
            },
    { ["Info","Action interrompue.","warning"] spawn ALF_fnc_doMsg; },
    [],
    6,   // durée à maintenir (s)
    0,
    false,
    false
] call BIS_fnc_holdActionAdd;
