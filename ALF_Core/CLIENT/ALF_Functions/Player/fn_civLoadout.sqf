player setUnitLoadout (configFile >> "EmptyLoadout");

if !(ALF_Prison) then 
{
    if (!isnil {License_Femme} AND {License_Femme}) then 
    {
        player forceaddUniform (selectRandom ["ALF_CHAW3_D6","EF_FEM_3_9_2K","EF_FEM_4_2SG2","EF_FEM_4_72ADR","EF_FEM_3_3OD"]);
    } else 
    {
        player forceaddUniform (selectRandom ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Commoner1_1"]);
    };    
    
    if !(life_playerfirstjoinserver) then 
	{
        if(life_copLevel > 0 OR {life_medicLevel > 0}) then 
        {
            if (life_copLevel > 0) then {
                player addItem "alf_neogend";
                player assignItem "alf_neogend";
            } else {
                player addItem "alf_SonyPo";
                player assignItem "alf_SonyPo";
            };
        } else 
        {
            player addItem "ALF_3310";
            player assignItem "ALF_3310";
        };
    };
    
    if(life_laactive OR {life_lbactive OR {life_lcactive}}) then 
    {
        if(life_lcactive) exitWith {player addMagazine "ALF_CB_Black"};
        if(life_lbactive) exitWith {player addMagazine "ALF_CB_Gold"};
        if(life_laactive) exitWith {player addMagazine "ALF_CB_Bronze"};
    };
    
    player addMagazine "ALF_identite";
    if (license_driver) then {player addMagazine "ALF_Permis";};

    player addItem "ItemGPS";
    player assignItem "ItemGPS";
    player addItem "ItemMap";
    player assignItem "ItemMap";
    player addItem "ItemCompass";
    player assignItem "ItemCompass";
    player addItem "ItemWatch";
    player assignItem "ItemWatch";
};

[2] call SOCK_fnc_updatePartial;
