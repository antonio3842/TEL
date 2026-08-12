/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
#define true 1
#define false 0

class Life_Settings {

    ALF_ConfigToClient_Patern[] = {
        {"fuel_cost", "NUMBER"},
        {"house_limit", "NUMBER"},
        {"house_limit_donor", "NUMBER"},
        {"animaltypes_fish", "ARRAY"},
        {"animaltypes_hunting", "ARRAY"}
    };

    fuel_cost = 0.38;
    house_limit = 4;
    house_limit_donor = 6;
    animaltypes_fish[] = { "Salema_F", "Ornate_random_F", "Mackerel_F", "Tuna_F", "Mullet_F", "CatShark_F", "Turtle_F" };
    animaltypes_hunting[] = { "Sheep_random_F", "Goat_random_F", "Hen_random_F", "Cock_random_F", "Rabbit_F" };
};

#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Clothing.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Garages.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Licenses.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Vehicles.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Shops.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Mobiliers.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Sellers.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Deseases.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Missions.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Object.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Jobs.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_MetaData.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_SmartMarker.hpp"
//#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Dynamic_Markers.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Interactions.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Incendie.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Inventory.hpp"
#include "\ALF_Core\SERVER\ALF_Client_Config\Config_Traitements.hpp"