/*
    MRP_HC2 - Functions declarations
*/
class MRP_HC2 {
    tag = "MRP_HC2";

    class Init {
        file = "\MRP_HC2\Functions";
        class initHC2 { postInit = 1; };
    };

    class Events {
        file = "\MRP_HC2\Functions\Events";
        class feuForet {};
        class startEventFire {};
        class startEventOrgane {};
        class wreckEventStart {};
        class countService {};
    };

    class Fire {
        file = "\MRP_HC2\Functions\Fire";
        class createFire {};
        class createFeuForet {};
        class ambientFire {};
        class expansionFire {};
        class replaceFeuForet {};
    };
};
