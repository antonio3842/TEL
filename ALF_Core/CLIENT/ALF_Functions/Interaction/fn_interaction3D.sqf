// /*
//     File: fn_interaction3D.sqf
//     Author: ALF - NiiRoZz, modifié pour fonctionner par le framework plutôt qu'un mod par NorX Aengell
// */

private _liste_Interactions_3D = [] call ALF_fnc_interaction3D_Liste_Actions;

ALF_fnc_interaction3DEachFrame = 
{
    private _liste_Interactions_3D = param [0,createHashMap];

    ALF_3DInteraction_Selected = -1;
    ALF_3DInteractionScript_Selected = "";
    ALF_3DInteraction_CursorObject = objNull;

    private _obj = objNull;
    (lineIntersectsSurfaces [
        AGLToASL positionCameraToWorld [0,0,0],
        AGLToASL positionCameraToWorld [0,0,5],
        player,
        objNull,
        true,
        1,
        "VIEW",
        "GEOM"
    ] # 0) params ["","","",["_obj",objNull,[objNull]]];

    // Cas spécifique table poker (véhicule) : si le raycast touche un joueur assis,
    // on bascule la cible sur la table pour garder les interactions 3D poker.
    // Fallback poker: en cargo, le raycast peut renvoyer objNull selon l'angle camera.
    if (isNull _obj) then {
        private _vehSelf = objectParent player;
        if (!isNull _vehSelf && {((toLowerANSI (typeOf _vehSelf)) find "alf_poker") > -1}) then {
            _obj = _vehSelf;
        };
    };

    if (!isNull _obj && {_obj isKindOf "CAManBase"}) then {
        private _veh = objectParent _obj;
        if (!isNull _veh && {((toLowerANSI (typeOf _veh)) find "alf_poker") > -1}) then {
            _obj = _veh;
        };
    };

    if !(isNull _obj) then 
    {
        {
            private _clef = _x;
            if (_obj isKindOf _clef OR {_clef in (str _obj)} OR {(_clef isEqualTo "alf_poker") && {((toLowerANSI (typeOf _obj)) find "alf_poker") > -1}}) then 
            {
                {
                    private _liste_Actions = _x;
                    private _pos = [];
                    private _posModel = _liste_Actions # 0;
                    private _exit = false;

                    if (_posModel isEqualType []) then 
                    {
                        _pos = _obj modelToWorldVisual _posModel;
                    } else 
                    {                        
                        if ((_obj selectionPosition _posModel) isEqualTo [0,0,0]) exitWith {_exit = true;};
                        _pos = _obj modelToWorldVisual (_obj selectionPosition _posModel);                        
                    };

                    private _w2s = worldToScreen _pos;
                    if (!_exit AND {count _w2s >= 2 AND {(player distance _pos) <= (_liste_Actions # 3) AND {[_obj] call compile (_liste_Actions # 4)}}}) then 
                    {                        
                        private _selected = ((_w2s distance (worldToScreen (positionCameraToWorld [0,0,1]))) < 0.2);
                        if (_selected AND {(_forEachIndex isNotEqualTo ALF_3DInteraction_Selected)}) then 
                        {
                            ALF_3DInteraction_Selected = _forEachIndex;
                            ALF_3DInteractionScript_Selected = _liste_Actions # 5;
                            ALF_3DInteraction_CursorObject = _obj;
                        } else 
                        {
                            if (!_selected AND {_forEachIndex isEqualTo ALF_3DInteraction_Selected}) then 
                            {
                                ALF_3DInteraction_Selected = -1;
                                ALF_3DInteractionScript_Selected = '';
                                ALF_3DInteraction_CursorObject = objNull;
                            };
                        };

                        drawIcon3D [(_liste_Actions # 2), [1,1,1,1], _pos, 0.75, 0.75, 0, (_liste_Actions # 1), 2, 0.035, "PuristaMedium", "center", false];
                        if (_selected AND {_forEachIndex isEqualTo ALF_3DInteraction_Selected}) then 
                        {
                            drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectOver_ca.paa", [1,1,1,1], _pos, 1.25, 1.25, 0, "", 2, 0];
                        };
                    };
                } forEach (_liste_Interactions_3D getOrDefault [_clef,[]]);
            };
        } forEach (keys _liste_Interactions_3D);
    };

    sleep 0.01;
};

addMissionEventHandler ["EachFrame", {[_thisArgs # 0] spawn ALF_fnc_interaction3DEachFrame;},[_liste_Interactions_3D]];
