// ALF_fnc_placeMobilier = {
params 
[
    ["_mobilier",objNull,[objNull]],
    ["_isFloating",true,[true]]
];

if(isNull _mobilier) exitWith {hint "#PLMO EXIT1";};

private _uid = getPlayerUID player;
private _house = life_mobilier_activeHouse;
private _message = 0;
private _isPlaced = false;

if !(isNull _house) then 
{
    _message = 1;
    private _hauteur_Neg = - (getPosworld _mobilier # 2);
    private _hauteur_Pos = (0 boundingBoxReal _mobilier) # 1 # 2;

    private _liste_Obj_Detecter = lineIntersectsSurfaces [(getPosworld _mobilier) vectorAdd [0,0,_hauteur_Pos + 0.3],(getPosworld _mobilier) vectorAdd [0,0,_hauteur_Neg - 5],_mobilier,_mobilier,true,20,"GEOM","NONE"];

    {
        private _obj_detecter = _x # 2;

        if(!isnil {_obj_detecter} AND {_obj_detecter isequalto _house}) exitWith
        {
            _isPlaced = true;
            [_uid,_mobilier,_house,life_mobilier_activeName,life_mobilier_activePos,life_mobilier_activeDir,life_mobilier_activeMun] remoteExec ["ALF_Server_fnc_addMobilier",2];
        };
    } foreach _liste_Obj_Detecter;

    // Vérification de secours pour les appartements (rayon vers le haut pour toucher le plafond)
    if (!_isPlaced) then {
        private _posW = getPosWorld _mobilier;
        private _rayUp = lineIntersectsSurfaces [_posW vectorAdd [0,0,0.1], _posW vectorAdd [0,0,5], _mobilier, _mobilier, true, 3, "GEOM", "NONE"];
        {
            private _obj_detecter = _x # 2;
            if (!isNil {_obj_detecter} AND {_obj_detecter isEqualTo _house}) exitWith {
                _isPlaced = true;
                [_uid,_mobilier,_house,life_mobilier_activeName,life_mobilier_activePos,life_mobilier_activeDir,life_mobilier_activeMun] remoteExec ["ALF_Server_fnc_addMobilier",2];
            };
        } forEach _rayUp;
    };
};
if(_isPlaced) exitWith {life_mobilier_activeMun = ""; life_mobilier_activeHouse = objNull; titleText ["","PLAIN"];};

[life_mobilier_activeMun,true] spawn ALF_fnc_handleItem;
life_mobilier_activeMun = "";
life_mobilier_activeHouse = objNull;

deleteVehicle _mobilier;

if (_message isEqualTo 0) exitWith {hint "Vous n'êtes pas dans une maison. #PLMO1"; [] spawn {sleep 5: hint "";};};
if (_message isEqualTo 1) exitWith {hint "Vous n'êtes pas dans une maison. #PLMO2"; [] spawn {sleep 5: hint "";};};
// };