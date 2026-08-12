// ALF_fnc_radar = {
private _vehicle = cursorObject;


if ((_vehicle isKindOf "Car") OR {(currentWeapon player) isEqualTo "ALF_Rangefinder"}) then 
{
    private _plaque = getPlateNumber _vehicle;
    private _speed = round speed _vehicle;
    
    if (typeOf(_vehicle) isEqualTo "V_ALF_Kx") then {_plaque = "Inconnue"};
    
    if (_speed <= 55) then 
    {
        hint parseText format ["<t color='#ffffff'><t size='1.8'><t align='center'>Plaque : %1</t><br/><t color='#33CC33' align='center' size='1.5'>Vitesse : %2km/h</t>",_plaque,_speed];
    } else
    {
        hint parseText format ["<t color='#ffffff'><t size='1.8'><t align='center'>Plaque : %1</t><br/><t color='#FF0000'><t align='center'><t size='1.5'>Vitesse : %2km/h</t>",_plaque,_speed];          
    };
};
// };