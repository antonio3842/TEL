/*
    MRP_HC2 - Headless Client 2
    Incendie & Events: feuForet, startEventFire, startEventOrgane, wreckEventStart, countService
*/

class CfgPatches {
    class MRP_HC2 {
        name = "MRP Headless Client 2";
        author = "ALF Team";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {};
    };
};

class CfgName {
	name = "hc_2";
};

class CfgFunctions {
    #include "Functions.hpp"
};
