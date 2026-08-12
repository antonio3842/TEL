// ALF_Server_fnc_peintureVehicule = {
params 
[ 
    ["_veh", objNull, [objNull]], 
    ["_texture", "", [""]], 
    ["_material", "", [""]] 
]; 

if (isNull _veh OR {_texture isEqualTo "" OR {_material isEqualTo ""}}) exitWith {}; 
 
private _classname = toLower (typeOf _veh); 
private _textureIndex = if ("_mrp_" in tolower (typeof _veh)) then {11} else {0};
 
private _plaque = getPlateNumber _veh;

_texture = (_texture splitString "\") joinString "\\"; 
_material = (_material splitString "\") joinString "\\"; 

private _peinture = [_texture, _material];
private _requete = format ["UPDATE vehicles SET peinture='%1' WHERE plate='%2'",_peinture, _plaque];   
[_requete, 1] call ALF_Server_fnc_asyncCall; 
 
_veh setObjectTextureGlobal [_textureIndex, _texture]; 
_veh setObjectMaterialGlobal [_textureIndex, _material];
// };