/*
    MRP_HC1 - Headless Client 1
    Boucles systeme: cleanup, appleSystem, raisinSystem, spawnAlgues, sanctuaireTurtles
*/

class CfgPatches {
    class MRP_HC1 {
        name = "MRP Headless Client 1";
        author = "ALF Team";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {};
    };
};

class CfgName {
	name = "hc_1";
};

class CfgFunctions {
    #include "Functions.hpp"
};
