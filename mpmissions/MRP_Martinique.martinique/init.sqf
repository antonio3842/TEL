/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
StartProgress = false;
StartProgress = true;
TFAR_giveMicroDagrToSoldier = false;

// Accélération du temps la nuit (server-only)
if (isServer) then {
    [] spawn {
        while {true} do {
            private _hour = dayTime;
            if ((_hour >= 20) OR (_hour < 5)) then {
                setTimeMultiplier 15;
            } else {
                setTimeMultiplier 5;
            };
            sleep 1800;
        };
    };
};