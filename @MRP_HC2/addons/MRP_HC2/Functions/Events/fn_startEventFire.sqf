/*
    File: fn_startEventFire.sqf
    Author: NiiRoZz
    Desc: Event automatique d'incendie de batiments
    hc_2 - Events
*/
private _co = nearestObjects [[8000,8000,0], ["Land_Caserne_MRP"], 20000];
private _h = nearestObjects [[8000,8000,0], ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_ALF_Caravane"],20000];
private _s = nearestObjects [[8000,8000,0], ["Land_ALF_station"],20000];

ALF_HC_Fire = [];
publicVariable "ALF_HC_Fire";

for "_i" from 0 to 1 step 0 do {
    private _c = {_x getVariable ["MedService",false]} count playableUnits;
    if(_c >= 6 && ALF_fireON) then {
        private _r = selectRandom [1,2,3,4,5,6,7,8,9];
//        if(_r isEqualTo 2 OR {_r isEqualTo 4} OR {_r isEqualTo 8}) then {
//            if (_h isEqualTo []) exitWith {};
//            private _hs = selectRandom _h;
 //           if (isNil "_hs" || {isNull _hs}) exitWith {};
 //           switch (typeOf _hs) do {
 //               case "Land_i_House_Big_01_V1_F" : {
  //                  [_hs modelToWorld [-2,2,0.85]] spawn MRP_HC2_fnc_createFire;
  //                  [_hs modelToWorld [-4.5,-2.9,0.88]] spawn MRP_HC2_fnc_createFire;
  //                  [_hs modelToWorld [0,-5.5,-2.6]] spawn MRP_HC2_fnc_createFire;
  //                  [_hs modelToWorld [2.6,4.8,-2.6]] spawn MRP_HC2_fnc_createFire;
  //              };
   //             case "Land_i_House_Big_01_V2_F" : {
   //                 [_hs modelToWorld [-2,2,0.85]] spawn MRP_HC2_fnc_createFire;
   //                 [_hs modelToWorld [-4.5,-2.9,0.88]] spawn MRP_HC2_fnc_createFire;
   //                 [_hs modelToWorld [0,-5.5,-2.6]] spawn MRP_HC2_fnc_createFire;
   //                 [_hs modelToWorld [2.6,4.8,-2.6]] spawn MRP_HC2_fnc_createFire;
   //             };
    //            case "Land_i_House_Big_01_V3_F" : {
    //                [_hs modelToWorld [-2,2,0.85]] spawn MRP_HC2_fnc_createFire;
    //                [_hs modelToWorld [-4.5,-2.9,0.88]] spawn MRP_HC2_fnc_createFire;
     //               [_hs modelToWorld [0,-5.5,-2.6]] spawn MRP_HC2_fnc_createFire;
     //               [_hs modelToWorld [2.6,4.8,-2.6]] spawn MRP_HC2_fnc_createFire;
    //            };
    //            case "Land_ALF_Caravane" : {
     //               [_hs modelToWorld [0,0,0]] spawn MRP_HC2_fnc_createFire;
    //            };
     //           default {
     //               [_hs modelToWorld [0,0,0]] spawn MRP_HC2_fnc_createFire;
     //           };
            //};

 //           ALF_HC_Fire pushBack _hs;
   //         publicVariable "ALF_HC_Fire";

   //         ["INCENDIE","ALERTE INCENDIE !! DEPART D'INCENDIE DANS UNE HABITATION !!"] remoteExec ["ALF_fnc_doMedCall",(playableUnits select {_x getVariable ["MedService",false]})];
   //         [_co] spawn {
   //             private _com = _this select 0;
    //            private _timer = 0;
    //            for "_i" from 0 to 1 step 0 do {
     //               if(_timer > 2) exitWith {};
     //               _timer = _timer + 1;
     //               {
      //                  playSound3D ["ALF_Client2\sounds\pompier_alarm.ogg", _x, false, _x modelToWorld [0,0,0], 1, 1, 150];
      //              } forEach _com;
       //             uiSleep 27;
      //          };
      //      };
  //    };
        if(_r isEqualTo 7 OR {_r isEqualTo 9}) then {
            if (_s isEqualTo []) exitWith {};
            private _ss = selectRandom _s;
            if (isNil "_ss" || {isNull _ss}) exitWith {};

            ALF_HC_Fire pushBack _ss;
            publicVariable "ALF_HC_Fire";

            ["INCENDIE","ATTENTION, L'ALARME INCENDIE DE LA STATION VIENT DE S'ALLUMER !! ELOIGNE TOI VITE !!","warning"] remoteExec ["ALF_fnc_doMsg",(playableUnits select {_x distance _ss < 50})];

            playSound3D ["ALF_Client2\sounds\station_alarm.ogg", _ss, false, _ss modelToWorld [0,0,0], 1, 1, 150];
            uiSleep 30;

            [_ss modelToWorld [-12,7,-1.5]] spawn MRP_HC2_fnc_createFire;
            [_ss modelToWorld [-4,10,-1.5]] spawn MRP_HC2_fnc_createFire;
            [_ss modelToWorld [-5,7,-1.5]] spawn MRP_HC2_fnc_createFire;
            [_ss modelToWorld [3,7,-1.73]] spawn MRP_HC2_fnc_createFire;
            [_ss modelToWorld [1,-4,-1.73]] spawn MRP_HC2_fnc_createFire;
            [_ss modelToWorld [1,-6,-1.73]] spawn MRP_HC2_fnc_createFire;
            [_ss modelToWorld [-3,-6,-1.73]] spawn MRP_HC2_fnc_createFire;

            ["INCENDIE","SITUATION D'URGENCE !! DEPART D'INCENDIE DANS UNE STATION SERVICE !!"] remoteExec ["ALF_fnc_doMedCall",(playableUnits select {_x getVariable ["MedService",false]})];

            [_co] spawn {
                private _com = _this select 0;
                private _timer = 0;
                for "_i" from 0 to 1 step 0 do {
                    if(_timer > 2) exitWith {};
                    _timer = _timer + 1;
                    {
                        playSound3D ["ALF_Client2\sounds\pompier_alarm.ogg", _x, false, _x modelToWorld [0,0,0], 1, 1, 150];
                    } forEach _com;
                    uiSleep 27;
                };
            };
        };
    };
    uiSleep (30 * 60);
};
