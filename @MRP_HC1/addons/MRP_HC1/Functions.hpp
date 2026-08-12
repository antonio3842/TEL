/*
    MRP_HC1 - Functions declarations
*/

class MRP_HC1 {
    tag = "MRP_HC1";

    class Init {
        file = "\MRP_HC1\Functions";
        class initHC1 { postInit = 1; };
    };

    class Boucles {
        file = "\MRP_HC1\Functions\Boucles";
        class cleanup {};
        class appleSystem {};
        class raisinSystem {};
        class spawnAlgues {};
        class sanctuaireTurtles {};
        class objetsCarteEnObjetSimple {};
        class objetsTxtEnObjetSimple {};
    };

    // Note: DAB deplace sur HC3
};
