/*
    MRP_HC3 - Functions declarations
*/

class MRP_HC3 {
    tag = "MRP_HC3";

    class Init {
        file = "\MRP_HC3\Functions";
        class initHC3 { postInit = 1; };
    };

    class Bourse {
        file = "\MRP_HC3\Functions\Bourse";
        class randomEvent {};
    };

    class BDD {
        file = "\MRP_HC3\Functions\BDD";
        class countDownForfait {};
        class countDownBracelet {};
        class countDownPrison {};
        class initReboot {};
    };

    class DAB {
        file = "\MRP_HC3\Functions\DAB";
        class initDAB {};
        class updateDABDispo {};
        class checkDABDispo {};
        class retraitDAB {};
        class bag_vehicle {};
    };
};
