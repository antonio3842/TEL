// /*
// 	File: fn_getDog.sqf
// 	Author: ALF TEAM
// */
// ALF_fnc_getDog = {
private _dog = player getVariable ["ALF_Dog", objNull];

if !(isNull _dog) then 
{
    if (alive _dog) exitWith {["INFO", "Vous avez déjà un chien.", "danger"] spawn ALF_fnc_doMsg;}; 
} else 
{
    player setVariable ["ALF_Dog", objNull];
};

_dog = createagent ["Alsatian_Sandblack_F", getPos cursorObject, [], 0, "CAN_COLLIDE"];
_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
_dog setAnimSpeedCoef 2;
_dog setBehaviour "CARELESS";
_dog setSkill 1;

player setVariable ["ALF_Dog",_dog];
removeAllActions player;

["GENDARMERIE", "Votre chien est sortis du chenil.", "info"] spawn ALF_fnc_doMsg;

player addAction 
    [
        "<t color = '#ffff00'>Suis lentement</t>", 
        ALF_fnc_dogFollowDoucement,
        [],
        1.5, 
        true, 
        true, 
        "",
        "isNull attachedTo (player getvariable [""ALF_Dog"",objNull]) && !((player getVariable [""ALF_dogAction"",""""]) isEqualTo ""followDoucement"")" 
    ];
player addAction 
    [
        "<t color = '#ffff00'>Suis vite</t>", 
        ALF_fnc_dogFollowVite,
        [],
        1.5, 
        true, 
        true, 
        "",
        "isNull attachedTo (player getvariable [""ALF_Dog"",objNull]) && !((player getVariable [""ALF_dogAction"",""""]) isEqualTo ""followVite"")" 
    ];
player addAction 
    [
        "<t color = '#ffff00'>Assis</t>", 
        ALF_fnc_dogSit,
        [],
        1.5, 
        true, 
        true, 
        "",
        "isNull attachedTo (player getvariable [""ALF_Dog"",objNull]) && !((player getVariable [""ALF_dogAction"",""SitDown""]) isEqualTo ""SitDown"")" 
    ];
player addAction 
    [
        "<t color = '#ffff00'>Arreter/Se lever</t>", 
        ALF_fnc_dogStop,
        [],
        1.5, 
        true, 
        true, 
        "",
        "isNull attachedTo (player getvariable [""ALF_Dog"",objNull]) && !((player getVariable [""ALF_dogAction"",""stop""]) isEqualTo ""stop"")" 
    ];
player addAction 
    [
        "<t color = '#ffff00'>Monter dans le véhicule</t>", 
        ALF_fnc_dogGetInVehicle,
        [],
        1.5, 
        true, 
        true, 
        "",
        "isNull attachedTo (player getvariable [""ALF_Dog"",objNull]) && ((typeOf cursorTarget) in [""V_ALF_Vito_Penit"",""V_ALF_Vito_Cyno"",""V_ALF_Vito_Gendarmerie_MRPV2"",""V_ALF_Vito_G_SR"",""V_ALF_Vito"",""V_ALF_RS6_MRPV2"",""V_ALF_CLA45_GND_MRPV2"",""VEH_Mercura_MRP_Citroen_Berlingo_Gn"",""VEH_Mercura_MRP_Skoda_Karoq_Gn""])"
    ];
player addAction 
    [
        "<t color = '#ffff00'>Descendre du véhicule</t>", 
        ALF_fnc_dogGetOutVehicle,
        [],
        1.5, 
        true, 
        true, 
        "",
        "!(isNull attachedTo (player getvariable [""ALF_Dog"",objNull]))" 
    ];
player addAction 
    [
        "<t color = '#ffff00'>Chercher de la drogue</t>", 
        ALF_fnc_dogChercherStup,
        [],
        1.5, 
        true, 
        true, 
        "",
        "isNull attachedTo (player getvariable [""ALF_Dog"",objNull]) && ((cursorObject isKindOf ""CAManBase"") || (cursorObject isKindOf ""Car""))" 
    ];
player addAction 
    [
        "<t color = '#ffff00'>Attaquer</t>", 
        ALF_fnc_dogAttack,
        cursortarget,
        1.5, 
        true, 
        true, 
        "",
        "isNull attachedTo (player getvariable [""ALF_Dog"",objNull]) && (!isNull cursortarget) && (cursorObject isKindOf ""CAManBase"") && life_penit_service" 
    ];
player addAction 
    [
        "<t color = '#ffff00'>Au pied</t>", 
        ALF_fnc_Chien_Au_Pied,
        cursortarget,
        1.5, 
        true, 
        true, 
        "",
        "isNull attachedTo (player getvariable [""ALF_Dog"",objNull]) && !((player getVariable [""ALF_dogAction"",""""]) isEqualTo ""followDoucement"")" 
    ];    
// };